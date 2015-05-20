function [B] = lawOfSines(a, b, c, C)

epsV = 10^-6;

B0 = asin(b / c * sin(C));
if C > (pi / 2)
  B = B0;
  %display('0');
elseif C < epsV
  B = pi;
else
  B1 = pi - B0;
  A0 = asin(a / c * sin(C));
  A1 = pi - A0;
  if isTriangle(A0, B0, C) || isTriangle(A1, B0, C) 
    %display('1');
    B = B0;
  else
    %display('2');
    B = B1;
  end
end

