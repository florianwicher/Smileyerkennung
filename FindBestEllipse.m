function [x0,y0,a,b,alpha] = FindBestEllipse(image)

F = FindSheet(image);
    
    results = zeros(0,6);
    
    
    
    
for i = 1:size(F,1)
    
    croppedImage = imcrop(image, F(i,1:4));
    
        binaryImage = imbinarize(rgb2gray(croppedImage));
    binaryImage = MedianFilter(binaryImage);
    binaryImage = OpenImage(binaryImage,5);
    kantenbild = CannyFilter(binaryImage,0.2);
    if sum(kantenbild(:)) < 10000000



    

    H = fspecial('gaussian', [6 1], 1);

    [Y,X]=find(kantenbild);
    Y = single(Y); X = single(X);
    N = length(Y);
    
    fprintf('Possible major axes: %d * %d = %d\n', N, N, N*N);

    distsSq = (X-X').^2 + (Y-Y').^2;
    [I,J] = find(distsSq);
    idx = I<J;
    I = uint32(I(idx)); J = uint32(J(idx));
    
    fprintf('..after distance constraint: %d\n', length(I));
    
    perm = randperm(length(I));
    pairSubset = perm(1:min(length(I),10*N));
    clear perm;
    fprintf('..after randomization: %d\n', length(pairSubset));

    highestScoringEllipse = zeros(1,6);
    highscore = 0;
    
    for p= pairSubset
        
        x1=X(I(p)); y1=Y(I(p));
        x2=X(J(p)); y2=Y(J(p));
        
        x0=(x1+x2)/2; y0=(y1+y2)/2;
        aSq = distsSq(I(p),J(p))/4;
        thirdPtDistsSq = (X-x0).^2 + (Y-y0).^2;
        K = thirdPtDistsSq <= aSq;

        fSq = (X(K)-x2).^2 + (Y(K)-y2).^2;
        cosTau = (aSq + thirdPtDistsSq(K) - fSq) ./ (2*sqrt(aSq*thirdPtDistsSq(K)));
        cosTau = min(1,max(-1,cosTau));
        sinTauSq = 1 - cosTau.^2;
        b = sqrt( (aSq * thirdPtDistsSq(K) .* sinTauSq) ./ (aSq - thirdPtDistsSq(K) .* cosTau.^2) );

        %proper bins for b
        idxs = round(b);
        idxs = idxs(idxs>0);
        
        accumulator = accumarray(idxs, 1);

        accumulator = conv(accumulator,H,'same');
        accumulator(1:ceil(sqrt(aSq)*0.4)) = 0;
        [score, idx] = max(accumulator);

        if (highscore < score)
            highestScoringEllipse = [x0+F(i,1) y0+F(i,2) sqrt(aSq) idx atand((y1-y2)/(x1-x2)) score];
            highscore = score;
        end
    end
   
    results = cat(1, results, highestScoringEllipse);
    
    end
end



[~, index] = max(results(:,6));

t = num2cell(results(index,:));
[x0,y0,a,b,alpha,~]=deal(t{:});