close all

image = imread("misc\4.2.05.tiff");
[H, W, channels] = size(image);

image_hungry_blue = hungry_blue(image,5);
image_histo_eq = histogram_eq(image);
image_custom = custom(image, 5);


