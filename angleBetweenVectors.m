function [theta] = angleBetweenVectors(v0, v1)

theta = acos(dot(v0,v1)/(norm(v0) * norm(v1)));

crossP = v0(1) * v1(2) - v1(1) * v0(2);
if crossP < 0
  theta = -theta;
end

%!assert (angleBetweenVectors ([1,1], [1,1]), 0.0, 10^-5)
%!assert (angleBetweenVectors ([1,0], [1,1]), 0.78540, 10^-5)
%!test 
%! a = [1,1];
%! assert (angleBetweenVectors (a, [1,0]), -0.78540, 10^-5)