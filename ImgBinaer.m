function ImgB = ImgBinaer(Img,Thresh)
    s = size(Img);
    ImgB=zeros(s(1),s(2));
    for x=1:s(1)
        for y=1:s(2)
            if(Img(x,y,1)<=255*Thresh && Img(x,y,2)<=255*Thresh && Img(x,y,3)<=255*Thresh)
                ImgB(x,y)=0;
            else
                ImgB(x,y)=1;
            end
        end
    end
    
end