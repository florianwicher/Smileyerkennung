function [x0,y0,a,b,alpha] = FindBestEllipse(image)

F = FindSheet(image);

    params.minMajorAxis = 0;
    params.maxMajorAxis = 1500;
    params.rotation = 0;
    params.rotationSpan = 0;
    params.minAspectRatio = 0.2;
    params.randomize = 10;
    params.numBest =  10;
    params.uniformWeights = true;
    params.smoothStddev = 1;
    
    bestFits = zeros(0,6);
    
for i = 1:size(F,1)
    
    croppedImage = imcrop(image, F(i,1:4));
    kantenbild = CannyFilter(imbinarize(rgb2gray(croppedImage)),0.2);
    values = ellipseDetection(kantenbild, params);
    values(:,1)= values(:,1)+F(i,1);
    values(:,2)= values(:,2)+F(i,2);
    bestFits = cat(1, bestFits, values);
    
end



[~, index] = max(bestFits(:,6));

t = num2cell(bestFits(index,:));
[x0,y0,a,b,alpha,~]=deal(t{:});