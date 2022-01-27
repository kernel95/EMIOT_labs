clc
clear
close all

images_list1 = dir(fullfile("misc/*.tiff")); %39 images
images_list2 = dir(fullfile("BSR_bsds500/BSR/BSDS500/data/images/train/*.jpg")); %200 images
images_list3 = dir(fullfile("screenshots/*.png")); % 5 images 

%arrays for list1
images1_names1 = strings(1, length(images_list1)); %create array for names
images1_original_power = zeros(1, length(images_list1));
%different tries for different constraints of distortion
%value 1
images1_power_hungry_blue1 = zeros(1, length(images_list1));
images1_power_histo_eq = zeros(1, length(images_list1));
images1_power_custom1 = zeros(1, length(images_list1));

images1_differnce_hungry_blue1 = zeros(1, length(images_list1));
images1_differnce_histo_eq = zeros(1, length(images_list1));
images1_differnce_custom1 = zeros(1, length(images_list1));

images1_distortion_hungry_blue1 = zeros(1, length(images_list1));
images1_distortion_histo_eq = zeros(1, length(images_list1));
images1_distortion_custom1 = zeros(1, length(images_list1));

%value 5
images1_power_hungry_blue5 = zeros(1, length(images_list1));
images1_power_custom5 = zeros(1, length(images_list1));

images1_differnce_hungry_blue5 = zeros(1, length(images_list1));
images1_differnce_custom5 = zeros(1, length(images_list1));

images1_distortion_hungry_blue5 = zeros(1, length(images_list1));
images1_distortion_custom5 = zeros(1, length(images_list1));
%value 10
images1_power_hungry_blue10 = zeros(1, length(images_list1));
images1_power_custom10 = zeros(1, length(images_list1));

images1_differnce_hungry_blue10 = zeros(1, length(images_list1));
images1_differnce_custom10 = zeros(1, length(images_list1));

images1_distortion_hungry_blue10 = zeros(1, length(images_list1));
images1_distortion_custom10 = zeros(1, length(images_list1));

%average
average_power_hungry_blue1 = 0;
average_power_histo_eq = 0;
average_power_custom1 = 0;

average_distortion_hungry_blue1 = 0;
average_distortion_histo_eq = 0;
average_distortion_custom1 = 0;

average_power_hungry_blue5 = 0;
average_power_custom5 = 0;

average_distortion_hungry_blue5 = 0;
average_distortion_custom5 = 0;

average_power_hungry_blue10 = 0;
average_power_custom10 = 0;

average_distortion_hungry_blue10 = 0;
average_distortion_custom10 = 0;

%loop for each image in the folder
for k = 1 : length(images_list1)

    image_path = strcat(images_list1(k).folder, '/', images_list1(k).name);
    images1_names1(k) = images_list1(k).name;
    image = imread(image_path);
    [H, W, channels] = size(image); %function of imaging processing packet

    if channels == 1 %in case the image is in black and white without colors
        image = gray2rgb(image);
        %gray_distribution(image);
    end

    images1_original_power(k) = power_consumption(image);

    %apply transformations with 1%
    image_hungry_blue = hungry_blue(image,1);
    image_histo_eq = histogram_eq(image);
    image_custom = custom(image, 1);

    %evaluate power after transformations
    images1_power_hungry_blue1(k) = power_consumption(image_hungry_blue);
    images1_power_histo_eq(k) = power_consumption(image_histo_eq);
    images1_power_custom1(k) = power_consumption(image_custom);

    %compute difference
    images1_differnce_hungry_blue1(k) = image_difference(image, image_hungry_blue);
    images1_differnce_histo_eq(k) = image_difference(image, image_histo_eq);
    images1_differnce_custom1(k) = image_difference(image, image_custom);

    %compute distortion
    images1_distortion_hungry_blue1(k) = distortion(images1_differnce_hungry_blue1(k), image);
    images1_distortion_histo_eq(k) = distortion(images1_differnce_histo_eq(k), image);
    images1_distortion_custom1(k) = distortion(images1_differnce_custom1(k), image);  

    %apply transformation with 5%
    image_hungry_blue = hungry_blue(image,5);
    image_custom = custom(image, 5);

    %evaluate power after transformations
    images1_power_hungry_blue5(k) = power_consumption(image_hungry_blue);
    images1_power_custom5(k) = power_consumption(image_custom);

    %compute difference
    images1_differnce_hungry_blue5(k) = image_difference(image, image_hungry_blue);
    images1_differnce_custom5(k) = image_difference(image, image_custom);

    %compute distortion
    images1_distortion_hungry_blue5(k) = distortion(images1_differnce_hungry_blue5(k), image);
    images1_distortion_custom5(k) = distortion(images1_differnce_custom5(k), image);  

    %apply transformation with 10%
    image_hungry_blue = hungry_blue(image,10);
    image_custom = custom(image, 10);

    %evaluate power after transformations
    images1_power_hungry_blue10(k) = power_consumption(image_hungry_blue);
    images1_power_custom10(k) = power_consumption(image_custom);

    %compute difference
    images1_differnce_hungry_blue10(k) = image_difference(image, image_hungry_blue);
    images1_differnce_custom10(k) = image_difference(image, image_custom);

    %compute distortion
    images1_distortion_hungry_blue10(k) = distortion(images1_differnce_hungry_blue10(k), image);
    images1_distortion_custom10(k) = distortion(images1_differnce_custom10(k), image);

    %avg power consumption
    %1
    average_power_hungry_blue1 = average_power_hungry_blue1 + (images1_original_power(k) - images1_power_hungry_blue1(k));
    average_power_histo_eq =  average_power_histo_eq + (images1_original_power(k) - images1_power_histo_eq(k));
    average_power_custom1 = average_power_custom1 + (images1_original_power(k) - images1_power_custom1(k));
    %5
    average_power_hungry_blue5 = average_power_hungry_blue5 + (images1_original_power(k) - images1_power_hungry_blue5(k));
    average_power_custom5 = average_power_custom5 + (images1_original_power(k) - images1_power_custom5(k));
    %10
    average_power_hungry_blue10 = average_power_hungry_blue10 + (images1_original_power(k) - images1_power_hungry_blue10(k));
    average_power_custom10 = average_power_custom10 + (images1_original_power(k) - images1_power_custom10(k));

    %avg distortion
    %1
    average_distortion_hungry_blue1 = average_distortion_hungry_blue1 + images1_distortion_hungry_blue1(k);
    average_distortion_histo_eq = average_distortion_histo_eq + images1_distortion_histo_eq(k);
    average_distortion_custom1 = average_distortion_custom1 + images1_distortion_custom1(k);
    %5
    average_distortion_hungry_blue5 = average_distortion_hungry_blue5 + images1_distortion_hungry_blue5(k);
    average_distortion_custom5 = average_distortion_custom5 + images1_distortion_custom5(k);
    %10
    average_distortion_hungry_blue10 = average_distortion_hungry_blue10 + images1_distortion_hungry_blue10(k);
    average_distortion_custom10 = average_distortion_custom5 + images1_distortion_custom10(k);


end 

%1 power average
average_power_hungry_blue1 = average_power_hungry_blue1/k;
average_power_histo_eq = average_power_histo_eq/k;
average_power_custom1 = average_power_custom1/k;
%5
average_power_hungry_blue5 = average_power_hungry_blue5/k;
average_power_custom5 = average_power_custom5/k;
%10
average_power_hungry_blue10 = average_power_hungry_blue10/k;
average_power_custom10 = average_power_custom10/k;
%distortion average
%1
average_distortion_hungry_blue1 = average_distortion_hungry_blue1/k;
average_distortion_histo_eq = average_distortion_histo_eq/k;
average_distortion_custom1 = average_distortion_custom1/k;
%5
average_distortion_hungry_blue5 = average_distortion_hungry_blue5/k;
average_distortion_custom5 = average_distortion_custom5/k;
%10
average_distortion_hungry_blue10 = average_distortion_hungry_blue10/k;
average_distortion_custom10 = average_distortion_custom10/k;


x_savings_hungry_blue = [average_power_hungry_blue1, average_power_hungry_blue5, average_power_hungry_blue10];
y_distortion_hungry_blue = [average_distortion_hungry_blue1, average_distortion_hungry_blue5, average_distortion_hungry_blue10];

x_savings_histo_eq = average_power_histo_eq;
y_distortion_histo_eq = average_distortion_histo_eq;

x_savings_custom = [average_power_custom1,average_power_custom5,average_power_custom10];
y_distortion_custom = [average_distortion_custom1 ,average_distortion_custom5,average_distortion_custom10];


%%
figure;
plot(y_distortion_hungry_blue,x_savings_hungry_blue, '-o');
hold on;
plot(y_distortion_histo_eq, x_savings_histo_eq, '-o');
hold on;
plot(y_distortion_custom, x_savings_custom, '-o');
xlabel('AVG DISTORTION [%]');
ylabel('AVG POWER CONSUMPTION');
legend('Hungry blue', 'Histogram equalization', 'Custom');










