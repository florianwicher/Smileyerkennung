function B=imgTransform(A, T)
% transformiert das übergebene Bild 'A' mit der Transformationsmatrix 'T'

s = [size(A,2), size(A,1), 1] * T;

s = round(s);

B = zeros(s(2), s(1), 3,'uint8');

invT = inv(T);
Y = round( [1:size(B,1)] .* invT(2,1) + [1:size(B,1)] .* invT(2,2) + [1:size(B,1)] .* invT(2,3) ); 
X = round( [1:size(B,2)] .* invT(1,1) + [1:size(B,2)] .* invT(1,2) + [1:size(B,2)] .* invT(1,3) ); 
       
Y(Y < 1) = 1;
Y(Y > size(A,1)) = size(A,1);

X(X < 1) = 1;
X(X > size(A,2)) = size(A,2);

y = 1:size(B,1);
x = 1:size(B,2);

B(y, x, 1) = A(Y(y), X(x), 1);
B(y, x, 2) = A(Y(y), X(x), 2);
B(y, x, 3) = A(Y(y), X(x), 3);