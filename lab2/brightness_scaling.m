% Brightness scaling
function new_img = brightness_scaling(img, b)
    [H, W, channels] = size(img);   % extract size of img

    hsv_img = rgb2hsv(img);         % convert color space to hsv

    for i = 1 : H
        for j = 1 : W
            hsv_img(i, j, 3) = hsv_img(i, j, 3) + b; 
            if hsv_img(i, j, 3) > 1.0
                hsv_img(i, j, 3) = 1.0;
            end
         end
    end 
    new_img = im2uint8(hsv2rgb(HSV));


end
