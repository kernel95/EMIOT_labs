%% load the matrices of pvcell

V_ref = 3.3;

load("gmonths.mat");
load('pvcell_250.mat' );
load('pvcell_500.mat' );
load('pvcell_750.mat' );
load('pvcell_1000.mat');

G = [250; 500; 750; 1000];          % Vector of values of G

run("config.m");

%% find MPP for each line

% create power curve 
for i=1:11
    powerCurve_pvcell_250(i)  = pvcell_250(i, 1)  * pvcell_250(i, 2);
    powerCurve_pvcell_500(i)  = pvcell_500(i, 1)  * pvcell_500(i, 2);
    powerCurve_pvcell_750(i)  = pvcell_750(i, 1)  * pvcell_750(i, 2);
    powerCurve_pvcell_1000(i) = pvcell_1000(i, 1) * pvcell_1000(i, 2);
end

%%
% MPP for each curve
MPP_pvcell_250 = max(powerCurve_pvcell_250);
i_250 = find(powerCurve_pvcell_250==MPP_pvcell_250);
V_250 = pvcell_250(i_250, 1);
I_250 = MPP_pvcell_250 / V_250;

MPP_pvcell_500 = max(powerCurve_pvcell_500);
i_500 = find(powerCurve_pvcell_500==MPP_pvcell_500);
V_500 = pvcell_500(i_500, 1);
I_500 = MPP_pvcell_500 / V_500;

MPP_pvcell_750 = max(powerCurve_pvcell_750);
i_750 = find(powerCurve_pvcell_750==MPP_pvcell_750);
V_750 = pvcell_750(i_750, 1);
I_750 = MPP_pvcell_750 / V_750;

MPP_pvcell_1000 = max(powerCurve_pvcell_1000);
i_1000 = find(powerCurve_pvcell_1000==MPP_pvcell_1000);
V_1000 = pvcell_1000(i_1000, 1);
I_1000 = MPP_pvcell_1000 / V_1000;

I = [I_250; I_500; I_750; I_1000];          % Vector of corresponding values of current at the MPP
V = [V_250; V_500; V_750; V_1000];          % Vector of corresponding values of voltage at the MPP

%% model DC-DC converter of PV module

load('efficiency_pv_dcdc.mat');
efficiency_x = efficiency_pv_dcdc(:,1);
efficiency_y = efficiency_pv_dcdc(:,2); %Already logarithmic scale adjusted

%% DC-DC converter of battery
load('batterydcdc.mat');

%% Battery model
load('battery_1C.mat');
load('battery_2C.mat');

% interpolate the datasets
x_new = (0:0.1:1);

SOC_1_interpolated = interp1(battery_1C(:,1), battery_1C(:,2), x_new);
SOC_1_interpolated = SOC_1_interpolated(2:10);


SOC_2_interpolated = interp1(battery_2C(:,1), battery_2C(:,2), x_new);
SOC_2_interpolated = SOC_2_interpolated(2:10);

load('nico_soc1_interpolated.mat');
load('nico_soc2_interpolated.mat');

%%

I_1 = 3.2 ; %1C = 3200mAh
I_2 = 6.4;  %2C = 6400mAh

x_new = x_new(2:10);
R = (SOC_1_interpolated - SOC_2_interpolated) / (I_2-I_1);
V_oc = SOC_2_interpolated + R * I_2;

%R and V interpolation with Curve Fitting
%call the curve fitting app