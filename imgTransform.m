function B=imgTransform(A, T)
% Transformiert das Bild A mit der Transformationsmatrix T
B = imwarp(A, affine2d(T));
