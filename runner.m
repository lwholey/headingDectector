clear all;
close all;
clc;

deg = pi / 180;

% stop criteria
rStop = 5;
cntStop = 1000;

% dynamics init
dynIn.prm.r0 = 50;
dynIn.prm.psi0 = 90 * deg;
dynIn.prm.stepLength = 1;
dynIn.state.firstCall = 1;
dynIn.state.r = dynIn.prm.r0;
dynIn.state.psi = dynIn.prm.psi0;
conOut.cmd.deltaPsi = 0;

cnt = 0;
rH = [];
psiH = [];
while (1)
% dynamics model
dynIn.cmd.deltaPsi = conOut.cmd.deltaPsi;
dynOut = dynamics(dynIn);
dynIn.state.firstCall = dynOut.state.firstCall;
dynIn.state.r = dynOut.state.r;
dynIn.state.psi = dynOut.state.psi;
rH = [rH; dynIn.state.r];
psiH = [psiH; dynIn.state.psi];

% sensor model
senIn.state.r = dynOut.state.r;
senIn.state.psi = dynOut.state.psi;
senOut = sensor(senIn);


%navOut = navigation(navIn);
%conOut = control(conIn);
% limit control authority
conOut.cmd.deltaPsi = (-dynOut.state.psi * 1.0);

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
