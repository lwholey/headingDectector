function [conOut] = control(conIn)

  conOut.deltaPsi = -conIn.psi + conIn.prm.psiErr;