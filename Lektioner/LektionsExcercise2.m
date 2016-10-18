clear all
close all
clc

%given
g = 9.82;
Omega = 8500*2*pi/60;
R = 60*10^(-3);
b = 60*10^(-3);
deltaR = 82*10^(-6);
rotorMass = 1400;
eta = 24*10^(-3);

%from given
Psi = deltaR/R;
U=Omega*R;
P = rotorMass*g;
P_0 = (P*Psi^2)/(b*eta*U);

%Values?!?!
Epsilon = 0.4;
C = 5/13.1;

Cxx = -5 + 22.6*C;
Cyy = -5 + 32.3*C;
Cxy = -5 + C*7.5;
Cyx = -5 + C*7.5;

Kxx = 1.94;
Kyy = 2.13;
Kxy = 1.23; 
Kyx = -3.87;

Gamma = (Cyy*Kxx + Cxx*Kyy - Cyx*Kxy - Cxy*Kyx)/(Cxx + Cyy);
fSquared = ((Kxx*Kyy - Kxy*Kyx) - Gamma*(Kxx + Kyy) + Gamma^2)/(Cxx*Cyy - Cyx*Cxy);

OMEGA_c = sqrt(g/deltaR)*sqrt(Gamma/fSquared);

% Förslag Öka lasten!
% Minska deltaR!