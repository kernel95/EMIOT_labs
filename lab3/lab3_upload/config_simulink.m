%run this script to load variables in simulink

%read data from image with digitizer
%imread("PVcell\datasheet.bmp");
%digitizer();

load('gmonths.mat');
G = [250; 500; 750; 1000];
I = [];
V = [];


load('pvcell_250.mat');
load('pvcell_500.mat');
load('pvcell_750.mat');
load('pvcell_1000.mat');