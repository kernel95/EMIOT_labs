% Brightness scaling
function new_img = contrast_enhancement(img, b)
    [H, W, channels] = size(img);   % extract size of img

    hsv_img = rgb2hsv(img);         % convert color space to hsv

    for i = 1 : H
        for j = 1 : W
            hsv_img(i, j, 3) = hsv_img(i, j, 3) / b; 
         end
    end 
    new_img = im2uint8(hsv2rgb(hsv_img));
end