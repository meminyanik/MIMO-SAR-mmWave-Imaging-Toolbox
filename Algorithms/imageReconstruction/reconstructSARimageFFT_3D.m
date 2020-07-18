%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function [sarImage,xRangeT_mm,yRangeT_mm,zRangeT_mm] = reconstructSARimageFFT_3D(sarData,frequency,xStepM,yStepM,xySizeT,zTarget,nFFTkXY,zRadar,xUpsampleM,yUpsampleM)
% For wideband processing:
% -------------------------------------------------------------------------
% sarData: should be yPointM x xPointM x nSample


% Example function calls, see details below
% -------------------------------------------------------------------------
% lambda/4 = 0.9487, f0 = 77e9+6e-6*63.343e12;
% [77e9,150e12,3000e3,4e-6] = [fStart(Hz),fSlope(Hz/s),fSample(sps),adcStart(s)]
% Image for Tx0-Rx0 antenna pair with monostatic assumption
% sarImage = reconstructSARimageFFT_3D(sarData,[77e9,63.343e12,9121e3,6e-6],200/406,2,-1,300,512);
% sarImage = reconstructSARimageFFT_3D(sarData,[77e9,63.343e12,9121e3,6e-6],300/305,3.795/4,-1,291,1024); lambda/4 = 0.9487
% sarImage = reconstructSARimageFFT_3D(sarData,[77e9,63.343e12,9121e3,6e-6],400/406,7.59/8,-1,[200:10:600],512);
% sarImage = reconstructSARimageFFT_3D(sarData,[77e9,63.343e12,9121e3,6e-6],400/414,7.59/8,-1,[200:10:600],512);
% sarImage = reconstructSARimageFFT_3D(sarData,[77e9,70.295e12,5000e3,4.66e-6],400/407,7.59/8,-1,[200:5:250],1024);
% [sarImage,xRangeT,yRangeT,zRangeT] = reconstructSARimageFFT_3D(sarData3D,[77e9,70.295e12,5000e3,4.66e-6],400/407,7.59/8,-1,-1,512);

% For wideband processing:
% -------------------------------------------------------------------------
% frequency: [fStart,fSlope,fSample,nSample]
% fStart: Start frequency
% fSlope: Slope const (Hz/sec)
% fSample: Sample ps
% Example: [77e9,63.343e12,9121e3]

% Variables
% -------------------------------------------------------------------------
% xStepM: measurement step size at x (horizontal) axis in mm
% yStepM: measurement step size at y (vertical) axis in mm
%
% xySizeT: size of target area in mm
% zTarget: target distance in mm
% nFFTkXY: number of FFT points, should be greater than xStepM and yStepM


%% Code Starts
% profile on


%% Define Optional Parameters
%-------------------------------------------------------------------------%
if (nargin < 10)
    yUpsampleM = 1;
end
if (nargin < 9)
    xUpsampleM = 1;
end
if (nargin < 8)
    zRadar = 0;
end


%% Define Fixed Parameters
%-------------------------------------------------------------------------%
isAmplitudeFactor = true; % Set true if Amplitude Factor is needed for 2D

is3DImagingStolt = false;
is3DImagingManualZ = false;
is2DImaging = false;

if length(zTarget) > 1 % is3DImaging is true if depth data is given
    is3DImagingManualZ = true;
elseif zTarget == -1
    is3DImagingStolt = true;
else
    is2DImaging = true;
end


%% Define Frequency Spectrum
%-------------------------------------------------------------------------%
[~,~,nSample] = size(sarData); % Number of samples
if (length(frequency)>1) && (length(frequency)<=4) && (nSample>1)
    frequency = num2cell(frequency);
    [f0,K,fS,adcStart] = frequency{:};
    f0 = f0 + adcStart*K; % This is for ADC sampling offset
    f = f0 + (0:nSample-1)*K/fS; % wideband frequency
elseif (length(frequency)==1) && (nSample==1) && (is2DImaging == true)
    f = frequency;
else
    error('Please correct the configuration and data for 3D processing')
end


%% Define Fixed Parameters
%-------------------------------------------------------------------------%
c = 299792458; % physconst('lightspeed'); in m/s
k = 2*pi*f/c;
k = reshape(k,1,1,[]);


%% Coincide Aperture and Target Domains
%-------------------------------------------------------------------------%
if yUpsampleM > 1
    sarData = upsample(sarData,yUpsampleM);
end
if xUpsampleM > 1
    sarData = permute(sarData,[2,1,3]);
    sarData = upsample(sarData,xUpsampleM);
    sarData = permute(sarData,[2,1,3]);
end

[yPointM,xPointM,~] = size(sarData);
xStepT = xStepM / xUpsampleM;
yStepT = yStepM / yUpsampleM;
zRangeT_mm = zTarget * 1e-3;


%% Define Number of FFT Points
%-------------------------------------------------------------------------%
if (nFFTkXY<xPointM) || (nFFTkXY<yPointM)
    warning('# of FFT points should be greater than the # of measurement points. FFT will be performed at # of measurement points')
end
% Set nFFTkX and nFFTkY accordingly
if (nFFTkXY>xPointM)
    nFFTkX = nFFTkXY;
else
    nFFTkX = xPointM;
end
if (nFFTkXY>yPointM)
    nFFTkY = nFFTkXY;
else
    nFFTkY = yPointM;
end


%% Define Wavenumbers
%-------------------------------------------------------------------------%
wSx = 2*pi/(xStepT*1e-3); % Sampling frequency for Target Domain
kX = linspace(-(wSx/2),(wSx/2),nFFTkX); % kX-Domain

wSy = 2*pi/(yStepT*1e-3); % Sampling frequency for Target Domain
kY = (linspace(-(wSy/2),(wSy/2),nFFTkY)).'; % kY-Domain


%% Zero Padding to sarData to Locate Target at Center
%-------------------------------------------------------------------------%
sarDataPadded = single(sarData);
clear sarData;
if (nFFTkXY > xPointM)
    sarDataPadded = padarray(sarDataPadded,[0 floor((nFFTkX-xPointM)/2)],0,'pre');
    sarDataPadded = padarray(sarDataPadded,[0 ceil((nFFTkX-xPointM)/2)],0,'post');
end
if (nFFTkXY > yPointM)
    sarDataPadded = padarray(sarDataPadded,[floor((nFFTkY-yPointM)/2) 0],0,'pre');
    sarDataPadded = padarray(sarDataPadded,[ceil((nFFTkY-yPointM)/2) 0],0,'post');
end


%% Calculate kZ
%-------------------------------------------------------------------------%
kZ = single(sqrt((2*k).^2 - kX.^2 - kY.^2));


%% Take 2D FFT of SAR Data
%-------------------------------------------------------------------------%
sarDataFFT = fftshift(fftshift(fft2(sarDataPadded),1),2);
clear sarDataPadded;

%% Create 2D-SAR Image for single Z
%-------------------------------------------------------------------------%
if is2DImaging
    phaseFactor = exp(-1i*zRangeT_mm*kZ);
    phaseFactor((kX.^2 + kY.^2) > (2*k).^2) = 0;
    
    if ~isAmplitudeFactor
        clear kZ;
    else
        sarDataFFT = kZ .* sarDataFFT;
        clear kZ;
    end
    
    sarDataFFT = sarDataFFT .* phaseFactor;
    
    sarDataFFT = sum(sarDataFFT,3);
    sarImage = ifft2(sarDataFFT);
end


%% Stolt Gridding
%-------------------------------------------------------------------------%
if is3DImagingStolt
    kZ((kX.^2 + kY.^2) > (2*k).^2) = 0;
    kZU = linspace(0,2*max(k),2*nSample);
    
    if isAmplitudeFactor
        sarDataFFT = kZ .* sarDataFFT;
    end
    
    if (zRadar ~=0 )
        zRadar_m = zRadar * 1e-3;
        phaseFactor_zRadar = exp(1i*kZ*zRadar_m);
        sarDataFFT = sarDataFFT .* phaseFactor_zRadar;
    end
    
    %% Stolt (Faster version)
    sarDataFFT_Stolt = single(zeros(nFFTkY,nFFTkX,length(kZU)));
    
    processBar = waitbar(0,'Processing...');
    for nX = 1:length(kX)
        for nY = 1:length(kY)
            dataTemp = squeeze(sarDataFFT(nY,nX,:));
            kZTemp = squeeze(kZ(nY,nX,:));
            
            [kZTemp_Unique,~,idx_c] = uniquetol(kZTemp);
            dataTemp = accumarray(idx_c,dataTemp);
            
            if (length(kZTemp_Unique)>2)
                sarDataFFT_Stolt(nY,nX,:) = interp1(kZTemp_Unique,dataTemp,kZU,'nearest',0);
            end
            
        end
        
        waitbar(nX/length(kX));
    end
    delete(processBar)
    
    %% Stolt (Slower version)
    %         sarDataFFT_Stolt = single(zeros(nFFTkY,nFFTkX,length(kZU)));
    %
    %         processBar = waitbar(0,'Processing...');
    %         for nX = 1:length(kX)
    %             for nY = 1:length(kY)
    %                 for nk = 1:length(k)
    %                     dataTemp = squeeze(sarDataFFT(nY,nX,nk));
    %                     kZTemp = squeeze(kZ(nY,nX,nk));
    %                     [~,ix] = min(abs(kZU-kZTemp));
    %                     sarDataFFT_Stolt(nY,nX,ix) = sarDataFFT_Stolt(nY,nX,ix) + dataTemp;
    %                 end
    %             end
    %
    %             waitbar(nX/length(kX));
    %         end
    %         delete(processBar)
    
    
    %% Stolt (Alternative faster version)
    %     sarDataFFT_Stolt = single(zeros(nFFTkY,nFFTkX,length(kZU)));
    %     
    %     kZU_S = 1/2 * sqrt(kY.^2 + kX.^2 + reshape(kZU,1,1,[]).^2);
    %     
    %     processBar = waitbar(0,'Processing...');
    %     
    %     for nY = 1:length(kY) % Replace with parfor to increase speed
    %         for nX = 1:length(kX)
    %             sarDataFFT_Stolt(nY,nX,:) = interp1(k(:),squeeze(sarDataFFT(nY,nX,:)),squeeze(kZU_S(nY,nX,:)),"v5cubic");
    %         end
    %         waitbar(nY/length(kY));
    %     end
    %     sarDataFFT_Stolt(isnan(sarDataFFT_Stolt)) = 0;
    %     
    %     delete(processBar)
    
    
    %% Create Image
    sarImage_fft = fft(sarDataFFT_Stolt,length(kZU),3);
    sarImage = ifft2(sarImage_fft);
end


%% Manual Z-Focusing V1, Create 3D-SAR Image
%-------------------------------------------------------------------------%
if is3DImagingManualZ
    [ySizeData,xSizeData,~] = size(sarDataFFT);
    sarImageIfft = zeros(ySizeData,xSizeData,length(zRangeT_mm));
    for n = 1:length(zRangeT_mm)
        phaseFactor = exp(-1i*zRangeT_mm(n)*kZ);
        phaseFactor((kX.^2 + kY.^2) > (2*k).^2) = 0;
        
        sarDataFFT = sarDataFFT .* phaseFactor;
        
        if isAmplitudeFactor
            amplitudeFactor = kZ;
            amplitudeFactor((kX.^2 + kY.^2) > (2*k).^2) = 0;
            sarDataFFT = sarDataFFT .* amplitudeFactor;
        end
        
        sarImageIfft(:,:,n) = sum(sarDataFFT,3);
    end
    sarImage = ifft2(sarImageIfft);
end


%% Define Target Axis
%-------------------------------------------------------------------------%
xRangeT_mm = xStepT * (-(nFFTkX-1)/2 : (nFFTkX-1)/2); % xStepM is in mm
yRangeT_mm = yStepT * (-(nFFTkY-1)/2 : (nFFTkY-1)/2); % xStepM is in mm

if is3DImagingStolt
    DeltakZ = kZU(2)-kZU(1);
    zMax = 2*pi/DeltakZ;
    zRangeT_mm = linspace(0,zMax,length(kZU)) * 1e3; % in mm
end

%% Flip Target in x-Axis
sarImage = flip(sarImage,2);


%% Crop the Image for Related Region
%-------------------------------------------------------------------------%
if (xySizeT ~= -1)
    
    if max(xRangeT_mm)<(xySizeT/2)
        xySizeT = 2*max(xRangeT_mm);
    end
    if max(yRangeT_mm)<(xySizeT/2)
        xySizeT = 2*max(yRangeT_mm);
    end
    
    indXpartT = xRangeT_mm>(-xySizeT/2) & xRangeT_mm<(xySizeT/2);
    indYpartT = yRangeT_mm>(-xySizeT/2) & yRangeT_mm<(xySizeT/2);
    
    xRangeT_mm = xRangeT_mm(indXpartT);
    yRangeT_mm = yRangeT_mm(indYpartT);
    if ~is2DImaging
        sarImage = sarImage(indYpartT,indXpartT,:);
    else
        sarImage = sarImage(indYpartT,indXpartT);
    end
end

%% Plot SAR Image
%-------------------------------------------------------------------------%
if is2DImaging
    figure('OuterPosition',[695 166 670 712]);
    mesh(xRangeT_mm,yRangeT_mm,abs(squeeze(sarImage)),'FaceColor','interp','LineStyle','none')
    view(2)
    colormap('gray');
    
    xlabel('Horizontal (mm)')
    ylabel('Vertical (mm)')
    titleFigure = "SAR 2D Image - " + zTarget + "mm Focused" ;
    title(titleFigure)
    
    % Or Log Image
    sarImageAbsLog = mag2db(abs(squeeze(sarImage))); % 20*log10
    sarImageAbsLog = sarImageAbsLog - max(max(sarImageAbsLog));
    
    figure('OuterPosition',[695 166 670 712]);
    mesh(xRangeT_mm,yRangeT_mm,sarImageAbsLog,'FaceColor','interp','LineStyle','none')
    view(2)
    colormap('gray');
    
    xlabel('Horizontal (mm)')
    ylabel('Vertical (mm)')
    titleFigure = "SAR 2D Log Image - " + zTarget + "mm Focused" ;
    title(titleFigure)
end


%% Write the output variable in a binary file (for ImageJ) in floating point format
%-------------------------------------------------------------------------%
% if is3DImaging
%     %%% Flip the Image in x-axis for Visualization
%     sarImage = flip(sarImage,2);
%     %%% Optional Interpolation in z-axis
%     %%% sarImageInt = spline(zTarget,sarImage,linspace(min(zTarget),max(zTarget),nFFTkXY));
%     fid = fopen('sar_image.bin','w');
%     fwrite(fid, abs(rot90(sarImage,-1)),'float');
%     fclose(fid);
% end

% profile viewer