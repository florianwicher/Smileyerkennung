I = imread('Datensatz/IMG_20181117_155407.jpg');
imshow(CannyFilter(imbinarize(rgb2gray(I)),0.1));

[x0,y0,a,b,alpha] = FindBestEllipse(I);

figure;
image(I);

ellipse_draw(a,b,alpha*pi/180,x0,y0,'r');


[T, inverse] = ellipseToCircleT(a,b);
img = imgTransform(I, T);
figure;
imshow(img);

figure;
imshow(imgTransform(img, inverse));
