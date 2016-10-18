RpmToOmega = pi/30;

RPM = 2200;
Torque = 10;
% init values!!

EE.Omega(1) = 0.1;
meanSpeed(1) = EE.Omega(1)*given.wheelRadius;

ICE.Omega = RPM*RpmToOmega;
ICE.Power(1) = PowerIce(meanSpeed(1), ICE.Omega.*Torque, 0, 0);
ICE.Torque(1) = ICE.Power(1)/ICE.Omega;
ICE.Energy(1) = 0;


GEN.Omega = ICE.Omega;
GEN.Torque(1) = electricEffiency(ICE.Torque(1))*ICE.Torque(1);
GEN.Power(1) = electricEffiency(ICE.Torque(1))*ICE.Power(1);
GEN.Energy(1) = 0;

firstEETorque = bearing.torque + 0.5*airResistance.Cd*airResistance.As*EE.Omega(1)^2*given.wheelRadius^3;

EE.Power(1) = electricEffiency(firstEETorque)*GEN.Power(1)
EE.Torque(1) = firstEETorque;
EE.Energy(1) = 0;

a(1) = (EE.Torque(1) - bearing.torque - 0.5*airResistance.Cd*airResistance.As*EE.Omega(1)^2*given.wheelRadius^3)/(given.wheelRadius*given.carMass); 

v(1) = EE.Omega(1)*given.wheelRadius;
s(1) = 0;

time = 1; %[inkrement]
dt = 0.01; %[s]

while s(time) < given.distance
    
    time = time + 1;
    
    EE.Omega(time) = EE.Omega(time-1) + a(time-1)*dt/given.wheelRadius;
    v(time) = EE.Omega(time)*given.wheelRadius;
    s(time) = s(time-1) + v(time)*dt;

    meanSpeed(time) = sum(v)./((time-1));
    
    ICE.Power(time) = PowerIce(meanSpeed(time), ICE.Omega.*Torque, (time-1)*dt, v(time));
    ICE.Torque(time) = ICE.Power(time)/ICE.Omega;
    ICE.Energy(time) = ICE.Energy(time - 1) + ICE.Power(time)*dt;
    
    GEN.Torque(time) = ICE.Torque(time);
    GEN.Power(time) = electricEffiency(GEN.Torque(time))*ICE.Power(time);
    GEN.Energy(time) = GEN.Energy(time - 1) + GEN.Power(time)*dt;
    
    EE.Power(time) = electricEffiency(EE.Torque(time-1))*GEN.Power(time);
    EE.Torque(time) = EE.Power(time-1)/EE.Omega(time-1);
    EE.Energy(time) = EE.Energy(time - 1) + EE.Power(time)*dt;

    a(time) = (EE.Torque(time) - bearing.torque - 0.5*airResistance.Cd*airResistance.As*EE.Omega(time)^2*given.wheelRadius^3)/(given.wheelRadius*given.carMass);
end
