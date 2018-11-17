I = imread('Testbild.jpg');

[x0,y0,a,b,alpha] = FindBestEllipse(I);

figure;
image(I);

ellipse_draw(a,b,alpha*pi/180,x0,y0,'r');