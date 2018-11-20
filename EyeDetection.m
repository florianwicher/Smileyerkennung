function Picture = EyeDetection(Img)
ImgB = Img;

ImgB=imbinarize(ImgB(:,:,3));

%Mitte des Smileys berechnen / Smiley ausschneiden
[heightP,lengthP,~] = size(Img);
heightset = false;
lengthset = false;
for height = 1:heightP
    for length = 1:lengthP
        if ImgB(height,length)==0 && ~lengthset
            y1 = height;
            lengthset = true;
        end
    end
end

for length = 1:lengthP
    for height = 1:heightP
        if ImgB(height,length)==0 && ~heightset
            x2 = length;
            heightset = true;
        end
    end
end

heightset = false;
lengthset = false;
for height = 0:heightP-1
    for length = 0:lengthP-1
        if ImgB(heightP-height,lengthP-length)==0 && ~lengthset
            y3 = heightP-height;
            lengthset = true;
        end
    end
end

for length = 0:lengthP-1
    for height = 0:heightP-1
        if ImgB(heightP-height,lengthP-length)==0 && ~heightset
            x4 = lengthP-length;
            heightset = true;
        end
    end
end
            
length = x4 - x2;
height = y3 - y1;

ImgCropped = imcrop(ImgB,[x2 y1 length height]);


%Winkel des Smileys erkennen
heightHalf = round(height/2);
lengthHalf = round(length/2);
for Winkel = 0:360
    ImgTemp = imrotate(~ImgCropped,Winkel,'crop');
    ImgTemp = ~ImgTemp;
    
    ImgO = ImgTemp(1:heightHalf,1:length);
    ImgU = ImgTemp(heightHalf+1:height,1:length);
    ImgL = ImgTemp(1:height,1:lengthHalf);
    ImgR = ImgTemp(1:height,lengthHalf+1:length);
    
    SumO = sum(ImgO(:)==0);
    SumU = sum(ImgU(:)==0);
    SumL = sum(ImgL(:)==0);
    SumR = sum(ImgR(:)==0);
    
    VerhaeltnisH = SumO/SumU;
    VerhaeltnisS = SumL/SumR;
    if VerhaeltnisH <= 0.94 && VerhaeltnisS >=0.99 && VerhaeltnisS <= 1.01
        WinkelP = Winkel;
        break
    end
end

Glass = imread('Glasses.jpg');
Glass = imcomplement(Glass);
[~,lengthGlass,~] = size(Glass);
Glass = imresize(Glass,length/lengthGlass);
Glass = imcomplement(Glass);

Img = imcomplement(Img);
Img = imrotate(Img,WinkelP,'crop');
Img = imcomplement(Img);

[heightGlass,lengthGlass,o] = size(Glass);
oX=x2+round(heightGlass/3);
oY=y1+round(lengthGlass/14);

 for x = 1:heightGlass 
     for y = 1:lengthGlass  
         for z = 1:o
            if Glass(x,y,z) < 200
                if(x+oX)>0 && (x+oX)<lengthP && (y+oY)>0 && (y+oY)<heightP
                    Img(x+oX,y+oY,z) = Glass(x,y,z);
                end
            end
         end
     end
 end
 
Img = imcomplement(Img);
Img = imrotate(Img,-WinkelP,'crop');
Img = imcomplement(Img);

Picture = Img;
end

 
