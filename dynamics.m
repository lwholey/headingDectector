function [dynOut] = dynamics(dynIn)

  a = dynIn.state.v * dynIn.prm.dt;
  b = dynIn.state.r;
  C = dynIn.state.psi + dynIn.cmd.deltaPsi;

  % law of cosines
  c = sqrt( a^2 + b^2 - 2 * a * b * cos(C) );

  dynOut.state.r = c;
  
  v0 = [sin(C), cos(C)];
  v1 = [-a*sin(C), b - a*cos(C)];
  
  dynOut.state.psi = angleBetweenVectors(v0, v1);
  dynOut.state.v = dynIn.state.v;

%!test 
%! in.prm.dt = 1; in.state.v = 1; in.state.r = 100; in.state.psi = 0; in.cmd.deltaPsi = 0;
%! out.state.r = 99; out.state.psi = 0; out.state.v = in.state.v = 1;
%! assert (dynamics(in), out, 10^-5)
%!test 
%! in.prm.dt = 1; in.state.v = 1; in.state.r = 100; in.state.psi = pi; in.cmd.deltaPsi = 0;
%! out.state.r = 101; out.state.psi = pi; out.state.v = in.state.v = 1;
%! assert (dynamics(in), out, 10^-5)
%!test 
%! in.prm.dt = 1; in.state.v = 1; in.state.r = 100; in.state.psi = pi/4; in.cmd.deltaPsi = 0;
%! out.state.r = 99.295410; out.state.psi = 0.79252; out.state.v = in.state.v = 1;
%! assert (dynamics(in), out, 10^-5)
%!test 
%! in.prm.dt = 1; in.state.v = 1; in.state.r = 100; in.state.psi = -pi/4; in.cmd.deltaPsi = 0;
%! out.state.r = 99.295410; out.state.psi = -0.79252; out.state.v = in.state.v = 1;
%! assert (dynamics(in), out, 10^-5)
%!test 
%! in.prm.dt = 141.421356237309; in.state.v = 1; in.state.r = 100; in.state.psi = pi/4; in.cmd.deltaPsi = 0;
%! out.state.r = 100.0; out.state.psi = 3 * pi / 4; out.state.v = in.state.v = 1;
%! assert (dynamics(in), out, 10^-5)