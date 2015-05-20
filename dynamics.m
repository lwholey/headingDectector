function [dynOut] = dynamics(dynIn)

  a = dynIn.prm.stepLength;
  b = dynIn.state.r;
  C = dynIn.state.psi + dynIn.cmd.deltaPsi;

  % law of cosines
  c = sqrt( a^2 + b^2 - 2 * a * b * cos(C) );
  
  % law of sines
  B = lawOfSines(a, b, c, C);
  
  dynOut.state.r = c;
  dynOut.state.psi = pi - B;
  dynOut.state.stepLength = dynIn.prm.stepLength;
  dynOut.state.rho = dynIn.cmd.deltaPsi;

