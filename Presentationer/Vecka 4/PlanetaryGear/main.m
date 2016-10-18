clear 
close all
clc
addpath('functions/');

% initiate PlanetaryGear
d = 0.01;
planets = 3;
sunDiameter = 21*d;
outerDiameter = 53*d;
center = [0,0];
startOmega = 200;
gears = 2;

% Pre do the first gear
    % Create the gear
        gear(1) = CreateGear(outerDiameter,sunDiameter,planets,center, d);
    % Make the gear drawable
        gear(1) = drawRealBody(gear(1), planets, 1);
    % Initiate velocities!    
        gear(1).outerGear.omega = startOmega;
        gear(1).carrier.omega = gear(1).carrier.omegaFunction(gear(1).outerGear.omega);
        gear(1).planet.omega = gear(1).planet.omegaFunction(gear(1).carrier.omega);

% Initiate the gears!
for i = 2:gears
    % Create the gear
        gear(i) = CreateGear(outerDiameter,sunDiameter,planets,center, d);
    % Make the gear drawable
        gear(i) = drawRealBody(gear(i), planets, i);
    % Initiate velocities!
        gear(i).outerGear.omega = gear(i-1).carrier.omega;
        gear(i).carrier.omega = gear(i).carrier.omegaFunction(gear(i).outerGear.omega);
        gear(i).planet.omega = gear(i).planet.omegaFunction(gear(i).carrier.omega);
end

% Calculate different powerStates in the gears!

% given
bearingLosses = 1; %[Nm]
P(1).start = 100*10^3; %[Watt]
eta = 0.98; % mellan varje kuggingrepp.
M(1).start = P(1).start/startOmega;
for i = 1:gears
    % Loss due to first bearing on shaft
    initialLoss = gear(i).outerGear.omega*bearingLosses;
    P(i).outerBearing = P(i).start - initialLoss;
    
% loss due to berings in planets and the teeth contact!
    % contactLoss
    P(i).planetContact = eta*P(i).outerBearing;
    % beringlosses
    planetBearingLoss = planets*gear(i).planet.omega*bearingLosses;
    P(i).planetBearing = P(i).planetContact - planetBearingLoss;

% losses due to Sungear!
    P(i).sunContact = P(i).planetBearing*eta;
% losses due to rotation last bearing!
    carrierBearingLoss = gear(i).carrier.omega*bearingLosses;
    P(i).end = P(i).sunContact - carrierBearingLoss;
% new start value
    P(i+1).start = P(i).end;
% Calculate the Moment
    M(i).end = P(i).end/gear(i).carrier.omega;
% Calculate the Next startMoment!
    M(i+1).start = M(i).end;
end

% Make a plot for the moments!!

for i = 1:(gears)
   Moment(i) = M(i).end; 
   Power(i) = P(i).end;
   
   subplot(1,2,i)
   hold on
   
   str = strcat('planetary gear nr: ', int2str(i));
   momentStr = strcat('Torque:  ', int2str(Moment(i)),' Nm');
   powerOut = strcat('Power:  ', int2str(Power(i)/1000),' kW');
   title({str, momentStr, powerOut})
   hold off
end

figure
hold on
xlabel('gearCount')
plot(1:(gears),Moment);
plot(1:(gears),Power/100);
legend('Moment [nM]','Energi [dW]')
hold off

% Make the planetary gears rotate!!
dt = 0.005;
k = 1;
while true
    
    for i = 1:length(gear)
    [gear(i).carrier.realBody.XData, gear(i).carrier.realBody.YData] = rotateBody(gear(i).carrier.realBody.XData, gear(i).carrier.realBody.YData,gear(i).carrier.omega*dt, gear(i).carrier.centerPos);
    [gear(i).outerGear.realBody.XData, gear(i).outerGear.realBody.YData] = rotateBody(gear(i).outerGear.realBody.XData, gear(i).outerGear.realBody.YData,gear(i).outerGear.omega*dt,gear(i).outerGear.centerPos);
    [gear(i).sun.realBody.XData, gear(i).sun.realBody.YData] = rotateBody(gear(i).sun.realBody.XData, gear(i).sun.realBody.YData,gear(i).sun.omega*dt,gear(i).sun.centerPos);
    for j = 1:planets
        
       [gear(i).planet.realBody(j).XData, gear(i).planet.realBody(j).YData, gear(i).planet.centerPos(j,:)] = rotatePlanetBody(gear(i).planet.realBody(j).XData, gear(i).planet.realBody(j).YData,gear(i).planet.omega*dt,gear(i).planet.centerPos(j,:),gear(i).carrier.omega*dt); 
    end
    
    end
    pause(dt)

end





