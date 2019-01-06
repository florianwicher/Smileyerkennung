%Julia Kleinferchner
function [pattern] = CreateDisk(r)
%creates a disk shape pattern with r size that can be used for filtering

%create matrix to contain the pattern
pattern = zeros(2*r + 1);

for i=1:size(pattern,1)
    for n=1:size(pattern,2)
        %calculate distance from center
        distance = sqrt((i - r - 1)^2 + (n - r - 1)^2);
        if distance <= r
            pattern(i,n) = 1;
        end
    end
end
end

