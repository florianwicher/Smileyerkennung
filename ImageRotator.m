function rotImage = ImageRotator(img,degree)

switch mod(degree, 360)
    % Spezialfälle
    case 0
        rotImage = img;
    case 90
        rotImage = rot90(img);
    case 180
        rotImage = img(end:-1:1, end:-1:1);
    case 270
        rotImage = rot90(img(end:-1:1, end:-1:1));

    % Rotation
    otherwise

        % Radians + Transformationsmatrix
        a = degree*pi/180;
        R = [+cos(a) +sin(a); -sin(a) +cos(a)];

        % Größe des Bildes berechnen
        [m,n,p] = size(img);
        dest = round( [1 1; 1 n; m 1; m n]*R );
        dest = bsxfun(@minus, dest, min(dest)) + 1;
        rotImage = zeros([max(dest) p],class(img));

        % Pixelmapping vom Transformierten Image zum Org
        for ii = 1:size(rotImage,1)
            for jj = 1:size(rotImage,2)
                source = ([ii jj]-dest(1,:))*R.';
                if all(source >= 1) && all(source <= [m n])

                    % Alle 4 anliegenden Pixel betrachten
                    C = ceil(source);
                    F = floor(source);

                    % Relative Fläche berechnen
                    A = [...
                        ((C(2)-source(2))*(C(1)-source(1))),...
                        ((source(2)-F(2))*(source(1)-F(1)));
                        ((C(2)-source(2))*(source(1)-F(1))),...
                        ((source(2)-F(2))*(C(1)-source(1)))];

                    % Farbe berechnen
                    cols = bsxfun(@times, A, double(img(F(1):C(1),F(2):C(2),:)));

                    % Einfügen                     
                    rotImage(ii,jj,:) = sum(sum(cols),2);

                end
            end
        end        
end
end