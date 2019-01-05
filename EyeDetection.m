function [Picture,worked] = EyeDetection(Img, MitteSmileyX, MitteSmileyY, RadiusSmiley)
Im = imbinarize(Img,0.7);
[zeilenBild, spaltenBild,~] = size(Img);    
%Augen berechnen 
xHelper = 0;
yHelper = 0;
checker = 0;
circles = zeros(2,2); 
for y = 0:0.1:1.5
    SearchRadius = RadiusSmiley/(3-y);
    if circles(1,1)==0 || circles(2,1)==0
        i = 1;
        for x = 1:360
            yPoint = MitteSmileyX + SearchRadius * cosd(x);
            xPoint = MitteSmileyY + SearchRadius * sind(x);
            if Im(round(xPoint),round(yPoint),:)==0
                xHelper = xHelper + xPoint;
                yHelper = yHelper + yPoint;
                checker = checker + 1;
            else
                if(checker >= 4 && checker <= 50)
                    circles(i,2) = round(xHelper/checker);
                    circles(i,1) = round(yHelper/checker);
                    i = i + 1;
                    xHelper = 0;
                    yHelper = 0;
                    checker = 0;
                else
                    xHelper = 0;
                    yHelper = 0;
                    checker = 0;
                end
            end
            Img(round(xPoint),round(yPoint),:) = 150;
        end
    end
end
imshow(Img)
if circles(1,1)~=0 && circles(2,1)~=0
    Kreis1 = circles(1,1:2);
    Kreis2 = circles(2,1:2);

    %TODO Lenge zwischen den Kreisen ausrechnen
    Delta = Kreis1 - Kreis2;
    LengeZwischenAugen = sqrt(Delta(1)^2 + Delta(2)^2);
        %TODO Brille
        Brille = imread('Glasses.jpg');
        Brille = ImgResizer(Brille,(LengeZwischenAugen/100)*1.5);

    %TODO Winkel der Kreise ausrechnen
    if Kreis1(1) > Kreis2(1)
        Helper = Kreis1;
        Kreis1 = Kreis2;
        Kreis2 = Helper;
    end

    %TODO Mitte der Kreise berechnen
    Mitte = Kreis1 + ((Kreis2 - Kreis1) * 0.5);

    if Mitte(2) < MitteSmileyY
    LengeFuerBerechnung = abs(Kreis1(1) - Kreis2(1));
    else
    LengeFuerBerechnung = Kreis1(1) - Kreis2(1);
    end

    Winkel = acosd(LengeFuerBerechnung/LengeZwischenAugen);
        %TODO Brille nach Winkel rotieren
        Brille = imcomplement(Brille);
        Brille = ImageRotator(Brille,Winkel);
        Brille = imcomplement(Brille);
        

    %TODO Startpunkt
    [zeilenBrille, spaltenBrille, ~] = size(Brille);
    Mitte(1) = round(Mitte(1) - spaltenBrille/2);
    Mitte(2) = round(Mitte(2) - zeilenBrille/2);
    Mitte = round(Mitte);

    %TODO Brille aufsetzen 
     for x = 1:zeilenBrille 
         for y = 1:spaltenBrille
             for z = 1:3
                if Brille(x,y,z) < 200
                    if(x+Mitte(1))>0 && (x+Mitte(1)) <= spaltenBild && (y+Mitte(2))>0 && (y+Mitte(2))<zeilenBild
                        Img(x + Mitte(2),y + Mitte(1),z) = Brille(x,y,z);
                    end
                end
             end
         end
     end
     worked = true;
else
    worked = false;
end
    Picture = Img;
end


 
