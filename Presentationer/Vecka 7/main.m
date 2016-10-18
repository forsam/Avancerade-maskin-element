%
clear all
close all
clc

addpath('functions/wetClutch');

RpmToOmega = pi./30;

g = 9.82;

Engine.omega = 3000.*RpmToOmega;
Engine.maxTorque = 260;

Sauna.mass = 2000;

Car.omega(1) = 0;
Car.wheelR = 0.3;
Car.mass = 1550;
Car.utv.ettan = 4.03;
Car.utv.diff = 3.54;
Car.torqueBefore(1) = 0;
Car.torque(1) = 0;

% wetClutch testing!
t = 1;
s(1) = 0;
distanceBool = 1;
dt = 0.01;
while distanceBool
    
    speedRatio(t) = Car.omega(t)/Engine.omega;
    
    Car.torqueBefore(t) = P(t*dt)*momentIntegralen(Engine.omega, Car.omega(t));
    
    omegaDiff(t) = Engine.omega - Car.omega(t);
    
    if Car.torqueBefore(t) > Engine.maxTorque
        Car.torqueBefore(t) = Engine.maxTorque;
    end
    
    Car.torque(t) = Car.torqueBefore(t)*Car.utv.ettan*Car.utv.diff;
    
    acc(t) = (Car.torque(t)/Car.wheelR - sind(20)*g*(Car.mass + Sauna.mass))/(Car.mass + Sauna.mass);
    
    if t == 1
        v(t) = acc(t)*dt;
    else
        v(t) = v(t-1) + acc(t)*dt; 
    end
    
    if t == 1
        s(t) = v(t)*dt;
    else
        s(t) = s(t-1) + v(t)*dt; 
    end
    
    if t*dt > 100
        distanceBool = 0;
    end
    
    Car.omega(t+1) = (v(t)/Car.wheelR)*Car.utv.ettan*Car.utv.diff;
    
    t = t + 1;
    
    
end

t = 1;
converter.s(1) = 0;
distanceBool = 1;
dt = 0.01;
converter.engine.RPM = 2150;
converter.engine.torque = 190;
converter.Car.driveshaft.RPM(1) = 0;
while distanceBool
    
    converter.speedRatio(t) = converter.Car.driveshaft.RPM(t)/converter.engine.RPM;
    converter.Car.torqueBefore(t) = converter.engine.torque*torqueMultiple(converter.speedRatio(t));
    
    converter.Car.torque(t) = converter.Car.torqueBefore(t)*Car.utv.ettan*Car.utv.diff;
    
    converter.acc(t) = (converter.Car.torque(t)/Car.wheelR - sind(20)*g*(Car.mass + Sauna.mass))/(Car.mass + Sauna.mass);
    
    if t == 1
        converter.v(t) = converter.acc(t)*dt;
    else
        converter.v(t) = converter.v(t-1) + converter.acc(t)*dt; 
    end
    
    if t == 1
        converter.s(t) = converter.v(t)*dt;
    else
        converter.s(t) = converter.s(t-1) + converter.v(t)*dt; 
    end
    
    if t*dt > 100
        distanceBool = 0;
    end
    
    converter.Car.driveshaft.RPM(t+1) = (converter.v(t)/Car.wheelR)*Car.utv.ettan*Car.utv.diff/RpmToOmega;
    
    t = t + 1;
    
    
end

% plottning!!
figure(1)
hold on
title('Distance plot')
xlabel('time in seconds')
ylabel('distance in meters')
plot((1:t-1)*dt, converter.s)
plot((1:t-1)*dt, s)
legend('CONVERTER','WET CLUTCH')
hold off

figure(2)
hold on
title('Velocity plot')
xlabel('time in seconds')
ylabel('Velocity in m/s')
plot((1:t-1)*dt, converter.v)
plot((1:t-1)*dt, v)
legend('CONVERTER','WET CLUTCH')
hold off

figure(3)
hold on
title('Acceleration plot')
xlabel('time in seconds')
ylabel('acceleration in m/s^2')
plot((1:t-1)*dt, converter.acc)
plot((1:t-1)*dt, acc)
legend('CONVERTER','WET CLUTCH')
hold off

figure(4)
hold on
title('Torque plot')
xlabel('time in seconds')
ylabel('Torque in Nm')
plot((1:t-1)*dt, converter.Car.torqueBefore)
plot((1:t-1)*dt, Car.torqueBefore)
legend('CONVERTER','WET CLUTCH')
hold off

figure(5)
hold on
title('speed ratio plot')
xlabel('time in seconds')
ylabel('speed ratio')
plot((1:t-1)*dt, converter.speedRatio)
plot((1:t-1)*dt, speedRatio)
legend('CONVERTER','WET CLUTCH')
hold off