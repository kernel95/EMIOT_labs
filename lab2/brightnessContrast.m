function new_img = brightnessContrast (img, b, Vdd, Vdd_mod)

    [H, W, channels] = size(img);   % extract size of img

    gl = -((1 - Vdd/Vdd_mod)/2 * (Vdd_mod/Vdd));
    gu = (b) + gl;
    
    if ( gl > 1 ) 
        gl=1; 
    elseif(gl < 0) 
        gl=0; 
    end
    if (gu > 1) 
        gu=1; 
    elseif(gu < 0) 
        gu=0; 
    end
        
    HSV = rgb2hsv(img);

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