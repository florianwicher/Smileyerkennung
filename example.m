I = imread('Datensatz/IMG_20181117_155415.jpg');
I2 = imread('Datensatz/IMG_20181117_155415.jpg');
imshow(CannyFilter(imbinarize(rgb2gray(I)),0.1));

[x0,y0,a,b,alpha] = FindBestEllipse(I);

figure;
image(I);
ellipse_draw(a,b,alpha*pi/180,x0,y0,'r');


[T, inverse] = ellipseToCircleT(a,b);
img = imgTransform(I, T);
figure;
imshow(img);

img = imgTransform(img, inverse);

img2 = EyeDetection(img, 800, 1100, 500);
imshow(img2);