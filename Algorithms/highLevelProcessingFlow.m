%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

%% Run this script at "Algorithms" Folder


%% Modify all necessary directories and files
%--------------------------------------------------------------------------
% Path for the adcBinData
experiment_folderName = '..\RecordedData_Example\20190523_smallPlatform_scissorsInBox_400By400';
adcBinData_subFolderName = 'data1';

% Path for the Calibration Data (and optional Background radiation)
calData_fileName = '.\calibration\calData\calData_3Tx_4Rx.mat';
delayOffset_fileName = '.\calibration\calData\delayOffset_3Tx_4Rx.mat';

%% Automated folder and file name generation
%--------------------------------------------------------------------------
addpath(genpath(pwd));
% addpath(genpath('C:\Users\mey160030\Box Sync\TISyncFolder\_TI_SAR_Software_Package_xWR1xxx_AMC4030\Algorithms'))

% Load sensorParams and sarParams
load(fullfile(experiment_folderName,adcBinData_subFolderName,'sensorParams'));
load(fullfile(experiment_folderName,adcBinData_subFolderName,'sarParams'));

% Load calData and delayOffset
load(fullfile(calData_fileName));
load(fullfile(delayOffset_fileName));

% Configure the ADC Bin Data Path
adcBinData_folderName = fullfile(experiment_folderName,adcBinData_subFolderName);

%% Mean Target z-Distance
zTarget_mm = 250; % update the distance as needed.

%% Data Read Function call
%--------------------------------------------------------------------------
[rawData,sarParams,sensorParams] = dataReadFunction(sensorParams,sarParams,adcBinData_folderName);
% rawData Format:
% (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Samples_per_Chirp;
% sarParams and sensorParams may be updated because of data rearrangement process


%% Remove Background Radiation (Optional) and Calibrate Data
%--------------------------------------------------------------------------
% load(fullfile(backgroundRadiation_fileName));
% rawData = rawData - rawDataBackground;

%% Calibrate rawData
%--------------------------------------------------------------------------
% rawData format should be: (Num_RX x Num_TX) x Num_verticalScan x Num_horizontalScan x Samples_per_Chirp;
rawDataCal = calibrateDataFunction(rawData,sensorParams,calData,delayOffset);


%% Define Parameters
%--------------------------------------------------------------------------
frequency = [sensorParams.Start_Freq_GHz*1e9,sensorParams.Slope_MHzperus*1e12,sensorParams.Sampling_Rate_ksps*1e3,sensorParams.Adc_Start_Time_us*1e-6];
c = physconst('lightspeed');
Samples_per_Chirp = sensorParams.Samples_per_Chirp;
Num_TX = sensorParams.Num_TX;
Num_RX = length(sensorParams.RxToEnable);
Num_horizontalScan = sarParams.Num_horizontalScan;
Num_verticalScan = sarParams.Num_verticalScan;
yStepM_mm = sarParams.Vertical_stepSize_mm;
if (Num_horizontalScan~=1)
    if(sarParams.Horizontal_stepSize_mm == 0)
        % for AMC4030 measurements
        xStepM_mm = sarParams.Platform_Speed_mmps * sensorParams.Frame_Repetition_Period_ms*1e-3;
        % for ESP32 based measurements
        % xStepM_mm = (sarParams.Horizontal_scanSize_mm)/(Num_horizontalScan-1);
    else
        xStepM_mm = sarParams.Horizontal_stepSize_mm;
    end
else
    xStepM_mm = 0;
end
lambda_mm = c/79e9*1e3; %  % center frequency


%% Convert multistatic data to monostatic version
%--------------------------------------------------------------------------
% rawData format should be: (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Samples_per_Chirp;
[~,rawDataMonostatic] = convertMultistaticToMonostatic(rawDataCal,frequency,xStepM_mm,yStepM_mm,zTarget_mm,'IWR1443',ones(1,Num_TX),ones(1,Num_RX));


%% Make Uniform Virtual Array
%--------------------------------------------------------------------------
% rawData format should be: (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Samples_per_Chirp;
rawDataUniform = reshape(rawDataMonostatic([1:4,9:12],:,:,:),[],Num_horizontalScan,Samples_per_Chirp);


%--------------------------------------------------------------------------
%-- Image Reconstruction Part
%--------------------------------------------------------------------------

%% Reconstruct 3D or 2D Image
% 2D Slice
[sarImage2D,xRangeT2D,yRangeT2D,zRangeT2D] = reconstructSARimageFFT_3D(rawDataUniform,frequency,xStepM_mm,lambda_mm/4,-1,zTarget_mm,512);
% sarImage2D = reconstructSARimageFFT(rawDataUniform,frequency,xStepM_mm,lambda_mm/4,-1,zTarget_mm,512);

% 3D Image
[sarImage3D,xRangeT,yRangeT,zRangeT] = reconstructSARimageFFT_3D(rawDataUniform,frequency,xStepM_mm,lambda_mm/4,-1,-1,512);
% Filtering and visualizing
sarImage3DAbs = abs(sarImage3D);
volumeViewer(sarImage3DAbs);
% sarImage3DAbs = imgaussfilt3(sarImage3DAbs,0.5);
% volshow(sarImage3DAbs,'Renderer','MaximumIntensityProjection','Isovalue',0.9,'BackgroundColor',[0 0 0]);

%% Isosurface patch plot
sarImage3DAbs_dB = mag2db(sarImage3DAbs/max(sarImage3DAbs(:)));
dynamicRange_dB = -15;
[X,Y,Z] = meshgrid(xRangeT,yRangeT,zRangeT);
[faces,vertices,colors] = isosurface(X,Y,Z,sarImage3DAbs_dB,dynamicRange_dB,Z);
figure('OuterPosition',[695 166 670 712]);
sarImage3DAbs_dB_patch = patch('Vertices',vertices(:,[3,1,2]),'Faces',faces(:,[3,1,2]),'FaceVertexCData',colors,...
    'FaceColor','interp','EdgeColor','interp');
grid on
xlabel('z-axis (mm)'); ylabel('x-axis (mm)'); zlabel('y-axis (mm)')
xlim([0 400]); ylim([-200 200]); zlim([-200 200]);
view(3)
colormap gray