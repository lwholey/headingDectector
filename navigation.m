function [navOut] = navigation(navIn, navFirstCall)

if navFirstCall
  navOut.state.x.r = navIn.state.x.r;
  navOut.state.x.psi = navIn.state.x.psi;
  navOut.state.x.v = navIn.state.x.v;
  navOut.state.P = navIn.state.P;
else
  % project ahead
  x = [navIn.state.x.r; navIn.state.x.psi; navIn.state.x.v];
  P = navIn.state.P;
  [phi, Q] = computePhiAndQ(navIn.state.x, navIn.prm);
  x = phi * x;
  P = phi * P * phi' + Q;
  
  % Compute Kalman gain
  R = navIn.prm.R;
  H = [1 0 0];
  K = P * H' * (H * P * H' + R)^-1;
  
  % Update estimate with measurement
  x = x + K * (navIn.z - H * x);
  
  % Compute error covariance for updated estimate
  P = (eye(3) - K * H) * P;

  navOut.state.x.r = x(1);
  navOut.state.x.psi = x(2);
  navOut.state.x.v = x(3);
  navOut.state.P = P;
end

navOut.prm = navIn.prm;
