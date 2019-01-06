%Lippeck Daniel
%Rotiert ein Bild um die gewünschten Grad
function rotImage = ImageRotator(img,degree)

switch mod(degree, 360)
    % Spezialfälle
    case 0
        %Nichts
        rotImage = img;
    case 90
        %Einfache Matrix rotation
        rotImage = rot90(img);
    case 180
        %Bild umdrehen
        rotImage = img(end:-1:1, end:-1:1);
    case 270
        %Einfache Matrix rotation mit umgedrehten Bild
        rotImage = rot90(img(end:-1:1, end:-1:1));

    % Rotation
    otherwise

        % Radiant + Transformationsmatrix
        rad = degree*pi/180;
        TransM = [+cos(rad) +sin(rad); -sin(rad) +cos(rad)];

        % Größe des Bildes berechnen
        [h,b,d] = size(img);
        helper = round( [1 1; 1 b; h 1; h b]*TransM );
        helper = (helper - min(helper)) + 1;
        rotImage = zeros([max(helper) d],class(img));

        % Pixelmapping vom Transformierten Image zum Org
        for Bildh = 1:size(rotImage,1)
            for Bildb = 1:size(rotImage,2)
                orig = ([Bildh Bildb]-helper(1,:))*TransM.';
                if all(orig >= 1) && all(orig <= [h b])
                    %Runden
                    Dn = floor(orig);
                    Up = ceil(orig);

                    % Alle 4 anliegenden Pixel betrachten
                    % Relative Fläche berechnen
                    A = [((Up(2)-orig(2))*(Up(1)-orig(1))),((orig(2)-Dn(2))*(orig(1)-Dn(1)));
                        ((Up(2)-orig(2))*(orig(1)-Dn(1))),((orig(2)-Dn(2))*(Up(1)-orig(1)))];

                    % Farbe berechnen
                    cols = A .* double(img(Dn(1):Up(1),Dn(2):Up(2),:));

                    % Einfügen                     
                    rotImage(Bildh,Bildb,:) = sum(sum(cols),2);

                end
            end
        end        
end
end