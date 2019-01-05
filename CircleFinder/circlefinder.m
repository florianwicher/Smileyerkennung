function [r , c , rad, maxVec, houghTrans] = circlefinder(image, minRad, maxRad, thresh)
%CIRCLEFINDER finds circles in an RGB or grayscale image.
%   EXTRACTCIRCLES(houghTrans, tresh , radVec, maxVec)
%   returning a list of circles (row, column, radius) in image im. 
%
% Arguments: 
%           im - RGB or grayscale image.
%           radMin - (optional)the minimum radius of a candidate circle.
%           radMax - (optional)the maximum radius of a candidate circle.
%           tresh - (optional)threshold in the range (0,1].
%           imresize - (optional)the size in pixels of the internal resizing
%                     if its bigger then the longest dimension of the image
%                     the internal image will not be re sized.
%           imDisp - (optional)if passed the circles found will be
%           displayed on this image.
% 
% Return values:
%            r - vector of row coordinates of the circles.
%            c - vector of column coordinates of the circles.
%            rad - vector of radiuses of the circles.
%            maxVec - a vector with the same length as radVec 
%                    indicating the likelihood of a circle in the
%                    corresponding radius. 
%            houghTrans - a 3 dimensional matrix holding the hough transform 
%
% Useage example:
%         [r , c , rad] = circlefinder(im);
%         finds  circles with the default settings.
%         
%        [r , c , rad] = circlefinder(im, [], [], 0.4);
%        finds  circles with the default radius min and max values
%        and a threshold set 0.4
%
%   For questions e-mail me at: nis.kobi@gmail.com
%
%   See also EXTRACTCIRCLES, HOUGHTRANSFORM, RGBCIRCLE, NONMAXSUP1D.

% By Kobi Nistel.
s = size(image);

minRad = round(minRad);
maxRad = round(maxRad);


image = CannyFilter(image(:,:,1),0,1);

radiusSize = minRad:1:maxRad;
[houghTrans, maxVec] = houghtransform(image, radiusSize);

% extracts circle positions from the transformed image
[r, c, rad] = extractcircles(houghTrans, thresh, radiusSize, maxVec);
    
end