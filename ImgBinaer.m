%Lippeck
%ImgToBinaerImage
function ImgB = ImgBinaer(Img,Thresh)
    
    %Größe des Binär Images ausrechnen und anlegen
    s = size(Img);
    ImgB=zeros(s(1),s(2),3);
    for x=1:s(1)
        for y=1:s(2)
            %Wenn Alle Farbebenen dünkler als der Threshhold sind Pixel
            %Schwarz sondst Pixel weiß einfärben
            if(Img(x,y,1)<=255*Thresh && Img(x,y,2)<=255*Thresh && Img(x,y,3)<=255*Thresh)
                ImgB(x,y,1)=0;
                ImgB(x,y,2)=0;
                ImgB(x,y,3)=0;
            else
                ImgB(x,y,1)=1;
                ImgB(x,y,2)=1;
                ImgB(x,y,3)=1;
            end
        end
    end
end