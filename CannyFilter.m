
bildPfad='C:\TU\Smileyerkennung\Testbild.jpg';
dateityp='jpg';

%bild einlesen
bild=imread(bildPfad,dateityp);
imshow(bild);

%bild in Graustufenbild umwandeln
grayskaleImage=rgb2gray(bild);
imshow(grayskaleImage);

%Canny Filter
canny=edge(grayskaleImage,'canny',[],3);
imshow(canny);