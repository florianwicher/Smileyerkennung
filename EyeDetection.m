function Picture = EyeDetection(Img, MitteSmileyX, MitteSmileyY, RadiusSmiley)
Rmin = round(RadiusSmiley/9);
Rmax= round(RadiusSmiley*2/9);
%Berechnen der Augengröße
[centersDark, radii] = imfindcircles(Img,[Rmin Rmax],'ObjectPolarity','dark','sensitivity',0.95);

%TODO Finde die 2 Nähesten Kreise
[zeilen, ~] = size(centersDark);
[zeilenBild, spaltenBild,~] = size(Img);
for x = 1:zeilen
    deltaX = centersDark(x,1) - MitteSmileyX;
    deltaY = centersDark(x,2) - MitteSmileyY;
    
    centersDark(x,3) = sqrt(deltaX^2 + deltaY^2);
end

[~, minZeile] = min(centersDark(:,3));
Kreis1 = centersDark (minZeile, 1:2);
centersDark(minZeile,:)=[];
[~, minZeile] = min(centersDark(:,3));
Kreis2 = centersDark (minZeile, 1:2);

%TODO Lenge zwischen den Kreisen ausrechnen
Delta = Kreis1 - Kreis2;
LengeZwischenAugen = sqrt(Delta(1)^2 + Delta(2)^2);
    %TODO Brille
    Brille = imread('Glasses.jpg');
    Brille = imresize(Brille,LengeZwischenAugen/100);

%TODO Winkel der Kreise ausrechnen
if Kreis1(1) > Kreis2(1)
    Helper = Kreis1;
    Kreis1 = Kreis2;
    Kreis2 = Helper;
end

%TODO Mitte der Kreise berechnen
Mitte = Kreis1 + ((Kreis2 - Kreis1) * 0.5);

if Mitte(2) >= MitteSmileyY
LengeFuerBerechnung = abs(Kreis1(1) - Kreis2(1));
else
LengeFuerBerechnung = Kreis1(1) - Kreis2(1);
end

Winkel = acosd(LengeFuerBerechnung/LengeZwischenAugen);
    %TODO Brille nach Winkel rotieren
    Brille = imcomplement(Brille);
    Brille = imrotate(Brille,Winkel);
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
                if(x+Mitte(2))>0 && (x+Mitte(2)) <= spaltenBild && (y+Mitte(1))>0 && (y+Mitte(1))<zeilenBild
                    Img(x + Mitte(2),y + Mitte(1),z) = Brille(x,y,z);
                end
            end
         end
     end
 end
 Picture = Img;
end

 
