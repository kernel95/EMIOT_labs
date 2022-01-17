%%
% section 1 analysis and value extraction from an image
clear all
close all

image1 = imread('screenshots/screenshot4.png');
%image2 = imread('screenshots/screenshot2.png');
%image3 = imread('screenshots/screenshot3.png');
%image4 = imread('screenshots/screenshot4.png');
%image5 = imread('screenshots/screenshot5.png');

% given in the PDF lab2

y = 0.7755;
w0 = 1.48169521e-6;
wr = 2.13636845e-7;
wg = 1.77746705e-7;
wb = 2.14348309e-7;

%%
%search for RGB values of the images

R = image1(:,:,1);
G = image1(:,:,2);
B = image1(:,:,3);
P = zeros(65536,1);
[yRed, x] = imhist(R);
[yGreen, x] = imhist(G);
[yBlue, x] = imhist(B);
p = plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');

for i = 1 : (length(image1(:,1,1)))
        for j = 1 : (length(image1(1,:,1)))
            R_component = double(R(i,j));
            G_component = double(G(i,j));
            B_component = double(B(i,j));
            index = i.*255 + j;
            P(index) = (wr * (R_component .^ y)) + (wg * (G_component .^ y)) + (wb * (B_component .^ y));
        end
end

P1 = sum(P) + w0;
