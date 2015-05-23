function [navOut] = navigation(navIn, navFirstCall)

if navFirstCall
  navOut.state.x.r = navIn.state.x.r;
  navOut.state.x.psi = navIn.state.x.psi;
  navOut.state.x.v = navIn.state.x.v;
  navOut.state.P = navIn.state.P;
else  
  x = [navIn.state.x.r; navIn.state.x.psi; navIn.state.x.v];
  P = navIn.state.P;

  B = calcMatrixForPhiAndQ(navIn.state.x, navIn.prm);
  phiT = B(4:6,4:6);
  phi = phiT';
  Q = phi * B(1:3,4:6);
  
  x = statePropagate(x, phi);
  P = covPropagate(P, phi, Q);
  
  % Compute Kalman gain
  R = navIn.prm.R;
  H = [1 0 0];
  K = P * H' * (H * P * H' + R)^-1;
  
  % Update estimate with measurement
  residual = navIn.z - H * x;
  x = x + K * (residual);
  
  % Compute error covariance for updated estimate
  P = (eye(3) - K * H) * P;

  navOut.state.x.r = x(1);
  navOut.state.x.psi = x(2);
  navOut.state.x.v = x(3);
  navOut.state.P = P;
end

navOut.prm = navIn.prm;
