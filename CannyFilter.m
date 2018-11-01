function [canny] = CannyFilter(bild)
    %bild in Graustufenbild umwandeln
    grayskaleImage=rgb2gray(bild);

    %Canny Filter
    canny = edge(grayskaleImage,'canny',[],3);