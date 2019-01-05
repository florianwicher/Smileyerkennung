I = imread('Smileyexample.jpg');
Im = ImgBinaer(I,0.3);


s = size(I);
I = EyeDetection(I,s(1)/2,s(1)/2,(s(1)-5)/2);

imshow(I)