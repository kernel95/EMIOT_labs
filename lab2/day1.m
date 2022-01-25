close all


%magari qua proviamo a caricare tutto tipo struttura dati
%image_list_1.dir = dir(fullfile('./misc/', '*.tiff'));
%image_list_2.dir = dir(fullfile('./BSR/BSDS500/data/images/train/', '*.jpg'));
%image_list_3.dir = dir(fullfile('./screenshots/', '*.JPG'));

image = imread('screenshots/screenshot4.png');
[H, W, channels] = size(image); %function of imaging processing packet

power_original = power_consumption(image);
RGB_distribution(image);

image_hungry_blue = hungry_blue(image,20);
image_histo_eq = histogram_eq(image);

power_hungry_blue = power_consumption(image_hungry_blue);
power_histo_eq = power_consumption(image_histo_eq);

difference1_blue = image_difference(image, image_hungry_blue);
difference1_histo = image_difference(image, image_histo_eq);



distortion_blue = distortion(difference1_blue, H, W);
%distortion_histo = distortion2(image, image_histo_eq);

figure;
imshow(image);
figure;
imshow(image_hungry_blue);
figure;
imshow(image_histo_eq);



