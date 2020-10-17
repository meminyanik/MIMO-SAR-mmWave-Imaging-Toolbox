%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function [sarImage,xRangeT_mm,yRangeT_mm] = ...
    reconstructImage_3DMIMOSAR_MultipleSIMO_Multistatic(sarData,...
                                           frequency,...
                                           xStepM_mm,...
                                           yStepM_mm,...
                                           yOffset_mm,...
                                           dy_Rx_mm,...
                                           y_Tx_mm,...
                                           zTarget_mm,...
                                           xySizeT,...
                                           nFFTkX,...
                                           nFFTkY_Rx)
% -------------------------------------------------------------------------
% sarData: should be nRx x nTx x yPointM x xPointM x nSample
% Note: Rx domain should have a uniform spatial axis

% For wideband processing:
% -------------------------------------------------------------------------
% frequency: [fStart,fSlope,fSample,adcStart]
% fStart: Start frequency
% fSlope: Slope const (Hz/sec)
% fSample: Sample ps
% adcStart: ADC start time
% Example: [77e9,63.343e12,9121e3,6e-3]

% Parameters
% -------------------------------------------------------------------------
% xStepM_mm: measurement step size at x (horizontal) axis in mm
% yStepM_mm: measurement step size at y (vertical) axis in mm

% yOffset_mm: offset of the array at y (vertical) axis in mm (because of the array center)
% dy_Rx_mm: sampling distance in receiver domain in y-axis

% y_Tx_mm: transmitter antenna location (referenced to the 1st Rx antenna)

% zTarget_mm: target distance
% xySizeT: desired target size

% nFFTkX: number of FFT points in x-axis
% nFFTkY_Rx: number of FFT points in receiver domain in y-axis


%% Code Starts
% profile on


%% Define Frequency Spectrum
%-------------------------------------------------------------------------%
% Reshape sarData as:
% nRx x nTx x xPointM x yPointM x nSample
sarData = permute(sarData,[1,2,4,3,5]);

[yPointRx,~,xPointM,yPointM,nSample] = size(sarData);
if (length(frequency)==4) && (nSample>1)
    frequency = num2cell(frequency);
    [f0,K,fS,adcStart] = frequency{:};
    f0 = f0 + adcStart*K; % This is for ADC sampling offset
    f = f0 + (0:nSample-1)*K/fS; % wideband frequency
    if (length(zTarget_mm)==1)
       is2DImaging = true;
    else
        is2DImaging = false;
    end
elseif (length(frequency)==1) && (nSample==1) && (length(zTarget_mm)==1)
    is2DImaging = true;
    f = frequency;
else
    error('Please correct the configuration and data for 3D processing')
end


%% Define Fixed Parameters
%-------------------------------------------------------------------------%
c = physconst('lightspeed'); % in m/s
k = 2*pi*f/c;
k = reshape(k,1,1,1,[]);


%% Define Number of FFT Points
%-------------------------------------------------------------------------%
if (nFFTkX<xPointM) || (nFFTkY_Rx<yPointRx)
    error('# of FFT points should be greater than the # of measurement points. FFT will be performed at # of measurement points')
end


%% Target domain data
z = zTarget_mm*1e-3;


%% Zero Padding to sarData to Locate Target at Center
% Zero pad along Rx and x axes
%-------------------------------------------------------------------------%
sarData = single(conj(sarData)); % Take the conjugate to make consistent with the paper
sarData = padarray(sarData,[0 0 floor((nFFTkX-xPointM)/2)],0,'pre');
sarData = padarray(sarData,[0 0 ceil((nFFTkX-xPointM)/2)],0,'post');


%% Define Wavenumbers
%-------------------------------------------------------------------------%
wSx = 2*pi/(xStepM_mm*1e-3); % Sampling frequency for X-Domain
kX =  wSx/nFFTkX * (-(nFFTkX/2) : ((nFFTkX-1)/2));

wSy_Rx = 2*pi/(dy_Rx_mm*1e-3); % Sampling frequency for Transceiver-Y Domain
kY_Rx = wSy_Rx/nFFTkY_Rx * (-(nFFTkY_Rx/2) : ((nFFTkY_Rx-1)/2)).';


%% Take 2D FFT of SAR Data
% FFT along Rx and x axes
%-------------------------------------------------------------------------%
sarData = fftshift(sarData,3);
sarDataFFT_kXkY_Rx_All = fft(fft(sarData,nFFTkY_Rx,1),[],3);
sarDataFFT_kXkY_Rx_All = fftshift(fftshift(sarDataFFT_kXkY_Rx_All,1),3);
clear sarData;

% Correct the shift factor along y axis
yOffset = yOffset_mm * 1e-3;
phaseFactor_yOffset = exp(-1i*kY_Rx*yOffset);
sarDataFFT_kXkY_Rx_All = sarDataFFT_kXkY_Rx_All .* phaseFactor_yOffset;

% Correct the Tx antenna locations
y_Tx_mm = y_Tx_mm + yOffset_mm;


%% Define Measurement Locations at Linear Rail
% Coordinates: [x y z], x-Horizontal, y-Vertical, z-Depth
%-------------------------------------------------------------------------%
yAxisM = (yStepM_mm * (-(yPointM-1)/2 : (yPointM-1)/2) * 1e-3).';


%% Define Target Axis
%-------------------------------------------------------------------------%
yRangeT_mm = dy_Rx_mm * (-(nFFTkY_Rx)/2 : (nFFTkY_Rx-1)/2);
xRangeT_mm = xStepM_mm * (-(nFFTkX)/2 : (nFFTkX-1)/2);


%% Create the Image Per Measurement
sarImage = zeros(nFFTkY_Rx,nFFTkX,yPointM);

for nM = 1:yPointM
    
    %% Take the corresponding spectrum
    sarDataFFT_kXkY_Rx = squeeze(sarDataFFT_kXkY_Rx_All(:,:,:,nM,:));
    
    % Correct the shift factor along y axis
    phaseFactor_yOffset = exp(-1i*kY_Rx*yAxisM(nM));
    sarDataFFT_kXkY_Rx = sarDataFFT_kXkY_Rx .* phaseFactor_yOffset;
    
    
    %% Calculate Matched Filter
    %-------------------------------------------------------------------------%
    kX_Rx = single(reshape(kX/2,1,[]));
    kZ_Rx = sqrt(k.^2 - kX_Rx.^2 - kY_Rx.^2);
    phaseFactor_Rx = exp(1i*kZ_Rx.*z);
    phaseFactor_Rx((kX_Rx.^2 + kY_Rx.^2) > k.^2) = 0;
    phaseFactor_Rx = reshape(phaseFactor_Rx,nFFTkY_Rx,1,nFFTkX,[]);
    
    
    %% Compensate Matched Filter
    sarImageFFT_kXkY_Rx = sarDataFFT_kXkY_Rx .* phaseFactor_Rx;
    clear phaseFactor_Rx sarDataFFT_kXkY_Rx
    
    
    %% Image Per Tx
    sarImage_Temp_y_kX = ifftshift(ifft(ifftshift(sarImageFFT_kXkY_Rx,1),[],1),1);
    
    
    %% Image
    kX_Tx = single(reshape(kX/2,1,1,[]));
    kZ_Tx = sqrt(k.^2 - kX_Tx.^2);
    
    yRangeT = (yRangeT_mm * 1e-3).';
    y_Tx = (y_Tx_mm *1e-3).' + yAxisM(nM);
    
    phaseFactor_Tx = exp(1i*kZ_Tx .* sqrt((yRangeT - y_Tx).^2 + z^2));
    phaseFactor_Tx(:,:,kX_Tx.^2 > k.^2) = 0;
    sarImage_y_kX = sarImage_Temp_y_kX .* phaseFactor_Tx;
    
    clear sarImage_Temp_y_kX phaseFactor_Tx
    
    % Sum accross the transmitters
    sarImage_y_kX = squeeze(sum(sarImage_y_kX,2));
    
    
    %% Final Image
    sarImage(:,:,nM) = sum(ifftshift(ifft(ifftshift(sarImage_y_kX,2),[],2),2),3);
    
end

%% Sum the image from all the measurements
sarImage = squeeze(sum(sarImage,3));


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
    figure('OuterPosition',[627,166,738,712]);
    mesh(xRangeT_mm,yRangeT_mm,mag2db(abs(fliplr(squeeze(sarImage)))/max(max(abs(squeeze(sarImage))))),'FaceColor','interp','LineStyle','none')
    view(2)
    colormap('gray');
    colorbar
    
    xlabel('Horizontal (mm)')
    ylabel('Vertical (mm)')
    titleFigure = "SAR 2D Image (dB) - " + z*1e3 + "mm Focused" ;
    title(titleFigure)
    
    figure('OuterPosition',[695 166 670 712]);
    mesh(xRangeT_mm,yRangeT_mm,(abs(fliplr(squeeze(sarImage)))/max(max(abs(squeeze(sarImage))))),'FaceColor','interp','LineStyle','none')
    view(2)
    colormap('gray');
    
    xlabel('Horizontal (mm)')
    ylabel('Vertical (mm)')
    titleFigure = "SAR 2D Image - " + z*1e3 + "mm Focused" ;
    title(titleFigure)
end


%% Write the output variable (“sarImage”) in a binary file in floating point format
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