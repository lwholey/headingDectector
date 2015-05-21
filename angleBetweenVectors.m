function [theta] = angleBetweenVectors(v0, v1)

theta = acos(dot(v0,v1)/(norm(v0) * norm(v1)));

crossP = v0(1) * v1(2) - v1(1) * v0(2);
if crossP < 0
  theta = -theta;
end
