function [T, I] =ellipseToCircleT(a, b)
% Berechnet eine Transformationsmatrix, die eine Ellipse mit den Parametern 
% a und b in einen Kreis �berf�hrt
T = [1*b 0 0 ; 0 1*a 0 ; 0 0 1];
I = [1/b 0 0 ; 0 1/a 0 ; 0 0 1];
