I = imread('Testbild.jpg');
E = imresize(CannyFilter(I),0.4);

% override some default parameters
params.minMajorAxis = 200;
params.maxMajorAxis = 500;
params.numBest = 1;

% note that the edge (or gradient) image must be used
bestFits = ellipseDetection(E, params);

fprintf('Output %d best fits.\n', size(bestFits,1));

figure;
image(I);

%ellipse drawing implementation: http://www.mathworks.com/matlabcentral/fileexchange/289 
ellipse_draw(bestFits(:,3),bestFits(:,4),bestFits(:,5)*pi/180,bestFits(:,1),bestFits(:,2),'r');

I = imread('Smileyexample1.jpg');
I = EyeDetetion(I);
image(I);
