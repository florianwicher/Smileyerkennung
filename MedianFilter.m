function [filtered_image] = MedianFilter(img)
%applies a 3x3 Median Filter to the input image

    filtered_image = img;
    
    %go through every pixel in the image, ignore the border
    for i = 2:(size(img,1)-1)
        for j = 1:(size(img,2)-1)
            %check a 3x3 neighborhood around the pixel
            neighborhood = img((j-1):(j+1),(i-1):(i+1));
            %pixel at position j,i is the median of the neighborhood
            filtered_image(j,i) = median(neighborhood(:));
        end
    end
end

