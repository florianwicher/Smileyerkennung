function [x0,y0,a,b,alpha] = FindBestEllipse(image)

F = FindSheet(image);

    params.minMajorAxis = size(image,2)/50;
    params.maxMajorAxis = 1500;
    params.rotation = 0;
    params.rotationSpan = 0;
    params.minAspectRatio = 0.5;
    params.randomize = 10;
    params.numBest =  10;
    params.uniformWeights = true;
    params.smoothStddev = 1;
    
    bestFits = zeros(0,6);
    
for i = 1:size(F,1)
    
    croppedImage = imcrop(image, F(i,1:4));
    binaryImage = imbinarize(rgb2gray(croppedImage));
    binaryImage = MedianFilter(binaryImage);
    binaryImage = OpenImage(binaryImage,5);
    kantenbild = CannyFilter(binaryImage,0.2);
    if sum(kantenbild(:)) < 10000000
        values = ellipseDetection(kantenbild, params);
        values(:,1)= values(:,1)+F(i,1);
        values(:,2)= values(:,2)+F(i,2);
        bestFits = cat(1, bestFits, values);
    end
    
end



[~, index] = max(bestFits(:,6));

t = num2cell(bestFits(index,:));
[x0,y0,a,b,alpha,~]=deal(t{:});