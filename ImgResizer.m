%Lippeck Daniel
%Skaliert ein Bild um den angegebenen Faktor
function outputImage = ImgResizer(Image,scale)

%# Initialisierung:

oldSize = size(Image);                   %# Gr��e des Bildes
newSize = max(floor(scale.*oldSize(1:2)),1);  %# Gr��e des neuen Bildes

%# H�here Skallierung berechnen

rowIndex = min(round(((1:newSize(1))-0.5)./scale+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale+0.5),oldSize(2));

%# Image ausgeben

outputImage = Image(rowIndex,colIndex,:);
end
