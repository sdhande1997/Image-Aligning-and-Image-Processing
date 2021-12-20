clc;
row1 = 25:345;
row2 = 350:670;
row3 = 676:996;
colm = 26:375;


for i = 1:1
    img_name = sprintf('image%d.jpg',i);                %get image
%     img = (imread('image1.jpg'));
    img = (imread(img_name));
    double = im2double(img);
%     figure;imshow(img)
    h = gca;                                            %get current axis
    h.Visible = "On";
    
    
    %Stacking images                                 #################
    red = img(row1,colm);
    green = img(row2,colm);
    blue = img(row3, colm);
    
    
%%     Combining images                                
    combImg = cat(3,blue,green,red);
    color_image = sprintf("image%d-color.jpg", i);        %store Images
    imwrite(combImg, color_image);
     
    %Getting sample data for processing            #################
    cut_blue = blue(200:240, 200:240);
    cut_green = green(200:240, 200:240);
    cut_red = red(200:240, 200:240);
    
    
%%     Alignment of images by SSD                    
%     diff_ssd_red = im_align1(cut_blue, cut_red);
%     sprintf("Image SSD: %d ", i)
%     sprintf("red: %d ", diff_ssd_red)
%     diff_ssd_green = im_align1(cut_blue, cut_green);
%     sprintf("green: %d ", diff_ssd_green)
% %     
%     
%     correcting_red = circshift(red, diff_ssd_red);
%     correcting_green = circshift(green, diff_ssd_green);
%     
%     comb_ssd_img = cat(3, blue, correcting_green, correcting_red);
%     ssd_image = sprintf("image%d-ssd.jpg", i);        %store Images
%     imwrite(comb_ssd_img, ssd_image);
% % %     
    
%%     Alignment of images by NCC       
% % 
%     blue_d = im2double(blue);
%     red_d = im2double(red);
%     green_d = im2double(green);
%     
%     diff_ncc_red = im_align2(blue_d, red_d);
%     sprintf("Image NCC: %d ", i)
%     sprintf("red: %d ", diff_ncc_red)
%     diff_ncc_green = im_align2(blue_d, green_d);
%     sprintf("green: %d ", diff_ncc_green)
% 
%     correcting_red_ncc = circshift(red, diff_ncc_red);
%     correcting_green_ncc = circshift(green, diff_ncc_green);
%     
%     comb_ncc_img = cat(3, blue, correcting_green_ncc, correcting_red_ncc);
%     ncc_image = sprintf("image%d-ncc.jpg", i);        %store Images
%     imwrite(comb_ncc_img, ncc_image);
%     
    
%%     Corner Detection by harris corner detection method
    
    harris_corner_blue = harris(blue);
    harris_corner_green = harris(green);
    harris_corner_red = harris(red);
    sprintf("Harris Blue %d", i)
    size(find(harris_corner_green))
    sprintf("Harris Green %d", i)
    size(find(harris_corner_blue))
    sprintf("Harris Red %d", i)
    size(find(harris_corner_red))
    
    [rows_red, columns_red] = find(harris_corner_red);
    [rows_green, columns_green] = find(harris_corner_green);
    [rows_blue, columns_blue] = find(harris_corner_blue);
%     subplot(2,3,i), imshow(red), hold on, plot(columns_red, rows_red, "r.");
%     subplot(2,3,i), imshow(green), hold on, plot(columns_green, rows_green, "r.");
%     subplot(2,3,i), imshow(blue), hold on, plot(columns_blue, rows_blue, "r.");
%     
%  
    
%%     Alignment by RANSAC
    diff_ransac_red = im_align3(harris_corner_blue, harris_corner_red);
    diff_ransac_green = im_align3(harris_corner_blue, harris_corner_green);

    correcting_ransac_red = circshift(red, diff_ransac_red);
    correcting_ransac_green = circshift(green, diff_ransac_green);
    sprintf("Image Ransac: %d ", i)
    sprintf("Ransac_Red %d ", diff_ransac_red)
    sprintf("Ransac_Green %d ", diff_ransac_green)
    
    comb_ransac_img = cat(3, blue, correcting_ransac_green, correcting_ransac_red);
    subplot(2,3,i),imshow(comb_ransac_img);
    ransac_image = sprintf("image%d-corner.jpg", i);        %store Images
    imwrite(comb_ransac_img, ransac_image);

    
end

