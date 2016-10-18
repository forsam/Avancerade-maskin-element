clear all
close all
clc

M = 1;  %massa
K = 100; %Fjäderkonstant

rKolv = 0.1;
rHole = rKolv*10^(-1);
eta = 0.001;
L = 0.005;
A = rKolv^2*pi;

C = A*8*eta*rKolv^2*L/rHole^4;
