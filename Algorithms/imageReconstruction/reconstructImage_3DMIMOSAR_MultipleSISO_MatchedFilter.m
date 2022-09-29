%% Copyright(C) 2018 Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  The University of Texas at Dallas
%  Department of Electrical and Computer Engineering

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function [sarImage,xI,yI] = ...
    reconstructImage_3DMIMOSAR_MultipleSISO_MatchedFilter(sarData,...
                                                        frequency,...
                                                        xStepM,...
                                                        yStepM,...
                                                        txAntPos,...
                                                        rxAntPos,...
                                                        xySizeI,...
                                                        zTarget,...
                                                        nFFTkX)
% For single tone applications: 
% -------------------------------------------------------------------------
% sarData: should be nRx x nTx x yPointM x xPointM x nSample

% If wideband processing is used:
% -------------------------------------------------------------------------
% frequency: [fStart,fSlope,fSample,adcStart]
% fStart: Start frequency
% fSlope: Slope const (Hz/sec)
% fSample: Sample ps
% adcStart: ADC start time
% Example: [77e9,63.343e12,9121e3,4.66e-6]

% For single tone applications:
% -------------------------------------------------------------------------
% frequency: start frequency

% Variables
% -------------------------------------------------------------------------
% xStepM: measurement step size at x (horizontal) axis in mm
% yStepM: measurement step size at y (vertical) axis in mm
%
% txAntPos,rxAntPos: Tx and Rx antenna locations
% % Optional (To get the antenna locations from the radar type)
% % [rxAntPos,txAntPos,virtualChPos,~] = getAntennaLocations(radarType);
% % [rxAntPos,txAntPos,~] = cropAntennaLocationsSetArrayCenter(rxAntPos,txAntPos,virtualChPos,activeTx,activeRx);
%
% xySizeI: size of image in xy-axis in mm
% zTarget: target distance in mm
% nFFTkXY: number of FFT points, should be greater than xStepM and yStepM


%% Zero Padding to sarData to Locate Target at Center
%-------------------------------------------------------------------------%
sarData = single(conj(sarData)); % Take the conjugate to make consistent with the paper
[nRx,nTx,~,xPointM,nSample] = size(sarData);
if (nFFTkX<xPointM)
    error('# of FFT points must be greater than the # of measurement points.')
else
    sarData = padarray(sarData,[0 0 0 floor((nFFTkX-xPointM)/2) 0],0,'pre');
    sarData = padarray(sarData,[0 0 0 ceil((nFFTkX-xPointM)/2) 0],0,'post');
end


%% Define Frequency Spectrum
%-------------------------------------------------------------------------%
if (length(frequency)==4) && (nSample>1)
    frequency = num2cell(frequency);
    [f0,K,fS,adcStart] = frequency{:};
    f0 = f0 + adcStart*K; % This is for ADC sampling offset
    f = f0 + (0:nSample-1)*K/fS; % wideband frequency
elseif (length(frequency)==1) && (nSample==1)
    f = frequency; % single frequency
else
    error('Please correct the configuration and data for 3D processing')
end


%% Define Fixed Parameters
%-------------------------------------------------------------------------%
c = 299792458; % physconst('lightspeed'); in m/s
lambda = c./f;
k = 2*pi./lambda;


%% Define Measurement Locations at Linear Rail
% Coordinates: [x y z], x-Horizontal, y-Vertical, z-Depth
%-------------------------------------------------------------------------%
[~,~,yPointM,xPointM,~] = size(sarData);
x = xStepM * (-(xPointM-1)/2 : (xPointM-1)/2) * 1e-3; % xStepM is in mm
yAxisM = (yStepM * (-(yPointM-1)/2 : (yPointM-1)/2) * 1e-3).'; % yStepM is in mm


%% Check if transmit and receive arrays are 1-D in y-axis
%-------------------------------------------------------------------------%
% if ~isempty(find(rxAntPos(:,1)~=rxAntPos(1,1), 1))
%     error("Receive array must be 1-D in y-axis")
% end
% if ~isempty(find(txAntPos(:,1)~=txAntPos(1,1), 1))
%     error("Receive array must be 1-D in y-axis")
% end
%- Tx antenna offset in x-axis -%
dTx_X = txAntPos(:,1);
dRx_X = rxAntPos(:,1);


%% Define Target Locations
% Coordinates: [x y z], x-Horizontal, y-Vertical, z-Depth
%-------------------------------------------------------------------------%
y = x.'; % Define a square target area
z0 = zTarget * 1e-3; % zTarget is in mm


%% Define g-function
%-------------------------------------------------------------------------%
matchedFilter_k = single(zeros(nRx,nTx,yPointM,length(y),length(x)));
sarImage = single(zeros(length(y),length(x),length(k)));

processBar = waitbar(0,'Processing...');
for nK = 1:length(k)
    
    % Get sarData for each k
    sarData_k = sarData(:,:,:,:,nK);
    
    % Calculate matchedFilter for each k
    for nM = 1:yPointM
        yTx = txAntPos(:,2) + yAxisM(nM);
        yRx = rxAntPos(:,2) + yAxisM(nM);
        for nT = 1:nTx
            for nR = 1:nRx
                matchedFilter_k(nR,nT,nM,:,:) = exp(1i*k(nK)*sqrt((x-dRx_X(nR)).^2 + (y-yRx(nR)).^2 + z0^2)) .* ...
                    exp(1i*k(nK)*sqrt((x-dTx_X(nT)).^2 + (y-yTx(nT)).^2 + z0^2));
            end
        end
    end
    
    %% Convert Matched Filter Format as
    % nRx * nTx * yPointM * length(x) * length(y)
    matchedFilter_k = permute(matchedFilter_k,[1,2,3,5,4]);
    
    %% Take FFT in x-Axis
    %-------------------------------------------------------------------------%
    sarDataFFT_kX = fftshift(fft(fftshift(sarData_k,4),nFFTkX,4),4);
    matchedFilterFFT_kX = fftshift(fft(fftshift(matchedFilter_k,4),nFFTkX,4),4);
    sarImageFFT_kX = sarDataFFT_kX .* matchedFilterFFT_kX;
    sarImageFFT_kX = squeeze(sum(sum(sum(sarImageFFT_kX,1),2),3));
    sarImageFFT_kX = sarImageFFT_kX.';
    
    %% Take IFFT to switch back to image domain
    %-------------------------------------------------------------------------%
    % sarImage = ifft(sarImageFFT_kX,nFFTkX,2);
    sarImage(:,:,nK) = ifftshift(ifft(ifftshift(sarImageFFT_kX,2).').',2);
    
    waitbar(nK/length(k));
end
delete(processBar)

%% Coherently combine sarImage accross k
sarImage = sum(sarImage,3);


%% Define Image Axis
%-------------------------------------------------------------------------%
[~,xPointM] = size(sarImage);
xI = xStepM * (-(xPointM-1)/2 : (xPointM-1)/2); % xStepM is in mm
yI = y * 1e3;


%% Crop the Image for Related Region
%-------------------------------------------------------------------------%
if (xySizeI ~= -1)
    indX = xI>(-xySizeI/2) & xI<(xySizeI/2);
    indY = yI>(-xySizeI/2) & yI<(xySizeI/2);
    xI = xI(indX);
    yI = yI(indY);
    sarImage = sarImage(indY,indX);
end


%% Plot SAR Image
%-------------------------------------------------------------------------%
figure('OuterPosition',[695 166 670 712]);
mesh(xI,yI,abs(fliplr(sarImage)),'FaceColor','interp','LineStyle','none')
view(2)
colormap('gray');

xlabel('Horizontal (mm)')
ylabel('Vertical (mm)')
titleFigure = "SAR 2D Image - " + zTarget + "mm Focused" ;
title(titleFigure)

% Or Log Image
sarImageAbsLog = mag2db(abs(sarImage)); % 20*log10
sarImageAbsLog = sarImageAbsLog - max(max(sarImageAbsLog));

figure('OuterPosition',[695 166 670 712]);
mesh(xI,yI,fliplr(sarImageAbsLog),'FaceColor','interp','LineStyle','none')
view(2)
colormap('gray');

xlabel('Horizontal (mm)')
ylabel('Vertical (mm)')
titleFigure = "SAR 2D Log Image - " + zTarget + "mm Focused" ;
title(titleFigure)