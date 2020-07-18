classdef SAR_GUI_Source < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        SARGUI                          matlab.ui.Figure
        Label                           matlab.ui.control.Label
        TabGroup                        matlab.ui.container.TabGroup
        InitializationTab               matlab.ui.container.Tab
        ScannerInitializationPanel      matlab.ui.container.Panel
        ConnectToScannerButton          matlab.ui.control.Button
        ManualMovementForTestWillbemovedatIdleSpeedPanel  matlab.ui.container.Panel
        DesiredHorizontalMovementmmLabel  matlab.ui.control.Label
        DesiredHorizontalMovementmmEditField  matlab.ui.control.NumericEditField
        DesiredVerticalMovementmmLabel  matlab.ui.control.Label
        DesiredVerticalMovementmmEditField  matlab.ui.control.NumericEditField
        SendSingleCommandButton         matlab.ui.control.Button
        ScannerConnectionStatusLamp     matlab.ui.control.Lamp
        DesignParametersHardwareDependentPanel  matlab.ui.container.Panel
        PulsePerRevolutionEditFieldLabel  matlab.ui.control.Label
        PulsePerRevolutionEditField     matlab.ui.control.NumericEditField
        DistancePerRevolutionmmEditFieldLabel  matlab.ui.control.Label
        DistancePerRevolutionmmEditField  matlab.ui.control.NumericEditField
        ScannerCOMPortEditFieldLabel    matlab.ui.control.Label
        ScannerCOMPortEditField         matlab.ui.control.NumericEditField
        DisconnectFromScannerButton     matlab.ui.control.Button
        ConfigurationParametersPanel    matlab.ui.container.Panel
        SpeedSARmmsLabel                matlab.ui.control.Label
        SpeedmmpsEditField              matlab.ui.control.NumericEditField
        HorizontalAxisLimitmmLabel      matlab.ui.control.Label
        HorizontalAxisLimitmmEditField  matlab.ui.control.NumericEditField
        VerticalAxisLimitmmEditFieldLabel  matlab.ui.control.Label
        VerticalAxisLimitmmEditField    matlab.ui.control.NumericEditField
        xAxisLabel                      matlab.ui.control.Label
        yAxisLabel                      matlab.ui.control.Label
        IdleSpeedmmsNoDataLabel         matlab.ui.control.Label
        IdleSpeedmmpsEditField          matlab.ui.control.NumericEditField
        TotalMovementPanel              matlab.ui.container.Panel
        HomeButton                      matlab.ui.control.Button
        TotalMovementTextArea           matlab.ui.control.TextArea
        ScannerTypeSwitchLabel          matlab.ui.control.Label
        ScannerTypeSwitch               matlab.ui.control.Switch
        RadarInitilializationPanel      matlab.ui.container.Panel
        InitializeRSTDandHSDCPROConnectionsButton  matlab.ui.control.Button
        RadarConnectionStatusLamp       matlab.ui.control.Lamp
        RadarStatusTextAreaLabel        matlab.ui.control.Label
        RadarStatusTextArea             matlab.ui.control.TextArea
        OutputBaseFolderEditFieldLabel  matlab.ui.control.Label
        OutputBaseFolderEditField       matlab.ui.control.EditField
        BrowseOutputBaseButton          matlab.ui.control.Button
        ExperimentFolderEditFieldLabel  matlab.ui.control.Label
        ExperimentFolderEditField       matlab.ui.control.EditField
        ParameterFileLabel              matlab.ui.control.Label
        ParamFileEditField              matlab.ui.control.EditField
        BrowseParamFileButton           matlab.ui.control.Button
        RadarTypeSwitchLabel            matlab.ui.control.Label
        RadarTypeSwitch                 matlab.ui.control.Switch
        ConfigureParamFromFileButton    matlab.ui.control.Button
        CaptureandRecordForTestPanel    matlab.ui.container.Panel
        CaptureAndRecordButton          matlab.ui.control.Button
        InitializeRSTDandHSDCPROCon2ConfigurechirpsparametersLabel  matlab.ui.control.Label
        ofMeasurementsSpinnerLabel      matlab.ui.control.Label
        ofMeasurementsSpinner           matlab.ui.control.Spinner
        ofSamplesChannelLabel_3         matlab.ui.control.Label
        NumberofSamplesPerChannelEditField  matlab.ui.control.NumericEditField
        TriggerHSDCButton               matlab.ui.control.Button
        TriggerFrameButton              matlab.ui.control.Button
        RecordDataButton                matlab.ui.control.Button
        ManualStepsLabel                matlab.ui.control.Label
        ScannerStatusPanel              matlab.ui.container.Panel
        ScannerStatusTextArea           matlab.ui.control.TextArea
        SARConfigurationHWTriggerTab    matlab.ui.container.Tab
        SARConfigurationContinuousHorizontalScanHwTrgPanel  matlab.ui.container.Panel
        StartCapturingContSARHwTrgCommandButton  matlab.ui.control.Button
        StopCapturingContSARHwTrgCommandButton  matlab.ui.control.Button
        VerticalStepSizemmContSARHwTrgLabel  matlab.ui.control.Label
        NumberofVerticalStepsLabel      matlab.ui.control.Label
        VerticalScanStepsContSARHwTrgSpinner  matlab.ui.control.Spinner
        VerticalStepSizemmLabel_5       matlab.ui.control.Label
        VerticalStepSizemmContSARHwTrgEditField  matlab.ui.control.EditField
        HorizontalScanSizemmLabel_5     matlab.ui.control.Label
        HorizontalScanSizemmContSARHwTrgEditField  matlab.ui.control.NumericEditField
        ReconfigureRadarSARSyncContSARHwTrgButton  matlab.ui.control.Button
        TotalContSARHwTrgMovementPanel  matlab.ui.container.Panel
        TotalMovementContSARHwTrgTextArea  matlab.ui.control.TextArea
        ContSARHwTrgStatusPanel         matlab.ui.container.Panel
        Label_5                         matlab.ui.control.Label
        ContSARHwTrgStatusTextArea      matlab.ui.control.TextArea
        HorizontalStepSizemmLabel_3     matlab.ui.control.Label
        HorizontalStepSizemmContSARHwTrgEditField  matlab.ui.control.NumericEditField
        VerticalScanSizemmLabel_3       matlab.ui.control.Label
        VerticalScanSizemmContSARHwTrgEditField  matlab.ui.control.NumericEditField
        ScanModeSwitchLabel_2           matlab.ui.control.Label
        ScanModeContSARHwTrgSwitch      matlab.ui.control.RockerSwitch
        NumberofHorizontalStepsLabel    matlab.ui.control.Label
        HorizontalScanStepsContSARHwTrgSpinner  matlab.ui.control.Spinner
        SARSyncCOMPortEditFieldLabel    matlab.ui.control.Label
        SARSyncCOMPortEditField         matlab.ui.control.NumericEditField
        NumberofFramesEditFieldLabel_3  matlab.ui.control.Label
        NumberofFramesContSARHwTrgEditField  matlab.ui.control.NumericEditField
        ofSamplesChannelLabel_4         matlab.ui.control.Label
        NumberofSamplesPerChannelContSARHwTrgEditField  matlab.ui.control.NumericEditField
        FramePeriodicitymsLabel_2       matlab.ui.control.Label
        FramePeriodicitymsContSARHwTrgEditField  matlab.ui.control.NumericEditField
        ConnectToSARSyncButton          matlab.ui.control.Button
        SARSyncConnectionStatusLamp     matlab.ui.control.Lamp
        CaptureBoardLabel               matlab.ui.control.Label
        CaptureBoardContSARHwTrgSwitch  matlab.ui.control.RockerSwitch
        NumberofPulsesStepLabel         matlab.ui.control.Label
        NumberofPulsesPerStepContSARHwTrgEditField  matlab.ui.control.NumericEditField
        SARConfigurationSWTriggerTab    matlab.ui.container.Tab
        SARConfigurationContinuousHorizontalScanPanel  matlab.ui.container.Panel
        StartCapturingContSARCommandButton  matlab.ui.control.Button
        StopCapturingContSARCommandButton  matlab.ui.control.Button
        VerticalStepSizemmContSARLabel  matlab.ui.control.Label
        RecommendNumberOfFramesButtonContSAR  matlab.ui.control.Button
        TimeBeforeCapturingsLabel       matlab.ui.control.Label
        WaitTimeBeforeCapturingContSAREditField  matlab.ui.control.NumericEditField
        NumberofStepsatVerticalScanLabel_3  matlab.ui.control.Label
        VerticalScanStepsContSARSpinner  matlab.ui.control.Spinner
        VerticalStepSizemmLabel_3       matlab.ui.control.Label
        VerticalStepSizemmContSAREditField  matlab.ui.control.EditField
        FramePeriodicitymsLabel         matlab.ui.control.Label
        FramePeriodicitymsContSAREditField  matlab.ui.control.NumericEditField
        HorizontalScanSizemmLabel_3     matlab.ui.control.Label
        HorizontalScanSizemmContSAREditField  matlab.ui.control.NumericEditField
        NumberofFramesEditFieldLabel    matlab.ui.control.Label
        NumberofFramesContSAREditField  matlab.ui.control.NumericEditField
        ifRadarTriggerFirstLabel        matlab.ui.control.Label
        PlatformSpeedmmsEditFieldLabel  matlab.ui.control.Label
        PlatformSpeedmmpsContSAREditField  matlab.ui.control.NumericEditField
        ReconfigureRadarContSARButton   matlab.ui.control.Button
        TotalContSARMovementPanel       matlab.ui.container.Panel
        TotalMovementContSARTextArea    matlab.ui.control.TextArea
        ContSARStatusPanel              matlab.ui.container.Panel
        Label_3                         matlab.ui.control.Label
        ContSARStatusTextArea           matlab.ui.control.TextArea
        ofSamplesChannelLabel           matlab.ui.control.Label
        NumberofSamplesPerChannelContSAREditField  matlab.ui.control.NumericEditField
        HorizontalStepSizemmLabel_2     matlab.ui.control.Label
        HorizontalStepSizemmContSAREditField  matlab.ui.control.NumericEditField
        UpdateParamsContSARButton       matlab.ui.control.Button
        VerticalScanSizemmLabel_2       matlab.ui.control.Label
        VerticalScanSizemmContSAREditField  matlab.ui.control.NumericEditField
        ScanModeSwitchLabel             matlab.ui.control.Label
        ScanModeContSARSwitch           matlab.ui.control.RockerSwitch
        SARConfigurationDiscreteHorizontalScanPanel  matlab.ui.container.Panel
        StartCapturingDiscSARCommandButton  matlab.ui.control.Button
        StopCapturingDiscSARCommandButton  matlab.ui.control.Button
        Blankbetweenvalues0919DiscSARLabel  matlab.ui.control.Label
        NumberofStepsatVerticalScanLabel_4  matlab.ui.control.Label
        VerticalScanStepsDiscSARSpinner  matlab.ui.control.Spinner
        VerticalStepSizemmLabel_4       matlab.ui.control.Label
        VerticalStepSizemmDiscSAREditField  matlab.ui.control.EditField
        HorizontalScanSizemmLabel_4     matlab.ui.control.Label
        HorizontalScanSizemmDiscSAREditField  matlab.ui.control.NumericEditField
        NumberofFramesEditFieldLabel_2  matlab.ui.control.Label
        NumberofFramesDiscSAREditField  matlab.ui.control.NumericEditField
        ReconfigureRadarDiscSARButton   matlab.ui.control.Button
        TotalDiscSARMovementPanel       matlab.ui.container.Panel
        TotalMovementDiscSARTextArea    matlab.ui.control.TextArea
        DiscSARStatusPanel              matlab.ui.container.Panel
        Label_4                         matlab.ui.control.Label
        DiscSARStatusTextArea           matlab.ui.control.TextArea
        ofSamplesChannelLabel_2         matlab.ui.control.Label
        NumberofSamplesPerChannelDiscSAREditField  matlab.ui.control.NumericEditField
        UpdateParamsDiscSARButton       matlab.ui.control.Button
        VerticalScanSizemmLabel         matlab.ui.control.Label
        VerticalScanSizemmDiscSAREditField  matlab.ui.control.NumericEditField
        NumberofStepsatHorizontalScanLabel  matlab.ui.control.Label
        HorizontalScanStepsDiscSARSpinner  matlab.ui.control.Spinner
        WaitTimeBetweenStepssEditField_2Label  matlab.ui.control.Label
        WaitTimeBetweenStepsDiscSAREditField  matlab.ui.control.NumericEditField
        HorizontalStepSizemmEditFieldLabel  matlab.ui.control.Label
        HorizontalStepSizemmDiscSAREditField  matlab.ui.control.NumericEditField
        EmergencyStopScannerButton      matlab.ui.control.Button
        VersionLabel                    matlab.ui.control.Label
    end


    properties (Access = public)
        
        % ----------------- Scanner Properties -----------------
        isScannerConnected = false;
        
        desiredHorizontalMovement_mm = 0;
        desiredVerticalMovement_mm = 0;

        totalHorizontalMovement_mm = 0;
        totalVerticalMovement_mm = 0;
        textMovementString = ' ';
        
        scannerType; % Smaller or bigger version
        scannerTypeItems; % Smaller or bigger version
        
        acceleration_mmps2 = 200; % Acceleration limit of the platform (mm/s^2)
        
        % For Discrete SAR, Raster Scan is the only available mode
        scanModeContSAR; % Raster Scan or Rectangular Plane Scan for Continuous SAR
        scanModeItemsContSAR; % Raster Scan or Rectangular Plane Scan for Continuous SAR
        
        % ----------------- DLL Paths -----------------
        %% RSTD_DLL_Path should be modified after software updates
        RSTD_DLL_Path ='C:\ti\mmwave_dfp_01_00_00_01\rf_eval\radarstudio\Clients\RtttNetClientController\RtttNetClientAPI.dll';
        
        % HSDCPRO_DLL_Path should be modified after software updates
        HSDCPRO_DLL_Path = 'C:\Program Files (x86)\Texas Instruments\High Speed Data Converter Pro\HSDCPro Automation DLL\64Bit DLL\HSDCProAutomation_64Bit.dll';
        
        
        % ----------------- Radar Properties -----------------
        radarType; % Single chip or Cascaded
        radarTypeItems; % Single chip or Cascaded
        currentTriggeredFrameNumber = 1; % Is being used at manual data capture window
        
        % Set Data Capture Ready flag to true if radar is ready
        isDataCaptureReady = false;
        
        % ----------------- HSDC Properties -----------------
        sourceHSDC = 'C:\Users\Public\Documents\Texas Instruments\High Speed Data Converter Pro\ADC Temp.bin';
        HSDCPRO_TimeoutInMs= 300000;
        samplesPerChannelLimit = 1*1024*1024*1024/2/8; % TSW1400: 1Gb of RAM, 16 bit samples, 8 channels
        numberOfSamplesPerChannel;
        
        % ----------------- SAR Sync API Properties -----------------
        SarSync;
        isSARSyncConnected = false;
        pulseCounterUpperLimit = 10000; % Must be compatible with the SAR Sync FW
        
        % ----------------- Captured Data Properties -----------------
        %% Output file folder to save the ADC data
        outputFileBase;
        outputFilePath;
        
        %% Chirp configuration file
        sensorParamFile;
        sensorParams;
        sarParams;
        
        % ----------------- SAR Properties -----------------
        sarScenarioActive = false;
        
        % Set SAR Data Capture Ready flag to true if both scanner and radar are ready
        isSARDataCaptureReady = false;
    end

    methods (Access = public)
        
        
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: 
        % InitializeRSTDandHSDCPROConnectionsButton
        function InitializeRSTDandHSDCPROConnectionsButtonPushed(app, event)
            
            % Initialize Radarstudio .NET connection
            Init_RSTD_Connection(app.RSTD_DLL_Path);
            ErrStatus = Init_RSTD_Connection(app.RSTD_DLL_Path); % A bug in Radar Studio v1.9.2.1
            if (ErrStatus ~= 30000)
                app.RadarStatusTextArea.Value = 'Error inside Init_RSTD_Connection';
                app.RadarConnectionStatusLamp.Color = 'red';
                return;
            else
                
                % Initialize HSDCPRO connection
                Init_HSDCPRO_Connection(app.HSDCPRO_DLL_Path);
                
                % Configure HSDCPRO
                ErrStatus = Config_HSDCPRO(app.HSDCPRO_TimeoutInMs);
                if (ErrStatus ~= 0)
                    app.RadarStatusTextArea.Value = 'Error inside Config_HSDCPRO';
                    app.RadarConnectionStatusLamp.Color = 'red';
                    return;
                end
                
                app.RadarStatusTextArea.Value = ['RSTD Connection is successful' newline 'HSDCPRO Connection is successful'];
                app.RadarConnectionStatusLamp.Color = 'green';
                app.ConfigureParamFromFileButton.Enable = true;
            end
            
        end

        % Button pushed function: DisconnectFromScannerButton
        function DisconnectFromScannerButtonPushed(app, event)
            
            app.ScannerConnectionStatusLamp.Color = 'red';
            app.isScannerConnected = false;
            app.isSARDataCaptureReady = false;
            
            app.SendSingleCommandButton.Enable = false;
            app.HomeButton.Enable = false;
            
        end

        % Button pushed function: HomeButton
        function HomeButtonPushed(app, event)
            
            if (app.isScannerConnected)
                
                % Reconnect to the scanner (To avoid timeout)
                errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
                if (errorStatus ~= 1)
                    app.ScannerStatusTextArea.Value = 'Error in the scanner connection';
                    return;
                end
                
                % Move to home
                calllib('AMC4030','COM_API_Home',1,1,0);
                
                % Pause for movement
                largerMovement_mm = app.totalHorizontalMovement_mm;
                if (abs(app.totalVerticalMovement_mm) > abs(largerMovement_mm))
                    largerMovement_mm = app.totalVerticalMovement_mm;
                end
                motionTime_s = calculateMotionDuration(largerMovement_mm,20,app.acceleration_mmps2);
                pause(motionTime_s); % Home speed is 20 mm/s
                
                app.totalHorizontalMovement_mm = 0;
                app.totalVerticalMovement_mm = 0;
                app.textMovementString = ['Horizontal:       ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                    'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                app.TotalMovementTextArea.Value = app.textMovementString;
                app.TotalMovementContSARTextArea.Value = app.textMovementString;
                app.TotalMovementDiscSARTextArea.Value = app.textMovementString;
                
            end
            
        end

        % Button pushed function: SendSingleCommandButton
        function SendSingleCommandButtonPushed(app, event)
            
            % Define the scanner speed parameters
            idleSpeed_mmps = app.IdleSpeedmmpsEditField.Value;
            
            app.desiredHorizontalMovement_mm = app.DesiredHorizontalMovementmmEditField.Value;
            app.desiredVerticalMovement_mm = app.DesiredVerticalMovementmmEditField.Value;
            
            %% Check the axis limits
            if (app.desiredHorizontalMovement_mm + app.totalHorizontalMovement_mm) > app.HorizontalAxisLimitmmEditField.Value
                app.ScannerStatusTextArea.Value = "Desired horizontal movement is beyond the axis limit";
                return;
            elseif (app.desiredHorizontalMovement_mm + app.totalHorizontalMovement_mm) < 0
                app.ScannerStatusTextArea.Value = "Desired horizontal movement is beyond the home point";
                return;
            end
            
            if (app.desiredVerticalMovement_mm + app.totalVerticalMovement_mm) > app.VerticalAxisLimitmmEditField.Value
                app.ScannerStatusTextArea.Value = "Desired vertical movement is beyond the axis limit";
                return;
            elseif (app.desiredVerticalMovement_mm + app.totalVerticalMovement_mm) < 0
                app.ScannerStatusTextArea.Value = "Desired vertical movement is beyond the home point";
                return;
            end
            
            % Reconnect to the scanner (To avoid timeout)
            errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
            if (errorStatus ~= 1)
                app.ScannerStatusTextArea.Value = 'Error in the scanner connection';
                return;
            end
            
            % Start the movement
            calllib('AMC4030','COM_API_Jog',0,app.desiredHorizontalMovement_mm,idleSpeed_mmps);
            calllib('AMC4030','COM_API_Jog',1,app.desiredVerticalMovement_mm,idleSpeed_mmps);
            
            % Pause for movement
            largerMovement_mm = app.desiredHorizontalMovement_mm;
            if (abs(app.desiredVerticalMovement_mm) > abs(largerMovement_mm))
                largerMovement_mm = app.desiredVerticalMovement_mm;
            end
            motionTime_s = calculateMotionDuration(largerMovement_mm,idleSpeed_mmps,app.acceleration_mmps2);
            pause(motionTime_s);
            
            %% Update the movement screen
            app.totalHorizontalMovement_mm = app.totalHorizontalMovement_mm + app.desiredHorizontalMovement_mm;
            app.totalVerticalMovement_mm = app.totalVerticalMovement_mm + app.desiredVerticalMovement_mm;
            app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
            app.TotalMovementTextArea.Value = app.textMovementString;
            app.TotalMovementContSARTextArea.Value = app.textMovementString;
            app.TotalMovementDiscSARTextArea.Value = app.textMovementString;
            
        end

        % Button pushed function: CaptureAndRecordButton
        function CaptureAndRecordButtonPushed(app, event)
            
            % Set the outputFileBase and outputFilePath
            app.outputFileBase = createOutputFileBase(app.OutputBaseFolderEditField.Value,app.ExperimentFolderEditField.Value);
            [app.outputFilePath, ~] = createOutputFilePath(app.outputFileBase);
            
            % Calculate the number of samples per channel for data capture from HSDC Pro
            app.numberOfSamplesPerChannel = app.sensorParams.Samples_per_Chirp*app.sensorParams.Chirps_per_Frame*app.sensorParams.Num_TX*app.sensorParams.Num_Frames;
            app.numberOfSamplesPerChannel = app.numberOfSamplesPerChannel*app.ofMeasurementsSpinner.Value;
            % Update
            app.NumberofSamplesPerChannelEditField.Value = app.numberOfSamplesPerChannel;
            
            if (mod(app.numberOfSamplesPerChannel,4096))
                uialert(app.SARGUI,'The total number of samples is not divisible by 4096','Warning', 'Icon','warning');
                return;
            elseif (app.numberOfSamplesPerChannel > app.samplesPerChannelLimit)
                uialert(app.SARGUI,'The total number of samples is greater than TSW limits','Warning', 'Icon','warning');
                return;
            end
            
            % Start data capture process
            if (app.isDataCaptureReady)
                
                % Trigger HSDCPRO
                ErrStatus = Trigger_HSDCPRO(app.numberOfSamplesPerChannel,app.HSDCPRO_TimeoutInMs);
                if (ErrStatus ~= 0)
                    app.RadarStatusTextArea.Value = 'Error inside Trigger_HSDCPRO';
                    return;
                else
                    app.RadarStatusTextArea.Value = 'Trigger_HSDCPRO is successful';
                end
                
                % Trigger Frames
                for n = 1:app.ofMeasurementsSpinner.Value
                    
                    if (strcmp(app.radarType,app.radarTypeItems(1)))
                        %% IWR 1443 Single Chip Radar is selected
                        Lua_String = sprintf('ar1.StartFrame()');
                        ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
                        if (ErrStatus ~=30000)
                            app.RadarStatusTextArea.Value = 'Trigger Frame failed for IWR 1443';
                            return;
                        else
                            app.RadarStatusTextArea.Value = ['Trigger Frame ', num2str(n), ' for IWR 1443 is successful'];
                        end
                    else
                        %% Other (TBD) Radar is selected
                        app.RadarStatusTextArea.Value = 'This Radar version is not available';
                    end
                    
                    %Wait till the TSW memory is filled with data
                    pause(app.sensorParams.Num_Frames * app.sensorParams.Frame_Repetition_Period_ms / 1000);
                    
                    % Tolerance delay for 1 sec !!! Can be tuned better
                    pause(1);
                end
                
                % Transfer Data to PC
                ErrStatus = Transfer_Data_to_PC(app.sourceHSDC,app.HSDCPRO_TimeoutInMs);
                if (ErrStatus ~= 0)
                    app.RadarStatusTextArea.Value = 'Error inside Transfer_Data_to_PC';
                    return;
                else
                    app.RadarStatusTextArea.Value = 'Data capture process is successful';
                end
                
                % Copy raw data to outputFilePath
                mkdir(app.outputFilePath)
                copyfile(app.sourceHSDC,app.outputFilePath);
                
                % Save the chirp profile to the data folder, this is important to keep
                % Record the chirp configuration
                assignin('base', 'sensorParams', app.sensorParams);
                cmdStr = sprintf('save(''%ssensorParams.mat'',''%s'')',app.outputFilePath,'sensorParams');
                evalin('base',cmdStr);

                % Record the SAR configuration
                app.sarParams = createSarConfigurationParameters();
                app.sarParams.Num_horizontalScan = app.ofMeasurementsSpinner.Value;
                app.sarParams.dataCaptureMode = 'Stationary';
                assignin('base', 'sarParams', app.sarParams);
                cmdStr = sprintf('save(''%ssarParams.mat'',''%s'')',app.outputFilePath,'sarParams');
                evalin('base',cmdStr);

            else
                app.RadarStatusTextArea.Value = 'Please configure the radar for data capture';
            end
            
        end

        % Button pushed function: StartCapturingContSARCommandButton
        function StartCapturingContSARCommandButtonPushed(app, event)
            
            % Start data capture process
            if (app.isSARDataCaptureReady)

                % Set the outputFileBase and outputFilePath
                app.outputFileBase = createOutputFileBase(app.OutputBaseFolderEditField.Value,app.ExperimentFolderEditField.Value);
                [app.outputFilePath, ~] = createOutputFilePath(app.outputFileBase);
                
                % Define the scanner speed parameters
                sarSpeed_mmps = app.SpeedmmpsEditField.Value;
                idleSpeed_mmps = app.IdleSpeedmmpsEditField.Value;
                
                % Get the horizontal scan size
                horizontalScanSize_mm = app.HorizontalScanSizemmContSAREditField.Value;
                
                % Get the vertical step distance
                numberOfVerticalSteps = app.VerticalScanStepsContSARSpinner.Value;
                stepVerticalMovement_mm = str2num(app.VerticalStepSizemmContSAREditField.Value);
                stepVerticalMovement_mm = repmat(stepVerticalMovement_mm,1,ceil(numberOfVerticalSteps/length(stepVerticalMovement_mm)));
                stepVerticalMovement_mm = stepVerticalMovement_mm(1:numberOfVerticalSteps-1);
                
                % Set the wait time before (or after) trigger
                waitDuration_s = app.WaitTimeBeforeCapturingContSAREditField.Value;
                
                % Set scan mode
                app.scanModeContSAR = app.ScanModeContSARSwitch.Value;
                app.scanModeItemsContSAR = app.ScanModeContSARSwitch.Items;
                
                % Start SAR Data capture
                app.sarScenarioActive = true;
                app.StopCapturingContSARCommandButton.Enable = true;
                
                for nV = 1:numberOfVerticalSteps
                    
                    % Reconnect to the scanner (To avoid timeout) 
                    errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
                    if (errorStatus ~= 1)
                        app.ContSARStatusTextArea.Value = 'Error in the scanner connection';
                        return;
                    end
                    
                    pause(0.5) % Extra 0.5s wait for tolerance
                    
                    % If the Capturing process has stopped, exit from the function the loop
                    if (~app.sarScenarioActive)
                        app.ContSARStatusTextArea.Value = 'SAR process has been stopped.';
                        return;
                    end
                    
                    % Start horizontal movement before trigger
                    if (waitDuration_s >= 0)
                        calllib('AMC4030','COM_API_Jog',0,horizontalScanSize_mm,sarSpeed_mmps);
                        pause(waitDuration_s)
                    end
                    
                    % Trigger Frames
                    if (strcmp(app.radarType,app.radarTypeItems(1)))
                        %% IWR 1443 Single Chip Radar is selected
                        Lua_String = sprintf('ar1.StartFrame()');
                        ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
                        if (ErrStatus ~=30000)
                            app.ContSARStatusTextArea.Value = 'Trigger Frame failed for IWR 1443';
                            return;
                        end
                    else
                        %% Other (TBD) Radar is selected
                        app.ContSARStatusTextArea.Value = 'This Radar version is not available';
                    end
                    
                    % Or start horizontal movement after trigger
                    if (waitDuration_s < 0)
                        pause(abs(waitDuration_s))
                        calllib('AMC4030','COM_API_Jog',0,horizontalScanSize_mm,sarSpeed_mmps);
                    end
                    
                    % Pause for movement (Extra pause is for tolerance to ensure frame has finished)
                    motionTime_s = calculateMotionDuration(horizontalScanSize_mm,sarSpeed_mmps,app.acceleration_mmps2);
                    pause(motionTime_s - waitDuration_s);
                    
                    % Update the total movement screen
                    app.totalHorizontalMovement_mm = app.totalHorizontalMovement_mm + horizontalScanSize_mm;
                    app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                        'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                    app.TotalMovementContSARTextArea.Value = app.textMovementString;
                    
                    if (app.sarScenarioActive)
                        
                        if nV ~= numberOfVerticalSteps
                            pause(0.5) % Extra 0.5s wait for tolerance
                            
                            if (strcmp(app.scanModeContSAR,app.scanModeItemsContSAR(1)))
                                % Raster Scan Mode is selected
                                calllib('AMC4030','COM_API_Jog',0,-1*horizontalScanSize_mm,idleSpeed_mmps);
                                calllib('AMC4030','COM_API_Jog',1,stepVerticalMovement_mm(nV),idleSpeed_mmps);
                                
                                % Pause for movement
                                largerMovement_mm = horizontalScanSize_mm;
                                if (abs(stepVerticalMovement_mm(nV)) > abs(largerMovement_mm))
                                    largerMovement_mm = stepVerticalMovement_mm(nV);
                                end
                                motionTime_s = calculateMotionDuration(largerMovement_mm,idleSpeed_mmps,app.acceleration_mmps2);
                                pause(motionTime_s);
                                
                                app.totalHorizontalMovement_mm = app.totalHorizontalMovement_mm - horizontalScanSize_mm;
                                
                            else
                                % Rectangular Plane Scan Mode is selected
                                calllib('AMC4030','COM_API_Jog',1,stepVerticalMovement_mm(nV),idleSpeed_mmps);
                                
                                % Pause for movement
                                motionTime_s = calculateMotionDuration(stepVerticalMovement_mm(nV),idleSpeed_mmps,app.acceleration_mmps2);
                                pause(motionTime_s);
                                
                                % Inverse horizontal movement direction
                                horizontalScanSize_mm = -1*horizontalScanSize_mm;
                                
                            end
                            
                            % Update the total movement screen
                            app.totalVerticalMovement_mm = app.totalVerticalMovement_mm + stepVerticalMovement_mm(nV);
                            app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                                'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                            app.TotalMovementContSARTextArea.Value = app.textMovementString;
                            
                            pause(0.5) % Extra wait for tolerance
                            
                        end
                    end
                end
                
                app.StopCapturingContSARCommandButton.Enable = false;
                
                app.ContSARStatusTextArea.Value = 'Data is being transferred to PC ...';
                ErrStatus = Transfer_Data_to_PC(app.sourceHSDC,app.HSDCPRO_TimeoutInMs);
                if (ErrStatus ~= 0)
                    app.ContSARStatusTextArea.Value = 'Error inside Transfer_Data_to_PC';
                    return;
                else
                    app.ContSARStatusTextArea.Value = 'Data transferred to PC is successful';
                end

                % Copy raw data to outputFilePath
                mkdir(app.outputFilePath)
                copyfile(app.sourceHSDC,app.outputFilePath);
                
                % Save the chirp profile to the data folder, this is important to keep
                % Record the chirp configuration
                assignin('base', 'sensorParams', app.sensorParams);
                cmdStr = sprintf('save(''%ssensorParams.mat'',''%s'')',app.outputFilePath,'sensorParams');
                evalin('base',cmdStr);

                % Record the SAR configuration
                app.sarParams = createSarConfigurationParameters();
                app.sarParams.Num_verticalScan = app.VerticalScanStepsContSARSpinner.Value;
                app.sarParams.Horizontal_scanSize_mm = app.HorizontalScanSizemmContSAREditField.Value;
                app.sarParams.Vertical_stepSize_mm = str2num(app.VerticalStepSizemmContSAREditField.Value);
                app.sarParams.Platform_Speed_mmps = app.PlatformSpeedmmpsContSAREditField.Value;
                app.sarParams.Trigger_timeOffset_s = waitDuration_s;
                if (strcmp(app.scanModeContSAR,app.scanModeItemsContSAR(1)))
                    app.sarParams.scanTrajectoryMode = 'Raster';
                else
                    app.sarParams.scanTrajectoryMode = 'Rectangular'; % Rectangular Mode is the default
                end
                assignin('base', 'sarParams', app.sarParams);
                cmdStr = sprintf('save(''%ssarParams.mat'',''%s'')',app.outputFilePath,'sarParams');
                evalin('base',cmdStr);
                
                % Move to home point
                calllib('AMC4030','COM_API_Home',1,1,0);
                app.ContSARStatusTextArea.Value = 'Moving to home';
                
                % Pause for movement
                largerMovement_mm = app.totalHorizontalMovement_mm;
                if (abs(app.totalVerticalMovement_mm) > abs(largerMovement_mm))
                    largerMovement_mm = app.totalVerticalMovement_mm;
                end
                motionTime_s = calculateMotionDuration(largerMovement_mm,20,app.acceleration_mmps2);
                pause(motionTime_s); % Home speed is 20 mm/s
                
                app.totalHorizontalMovement_mm = 0;
                app.totalVerticalMovement_mm = 0;
                
                % Update the total movement screen
                app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                    'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                app.TotalMovementContSARTextArea.Value = app.textMovementString;
                app.TotalMovementTextArea.Value = app.textMovementString;
                app.TotalMovementDiscSARTextArea.Value = app.textMovementString;
                
            else
                app.ContSARStatusTextArea.Value = 'Please configure the radar and scanner for data capture';
            end
            
        end

        % Button pushed function: StopCapturingContSARCommandButton
        function StopCapturingContSARCommandButtonPushed(app, event)
            
            % Reconnect to the scanner (To avoid timeout)
            errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
            if (errorStatus ~= 1)
                return;
            end
            
            calllib('AMC4030','COM_API_StopAll');
            app.sarScenarioActive = false;
            
        end

        % Button pushed function: EmergencyStopScannerButton
        function EmergencyStopScannerButtonPushed(app, event)
            
            % Reconnect to the scanner (To avoid timeout)
            errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
            if (errorStatus ~= 1)
                return;
            end
            
            calllib('AMC4030','COM_API_StopAll');
            app.sarScenarioActive = false;
            
        end

        % Button pushed function: 
        % RecommendNumberOfFramesButtonContSAR
        function RecommendNumberOfFramesButtonContSARPushed(app, event)
            
            horizontalScanSize_mm = app.HorizontalScanSizemmContSAREditField.Value;
            sarSpeed_mmps = app.SpeedmmpsEditField.Value;
            
            motionTime_s = calculateMotionDuration(horizontalScanSize_mm,sarSpeed_mmps,app.acceleration_mmps2);
            
            framePeriodicity = app.FramePeriodicitymsContSAREditField.Value;
            waitDuration_s = app.WaitTimeBeforeCapturingContSAREditField.Value;
            
            numberOfFrames = floor((motionTime_s - 2*waitDuration_s) / (framePeriodicity/1000));
            
            % Find the smallest number that makes the #of samples per channesl as a multiple of 4096
            while(mod(app.sensorParams.Samples_per_Chirp*app.sensorParams.Chirps_per_Frame*app.sensorParams.Num_TX*numberOfFrames,4096)~=0)
                numberOfFrames = numberOfFrames + 1;
            end
            
            app.NumberofFramesContSAREditField.Value = numberOfFrames;
            
        end

        % Button pushed function: ConnectToScannerButton
        function ConnectToScannerButtonPushed(app, event)
            
            % Load the AMC4030 Library
            if ~libisloaded('AMC4030')
                loadlibrary('AMC4030.dll', @ComInterfaceHeader);
            end
            
            % Establish the communication
            calllib('AMC4030','COM_API_SetComType',2);
            errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
            if (errorStatus == 1)
                % Move to home
                calllib('AMC4030','COM_API_Home',1,1,0);
                
                app.ScannerConnectionStatusLamp.Color = 'green';
                app.isScannerConnected = true;
                
                if (app.isDataCaptureReady == true)
                    app.isSARDataCaptureReady = true;
                end
                
                app.SendSingleCommandButton.Enable = true;
                app.HomeButton.Enable = true;
                
                %% Update the movement screen
                app.totalHorizontalMovement_mm = 0;
                app.totalVerticalMovement_mm = 0;
                app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                    'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                app.TotalMovementTextArea.Value = app.textMovementString;
                app.TotalMovementContSARTextArea.Value = app.textMovementString;
                app.TotalMovementDiscSARTextArea.Value = app.textMovementString;
            else
                app.ScannerStatusTextArea.Value = "Error in AMC4030 connection";
            end
            
        end

        % Button pushed function: BrowseOutputBaseButton
        function BrowseOutputBaseButtonPushed(app, event)
            
            % Update Output File Base folder
            dirName = convertCharsToStrings(uigetdir);
            
            if (isstring(dirName))
                app.OutputBaseFolderEditField.Value =  dirName + '\';
            end
            
            app.SARGUI.Visible = 'off';
            app.SARGUI.Visible = 'on';
            
        end

        % Button pushed function: BrowseParamFileButton
        function BrowseParamFileButtonPushed(app, event)
            
            % Get the file name
            fileName = convertCharsToStrings(uigetfile);
            
            % Ignore the file extension
            if (isstring(fileName))
                app.ParamFileEditField.Value = extractBetween(fileName,1,'.');
            end
            
            app.SARGUI.Visible = 'off';
            app.SARGUI.Visible = 'on';
            
        end

        % Button pushed function: ConfigureParamFromFileButton
        function ConfigureParamFromFileButtonPushed(app, event)
            
            % Set paramFile
            app.sensorParamFile = app.ParamFileEditField.Value;
            
            % Set params variable
            cmdStr = sprintf('app.sensorParams = %s();',app.sensorParamFile);
            eval(cmdStr);
            
            % Update SAR configuration page parameters
            app.FramePeriodicitymsContSAREditField.Value = app.sensorParams.Frame_Repetition_Period_ms;
            app.NumberofFramesContSAREditField.Value = app.sensorParams.Num_Frames;
            
            % Set radar type
            app.radarType = app.RadarTypeSwitch.Value;
            app.radarTypeItems = app.RadarTypeSwitch.Items;
            
            % Set up the chirp parameters
            if (strcmp(app.radarType,app.radarTypeItems(1)))
                %% IWR 1443 Single Chip Radar is selected
                ErrStatus = Sensor_Config_chirpconfigs_Function(app.sensorParams);
                if (ErrStatus ~= 30000)
                    app.RadarStatusTextArea.Value = 'Error inside Sensor_Config_chirpconfigs_Function';
                    return;
                else
                    app.RadarStatusTextArea.Value = 'Sensor_Config_chirpconfigs_Function is successful';
                end
            else
                %% Other (TBD) Radar is selected
                app.RadarStatusTextArea.Value = 'This Radar version is not available';
            end
            
            app.isDataCaptureReady = true;
            
            if (app.isScannerConnected == true)
                app.isSARDataCaptureReady = true;
            end
            
            app.CaptureAndRecordButton.Enable = true;
            app.TriggerHSDCButton.Enable = true;
            app.TriggerFrameButton.Enable = true;
            
        end

        % Value changed function: ScannerTypeSwitch
        function ScannerTypeSwitchValueChanged(app, event)
            
            app.scannerType = app.ScannerTypeSwitch.Value;
            app.scannerTypeItems = app.ScannerTypeSwitch.Items;
            
             if (strcmp(app.scannerType,app.scannerTypeItems(1)))
                 
                 app.DesiredHorizontalMovementmmEditField.Limits = [-400,400];
                 app.DesiredVerticalMovementmmEditField.Limits = [-400,400];
                 app.HorizontalAxisLimitmmEditField.Value = 400;
                 app.VerticalAxisLimitmmEditField.Value = 400;
                 
                 app.SpeedmmpsEditField.Limits = [0,50];
                 app.SpeedmmpsEditField.Value = 20;
                 
                 app.IdleSpeedmmpsEditField.Limits = [0,50];
                 app.IdleSpeedmmpsEditField.Value = 20;
                 
                 app.PulsePerRevolutionEditField.Value = 5000;
                 app.DistancePerRevolutionmmEditField.Value = 5;
             else
                 app.DesiredHorizontalMovementmmEditField.Limits = [-900,900];
                 app.DesiredVerticalMovementmmEditField.Limits = [-900,900];
                 app.HorizontalAxisLimitmmEditField.Value = 900;
                 app.VerticalAxisLimitmmEditField.Value = 900;
                 
                 app.SpeedmmpsEditField.Limits = [0,400];
                 app.SpeedmmpsEditField.Value = 20;
                 
                 app.IdleSpeedmmpsEditField.Limits = [0,400];
                 app.IdleSpeedmmpsEditField.Value = 100;
                 
                 app.PulsePerRevolutionEditField.Value = 20000;
                 app.DistancePerRevolutionmmEditField.Value = 20;
             end
            
        end

        % Button pushed function: ReconfigureRadarContSARButton
        function ReconfigureRadarContSARButtonPushed(app, event)
            
            app.sensorParams.Frame_Repetition_Period_ms = app.FramePeriodicitymsContSAREditField.Value;
            app.sensorParams.Num_Frames = app.NumberofFramesContSAREditField.Value;
            
            %set up the chirp parameters
            if (strcmp(app.radarType,app.radarTypeItems(1)))
                %% IWR 1443 Single Chip Radar is selected
                ErrStatus = Sensor_Config_chirpconfigs_Function(app.sensorParams);
                if (ErrStatus ~= 30000)
                    app.ContSARStatusTextArea.Value = 'Error inside Sensor_Config_chirpconfigs_Function';
                    return;
                else
                    app.ContSARStatusTextArea.Value = 'Sensor_Config_chirpconfigs_Function is successful';
                end
            else
                %% Other (TBD) Radar is selected
                app.ContSARStatusTextArea.Value = 'This Radar version is not available';
            end
            
            % Calculate the number of samples per channel for data capture from HSDC Pro
            numberOfVerticalSteps = app.VerticalScanStepsContSARSpinner.Value;
            app.numberOfSamplesPerChannel = app.sensorParams.Samples_per_Chirp*app.sensorParams.Chirps_per_Frame*app.sensorParams.Num_TX*app.sensorParams.Num_Frames;
            app.numberOfSamplesPerChannel = app.numberOfSamplesPerChannel * numberOfVerticalSteps;
            
            if (mod(app.numberOfSamplesPerChannel,4096))
                uialert(app.SARGUI,'The total number of samples is not divisible by 4096','Warning', 'Icon','warning');
                return;
            elseif (app.numberOfSamplesPerChannel > app.samplesPerChannelLimit)
                uialert(app.SARGUI,'The total number of samples is greater than TSW limits','Warning', 'Icon','warning');
                return;
            end
            
            % Trigger HSDCPRO
            ErrStatus = Trigger_HSDCPRO(app.numberOfSamplesPerChannel,app.HSDCPRO_TimeoutInMs);
            if (ErrStatus ~= 0)
                app.ContSARStatusTextArea.Value = 'Error inside Trigger_HSDCPRO';
                return;
            else
                app.ContSARStatusTextArea.Value = 'Trigger_HSDCPRO is successful';
            end
            
        end

        % Button pushed function: StopCapturingDiscSARCommandButton
        function StopCapturingDiscSARCommandButtonPushed(app, event)
            
            % Reconnect to the scanner (To avoid timeout)
            errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
            if (errorStatus ~= 1)
                return;
            end
            
            calllib('AMC4030','COM_API_StopAll');
            app.sarScenarioActive = false;
            
        end

        % Button pushed function: StartCapturingDiscSARCommandButton
        function StartCapturingDiscSARCommandButtonPushed(app, event)
            
            % Start data capture process
            if (app.isSARDataCaptureReady)

                % Set the outputFileBase and outputFilePath
                app.outputFileBase = createOutputFileBase(app.OutputBaseFolderEditField.Value,app.ExperimentFolderEditField.Value);
                [app.outputFilePath, ~] = createOutputFilePath(app.outputFileBase);
                
                % Define the scanner speed parameters
                idleSpeed_mmps = app.IdleSpeedmmpsEditField.Value;
                
                % Get the horizontal step data
                numberOfHorizontalSteps = app.HorizontalScanStepsDiscSARSpinner.Value;
                stepHorizontalMovement_mm = app.HorizontalStepSizemmDiscSAREditField.Value;
                
                % Get the vertical step data
                numberOfVerticalSteps = app.VerticalScanStepsDiscSARSpinner.Value;
                stepVerticalMovement_mm = str2num(app.VerticalStepSizemmDiscSAREditField.Value);
                stepVerticalMovement_mm = repmat(stepVerticalMovement_mm,1,ceil(numberOfVerticalSteps/length(stepVerticalMovement_mm)));
                stepVerticalMovement_mm = stepVerticalMovement_mm(1:numberOfVerticalSteps-1);
                
                % Set the wait time between steps
                waitDuration_s = app.WaitTimeBetweenStepsDiscSAREditField.Value;
                
                % Start SAR Data capture
                app.sarScenarioActive = true;
                app.StopCapturingDiscSARCommandButton.Enable = true;
                
                nTriggers = 1; % To follow the number of triggers
                for nV = 1:numberOfVerticalSteps
                    
                    % Reconnect to the scanner (To avoid timeout) 
                    errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
                    if (errorStatus ~= 1)
                        app.DiscSARStatusTextArea.Value = 'Error in the scanner connection';
                        return;
                    end
                    
                    % If the Capturing process has stopped, exit from the function the loop
                    if (~app.sarScenarioActive)
                        app.DiscSARStatusTextArea.Value = 'SAR process has been stopped.';
                        return;
                    end
                    
                    for nH = 1:numberOfHorizontalSteps
                        
                        if (~app.sarScenarioActive)
                            app.DiscSARStatusTextArea.Value = 'SAR process has been stopped.';
                            return;
                        end
                        
                        % Wait before trigger
                        pause(abs(waitDuration_s/2))
                        
                        % Trigger Frames
                        if (strcmp(app.radarType,app.radarTypeItems(1)))
                            %% IWR 1443 Single Chip Radar is selected
                            Lua_String = sprintf('ar1.StartFrame()');
                            ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
                            if (ErrStatus ~=30000)
                                app.DiscSARStatusTextArea.Value = 'Trigger Frame failed for IWR 1443';
                                return;
                            else
                                app.DiscSARStatusTextArea.Value = ['Trigger Frame ', num2str(nTriggers), ' is successful']; nTriggers = nTriggers + 1;
                            end
                        else
                            %% Other (TBD) Radar is selected
                            app.DiscSARStatusTextArea.Value = 'This Radar version is not available';
                        end
                        
                        % Wait till the TSW memory is filled with data
                        pause(app.sensorParams.Num_Frames*app.sensorParams.Frame_Repetition_Period_ms/1000);
                        
                        % Wait after trigger
                        pause(abs(waitDuration_s/2))
                        
                        % Move one step
                        if (nH ~= numberOfHorizontalSteps)
                            calllib('AMC4030','COM_API_Jog',0,stepHorizontalMovement_mm,idleSpeed_mmps);
                            
                            % Pause for movement
                            motionTime_s = calculateMotionDuration(stepHorizontalMovement_mm,idleSpeed_mmps,app.acceleration_mmps2);
                            pause(motionTime_s);
                            
                            % Update the total movement screen
                            app.totalHorizontalMovement_mm = app.totalHorizontalMovement_mm + stepHorizontalMovement_mm;
                            app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                                'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                            app.TotalMovementDiscSARTextArea.Value = app.textMovementString;
                        end
                        
                    end
                    
                    if (app.sarScenarioActive)
                        
                        if nV ~= numberOfVerticalSteps
                            pause(abs(waitDuration_s/2)) % Wait for tolerance
                            
                            calllib('AMC4030','COM_API_Jog',1,stepVerticalMovement_mm(nV),idleSpeed_mmps);
                            
                            % Pause for movement
                            motionTime_s = calculateMotionDuration(stepVerticalMovement_mm(nV),idleSpeed_mmps,app.acceleration_mmps2);
                            pause(motionTime_s);
                            
                            % Update the total movement screen
                            app.totalVerticalMovement_mm = app.totalVerticalMovement_mm + stepVerticalMovement_mm(nV);
                            app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                                'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                            app.TotalMovementDiscSARTextArea.Value = app.textMovementString;
                            
                            % Inverse horizontal movement direction
                            stepHorizontalMovement_mm = -1*stepHorizontalMovement_mm;
                            
                            pause(abs(waitDuration_s/2)) % Wait for tolerance
                            
                        end
                    end
                end
                
                app.StopCapturingDiscSARCommandButton.Enable = false;
                
                app.DiscSARStatusTextArea.Value = 'Data is being transferred to PC ...';
                ErrStatus = Transfer_Data_to_PC(app.sourceHSDC,app.HSDCPRO_TimeoutInMs);
                if (ErrStatus ~= 0)
                    app.DiscSARStatusTextArea.Value = 'Error inside Transfer_Data_to_PC';
                    return;
                else
                    app.DiscSARStatusTextArea.Value = 'Data transferred to PC is successful';
                end

                % Copy raw data to outputFilePath
                mkdir(app.outputFilePath)
                copyfile(app.sourceHSDC,app.outputFilePath);
                
                % Save the chirp profile to the data folder, this is important to keep
                % Record the chirp configuration
                assignin('base', 'sensorParams', app.sensorParams);
                cmdStr = sprintf('save(''%ssensorParams.mat'',''%s'')',app.outputFilePath,'sensorParams');
                evalin('base',cmdStr);

                % Record the SAR configuration
                app.sarParams = createSarConfigurationParameters();
                app.sarParams.Num_horizontalScan = app.HorizontalScanStepsDiscSARSpinner.Value;
                app.sarParams.Num_verticalScan = app.VerticalScanStepsDiscSARSpinner.Value;
                app.sarParams.Horizontal_stepSize_mm = app.HorizontalStepSizemmDiscSAREditField.Value;
                app.sarParams.Vertical_stepSize_mm = str2num(app.VerticalStepSizemmDiscSAREditField.Value);
                app.sarParams.dataCaptureMode = 'Discrete';
                assignin('base', 'sarParams', app.sarParams);
                cmdStr = sprintf('save(''%ssarParams.mat'',''%s'')',app.outputFilePath,'sarParams');
                evalin('base',cmdStr);
                
                % Move to home point
                calllib('AMC4030','COM_API_Home',1,1,0);
                app.ContSARStatusTextArea.Value = 'Moving to home';
                
                % Pause for movement
                largerMovement_mm = app.totalHorizontalMovement_mm;
                if (abs(app.totalVerticalMovement_mm) > abs(largerMovement_mm))
                    largerMovement_mm = app.totalVerticalMovement_mm;
                end
                motionTime_s = calculateMotionDuration(largerMovement_mm,20,app.acceleration_mmps2);
                pause(motionTime_s); % Home speed is 20 mm/s
                
                app.totalHorizontalMovement_mm = 0;
                app.totalVerticalMovement_mm = 0;
                
                % Update the total movement screen
                app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                    'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                app.TotalMovementDiscSARTextArea.Value = app.textMovementString;
                app.TotalMovementTextArea.Value = app.textMovementString;
                app.TotalMovementContSARTextArea.Value = app.textMovementString;
            
            else
                app.DiscSARStatusTextArea.Value = 'Please configure the radar and scanner for data capture';
            end
            
        end

        % Button pushed function: ReconfigureRadarDiscSARButton
        function ReconfigureRadarDiscSARButtonPushed(app, event)
            
            app.sensorParams.Num_Frames = app.NumberofFramesDiscSAREditField.Value;
            
            %set up the chirp parameters
            if (strcmp(app.radarType,app.radarTypeItems(1)))
                %% IWR 1443 Single Chip Radar is selected
                ErrStatus = Sensor_Config_chirpconfigs_Function(app.sensorParams);
                if (ErrStatus ~= 30000)
                    app.DiscSARStatusTextArea.Value = 'Error inside Sensor_Config_chirpconfigs_Function';
                    return;
                else
                    app.DiscSARStatusTextArea.Value = 'Sensor_Config_chirpconfigs_Function is successful';
                end
            else
                %% Other (TBD) Radar is selected
                app.DiscSARStatusTextArea.Value = 'This Radar version is not available';
            end
            
            % Calculate the number of samples per channel for data capture from HSDC Pro
            numberOfHorizontalSteps = app.HorizontalScanStepsDiscSARSpinner.Value;
            numberOfVerticalSteps = app.VerticalScanStepsDiscSARSpinner.Value;
            app.numberOfSamplesPerChannel = app.sensorParams.Samples_per_Chirp*app.sensorParams.Chirps_per_Frame*app.sensorParams.Num_TX*app.sensorParams.Num_Frames;
            app.numberOfSamplesPerChannel = app.numberOfSamplesPerChannel * numberOfHorizontalSteps * numberOfVerticalSteps;
            
            if (mod(app.numberOfSamplesPerChannel,4096))
                uialert(app.SARGUI,'The total number of samples is not divisible by 4096','Warning', 'Icon','warning');
                return;
            elseif (app.numberOfSamplesPerChannel > app.samplesPerChannelLimit)
                uialert(app.SARGUI,'The total number of samples is greater than TSW limits','Warning', 'Icon','warning');
                return;
            end
            
            % Trigger HSDCPRO
            ErrStatus = Trigger_HSDCPRO(app.numberOfSamplesPerChannel,app.HSDCPRO_TimeoutInMs);
            if (ErrStatus ~= 0)
                app.DiscSARStatusTextArea.Value = 'Error inside Trigger_HSDCPRO';
                return;
            else
                app.DiscSARStatusTextArea.Value = 'Trigger_HSDCPRO is successful';
            end
            
        end

        % Button pushed function: UpdateParamsDiscSARButton
        function UpdateParamsDiscSARButtonPushed(app, event)
            
            app.sensorParams.Num_Frames = app.NumberofFramesDiscSAREditField.Value;
            
            % Update number of samples per channel
            numberOfHorizontalSteps = app.HorizontalScanStepsDiscSARSpinner.Value;
            numberOfVerticalSteps = app.VerticalScanStepsDiscSARSpinner.Value;
            app.numberOfSamplesPerChannel = app.sensorParams.Samples_per_Chirp*app.sensorParams.Chirps_per_Frame*app.sensorParams.Num_TX*app.sensorParams.Num_Frames;
            app.numberOfSamplesPerChannel = app.numberOfSamplesPerChannel * numberOfHorizontalSteps * numberOfVerticalSteps;
            % Update
            app.NumberofSamplesPerChannelDiscSAREditField.Value = app.numberOfSamplesPerChannel;
            
            % Update total scan size
            app.HorizontalScanSizemmDiscSAREditField.Value = app.HorizontalStepSizemmDiscSAREditField.Value * (numberOfHorizontalSteps-1);
            
            stepVerticalMovement_mm = str2num(app.VerticalStepSizemmDiscSAREditField.Value);
            stepVerticalMovement_mm = repmat(stepVerticalMovement_mm,1,ceil(numberOfVerticalSteps/length(stepVerticalMovement_mm)));
            stepVerticalMovement_mm = stepVerticalMovement_mm(1:numberOfVerticalSteps-1);
            app.VerticalScanSizemmDiscSAREditField.Value = sum(stepVerticalMovement_mm);
            
        end

        % Button pushed function: UpdateParamsContSARButton
        function UpdateParamsContSARButtonPushed(app, event)
            
            app.PlatformSpeedmmpsContSAREditField.Value = app.SpeedmmpsEditField.Value;
            
            app.sensorParams.Frame_Repetition_Period_ms = app.FramePeriodicitymsContSAREditField.Value;
            app.sensorParams.Num_Frames = app.NumberofFramesContSAREditField.Value;
            
            % Update number of samples per channel
            numberOfVerticalSteps = app.VerticalScanStepsContSARSpinner.Value;
            app.numberOfSamplesPerChannel = app.sensorParams.Samples_per_Chirp*app.sensorParams.Chirps_per_Frame*app.sensorParams.Num_TX*app.sensorParams.Num_Frames;
            app.numberOfSamplesPerChannel = app.numberOfSamplesPerChannel * numberOfVerticalSteps;
            % Update
            app.NumberofSamplesPerChannelContSAREditField.Value = app.numberOfSamplesPerChannel;
            
            % Update total vertical scan size
            stepVerticalMovement_mm = str2num(app.VerticalStepSizemmContSAREditField.Value);
            stepVerticalMovement_mm = repmat(stepVerticalMovement_mm,1,ceil(numberOfVerticalSteps/length(stepVerticalMovement_mm)));
            stepVerticalMovement_mm = stepVerticalMovement_mm(1:numberOfVerticalSteps-1);
            app.VerticalScanSizemmContSAREditField.Value = sum(stepVerticalMovement_mm);
            
            % Update horizontal step size
            app.HorizontalStepSizemmContSAREditField.Value = app.PlatformSpeedmmpsContSAREditField.Value * app.FramePeriodicitymsContSAREditField.Value * 1e-3;
            
        end

        % Button pushed function: TriggerHSDCButton
        function TriggerHSDCButtonPushed(app, event)
            
            % Calculate the number of samples per channel for data capture from HSDC Pro
            app.numberOfSamplesPerChannel = app.sensorParams.Samples_per_Chirp*app.sensorParams.Chirps_per_Frame*app.sensorParams.Num_TX*app.sensorParams.Num_Frames;
            app.numberOfSamplesPerChannel = app.numberOfSamplesPerChannel*app.ofMeasurementsSpinner.Value;
            % Update
            app.NumberofSamplesPerChannelEditField.Value = app.numberOfSamplesPerChannel;
            
            % Check the number of samples per channel
            if (mod(app.numberOfSamplesPerChannel,4096))
                uialert(app.SARGUI,'The total number of samples is not divisible by 4096','Warning', 'Icon','warning');
                return;
            elseif (app.numberOfSamplesPerChannel > app.samplesPerChannelLimit)
                uialert(app.SARGUI,'The total number of samples is greater than TSW limits','Warning', 'Icon','warning');
                return;
            end

            % Trigger HSDCPRO
            ErrStatus = Trigger_HSDCPRO(app.numberOfSamplesPerChannel,app.HSDCPRO_TimeoutInMs);
            if (ErrStatus ~= 0)
                app.RadarStatusTextArea.Value = 'Error inside Trigger_HSDCPRO';
                return;
            else
                app.RadarStatusTextArea.Value = 'Trigger_HSDCPRO is successful';
            end

            app.currentTriggeredFrameNumber = 1;
            
        end

        % Button pushed function: TriggerFrameButton
        function TriggerFrameButtonPushed(app, event)
            
            % Trigger Frames
            n = app.currentTriggeredFrameNumber;
            
            if (strcmp(app.radarType,app.radarTypeItems(1)))
                %% IWR 1443 Single Chip Radar is selected
                Lua_String = sprintf('ar1.StartFrame()');
                ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
                if (ErrStatus ~=30000)
                    app.RadarStatusTextArea.Value = 'Trigger Frame failed for IWR 1443';
                    return;
                else
                    %Wait till the TSW memory is filled with data
                    pause(app.sensorParams.Num_Frames * app.sensorParams.Frame_Repetition_Period_ms / 1000);
                    
                    app.RadarStatusTextArea.Value = ['Trigger Frame ', num2str(n), ' for IWR 1443 is successful'];
                    app.currentTriggeredFrameNumber = app.currentTriggeredFrameNumber + 1;
                end
            else
                %% Other (TBD) Radar is selected
                app.RadarStatusTextArea.Value = 'This Radar version is not available';
            end
            
            % Tolerance delay for 1 sec !!! Can be tuned better
            pause(1);
            
            if (n == app.ofMeasurementsSpinner.Value)
                app.RecordDataButton.Enable = true;
            end
            
        end

        % Button pushed function: RecordDataButton
        function RecordDataButtonPushed(app, event)
            
            % Set the outputFileBase and outputFilePath
            app.outputFileBase = createOutputFileBase(app.OutputBaseFolderEditField.Value,app.ExperimentFolderEditField.Value);
            [app.outputFilePath, ~] = createOutputFilePath(app.outputFileBase);
            
            % Transfer Data to PC
            ErrStatus = Transfer_Data_to_PC(app.sourceHSDC,app.HSDCPRO_TimeoutInMs);
            if (ErrStatus ~= 0)
                app.RadarStatusTextArea.Value = 'Error inside Transfer_Data_to_PC';
                return;
            else
                app.RadarStatusTextArea.Value = 'Data capture process is successful';
            end
            
            % Copy raw data to outputFilePath
            mkdir(app.outputFilePath)
            copyfile(app.sourceHSDC,app.outputFilePath);
            
            % Save the chirp profile to the data folder, this is important to keep
            % Record the chirp configuration
            assignin('base', 'sensorParams', app.sensorParams);
            cmdStr = sprintf('save(''%ssensorParams.mat'',''%s'')',app.outputFilePath,'sensorParams');
            evalin('base',cmdStr);
            
            % Record the SAR configuration
            app.sarParams = createSarConfigurationParameters();
            app.sarParams.Num_horizontalScan = app.ofMeasurementsSpinner.Value;
            app.sarParams.dataCaptureMode = 'Stationary';
            assignin('base', 'sarParams', app.sarParams);
            cmdStr = sprintf('save(''%ssarParams.mat'',''%s'')',app.outputFilePath,'sarParams');
            evalin('base',cmdStr);
            
        end

        % Value changed function: SpeedmmpsEditField
        function SpeedmmpsEditFieldValueChanged(app, event)
            
            speed_mmps = app.SpeedmmpsEditField.Value;
            app.PlatformSpeedmmpsContSAREditField.Value = speed_mmps;
            
        end

        % Button pushed function: ConnectToSARSyncButton
        function ConnectToSARSyncButtonPushed(app, event)
                      
            % Establish the communication
            try
                app.SarSync = SarSyncApi("COM" + app.SARSyncCOMPortEditField.Value);
            catch ME
                app.ContSARHwTrgStatusTextArea.Value = ME.identifier;
                return;
            end
            
            app.SARSyncConnectionStatusLamp.Color = 'green';
            app.isSARSyncConnected = true;
            
        end

        % Button pushed function: 
        % ReconfigureRadarSARSyncContSARHwTrgButton
        function ReconfigureRadarSARSyncContSARHwTrgButtonPushed(app, event)
                       
            %--- Calculate the recommended the Frame periodicity ---%
            frameDuration_us = (app.sensorParams.Idle_Time_us + app.sensorParams.Ramp_End_Time_us) ...
                                * app.sensorParams.Num_chirpConfigs * app.sensorParams.Chirps_per_Frame;
            recommendedFramePeriodicity_ms = frameDuration_us * 1e-3 * 2; % For the % 50 Duty Cycle

            app.FramePeriodicitymsContSARHwTrgEditField.Value = recommendedFramePeriodicity_ms;
            app.sensorParams.Frame_Repetition_Period_ms = app.FramePeriodicitymsContSARHwTrgEditField.Value;
            
            % Calculate the total number of frames ---%
            numberOfHorizontalSteps = app.HorizontalScanStepsContSARHwTrgSpinner.Value;
            numberOfVerticalSteps = app.VerticalScanStepsContSARHwTrgSpinner.Value;
            
            app.NumberofFramesContSARHwTrgEditField.Value = numberOfHorizontalSteps * numberOfVerticalSteps;
            app.sensorParams.Num_Frames = app.NumberofFramesContSARHwTrgEditField.Value;
            
            %--- Set the Hardware Trigger Mode ---%
            app.sensorParams.TriggerSelect_Arr = 2;
            
            %--- Configure SAR Sync ---%
            % Calculate the pulse per horizontal step
            pulsePerStep = round(app.HorizontalStepSizemmContSARHwTrgEditField.Value ...
                * app.PulsePerRevolutionEditField.Value ...
                / app.DistancePerRevolutionmmEditField.Value);
            app.NumberofPulsesPerStepContSARHwTrgEditField.Value = pulsePerStep;
            % Validate
            if (pulsePerStep > app.pulseCounterUpperLimit)
                uialert(app.SARGUI,sprintf('The maximum allowed pulse number for the SAR Sync FW is: %u', app.pulseCounterUpperLimit),'Warning', 'Icon','warning');
                return;
            end
            % Set pulse counter
            app.SarSync.setPulseCount(pulsePerStep);
            % Reset pulse counter
            app.SarSync.resetPcnt();
            % Set desired Radar trigger
            app.SarSync.setDesiredRadarTrigger(numberOfHorizontalSteps);
            
            %--- Recalculate the horizontal step ---%
            app.HorizontalStepSizemmContSARHwTrgEditField.Value = pulsePerStep ...
                * app.DistancePerRevolutionmmEditField.Value / app.PulsePerRevolutionEditField.Value;
            
            % Update total vertical scan size
            stepVerticalMovement_mm = str2num(app.VerticalStepSizemmContSARHwTrgEditField.Value);
            stepVerticalMovement_mm = repmat(stepVerticalMovement_mm,1,ceil(numberOfVerticalSteps/length(stepVerticalMovement_mm)));
            stepVerticalMovement_mm = stepVerticalMovement_mm(1:numberOfVerticalSteps-1);
            app.VerticalScanSizemmContSARHwTrgEditField.Value = sum(stepVerticalMovement_mm);
            
            % Update total horizontal scan size
            app.HorizontalScanSizemmContSARHwTrgEditField.Value = ...
                (app.HorizontalScanStepsContSARHwTrgSpinner.Value - 1) * ...
                app.HorizontalStepSizemmContSARHwTrgEditField.Value;
            
            %--- Validate the maximum speed ---%
            sarSpeed_mmps = app.SpeedmmpsEditField.Value;
            maxAllowedSpeed_mmps = floor(app.HorizontalStepSizemmContSARHwTrgEditField.Value / (recommendedFramePeriodicity_ms * 1e-3));
            % Validate
            if (sarSpeed_mmps > maxAllowedSpeed_mmps)
                uialert(app.SARGUI,sprintf('The maximum allowed speed for this configuration is: %d mm/s', maxAllowedSpeed_mmps),'Warning', 'Icon','warning');
                return;
            end
            
            %--- Set up the chirp parameters ---%
            if (strcmp(app.radarType,app.radarTypeItems(1)))
                %% IWR 1443 Single Chip Radar is selected
                ErrStatus = Sensor_Config_chirpconfigs_Function(app.sensorParams);
                if (ErrStatus ~= 30000)
                    app.ContSARHwTrgStatusTextArea.Value = 'Error inside Sensor_Config_chirpconfigs_Function';
                    return;
                else
                    app.ContSARHwTrgStatusTextArea.Value = 'Sensor_Config_chirpconfigs_Function is successful';
                end
            else
                %% Other (TBD) Radar is selected
                app.ContSARHwTrgStatusTextArea.Value = 'This Radar version is not available';
            end
            
            %--- Calculate the number of samples per channel for data capture from HSDC Pro ---%
            app.numberOfSamplesPerChannel = app.sensorParams.Samples_per_Chirp ...
                *app.sensorParams.Chirps_per_Frame ...
                *app.sensorParams.Num_chirpConfigs ...
                *app.sensorParams.Num_Frames;
            
            % Update
            app.NumberofSamplesPerChannelContSARHwTrgEditField.Value = app.numberOfSamplesPerChannel;
            
            % Validate
            if (mod(app.numberOfSamplesPerChannel,4096))
                uialert(app.SARGUI,'The total number of samples is not divisible by 4096','Warning', 'Icon','warning');
                return;
            elseif (app.numberOfSamplesPerChannel > app.samplesPerChannelLimit)
                uialert(app.SARGUI,'The total number of samples is greater than TSW limits','Warning', 'Icon','warning');
                return;
            end
            
            %--- Trigger HSDCPRO ---%
            ErrStatus = Trigger_HSDCPRO(app.numberOfSamplesPerChannel,app.HSDCPRO_TimeoutInMs);
            if (ErrStatus ~= 0)
                app.ContSARHwTrgStatusTextArea.Value = 'Error inside Trigger_HSDCPRO';
                return;
            else
                app.ContSARHwTrgStatusTextArea.Value = 'Trigger_HSDCPRO is successful';
            end
            
        end

        % Button pushed function: 
        % StartCapturingContSARHwTrgCommandButton
        function StartCapturingContSARHwTrgCommandButtonPushed(app, event)
            
            % Start data capture process
            if (app.isSARDataCaptureReady)

                % Set the outputFileBase and outputFilePath
                app.outputFileBase = createOutputFileBase(app.OutputBaseFolderEditField.Value,app.ExperimentFolderEditField.Value);
                [app.outputFilePath, ~] = createOutputFilePath(app.outputFileBase);
                
                % Define the scanner speed parameters
                sarSpeed_mmps = app.SpeedmmpsEditField.Value;
                idleSpeed_mmps = app.IdleSpeedmmpsEditField.Value;
                
                % Get the horizontal scan size
                horizontalScanSize_mm = app.HorizontalScanSizemmContSARHwTrgEditField.Value;
                
                % Get the vertical step distance
                numberOfVerticalSteps = app.VerticalScanStepsContSARHwTrgSpinner.Value;
                stepVerticalMovement_mm = str2num(app.VerticalStepSizemmContSARHwTrgEditField.Value);
                stepVerticalMovement_mm = repmat(stepVerticalMovement_mm,1,ceil(numberOfVerticalSteps/length(stepVerticalMovement_mm)));
                stepVerticalMovement_mm = stepVerticalMovement_mm(1:numberOfVerticalSteps-1);
                              
                % Set scan mode
                app.scanModeContSAR = app.ScanModeContSARHwTrgSwitch.Value;
                app.scanModeItemsContSAR = app.ScanModeContSARHwTrgSwitch.Items;
                
                % Start SAR Data capture
                app.sarScenarioActive = true;
                app.StopCapturingContSARHwTrgCommandButton.Enable = true;
                
                % Reset pulse counter
                app.SarSync.resetPcnt();
                
                %--- Trigger Frames ---%
                if (strcmp(app.radarType,app.radarTypeItems(1)))
                    %% IWR 1443 Single Chip Radar is selected
                    Lua_String = sprintf('ar1.StartFrame()');
                    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
                    if (ErrStatus ~=30000)
                        app.ContSARHwTrgStatusTextArea.Value = 'Trigger Frame failed for IWR 1443';
                        return;
                    end
                else
                    %% Other (TBD) Radar is selected
                    app.ContSARHwTrgStatusTextArea.Value = 'This Radar version is not available';
                end
                
                % Start scanning
                for nV = 1:numberOfVerticalSteps
                    
                    % Reconnect to the scanner (To avoid timeout) 
                    errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
                    if (errorStatus ~= 1)
                        app.ContSARHwTrgStatusTextArea.Value = 'Error in the scanner connection';
                        return;
                    end
                    
                    % If the Capturing process has stopped, exit from the function the loop
                    if (~app.sarScenarioActive)
                        app.ContSARHwTrgStatusTextArea.Value = 'SAR process has been stopped.';
                        return;
                    end
                    
                    % Call the Radar Trigger Command once
                    app.SarSync.radarTrigger();
                    
                    % Start horizontal movement
                    calllib('AMC4030','COM_API_Jog',0,horizontalScanSize_mm,sarSpeed_mmps);
                    
                    % Pause for movement
                    motionTime_s = calculateMotionDuration(horizontalScanSize_mm,sarSpeed_mmps,app.acceleration_mmps2);
                    pause(motionTime_s);
                    
                    pause(0.5) % Extra 0.5s wait for tolerance
                    
                    % Update the total movement screen
                    app.totalHorizontalMovement_mm = app.totalHorizontalMovement_mm + horizontalScanSize_mm;
                    app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                        'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                    app.TotalMovementContSARHwTrgTextArea.Value = app.textMovementString;
                    
                    if (app.sarScenarioActive)
                        
                        if nV ~= numberOfVerticalSteps
                            
                            if (strcmp(app.scanModeContSAR,app.scanModeItemsContSAR(1)))
                                % Raster Scan Mode is selected
                                calllib('AMC4030','COM_API_Jog',0,-1*horizontalScanSize_mm,idleSpeed_mmps);
                                calllib('AMC4030','COM_API_Jog',1,stepVerticalMovement_mm(nV),idleSpeed_mmps);
                                
                                % Pause for movement
                                largerMovement_mm = horizontalScanSize_mm;
                                if (abs(stepVerticalMovement_mm(nV)) > abs(largerMovement_mm))
                                    largerMovement_mm = stepVerticalMovement_mm(nV);
                                end
                                motionTime_s = calculateMotionDuration(largerMovement_mm,idleSpeed_mmps,app.acceleration_mmps2);
                                pause(motionTime_s);
                                
                                app.totalHorizontalMovement_mm = app.totalHorizontalMovement_mm - horizontalScanSize_mm;
                                
                            else
                                % Rectangular Plane Scan Mode is selected
                                calllib('AMC4030','COM_API_Jog',1,stepVerticalMovement_mm(nV),idleSpeed_mmps);
                                
                                % Pause for movement
                                motionTime_s = calculateMotionDuration(stepVerticalMovement_mm(nV),idleSpeed_mmps,app.acceleration_mmps2);
                                pause(motionTime_s);
                                
                                % Inverse horizontal movement direction
                                horizontalScanSize_mm = -1*horizontalScanSize_mm;
                                
                            end
                            
                            % Update the total movement screen
                            app.totalVerticalMovement_mm = app.totalVerticalMovement_mm + stepVerticalMovement_mm(nV);
                            app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                                'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                            app.TotalMovementContSARHwTrgTextArea.Value = app.textMovementString;
                            
                            pause(0.5) % Extra wait for tolerance
                            
                        end
                    end
                end
                
                app.StopCapturingContSARHwTrgCommandButton.Enable = false;
                
                % Pause pulse counter
                app.SarSync.pausePcnt();
                
                % Capture raw Data from TWS
                app.ContSARHwTrgStatusTextArea.Value = 'Data is being transferred to PC ...';
                ErrStatus = Transfer_Data_to_PC(app.sourceHSDC,app.HSDCPRO_TimeoutInMs);
                if (ErrStatus ~= 0)
                    app.ContSARHwTrgStatusTextArea.Value = 'Error inside Transfer_Data_to_PC';
                    return;
                else
                    app.ContSARHwTrgStatusTextArea.Value = 'Data transferred to PC is successful';
                end

                % Copy raw data to outputFilePath
                mkdir(app.outputFilePath)
                copyfile(app.sourceHSDC,app.outputFilePath);
                
                % Save the chirp profile to the data folder, this is important to keep
                % Record the chirp configuration
                assignin('base', 'sensorParams', app.sensorParams);
                cmdStr = sprintf('save(''%ssensorParams.mat'',''%s'')',app.outputFilePath,'sensorParams');
                evalin('base',cmdStr);

                % Record the SAR configuration
                app.sarParams = createSarConfigurationParameters();
                app.sarParams.Num_horizontalScan = app.HorizontalScanStepsContSARHwTrgSpinner.Value;
                app.sarParams.Num_verticalScan = app.VerticalScanStepsContSARHwTrgSpinner.Value;
                app.sarParams.Horizontal_stepSize_mm = app.HorizontalStepSizemmContSARHwTrgEditField.Value;
                app.sarParams.Vertical_stepSize_mm = str2num(app.VerticalStepSizemmContSARHwTrgEditField.Value);
                app.sarParams.Platform_Speed_mmps = sarSpeed_mmps;
                app.sarParams.triggerMode = 'Hardware';
                if (strcmp(app.scanModeContSAR,app.scanModeItemsContSAR(1)))
                    app.sarParams.scanTrajectoryMode = 'Raster';
                else
                    app.sarParams.scanTrajectoryMode = 'Rectangular'; % Rectangular Mode is the default
                end
                assignin('base', 'sarParams', app.sarParams);
                cmdStr = sprintf('save(''%ssarParams.mat'',''%s'')',app.outputFilePath,'sarParams');
                evalin('base',cmdStr);
                
                % Move to home point
                calllib('AMC4030','COM_API_Home',1,1,0);
                app.ContSARHwTrgStatusTextArea.Value = 'Moving to home';
                
                % Pause for movement
                largerMovement_mm = app.totalHorizontalMovement_mm;
                if (abs(app.totalVerticalMovement_mm) > abs(largerMovement_mm))
                    largerMovement_mm = app.totalVerticalMovement_mm;
                end
                motionTime_s = calculateMotionDuration(largerMovement_mm,20,app.acceleration_mmps2);
                pause(motionTime_s); % Home speed is 20 mm/s
                
                app.totalHorizontalMovement_mm = 0;
                app.totalVerticalMovement_mm = 0;
                
                % Update the total movement screen
                app.textMovementString = ['Horizontal:    ', num2str(app.totalHorizontalMovement_mm), ' mm', newline, newline, ...;
                    'Vertical:        ', num2str(app.totalVerticalMovement_mm), ' mm'];
                app.TotalMovementContSARHwTrgTextArea.Value = app.textMovementString;
                app.TotalMovementContSARTextArea.Value = app.textMovementString;
                app.TotalMovementTextArea.Value = app.textMovementString;
                app.TotalMovementDiscSARTextArea.Value = app.textMovementString;
                
            else
                app.ContSARHwTrgStatusTextArea.Value = 'Please configure the radar and scanner for data capture';
            end
            
        end

        % Button pushed function: 
        % StopCapturingContSARHwTrgCommandButton
        function StopCapturingContSARHwTrgCommandButtonPushed(app, event)
            
            % Reconnect to the scanner (To avoid timeout)
            errorStatus = calllib('AMC4030','COM_API_OpenLink',app.ScannerCOMPortEditField.Value,115200);
            if (errorStatus ~= 1)
                return;
            end
            
            calllib('AMC4030','COM_API_StopAll');
            app.sarScenarioActive = false;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create SARGUI and hide until all components are created
            app.SARGUI = uifigure('Visible', 'off');
            app.SARGUI.AutoResizeChildren = 'off';
            app.SARGUI.Color = [1 1 1];
            app.SARGUI.Position = [100 100 1233 747];
            app.SARGUI.Name = 'SAR Imaging Toolbox';
            app.SARGUI.Resize = 'off';

            % Create Label
            app.Label = uilabel(app.SARGUI);
            app.Label.VerticalAlignment = 'top';
            app.Label.FontSize = 18;
            app.Label.FontWeight = 'bold';
            app.Label.FontColor = [0.0745 0.6235 1];
            app.Label.Position = [15 698 286 43];
            app.Label.Text = 'SAR Imaging Toolbox        v4.0.1';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.SARGUI);
            app.TabGroup.AutoResizeChildren = 'off';
            app.TabGroup.Position = [15 76 1213 616];

            % Create InitializationTab
            app.InitializationTab = uitab(app.TabGroup);
            app.InitializationTab.AutoResizeChildren = 'off';
            app.InitializationTab.Title = 'Initialization';
            app.InitializationTab.BackgroundColor = [1 1 1];
            app.InitializationTab.ForegroundColor = [0.0745 0.6235 1];

            % Create ScannerInitializationPanel
            app.ScannerInitializationPanel = uipanel(app.InitializationTab);
            app.ScannerInitializationPanel.AutoResizeChildren = 'off';
            app.ScannerInitializationPanel.ForegroundColor = [0.0745 0.6235 1];
            app.ScannerInitializationPanel.Title = 'Scanner Initialization';
            app.ScannerInitializationPanel.BackgroundColor = [1 1 1];
            app.ScannerInitializationPanel.FontWeight = 'bold';
            app.ScannerInitializationPanel.FontSize = 16;
            app.ScannerInitializationPanel.Position = [19 11 562 562];

            % Create ConnectToScannerButton
            app.ConnectToScannerButton = uibutton(app.ScannerInitializationPanel, 'push');
            app.ConnectToScannerButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectToScannerButtonPushed, true);
            app.ConnectToScannerButton.HorizontalAlignment = 'left';
            app.ConnectToScannerButton.BackgroundColor = [0.4706 0.6706 0.1882];
            app.ConnectToScannerButton.FontSize = 16;
            app.ConnectToScannerButton.FontColor = [1 1 1];
            app.ConnectToScannerButton.Position = [8 493 220 36];
            app.ConnectToScannerButton.Text = 'Connect to Scanner';

            % Create ManualMovementForTestWillbemovedatIdleSpeedPanel
            app.ManualMovementForTestWillbemovedatIdleSpeedPanel = uipanel(app.ScannerInitializationPanel);
            app.ManualMovementForTestWillbemovedatIdleSpeedPanel.AutoResizeChildren = 'off';
            app.ManualMovementForTestWillbemovedatIdleSpeedPanel.Title = 'Manual Movement (For Test) - Will be moved at Idle Speed ';
            app.ManualMovementForTestWillbemovedatIdleSpeedPanel.BackgroundColor = [1 1 1];
            app.ManualMovementForTestWillbemovedatIdleSpeedPanel.FontSize = 14;
            app.ManualMovementForTestWillbemovedatIdleSpeedPanel.Position = [8 144 546 107];

            % Create DesiredHorizontalMovementmmLabel
            app.DesiredHorizontalMovementmmLabel = uilabel(app.ManualMovementForTestWillbemovedatIdleSpeedPanel);
            app.DesiredHorizontalMovementmmLabel.FontSize = 14;
            app.DesiredHorizontalMovementmmLabel.Position = [11 49 228 22];
            app.DesiredHorizontalMovementmmLabel.Text = 'Desired Horizontal Movement (mm)';

            % Create DesiredHorizontalMovementmmEditField
            app.DesiredHorizontalMovementmmEditField = uieditfield(app.ManualMovementForTestWillbemovedatIdleSpeedPanel, 'numeric');
            app.DesiredHorizontalMovementmmEditField.Limits = [-1000 1000];
            app.DesiredHorizontalMovementmmEditField.FontSize = 14;
            app.DesiredHorizontalMovementmmEditField.Position = [243 49 144 22];

            % Create DesiredVerticalMovementmmLabel
            app.DesiredVerticalMovementmmLabel = uilabel(app.ManualMovementForTestWillbemovedatIdleSpeedPanel);
            app.DesiredVerticalMovementmmLabel.FontSize = 14;
            app.DesiredVerticalMovementmmLabel.Position = [11 11 210 22];
            app.DesiredVerticalMovementmmLabel.Text = 'Desired Vertical Movement (mm)';

            % Create DesiredVerticalMovementmmEditField
            app.DesiredVerticalMovementmmEditField = uieditfield(app.ManualMovementForTestWillbemovedatIdleSpeedPanel, 'numeric');
            app.DesiredVerticalMovementmmEditField.Limits = [-1200 1200];
            app.DesiredVerticalMovementmmEditField.FontSize = 14;
            app.DesiredVerticalMovementmmEditField.Position = [243 13 144 22];

            % Create SendSingleCommandButton
            app.SendSingleCommandButton = uibutton(app.ManualMovementForTestWillbemovedatIdleSpeedPanel, 'push');
            app.SendSingleCommandButton.ButtonPushedFcn = createCallbackFcn(app, @SendSingleCommandButtonPushed, true);
            app.SendSingleCommandButton.BackgroundColor = [0 0.451 0.7412];
            app.SendSingleCommandButton.FontSize = 16;
            app.SendSingleCommandButton.FontColor = [1 1 1];
            app.SendSingleCommandButton.Enable = 'off';
            app.SendSingleCommandButton.Position = [402 11 133 62];
            app.SendSingleCommandButton.Text = 'Send Command';

            % Create ScannerConnectionStatusLamp
            app.ScannerConnectionStatusLamp = uilamp(app.ScannerInitializationPanel);
            app.ScannerConnectionStatusLamp.Position = [251 496 31 31];
            app.ScannerConnectionStatusLamp.Color = [1 0 0];

            % Create DesignParametersHardwareDependentPanel
            app.DesignParametersHardwareDependentPanel = uipanel(app.ScannerInitializationPanel);
            app.DesignParametersHardwareDependentPanel.AutoResizeChildren = 'off';
            app.DesignParametersHardwareDependentPanel.Title = 'Design Parameters (Hardware Dependent)';
            app.DesignParametersHardwareDependentPanel.BackgroundColor = [1 1 1];
            app.DesignParametersHardwareDependentPanel.FontSize = 14;
            app.DesignParametersHardwareDependentPanel.Position = [8 397 546 89];

            % Create PulsePerRevolutionEditFieldLabel
            app.PulsePerRevolutionEditFieldLabel = uilabel(app.DesignParametersHardwareDependentPanel);
            app.PulsePerRevolutionEditFieldLabel.FontSize = 14;
            app.PulsePerRevolutionEditFieldLabel.Position = [8 36 136 18];
            app.PulsePerRevolutionEditFieldLabel.Text = 'Pulse Per Revolution';

            % Create PulsePerRevolutionEditField
            app.PulsePerRevolutionEditField = uieditfield(app.DesignParametersHardwareDependentPanel, 'numeric');
            app.PulsePerRevolutionEditField.Limits = [0 Inf];
            app.PulsePerRevolutionEditField.ValueDisplayFormat = '%.0f';
            app.PulsePerRevolutionEditField.Editable = 'off';
            app.PulsePerRevolutionEditField.FontSize = 14;
            app.PulsePerRevolutionEditField.Position = [208 35 71 22];
            app.PulsePerRevolutionEditField.Value = 20000;

            % Create DistancePerRevolutionmmEditFieldLabel
            app.DistancePerRevolutionmmEditFieldLabel = uilabel(app.DesignParametersHardwareDependentPanel);
            app.DistancePerRevolutionmmEditFieldLabel.FontSize = 14;
            app.DistancePerRevolutionmmEditFieldLabel.Position = [8 6 194 18];
            app.DistancePerRevolutionmmEditFieldLabel.Text = 'Distance Per Revolution (mm)';

            % Create DistancePerRevolutionmmEditField
            app.DistancePerRevolutionmmEditField = uieditfield(app.DesignParametersHardwareDependentPanel, 'numeric');
            app.DistancePerRevolutionmmEditField.Limits = [0 Inf];
            app.DistancePerRevolutionmmEditField.Editable = 'off';
            app.DistancePerRevolutionmmEditField.FontSize = 14;
            app.DistancePerRevolutionmmEditField.Position = [208 5 71 22];
            app.DistancePerRevolutionmmEditField.Value = 110;

            % Create ScannerCOMPortEditFieldLabel
            app.ScannerCOMPortEditFieldLabel = uilabel(app.DesignParametersHardwareDependentPanel);
            app.ScannerCOMPortEditFieldLabel.HorizontalAlignment = 'right';
            app.ScannerCOMPortEditFieldLabel.FontSize = 14;
            app.ScannerCOMPortEditFieldLabel.Position = [329 5 124 22];
            app.ScannerCOMPortEditFieldLabel.Text = 'Scanner COM Port';

            % Create ScannerCOMPortEditField
            app.ScannerCOMPortEditField = uieditfield(app.DesignParametersHardwareDependentPanel, 'numeric');
            app.ScannerCOMPortEditField.FontSize = 14;
            app.ScannerCOMPortEditField.Position = [464 5 63 22];
            app.ScannerCOMPortEditField.Value = 12;

            % Create DisconnectFromScannerButton
            app.DisconnectFromScannerButton = uibutton(app.ScannerInitializationPanel, 'push');
            app.DisconnectFromScannerButton.ButtonPushedFcn = createCallbackFcn(app, @DisconnectFromScannerButtonPushed, true);
            app.DisconnectFromScannerButton.BackgroundColor = [1 0 0];
            app.DisconnectFromScannerButton.FontSize = 16;
            app.DisconnectFromScannerButton.FontColor = [1 1 1];
            app.DisconnectFromScannerButton.Position = [302 493 220 36];
            app.DisconnectFromScannerButton.Text = 'Disconnect from Scanner';

            % Create ConfigurationParametersPanel
            app.ConfigurationParametersPanel = uipanel(app.ScannerInitializationPanel);
            app.ConfigurationParametersPanel.AutoResizeChildren = 'off';
            app.ConfigurationParametersPanel.Title = 'Configuration Parameters';
            app.ConfigurationParametersPanel.BackgroundColor = [1 1 1];
            app.ConfigurationParametersPanel.FontSize = 14;
            app.ConfigurationParametersPanel.Position = [8 264 546 121];

            % Create SpeedSARmmsLabel
            app.SpeedSARmmsLabel = uilabel(app.ConfigurationParametersPanel);
            app.SpeedSARmmsLabel.FontSize = 14;
            app.SpeedSARmmsLabel.Position = [8 62 146 22];
            app.SpeedSARmmsLabel.Text = 'Speed SAR (mm/s)';

            % Create SpeedmmpsEditField
            app.SpeedmmpsEditField = uieditfield(app.ConfigurationParametersPanel, 'numeric');
            app.SpeedmmpsEditField.Limits = [0 500];
            app.SpeedmmpsEditField.ValueChangedFcn = createCallbackFcn(app, @SpeedmmpsEditFieldValueChanged, true);
            app.SpeedmmpsEditField.FontSize = 14;
            app.SpeedmmpsEditField.Position = [190 64 71 22];
            app.SpeedmmpsEditField.Value = 100;

            % Create HorizontalAxisLimitmmLabel
            app.HorizontalAxisLimitmmLabel = uilabel(app.ConfigurationParametersPanel);
            app.HorizontalAxisLimitmmLabel.FontSize = 14;
            app.HorizontalAxisLimitmmLabel.Position = [8 35 169 22];
            app.HorizontalAxisLimitmmLabel.Text = 'Horizontal Axis Limit (mm)';

            % Create HorizontalAxisLimitmmEditField
            app.HorizontalAxisLimitmmEditField = uieditfield(app.ConfigurationParametersPanel, 'numeric');
            app.HorizontalAxisLimitmmEditField.Limits = [0 1000];
            app.HorizontalAxisLimitmmEditField.Editable = 'off';
            app.HorizontalAxisLimitmmEditField.FontSize = 14;
            app.HorizontalAxisLimitmmEditField.Position = [190 35 71 22];
            app.HorizontalAxisLimitmmEditField.Value = 1000;

            % Create VerticalAxisLimitmmEditFieldLabel
            app.VerticalAxisLimitmmEditFieldLabel = uilabel(app.ConfigurationParametersPanel);
            app.VerticalAxisLimitmmEditFieldLabel.FontSize = 14;
            app.VerticalAxisLimitmmEditFieldLabel.Position = [8 6 152 22];
            app.VerticalAxisLimitmmEditFieldLabel.Text = 'Vertical Axis Limit (mm)';

            % Create VerticalAxisLimitmmEditField
            app.VerticalAxisLimitmmEditField = uieditfield(app.ConfigurationParametersPanel, 'numeric');
            app.VerticalAxisLimitmmEditField.Limits = [0 1200];
            app.VerticalAxisLimitmmEditField.Editable = 'off';
            app.VerticalAxisLimitmmEditField.FontSize = 14;
            app.VerticalAxisLimitmmEditField.Position = [190 6 71 22];
            app.VerticalAxisLimitmmEditField.Value = 1200;

            % Create xAxisLabel
            app.xAxisLabel = uilabel(app.ConfigurationParametersPanel);
            app.xAxisLabel.FontSize = 14;
            app.xAxisLabel.Position = [273 35 53 22];
            app.xAxisLabel.Text = '(x-Axis)';

            % Create yAxisLabel
            app.yAxisLabel = uilabel(app.ConfigurationParametersPanel);
            app.yAxisLabel.FontSize = 14;
            app.yAxisLabel.Position = [273 6 53 22];
            app.yAxisLabel.Text = '(y-Axis)';

            % Create IdleSpeedmmsNoDataLabel
            app.IdleSpeedmmsNoDataLabel = uilabel(app.ConfigurationParametersPanel);
            app.IdleSpeedmmsNoDataLabel.FontSize = 14;
            app.IdleSpeedmmsNoDataLabel.Position = [278 63 179 22];
            app.IdleSpeedmmsNoDataLabel.Text = 'Idle Speed (mm/s) - No Data';

            % Create IdleSpeedmmpsEditField
            app.IdleSpeedmmpsEditField = uieditfield(app.ConfigurationParametersPanel, 'numeric');
            app.IdleSpeedmmpsEditField.Limits = [0 500];
            app.IdleSpeedmmpsEditField.FontSize = 14;
            app.IdleSpeedmmpsEditField.Position = [460 62 71 22];
            app.IdleSpeedmmpsEditField.Value = 50;

            % Create TotalMovementPanel
            app.TotalMovementPanel = uipanel(app.ScannerInitializationPanel);
            app.TotalMovementPanel.AutoResizeChildren = 'off';
            app.TotalMovementPanel.Title = 'Total Movement';
            app.TotalMovementPanel.BackgroundColor = [1 1 1];
            app.TotalMovementPanel.FontSize = 14;
            app.TotalMovementPanel.Position = [9 7 303 123];

            % Create HomeButton
            app.HomeButton = uibutton(app.TotalMovementPanel, 'push');
            app.HomeButton.ButtonPushedFcn = createCallbackFcn(app, @HomeButtonPushed, true);
            app.HomeButton.BackgroundColor = [0 0.451 0.7412];
            app.HomeButton.FontSize = 16;
            app.HomeButton.FontColor = [1 1 1];
            app.HomeButton.Enable = 'off';
            app.HomeButton.Position = [226 6 68 87];
            app.HomeButton.Text = 'Home';

            % Create TotalMovementTextArea
            app.TotalMovementTextArea = uitextarea(app.TotalMovementPanel);
            app.TotalMovementTextArea.FontSize = 14;
            app.TotalMovementTextArea.Position = [9 4 210 90];

            % Create ScannerTypeSwitchLabel
            app.ScannerTypeSwitchLabel = uilabel(app.ScannerInitializationPanel);
            app.ScannerTypeSwitchLabel.HorizontalAlignment = 'center';
            app.ScannerTypeSwitchLabel.FontSize = 14;
            app.ScannerTypeSwitchLabel.Enable = 'off';
            app.ScannerTypeSwitchLabel.Position = [382 464 92 22];
            app.ScannerTypeSwitchLabel.Text = 'Scanner Type';

            % Create ScannerTypeSwitch
            app.ScannerTypeSwitch = uiswitch(app.ScannerInitializationPanel, 'slider');
            app.ScannerTypeSwitch.Items = {'Smaller', 'Bigger (TBD)'};
            app.ScannerTypeSwitch.ValueChangedFcn = createCallbackFcn(app, @ScannerTypeSwitchValueChanged, true);
            app.ScannerTypeSwitch.Enable = 'off';
            app.ScannerTypeSwitch.FontSize = 14;
            app.ScannerTypeSwitch.Position = [402 439 45 20];
            app.ScannerTypeSwitch.Value = 'Smaller';

            % Create RadarInitilializationPanel
            app.RadarInitilializationPanel = uipanel(app.InitializationTab);
            app.RadarInitilializationPanel.AutoResizeChildren = 'off';
            app.RadarInitilializationPanel.ForegroundColor = [0.0745 0.6235 1];
            app.RadarInitilializationPanel.Title = 'Radar Initilialization';
            app.RadarInitilializationPanel.BackgroundColor = [1 1 1];
            app.RadarInitilializationPanel.FontWeight = 'bold';
            app.RadarInitilializationPanel.FontSize = 16;
            app.RadarInitilializationPanel.Position = [589 11 611 562];

            % Create InitializeRSTDandHSDCPROConnectionsButton
            app.InitializeRSTDandHSDCPROConnectionsButton = uibutton(app.RadarInitilializationPanel, 'push');
            app.InitializeRSTDandHSDCPROConnectionsButton.ButtonPushedFcn = createCallbackFcn(app, @InitializeRSTDandHSDCPROConnectionsButtonPushed, true);
            app.InitializeRSTDandHSDCPROConnectionsButton.HorizontalAlignment = 'left';
            app.InitializeRSTDandHSDCPROConnectionsButton.BackgroundColor = [0.4706 0.6706 0.1882];
            app.InitializeRSTDandHSDCPROConnectionsButton.FontSize = 16;
            app.InitializeRSTDandHSDCPROConnectionsButton.FontColor = [1 1 1];
            app.InitializeRSTDandHSDCPROConnectionsButton.Position = [12 494 336 35];
            app.InitializeRSTDandHSDCPROConnectionsButton.Text = 'Initialize RSTD and HSDCPRO Connections';

            % Create RadarConnectionStatusLamp
            app.RadarConnectionStatusLamp = uilamp(app.RadarInitilializationPanel);
            app.RadarConnectionStatusLamp.Position = [358 496 31 31];
            app.RadarConnectionStatusLamp.Color = [1 0 0];

            % Create RadarStatusTextAreaLabel
            app.RadarStatusTextAreaLabel = uilabel(app.RadarInitilializationPanel);
            app.RadarStatusTextAreaLabel.VerticalAlignment = 'top';
            app.RadarStatusTextAreaLabel.FontSize = 14;
            app.RadarStatusTextAreaLabel.Position = [9 96 87 22];
            app.RadarStatusTextAreaLabel.Text = 'Radar Status';

            % Create RadarStatusTextArea
            app.RadarStatusTextArea = uitextarea(app.RadarInitilializationPanel);
            app.RadarStatusTextArea.FontSize = 14;
            app.RadarStatusTextArea.Position = [9 12 586 88];

            % Create OutputBaseFolderEditFieldLabel
            app.OutputBaseFolderEditFieldLabel = uilabel(app.RadarInitilializationPanel);
            app.OutputBaseFolderEditFieldLabel.HorizontalAlignment = 'right';
            app.OutputBaseFolderEditFieldLabel.FontSize = 14;
            app.OutputBaseFolderEditFieldLabel.Position = [3 350 135 22];
            app.OutputBaseFolderEditFieldLabel.Text = 'Output Base Folder: ';

            % Create OutputBaseFolderEditField
            app.OutputBaseFolderEditField = uieditfield(app.RadarInitilializationPanel, 'text');
            app.OutputBaseFolderEditField.FontSize = 14;
            app.OutputBaseFolderEditField.Position = [137 350 344 22];
            app.OutputBaseFolderEditField.Value = 'C:\Users\mey160030\Box\TIRadarWork\SarStudy\RecordedData\TI_Radar_Data_WithParams';

            % Create BrowseOutputBaseButton
            app.BrowseOutputBaseButton = uibutton(app.RadarInitilializationPanel, 'push');
            app.BrowseOutputBaseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseOutputBaseButtonPushed, true);
            app.BrowseOutputBaseButton.BackgroundColor = [0.651 0.651 0.651];
            app.BrowseOutputBaseButton.FontSize = 14;
            app.BrowseOutputBaseButton.Position = [492 349 100 24];
            app.BrowseOutputBaseButton.Text = 'Browse';

            % Create ExperimentFolderEditFieldLabel
            app.ExperimentFolderEditFieldLabel = uilabel(app.RadarInitilializationPanel);
            app.ExperimentFolderEditFieldLabel.HorizontalAlignment = 'right';
            app.ExperimentFolderEditFieldLabel.FontSize = 14;
            app.ExperimentFolderEditFieldLabel.Position = [3 323 124 22];
            app.ExperimentFolderEditFieldLabel.Text = 'Experiment Folder:';

            % Create ExperimentFolderEditField
            app.ExperimentFolderEditField = uieditfield(app.RadarInitilializationPanel, 'text');
            app.ExperimentFolderEditField.FontSize = 14;
            app.ExperimentFolderEditField.Position = [137 323 344 22];
            app.ExperimentFolderEditField.Value = 'NewExperiment\';

            % Create ParameterFileLabel
            app.ParameterFileLabel = uilabel(app.RadarInitilializationPanel);
            app.ParameterFileLabel.HorizontalAlignment = 'right';
            app.ParameterFileLabel.FontSize = 14;
            app.ParameterFileLabel.Position = [3 404 97 22];
            app.ParameterFileLabel.Text = 'Parameter File';

            % Create ParamFileEditField
            app.ParamFileEditField = uieditfield(app.RadarInitilializationPanel, 'text');
            app.ParamFileEditField.FontSize = 14;
            app.ParamFileEditField.Position = [137 404 243 22];
            app.ParamFileEditField.Value = 'chirpProfiles_256S_3Tx_4Rx';

            % Create BrowseParamFileButton
            app.BrowseParamFileButton = uibutton(app.RadarInitilializationPanel, 'push');
            app.BrowseParamFileButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseParamFileButtonPushed, true);
            app.BrowseParamFileButton.BackgroundColor = [0.651 0.651 0.651];
            app.BrowseParamFileButton.FontSize = 14;
            app.BrowseParamFileButton.Position = [388 403 100 24];
            app.BrowseParamFileButton.Text = 'Browse';

            % Create RadarTypeSwitchLabel
            app.RadarTypeSwitchLabel = uilabel(app.RadarInitilializationPanel);
            app.RadarTypeSwitchLabel.HorizontalAlignment = 'center';
            app.RadarTypeSwitchLabel.FontSize = 14;
            app.RadarTypeSwitchLabel.Enable = 'off';
            app.RadarTypeSwitchLabel.Position = [9 447 78 22];
            app.RadarTypeSwitchLabel.Text = 'Radar Type';

            % Create RadarTypeSwitch
            app.RadarTypeSwitch = uiswitch(app.RadarInitilializationPanel, 'slider');
            app.RadarTypeSwitch.Items = {'1-Chip xWR1xxxx', 'Other (TBD)'};
            app.RadarTypeSwitch.Enable = 'off';
            app.RadarTypeSwitch.FontSize = 14;
            app.RadarTypeSwitch.Position = [248 450 45 20];
            app.RadarTypeSwitch.Value = '1-Chip xWR1xxxx';

            % Create ConfigureParamFromFileButton
            app.ConfigureParamFromFileButton = uibutton(app.RadarInitilializationPanel, 'push');
            app.ConfigureParamFromFileButton.ButtonPushedFcn = createCallbackFcn(app, @ConfigureParamFromFileButtonPushed, true);
            app.ConfigureParamFromFileButton.BackgroundColor = [0 0.451 0.7412];
            app.ConfigureParamFromFileButton.FontSize = 14;
            app.ConfigureParamFromFileButton.FontColor = [1 1 1];
            app.ConfigureParamFromFileButton.Enable = 'off';
            app.ConfigureParamFromFileButton.Position = [492 401 100 26];
            app.ConfigureParamFromFileButton.Text = 'Configure';

            % Create CaptureandRecordForTestPanel
            app.CaptureandRecordForTestPanel = uipanel(app.RadarInitilializationPanel);
            app.CaptureandRecordForTestPanel.AutoResizeChildren = 'off';
            app.CaptureandRecordForTestPanel.Title = 'Capture and Record (For Test)';
            app.CaptureandRecordForTestPanel.BackgroundColor = [1 1 1];
            app.CaptureandRecordForTestPanel.FontSize = 14;
            app.CaptureandRecordForTestPanel.Position = [9 131 583 172];

            % Create CaptureAndRecordButton
            app.CaptureAndRecordButton = uibutton(app.CaptureandRecordForTestPanel, 'push');
            app.CaptureAndRecordButton.ButtonPushedFcn = createCallbackFcn(app, @CaptureAndRecordButtonPushed, true);
            app.CaptureAndRecordButton.BackgroundColor = [0 0.451 0.7412];
            app.CaptureAndRecordButton.FontSize = 16;
            app.CaptureAndRecordButton.FontColor = [1 1 1];
            app.CaptureAndRecordButton.Enable = 'off';
            app.CaptureAndRecordButton.Position = [229 69 181 43];
            app.CaptureAndRecordButton.Text = 'Capture and Record';

            % Create InitializeRSTDandHSDCPROCon2ConfigurechirpsparametersLabel
            app.InitializeRSTDandHSDCPROCon2ConfigurechirpsparametersLabel = uilabel(app.CaptureandRecordForTestPanel);
            app.InitializeRSTDandHSDCPROCon2ConfigurechirpsparametersLabel.FontSize = 14;
            app.InitializeRSTDandHSDCPROCon2ConfigurechirpsparametersLabel.Position = [4 121 494 27];
            app.InitializeRSTDandHSDCPROCon2ConfigurechirpsparametersLabel.Text = 'Note: Initialize RSTD and HSDCPRO Connection, Configure chirps parameters';

            % Create ofMeasurementsSpinnerLabel
            app.ofMeasurementsSpinnerLabel = uilabel(app.CaptureandRecordForTestPanel);
            app.ofMeasurementsSpinnerLabel.HorizontalAlignment = 'right';
            app.ofMeasurementsSpinnerLabel.FontSize = 14;
            app.ofMeasurementsSpinnerLabel.Position = [4 73 125 22];
            app.ofMeasurementsSpinnerLabel.Text = '# of Measurements';

            % Create ofMeasurementsSpinner
            app.ofMeasurementsSpinner = uispinner(app.CaptureandRecordForTestPanel);
            app.ofMeasurementsSpinner.FontSize = 14;
            app.ofMeasurementsSpinner.Position = [144 73 72 22];
            app.ofMeasurementsSpinner.Value = 1;

            % Create ofSamplesChannelLabel_3
            app.ofSamplesChannelLabel_3 = uilabel(app.CaptureandRecordForTestPanel);
            app.ofSamplesChannelLabel_3.FontSize = 14;
            app.ofSamplesChannelLabel_3.Position = [434 93 143 22];
            app.ofSamplesChannelLabel_3.Text = '# of Samples/Channel';

            % Create NumberofSamplesPerChannelEditField
            app.NumberofSamplesPerChannelEditField = uieditfield(app.CaptureandRecordForTestPanel, 'numeric');
            app.NumberofSamplesPerChannelEditField.ValueDisplayFormat = '%.0f';
            app.NumberofSamplesPerChannelEditField.Editable = 'off';
            app.NumberofSamplesPerChannelEditField.FontSize = 14;
            app.NumberofSamplesPerChannelEditField.Position = [434 69 134 22];

            % Create TriggerHSDCButton
            app.TriggerHSDCButton = uibutton(app.CaptureandRecordForTestPanel, 'push');
            app.TriggerHSDCButton.ButtonPushedFcn = createCallbackFcn(app, @TriggerHSDCButtonPushed, true);
            app.TriggerHSDCButton.BackgroundColor = [0 0.451 0.7412];
            app.TriggerHSDCButton.FontSize = 16;
            app.TriggerHSDCButton.FontColor = [1 1 1];
            app.TriggerHSDCButton.Enable = 'off';
            app.TriggerHSDCButton.Position = [128 7 140 43];
            app.TriggerHSDCButton.Text = 'Trigger HSDC';

            % Create TriggerFrameButton
            app.TriggerFrameButton = uibutton(app.CaptureandRecordForTestPanel, 'push');
            app.TriggerFrameButton.ButtonPushedFcn = createCallbackFcn(app, @TriggerFrameButtonPushed, true);
            app.TriggerFrameButton.BackgroundColor = [0 0.451 0.7412];
            app.TriggerFrameButton.FontSize = 16;
            app.TriggerFrameButton.FontColor = [1 1 1];
            app.TriggerFrameButton.Enable = 'off';
            app.TriggerFrameButton.Position = [278 7 140 43];
            app.TriggerFrameButton.Text = 'Trigger Frame';

            % Create RecordDataButton
            app.RecordDataButton = uibutton(app.CaptureandRecordForTestPanel, 'push');
            app.RecordDataButton.ButtonPushedFcn = createCallbackFcn(app, @RecordDataButtonPushed, true);
            app.RecordDataButton.BackgroundColor = [0 0.451 0.7412];
            app.RecordDataButton.FontSize = 16;
            app.RecordDataButton.FontColor = [1 1 1];
            app.RecordDataButton.Enable = 'off';
            app.RecordDataButton.Position = [428 7 140 43];
            app.RecordDataButton.Text = 'Record Data';

            % Create ManualStepsLabel
            app.ManualStepsLabel = uilabel(app.CaptureandRecordForTestPanel);
            app.ManualStepsLabel.FontSize = 14;
            app.ManualStepsLabel.Position = [26 17 95 22];
            app.ManualStepsLabel.Text = 'Manual Steps:';

            % Create ScannerStatusPanel
            app.ScannerStatusPanel = uipanel(app.InitializationTab);
            app.ScannerStatusPanel.AutoResizeChildren = 'off';
            app.ScannerStatusPanel.Title = 'Scanner Status';
            app.ScannerStatusPanel.BackgroundColor = [1 1 1];
            app.ScannerStatusPanel.FontSize = 14;
            app.ScannerStatusPanel.Position = [339 18 234 123];

            % Create ScannerStatusTextArea
            app.ScannerStatusTextArea = uitextarea(app.ScannerStatusPanel);
            app.ScannerStatusTextArea.FontSize = 14;
            app.ScannerStatusTextArea.Position = [6 4 217 90];

            % Create SARConfigurationHWTriggerTab
            app.SARConfigurationHWTriggerTab = uitab(app.TabGroup);
            app.SARConfigurationHWTriggerTab.Title = 'SAR Configuration (HW Trigger)';
            app.SARConfigurationHWTriggerTab.BackgroundColor = [1 1 1];
            app.SARConfigurationHWTriggerTab.ForegroundColor = [0.0745 0.6235 1];

            % Create SARConfigurationContinuousHorizontalScanHwTrgPanel
            app.SARConfigurationContinuousHorizontalScanHwTrgPanel = uipanel(app.SARConfigurationHWTriggerTab);
            app.SARConfigurationContinuousHorizontalScanHwTrgPanel.AutoResizeChildren = 'off';
            app.SARConfigurationContinuousHorizontalScanHwTrgPanel.ForegroundColor = [0.0745 0.6235 1];
            app.SARConfigurationContinuousHorizontalScanHwTrgPanel.Title = 'SAR Configuration (Continuous Horizontal Scan)';
            app.SARConfigurationContinuousHorizontalScanHwTrgPanel.BackgroundColor = [1 1 1];
            app.SARConfigurationContinuousHorizontalScanHwTrgPanel.FontWeight = 'bold';
            app.SARConfigurationContinuousHorizontalScanHwTrgPanel.FontSize = 16;
            app.SARConfigurationContinuousHorizontalScanHwTrgPanel.Position = [28 10 555 572];

            % Create StartCapturingContSARHwTrgCommandButton
            app.StartCapturingContSARHwTrgCommandButton = uibutton(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'push');
            app.StartCapturingContSARHwTrgCommandButton.ButtonPushedFcn = createCallbackFcn(app, @StartCapturingContSARHwTrgCommandButtonPushed, true);
            app.StartCapturingContSARHwTrgCommandButton.BackgroundColor = [0.4706 0.6706 0.1882];
            app.StartCapturingContSARHwTrgCommandButton.FontSize = 16;
            app.StartCapturingContSARHwTrgCommandButton.FontColor = [1 1 1];
            app.StartCapturingContSARHwTrgCommandButton.Position = [195 143 152 54];
            app.StartCapturingContSARHwTrgCommandButton.Text = 'Start Capturing';

            % Create StopCapturingContSARHwTrgCommandButton
            app.StopCapturingContSARHwTrgCommandButton = uibutton(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'push');
            app.StopCapturingContSARHwTrgCommandButton.ButtonPushedFcn = createCallbackFcn(app, @StopCapturingContSARHwTrgCommandButtonPushed, true);
            app.StopCapturingContSARHwTrgCommandButton.BackgroundColor = [1 0 0];
            app.StopCapturingContSARHwTrgCommandButton.FontSize = 16;
            app.StopCapturingContSARHwTrgCommandButton.FontColor = [1 1 1];
            app.StopCapturingContSARHwTrgCommandButton.Enable = 'off';
            app.StopCapturingContSARHwTrgCommandButton.Position = [370 143 150 54];
            app.StopCapturingContSARHwTrgCommandButton.Text = 'Stop Capturing';

            % Create VerticalStepSizemmContSARHwTrgLabel
            app.VerticalStepSizemmContSARHwTrgLabel = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.VerticalStepSizemmContSARHwTrgLabel.VerticalAlignment = 'top';
            app.VerticalStepSizemmContSARHwTrgLabel.FontSize = 14;
            app.VerticalStepSizemmContSARHwTrgLabel.Position = [224 334 111 22];
            app.VerticalStepSizemmContSARHwTrgLabel.Text = 'Example: 0.9 1.9';

            % Create NumberofVerticalStepsLabel
            app.NumberofVerticalStepsLabel = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.NumberofVerticalStepsLabel.VerticalAlignment = 'top';
            app.NumberofVerticalStepsLabel.FontSize = 14;
            app.NumberofVerticalStepsLabel.Position = [8 390 164 22];
            app.NumberofVerticalStepsLabel.Text = 'Number of Vertical Steps';

            % Create VerticalScanStepsContSARHwTrgSpinner
            app.VerticalScanStepsContSARHwTrgSpinner = uispinner(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.VerticalScanStepsContSARHwTrgSpinner.HorizontalAlignment = 'left';
            app.VerticalScanStepsContSARHwTrgSpinner.FontSize = 14;
            app.VerticalScanStepsContSARHwTrgSpinner.Position = [224 393 111 22];
            app.VerticalScanStepsContSARHwTrgSpinner.Value = 1;

            % Create VerticalStepSizemmLabel_5
            app.VerticalStepSizemmLabel_5 = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.VerticalStepSizemmLabel_5.VerticalAlignment = 'top';
            app.VerticalStepSizemmLabel_5.FontSize = 14;
            app.VerticalStepSizemmLabel_5.Position = [8 358 164 18];
            app.VerticalStepSizemmLabel_5.Text = 'Vertical Step Size (mm)';

            % Create VerticalStepSizemmContSARHwTrgEditField
            app.VerticalStepSizemmContSARHwTrgEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'text');
            app.VerticalStepSizemmContSARHwTrgEditField.HorizontalAlignment = 'right';
            app.VerticalStepSizemmContSARHwTrgEditField.FontSize = 14;
            app.VerticalStepSizemmContSARHwTrgEditField.Position = [224 357 111 22];
            app.VerticalStepSizemmContSARHwTrgEditField.Value = '7.59';

            % Create HorizontalScanSizemmLabel_5
            app.HorizontalScanSizemmLabel_5 = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.HorizontalScanSizemmLabel_5.FontSize = 14;
            app.HorizontalScanSizemmLabel_5.Position = [12 286 175 18];
            app.HorizontalScanSizemmLabel_5.Text = 'Horizontal Scan Size (mm)';

            % Create HorizontalScanSizemmContSARHwTrgEditField
            app.HorizontalScanSizemmContSARHwTrgEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'numeric');
            app.HorizontalScanSizemmContSARHwTrgEditField.ValueDisplayFormat = '%.4f';
            app.HorizontalScanSizemmContSARHwTrgEditField.Editable = 'off';
            app.HorizontalScanSizemmContSARHwTrgEditField.FontSize = 14;
            app.HorizontalScanSizemmContSARHwTrgEditField.Position = [186 284 98 22];

            % Create ReconfigureRadarSARSyncContSARHwTrgButton
            app.ReconfigureRadarSARSyncContSARHwTrgButton = uibutton(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'push');
            app.ReconfigureRadarSARSyncContSARHwTrgButton.ButtonPushedFcn = createCallbackFcn(app, @ReconfigureRadarSARSyncContSARHwTrgButtonPushed, true);
            app.ReconfigureRadarSARSyncContSARHwTrgButton.BackgroundColor = [0 0.451 0.7412];
            app.ReconfigureRadarSARSyncContSARHwTrgButton.FontSize = 16;
            app.ReconfigureRadarSARSyncContSARHwTrgButton.FontColor = [1 1 1];
            app.ReconfigureRadarSARSyncContSARHwTrgButton.Position = [18 143 168 51];
            app.ReconfigureRadarSARSyncContSARHwTrgButton.Text = {'Reconfigure'; 'Radar and SAR Sync'};

            % Create TotalContSARHwTrgMovementPanel
            app.TotalContSARHwTrgMovementPanel = uipanel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.TotalContSARHwTrgMovementPanel.Title = 'Total Movement';
            app.TotalContSARHwTrgMovementPanel.BackgroundColor = [1 1 1];
            app.TotalContSARHwTrgMovementPanel.FontSize = 14;
            app.TotalContSARHwTrgMovementPanel.Position = [8 9 214 123];

            % Create TotalMovementContSARHwTrgTextArea
            app.TotalMovementContSARHwTrgTextArea = uitextarea(app.TotalContSARHwTrgMovementPanel);
            app.TotalMovementContSARHwTrgTextArea.FontSize = 14;
            app.TotalMovementContSARHwTrgTextArea.Position = [8 6 198 87];

            % Create ContSARHwTrgStatusPanel
            app.ContSARHwTrgStatusPanel = uipanel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.ContSARHwTrgStatusPanel.AutoResizeChildren = 'off';
            app.ContSARHwTrgStatusPanel.Title = 'SAR Status';
            app.ContSARHwTrgStatusPanel.BackgroundColor = [1 1 1];
            app.ContSARHwTrgStatusPanel.FontSize = 14;
            app.ContSARHwTrgStatusPanel.Position = [234 9 308 123];

            % Create Label_5
            app.Label_5 = uilabel(app.ContSARHwTrgStatusPanel);
            app.Label_5.VerticalAlignment = 'top';
            app.Label_5.FontSize = 14;
            app.Label_5.Position = [279 73 25 22];
            app.Label_5.Text = '';

            % Create ContSARHwTrgStatusTextArea
            app.ContSARHwTrgStatusTextArea = uitextarea(app.ContSARHwTrgStatusPanel);
            app.ContSARHwTrgStatusTextArea.FontSize = 14;
            app.ContSARHwTrgStatusTextArea.Position = [7 6 297 89];

            % Create HorizontalStepSizemmLabel_3
            app.HorizontalStepSizemmLabel_3 = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.HorizontalStepSizemmLabel_3.FontSize = 14;
            app.HorizontalStepSizemmLabel_3.Position = [8 426 169 22];
            app.HorizontalStepSizemmLabel_3.Text = 'Horizontal Step Size (mm)';

            % Create HorizontalStepSizemmContSARHwTrgEditField
            app.HorizontalStepSizemmContSARHwTrgEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'numeric');
            app.HorizontalStepSizemmContSARHwTrgEditField.ValueDisplayFormat = '%.4f';
            app.HorizontalStepSizemmContSARHwTrgEditField.FontSize = 14;
            app.HorizontalStepSizemmContSARHwTrgEditField.Position = [224 426 111 22];
            app.HorizontalStepSizemmContSARHwTrgEditField.Value = 1;

            % Create VerticalScanSizemmLabel_3
            app.VerticalScanSizemmLabel_3 = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.VerticalScanSizemmLabel_3.FontSize = 14;
            app.VerticalScanSizemmLabel_3.Position = [12 248 154 22];
            app.VerticalScanSizemmLabel_3.Text = 'Vertical Scan Size (mm)';

            % Create VerticalScanSizemmContSARHwTrgEditField
            app.VerticalScanSizemmContSARHwTrgEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'numeric');
            app.VerticalScanSizemmContSARHwTrgEditField.ValueDisplayFormat = '%.4f';
            app.VerticalScanSizemmContSARHwTrgEditField.Editable = 'off';
            app.VerticalScanSizemmContSARHwTrgEditField.FontSize = 14;
            app.VerticalScanSizemmContSARHwTrgEditField.Position = [186 248 98 22];

            % Create ScanModeSwitchLabel_2
            app.ScanModeSwitchLabel_2 = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.ScanModeSwitchLabel_2.HorizontalAlignment = 'center';
            app.ScanModeSwitchLabel_2.FontSize = 14;
            app.ScanModeSwitchLabel_2.Enable = 'off';
            app.ScanModeSwitchLabel_2.Position = [407 480 76 22];
            app.ScanModeSwitchLabel_2.Text = 'Scan Mode';

            % Create ScanModeContSARHwTrgSwitch
            app.ScanModeContSARHwTrgSwitch = uiswitch(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'rocker');
            app.ScanModeContSARHwTrgSwitch.Items = {'Raster', 'Rectangular'};
            app.ScanModeContSARHwTrgSwitch.Enable = 'off';
            app.ScanModeContSARHwTrgSwitch.FontSize = 14;
            app.ScanModeContSARHwTrgSwitch.Position = [490 469 20 45];
            app.ScanModeContSARHwTrgSwitch.Value = 'Rectangular';

            % Create NumberofHorizontalStepsLabel
            app.NumberofHorizontalStepsLabel = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.NumberofHorizontalStepsLabel.VerticalAlignment = 'top';
            app.NumberofHorizontalStepsLabel.FontSize = 14;
            app.NumberofHorizontalStepsLabel.Position = [8 460 177 22];
            app.NumberofHorizontalStepsLabel.Text = 'Number of Horizontal Steps';

            % Create HorizontalScanStepsContSARHwTrgSpinner
            app.HorizontalScanStepsContSARHwTrgSpinner = uispinner(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.HorizontalScanStepsContSARHwTrgSpinner.HorizontalAlignment = 'left';
            app.HorizontalScanStepsContSARHwTrgSpinner.FontSize = 14;
            app.HorizontalScanStepsContSARHwTrgSpinner.Position = [224 463 111 22];
            app.HorizontalScanStepsContSARHwTrgSpinner.Value = 1;

            % Create SARSyncCOMPortEditFieldLabel
            app.SARSyncCOMPortEditFieldLabel = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.SARSyncCOMPortEditFieldLabel.HorizontalAlignment = 'right';
            app.SARSyncCOMPortEditFieldLabel.FontSize = 14;
            app.SARSyncCOMPortEditFieldLabel.Position = [5 515 135 22];
            app.SARSyncCOMPortEditFieldLabel.Text = 'SAR Sync COM Port';

            % Create SARSyncCOMPortEditField
            app.SARSyncCOMPortEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'numeric');
            app.SARSyncCOMPortEditField.FontSize = 14;
            app.SARSyncCOMPortEditField.Position = [151 515 63 22];
            app.SARSyncCOMPortEditField.Value = 13;

            % Create NumberofFramesEditFieldLabel_3
            app.NumberofFramesEditFieldLabel_3 = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.NumberofFramesEditFieldLabel_3.FontSize = 14;
            app.NumberofFramesEditFieldLabel_3.Position = [308 249 139 18];
            app.NumberofFramesEditFieldLabel_3.Text = 'Number of Frames';

            % Create NumberofFramesContSARHwTrgEditField
            app.NumberofFramesContSARHwTrgEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'numeric');
            app.NumberofFramesContSARHwTrgEditField.ValueDisplayFormat = '%.0f';
            app.NumberofFramesContSARHwTrgEditField.Editable = 'off';
            app.NumberofFramesContSARHwTrgEditField.FontSize = 14;
            app.NumberofFramesContSARHwTrgEditField.Position = [455 248 87 22];
            app.NumberofFramesContSARHwTrgEditField.Value = 1;

            % Create ofSamplesChannelLabel_4
            app.ofSamplesChannelLabel_4 = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.ofSamplesChannelLabel_4.FontSize = 14;
            app.ofSamplesChannelLabel_4.Position = [12 213 143 22];
            app.ofSamplesChannelLabel_4.Text = '# of Samples/Channel';

            % Create NumberofSamplesPerChannelContSARHwTrgEditField
            app.NumberofSamplesPerChannelContSARHwTrgEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'numeric');
            app.NumberofSamplesPerChannelContSARHwTrgEditField.ValueDisplayFormat = '%.0f';
            app.NumberofSamplesPerChannelContSARHwTrgEditField.Editable = 'off';
            app.NumberofSamplesPerChannelContSARHwTrgEditField.FontSize = 14;
            app.NumberofSamplesPerChannelContSARHwTrgEditField.Position = [162 213 122 22];

            % Create FramePeriodicitymsLabel_2
            app.FramePeriodicitymsLabel_2 = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.FramePeriodicitymsLabel_2.FontSize = 14;
            app.FramePeriodicitymsLabel_2.Position = [308 215 148 18];
            app.FramePeriodicitymsLabel_2.Text = 'Frame Periodicity (ms)';

            % Create FramePeriodicitymsContSARHwTrgEditField
            app.FramePeriodicitymsContSARHwTrgEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'numeric');
            app.FramePeriodicitymsContSARHwTrgEditField.Editable = 'off';
            app.FramePeriodicitymsContSARHwTrgEditField.FontSize = 14;
            app.FramePeriodicitymsContSARHwTrgEditField.Position = [455 213 87 22];
            app.FramePeriodicitymsContSARHwTrgEditField.Value = 100;

            % Create ConnectToSARSyncButton
            app.ConnectToSARSyncButton = uibutton(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'push');
            app.ConnectToSARSyncButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectToSARSyncButtonPushed, true);
            app.ConnectToSARSyncButton.BackgroundColor = [0.4706 0.6706 0.1882];
            app.ConnectToSARSyncButton.FontSize = 16;
            app.ConnectToSARSyncButton.FontColor = [1 1 1];
            app.ConnectToSARSyncButton.Position = [234 508 153 36];
            app.ConnectToSARSyncButton.Text = 'Connect SAR Sync';

            % Create SARSyncConnectionStatusLamp
            app.SARSyncConnectionStatusLamp = uilamp(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.SARSyncConnectionStatusLamp.Position = [401 511 31 31];
            app.SARSyncConnectionStatusLamp.Color = [1 0 0];

            % Create CaptureBoardLabel
            app.CaptureBoardLabel = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.CaptureBoardLabel.HorizontalAlignment = 'center';
            app.CaptureBoardLabel.FontSize = 14;
            app.CaptureBoardLabel.Enable = 'off';
            app.CaptureBoardLabel.Position = [392 371 97 22];
            app.CaptureBoardLabel.Text = 'Capture Board';

            % Create CaptureBoardContSARHwTrgSwitch
            app.CaptureBoardContSARHwTrgSwitch = uiswitch(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'rocker');
            app.CaptureBoardContSARHwTrgSwitch.Items = {'DCA1000', 'TSW1400'};
            app.CaptureBoardContSARHwTrgSwitch.Enable = 'off';
            app.CaptureBoardContSARHwTrgSwitch.FontSize = 14;
            app.CaptureBoardContSARHwTrgSwitch.Position = [496 360 20 45];
            app.CaptureBoardContSARHwTrgSwitch.Value = 'TSW1400';

            % Create NumberofPulsesStepLabel
            app.NumberofPulsesStepLabel = uilabel(app.SARConfigurationContinuousHorizontalScanHwTrgPanel);
            app.NumberofPulsesStepLabel.FontSize = 14;
            app.NumberofPulsesStepLabel.Position = [307 284 149 22];
            app.NumberofPulsesStepLabel.Text = 'Number of Pulses/Step';

            % Create NumberofPulsesPerStepContSARHwTrgEditField
            app.NumberofPulsesPerStepContSARHwTrgEditField = uieditfield(app.SARConfigurationContinuousHorizontalScanHwTrgPanel, 'numeric');
            app.NumberofPulsesPerStepContSARHwTrgEditField.Editable = 'off';
            app.NumberofPulsesPerStepContSARHwTrgEditField.FontSize = 14;
            app.NumberofPulsesPerStepContSARHwTrgEditField.Position = [455 284 87 22];
            app.NumberofPulsesPerStepContSARHwTrgEditField.Value = 1;

            % Create SARConfigurationSWTriggerTab
            app.SARConfigurationSWTriggerTab = uitab(app.TabGroup);
            app.SARConfigurationSWTriggerTab.Title = 'SAR Configuration (SW Trigger)';
            app.SARConfigurationSWTriggerTab.BackgroundColor = [1 1 1];
            app.SARConfigurationSWTriggerTab.ForegroundColor = [0.0745 0.6235 1];

            % Create SARConfigurationContinuousHorizontalScanPanel
            app.SARConfigurationContinuousHorizontalScanPanel = uipanel(app.SARConfigurationSWTriggerTab);
            app.SARConfigurationContinuousHorizontalScanPanel.AutoResizeChildren = 'off';
            app.SARConfigurationContinuousHorizontalScanPanel.ForegroundColor = [0.0745 0.6235 1];
            app.SARConfigurationContinuousHorizontalScanPanel.Title = 'SAR Configuration (Continuous Horizontal Scan)';
            app.SARConfigurationContinuousHorizontalScanPanel.BackgroundColor = [1 1 1];
            app.SARConfigurationContinuousHorizontalScanPanel.FontWeight = 'bold';
            app.SARConfigurationContinuousHorizontalScanPanel.FontSize = 16;
            app.SARConfigurationContinuousHorizontalScanPanel.Position = [28 10 555 572];

            % Create StartCapturingContSARCommandButton
            app.StartCapturingContSARCommandButton = uibutton(app.SARConfigurationContinuousHorizontalScanPanel, 'push');
            app.StartCapturingContSARCommandButton.ButtonPushedFcn = createCallbackFcn(app, @StartCapturingContSARCommandButtonPushed, true);
            app.StartCapturingContSARCommandButton.BackgroundColor = [0.4706 0.6706 0.1882];
            app.StartCapturingContSARCommandButton.FontSize = 16;
            app.StartCapturingContSARCommandButton.FontColor = [1 1 1];
            app.StartCapturingContSARCommandButton.Position = [195 158 152 54];
            app.StartCapturingContSARCommandButton.Text = 'Start Capturing';

            % Create StopCapturingContSARCommandButton
            app.StopCapturingContSARCommandButton = uibutton(app.SARConfigurationContinuousHorizontalScanPanel, 'push');
            app.StopCapturingContSARCommandButton.ButtonPushedFcn = createCallbackFcn(app, @StopCapturingContSARCommandButtonPushed, true);
            app.StopCapturingContSARCommandButton.BackgroundColor = [1 0 0];
            app.StopCapturingContSARCommandButton.FontSize = 16;
            app.StopCapturingContSARCommandButton.FontColor = [1 1 1];
            app.StopCapturingContSARCommandButton.Enable = 'off';
            app.StopCapturingContSARCommandButton.Position = [370 158 150 54];
            app.StopCapturingContSARCommandButton.Text = 'Stop Capturing';

            % Create VerticalStepSizemmContSARLabel
            app.VerticalStepSizemmContSARLabel = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.VerticalStepSizemmContSARLabel.VerticalAlignment = 'top';
            app.VerticalStepSizemmContSARLabel.FontSize = 14;
            app.VerticalStepSizemmContSARLabel.Position = [223 235 217 22];
            app.VerticalStepSizemmContSARLabel.Text = 'Blank between values. Ex: 0.9 1.9';

            % Create RecommendNumberOfFramesButtonContSAR
            app.RecommendNumberOfFramesButtonContSAR = uibutton(app.SARConfigurationContinuousHorizontalScanPanel, 'push');
            app.RecommendNumberOfFramesButtonContSAR.ButtonPushedFcn = createCallbackFcn(app, @RecommendNumberOfFramesButtonContSARPushed, true);
            app.RecommendNumberOfFramesButtonContSAR.BackgroundColor = [0.149 0.149 0.149];
            app.RecommendNumberOfFramesButtonContSAR.FontSize = 14;
            app.RecommendNumberOfFramesButtonContSAR.FontColor = [1 1 1];
            app.RecommendNumberOfFramesButtonContSAR.Position = [335 388 101 27];
            app.RecommendNumberOfFramesButtonContSAR.Text = 'Recommend';

            % Create TimeBeforeCapturingsLabel
            app.TimeBeforeCapturingsLabel = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.TimeBeforeCapturingsLabel.FontSize = 14;
            app.TimeBeforeCapturingsLabel.Position = [8 360 277 22];
            app.TimeBeforeCapturingsLabel.Text = 'Time Before Capturing (s)';

            % Create WaitTimeBeforeCapturingContSAREditField
            app.WaitTimeBeforeCapturingContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'numeric');
            app.WaitTimeBeforeCapturingContSAREditField.FontSize = 14;
            app.WaitTimeBeforeCapturingContSAREditField.Position = [224 360 88 22];
            app.WaitTimeBeforeCapturingContSAREditField.Value = -1;

            % Create NumberofStepsatVerticalScanLabel_3
            app.NumberofStepsatVerticalScanLabel_3 = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.NumberofStepsatVerticalScanLabel_3.VerticalAlignment = 'top';
            app.NumberofStepsatVerticalScanLabel_3.FontSize = 14;
            app.NumberofStepsatVerticalScanLabel_3.Position = [8 290 217 18];
            app.NumberofStepsatVerticalScanLabel_3.Text = 'Number of Steps at Vertical Scan';

            % Create VerticalScanStepsContSARSpinner
            app.VerticalScanStepsContSARSpinner = uispinner(app.SARConfigurationContinuousHorizontalScanPanel);
            app.VerticalScanStepsContSARSpinner.HorizontalAlignment = 'left';
            app.VerticalScanStepsContSARSpinner.FontSize = 14;
            app.VerticalScanStepsContSARSpinner.Position = [224 289 111 22];
            app.VerticalScanStepsContSARSpinner.Value = 1;

            % Create VerticalStepSizemmLabel_3
            app.VerticalStepSizemmLabel_3 = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.VerticalStepSizemmLabel_3.VerticalAlignment = 'top';
            app.VerticalStepSizemmLabel_3.FontSize = 14;
            app.VerticalStepSizemmLabel_3.Position = [8 261 164 18];
            app.VerticalStepSizemmLabel_3.Text = 'Vertical Step Size (mm)';

            % Create VerticalStepSizemmContSAREditField
            app.VerticalStepSizemmContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'text');
            app.VerticalStepSizemmContSAREditField.HorizontalAlignment = 'right';
            app.VerticalStepSizemmContSAREditField.FontSize = 14;
            app.VerticalStepSizemmContSAREditField.Position = [224 260 187 22];
            app.VerticalStepSizemmContSAREditField.Value = '7.59';

            % Create FramePeriodicitymsLabel
            app.FramePeriodicitymsLabel = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.FramePeriodicitymsLabel.FontSize = 14;
            app.FramePeriodicitymsLabel.Position = [8 422 230 18];
            app.FramePeriodicitymsLabel.Text = 'Frame Periodicity (ms)';

            % Create FramePeriodicitymsContSAREditField
            app.FramePeriodicitymsContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'numeric');
            app.FramePeriodicitymsContSAREditField.FontSize = 14;
            app.FramePeriodicitymsContSAREditField.Position = [224 420 88 22];
            app.FramePeriodicitymsContSAREditField.Value = 100;

            % Create HorizontalScanSizemmLabel_3
            app.HorizontalScanSizemmLabel_3 = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.HorizontalScanSizemmLabel_3.FontSize = 14;
            app.HorizontalScanSizemmLabel_3.Position = [8 331 175 18];
            app.HorizontalScanSizemmLabel_3.Text = 'Horizontal Scan Size (mm)';

            % Create HorizontalScanSizemmContSAREditField
            app.HorizontalScanSizemmContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'numeric');
            app.HorizontalScanSizemmContSAREditField.FontSize = 14;
            app.HorizontalScanSizemmContSAREditField.Position = [224 329 88 22];

            % Create NumberofFramesEditFieldLabel
            app.NumberofFramesEditFieldLabel = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.NumberofFramesEditFieldLabel.FontSize = 14;
            app.NumberofFramesEditFieldLabel.Position = [8 392 139 18];
            app.NumberofFramesEditFieldLabel.Text = 'Number of Frames';

            % Create NumberofFramesContSAREditField
            app.NumberofFramesContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'numeric');
            app.NumberofFramesContSAREditField.FontSize = 14;
            app.NumberofFramesContSAREditField.Position = [224 391 88 22];
            app.NumberofFramesContSAREditField.Value = 1;

            % Create ifRadarTriggerFirstLabel
            app.ifRadarTriggerFirstLabel = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.ifRadarTriggerFirstLabel.FontSize = 14;
            app.ifRadarTriggerFirstLabel.Position = [335 360 161 22];
            app.ifRadarTriggerFirstLabel.Text = '((-) if Radar Trigger First)';

            % Create PlatformSpeedmmsEditFieldLabel
            app.PlatformSpeedmmsEditFieldLabel = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.PlatformSpeedmmsEditFieldLabel.FontSize = 14;
            app.PlatformSpeedmmsEditFieldLabel.Position = [8 518 149 22];
            app.PlatformSpeedmmsEditFieldLabel.Text = 'Platform Speed (mm/s)';

            % Create PlatformSpeedmmpsContSAREditField
            app.PlatformSpeedmmpsContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'numeric');
            app.PlatformSpeedmmpsContSAREditField.Editable = 'off';
            app.PlatformSpeedmmpsContSAREditField.FontSize = 14;
            app.PlatformSpeedmmpsContSAREditField.Position = [206 518 65 22];
            app.PlatformSpeedmmpsContSAREditField.Value = 10;

            % Create ReconfigureRadarContSARButton
            app.ReconfigureRadarContSARButton = uibutton(app.SARConfigurationContinuousHorizontalScanPanel, 'push');
            app.ReconfigureRadarContSARButton.ButtonPushedFcn = createCallbackFcn(app, @ReconfigureRadarContSARButtonPushed, true);
            app.ReconfigureRadarContSARButton.BackgroundColor = [0 0.451 0.7412];
            app.ReconfigureRadarContSARButton.FontSize = 16;
            app.ReconfigureRadarContSARButton.FontColor = [1 1 1];
            app.ReconfigureRadarContSARButton.Position = [26 158 152 51];
            app.ReconfigureRadarContSARButton.Text = {'Reconfigure'; 'Radar'};

            % Create TotalContSARMovementPanel
            app.TotalContSARMovementPanel = uipanel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.TotalContSARMovementPanel.Title = 'Total Movement';
            app.TotalContSARMovementPanel.BackgroundColor = [1 1 1];
            app.TotalContSARMovementPanel.FontSize = 14;
            app.TotalContSARMovementPanel.Position = [8 9 214 123];

            % Create TotalMovementContSARTextArea
            app.TotalMovementContSARTextArea = uitextarea(app.TotalContSARMovementPanel);
            app.TotalMovementContSARTextArea.FontSize = 14;
            app.TotalMovementContSARTextArea.Position = [8 6 198 87];

            % Create ContSARStatusPanel
            app.ContSARStatusPanel = uipanel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.ContSARStatusPanel.AutoResizeChildren = 'off';
            app.ContSARStatusPanel.Title = 'SAR Status';
            app.ContSARStatusPanel.BackgroundColor = [1 1 1];
            app.ContSARStatusPanel.FontSize = 14;
            app.ContSARStatusPanel.Position = [234 9 308 123];

            % Create Label_3
            app.Label_3 = uilabel(app.ContSARStatusPanel);
            app.Label_3.VerticalAlignment = 'top';
            app.Label_3.FontSize = 14;
            app.Label_3.Position = [279 73 25 22];
            app.Label_3.Text = '';

            % Create ContSARStatusTextArea
            app.ContSARStatusTextArea = uitextarea(app.ContSARStatusPanel);
            app.ContSARStatusTextArea.FontSize = 14;
            app.ContSARStatusTextArea.Position = [7 6 297 89];

            % Create ofSamplesChannelLabel
            app.ofSamplesChannelLabel = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.ofSamplesChannelLabel.FontSize = 14;
            app.ofSamplesChannelLabel.Position = [8 488 143 22];
            app.ofSamplesChannelLabel.Text = '# of Samples/Channel';

            % Create NumberofSamplesPerChannelContSAREditField
            app.NumberofSamplesPerChannelContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'numeric');
            app.NumberofSamplesPerChannelContSAREditField.ValueDisplayFormat = '%.0f';
            app.NumberofSamplesPerChannelContSAREditField.Editable = 'off';
            app.NumberofSamplesPerChannelContSAREditField.FontSize = 14;
            app.NumberofSamplesPerChannelContSAREditField.Position = [158 488 113 22];

            % Create HorizontalStepSizemmLabel_2
            app.HorizontalStepSizemmLabel_2 = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.HorizontalStepSizemmLabel_2.FontSize = 14;
            app.HorizontalStepSizemmLabel_2.Position = [295 518 169 22];
            app.HorizontalStepSizemmLabel_2.Text = 'Horizontal Step Size (mm)';

            % Create HorizontalStepSizemmContSAREditField
            app.HorizontalStepSizemmContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'numeric');
            app.HorizontalStepSizemmContSAREditField.ValueDisplayFormat = '%.4f';
            app.HorizontalStepSizemmContSAREditField.Editable = 'off';
            app.HorizontalStepSizemmContSAREditField.FontSize = 14;
            app.HorizontalStepSizemmContSAREditField.Position = [467 518 75 22];

            % Create UpdateParamsContSARButton
            app.UpdateParamsContSARButton = uibutton(app.SARConfigurationContinuousHorizontalScanPanel, 'push');
            app.UpdateParamsContSARButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateParamsContSARButtonPushed, true);
            app.UpdateParamsContSARButton.BackgroundColor = [0.149 0.149 0.149];
            app.UpdateParamsContSARButton.FontSize = 14;
            app.UpdateParamsContSARButton.FontColor = [1 1 1];
            app.UpdateParamsContSARButton.Position = [295 459 103 51];
            app.UpdateParamsContSARButton.Text = {'Update'; 'Params'};

            % Create VerticalScanSizemmLabel_2
            app.VerticalScanSizemmLabel_2 = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.VerticalScanSizemmLabel_2.FontSize = 14;
            app.VerticalScanSizemmLabel_2.Position = [8 458 163 22];
            app.VerticalScanSizemmLabel_2.Text = 'Vertical Scan Size (mm)';

            % Create VerticalScanSizemmContSAREditField
            app.VerticalScanSizemmContSAREditField = uieditfield(app.SARConfigurationContinuousHorizontalScanPanel, 'numeric');
            app.VerticalScanSizemmContSAREditField.ValueDisplayFormat = '%.4f';
            app.VerticalScanSizemmContSAREditField.Editable = 'off';
            app.VerticalScanSizemmContSAREditField.FontSize = 14;
            app.VerticalScanSizemmContSAREditField.Position = [183 459 88 22];

            % Create ScanModeSwitchLabel
            app.ScanModeSwitchLabel = uilabel(app.SARConfigurationContinuousHorizontalScanPanel);
            app.ScanModeSwitchLabel.HorizontalAlignment = 'center';
            app.ScanModeSwitchLabel.FontSize = 14;
            app.ScanModeSwitchLabel.Position = [410 459 76 22];
            app.ScanModeSwitchLabel.Text = 'Scan Mode';

            % Create ScanModeContSARSwitch
            app.ScanModeContSARSwitch = uiswitch(app.SARConfigurationContinuousHorizontalScanPanel, 'rocker');
            app.ScanModeContSARSwitch.Items = {'Raster', 'Rectangular'};
            app.ScanModeContSARSwitch.FontSize = 14;
            app.ScanModeContSARSwitch.Position = [490 448 20 45];
            app.ScanModeContSARSwitch.Value = 'Rectangular';

            % Create SARConfigurationDiscreteHorizontalScanPanel
            app.SARConfigurationDiscreteHorizontalScanPanel = uipanel(app.SARConfigurationSWTriggerTab);
            app.SARConfigurationDiscreteHorizontalScanPanel.AutoResizeChildren = 'off';
            app.SARConfigurationDiscreteHorizontalScanPanel.ForegroundColor = [0.0745 0.6235 1];
            app.SARConfigurationDiscreteHorizontalScanPanel.Title = 'SAR Configuration (Discrete Horizontal Scan)';
            app.SARConfigurationDiscreteHorizontalScanPanel.BackgroundColor = [1 1 1];
            app.SARConfigurationDiscreteHorizontalScanPanel.FontWeight = 'bold';
            app.SARConfigurationDiscreteHorizontalScanPanel.FontSize = 16;
            app.SARConfigurationDiscreteHorizontalScanPanel.Position = [618 10 568 572];

            % Create StartCapturingDiscSARCommandButton
            app.StartCapturingDiscSARCommandButton = uibutton(app.SARConfigurationDiscreteHorizontalScanPanel, 'push');
            app.StartCapturingDiscSARCommandButton.ButtonPushedFcn = createCallbackFcn(app, @StartCapturingDiscSARCommandButtonPushed, true);
            app.StartCapturingDiscSARCommandButton.BackgroundColor = [0.4706 0.6706 0.1882];
            app.StartCapturingDiscSARCommandButton.FontSize = 16;
            app.StartCapturingDiscSARCommandButton.FontColor = [1 1 1];
            app.StartCapturingDiscSARCommandButton.Position = [205 158 152 54];
            app.StartCapturingDiscSARCommandButton.Text = 'Start Capturing';

            % Create StopCapturingDiscSARCommandButton
            app.StopCapturingDiscSARCommandButton = uibutton(app.SARConfigurationDiscreteHorizontalScanPanel, 'push');
            app.StopCapturingDiscSARCommandButton.ButtonPushedFcn = createCallbackFcn(app, @StopCapturingDiscSARCommandButtonPushed, true);
            app.StopCapturingDiscSARCommandButton.BackgroundColor = [1 0 0];
            app.StopCapturingDiscSARCommandButton.FontSize = 16;
            app.StopCapturingDiscSARCommandButton.FontColor = [1 1 1];
            app.StopCapturingDiscSARCommandButton.Enable = 'off';
            app.StopCapturingDiscSARCommandButton.Position = [380 158 150 54];
            app.StopCapturingDiscSARCommandButton.Text = 'Stop Capturing';

            % Create Blankbetweenvalues0919DiscSARLabel
            app.Blankbetweenvalues0919DiscSARLabel = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.Blankbetweenvalues0919DiscSARLabel.VerticalAlignment = 'top';
            app.Blankbetweenvalues0919DiscSARLabel.FontSize = 14;
            app.Blankbetweenvalues0919DiscSARLabel.Position = [255 271 217 22];
            app.Blankbetweenvalues0919DiscSARLabel.Text = 'Blank between values. Ex: 0.9 1.9';

            % Create NumberofStepsatVerticalScanLabel_4
            app.NumberofStepsatVerticalScanLabel_4 = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.NumberofStepsatVerticalScanLabel_4.VerticalAlignment = 'top';
            app.NumberofStepsatVerticalScanLabel_4.FontSize = 14;
            app.NumberofStepsatVerticalScanLabel_4.Position = [8 327 217 18];
            app.NumberofStepsatVerticalScanLabel_4.Text = 'Number of Steps at Vertical Scan';

            % Create VerticalScanStepsDiscSARSpinner
            app.VerticalScanStepsDiscSARSpinner = uispinner(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.VerticalScanStepsDiscSARSpinner.HorizontalAlignment = 'left';
            app.VerticalScanStepsDiscSARSpinner.FontSize = 14;
            app.VerticalScanStepsDiscSARSpinner.Position = [255 326 111 22];
            app.VerticalScanStepsDiscSARSpinner.Value = 1;

            % Create VerticalStepSizemmLabel_4
            app.VerticalStepSizemmLabel_4 = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.VerticalStepSizemmLabel_4.VerticalAlignment = 'top';
            app.VerticalStepSizemmLabel_4.FontSize = 14;
            app.VerticalStepSizemmLabel_4.Position = [8 298 164 18];
            app.VerticalStepSizemmLabel_4.Text = 'Vertical Step Size (mm)';

            % Create VerticalStepSizemmDiscSAREditField
            app.VerticalStepSizemmDiscSAREditField = uieditfield(app.SARConfigurationDiscreteHorizontalScanPanel, 'text');
            app.VerticalStepSizemmDiscSAREditField.HorizontalAlignment = 'right';
            app.VerticalStepSizemmDiscSAREditField.FontSize = 14;
            app.VerticalStepSizemmDiscSAREditField.Position = [255 297 187 22];
            app.VerticalStepSizemmDiscSAREditField.Value = '0';

            % Create HorizontalScanSizemmLabel_4
            app.HorizontalScanSizemmLabel_4 = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.HorizontalScanSizemmLabel_4.FontSize = 14;
            app.HorizontalScanSizemmLabel_4.Position = [8 488 175 18];
            app.HorizontalScanSizemmLabel_4.Text = 'Horizontal Scan Size (mm)';

            % Create HorizontalScanSizemmDiscSAREditField
            app.HorizontalScanSizemmDiscSAREditField = uieditfield(app.SARConfigurationDiscreteHorizontalScanPanel, 'numeric');
            app.HorizontalScanSizemmDiscSAREditField.ValueDisplayFormat = '%.4f';
            app.HorizontalScanSizemmDiscSAREditField.Editable = 'off';
            app.HorizontalScanSizemmDiscSAREditField.FontSize = 14;
            app.HorizontalScanSizemmDiscSAREditField.Position = [197 486 88 22];

            % Create NumberofFramesEditFieldLabel_2
            app.NumberofFramesEditFieldLabel_2 = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.NumberofFramesEditFieldLabel_2.FontSize = 14;
            app.NumberofFramesEditFieldLabel_2.Position = [301 520 139 18];
            app.NumberofFramesEditFieldLabel_2.Text = 'Number of Frames';

            % Create NumberofFramesDiscSAREditField
            app.NumberofFramesDiscSAREditField = uieditfield(app.SARConfigurationDiscreteHorizontalScanPanel, 'numeric');
            app.NumberofFramesDiscSAREditField.FontSize = 14;
            app.NumberofFramesDiscSAREditField.Position = [429 518 62 22];
            app.NumberofFramesDiscSAREditField.Value = 1;

            % Create ReconfigureRadarDiscSARButton
            app.ReconfigureRadarDiscSARButton = uibutton(app.SARConfigurationDiscreteHorizontalScanPanel, 'push');
            app.ReconfigureRadarDiscSARButton.ButtonPushedFcn = createCallbackFcn(app, @ReconfigureRadarDiscSARButtonPushed, true);
            app.ReconfigureRadarDiscSARButton.BackgroundColor = [0 0.451 0.7412];
            app.ReconfigureRadarDiscSARButton.FontSize = 16;
            app.ReconfigureRadarDiscSARButton.FontColor = [1 1 1];
            app.ReconfigureRadarDiscSARButton.Position = [36 158 152 51];
            app.ReconfigureRadarDiscSARButton.Text = {'Reconfigure'; 'Radar'};

            % Create TotalDiscSARMovementPanel
            app.TotalDiscSARMovementPanel = uipanel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.TotalDiscSARMovementPanel.Title = 'Total Movement';
            app.TotalDiscSARMovementPanel.BackgroundColor = [1 1 1];
            app.TotalDiscSARMovementPanel.FontSize = 14;
            app.TotalDiscSARMovementPanel.Position = [8 9 214 123];

            % Create TotalMovementDiscSARTextArea
            app.TotalMovementDiscSARTextArea = uitextarea(app.TotalDiscSARMovementPanel);
            app.TotalMovementDiscSARTextArea.FontSize = 14;
            app.TotalMovementDiscSARTextArea.Position = [8 6 198 87];

            % Create DiscSARStatusPanel
            app.DiscSARStatusPanel = uipanel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.DiscSARStatusPanel.AutoResizeChildren = 'off';
            app.DiscSARStatusPanel.Title = 'SAR Status';
            app.DiscSARStatusPanel.BackgroundColor = [1 1 1];
            app.DiscSARStatusPanel.FontSize = 14;
            app.DiscSARStatusPanel.Position = [234 9 320 123];

            % Create Label_4
            app.Label_4 = uilabel(app.DiscSARStatusPanel);
            app.Label_4.VerticalAlignment = 'top';
            app.Label_4.FontSize = 14;
            app.Label_4.Position = [288 73 25 22];
            app.Label_4.Text = '';

            % Create DiscSARStatusTextArea
            app.DiscSARStatusTextArea = uitextarea(app.DiscSARStatusPanel);
            app.DiscSARStatusTextArea.FontSize = 14;
            app.DiscSARStatusTextArea.Position = [7 6 306 89];

            % Create ofSamplesChannelLabel_2
            app.ofSamplesChannelLabel_2 = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.ofSamplesChannelLabel_2.FontSize = 14;
            app.ofSamplesChannelLabel_2.Position = [8 518 143 22];
            app.ofSamplesChannelLabel_2.Text = '# of Samples/Channel';

            % Create NumberofSamplesPerChannelDiscSAREditField
            app.NumberofSamplesPerChannelDiscSAREditField = uieditfield(app.SARConfigurationDiscreteHorizontalScanPanel, 'numeric');
            app.NumberofSamplesPerChannelDiscSAREditField.ValueDisplayFormat = '%.0f';
            app.NumberofSamplesPerChannelDiscSAREditField.Editable = 'off';
            app.NumberofSamplesPerChannelDiscSAREditField.FontSize = 14;
            app.NumberofSamplesPerChannelDiscSAREditField.Position = [177 518 108 22];

            % Create UpdateParamsDiscSARButton
            app.UpdateParamsDiscSARButton = uibutton(app.SARConfigurationDiscreteHorizontalScanPanel, 'push');
            app.UpdateParamsDiscSARButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateParamsDiscSARButtonPushed, true);
            app.UpdateParamsDiscSARButton.BackgroundColor = [0.149 0.149 0.149];
            app.UpdateParamsDiscSARButton.FontSize = 14;
            app.UpdateParamsDiscSARButton.FontColor = [1 1 1];
            app.UpdateParamsDiscSARButton.Position = [301 452 100 51];
            app.UpdateParamsDiscSARButton.Text = {'Update'; 'Params'};

            % Create VerticalScanSizemmLabel
            app.VerticalScanSizemmLabel = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.VerticalScanSizemmLabel.FontSize = 14;
            app.VerticalScanSizemmLabel.Position = [8 452 175 22];
            app.VerticalScanSizemmLabel.Text = 'Vertical Scan Size (mm)';

            % Create VerticalScanSizemmDiscSAREditField
            app.VerticalScanSizemmDiscSAREditField = uieditfield(app.SARConfigurationDiscreteHorizontalScanPanel, 'numeric');
            app.VerticalScanSizemmDiscSAREditField.ValueDisplayFormat = '%.4f';
            app.VerticalScanSizemmDiscSAREditField.Editable = 'off';
            app.VerticalScanSizemmDiscSAREditField.FontSize = 14;
            app.VerticalScanSizemmDiscSAREditField.Position = [197 454 88 22];

            % Create NumberofStepsatHorizontalScanLabel
            app.NumberofStepsatHorizontalScanLabel = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.NumberofStepsatHorizontalScanLabel.VerticalAlignment = 'top';
            app.NumberofStepsatHorizontalScanLabel.FontSize = 14;
            app.NumberofStepsatHorizontalScanLabel.Position = [9 394 231 22];
            app.NumberofStepsatHorizontalScanLabel.Text = 'Number of Steps at Horizontal Scan';

            % Create HorizontalScanStepsDiscSARSpinner
            app.HorizontalScanStepsDiscSARSpinner = uispinner(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.HorizontalScanStepsDiscSARSpinner.HorizontalAlignment = 'left';
            app.HorizontalScanStepsDiscSARSpinner.FontSize = 14;
            app.HorizontalScanStepsDiscSARSpinner.Position = [255 397 111 22];
            app.HorizontalScanStepsDiscSARSpinner.Value = 1;

            % Create WaitTimeBetweenStepssEditField_2Label
            app.WaitTimeBetweenStepssEditField_2Label = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.WaitTimeBetweenStepssEditField_2Label.HorizontalAlignment = 'right';
            app.WaitTimeBetweenStepssEditField_2Label.VerticalAlignment = 'top';
            app.WaitTimeBetweenStepssEditField_2Label.FontSize = 14;
            app.WaitTimeBetweenStepssEditField_2Label.Position = [9 239 181 18];
            app.WaitTimeBetweenStepssEditField_2Label.Text = 'Wait Time Between Steps (s)';

            % Create WaitTimeBetweenStepsDiscSAREditField
            app.WaitTimeBetweenStepsDiscSAREditField = uieditfield(app.SARConfigurationDiscreteHorizontalScanPanel, 'numeric');
            app.WaitTimeBetweenStepsDiscSAREditField.FontSize = 14;
            app.WaitTimeBetweenStepsDiscSAREditField.Position = [255 237 100 22];
            app.WaitTimeBetweenStepsDiscSAREditField.Value = 1;

            % Create HorizontalStepSizemmEditFieldLabel
            app.HorizontalStepSizemmEditFieldLabel = uilabel(app.SARConfigurationDiscreteHorizontalScanPanel);
            app.HorizontalStepSizemmEditFieldLabel.FontSize = 14;
            app.HorizontalStepSizemmEditFieldLabel.Position = [9 370 169 22];
            app.HorizontalStepSizemmEditFieldLabel.Text = 'Horizontal Step Size (mm)';

            % Create HorizontalStepSizemmDiscSAREditField
            app.HorizontalStepSizemmDiscSAREditField = uieditfield(app.SARConfigurationDiscreteHorizontalScanPanel, 'numeric');
            app.HorizontalStepSizemmDiscSAREditField.FontSize = 14;
            app.HorizontalStepSizemmDiscSAREditField.Position = [256 370 187 22];

            % Create EmergencyStopScannerButton
            app.EmergencyStopScannerButton = uibutton(app.SARGUI, 'push');
            app.EmergencyStopScannerButton.ButtonPushedFcn = createCallbackFcn(app, @EmergencyStopScannerButtonPushed, true);
            app.EmergencyStopScannerButton.BackgroundColor = [1 0 0];
            app.EmergencyStopScannerButton.FontSize = 20;
            app.EmergencyStopScannerButton.FontColor = [1 1 1];
            app.EmergencyStopScannerButton.Position = [478.5 13 245 54];
            app.EmergencyStopScannerButton.Text = 'Emergency Stop Scanner';

            % Create VersionLabel
            app.VersionLabel = uilabel(app.SARGUI);
            app.VersionLabel.HorizontalAlignment = 'right';
            app.VersionLabel.VerticalAlignment = 'top';
            app.VersionLabel.FontSize = 18;
            app.VersionLabel.FontWeight = 'bold';
            app.VersionLabel.FontColor = [0.0745 0.6235 1];
            app.VersionLabel.Position = [941 698 286 43];
            app.VersionLabel.Text = 'xWR1xxx and AMC4030 Version';

            % Show the figure after all components are created
            app.SARGUI.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SAR_GUI_Source

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.SARGUI)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.SARGUI)
        end
    end
end