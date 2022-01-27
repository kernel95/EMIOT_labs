%% luminance reduction 
function new_img = custom(img, reduction_percentage)
    
    if reduction_percentage < 0 || reduction_percentage > 100
        error("ERROR: the percentage should be between 0 and 100!!! \n"); 
    end

     % picture dimension
    height = length(img(:, 1, 1));
    width  = length(img(1, :, 1));

    new_blue = img;
    
    % newblue = oldvalue - oldvalue*percentage/100;
    for i = 1 : height
        for j = 1 : width
            new_blue(i,j,3) = (double(new_blue(i,j,3)) - ((double(new_blue(i,j,3)) * reduction_percentage)/100));
        end
    end

    new_green = new_blue;
    
    % new_green = oldvalue - oldvalue*percentage/100;
    for i = 1 : height
        for j = 1 : width
            new_green(i,j,2) = (double(new_green(i,j,2)) - ((double(new_green(i,j,2)) * reduction_percentage)/100));
        end
    end

    new_red = new_green;
    
    % new_red = oldvalue - oldvalue*percentage/100;
    for i = 1 : height
        for j = 1 : width
            new_red(i,j,1) = (double(new_red(i,j,1)) - ((double(new_red(i,j,1)) * reduction_percentage)/100));
        end
    end

    new_img = new_red;
end