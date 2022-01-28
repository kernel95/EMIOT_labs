function structure1 = auto_image_list1(images_list1)

%arrays for list1
images_list1.name = strings(1, length(images_list1)); %create array for names
images_list1.original_power = zeros(1, length(images_list1));
%different tries for different constraints of distortion
%value 1
images_list1.power_hungry_blue1 = zeros(1, length(images_list1));
images_list1.power_histo_eq = zeros(1, length(images_list1));
images_list1.power_custom1 = zeros(1, length(images_list1));

images_list1.differnce_hungry_blue1 = zeros(1, length(images_list1));
images_list1.differnce_histo_eq = zeros(1, length(images_list1));
images_list1.differnce_custom1 = zeros(1, length(images_list1));

images_list1.distortion_hungry_blue1 = zeros(1, length(images_list1));
images_list1.distortion_histo_eq = zeros(1, length(images_list1));
images_list1.distortion_custom1 = zeros(1, length(images_list1));

%value 5
images_list1.power_hungry_blue5 = zeros(1, length(images_list1));
images_list1.power_custom5 = zeros(1, length(images_list1));

images_list1.differnce_hungry_blue5 = zeros(1, length(images_list1));
images_list1.differnce_custom5 = zeros(1, length(images_list1));

images_list1.distortion_hungry_blue5 = zeros(1, length(images_list1));
images_list1.distortion_custom5 = zeros(1, length(images_list1));
%value 10
images_list1.power_hungry_blue10 = zeros(1, length(images_list1));
images_list1.power_custom10 = zeros(1, length(images_list1));

images_list1.differnce_hungry_blue10 = zeros(1, length(images_list1));
images_list1.differnce_custom10 = zeros(1, length(images_list1));

images_list1.distortion_hungry_blue10 = zeros(1, length(images_list1));
images_list1.distortion_custom10 = zeros(1, length(images_list1));

%average
images_list1.average_power_hungry_blue1 = 0;
images_list1.average_power_histo_eq = 0;
images_list1.average_power_custom1 = 0;

images_list1.average_distortion_hungry_blue1 = 0;
images_list1.average_distortion_histo_eq = 0;
images_list1.average_distortion_custom1 = 0;

images_list1.average_power_hungry_blue5 = 0;
images_list1.average_power_custom5 = 0;

images_list1.average_distortion_hungry_blue5 = 0;
images_list1.average_distortion_custom5 = 0;

images_list1.average_power_hungry_blue10 = 0;
images_list1.average_power_custom10 = 0;

images_list1.average_distortion_hungry_blue10 = 0;
images_list1.average_distortion_custom10 = 0;

%savings
images_list1.savings_hungry_blue1 = zeros(1, length(images_list1.power_hungry_blue1));
images_list1.savings_hungry_blue5 = zeros(1, length(images_list1.power_hungry_blue1));
images_list1.savings_hungry_blue10 = zeros(1, length(images_list1.power_hungry_blue1));

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

    images_list1.original_power(k) = power_consumption(image);

    %apply transformations with 1%
    image_hungry_blue = hungry_blue(image,1);
    image_histo_eq = histogram_eq(image);
    image_custom = custom(image, 1);

    %evaluate power after transformations
    images_list1.power_hungry_blue1(k) = power_consumption(image_hungry_blue);
    images_list1.power_histo_eq(k) = power_consumption(image_histo_eq);
    images_list1.power_custom1(k) = power_consumption(image_custom);

    %compute difference
    images_list1.differnce_hungry_blue1(k) = image_difference(image, image_hungry_blue);
    images_list1.differnce_histo_eq(k) = image_difference(image, image_histo_eq);
    images_list1.differnce_custom1(k) = image_difference(image, image_custom);

    %compute distortion
    images_list1.distortion_hungry_blue1(k) = distortion(images_list1.differnce_hungry_blue1(k), image);
    images_list1.distortion_histo_eq(k) = distortion(images_list1.differnce_histo_eq(k), image);
    images_list1.distortion_custom1(k) = distortion(images_list1.differnce_custom1(k), image);  

    %apply transformation with 5%
    image_hungry_blue = hungry_blue(image,5);
    image_custom = custom(image, 5);

    %evaluate power after transformations
    images_list1.power_hungry_blue5(k) = power_consumption(image_hungry_blue);
    images_list1.power_custom5(k) = power_consumption(image_custom);

    %compute difference
    images_list1.differnce_hungry_blue5(k) = image_difference(image, image_hungry_blue);
    images_list1.differnce_custom5(k) = image_difference(image, image_custom);

    %compute distortion
    images_list1.distortion_hungry_blue5(k) = distortion(images_list1.differnce_hungry_blue5(k), image);
    images_list1.distortion_custom5(k) = distortion(images_list1.differnce_custom5(k), image);  

    %apply transformation with 10%
    image_hungry_blue = hungry_blue(image,10);
    image_custom = custom(image, 10);

    %evaluate power after transformations
    images_list1.power_hungry_blue10(k) = power_consumption(image_hungry_blue);
    images_list1.power_custom10(k) = power_consumption(image_custom);

    %compute difference
    images_list1.differnce_hungry_blue10(k) = image_difference(image, image_hungry_blue);
    images_list1.differnce_custom10(k) = image_difference(image, image_custom);

    %compute distortion
    images_list1.distortion_hungry_blue10(k) = distortion(images_list1.differnce_hungry_blue10(k), image);
    images_list1.distortion_custom10(k) = distortion(images_list1.differnce_custom10(k), image);

    %avg power consumption
    %1
    images_list1.average_power_hungry_blue1 = images_list1.average_power_hungry_blue1 + (images_list1.original_power(k) - images_list1.power_hungry_blue1(k));
    images_list1.average_power_histo_eq =  images_list1.average_power_histo_eq + (images_list1.original_power(k) - images_list1.power_histo_eq(k));
    images_list1.average_power_custom1 = images_list1.average_power_custom1 + (images_list1.original_power(k) - images_list1.power_custom1(k));
    %save savings
    images_list1.savings_hungry_blue1(k) = images_list1.original_power(k) - images_list1.power_hungry_blue1(k);
    %5
    images_list1.average_power_hungry_blue5 = images_list1.average_power_hungry_blue5 + (images_list1.original_power(k) - images_list1.power_hungry_blue5(k));
    images_list1.average_power_custom5 = images_list1.average_power_custom5 + (images_list1.original_power(k) - images_list1.power_custom5(k));
    %save savings
    images_list1.savings_hungry_blue5(k) = images_list1.original_power(k) - images_list1.power_hungry_blue5(k);
    %10
    images_list1.average_power_hungry_blue10 = images_list1.average_power_hungry_blue10 + (images_list1.original_power(k) - images_list1.power_hungry_blue10(k));
    images_list1.average_power_custom10 = images_list1.average_power_custom10 + (images_list1.original_power(k) - images_list1.power_custom10(k));
    %save savings
    images_list1.savings_hungry_blue10(k) = images_list1.original_power(k) - images_list1.power_hungry_blue10(k);

    %avg distortion
    %1
    images_list1.average_distortion_hungry_blue1 = images_list1.average_distortion_hungry_blue1 + images_list1.distortion_hungry_blue1(k);
    images_list1.average_distortion_histo_eq = images_list1.average_distortion_histo_eq + images_list1.distortion_histo_eq(k);
    images_list1.average_distortion_custom1 = images_list1.average_distortion_custom1 + images_list1.distortion_custom1(k);
    %5
    images_list1.average_distortion_hungry_blue5 = images_list1.average_distortion_hungry_blue5 + images_list1.distortion_hungry_blue5(k);
    images_list1.average_distortion_custom5 = images_list1.average_distortion_custom5 + images_list1.distortion_custom5(k);
    %10
    images_list1.average_distortion_hungry_blue10 = images_list1.average_distortion_hungry_blue10 + images_list1.distortion_hungry_blue10(k);
    images_list1.average_distortion_custom10 = images_list1.average_distortion_custom5 + images_list1.distortion_custom10(k);

end 

%1 power average
images_list1.average_power_hungry_blue1 = images_list1.average_power_hungry_blue1/k;
images_list1.average_power_histo_eq = images_list1.average_power_histo_eq/k;
images_list1.average_power_custom1 = images_list1.average_power_custom1/k;
%5
images_list1.average_power_hungry_blue5 = images_list1.average_power_hungry_blue5/k;
images_list1.average_power_custom5 = images_list1.average_power_custom5/k;
%10
images_list1.average_power_hungry_blue10 = images_list1.average_power_hungry_blue10/k;
images_list1.average_power_custom10 = images_list1.average_power_custom10/k;
%distortion average
%1
images_list1.average_distortion_hungry_blue1 = images_list1.average_distortion_hungry_blue1/k;
images_list1.average_distortion_histo_eq = images_list1.average_distortion_histo_eq/k;
images_list1.average_distortion_custom1 = images_list1.average_distortion_custom1/k;
%5
images_list1.average_distortion_hungry_blue5 = images_list1.average_distortion_hungry_blue5/k;
images_list1.average_distortion_custom5 = images_list1.average_distortion_custom5/k;
%10
images_list1.average_distortion_hungry_blue10 = images_list1.average_distortion_hungry_blue10/k;
images_list1.average_distortion_custom10 = images_list1.average_distortion_custom10/k;

%plots
x_savings_hungry_blue = [images_list1.average_power_hungry_blue1, images_list1.average_power_hungry_blue5, images_list1.average_power_hungry_blue10];
y_distortion_hungry_blue = [images_list1.average_distortion_hungry_blue1, images_list1.average_distortion_hungry_blue5, images_list1.average_distortion_hungry_blue10];

x_savings_histo_eq = images_list1.average_power_histo_eq;
y_distortion_histo_eq = images_list1.average_distortion_histo_eq;

x_savings_custom = [images_list1.average_power_custom1,images_list1.average_power_custom5,images_list1.average_power_custom10];
y_distortion_custom = [images_list1.average_distortion_custom1 ,images_list1.average_distortion_custom5,images_list1.average_distortion_custom10];

figure1 = figure;
plot(y_distortion_hungry_blue,x_savings_hungry_blue, '-o');
hold on;
plot(y_distortion_histo_eq, x_savings_histo_eq, '-o');
hold on;
plot(y_distortion_custom, x_savings_custom, '-o');
xlabel('AVG DISTORTION [%]');
ylabel('AVG POWER SAVINGS');
legend('Hungry blue', 'Histogram equalization', 'Custom');
saveas(figure1, 'power_vs_distortion1.jpg');

%%
x_name = strings(1, length(images_list1));
y_power_cons_blue1 = zeros(1, length(images_list1.power_hungry_blue1));
y_power_cons_blue5 = zeros(1, length(images_list1.power_hungry_blue5));
y_power_cons_blue10 = zeros(1, length(images_list1.power_hungry_blue10));
y_hungry_blue_total = zeros(1, length(images_list1.power_hungry_blue10)*3);

x_name = categorical(images_list1.name);
x_name = reordercats(x_name);
y_power_cons_blue1 = images_list1.savings_hungry_blue1;
y_power_cons_blue5 = images_list1.savings_hungry_blue5;
y_power_cons_blue10 = images_list1.savings_hungry_blue10;


y_hungry_blue_total = [y_power_cons_blue1 ; y_power_cons_blue5 ; y_power_cons_blue10];
ylabel('POWER SAVINGS');
fig_bar = bar(x_name, y_hungry_blue_total);
l = cell(1,3);
l{1}='1%'; l{2}='5%'; l{3}='10%';
legend(fig_bar,l);
ylabel('SAVINGS HUNGRY BLUE');
%ax = gca;
%exportgraphics(ax, 'power_savings_hungry_blue.jpg', 'resolution',600);


structure1 = images_list1;
end









