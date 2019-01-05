function [labels]  = findConnectingPixels(binaryImg,label,labelmatrix,queue)
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
labels=labelmatrix;
end
