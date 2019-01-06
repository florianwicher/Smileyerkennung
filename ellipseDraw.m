% Mathias Schwengerer
function img_ellipse = ellipseDraw(img, x0, y0, a, b)
% zeichnet eine Ellipse in 'img'

theta = 0 : 0.005 : 2*pi;
x = a * cos(theta) + x0;
y = b * sin(theta) + y0;
x = round(x);
y = round(y);
img_ellipse = img;

for i = 1:size(theta,2)
    img_ellipse( y(i)-1:y(i)+1 , x(i)-1:x(i)+1 ,1) = 255;
    img_ellipse( y(i)-1:y(i)+1 , x(i)-1:x(i)+1 ,2) = 0;
    img_ellipse( y(i)-1:y(i)+1 , x(i)-1:x(i)+1 ,3) = 0;
end