function [phi, Q] = computePhiAndQ(x, prm)

r = x.r;
psi = x.psi;
v = x.v;

F = [0, v * sin(psi) -cos(psi); ...
  -v * sin(psi) / (r^2), v / r * cos(psi), sin(psi) / r; ...
     0, 0, 0];
     
W = 1;

G = [prm.rProcN; prm.psiProcN; prm.vProcN];

A(1:3,1:3) = F;
A(1:3,4:6) = G * W * G';
A(4:6,1:3) = zeros(3);
A(4:6,4:6) = F';

B = expm(A);

phiT = B(4:6,4:6);
phi = phiT';

Q = phi * B(1:3,4:6);