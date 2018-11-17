I = imread('Testbild.jpg');
F = FindSheet(I);
I = imcrop(I, F(2,1:4));

E = CannyFilter(imbinarize(rgb2gray(I)),0.1);
%E = imcomplement(rgb2gray(I));

% override some default parameters
params.numBest = 10;

% note that the edge (or gradient) image must be used

params.minMajorAxis = 00;
params.maxMajorAxis = 160;
params.rotation = 0;
params.rotationSpan = 0;
params.minAspectRatio = 0;
params.randomize = 100;
params.numBest = 1;
params.uniformWeights = true;
params.smoothStddev = 1;

bestFits = ellipseDetection(E, params);

fprintf('Output %d best fits.\n', size(bestFits,1));

figure;
image(I);

%ellipse drawing implementation: http://www.mathworks.com/matlabcentral/fileexchange/289 
ellipse_draw(bestFits(:,3),bestFits(:,4),bestFits(:,5)*pi/180,bestFits(:,1),bestFits(:,2),'r');