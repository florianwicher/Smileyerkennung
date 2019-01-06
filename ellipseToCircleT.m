% Mathias Schwengerer
function T = ellipseToCircleT(a, b)
% Berechnet eine Transformationsmatrix, die eine Ellipse mit den Parametern 
% a und b in einen Kreis mit Radius a überführt
T = [1 0 0 ; 0 a/b 0 ; 0 0 1];
