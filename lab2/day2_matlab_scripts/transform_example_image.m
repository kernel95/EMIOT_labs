clc
close all

% Constant Parameters
p1 = +4.251e-5;
p2 = -3.029e-4;
p3 = +3.024e-5;
Vdd= 15;
%Vdd_interval = Vdd:-0.3:Vdd/1.5;
SATURATED = 1;
DISTORTED = 2;

Vdd = 15;

image = imread("../misc/4.2.05.tiff");
figure;
imshow(image)

%evaluate Ipanel and Ppanel for the image when original
current = Ipanel(image, Vdd);

%for each variation of Vdd between 8 and 14
    for Vdd_mod = 1:1:14
        %evaluate b for scaling of Vdd
        b = (100 - ((100*Vdd_mod)/Vdd))/100; %calculation of b

        %ORIGINAL ONLY DVS
        temp_image_saturated = displayed_image(current,Vdd,SATURATED);
        figure;
        imshow(temp_image_saturated/255)
        temp_image_distorted = displayed_image(current,Vdd,DISTORTED);
        figure;
        imshow(temp_image_distorted/255)
        
        %COMEPNSATIONS
        %apply Brightness compensation
        image_brightness_scaling  = brightness_scaling(image,b); 
        Ipanel_brightness_scaling = Ipanel(image_brightness_scaling,Vdd_mod);
        %apply DVS
        temp_image_saturated = displayed_image(Ipanel_brightness_scaling,Vdd,SATURATED);
        figure;
        imshow(temp_image_saturated/255)
        temp_image_distorted = displayed_image(Ipanel_brightness_scaling,Vdd,DISTORTED);
        figure;
        imshow(temp_image_distorted/255)

        %apply contrast enhancement
        image_contrast_enhancement  = contrast_enhancement(image,b);
        Ipanel_contrast_enhancement = Ipanel(image_contrast_enhancement, Vdd_mod);
        %apply DVS
        temp_image_saturated = displayed_image(Ipanel_contrast_enhancement,Vdd,SATURATED);
        figure;
        imshow(temp_image_saturated/255)
        temp_image_distorted = displayed_image(Ipanel_contrast_enhancement,Vdd,DISTORTED);
        figure;
        imshow(temp_image_distorted/255)

         %apply combined compensation
         image_combined = brightnessContrast(image,b,Vdd,Vdd_mod);
         Ipanel_combined = Ipanel(image_combined, Vdd_mod);
         %apply DVS
         temp_image_saturated = displayed_image(Ipanel_combined,Vdd,SATURATED);
         figure;
         imshow(temp_image_saturated/255)
         temp_image_distorted = displayed_image(Ipanel_combined,Vdd,DISTORTED);
         figure;
         imshow(temp_image_distorted/255)

    end



