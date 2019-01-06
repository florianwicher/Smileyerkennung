function [labels,boundingboxes]  = findConnectingPixels(binaryImg,label,labelmatrix,queue,boundingbox)
%Sabrina Oblasser

%labels=matrix which represents the different white areas in the image
%(labeled with  numbers)
%boundingboxes=matrix with 4 rows: column, row of the lower left point,
%width, height of the boundingbox

readindex=1;
writeindex=2;

while(readindex<writeindex)

    actrow=queue(1,readindex);
    actcol=queue(2,readindex);
    
    topLabel=labelmatrix(actrow-1,actcol);
    topImg=binaryImg(actrow-1,actcol);

    if(topLabel==0 && topImg==1)

        labelmatrix(actrow-1,actcol)=label;
        queue(1,writeindex)=actrow-1;
        queue(2,writeindex)=actcol;
        writeindex=writeindex+1;

    end

    rightLabel=labelmatrix(actrow,actcol+1);
    rightImg=binaryImg(actrow,actcol+1);

    if(rightLabel==0 && rightImg==1)
        labelmatrix(actrow,actcol+1)=label;
        queue(1,writeindex)=actrow;
        queue(2,writeindex)=actcol+1;
        writeindex=writeindex+1;

    end

    botLabel=labelmatrix(actrow+1,actcol);
    botImg=binaryImg(actrow+1,actcol);

    if(botLabel==0 && botImg==1)
        labelmatrix(actrow+1,actcol)=label;
        queue(1,writeindex)=actrow+1;
        queue(2,writeindex)=actcol;
        writeindex=writeindex+1;

    end

    leftLabel=labelmatrix(actrow,actcol-1);
    leftImg=binaryImg(actrow,actcol-1);

    if(leftLabel==0 && leftImg==1)
        labelmatrix(actrow,actcol-1)=label;
        queue(1,writeindex)=actrow;
        queue(2,writeindex)=actcol-1;
       writeindex=writeindex+1;

    end

    readindex=readindex+1;

end

imgSize=size(queue,2);
minSize=imgSize/300;

if(readindex-1<minSize)
    labelmatrix(labelmatrix==label)=-1;
end

if(readindex-1>=minSize)

   first0=find(queue(1,:)==0,1,'first');
   queueCut=queue(:,1:first0-1);
   minRow=min(queueCut(1,:))-1;
   maxRow=max(queueCut(1,:))-1;
   minCol=min(queueCut(2,:))-1;
   maxCol=max(queueCut(2,:))-1;
   height=maxRow-minRow+1;
   width=maxCol-minCol+1;
   areaBoundingBox=width*height;
   objectArea=readindex-1;
   ratio=objectArea/areaBoundingBox;

   if(ratio>0.3)

       empty=find(boundingbox(1,:)==0,1,'first');
       boundingbox(1,empty)=minCol; %
       boundingbox(2,empty)=minRow;
       boundingbox(3,empty)=width;
       boundingbox(4,empty)=height;

   else
       labelmatrix(labelmatrix==label)=-1;
   end

end

labels=labelmatrix;
boundingboxes=boundingbox;

end