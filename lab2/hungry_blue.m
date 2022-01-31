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

    %figure1 = figure;
    %imshow(new_img);
    %saveas(figure1, 'figures/HungryBlue_manipulation_result.jpg');
end