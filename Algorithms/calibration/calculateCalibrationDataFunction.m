%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function [calData,delayOffset] = calculateCalibrationDataFunction(rawData,sensorParams,xStepM,yStepM,referenceTargetXYZ_mm,radarType)
% rawData format
% (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Samples_per_Chirp;

%% Define parameters
[~,yPointM,xPointM,Samples_per_Chirp] = size(rawData);
chirpParameters = [sensorParams.Start_Freq_GHz*1e9,sensorParams.Slope_MHzperus*1e12,sensorParams.Sampling_Rate_ksps*1e3,sensorParams.Adc_Start_Time_us*1e-6,Samples_per_Chirp];
Num_TX = sensorParams.Num_TX;
Num_RX = length(sensorParams.RxToEnable);
xTarget_mm = referenceTargetXYZ_mm(1);
yTarget_mm = referenceTargetXYZ_mm(2);
zTarget_mm = referenceTargetXYZ_mm(3);

version = 2; % or 2

%% Simulate reference signal model
rawDataSim = simulateSARdata(xPointM,xStepM,yPointM,yStepM,1,0,zTarget_mm,xTarget_mm,yTarget_mm,radarType,0,ones(1,Num_TX),ones(1,Num_RX),chirpParameters);
% rawDataSim format
% (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Samples_per_Chirp;


%% Calculate Calibration data Version 1 - If the data is stationary
%--------------------------------------------------------------------------
if version == 1
    %% Average accross measurements
    rawDataSim = squeeze(sum(sum(rawDataSim,2),3));
    rawData = squeeze(sum(sum(rawData,2),3));
    %%% Or for 144x5 Calibration
    % rawDataSim = squeeze(sum(rawDataSim,3));
    % rawData = squeeze(sum(rawData,3));
    
    %% Take FFT of data
    N = 16*2048; % Number of FFT Point
    rawDataSim_RangeFFT = fft(rawDataSim,N,2);
    rawData_RangeFFT = fft(rawData,N,2); 
    figure;plot(squeeze(abs(rawDataSim_RangeFFT)).')
    figure;plot(squeeze(abs(rawData_RangeFFT)).')
    %%% Or for 144x5 Calibration
    % rawDataSim_RangeFFT = fft(rawDataSim,N,3);
    % rawData_RangeFFT = fft(rawData,N,3);
    % figure;plot(abs(reshape(permute(rawDataSim_RangeFFT,[3,1,2]),N,[])))
    % figure;plot(abs(reshape(permute(rawData_RangeFFT,[3,1,2]),N,[])))
    
    %% RVP Removal (Optional)
%     fbeat_range = (0:N-1)/N * fs;
%     rvp_factor = exp(1i*pi*fbeat_range.^2/(sensorParams.Slope_MHzperus*1e12));
%     rvp_factor = reshape(rvp_factor,1,1,1,N);
%     rawData_RangeFFT = rawData_RangeFFT .* rvp_factor;
    
    % rawData_RangeFFT(:,1:270) = 0; % Zeroize unrelated part for a better peak estimate (for 4096 points)
    % rawData_RangeFFT(:,360:end) = 0; % Zeroize unrelated part for a better peak estimate (for 4096 points)
    % rawData_RangeFFT(:,1:100) = 0; % Zeroize unrelated part for a better peak estimate (for 2048 points)
    % rawData_RangeFFT(:,160:end) = 0; % Zeroize unrelated part for a better peak estimate (for 2048 points)
    
    %% Take the peak point
    [~,kSim] = max(abs(rawDataSim_RangeFFT),[],2);
    [~,kData] = max(abs(rawData_RangeFFT),[],2);
    figure;plot(kSim)
    figure;plot(kData)
    peakSim = zeros(Num_TX*Num_RX,1);
    peakData = zeros(Num_TX*Num_RX,1);
    for n = 1:(Num_TX*Num_RX)
        peakSim(n) = rawDataSim_RangeFFT(n,kSim(n));
        peakData(n) = rawData_RangeFFT(n,kData(n));
    end
    %%% Or for 144x5 Calibration
    [~,kSim] = max(abs(rawDataSim_RangeFFT),[],3);
    [~,kData] = max(abs(rawData_RangeFFT),[],3);
    peakSim = zeros(Num_TX*Num_RX,5);
    peakData = zeros(Num_TX*Num_RX,5);
    for n = 1:(Num_TX*Num_RX)
        for m = 1:5
            peakSim(n,m) = rawDataSim_RangeFFT(n,m,kSim(n,m));
            peakData(n,m) = rawData_RangeFFT(n,m,kData(n,m));
        end
    end
    
    %% Take the calibration factor
    calData = peakSim ./ peakData;
    figure;plot(unwrap(angle(calData)));
    
    %% Calculate the range bias
    fS = sensorParams.Sampling_Rate_ksps*1e3; % sample ps
    K = sensorParams.Slope_MHzperus*1e12; % Slope const (Hz/sec)
    delayOffset = ((kData-kSim) * fS) / (N * K);
    
    c = physconst('LightSpeed');
    rangeOffset_mm = (c * delayOffset / 2)*1e3;
    figure;plot(rangeOffset_mm);
end

%% Calculate Calibration data Version 2
%--------------------------------------------------------------------------
if version ==2 % 144x1 Calibration data 
    
    %% Demodulate the signal
    calSignal = rawData .* conj(rawDataSim);
    calSignal = squeeze(sum(sum(calSignal,2),3));
    calSignal = calSignal.';
    % calSignal format
    % Samples_per_Chirp * (Num_RX * Num_TX);
    
    %% Take and plot FFT
    N = 16*4096; % Number of FFT Point
    % calSignalFFT = fft(calSignal,N);
    calSignalFFT = fftshift(fft(calSignal,N),1);
    figure;plot(abs(calSignalFFT))
    % calSignalFFT_RxTx = reshape(calSignalFFT,N,Num_RX,Num_TX);
    % figure;mesh(abs(calSignalFFT_RxTx))
    
    
    %% Take Peak data and index
    [peakData,k] = max(calSignalFFT,[],1);
    % [CalDataPeak,k] = max(CalDataFFT(1:1e4,:),[],1);
    % Get peak data
    % peakData = peakData / norm(peakData);
    calData = (1./(peakData)).';
    figure;plot(unwrap(angle(calData)))
    % calDataPhase_RxTx = reshape(unwrap(angle(calData)),Num_RX,Num_TX);
    % figure;mesh(abs(calDataPhase_RxTx))
    
    %% Calculate the range bias
    fS = sensorParams.Sampling_Rate_ksps*1e3; % sample ps
    K = sensorParams.Slope_MHzperus*1e12; % Slope const (Hz/sec)
    
    %% for FFT
    % delayOffset = (((k-1) * fS) / (N * K)).'; % Should be k-1
    % delayOffsetRange = (0:N-1) * (fS /(N * K));
    % delayOffset = delayOffsetRange(k).';
    
    %% For FFT Shift
    delayOffsetRange = (-N/2:N/2-1) * (fS /(N * K));
    delayOffset = delayOffsetRange(k).';
    
    c = physconst('LightSpeed');
    rangeOffset_mm = (c * delayOffset / 2)*1e3;
    figure;plot(rangeOffset_mm);
end

if version ==3 % 144x5 Calibration data 
    
    %% Demodulate the signal
    calSignal = rawData .* conj(rawDataSim);
    calSignal = squeeze(sum(calSignal,3)); % Sum only over horizontal axis
    % calSignal format
    % Samples_per_Chirp * (Num_RX * Num_TX);
    
    %% Take and plot FFT
    N = 16*4096; % Number of FFT Point
    calSignalFFT = fft(calSignal,N,3);
    figure;plot(abs(reshape(permute(calSignalFFT,[3,1,2]),N,[])))
    % calSignalFFT_RxTx = reshape(calSignalFFT,N,Num_RX,Num_TX);
    % figure;mesh(abs(calSignalFFT_RxTx))
    
    
    %% Take Peak data and index
    [peakData,k] = max(calSignalFFT,[],3);
    % [CalDataPeak,k] = max(CalDataFFT(1:1e4,:),[],1);
    % Get peak data
    % peakData = peakData / norm(peakData);
    calData = 1./(peakData);
    figure;plot(unwrap(angle(calData(:))))
    % calDataPhase_RxTx = reshape(unwrap(angle(calData)),Num_RX,Num_TX);
    % figure;mesh(abs(calDataPhase_RxTx))
    
    %% Calculate the range bias
    fS = sensorParams.Sampling_Rate_ksps*1e3; % sample ps
    K = sensorParams.Slope_MHzperus*1e12; % Slope const (Hz/sec)
    delayOffset = ((k-1) * fS) / (N * K); % Should be k-1
    
    c = physconst('LightSpeed');
    rangeOffset_mm = (c * delayOffset / 2)*1e3;
    figure;plot(rangeOffset_mm(:));
end