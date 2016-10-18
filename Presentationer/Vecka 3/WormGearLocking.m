clear
close all
clc

DegreeToRad = pi/180;
RadToDegree = 180/pi;

alpha.start = 15*DegreeToRad;
alpha.finish = 85*DegreeToRad;

gamma.start = 1*DegreeToRad;
gamma.finish = 10*DegreeToRad;

Alpha = linspace(alpha.start,alpha.finish,110)';
Gamma = linspace(gamma.start,gamma.finish,5);

My = cos(Alpha)*tan(Gamma);
%Make a plot for alpha

figure
hold on
xlabel('alpha in degrees')
ylabel('my')
plot(Alpha*RadToDegree,My)
hold off


%Make everything again for gamma!
Alpha = linspace(alpha.start,alpha.finish,5)';
Gamma = linspace(gamma.start,gamma.finish,110);

My = cos(Alpha)*tan(Gamma);

figure
hold on
xlabel('gamma in degrees')
ylabel('my')
plot(Gamma*RadToDegree,My)
hold off

%Make everything again for gamma!
Alpha = linspace(alpha.start,alpha.finish,90)';
Gamma = linspace(gamma.start,gamma.finish,110);

My = cos(Alpha)*tan(Gamma);

figure
mesh(RadToDegree*Gamma,RadToDegree*Alpha,My)