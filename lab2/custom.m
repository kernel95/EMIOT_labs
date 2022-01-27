%% luminance reduction 
function new_img = custom(img, reduction_percentage)
    
    if reduction_percentage < 0 || reduction_percentage > 100
        error("ERROR: the percentage should be between 0 and 100!!! \n"); 
    end
    
    %figure;
    %imhist(img);
    %imshow(img);

     % picture dimension
    height = length(img(:, 1, 1));
    width  = length(img(1, :, 1));

    new_blue = img;
    new_img = histeq(new_blue); %modifica necessaria

    %figure;
    %imhist(new_img);
    %imshow(new_img);
    
    % newblue = oldvalue - oldvalue*percentage/100;
    for i = 1 : height
        for j = 1 : width
            new_img(i,j,3) = (double(new_img(i,j,3)) - ((double(new_img(i,j,3)) * reduction_percentage)/100));
        end
    end

    %figure;
    %imhist(new_img);
    %imshow(new_img);


end