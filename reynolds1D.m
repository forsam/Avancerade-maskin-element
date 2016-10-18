%
%	Solves Reynolds equation under the following conditions:
%   - Isoviscous, Newtonian lubricant
%   - Infinitely wide bearing
%   - No cavitation algorithm (negative pressure may occur)
%   - In dimensional form (SI-units)
%   - Cartesian coordinates
%
%   Roland Larsson, LTU 2016-08-29
%   
%   Input data
%
R   =0.05;  % Bearing radius, m
L   =2*pi*R;% Bearing length, m
b   =L/2;   % Bearing width, m
eta =0.01;  % Viscosity, Pas
u   =1;     % sliding velocity, m/s
epsilon = 0.8;  % godtyckligt
%
%   Grid data
%
nx=200;     % Number of grid spacings (number of grid points = nx+1)
dx=L/nx;    % Grid size
clear x     
x=0:dx:L;   % Defines the position of grid points on x-axis
%
%   Define film thickness (3 alternative shapes)
%
teta=15e-5;  % Tilt angle (radians) for simple pad bearing
hmin=1e-5;  % Minimum value of film thickness
%   Single wedge
h = hmin.*(1-epsilon*cos(x./L*2*pi + pi));
%
%   Numerical solution of Reynolds equation by using the finite difference
%   method
%
%   Boundary conditions for pressure
%
p = zeros(nx+1,1);  % Set up the array with pressures
pinlet = 1e6;       % Boundary condition at the inlet end of the bearing
poutlet = 0;        % Boundary condition at the outlet end of the bearing
p(1)=pinlet;        % The inlet is in the first grid point, no. 1
p(nx+1)=poutlet;    % The outlet is in the last grid point, no. nx+1
%
%
%
%   Calculate the flow q
C1 = (poutlet - pinlet)*(hmin^3)/(12*eta*L);
q = -C1;
%   Define coefficient matrix A (tri-diagonal) based on Reynolds L.H.S.
%
ae=(h(3:nx+1).^3+h(2:nx).^3)/2/dx/dx;
aw=(h(1:nx-1).^3+h(2:nx).^3)/2/dx/dx;
ap=-ae-aw;
%
m=nx-1;
Ap=sparse(1:m,1:m,ap,m,m,m);
Aw=sparse(2:m   ,1:m-1 ,aw(2:m)   ,m,m,m-1);
Ae=sparse(1:m-1 ,2:m,   ae(1:m-1),m,m,m-1);
A=Ap+Aw+Ae;
%
%   Define R.H.S. vector based on the Couette term of Reynolds
%
rhs = 6*eta*u*(h(2:nx)-h(1:nx-1))/dx;   % Upwind discretisation
%   Compensate for pressure B.C.
rhs(1)=rhs(1)-aw(1)*pinlet;
rhs(m)=rhs(m)-ae(m)*poutlet;
%
%   Solve the system of equations
%
p(2:nx) = A\rhs';% Solves the equation of systems for the interior grid points
%
p=p.*(p>0);
%   Compute load carrying capacity (in N/m)
%
loadCapacity=sum(p)*dx
%
%	Plot
%
clf;
plot(x,p,'o')
xlabel('x [m]')
ylabel('Pressure [Pa]');






















































