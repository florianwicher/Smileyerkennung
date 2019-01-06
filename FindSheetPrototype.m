function [findsheet] =FindSheetPrototype(bild)
%Sabrina Oblasser
Theshold=graythresh(bild);
Image_BW=im2bw(bild,Theshold);
%figure,imshow(Image_BW);

%Kantenbild aus Cannyfilter erstellen
pa=CannyFilter(Image_BW, Theshold);
%figure,imshow(pa);
pa=imbinarize(pa);
SE=strel('disk',3);
BW=imdilate(pa,SE);
%figure,imshow(BW);
BWfill=imfill(BW,'holes');
%figure,imshow(BWfill);
[labeled,numObjects] = bwlabel(BWfill,4); % Erzeugt Matrix labeled der Größe BWfill, wobei alle zusammenhängenden Pixel in BWfill eine einheitliche Nummer in labeled erhalten. Die Anzahl der Objekte wird in der Variable numObjects gespeichert.
%figure,imshow(RGB_label);
chrdata = regionprops(labeled,'all'); % Erzeugt eine Struktur chrdata, für jedes Objekt in labeled, in der die gewünschten Merkmale gespeichert werden.
Area = [chrdata.Area];
%kleinstesObjekt
xy=size(BWfill);
x=xy(1,1);
y=xy(1,2);
minSize=(x*y)/300;

idx = find(Area >minSize);
BWa = ismember(labeled,idx); % entfernet die Werte dessen Flächeninhalt <minSize sind
%figure,imshow(BWa)

s=regionprops(BWa,'BoundingBox');
boundingbox=cat(1,s.BoundingBox);
measurements = regionprops(BWa, 'Solidity');
m=cat(1,measurements.Solidity);
objectcoordinates=[boundingbox m];



%entfernt Werte dessen Dichte der weißen Pixel kleiner als 0.5 sind
b=objectcoordinates(:,5);
a=objectcoordinates;
found = b>0.5;
objectcoordinates=a(found,:);


%[sortedS, sortIndexes] = [measurements.Solidity]
figure,imshow(pa)
hold on
plot(objectcoordinates(:,1),objectcoordinates(:,2),'b*')
hold off
for i=1:size(objectcoordinates,1)
    rectangle('Position',[objectcoordinates(i,1) objectcoordinates(i,2) objectcoordinates(i,3) objectcoordinates(i,4)],'EdgeColor','r','LineWidth',2);
    t=text(objectcoordinates(i,1),objectcoordinates(i,2),num2str(objectcoordinates(i,5)));
    tsize=text(objectcoordinates(i,1),objectcoordinates(i,2),num2str(objectcoordinates(i,3)* objectcoordinates(i,4)));
    tsize.Color='white';
    tsize.FontSize=14;
end

s=size(BWfill);
findsheet=objectcoordinates;
