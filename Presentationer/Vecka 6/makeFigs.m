kWhToJoule = 3600000;


figure(1)
hold on
plot(s,meanSpeed*3.6)
plot(s,v*3.6)
title('Speed graph')
xlabel('distance travelled in meters :)')
ylabel('speed km per hour')
legend('meanspeed','speed')
hold off

figure(2)
hold on
[X, Y] = meshgrid(linspace(500,3000),linspace(1,12));
Z = data.BSFC.function(X,Y);
mesh(X,Y,Z)
title('BSFC')
xlabel('RPM')
ylabel('Torque Nm')
zlabel('Fuelneed g/kWh')
hold off

figure(3)
hold on
title('Torque')
xlabel('distance travelled in meters')
ylabel('Torque in Nm')
plot(s,EE.Torque)
plot(s,GEN.Torque)
plot(s,ICE.Torque)
legend('Electric engine','Generator','Combustion Engine')
hold off

figure(4)
hold on
title('energy consumption')
ICE.Consumption = (ICE.Energy.*data.BSFC.function(RPM,Torque))./kWhToJoule;
plot(s,ICE.Consumption)
xlabel('distance travelled in meters')
ylabel('Fuelconsumption g')
hold off