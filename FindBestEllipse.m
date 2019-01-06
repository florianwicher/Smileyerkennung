function [xCenter,yCenter,a,minorAxis,alpha] = FindBestEllipse(image)

%Bildausschnitte, die Kandidaten f�r das Blatt Papier sind
F = FindSheet(image);
    results = zeros(0,6);
    
for i = 1:size(F,1)
    
    croppedImage = imcrop(image, F(i,1:4));
    
    binaryImage = imbinarize(rgb2gray(croppedImage));
    binaryImage = MedianFilter(binaryImage);
    binaryImage = OpenImage(binaryImage,5);
    kantenbild = CannyFilter(binaryImage,0.2);
    if sum(kantenbild(:)) < 10000000
        %aufgrund der hohen Komplexit�t ist der Algorithmus f�r sehr gro�e
        %Bilder quasi unbrauchbar :( Die Ausf�hrung f�hrt meistens dazu,
        %dass sich Matlab aufh�ngt.

    [Y,X]=find(kantenbild);  %liste der Koordinaten aller Vordergrundpixel
    
    hypotenuseSquared = (X-X').^2 + (Y-Y').^2;
    [P,Q] = find(hypotenuseSquared);
    index = P<Q;
    P = uint32(P(index));
    Q = uint32(Q(index));
    highestScoringEllipse = zeros(1,6);
    highscore = 0; 
    
    %w�hle mithilfe eines zuf�llig ausgew�hlten Elements der
    %symmetrischen Gruppe S(length(P)) eine Untermenge von zu
    %�berpr�fenden Punktpaaren
    pairSubset = (randsample(length(P),min(length(P),10*length(Y))))';
    for pair = pairSubset
        
        x1=X(P(pair));
        x2=X(Q(pair));
        
        y1=Y(P(pair));
        y2=Y(Q(pair));
        
        majorAxisSquared = hypotenuseSquared(P(pair),Q(pair))/4;
        
        xCenter=0.5*x1 + 0.5*x2; yCenter=0.5*y1 + 0.5*y2;
        thirdPointDistanceSquared = (X-xCenter).^2 + (Y-yCenter).^2;
        
        %Punkte, die weiter als die Scheitelpunkte der Hauptachse
        %vom Mittelpunkt entfernt sind, k�nnen die Ellipsengleichung
        %nicht erf�llen, da per Definition die Scheitelpunkte der Haupt-
        %achse die Punkte sind, die vom Mittelpunkt am weitesten entfernt
        %sind
        K = thirdPointDistanceSquared <= majorAxisSquared;

        
        % Der in der Folge verwendete Approach basiert auf
        %"A new efficient ellipse detection method", Yonghong Xie, Qiang Ji,
        %2002 in Object recognition supported by user interaction for service robots;
        %Die hier verwendeten Variablennamen sind dieselben wie dort. Siehe
        %dort auch f�r Skizzen und genaue Erkl�rung des Verfahrens.
        fSquare = (X(K)-x2).^2 + (Y(K)-y2).^2;
        cosineTau = (majorAxisSquared + thirdPointDistanceSquared(K) - fSquare) ./ (2*sqrt(majorAxisSquared*thirdPointDistanceSquared(K)));
        cosineTau = max(-1,cosineTau);
        cosineTau = min(1,cosineTau);
        sineTauSq = 1 - cosineTau.^2; %weil sin(x)^2+cos(x)^2=1
        minorAxis = sqrt( (majorAxisSquared * thirdPointDistanceSquared(K) .* sineTauSq) ./ (majorAxisSquared - thirdPointDistanceSquared(K) .* cosineTau.^2) );

        %runden, damit wir die Ergebnisse in bins einteilen k�nnen
        indices = round(minorAxis);
        
        %entferne die ergebnisse, die auf 0 gerundet wurden (entartete oder
        %beinahe entartete Ellipsen)
        indices = indices(indices>0);
        
        akkumulator = accumarray(indices, 1);

        %durch die Diskretisierung und ungenaue Gleitpunktarithmetik kann
        %das Ergebnis ungenau sein. Durch die Gl�ttung des Ergebnisses mit
        %einem Gauss-Filter werden Nachbarzellen im Akkumulator ebenfalls
        %erh�ht.
        akkumulator = conv(akkumulator,fspecial('gaussian', [6 1], 1),'same');
        akkumulator(1:ceil(sqrt(majorAxisSquared)*0.4)) = 0;
        [score, index] = max(akkumulator);

        %merke dir die plausibelste Hypothese  also die Ellipsengleichung,
        %die die meisten Punkte erf�llen
        if (highscore < score)
            highestScoringEllipse = [xCenter+F(i,1) yCenter+F(i,2) sqrt(majorAxisSquared) index atand((y1-y2)/(x1-x2)) score];
            highscore = score;
        end
    end
    %h�nge das beste Ergebnis dieses Bildausschnitts an die Kandidatenliste
    %f�r das Ergebnis der Suche an.
    results = cat(1, results, highestScoringEllipse);
    end
end

%w�hle die Ellipsengleichung mit dem h�chsten Score und retourniere sie.
[~, index] = max(results(:,6));

t = num2cell(results(index,:));
[xCenter,yCenter,a,minorAxis,alpha,~]=deal(t{:});