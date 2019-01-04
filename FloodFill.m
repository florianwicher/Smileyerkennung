function [colored_img] = FloodFill(img, x0, y0, threshold)
% flood fills the region around x0, y0 (this should be the center of the
% ellipse) from white to yellow

    colored_img = img;
    base_color = mean(colored_img(y0,x0,:)); %average of alle color components at x0, y0
    q = {}; %initialize the "queue"
    head = 1;
    q{head} = [x0,y0]; %add first point (center) to the queue
    while(head <= numel(q))
        x = q{head}(1); %get x from the queue
        y = q{head}(2); %get y from the queue
        head = head + 1;
        if x >= 1 && x <= size(img,2) && y >= 1 && y <= size(img,1)
            white = colored_img(y,x,:) > base_color * threshold; %white is considered not much darker than the color at the center of the ellipse
            if sum(white) == 3 %check if the color at the point is "white"
                colored_img(y,x,3) = colored_img(y,x,3) - base_color; %remove blue color component
                %add next points to the queue
                q{end+1} = [x+1,y]; %right
                q{end+1} = [x,y+1]; %up
                q{end+1} = [x-1,y]; %left
                q{end+1} = [x,y-1]; %down
            end
        end
    end
end

