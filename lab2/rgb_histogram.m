%%show RGB histogram of an image

function rgb_histogram(image)

R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

[yRed, x] = imhist(R);
[yGreen, x] = imhist(G);
[yBlue, x] = imhist(B);
figure;
plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');