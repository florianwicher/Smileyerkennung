%Lippeck Daniel
%Erkennung der Augen
function [Picture,worked] = EyeDetection(Img, MitteSmileyX, MitteSmileyY, RadiusSmiley)

Im = ImgBinaer(Img,0.6);
image(Im);
[zeilenBild, spaltenBild,~] = size(Img);    
xHelper = 0;
yHelper = 0;
checker = 0;
checker2 = 0;
circles = zeros(2,2); 
%Durchsucht von Mittelpunkt des Smileys Kreisförmig ob Schwarze Flächen
%vorhanden sind - erste Detektierten Flächen sind die Augen - da die Augen
%näher zum Mittelpunkt sind als der  Mund
for y = 0:0.1:2.5
    SearchRadius = RadiusSmiley/(4-y);
    if circles(1,1)==0 || circles(2,1)==0
        i = 1;
        for x = 1:360
            checker2 = checker2 - 1;
            yPoint = MitteSmileyX + SearchRadius * cosd(x);
            xPoint = MitteSmileyY + SearchRadius * sind(x);
            if Im(round(xPoint),round(yPoint),:)==0 & checker2 <= 0
                xHelper = xHelper + xPoint;
                yHelper = yHelper + yPoint;
                checker = checker + 1;
            else
                if(checker >= 10 && checker <= 40)
                    circles(i,2) = round(xHelper/checker);
                    circles(i,1) = round(yHelper/checker);
                    i = i + 1;
                    xHelper = 0;
                    yHelper = 0;
                    checker = 0;
                    checker2 = 15;
                else
                    xHelper = 0;
                    yHelper = 0;
                    checker = 0;
                end
            end
        end
    end
end
%Wenn 2 Flächen erkannt wurden
if circles(1,1)~=0 && circles(2,1)~=0
    Kreis1 = circles(1,1:2);
    Kreis2 = circles(2,1:2);
    
    Delta = Kreis1 - Kreis2;
    LengeZwischenAugen = sqrt(Delta(1)^2 + Delta(2)^2);
    %Sollte es doch zu zuvielen schwarzen Flächen kommen (mehr als 2 für Augen)
    %und der Augenabstand nicht passt (zu klein für Smiley) so werden die anderen Flächen als
    %richtige Augen angenommen
    if(LengeZwischenAugen < RadiusSmiley/8 && length(circles(:,1))>=3)
        for cir = 3:length(circles(:,1))
            if(LengeZwischenAugen < RadiusSmiley/8)
                Kreis2 = circles(cir,1:2);
                LengeZwischenAugen = sqrt(Delta(1)^2 + Delta(2)^2);
            end
        end
    end


        %Brille wird eingelsen und entsprechend der Augengröße sklaiert
        Brille = imread('Glasses.jpg');
        Brille = ImgResizer(Brille,(LengeZwischenAugen/100)*1.7);

    % Die Kreise werden so getauscht das der linkere Kreis gleich Kreis1
    % ist
    if Kreis1(1) > Kreis2(1)
        Helper = Kreis1;
        Kreis1 = Kreis2;
        Kreis2 = Helper;
    end

    %Es wird die MItte zwischen den Punkten berechnet für den Mittelpunkt
    %der Brille
    Mitte = Kreis1 + ((Kreis2 - Kreis1) * 0.5);

    % Je nachdem ob der Mittelpunk über oder unter dem Smiley mittelpunkt
    % ist wird die Brille um 180 grad gedreht
    if Mitte(1) < MitteSmileyX
        if Mitte(2) < MitteSmileyY
        LengeFuerBerechnung = abs(Kreis1(1) - Kreis2(1));
        else
        LengeFuerBerechnung = Kreis1(1) - Kreis2(1);
        end
    else
        if Mitte(2) < MitteSmileyY
        LengeFuerBerechnung = (Kreis1(1) - Kreis2(1));
        else
        LengeFuerBerechnung = abs(Kreis1(1) - Kreis2(1));
        end
    end

    %Winkel wird berechnet
    Winkel = acosd(LengeFuerBerechnung/LengeZwischenAugen);
        %das komplent der Brille wird rotiert, da bei der Funktion ansonten
        %schwarze Ränder durch die Drehung des Bildes auftauchen würden
        Brille = imcomplement(Brille);
        Brille = ImageRotator(Brille,Winkel);
        Brille = imcomplement(Brille);
        

    %Der Startpunkt (Linksoben) für das einfügen der Brille wird berechnet
    [zeilenBrille, spaltenBrille, ~] = size(Brille);
    Mitte(1) = round(Mitte(1) - spaltenBrille/2);
    Mitte(2) = round(Mitte(2) - zeilenBrille/2);
    Mitte = round(Mitte);

    %Brille wird ins Bild eingefügt 
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
     %Es hat funktionert
     worked = true;
else
    %Es hat nicht funktioniert
    worked = false;
end
    %Bild wird zurück gegeben
    Picture = Img;
end


 
