clear all;
close all;
clc;

deg = pi / 180;

% stop criteria
rStop = 5;
cntStop = 1000;

% navigation init
navIn.state.x.r = 100;
navIn.state.x.psi = 90 * deg;
navIn.state.x.v = 1;
navIn.state.P = [10^2 0 0; 0 (90 * deg)^2 0; 0 0 (0.01)^2];
navIn.prm.dt = 1;
navIn.prm.R = 1^2;
navIn.prm.rProcN = 0.01;
navIn.prm.psiProcN = 0.001;
navIn.prm.vProcN = 1.0;
navFirstCall = 1;

% dynamics init
dynIn.prm.stepLength = 1;
dynIn.state.r = 50;
dynIn.state.psi = 0 * deg;

% control init
conIn.prm.psiErr = 0 * deg;

cnt = 0;
rH = [];
psiH = [];
rErrH = [];
psiErrH = [];
while (1)

  % navigation model
  if ~navFirstCall
    navIn = navOut;
    % overwrite psi estimate with command from control
    navIn.state.x.psi = navOut.state.x.psi + conOut.deltaPsi;
    navIn.z = senOut.state.r;
  end
  navOut = navigation(navIn, navFirstCall);
  navFirstCall = 0;

  % control model
  conIn.psi = navOut.state.x.psi;
  conOut = control(conIn);

  % dynamics model
  rErrH = [rErrH; navOut.state.x.r - dynIn.state.r];
  psiErrH = [psiErrH; navOut.state.x.psi - dynIn.state.psi];
  
  dynIn.cmd.deltaPsi = conOut.deltaPsi;
  dynOut = dynamics(dynIn);
  dynIn.state.r = dynOut.state.r;
  dynIn.state.psi = dynOut.state.psi;
  rH = [rH; dynIn.state.r];
  psiH = [psiH; dynIn.state.psi];

  % sensor model
  senIn.state.r = dynOut.state.r;
  senOut = sensor(senIn);

  cnt = cnt + 1;
  if dynOut.state.r < rStop 
    display('within range, range = ');
    dynOut.state.r
    break;
  elseif cnt > cntStop
    display('cntStop exceeded, range = ');
    dynOut.state.r
    break;
  end
end

figure; plot(rErrH)
ylabel('range error');
figure; plot(psiErrH/deg);
ylabel('psi error (deg)')
