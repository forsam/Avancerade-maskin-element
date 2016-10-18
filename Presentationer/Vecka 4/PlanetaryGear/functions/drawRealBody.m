function gear  = drawRealBody( gear, planets, i)
size = 0.05;

subplot(1,2,i);
hold on
gear.outerGear.realBody = plot(gear.outerGear.body(:,1),gear.outerGear.body(:,2));
gear.outerGear.realBody = addTeeth(gear.outerGear.realBody, gear.outerGear.teeth, size);

gear.carrier.realBody = plot(gear.carrier.body(:,1),gear.carrier.body(:,2));

gear.sun.realBody = plot(gear.sun.body(:,1),gear.sun.body(:,2));
gear.sun.realBody = addTeeth(gear.sun.realBody, gear.sun.teeth, size);

for planet = 1:planets
   gear.planet.realBody(planet) = plot(gear.planet.body(planet,:,1),gear.planet.body(planet,:,2));
   gear.planet.realBody(planet) = addPlanetTeeth(gear.planet.realBody(planet), gear.planet.teeth, size,gear.planet.centerPos(planet,:));
end

end

