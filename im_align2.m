
function NCC = im_align2(blue_img, filter_img2)
        min_error = 0;    %maximize 
        x = -20;
        y = 30;
        w = -20;
        u = 30;  
        for a = x:y
            for b = w:u
                circ_shift = circshift(filter_img2,[a b]);
                
                blue_mag = sum(abs(blue_img(:)).^2).^1/2;
                filter_mag = sum(abs(circ_shift(:)).^2).^1/2;
                
                blue_side = blue_img(:)/blue_mag;
                filter_side = circ_shift(:)/filter_mag;
                calc = dot(blue_side,filter_side);
                if min_error < calc
                   min_error = calc;
                   NCC = [a b];
%                    sprintf("Error_values for %d and %d is %d", a, b, min_error)
                end
             end
        end
end


