function [xCenter,yCenter,a,b,alpha] = FindBestEllipse(image)

F = FindSheet(image);
    results = zeros(0,6);
    
for i = 1:size(F,1)
    
    croppedImage = imcrop(image, F(i,1:4));
    
    binaryImage = imbinarize(rgb2gray(croppedImage));
    binaryImage = MedianFilter(binaryImage);
    binaryImage = OpenImage(binaryImage,5);
    kantenbild = CannyFilter(binaryImage,0.2);
    if sum(kantenbild(:)) < 10000000

    [Y,X]=find(kantenbild);  %list all points in binary image that are 1
    
    hypotenuseSquared = (X-X').^2 + (Y-Y').^2;
    [P,Q] = find(hypotenuseSquared);
    index = P<Q;
    P = uint32(P(index));
    Q = uint32(Q(index));
    highestScoringEllipse = zeros(1,6);
    highscore = 0;
    
    pairSubset = (randsample(length(P),min(length(P),10*length(Y))))';
    for pair = pairSubset
        
        x1=X(P(pair));
        x2=X(Q(pair));
        y1=Y(P(pair));
        y2=Y(Q(pair));
        
        xCenter=0.5*x1 + 0.5*x2; yCenter=0.5*y1 + 0.5*y2;
        aSq = hypotenuseSquared(P(pair),Q(pair))/4;
        thirdPtDistsSq = (X-xCenter).^2 + (Y-yCenter).^2;
        K = thirdPtDistsSq <= aSq;

        fSq = (X(K)-x2).^2 + (Y(K)-y2).^2;
        cosineTau = (aSq + thirdPtDistsSq(K) - fSq) ./ (2*sqrt(aSq*thirdPtDistsSq(K)));
        cosineTau = max(-1,cosineTau);
        cosineTau = min(1,cosineTau);
        sineTauSq = 1 - cosineTau.^2; %weil sin(x)^2+cos(x)^2=1
        b = sqrt( (aSq * thirdPtDistsSq(K) .* sineTauSq) ./ (aSq - thirdPtDistsSq(K) .* cosineTau.^2) );

        indices = round(b);
        indices = indices(indices>0);
        
        akkumulator = accumarray(indices, 1);

        akkumulator = conv(akkumulator,fspecial('gaussian', [6 1], 1),'same');
        akkumulator(1:ceil(sqrt(aSq)*0.4)) = 0;
        [score, index] = max(akkumulator);

        if (highscore < score)
            highestScoringEllipse = [xCenter+F(i,1) yCenter+F(i,2) sqrt(aSq) index atand((y1-y2)/(x1-x2)) score];
            highscore = score;
        end
    end
    results = cat(1, results, highestScoringEllipse);
    end
end

[~, index] = max(results(:,6));

t = num2cell(results(index,:));
[xCenter,yCenter,a,b,alpha,~]=deal(t{:});