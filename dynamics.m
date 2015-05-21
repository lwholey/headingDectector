function [dynOut] = dynamics(dynIn)

  a = dynIn.prm.stepLength;
  b = dynIn.state.r;
  C = dynIn.state.psi + dynIn.cmd.deltaPsi;

  % law of cosines
  c = sqrt( a^2 + b^2 - 2 * a * b * cos(C) );

  dynOut.state.r = c;
  
  v0 = [sin(C), cos(C)];
  v1 = [-a*sin(C), b - a*cos(C)];
  
  dynOut.state.psi = angleBetweenVectors(v0, v1);

