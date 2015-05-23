# headingDectector

This is a prototype to determine if the direction from one user (u0) to another user (u1) can be found with:

* range measurements
* knowledge of u0's change in position and direction

A simple Extended Kalman Filter is used with the following dynamics model:

* rDot   = -v * cos(psi)
* psiDot = v / r * sin(psi)
* vDot   = 0

where 

* r = distance (2D) between u0 and u1
* psi = angle between two vectors: 1. line of site vector between u0 and u1 and 2. direction that u0 is pointed

* v = speed of u0

Assumptions:

* u1 is stationary
* Perfect knowledge of u0 change in position and direction (through use of accels/gyros/camera data)
* u0 and u1 are always at the same altitude (2D motion)

# Installation

Code is written in GNU Octave.  Mac install is [here](http://wiki.octave.org/Octave_for_MacOS_X).  Installing with Homebrew worked well for me.

# Usage

Within Octave, run script 'runner.m'

# TODO

* Add controller so that user can change direction and point towards other user (driving range to 0).
* Add errors to 
  * range measurements 
  * u0 change in position
  * u0 change in direction
