function [xout] = statePropagate(xin, phi, dt)

% first model
% xout = phi * xin;

% second model
  r = xin(1);
  psi = xin(2);
  v = xin(3);

a = v * dt;
b = r;
C = psi;

% law of cosines
c = sqrt( a^2 + b^2 - 2 * a * b * cos(C) );

xout(1) = c;

v0 = [sin(C), cos(C)];
v1 = [-a*sin(C), b - a*cos(C)];

xout(2) = angleBetweenVectors(v0, v1);
xout(3) = v;
xout = xout';

%!test
%! x = [100; 0; 1];
%! prm.rProcN = 0; prm.psiProcN = 0; prm.vProcN = 0;
%! prm.dt = 1;
%! B = calcMatrixForPhiAndQ(x, prm);
%! phiT = B(4:6,4:6);
%! phi = phiT';
%! assert (statePropagate(x, phi, prm.dt), [99; 0; 1], 10^-5)

%!test
%! x = [100; pi; 1];
%! prm.rProcN = 0; prm.psiProcN = 0; prm.vProcN = 0;
%! prm.dt = 1;
%! B = calcMatrixForPhiAndQ(x, prm);
%! phiT = B(4:6,4:6);
%! phi = phiT';
%! % NEED TO RAISE TOLERANCE SIGNIFICANTLY TO PASS (FIRST MODEL IS NOT PERFECT)
%! assert (statePropagate(x, phi, prm.dt), [101; pi; 1], 10^-5)

%!test
%! x = [100; pi/2; 1];
%! prm.rProcN = 0; prm.psiProcN = 0; prm.vProcN = 0;
%! prm.dt = 1;
%! B = calcMatrixForPhiAndQ(x, prm);
%! phiT = B(4:6,4:6);
%! phi = phiT';
%! dynIn.prm.dt = prm.dt; dynIn.state.v = x(3); dynIn.state.r = x(1); dynIn.state.psi = x(2); 
%! dynIn.cmd.deltaPsi = 0;
%! dynOut = dynamics(dynIn);
%! dynVec = [dynOut.state.r; dynOut.state.psi; x(3)];
%! assert (statePropagate(x, phi, prm.dt), dynVec, 10^-5)
