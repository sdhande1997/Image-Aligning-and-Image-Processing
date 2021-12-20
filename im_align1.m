function SSD = im_align1(fix_blue_img,filter_img)
        min_error = 999999;          %minimize error
        x = 8.0;
        y = 10.0;
        w = -3.0;
        u = 3.0;
        for a = x:y
            for b = w:u  
                circular_shift = circshift(filter_img,[a b]);
                calc = sum(sum((fix_blue_img-circular_shift).^2));
                if min_error > calc
                   min_error = calc;
                   SSD = [a b];
%                    sprintf("Error_values for %d and %d is %d", a, b, min_error)
                end
             end
        end
end