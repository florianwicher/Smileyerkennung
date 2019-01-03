I = imread('Datensatz/IMG_20181117_155202.jpg');
imshow(CannyFilter(imbinarize(rgb2gray(I)),0.1));

[x0,y0,a,b,alpha] = FindBestEllipse(I);

figure;
image(I);
ellipse_draw(a,b,alpha*pi/180,x0,y0,'r');

% show original image with axes
% figure('Name','original (axes)');
% imshow(drawAxes(I, x0, y0, a, b));

% compute T and transform the image
T = ellipseToCircleT(a,b);
img_corrected = imgTransform(I, T);

% center
center = [x0, y0, 0];
centerNew = center * T;

% show corrected image with axes
% figure('Name','corrected (axes)');
% imshow(drawAxes(img_corrected, centerNew(1), centerNew(2), a));

img2 = EyeDetection(img_corrected, centerNew(1), centerNew(2), a);

figure();
img2 = imgTransform(img_corrected, inv(T));
imshow(img2);
