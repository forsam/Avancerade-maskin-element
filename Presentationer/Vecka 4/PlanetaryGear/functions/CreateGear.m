function planetaryGear = CreateGear( outerDia, sunDia, planetNumber, center, d)
% This function is used to create a gear object!!

    
% Angle between planet gears!
    angle = 2*pi/planetNumber;
    
% Initial omega on the gear
    initialOmega = 0;
    
% initialize outerGear
    planetaryGear.outerGear.diameter = outerDia;
    planetaryGear.outerGear.omega = initialOmega;
    planetaryGear.outerGear.centerPos = center;
    planetaryGear.outerGear.teeth = planetaryGear.outerGear.diameter/d;
    planetaryGear.outerGear.body = drawRing(planetaryGear.outerGear.centerPos,planetaryGear.outerGear.diameter, planetaryGear.outerGear.teeth);
% initialize sun   
    planetaryGear.sun.diameter = sunDia;
    planetaryGear.sun.omega = initialOmega;
    planetaryGear.sun.centerPos = center;
    planetaryGear.sun.teeth = planetaryGear.sun.diameter/d;
    planetaryGear.sun.body = drawRing(planetaryGear.sun.centerPos,planetaryGear.sun.diameter, planetaryGear.sun.teeth);
    
% initialize planets
    planetaryGear.planet.diameter = (planetaryGear.outerGear.diameter - planetaryGear.sun.diameter)/2;
    planetaryGear.planet.omegaFunction =@(omega) omega*(1 + planetaryGear.sun.diameter/planetaryGear.planet.diameter);
    planetaryGear.planet.centerPos(1,:) = [center(1),center(2) +  planetaryGear.planet.diameter/2 + planetaryGear.sun.diameter/2];
    planetaryGear.planet.teeth = ceil(planetaryGear.planet.diameter/d);
    planetaryGear.planet.body(1,:,:) = drawRing(planetaryGear.planet.centerPos(1,:), planetaryGear.planet.diameter, planetaryGear.planet.teeth);
    
    for planet = 2:planetNumber
        planetaryGear.planet.centerPos(planet,:) = rotatePoint(planetaryGear.planet.centerPos(planet-1,:),angle,center);
        planetaryGear.planet.body(planet,:,:) = drawRing(planetaryGear.planet.centerPos(planet,:), planetaryGear.planet.diameter, planetaryGear.planet.teeth);
    end
    
    
% initialize the carrier    
    planetaryGear.carrier.diameter = planetaryGear.planet.diameter + planetaryGear.sun.diameter;
    planetaryGear.carrier.omegaFunction =@(omega) omega*planetaryGear.outerGear.diameter/(planetaryGear.outerGear.diameter + planetaryGear.sun.diameter);
    planetaryGear.carrier.centerPos = center;
    planetaryGear.carrier.teeth = planetaryGear.carrier.diameter/d;
    planetaryGear.carrier.body = drawRing(planetaryGear.carrier.centerPos,planetaryGear.carrier.diameter,planetaryGear.carrier.teeth);
    

end

