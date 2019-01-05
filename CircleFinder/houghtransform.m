function [hough, maxVec] = houghtransform(image, radSize)

correctionForSmallCircles = 0.3;
sizeIm = size(image);
hough = zeros(sizeIm(1),sizeIm(2), length(radSize));
helper = zeros(sizeIm(1)+2,sizeIm(2)+2);
helperSize = size(helper);
for n = 1:length(radSize)
    radius = radSize(n);       
    Abstand = 2/radius;
    Winkel = 0:Abstand:2*pi;
    pX = cos(Winkel)*radius;
    pY = sin(Winkel)*radius;
    color = 1/(2*pi*radius+correctionForSmallCircles);
    
    for i = 1:sizeIm(1)
        for j = 1:sizeIm(2)            
            if( image(i,j) > 0)
                helper = 0;
                vi = min(max(round(i + pX + 1),1),helperSize(1));
                vj = min(max(round(j + pY + 1),1),helperSize(2));
                index = (vi-1) + (vj-1)*helperSize(1) + 1;
                helper(index) = color;                
                hough(:,:,n) = hough(:,:,n) +helper(2:(end-1), 2:(end-1));
            end
            
        end
    end
end

maxVec = squeeze(max(max(hough)));

