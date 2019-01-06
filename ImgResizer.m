%Lippeck Daniel
%Skaliert ein Bild um den angegebenen Faktor
function outputImage = ImgResizer(Image,scale)

%# Größe des Bildes Berechnen
oldPicSize = size(Image);           
newPicSize = max(floor(scale.*oldPicSize(1:2)),1);  

%# Höhere Skallierung berechnen nähesten Punkt im Original Image (relativ zur Skallierung)
rowIndex = min( round(( (1:newPicSize(1) ) - 0.5) ./ scale + 0.5) , oldPicSize(1));

colIndex = min( round(( (1:newPicSize(2) ) - 0.5) ./ scale + 0.5) , oldPicSize(2));

%# Image ausgeben
outputImage = Image(rowIndex,colIndex,:);
end
