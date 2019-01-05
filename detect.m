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



%%     -------------  findConnectedLabels
    function [L]  = findConnectedLabels(L,startLabel,bwcur,ir,ic,m,n)
        %startLabel
        %L
        %pause(0.1)
        
        a = bwcur(ir+1, ic);  % next row
        b = bwcur(ir-1, ic);    % previous row
        c = bwcur(ir, ic+1);  % next col
        d = bwcur(ir, ic-1);   % prev column
        
        aa = L(ir+1, ic);  % next row
        bb = L(ir-1, ic);    % previous row
        cc = L(ir, ic+1);  % next col
        dd = L(ir, ic-1);   % prev column
        
     %   Lout = L;
        
        if((a==1)&&(aa==0))
            L(ir+1, ic)=startLabel;
            [L]  = findConnectedLabels(L,startLabel,bwcur,ir+1,ic,m,n);
        end
        
        if((b==1)&&(bb==0))
            L(ir-1, ic)=startLabel;
            [L]  = findConnectedLabels(L,startLabel,bwcur,ir-1,ic,m,n);
        end
        
        if((c==1)&&(cc==0))
            L(ir, ic+1)=startLabel;
            [L]  = findConnectedLabels(L,startLabel,bwcur,ir,ic+1,m,n);
        end
        
        if((d==1)&&(dd==0))
            L(ir, ic-1)=startLabel;
            [L]  = findConnectedLabels(L,startLabel,bwcur,ir,ic-1,m,n);
        end
        
        
    end
%---------------------
end
