function harris_corner = harris(image)

[dx,dy] = meshgrid(-1:1, -1:1); 
[rows, columns] = size(image);

threshold_1 = 20000000;
K = 0.21;

sigma = 1.5;
sobel_x = double(conv2(image, dx, "same"));
sobel_y = double(conv2(image, dy, "same"));

%Input data for Gaussian Filter
m = 3;n = 3;
[h1, h2] = meshgrid(-m:m, -n:n);
hg = exp(-(h1.^2 + h2.^2)/(2*sigma^2));

sobel_x2 = double(conv2(sobel_x.^2, hg, "same"));   
sobel_y2 = double(conv2(sobel_y.^2, hg, "same"));
sobel_xy = double(conv2(sobel_x.*sobel_y, hg, "same"));
zeros_image = zeros(rows, columns);
% empty_list = 0;

%%
for i = 1:rows
    for j = 1:columns
        M = [sobel_x2(i ,j) sobel_xy(i, j); sobel_xy(i, j) sobel_y2(i, j)];
        R = det(M) - K.*(trace(M)).^2;
        if R > threshold_1
            zeros_image(i ,j) = R;
%               empty_list = R;
        end
    end
end
% sorting = sort(zeros_image, "descend");
% zeros_image = sorting(1, 200);
dilate = imdilate(zeros_image, [1 1 1; 1 0 1; 1 1 1]);
% figure('Name', 'Dilate');imshow(dilate)
% figure('Name', 'zeros_image');imshow(zeros_image)
correcting = zeros_image > dilate; 
correcting(:, 1:26) = 0;
correcting(:, 330:350) = 0;
correcting(1:35, :) = 0;
correcting(280:321, :) = 0;
harris_corner = correcting;
% figure('Name', 'harris_corner');imshow(harris_corner)



% figure;imshow(harris_points)
% subplot(3,3,1),imshow(sobel_x),title("sobelx")
% subplot(3,3,2),imshow(sobel_y),title("sobely")
% subplot(3,3,3),imshow(sobel_x2),title("filtered gaussian of sobel x")
% subplot(3,3,4),imshow(sobel_y2),title("filtered gaussian of sobel y")
% subplot(3,3,5),imshow(sobel_xy),title("filtered gaussian sobel x y combined")
% subplot(3,3,6),imshow(R), title("After Applying Harris Measure")
% subplot(3,3,7),imshow(harris_points), title("Dilation of detected points (local maxima)")
% subplot(3,3,8),imshow(image), hold on,plot(columns, rows, "r."), title("Harris Corner Detection");
        
        
        
        
        
        


