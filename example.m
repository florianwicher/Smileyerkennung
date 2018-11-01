I = imread('wheel.jpg');
I=imresize(I,0.85);
%E = imresize(CannyFilter('Testbild.jpg'),0.2);

E = edge(rgb2gray(I),'canny');

% override some default parameters
params.minMajorAxis = 200;
params.maxMajorAxis = 500;
params.numBest = 1;

% note that the edge (or gradient) image is used
bestFits = ellipseDetection(E, params);

fprintf('Output %d best fits.\n', size(bestFits,1));

figure;
image(I);

%ellipse drawing implementation: http://www.mathworks.com/matlabcentral/fileexchange/289 
ellipse_draw(bestFits(:,3),bestFits(:,4),bestFits(:,5)*pi/180,bestFits(:,1),bestFits(:,2),'r');