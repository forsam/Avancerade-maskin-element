clear
close all
clc

theta = linspace(0,2*pi,1000);

%initialize R
rx = sin(theta);
ry = cos(theta);
R = [rx ;ry];

%initialize T
tx = -theta.*cos(theta);
ty = theta.*sin(theta);
T = [tx ;ty];

%Calculate P!
P = R + T;

%plot T
figure
hold on
plot(P(1,:),P(2,:))

for i = 1:length(P)
    xR = [R(1,i) ,P(1,i)];
    yR = [R(2,i) ,P(2,i)];
    hold on
    plot(xR ,yR);
    pause(0.01);
end
