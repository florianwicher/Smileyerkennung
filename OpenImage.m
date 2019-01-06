function [filtered_image] = OpenImage(img, r)
%applies an opening filter with the selected size r to the input image.
%as opening pattern, a circle with radius r is used

%create a Disk Pattern
pattern = CreateDisk(r);

eroded_image = img; %copy input image

%erosion
for i = 1:size(img,1)
    for n = 1:size(img,2)
        %check if the neighborhood is smaller than radius r (at the border)
        left = r;
        right = r;
        top = r;
        bottom = r;
        if(i < r+1)
            left = i-1;
        end
        if(i > size(img,1) - r)
            right = i - size(img,1);
        end
        if(n < r+1)
            top = n-1;
        end
        if(n > size(img,2) - r)
            bottom = n - size(img,2);
        end
        neighborhood = img((i-left):(i+right),(n-top):(n+bottom)); %get neighborhood
        c = r+1; %center of the pattern
        smaller_pattern = pattern((c-left):(c+right),(c-top):(c+bottom)); %reduce pattern according to the neighborhood size
        %check if neighborhood has a 1 everywhere the pattern has a 1
        if(sum(sum(neighborhood(smaller_pattern==1))) == sum(sum(smaller_pattern)))
            eroded_image(i,n) = 1;
        else
            eroded_image(i,n) = 0;
        end
    end
end

%dilatation
dilated_image = eroded_image;
for i = 1:size(img,1)
    for n = 1:size(img,2)
        %get the neighborhood size (smaller when at the border)
        left = r;
        right = r;
        top = r;
        bottom = r;
        if(i < r+1)
            left = i-1;
        end
        if(i > size(img,1) - r)
            right = i - size(img,1);
        end
        if(n < r+1)
            top = n-1;
        end
        if(n > size(img,2) - r)
            bottom = n - size(img,2);
        end
        smaller_pattern = pattern((c-left):(c+right),(c-top):(c+bottom)); %reduce pattern
        if eroded_image(i,n) == 1 %check every pixel that is 1
            %set everything to 1 that has a 1 in the pattern
            dilated_image((i-left):(i+right),(n-top):(n+bottom)) = dilated_image((i-left):(i+right),(n-top):(n+bottom)) | smaller_pattern;
        end
    end
end
filtered_image = dilated_image;
end

