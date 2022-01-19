% image distance(i.e. difference) calculation

function Difference = image_difference(image1, image2)
    
    image1_lab = rgb2lab(image1);
    image2_lab = rgb2lab(image2);

    L_1 = image1_lab(:,:,1);
    a_1 = image1_lab(:,:,2);
    b_1 = image1_lab(:,:,3);

    L_2 = image2_lab(:,:,1);
    a_2 = image2_lab(:,:,2);
    b_2 = image2_lab(:,:,3);

    
    Difference = 0;
    for index = 1 : ((length(image1(:,1,1))) * (length(image2(:,1,1))))
        L_diff = (L_1(index) - L_2(index)).^2;
        a_diff = (a_1(index) - a_2(index)).^2;
        b_diff = (b_1(index) - b_2(index)).^2;
        
        Difference = Difference + sqrt(L_diff + a_diff + b_diff);
    end
end