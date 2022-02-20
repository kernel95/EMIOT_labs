clc
close all

SATURATED = 1;
DISTORTED = 2;

Vdd = 15;

name1 = "misc";
name2 = "BSR";
name3 = "screenshots";


result_struct1 = struct;
result_struct2 = struct;
result_struct3 = struct;
images_list1 = struct;
images_list2 = struct;
images_list3 = struct;

%create data structure one for each folder
images_list1.dir= dir(fullfile("../misc/*.tiff")); %39 images
images_list2.dir = dir(fullfile("../BSR_bsds500/BSR/BSDS500/data/images/train/*.jpg")); %200 images
images_list3.dir = dir(fullfile("../screenshots/*.png")); % 5 images 


%chiamo script auto
[images_list1, result_struct1] = auto_transf_list1(images_list1);
[images_list2, result_struct2] = auto_transf_list2(images_list2);
[images_list3, result_struct3] = auto_transf_list1(images_list3);

%FIGURES FOR POWER SAVINGS
%%
%produce graphs for savings list 1
%bar_graph_savings(images_list1, result_struct1.savings_nocomp_distorted, name1);
bar_graph_savings(images_list1,result_struct1.savings_brightness_saturated, name1);
%bar_graph_savings(images_list1, result_struct1.savings_contrast_saturated, name1);
%bar_graph_savings(images_list1, result_struct1.savings_combined_saturated, name1);


%produce graphs for savings list2
%bar_graph_savings(images_list2, result_struct2.savings_nocomp_saturated, name2);
bar_graph_savings(images_list2,result_struct2.savings_brightness_saturated, name2);
%bar_graph_savings(images_list2, result_struct2.savings_contrast_saturated, name2);
%bar_graph_savings(images_list2, result_struct2.savings_combined_saturated, name2);

%produce graphs for savings list3
%bar_graph_savings(images_list3, result_struct3.savings_nocomp_saturated, name3);  
bar_graph_savings(images_list3,result_struct3.savings_brightness_saturated, name3);
%bar_graph_savings(images_list3, result_struct3.savings_contrast_saturated, name3);
%bar_graph_savings(images_list3, result_struct3.savings_combined_saturated, name3);

%%
%FIGURES FOR DISTORTION
%graphs for distortion list 1

%bar_graph_distortion(images_list1, result_struct1.distortion_nocomp_distorted, name1);
bar_graph_distortion(images_list1, result_struct1.distortion_brightness_distorted, name1);
%bar_graph_distortion(images_list1, result_struct1.distortion_contrast_distorted, name1);
%bar_graph_distortion(images_list1, result_struct1.distortion_combined_distorted, name1);


%graphs for distortion list 2
%bar_graph_distortion(images_list2, result_struct2.distortion_nocomp_distorted, name2);
bar_graph_distortion(images_list2,result_struct2.distortion_brightness_distorted, name2);
%bar_graph_distortion(images_list2, result_struct2.distortion_contrast_distorted, name2);
%bar_graph_distortion(images_list2, result_struct2.distortion_combined_distorted, name2);


%graphs for distortion list 3
%bar_graph_distortion(images_list3, result_struct3.distortion_nocomp_distorted, name3);
bar_graph_distortion(images_list3,result_struct3.distortion_brightness_distorted, name3);
%bar_graph_distortion(images_list3, result_struct3.distortion_contrast_distorted, name3);
%bar_graph_distortion(images_list3, result_struct3.distortion_combined_distorted, name3);

