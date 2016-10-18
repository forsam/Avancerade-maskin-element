clear
close all
clc

Rotate =@(angle) [cos(angle),-sin(angle); sin(angle),cos(angle)];

cm = 0.01;

% diameters
outergear.diameter = 10*cm;
sun.diameter = 3*cm;
planet.diameter = (outergear.diameter - sun.diameter)/2;

% StartPostitions
outergear.startPosition = [0, 0];
sun.startPosition = [0, 0];
planet.startPosition = [0, sun.diameter/2 + planet.diameter/2];

% DrawFunctions
outergear.vector = DrawRing(outergear.startPosition, outergear.diameter);
sun.vector = DrawRing(sun.startPosition, sun.diameter);
planet.vector = DrawPlanets(planet.startPosition, planet.diameter, 3);

% Velocity
outergear.omega = pi/8;
sun.omega = 0;
planet.selfOmega = outergear.omega*(outergear.diameter/planet.diameter);
planet.omega = (outergear.omega*outergear.diameter/2 + sun.omega*sun.diameter/2)/sun.diameter;


% draw this crasy stuff!!
figure
hold on
plot(outergear.vector(:,1),outergear.vector(:,2))
plot(sun.vector(:,1),sun.vector(:,2))

planet.planetPlot(1) = plot(planet.vector(1:100,1),planet.vector(1:100,2),'+');
planet.planetPlot(2) = plot(planet.vector(101:200,1),planet.vector(101:200,2),'+');
planet.planetPlot(3) = plot(planet.vector(201:300,1),planet.vector(201:300,2),'+');

% Update this depending on omega!
dt = 0.1;
angle = planet.omega*dt;
angle2 = planet.selfOmega*dt;

for i = 1:10000
    planet.vector = planet.vector*Rotate(angle);
    for i = 1:length(planet.planetPlot)
        planet.planetPlot(i).XData = planet.vector((1 + (i-1)*100):i*100,1);
        planet.planetPlot(i).YData = planet.vector((1 + (i-1)*100):i*100,2);
        [planet.planetPlot(i).XData, planet.planetPlot(i).YData] = rotate([planet.planetPlot(i).XData; planet.planetPlot(i).YData],angle2,[1,1]);
    end
    pause(dt)
end
