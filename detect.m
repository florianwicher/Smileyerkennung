function [boundingboxes]  = detect(bw);

[m,n]=size(bw);

bwnnew = [ zeros(1,n) ;  bw; zeros(1,n)];

bwnnew  = [ zeros(m+2,1) , bwnnew , zeros(m+2,1)];

labelMatrix=zeros(size(bwnnew)); %labelMatrixabel array 0 not labeled

startLabel=1;

boundingbox=zeros(4,n);





for(ir=2:m+1)

    for(ic=2:n+1)

        

        curdata=bwnnew(ir,ic);

        lc           = labelMatrix(ir,ic);

        

        if((curdata==1)&&(lc==0))

            labelMatrix(ir,ic)=startLabel;

            queue=zeros(2,m*n);

            queue(1,1)=ir;

            queue(2,1)=ic;

            

             [labelMatrix,boundingbox] = findConnectingPixels(bwnnew,startLabel,labelMatrix,queue,boundingbox);

             

             startLabel = startLabel+1;

        end

        

    end

end

labelMatrix(labelMatrix==-1)=0;

imshow(labelMatrix);

boundingboxes=boundingbox;


end