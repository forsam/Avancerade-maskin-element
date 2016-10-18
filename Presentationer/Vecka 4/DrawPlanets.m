function [ vector ] = DrawPlanets( center, diameter, numberOfPlanets )

    R =@(angle) [cos(angle),-sin(angle); sin(angle),cos(angle)];
    radius = diameter/2;
    
    for planet = 1:numberOfPlanets  
        theta(planet) = 2*pi*planet/numberOfPlanets; % rotating angle
    end
    

    

    vector = zeros(numberOfPlanets*100,2);
    omega = linspace(0,2*pi,100);
    
    for planet = 1:numberOfPlanets
        start = 1 + (planet-1)*100;
        stop = planet*100;
        planetCenter = R(theta(planet))*center';
        vector(start:stop,1) = planetCenter(1) + radius.*cos(omega);
        vector(start:stop,2) = planetCenter(2) + radius.*sin(omega);
    end

end

