clear
clc
close all

images_list1 = struct;
images_list2 = struct;
images_list3 = struct;
%create data structure one for each folder
images_list1.dir= dir(fullfile("misc/*.tiff")); %39 images
images_list2.dir = dir(fullfile("BSR_bsds500/BSR/BSDS500/data/images/train/*.jpg")); %200 images
images_list3.dir = dir(fullfile("screenshots/*.png")); % 5 images 

%launch scripts that will fill data structure
images_list1 = auto_image_list1(images_list1);

%images_list2 = auto_image_list2(images_list2);

%images_list3 = auto_image_list3(images_list3);
