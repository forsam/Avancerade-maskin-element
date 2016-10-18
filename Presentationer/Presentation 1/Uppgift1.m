% Uppgift 1
m = 145;
g = 9.82;
eta = 0.026; %Viskositet
P = (m*g)/2; %Last
r = 0.01; %Radie
b = r;
ny = 0.5; %b/d
n = 21000; %Varvtal väljer hösta varvtalet som går!
omega = (n*pi)/30; %Vinkelhastighet
deltaR = (2/1000)*r; %Spel
Psi = 2/1000; %Relativt spel
U = omega*r; %Glidhastighet 
P0 = P*Psi^2/(eta*U*b) %Dimensionslös last

%% P0 --> epsilon ur graf
epsilon = 0.45;
hmin = deltaR*(1-epsilon) %Minsta filmtjocklek (5-25e-6)

Kxx = 2.0;
Kxy = 1.0;
Kyx = -3.8;
Kyy = 2.5;

Cxx = 3;
Cxy = -2;
Cyx = -2;
Cyy = 7;

Gamma = (Cyy*Kxx + Cxx*Kyy - Cyx*Kxy - Cxy*Kyx)/(Cxx + Cyy);
fSquared = ((Kxx*Kyy - Kxy*Kyx) - Gamma*(Kxx + Kyy) + Gamma^2)/(Cxx*Cyy - Cyx*Cxy);

OMEGA_c = sqrt(g/deltaR)*sqrt(Gamma/fSquared);
n_c = OMEGA_c*(30/pi);