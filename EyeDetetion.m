
Img = imread('Smileyexample.jpg');
figure;imshow(Img);
Img=imbinarize(Img(:,:,3));


glasses = imread('Glasses.png');
glasses = imbinarize(glasses(:,:,3));
glassessize = size(glasses);
glassessize = glassessize(1:2);
glassessize = glassessize';

Rmin=20;
Rmax=50;  
[centersDark, radiiDark] = imfindcircles(Img, [Rmin Rmax],'ObjectPolarity','dark','sensitivity',0.90);

center = centersDark(1:2,:);
radii = radiiDark(1:2);

centers = sum(center,2)/2;
centers = centers - glassessize/2;
centers = round(centers);

Img(1:4, 1:3) = glasses;

hold on
viscircles(centersDark, radiiDark,'LineStyle','--');
hold off