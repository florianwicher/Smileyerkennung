I = imread('Datensatz/IMG_20181117_155202.jpg');
imshow(CannyFilter(imbinarize(rgb2gray(I)),0.1));

[x0,y0,a,b,alpha] = FindBestEllipse(I);

figure;
image(I);
ellipse_draw(a,b,alpha*pi/180,x0,y0,'r');


[T, inverse] = ellipseToCircleT(a,b);
img = imgTransform(I, inverse);
figure;


imshow(img);
vec = (inverse*[x0;y0;0]);
img2 = EyeDetection(img, vec(1), vec(2), a);
img2 = imgTransform(img2, T);
imshow(img2);