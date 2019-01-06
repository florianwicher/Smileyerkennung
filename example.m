close all
startingFolder = 'dir';
% Get the name of the file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.jpg');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
if baseFileName == 0
  % User clicked the Cancel button.
  return;
end
fullFileName = fullfile(folder, baseFileName);
I = imread(fullFileName);
%I = imread('Datensatz/IMG_4069.jpg');


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

img2 = FloodFill(img_corrected, round(centerNew(1)), round(centerNew(2)), 0.7);

[img2,worked] = EyeDetection(img2, centerNew(1), centerNew(2), a);
imshow(img2);
figure();
img2 = imgTransform(img2, inv(T));
imshow(img2);
