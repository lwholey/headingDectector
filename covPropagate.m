function [Pout] = covPropagate(Pin, phi, Q)

Pout = phi * Pin * phi' + Q;