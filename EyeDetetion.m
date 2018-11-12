function Picture = EyeDetetion(Img)

Img=imbinarize(Img(:,:,3)); 
Rmin=20;
Rmax=50;  
[centersDark, radiiDark] = imfindcircles(Img, [Rmin Rmax],'ObjectPolarity','dark','sensitivity',0.90);

Glass = imread('Glasses1.jpg');
Glass = imbinarize(Glass(:,:,3));

Glass = ~Glass;

dX = centersDark(1,1) - centersDark(1,2);
dY = centersDark(2,1) - centersDark(2,2);
H = sqrt(dX^2+dY^2);
alpha = asind(dX/H);
Glass = imrotate(Glass, -alpha,'bilinear','crop'); 

Glass = ~Glass;

oX = -20;
oY = 0;

[n,m] = size(Glass);

 for y = 1:m 
     for x = 1:n    
         if Glass(x,y) < 1
             Img(x+oX,y+oY) = 0;
         end
     end
 end
 
 Picture = Img;
 
