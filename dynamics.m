function [dynOut] = dynamics(dynIn)

if dynIn.state.firstCall
  dynOut.state.r = dynIn.state.r;
  dynOut.state.psi = dynIn.state.psi;
else
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

end

dynOut.state.firstCall = 0;
