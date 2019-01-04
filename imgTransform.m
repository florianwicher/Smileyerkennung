function B=imgTransform(A, T)

s = [size(A,2), size(A,1), 1] * T;

B = zeros(round(s(2)), round(s(1)), 3,'uint8');

invT = inv(T);
Y = round( [1:size(B,1)] .* invT(2,1) + [1:size(B,1)] .* invT(2,2) + [1:size(B,1)] .* invT(2,3) ); 
X = round( [1:size(B,2)] .* invT(1,1) + [1:size(B,2)] .* invT(1,2) + [1:size(B,2)] .* invT(1,3) ); 
       
y = 1:size(B,1);
x = 1:size(B,2);

B(y, x, 1) = A(Y(y), X(x), 1);
B(y, x, 2) = A(Y(y), X(x), 2);
B(y, x, 3) = A(Y(y), X(x), 3);