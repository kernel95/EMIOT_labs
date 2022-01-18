
figure;
image = imread('..\Tina\BB8-robot-Star-Wars_3840x2160.jpg');
imshow(image);

figure;
result = hungry_blue(image,100);
imshow(result);

figure;
result_hsv = histogram_equalization(image, 100);
imshow(result_hsv);

figure;
result_hsv2 = histogram_eq(image);
imshow(result_hsv2);

% Blue - most costly component : function to reduce its value
% takes as input the image to manipulate and the desired reduction percentage 

function new_img = hungry_blue(img, reduction_percentage)

    if reduction_percentage < 0 || reduction_percentage > 100
        error("ERROR: the percentage should be between 0 and 100!!! \n"); 
    end

    % picture dimension
    height = length(img(:, 1, 1));
    width  = length(img(1, :, 1));

    new_img = img;
    
    % newblue = oldvalue - oldvalue*percentage/100;
    for i = 1 : height
        for j = 1 : width
            new_img(i,j,3) = (double(new_img(i,j,3)) - ((double(new_img(i,j,3)) * reduction_percentage)/100));
        end
    end
end

%% luminance reduction
function new_img = histogram_equalization(img, reduction_percentage)

     if reduction_percentage < 0 || reduction_percentage > 100
        error("ERROR: the percentage should be between 0 and 100!!! \n"); 
     end

     % picture dimension
     height = length(img(:, 1, 1));
     width  = length(img(1, :, 1));

     HSV_img = rgb2hsv(img);
     
     new_img = HSV_img;

     for i = 1 : height
        for j = 1 : width
            new_img(i,j,3) = (double(new_img(i,j,3)) - ((double(new_img(i,j,3)) * reduction_percentage)/100));
        end
    end
end

%% luminance reduction pt 2
function hist_eq_img = histogram_eq(img)
    hist_eq_img = histeq(img);
end