clc
close all

SATURATED = 1;
DISTORTED = 2;

Vdd = 15;

name1 = "misc";
%name2 = "BSR";
%name3 = "screenshots";

images_list1 = struct;
result_struct1 = struct;
result_struct2 = struct;
result_struct3 = struct;
%images_list2 = struct;
%images_list3 = struct;

%create data structure one for each folder
images_list1.dir= dir(fullfile("../misc/*.tiff")); %39 images
%images_list2.dir = dir(fullfile("../BSR_bsds500/BSR/BSDS500/data/images/train/*.jpg")); %200 images
%images_list3.dir = dir(fullfile("../screenshots/*.png")); % 5 images 


%chiamo script auto
[images_list1, result_struct1] = auto_transf_list1(images_list1);
%[images_list2, result_struct2] = auto_transf_list1(images_list2);
%[images_list3, result_struct3] = auto_transf_list1(images_list3);


%%
%produce graphs for savings
bar_graph_savings(images_list1, result_struct1.savings_nocomp_saturated, name1);

%%
bar_graph_savings(images_list1,result_struct1.savings_brightness_saturated, name1);

%%
bar_graph_savings(images_list1, result_struct1.savings_contrast_saturated, name1);

%%
bar_graph_savings(images_list1, result_struct1.savings_combined_saturated, name1);

%%
%graphs for distortion



