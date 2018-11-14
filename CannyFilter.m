function [canny] = CannyFilter(bild, treshold)


    %Canny Filter
    canny = edge(bild,'Canny',treshold);