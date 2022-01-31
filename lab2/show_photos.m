close all

image = imread("misc\4.2.05.tiff");
[H, W, channels] = size(image);

figure0 = figure;
imshow(image);
saveas(figure0, 'figures/Original_photo.jpg');

image_hungry_blue = hungry_blue(image,5);
image_histo_eq = histogram_eq(image);
image_custom = custom(image, 5);


