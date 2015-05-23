function [psiDot] = testPsiDotModel(v, r, psi)

  psiDot = v / r * sin(psi);
  
%!test
%! v = 2; r = 100; psi = 0;
%! dynIn.state.v = v;
%! dynIn.prm.dt = 0.01;
%! dynIn.state.r = r;
%! dynIn.state.psi = psi;
%! dynIn.cmd.deltaPsi = 0;
%! [dynOut] = dynamics(dynIn);
%! psiDotEst = (dynOut.state.psi - dynIn.state.psi) / dynIn.prm.dt;
%! assert (testPsiDotModel(v, r, psi), psiDotEst, 10^-5)

%!test
%! v = 2; r = 100; psi = pi/2;
%! dynIn.state.v = v;
%! dynIn.prm.dt = 0.01;
%! dynIn.state.r = r;
%! dynIn.state.psi = psi;
%! dynIn.cmd.deltaPsi = 0;
%! [dynOut] = dynamics(dynIn);
%! psiDotEst = (dynOut.state.psi - dynIn.state.psi) / dynIn.prm.dt;
%! assert (testPsiDotModel(v, r, psi), psiDotEst, 10^-5)

%!test
%! v = 2; r = 100; psi = pi/4;
%! dynIn.state.v = v;
%! dynIn.prm.dt = 0.01;
%! dynIn.state.r = r;
%! dynIn.state.psi = psi;
%! dynIn.cmd.deltaPsi = 0;
%! [dynOut] = dynamics(dynIn);
%! psiDotEst = (dynOut.state.psi - dynIn.state.psi) / dynIn.prm.dt;
%! assert (testPsiDotModel(v, r, psi), psiDotEst, 10^-5)

%!test
%! v = 2; r = 100; psi = -pi/4;
%! dynIn.state.v = v;
%! dynIn.prm.dt = 0.01;
%! dynIn.state.r = r;
%! dynIn.state.psi = psi;
%! dynIn.cmd.deltaPsi = 0;
%! [dynOut] = dynamics(dynIn);
%! psiDotEst = (dynOut.state.psi - dynIn.state.psi) / dynIn.prm.dt;
%! assert (testPsiDotModel(v, r, psi), psiDotEst, 10^-5)