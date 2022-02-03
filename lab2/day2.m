close all

SATURATED = 1;
DISTORTED = 2;

name1 = "misc";
%name2 = "BSR";
%name3 = "screenshots";
Vdd = 12;

%images_list1 = struct;
%images_list2 = struct;
%images_list3 = struct;
%create data structure one for each folder
%images_list1.dir= dir(fullfile("../misc/*.tiff")); %39 images
%images_list2.dir = dir(fullfile("BSR_bsds500/BSR/BSDS500/data/images/train/*.jpg")); %200 images
%images_list3.dir = dir(fullfile("screenshots/*.png")); % 5 images 

%image_path = strcat(images_list1.dir(1).folder, '/', images_list1.dir(1).name);
%images_list1.name(1) = images_list1.dir(1).name;
image2 = imread("misc/4.1.01.tiff");
%[H, W, channels] = size(image);


I = Ipanel(image2, Vdd);
P = Ppanel(I, Vdd, image2);

image_RGB_saturated = displayed_image(I, Vdd, SATURATED);
image_RGB_distorted = displayed_image(I, Vdd, DISTORTED);

diff1 = image_difference(image_RGB_saturated, image2);
diff2 = image_difference(image_RGB_distorted, image2);

%figure;
%imshow(image_RGB_distorted/255);
%figure;
%imshow(image_RGB_saturated/255);

%figure;
%subplot(2,1,1)
figure;
image(image_RGB_saturated/255);       % display saturated RGB image
%subplot(2,1,2)
figure;
image(image_RGB_distorted/255);       % display distorted RGB image
