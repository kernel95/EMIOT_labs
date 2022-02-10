function new_img = brightnessContrast (img)

    [H, W, channels] = size(img);   % extract size of img

    HSV = rgb2hsv(hungryImg);

    c = 1/(gu - gl);
    d = (gl/(gu-gl));
    
    for i = 1:H
         for j = 1:W
            if (HSV(i, j, 3)<= gl)
                HSV(i, j, 3) = 0;
            elseif (HSV(i, j, 3) > gl && HSV (i, j, 3)<= gu) 
                HSV(i, j, 3) = c*HSV(i, j, 3) + d;
            else
                HSV(i, j, 3) = 1.0;
            end
         end
    end 
    new_img = im2uint8(hsv2rgb(HSV));
    
end