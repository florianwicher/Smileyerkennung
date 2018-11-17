function [x0,y0,a,b,alpha] = FindBestEllipse(image)

F = FindSheet(image);

    params.minMajorAxis = 0;
    params.maxMajorAxis = 160;
    params.rotation = 0;
    params.rotationSpan = 0;
    params.minAspectRatio = 0;
    params.randomize = 30;
    params.numBest = 1;
    params.uniformWeights = true;
    params.smoothStddev = 1;
    params.numBest = 1;
    
    bestFits = zeros(0,6);
    
for i = 1:size(F,1)
    
    croppedImage = imcrop(image, F(i,1:4));
    E = CannyFilter(imbinarize(rgb2gray(croppedImage)),0.1);
    values = ellipseDetection(E, params);
    values(1)= values(1)+F(i,1);
    values(2)= values(2)+F(i,2);
    bestFits = cat(1, bestFits, values);
    
end

[~, index] = max(bestFits(:,6));

t = num2cell(bestFits(index,:));
[x0,y0,a,b,alpha,~]=deal(t{:});
