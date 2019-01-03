function imgE = drawAxis(img, x, y, varargin)

if nargin == 5
    a = cell2mat(varargin(1));
    b = cell2mat(varargin(2));
    
    imgE = img;
    imgE(y-2:y+2, x-a:x+a, 1) = 255;
    imgE(y-b:y+b, x-2:x+2, 2) = 255;
elseif nargin == 4
    a = cell2mat(varargin(1));
    
    imgE = img;
    imgE(y-2:y+2, x-a:x+a, 1) = 255;
    imgE(y-a:y+a, x-2:x+2, 1) = 255;
end
