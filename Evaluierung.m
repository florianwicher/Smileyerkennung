clear all;

name = 'IMG_20181117_155407';
type = '.jpg';

% Bild einlesen
img = imread( strcat('Datensatz/', name, type) );

% Bild speichern (Orginalbild)
imwrite(img, strcat('Evaluierung/', name, '_1_original', type) );

% Ellipse suchen
[x0,y0,a,b,alpha] = FindBestEllipse(img);
    close all;

% zeichne Ellipse
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

% Bild speichern (Ellipse)
imwrite(img_ellipse, strcat('Evaluierung/', name, '_2_ellipse', type) );


% Berechnen der Transformationsmatrix und Durchführung der Transformation
T = ellipseToCircleT(a,b);
img_corrected = imgTransform(img, T);

% center
center = [x0, y0, 0];
centerNew = center * T;

% Bild speichern (Kreis)
imwrite(img_corrected, strcat('Evaluierung/', name, '_3_circle', type) );

% Smiley ausmalen
img_filled = FloodFill(img_corrected, round(centerNew(1)), round(centerNew(2)), 0.7);

% Bild speichern (ausgemalt)
imwrite(img_filled, strcat('Evaluierung/', name, '_4_filled', type) );

% Brille aufsetzen
    %img_glasses = img_filled;
[img_glasses, worked] = EyeDetection(img_filled, centerNew(1), centerNew(2), a);
    close all;
    
% Bild speichern (Brille)
imwrite(img_glasses, strcat('Evaluierung/', name, '_5_glasses', type) );

% zurücktransformieren (Ausgabebild)
img_result = imgTransform(img_glasses, inv(T));

% Bild speichern (Ausgabebild)
imwrite(img_result, strcat('Evaluierung/', name, '_6_result', type) );

