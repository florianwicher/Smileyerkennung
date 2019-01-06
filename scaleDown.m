% Mathias Schwengerer
function img = scaleDown(img, m)
% skaliert das Bild 'img' so, dass die schmälere Seite 'm' Pixel hat.

minSize = min(size(img,1), size(img,2));

if minSize > m
   s = m / minSize;
   T = [s 0 0; 0 s 0; 0 0 1];
   img = imgTransform(img, T);
end