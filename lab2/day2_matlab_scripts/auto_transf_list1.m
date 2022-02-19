function [structure1,results_struct] = auto_transf_list1(images_list1)

% Constant Parameters
p1 = +4.251e-5;
p2 = -3.029e-4;
p3 = +3.024e-5;
Vdd= 15;
%Vdd_interval = Vdd:-0.3:Vdd/1.5;
SATURATED = 1;
DISTORTED = 2;

%
%arrays for list1
images_list1.name = strings(1, length(images_list1.dir)); 
images_list1.original_power = zeros(1, length(images_list1.dir));   

results = struct;
%array for results
results.savings_nocomp_saturated = zeros(39, 5);
results.savings_nocomp_distorted = zeros(39, 5);
results.distortion_nocomp_saturated = zeros(39,5);
results.distortion_nocomp_distorted = zeros(39,5);

results.savings_brightness_saturated = zeros(39, 5);
results.savings_brightness_distorted = zeros(39, 5);
results.distortion_brightness_saturated = zeros(39,5);
results.distortion_brightness_distorted = zeros(39,5);

results.savings_contrast_saturated = zeros(39, 5);
results.savings_contrast_distorted = zeros(39, 5);
results.distortion_contrast_saturated = zeros(39,5);
results.distortion_contrast_distorted = zeros(39,5);

results.savings_combined_saturated = zeros(39, 5);
results.savings_combined_distorted = zeros(39, 5);
results.distortion_combined_saturated = zeros(39,5);
results.distortion_combined_distorted = zeros(39,5);


index2 = 1;
%loop for each image in the folder
    for k = 1 : length(images_list1.dir)

        image_path = strcat(images_list1.dir(k).folder, '/', images_list1.dir(k).name);
        images_list1.name(k) = images_list1.dir(k).name;
        image = imread(image_path);
        [H, W, channels] = size(image); %function of imaging processing packet

        if channels == 1 %in case the image is in black and white without colors
          image = gray2rgb(image);
          %gray_distribution(image);
        end

        %evaluate Ipanel and Ppanel for each image when original
        images_list1.IPanel_original(k).Ipanel = Ipanel(image, Vdd);
        images_list1.Ppanel_original(k) = Ppanel(images_list1.IPanel_original(k).Ipanel, Vdd, image);
        
        index = 1;
        %for each variation of Vdd between 8 and 14
        for Vdd_mod = 10:1:14
            %evaluate b for scaling of Vdd
            b = (100 - ((100*Vdd_mod)/Vdd))/100; %calculation of b

            %ORIGINAL ONLY DVS
            temp_image_saturated = displayed_image(images_list1.IPanel_original(k).Ipanel,Vdd,SATURATED);
            temp_image_distorted = displayed_image(images_list1.IPanel_original(k).Ipanel,Vdd,DISTORTED);
            %evaluate power
            images_list1.Ppanel_image_original_saturated(k).transf(index).power_panel = Ppanel(images_list1.IPanel_original(k).Ipanel, Vdd_mod, temp_image_saturated);
            images_list1.Ppanel_image_original_distorted(k).transf(index).power_panel = Ppanel(images_list1.IPanel_original(k).Ipanel, Vdd_mod, temp_image_distorted);
            %evaluate savings
            images_list1.savings_DVS_only_saturated(k).transf(index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_image_original_saturated(k).transf(index).power_panel);
            images_list1.savings_DVS_only_distorted(k).transf(index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_image_original_distorted(k).transf(index).power_panel);
            %
            results.savings_nocomp_saturated(k, index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_image_original_saturated(k).transf(index).power_panel);
            results.savings_nocomp_distorted(k, index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_image_original_distorted(k).transf(index).power_panel);
            %evaluate distortion
            images_list1.differnce_DVS_only_saturated(k).transf(index) = double(image_difference(image, temp_image_saturated));
            images_list1.distortion_DVS_only_saturated(k).transf(index) = double(distortion(images_list1.differnce_DVS_only_saturated(k).transf(index), image));
            images_list1.differnce_DVS_only_distorted(k).transf(index) = double(image_difference(image, temp_image_distorted));
            images_list1.distortion_DVS_only_distorted(k).transf(index) = double(distortion(images_list1.differnce_DVS_only_distorted(k).transf(index), image));
            %
            results.distortion_nocomp_saturated(k, index) = double(distortion(images_list1.differnce_DVS_only_saturated(k).transf(index), image));
            results.distortion_nocomp_distorted(k, index) = double(distortion(images_list1.differnce_DVS_only_distorted(k).transf(index), image));

            %COMEPNSATIONS
            %apply Brightness compensation
            image_brightness_scaling = brightness_scaling(image,b); %come gestiamo b? 15% compensare
            images_list1.Ipanel_brightness_scaling(k).transf(index).Ipanel = Ipanel(image_brightness_scaling,Vdd_mod);
            %apply DVS
            temp_image_saturated = displayed_image(images_list1.Ipanel_brightness_scaling(k).transf(index).Ipanel,Vdd,SATURATED);
            temp_image_distorted = displayed_image(images_list1.Ipanel_brightness_scaling(k).transf(index).Ipanel,Vdd,DISTORTED);
            %evaluate power
            images_list1.Ppanel_brightness_scaling_saturated(k).transf(index).power_panel = Ppanel(images_list1.Ipanel_brightness_scaling(k).transf(index).Ipanel,Vdd_mod, temp_image_saturated);
            images_list1.Ppanel_brightness_scaling_distorted(k).transf(index).power_panel = Ppanel(images_list1.Ipanel_brightness_scaling(k).transf(index).Ipanel,Vdd_mod, temp_image_distorted);
            %evaluate savings
            images_list1.savings_brightness_scaling_saturated(k).transf(index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_brightness_scaling_saturated(k).transf(index).power_panel);
            images_list1.savings_brightness_scaling_distorted(k).transf(index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_brightness_scaling_distorted(k).transf(index).power_panel);
            %
            results.savings_brightness_saturated(k, index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_brightness_scaling_saturated(k).transf(index).power_panel);
            results.savings_brightness_distorted(k, index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_brightness_scaling_distorted(k).transf(index).power_panel);
            %evaluate distortion
            images_list1.differnce_brightness_scaling_saturated(k).transf(index) = double(image_difference(image, temp_image_saturated));
            images_list1.distortion_brightness_scaling_saturated(k).transf(index) = double(distortion(images_list1.differnce_brightness_scaling_saturated(k).transf(index), image));
            images_list1.differnce_brightness_scaling_distorted(k).transf(index) = double(image_difference(image, temp_image_distorted));
            images_list1.distortion_brightness_scaling_distorted(k).transf(index) = double(distortion(images_list1.differnce_brightness_scaling_distorted(k).transf(index), image));
            %
            results.distortion_brightness_saturated(k, index) = double(distortion(images_list1.differnce_brightness_scaling_saturated(k).transf(index), image));
            results.distortion_brightness_distorted(k, index) = double(distortion(images_list1.differnce_brightness_scaling_distorted(k).transf(index), image));

            %apply contrast enhancement
            image_contrast_enhancement = contrast_enhancement(image,b);
            images_list1.Ipanel_contrast_enhancement(k).transf(index).Ipanel = Ipanel(image_contrast_enhancement, Vdd_mod);
            %apply DVS
            temp_image_saturated = displayed_image(images_list1.Ipanel_contrast_enhancement(k).transf(index).Ipanel,Vdd,SATURATED);
            temp_image_distorted = displayed_image(images_list1.Ipanel_contrast_enhancement(k).transf(index).Ipanel,Vdd,DISTORTED);
            %evaluate power
            images_list1.Ppanel_contrast_enhancement_saturated(k).transf(index).power_panel = Ppanel(images_list1.Ipanel_contrast_enhancement(k).transf(index).Ipanel, Vdd_mod, temp_image_saturated);
            images_list1.Ppanel_contrast_enhancement_distorted(k).transf(index).power_panel = Ppanel(images_list1.Ipanel_contrast_enhancement(k).transf(index).Ipanel, Vdd_mod, temp_image_distorted);
            %evaluate savings
            images_list1.savings_contrast_enhancement_saturated(k).transf(index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_contrast_enhancement_saturated(k).transf(index).power_panel);
            images_list1.savings_contrast_enhancement_distorted(k).transf(index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_contrast_enhancement_distorted(k).transf(index).power_panel);
            %
            results.savings_contrast_saturated(k, index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_contrast_enhancement_saturated(k).transf(index).power_panel);
            results.savings_contrast_distorted(k, index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_contrast_enhancement_distorted(k).transf(index).power_panel);
            %evaluate distortion
            images_list1.differnce_contrast_enhancement_saturated(k).transf(index) = double(image_difference(image, temp_image_saturated));
            images_list1.distortion_contrast_enhancement_saturated(k).transf(index) = double(distortion(images_list1.differnce_contrast_enhancement_saturated(k).transf(index), image));
            images_list1.differnce_contrast_enhancement_distorted(k).transf(index) = double(image_difference(image, temp_image_distorted));
            images_list1.distortion_contrast_enhancement_distorted(k).transf(index) = double(distortion(images_list1.differnce_contrast_enhancement_distorted(k).transf(index), image));            
            %
            results.distortion_contrast_saturated(k, index) = double(distortion(images_list1.differnce_contrast_enhancement_saturated(k).transf(index), image));
            results.distortion_contrast_distorted(k, index) = double(distortion(images_list1.differnce_contrast_enhancement_distorted(k).transf(index), image));

            %apply combined compensation
            image_combined = brightnessContrast(image,b,Vdd,Vdd_mod);
            images_list1.Ipanel_combined(k).transf(index).Ipanel = Ipanel(image_combined, Vdd_mod);
            %apply DVS
            temp_image_saturated = displayed_image(images_list1.Ipanel_combined(k).transf(index).Ipanel,Vdd,SATURATED);
            temp_image_distorted = displayed_image(images_list1.Ipanel_combined(k).transf(index).Ipanel,Vdd,DISTORTED);
            %evaluate power
            images_list1.Ppanel_combined_saturated(k).transf(index).power_panel = Ppanel(images_list1.Ipanel_combined(k).transf(index).Ipanel, Vdd_mod, temp_image_saturated);
            images_list1.Ppanel_combined_distorted(k).transf(index).power_panel = Ppanel(images_list1.Ipanel_combined(k).transf(index).Ipanel, Vdd_mod, temp_image_distorted);
            %evaluate savings
            images_list1.savings_combined_saturated(k).transf(index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_combined_saturated(k).transf(index).power_panel);
            images_list1.savings_combined_distorted(k).transf(index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_combined_distorted(k).transf(index).power_panel);
            results.savings_combined_saturated(k, index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_combined_saturated(k).transf(index).power_panel);
            results.savings_combined_distorted(k, index) = double(images_list1.Ppanel_original(k) - images_list1.Ppanel_combined_distorted(k).transf(index).power_panel);
            %evaluate distortion
            images_list1.differnce_combined_saturated(k).transf(index) = double(image_difference(image, temp_image_saturated));
            images_list1.distortion_combined_saturated(k).transf(index) = double(distortion(images_list1.differnce_combined_saturated(k).transf(index), image));
            images_list1.differnce_combined_distorted(k).transf(index) = double(image_difference(image, temp_image_distorted));
            images_list1.distortion_combined_distorted(k).transf(index) = double(distortion(images_list1.differnce_combined_distorted(k).transf(index), image));
            %
            results.distortion_combined_saturated(k, index) = double(distortion(images_list1.differnce_combined_saturated(k).transf(index), image));
            results.distortion_combined_distorted(k, index) = double(distortion(images_list1.differnce_combined_distorted(k).transf(index), image));
     
            index = index + 1;
            
            %Vdd_mod

        end
        index2 = index2 + 1
    end
    results_struct = results;
    %return the struct
    structure1 = images_list1;

end