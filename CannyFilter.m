function [canny] = CannyFilter(bild, treshold)
    %bild in Graustufenbild umwandeln
    grayskaleImage=rgb2gray(bild);

    %Canny Filter
    canny = edge(grayskaleImage,'Canny',treshold);