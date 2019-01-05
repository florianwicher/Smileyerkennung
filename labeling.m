I = imread('Testbild.jpg');
Theshold=graythresh(I);
Image_BW=im2bw(I,Theshold);

l=detect(Image_BW);

max(max(l))
imshow(l)
