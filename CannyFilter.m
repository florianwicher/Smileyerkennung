function [canny] = CannyFilter(bild)

    %bild einlesen
    bild=imread(bild);
    imshow(bild);

    %bild in Graustufenbild umwandeln
    grayskaleImage=rgb2gray(bild);

    %Canny Filter
    canny = edge(grayskaleImage,'canny',[],3);