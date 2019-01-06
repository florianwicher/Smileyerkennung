function [findsheet] =FindSheet(bild)

    I =bild;

    Theshold=graythresh(I);

    Image_BW=im2bw(I,Theshold);

    pa=CannyFilter(Image_BW, Theshold);

    pa=imbinarize(pa);

    SE=strel('disk',3);

    BW=imdilate(pa,SE);

    %figure,imshow(BW);

    Image_BW=imfill(BW,'holes');

    imshow(Image_BW);

    l=detect(Image_BW);

    size=find(l(1,:)==0,1,'first')-1;

    boundingbox=l(:,1:size)

    boundingboxT=boundingbox';

    figure,imshow(I);

    hold on

    plot(boundingboxT(:,1),boundingboxT(:,2),'b*')

    hold off

    for i=1:size

        rectangle('Position',[boundingboxT(i,1) boundingboxT(i,2) boundingboxT(i,3) boundingboxT(i,4)],'EdgeColor','r','LineWidth',2);

    end

    findsheet=boundingboxT;

end