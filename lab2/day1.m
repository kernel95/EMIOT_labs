close all


%magari qua proviamo a caricare tutto tipo struttura dati
%image_list_1.dir = dir(fullfile('./misc/', '*.tiff'));
%image_list_2.dir = dir(fullfile('./BSR/BSDS500/data/images/train/', '*.jpg'));
%image_list_3.dir = dir(fullfile('./screenshots/', '*.JPG'));

%creating data structure for analyze the images


%
%stratup data setting
%for index = 1:length(image_list_1.dir)
    
%end

image = imread('screenshots/screenshot4.png');
%[H, W, channels] = size(image); %function of imaging processing packet

%analyze original image
power_original = power_consumption(image);
RGB_distribution(image);

%apply transformation
image_hungry_blue = hungry_blue(image,20);
image_histo_eq = histogram_eq(image);
%here the 3rd transformation

%analyze power consumption of the new images
power_hungry_blue = power_consumption(image_hungry_blue);
power_histo_eq = power_consumption(image_histo_eq);

%compute the difference
difference1_blue = image_difference(image, image_hungry_blue);
difference1_histo = image_difference(image, image_histo_eq);
%compute the distortion in percentage
distortion_blue = distortion(difference1_blue, image);

%show new images after transformation
figure;
imshow(image);
figure;
imshow(image_hungry_blue);
figure;
imshow(image_histo_eq); %this will print image and also histogram of gray equalization



