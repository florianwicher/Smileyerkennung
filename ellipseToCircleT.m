function T=ellipseToCircleT(a, b)
% Berechnet eine Transformationsmatrix, die eine Ellipse mit den Parametern 
% a und b in einen Kreis �berf�hrt
T = [1 0 0 ; 0 a/b 0 ; 0 0 1];
