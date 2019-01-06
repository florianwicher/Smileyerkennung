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

% scale the image
I = scaleDown(I, 1000);

imshow(CannyFilter(imbinarize(rgb2gray(I)),0.1));

[x0,y0,a,b,alpha] = FindBestEllipse(I);

figure();
imshow(ellipseDraw(img, x0, y0, a, b));

% compute T and transform the image
T = ellipseToCircleT(a,b);
img_corrected = imgTransform(I, T);

% center
center = [x0, y0, 0];
centerNew = center * T;

img2 = FloodFill(img_corrected, round(centerNew(1)), round(centerNew(2)), 0.7);

[img2,worked] = EyeDetection(img2, centerNew(1), centerNew(2), a);
imshow(img2);
figure();
img2 = imgTransform(img2, inv(T));
imshow(img2);
