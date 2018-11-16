 function Picture = EyeDetetion(Img)

Picture = Img;
[w,e,r] = size(Picture);
Img=imbinarize(Img(:,:,3));
Rmin=20;
Rmax=50;  
[centersDark, radiiDark] = imfindcircles(Img, [Rmin Rmax],'ObjectPolarity','dark','sensitivity',0.90);

%Abstand zwischen Augen ausrechnen
dX = centersDark(1,1) - centersDark(1,2);
dY = centersDark(2,1) - centersDark(2,2);
H = sqrt(dX^2+dY^2);

Glass = imread('Glasses.jpg');
%TODO Glasses Größe je nach Augenabstand ändern

%TODO Glasses drehen je nach Augenwinkel

%Länge und Breite Abspeichern
[n,m,o] = size(Glass);
%TODO Glasses Startpunkt berechnen je nach Winkel
oX = round(centersDark(1,1))-round(n/2.9);
oY = round(centersDark(1,2))-round(m/2.95);

%Glasses auf Smiley überschreiben
 for x = 1:n 
     for y = 1:m  
         for z = 1:o
            if Glass(x,y,z) < 100
                if(x+oX)>0 && (x+oX)<w && (y+oY)>0 && (y+oY)<e
                    Picture(x+oX,y+oY,z) = Glass(x,y,z);
                end
            end
         end
     end
 end
 

 
