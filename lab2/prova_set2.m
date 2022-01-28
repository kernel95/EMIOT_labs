
image = imread("BSR_bsds500\BSR\BSDS500\data\images\train\100080.jpg");

[H, W, channels] = size(image);

if channels == 1
    image = gray2rgb(image);
end

original_power = power_consumption(image);

%transf
image_blue = hungry_blue(image, 20);
histo_image = histogram_eq(image);
custom_image = custom(image,20);

blue_differnce = image_difference(image, image_blue);
histo_difference = image_difference(image, histo_image);
custom_difference = image_difference(image, custom_image);

blue_distortion = distortion(blue_differnce, image);
histo_distortion = distortion(histo_difference, image);
custom_distortion = distortion(custom_difference, image);