clc
close all

SATURATED = 1;
DISTORTED = 2;

Vdd = 15;
Vdd_mod = 12;

image = imread("../misc/4.1.01.tiff");
[H, W, channels] = size(image); %function of imaging processing packet

if channels == 1 %in case the image is in black and white without colors
    image = gray2rgb(image);
    %gray_distribution(image);
end


b = (100 - ((100*Vdd_mod)/Vdd))/100; %calculation of b

current_original = Ipanel(image, Vdd);
current_power = Ppanel(current_original,Vdd,image);

temp_dvs_image_sat = displayed_image(current_original,Vdd_mod,1);
temp_dvs_image_dist = displayed_image(current_original,Vdd_mod,2);

image_brightness_scaling = brightness_scaling(image,b);
current_brightness = Ipanel(image_brightness_scaling,Vdd_mod);
temp_brightness_sat = displayed_image(current_brightness,Vdd_mod,1);
temp_brightness_dist = displayed_image(current_brightness,Vdd_mod,2);
power_brigthness = Ppanel(current_brightness,Vdd_mod,image_brightness_scaling);

image_contrast_scaling = contrast_enhancement(image,b);
current_contrast = Ipanel(image_contrast_scaling, Vdd_mod);
temp_contrast_sat = displayed_image(current_contrast,Vdd_mod,1);
temp_contrast_dist = displayed_image(current_contrast,Vdd_mod,2);

image_combined = brightnessContrast(image,b,Vdd,Vdd_mod);
current_combined = Ipanel(image_combined,Vdd_mod);
temp_combined_sat = displayed_image(current_combined,Vdd_mod,1);
temp_combined_dist = displayed_image(current_combined,Vdd_mod,2);


figure;
imshow(image); %original
%figure;
%imshow(temp_dvs_image_sat/255);
%figure;
%imshow(temp_dvs_image_dist/255);
figure;
imshow(temp_brightness_sat/255);
figure;
imshow(temp_brightness_dist/255);
figure;
imshow(temp_contrast_sat/255);
figure;
imshow(temp_contrast_dist/255);
figure;
imshow(temp_combined_sat/255);
figure;
imshow(temp_combined_dist/255);
