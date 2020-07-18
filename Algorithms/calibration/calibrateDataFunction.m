%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function rawDataCal = calibrateDataFunction(rawData,sensorParams,calData,delayOffset)

% Format should be
% rawData = (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Samples_per_Chirp;

% calData = (Num_RX * Num_TX) * 1
% delayOffset = (Num_RX * Num_TX) * 1


%% Complex Gain Calibration
rawDataCal = calData .* rawData;


%% Beat Frequency Offset Calibration
Slope_Hzpers = sensorParams.Slope_MHzperus*1e12;
Sampling_Rate_sps = sensorParams.Sampling_Rate_ksps * 1e3;
Samples_per_Chirp = sensorParams.Samples_per_Chirp;

f = ((0:Samples_per_Chirp-1)*Slope_Hzpers/Sampling_Rate_sps); % wideband frequency
f = reshape(f,1,1,1,[]);

frequencyBiasFactor = exp(-1i*2*pi*delayOffset.*f);

rawDataCal = rawDataCal .* frequencyBiasFactor;

end %% End of calibrateData
    