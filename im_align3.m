function ransac = im_align3(harris_blue, harris_filter)

% harris_blue = imread("image_blue-harris.jpg");
% harris_filter = imread("image_green-harris.jpg");

iterations = 0;
x = 2;
y = 2;

[blue_y, blue_x] = find(harris_blue);

[red_y, red_x] = find(harris_filter);

store_idx = [];
accuracy = [];

while iterations < 3500
    inliers = [];
    outliers = [];
    %Get Random points from both the channel features
    get_index = randi([1, 200], 1,1);
   
    
    rand_blue_y = blue_y(get_index);        %Y Blue...rows
    rand_blue_x = blue_x(get_index);        %X Blue...columns
    store_idx = [store_idx, get_index];
    
    rand_red_y = red_y(get_index);        %Y filter...rows
    rand_red_x = red_x(get_index);        %X filter...columns
    
    diff_u = rand_blue_x - rand_red_x;
    diff_v = rand_blue_y - rand_red_y;
    
    Rx_u = red_x + diff_u;
    Ry_v = red_y + diff_v;
    
    for i = 1:size(blue_x)
        for a = -4:4
            Yb_thresh = blue_y(i) + a;       % x
            Yb_thresh_neg = blue_y(i) - a;   % y
            
            Xb_thresh = blue_x(i) + a;
            Xb_thresh_neg = blue_x(i) - a;
        end
%         rows = length(Yb_thresh_neg);
%         columns = length(Yb_thresh);
%         xloop = zeros(rows, columns);
%         yloop = zeros(rows, columns);
%         for column = 1 : length(Yb_thresh)
%             xloop(:, column) = Yb_thresh(column);
%             yloop(:, column) = Yb_thresh_neg;
%         end

        grid_y = (Yb_thresh_neg:1:Yb_thresh);
        grid_x = (Xb_thresh_neg:1:Xb_thresh);
        
        search_pts_y = ismember(grid_y, Ry_v);
        search_pts_x = ismember(grid_x, Rx_u);
        
        
        if any(search_pts_x(:) > 0)
            if any (search_pts_y(:) > 0)
                inliers = [inliers i];
            else
                outliers = [outliers i];
            end
        else
            outliers = [outliers i];
        end
        
    end
    iterations = iterations + 1;   
    prob = size(inliers)/(size(outliers) + size(inliers));
    accuracy = [accuracy prob];
end

[high_accu, index] = max(accuracy);
disp("Index")
index

% [max_number] = max(inliers(:));
% max_number;
% [X, Y] = ind2sub(size(inliers), max_number);
% disp("SizeY, X")
% Y
% X

rand_idx = store_idx(index);
rand_blue_y = blue_y(rand_idx);       
rand_blue_x = blue_x(rand_idx);       

rand_red_y = red_y(rand_idx);        
rand_red_x = red_x(rand_idx);       

new_u = rand_blue_x - rand_red_x;
new_v = rand_blue_y - rand_red_y;
    
ransac = [new_u, new_v];
end

   






