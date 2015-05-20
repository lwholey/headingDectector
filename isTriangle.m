function [val] = isTriangle(A, B, C)

epsV = 10^-6;

tmp = abs((A + B + C) - pi);
if tmp > epsV
  val = false;
else
  val = true;
end
