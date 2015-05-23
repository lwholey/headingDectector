function [B] = calcMatrixForPhiAndQ(x, prm)

r = x(1);
psi = x(2);
v = x(3);

F = [0, v * sin(psi) -cos(psi); ...
  -v * sin(psi) / (r^2), v / r * cos(psi), sin(psi) / r; ...
     0, 0, 0];
     
W = 1;

G = [prm.rProcN; prm.psiProcN; prm.vProcN];

A(1:3,1:3) = -F * prm.dt;
A(1:3,4:6) = G * W * G';
A(4:6,1:3) = zeros(3);
A(4:6,4:6) = F' * prm.dt;

B = expm(A);
