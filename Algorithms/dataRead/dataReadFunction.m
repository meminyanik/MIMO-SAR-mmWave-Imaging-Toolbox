%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function [rawData,sarParams,sensorParams] = dataReadFunction(sensorParams,sarParams,adcBinData_folderName)

% Ouput Format will be
% rawData = (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Samples_per_Chirp;


%% Sensor and SAR Parameters
Chirps_per_Frame = sensorParams.Chirps_per_Frame;

Num_horizontalScan = sarParams.Num_horizontalScan;
Num_verticalScan = sarParams.Num_verticalScan;


%% Check the average chirps flag
if (Chirps_per_Frame > 1)
    averageChirps = true;
else
    averageChirps = false;
end

%% Check if the scan mode is Rectangular
% Data must be reversed for 2nd, 4th, etc. rows
if (~isfield(sarParams,'scanTrajectoryMode'))
    isRectangularScan = true; % Default scan mode is the Rectangular
else
    if (strcmp(sarParams.scanTrajectoryMode,'Rectangular'))
        isRectangularScan = true;
    else
        isRectangularScan = false;
    end
end


%% Check if the Hardware trigger mode is active
if ( ~isfield(sarParams,'triggerMode') || ~isfield(sensorParams,'TriggerSelect_Arr') )
    isHardwareTrigger = false; % Default mode is Software trigger
else
    if ( strcmp(sarParams.triggerMode,'Hardware') && (sensorParams.TriggerSelect_Arr==2) )
        isHardwareTrigger = true;
    else
        error('SAR and Sensor parameters are inconsistent for the Hardware Trigger mode. Please check the configuration data')
    end
end

%% Pre-processing of the Hardware Trigger Data
if isHardwareTrigger
    if (sensorParams.Num_Frames == Num_horizontalScan*Num_verticalScan)
        % Total number of frames information is not necessary anymore
        sensorParams.Num_Frames = 1;
    else
        error('Number of measurements must be equal to the number of frames in the Hardware Trigger continuous mode. Please check the data')
    end
end


%% Parse Complex rawData
rawData = fcn_read_ADC_bin_SAR(sensorParams,sarParams,adcBinData_folderName);
% Format should be
% rawData = Num_RX * Num_TX * Samples_per_Chirp * Chirps_per_Frame * Num_Frames * Num_measurements;
%%% HSDC #samples should be configured as nChirps*ADCSample*nTx*nFrame*nMeasurement (128*256*2*1*100, ex.)
%%% max HSDC #samples per channel 67108864


%% Average Chirps
if averageChirps
    rawData = sum(rawData,4)/Chirps_per_Frame; % Average Chirps
end


%% Sensor and SAR Parameters
Samples_per_Chirp = sensorParams.Samples_per_Chirp;

Num_TX = sensorParams.Num_TX;
Num_RX = length(sensorParams.RxToEnable);
Num_Frames = sensorParams.Num_Frames;


%% Reshape rawData
rawData = reshape(rawData,Num_RX*Num_TX,Samples_per_Chirp,Num_Frames,Num_horizontalScan,Num_verticalScan);


%% Pre-processing based on SAR Mode
if (strcmp(sarParams.dataCaptureMode,'Continuous'))
    isContinuousMode = true; % If this flag is true, data may need to be cropped.
    if ~isHardwareTrigger
        % Pre-process data for the Software Trigger mode (Data is already ready for the Hardware Trigger mode)
        if (Num_horizontalScan ~= 1)
            error('Number of horizontal scan must be 1 in Software Trigger Continuous mode. Please check the data')
        end
        Num_horizontalScan = Num_Frames;
        Num_Frames = 1;
        sarParams.Num_horizontalScan = Num_horizontalScan;
        sensorParams.Num_Frames = Num_Frames;
    end  
elseif (strcmp(sarParams.dataCaptureMode,'Discrete'))
    isContinuousMode = false; % Data will not be cropped in these modes
    if (Num_Frames ~= 1)
        answerAverageFrames = questdlg('Data can not be used for image reconstruction directly, do you want to average over frames', ...
            'AverageFrames', ...
            'Yes','No','Yes');
        switch answerAverageFrames
            case 'Yes'
                rawData = sum(rawData,3)/Num_Frames; % Average over frames
                Num_Frames = 1;
                sensorParams.Num_Frames = Num_Frames;
            case 'No'
                warning('Data can not be used for image reconstruction directly, please reshape it manually');
                % Convert rawData to: (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Num_Frames * Samples_per_Chirp;
                rawData = permute(rawData,[1,5,4,3,2]);
                return;
        end
    end
elseif (strcmp(sarParams.dataCaptureMode,'Stationary'))
    warning('Data can not be used for image reconstruction directly, please reshape it manually');
    % Convert rawData to: (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Num_Frames * Samples_per_Chirp;
    rawData = permute(rawData,[1,5,4,3,2]);
    return;
else
    error('Data capture mode is wrong. Please check the data')
end


%% Reshape data
rawData = reshape(rawData,Num_RX*Num_TX,Samples_per_Chirp,Num_horizontalScan,Num_verticalScan);
% rawData is (Num_RX * Num_TX) * Samples_per_Chirp * Num_horizontalScan * Num_verticalScan
% Num_Frames has to be zero up to this point.

%% For Continuous Scan - Crop the Data
if ( isContinuousMode && ~isHardwareTrigger )
    %% Check the Trigger Offset Time
    if (isfield(sarParams,'Trigger_timeOffset_s'))
        if (sarParams.Trigger_timeOffset_s < 0) % If Trigger is ahead of the scan
            firstIndex = floor(abs(sarParams.Trigger_timeOffset_s) / (sensorParams.Frame_Repetition_Period_ms*1e-3)) + 1;
            motionTime_s = calculateMotionDuration(sarParams.Horizontal_scanSize_mm,sarParams.Platform_Speed_mmps,200);
            lastIndex = ceil(motionTime_s / (sensorParams.Frame_Repetition_Period_ms*1e-3)) + firstIndex;
        else
            firstIndex = 1;
            lastIndex = Num_horizontalScan; % Get all the samples
        end
    else
        %% Crop the data manually by data analysis
        % Test Version 1
        % rawDataCh1 = squeeze(rawData(1,:,:,:));
        % nFFT = 512;
        % rawDataCh1FFT = fft(rawDataCh1,nFFT);
        % plot(abs(reshape(rawDataCh1FFT(:,:,25:35),nFFT,[])))
        % processData = squeeze(rawDataCh1FFT(10,:,:));
        % plot(unwrap(angle(processData)))
        
        % Test Version 2
        % plot(real(squeeze(rawData(1,1,:,:))))
        
        %% Data Crop Table
        %=================================================================
        %          | 25ms            | 50ms            | 100ms           | Frame Period
        %=================================================================
        %          | 120 | 180 | 240 | 120 | 180 | 240 | 120 | 180 | 240 | RPM
        %          |------------------------------------------------------
        %          |       200       |       200       | 300             | Scan Size (mm)
        %  Trigger |------------------------------------------------------
        %    1s    |       43        |       22        |       11        | First Sample
        %          |-----------------|-----------------|------------------
        %          | --- | --- | 663 | 428 | 291 | 229 | 316 | --- | --- | Last Sample
        %=================================================================
        %          | 120 | 180 | 240 | 120 | 180 | 240 | 120 | 180 | 240 | RPM
        %          |------------------------------------------------------
        %          |                 |             400 | 400             | Scan Size (mm)
        %  Trigger |------------------------------------------------------
        %   1.5s   |       --        |       31        |       16        | First Sample
        %          |-----------------|-----------------|------------------
        %          | --- | --- | --- | --- | --- | 445 | 423 | --- | --- | Last Sample
        %=================================================================
        
        %% New Platform crop table
        %=================================================================
        %          | 25ms            | 50ms            | 100ms           | Frame Period
        %=================================================================
        %          | 10  | 20  | 50  | -   | 20  | --  | 10  | 20  | 50  | Speed (mm/s)
        %          |------------------------------------------------------
        %          |       --        |       400       |       --        | Scan Size (mm)
        %  Trigger |------------------------------------------------------
        %   1.5s   |       --        |       33        |       --        | First Sample
        %          |-----------------|-----------------|------------------
        %          | --- | --- | --- | --- | --- | 434 | --- | --- | --- | Last Sample
        %=================================================================
        
        firstIndex = 16;
        lastIndex = 423;

    end
    
    %% Crop the Data
    rawData = rawData(:,:,firstIndex:lastIndex,:);
    
    %% (Optional for debugging) inject motion error (+/- 3 or 5 samples)
    % errorIndex = randi(11, 1, Num_verticalScan) - 6;
    % % errorIndex = randi(7, 1, Num_verticalScan) - 4;
    %     
    % rawDataTemp = zeros(size(rawData));
    % rawDataTemp = rawDataTemp(:,:,firstIndex:lastIndex,:);
    % for n=1:Num_verticalScan
    %     rawDataTemp(:,:,:,n) = rawData(:,:,(firstIndex:lastIndex)+errorIndex(n),n);
    % end
    % rawData = rawDataTemp;
    
    %% Define new Num_horizontalScan, rearrange the data
    [~,~,Num_horizontalScan,~] = size(rawData);
    sarParams.Num_horizontalScan = Num_horizontalScan;
end

%% Rearrange the vertical scans
% This should be done for Rectangular Scan Mode
% rawData is (Num_RX * Num_TX) * Samples_per_Chirp * Num_horizontalScan * Num_verticalScan
if isRectangularScan
    for n = 1:Num_verticalScan
        if rem(n-1,2)
            rawData(:,:,:,n) = flip(rawData(:,:,:,n),3);
        end
    end
end

%% Reshape the rawData
% Convert rawData to: (Num_RX * Num_TX) * Num_verticalScan * Num_horizontalScan * Samples_per_Chirp;
rawData = permute(rawData,[1,4,3,2]);
    

end %% End of dataRead
    