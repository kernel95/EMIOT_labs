close all
Distortion_constraint = 3;

name1 = "misc";
name2 = "BSR";
name3 = "screenshots";

images_list1 = struct;
images_list2 = struct;
images_list3 = struct;
%create data structure one for each folder
images_list1.dir= dir(fullfile("../misc/*.tiff")); %39 images
images_list2.dir = dir(fullfile("../BSR_bsds500/BSR/BSDS500/data/images/train/*.jpg")); %200 images
images_list3.dir = dir(fullfile("../screenshots/*.png")); % 5 images 

%launch scripts that will fill data structure
%images in misc folder
images_list1 = auto_image_list1(images_list1);
%images in train folder of BSR dataset
images_list2 = auto_image_list2(images_list2);
%screenshots
images_list3 = auto_image_list3(images_list3);


%produce figures for misc
bar_hungry_blue(images_list1, name1);
bar_histo_eq(images_list1, name1);
bar_custom_transformation(images_list1, name1);


%produce figures for BSD dataset
bar_hungry_blue(images_list2, name2);
bar_histo_eq(images_list2, name2);
bar_custom_transformation(images_list2, name2);

%produce figures for screenshots
bar_hungry_blue(images_list3, name3);
bar_histo_eq(images_list3, name3);
bar_custom_transformation(images_list3, name3);

%%
best manipulations for images_list
best_manipulation_under_constraint(Distortion_constraint, images_list1, name1);
best_manipulation_under_constraint(Distortion_constraint, images_list2, name2);
best_manipulation_under_constraint(Distortion_constraint, images_list3, name3);
