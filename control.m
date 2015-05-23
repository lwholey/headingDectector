function [conOut] = control(conIn)

  conOut.deltaPsi = 0; %-conIn.psi + conIn.prm.psiErr;