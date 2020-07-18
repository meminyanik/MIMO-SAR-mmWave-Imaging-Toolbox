%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function sarData = simulateSARdata(xPointM,xStepM,yPointM,yStepM,tMatrix,xyStepT,zTarget,xOffsetT,yOffsetT,radarType,isMonostatic,activeTx,activeRx,chirpParameters)
% sarData format
% -------------------------------------------------------------------------
% nChannel x yPointM x xPointM x adcSample
%
% Note:
% nChannel is arranged as (nRx*nTx)
% reshape(sarData,nRx,nTx,...) should be used if needed

% Example function calls
% -------------------------------------------------------------------------
% lambda/4 = 0.9487
% fC = 79e9; c = physconst('lightspeed'); lambda = c/fC;

% Simulated single tone (77GHz)signal for any antenna pair without monostatic assumption
% sarData = simulateSARdata(100,2,100,2,ones(1),0,400,0,0,'IWR1443',0,[1 0 0],[1 1 1 1]);
% sarData = simulateSARdata(408,400/407,54,7.59,'Target.png',0.5,300,0,0,'IWR1443',0,[1 0 1],[1 1 1 1]);
% sarData = simulateSARdata(200,0.9487,25,0.9487*8,'Target.png',0.5,300,0,0,'IWR1443',0,[1 1 1],[1 1 1 1],77e9);
% sarData = simulateSARdata(88,0.9487,1,0,'Target.png',0.5,300,0,0,'4ChipCascade',0,ones(1,9),ones(1,16));
%
% Simulate FMCW
% sarData = simulateSARdata(200,0.9487,25,0.9487*8,'Target.png',0.5,300,0,0,'IWR1443',0,[1 0 0],[1 0 0 0],[77e9,70.295e12,5000e3,4.66e-6,256]);
% sarData = simulateSARdata(1,0,1,0,ones(1),0,356,0,0,'IWR1443',0,[1 0 0],[1 0 0 0],[77e9,63.343e12,9121e3/8,6e-6,64]);
% sarData = simulateSARdata(1,0,1,0,ones(1),0,356,0,0,'IWR1443',0,[1 0 0],[1 0 0 0],[77e9,150e12,3200e3,5.25e-6,64]);
% [77e9,150e12,3000e3,4e-6,64] = [fStart(Hz),fSlope(Hz/s),fSample(sps),adcStart(s),adcSample]

% Coordinate system
% -------------------------------------------------------------------------
% x is the Horizontal axis
% y is the Vertical axis
% z is the Depth axis

% Variables
% -------------------------------------------------------------------------
% This code simulates rawData for the following scenario:
% xPointM: number of measurement points at x (horizontal) axis
% xStepM: measurement step size at x (horizontal) axis in mm
% yPointM: number of measurement points at y (vertical) axis
% yStepM: measurement step size at y (vertical) axis in mm
%
% tMatrix: target image
% xyStepT: target step size at x-y axis in mm
% zTarget: z distance of target in mm

% Optional variables
% -------------------------------------------------------------------------
% xOffsetT: target x-offset from boresight in mm. Default: 0
% yOffsetT: target y-offset from boresight in mm. Default: 0
%
% radarType: 'IWR1443', '4ChipCascade', 'Simulation'. Default: 'IWR1443'
%
% isMonostatic: if 1, monostatic confguration is assumed. Default: 1
%
% activeTx: active Tx antennas. Default: [1 0 0]
% [Tx0 Tx1 Tx2]
%
% activeRx: active Rx antennas. Default: [1 0 0 0]
% [Rx0 Rx1 Rx2 Rx3]
%
% isFMCW: if 1, wideband FMCW data is simulated. Default: 0

%% Code Starts
% profile on

if (nargin < 14)
    isFMCW = false;
    f0 = 77e9; % default start frequency
end
if (nargin < 13)
    activeRx = [1 0 0 0];
end
if (nargin < 12)
    activeTx = [1 0 0];
end
if (nargin < 11)
    isMonostatic = 1;
end
if (nargin < 10)
    radarType = 'IWR1443';
end
if (nargin < 9)
    yOffsetT = 0;
end
if (nargin < 8)
    xOffsetT = 0;
end

%-------------------------------------------------------------------------%
% Define multistatic to monostatic phase correction and amplitude factor
% Only works for single frequency (non-FMCW) scenario
%-------------------------------------------------------------------------%
isAmplitudefactor = false;

%-------------------------------------------------------------------------%
% Target Image Read
%-------------------------------------------------------------------------%
if tMatrix ~= 1
    % tMatrix = imread('Target.png');
    tMatrix = imread(tMatrix);
    tMatrix = tMatrix(:,:,1);
    tMatrix(tMatrix>0) = 1;
    tMatrix = ~tMatrix;
    tMatrix = fliplr(tMatrix);
end
    
%-------------------------------------------------------------------------%
% Define Parameters
%-------------------------------------------------------------------------%
c = physconst('lightspeed');

if (nargin == 14)
    if length(chirpParameters)==1
        isFMCW = false;
        f0 = chirpParameters;
    elseif (length(chirpParameters)>1) && (length(chirpParameters)<=5)
        isFMCW = true;
        chirpParameters = num2cell(chirpParameters);
        [f0,K,fS,adcStart,adcSample] = chirpParameters{:};
        f0 = f0 + adcStart*K; % This is for ADC sampling offset
        t = (0:adcSample-1)/fS;
        
        f = f0 + (0:adcSample-1)*K/fS; % wideband frequency
        k = 2*pi*f/c;
    else
       error("Error in the chirp data") 
    end
end

%-------------------------------------------------------------------------%
% Antenna Locations % Matlab Coordinate System
%-------------------------------------------------------------------------%
[rxAntPos,txAntPos,virtualChPos,~] = getAntennaLocations(radarType);
%- Calculate number of channels -%
nTx = sum(activeTx);
nRx = sum(activeRx);
nChannel = nTx*nRx;
%- Crop antenna positions -%
%- Set the array center (Array virtual center will be at (0,0,0)) -%
[rxAntPos,txAntPos,virtualChPos] = cropAntennaLocationsSetArrayCenter(rxAntPos,txAntPos,virtualChPos,activeTx,activeRx);
    

%-------------------------------------------------------------------------%
% Define Measurement Locations at Linear Rail
% Coordinates: [x y z], x-Horizontal, y-Vertical, z-Depth
%-------------------------------------------------------------------------%
xAxisM = xStepM * (-(xPointM-1)/2 : (xPointM-1)/2) * 1e-3; % xStepM is in mm
yAxisM = yStepM * (-(yPointM-1)/2 : (yPointM-1)/2) * 1e-3; % yStepM is in mm
zAxisM = 0;

[zM,xM,yM] = meshgrid(zAxisM,xAxisM,yAxisM);
xyzM = [xM,yM,zM]; % xPoint x 3 (x-y-z) x yPoint;
xyzM = reshape(permute(xyzM,[1 3 2]),[],3);
[nMeasurement,~] = size(xyzM);
% Show measurement points
% plot(xyzM(:,1),xyzM(:,2))
        
%-------------------------------------------------------------------------%
% Define Target Locations
% Coordinates: [x y z], x-Horizontal, y-Vertical, z-Depth
%-------------------------------------------------------------------------%
[yPointT,xPointT] = size(tMatrix);
xAxisT = xyStepT * (-(xPointT-1)/2 : (xPointT-1)/2) * 1e-3; % xyStepT is in mm
yAxisT = xyStepT * (-(yPointT-1)/2 : (yPointT-1)/2) * 1e-3; % xyStepT is in mm

xAxisT = xAxisT + xOffsetT*1e-3; % xOffsetT is in mm
yAxisT = yAxisT + yOffsetT*1e-3; % yOffsetT is in mm
zAxisT = zTarget * 1e-3; % zTarget is in mm

[zT,xT,yT] = meshgrid(zAxisT,xAxisT,yAxisT);
xyzT = [xT,yT,zT]; % xPoint x 3 (x-y-z) x yPoint;
xyzT = reshape(permute(xyzT,[1 3 2]),[],3);

indT = rot90(tMatrix,-1)==true;
xyzT = xyzT(indT,:);

[nTarget,~] = size(xyzT);
% Show target points
% plot(xyzT(:,1),xyzT(:,2))

%-------------------------------------------------------------------------%
% Calculate Delay Parameter for Each Channel
%-------------------------------------------------------------------------%
if isMonostatic
    %- Calculate monostatic transceiver measurement positions -%
    virtualChPos = reshape(virtualChPos,nChannel,1,3);
    xyzM = reshape(xyzM,1,nMeasurement,3);
    xyzM = repmat(xyzM,nChannel,1,1);
    
    xyzM_TRx = xyzM + virtualChPos;
    xyzM_TRx = reshape(xyzM_TRx,[],3);
    % Show measurement points
    figure('OuterPosition',[695 166 670 712]);
    plot(xyzM_TRx(:,1),xyzM_TRx(:,2),'.')
    xlabel('x-axis (meters)')
    ylabel('y-axis (meters)')
    title('Measurement Locations')
    
    %- Calculate distance matrix -%
    R_TRx_T = 2*pdist2(xyzM_TRx,xyzT);
else
    %- Calculate transmit and receive antenna positions -%
    txAntPos = repmat(txAntPos,nRx,1);
    txAntPos = reshape(txAntPos,nTx,[],3);
    txAntPos = permute(txAntPos,[2,1,3]);
    txAntPos = reshape(txAntPos,[],3);
    rxAntPos = repmat(rxAntPos,nTx,1);

    txAntPos = reshape(txAntPos,nChannel,1,3);
    rxAntPos = reshape(rxAntPos,nChannel,1,3);
    
    %- Calculate transmit and receive measurement positions -%
    xyzM = reshape(xyzM,1,nMeasurement,3);
    xyzM = repmat(xyzM,nChannel,1,1);
    
    xyzM_Tx = single(xyzM + txAntPos);
    xyzM_Rx = single(xyzM + rxAntPos);
    xyzM_Tx = reshape(xyzM_Tx,[],3);
    xyzM_Rx = reshape(xyzM_Rx,[],3);
    
    %- Calculate distance matrix -%
    xyzT = single(xyzT);
    R_Tx_T = pdist2(xyzM_Tx,xyzT);
    R_Rx_T = pdist2(xyzM_Rx,xyzT);
    clear xyzM_Tx xyzM_Rx 
    
    R_TRx_T = R_Tx_T + R_Rx_T;
    
    if (~isAmplitudefactor)
        clear R_Tx_T R_Rx_T
    end
    
end
%-------------------------------------------------------------------------%


%--------------------------------------------------------------------------
% Create FMCW SAR Data
%--------------------------------------------------------------------------
if isFMCW
    if nTarget > 1
        % tau = distanceMatrix/c;
        sarData = zeros(nChannel*nMeasurement,adcSample);
        processBar = waitbar(0,'Processing...');
        for nk = 1:length(k)
            % phaseData = 2*pi*(f0*tau - K/2*tau.^2 + K*tau*t(n));
            phaseData = k(nk)*R_TRx_T; % This line ignores residual phase factor
            sarDataT = exp(1i*phaseData);
            sarData(:,nk) = sum(sarDataT,2);
            waitbar(nk/length(k));
        end
        delete(processBar)
    else 
        tau = R_TRx_T/c;
        phaseData = 2*pi*(f0*tau - K/2*tau.^2 + K*tau*t);
        % phaseData = 2*pi*(f0*tau + K*tau*t);
        sarData = exp(1i*phaseData);
    end
    
    sarData = reshape(sarData,nChannel,xPointM,yPointM,adcSample);
    
    % Dimension should be nChannel - yAxis - xAxis - nSample
    sarData = permute(sarData,[1,3,2,4]);
    
%     if (xPointM>1) && (yPointM>1)
%         if nChannel == 1
%             sarData = permute(sarData,[2 1 3]);
%         else
%             sarData = permute(sarData,[1,3,2,4]);
%         end
%     end
%     sarData = squeeze(sarData);

%--------------------------------------------------------------------------
% Create Single Tone SAR Data
%--------------------------------------------------------------------------
else
    phaseData = 2*pi*f0*R_TRx_T/c;
    clear R_Tx_Rx;
    sarData = exp(1i*phaseData);
    clear phaseData;
    if isAmplitudefactor
        amplitudeFactor = 1./(R_Tx_T.*R_Rx_T);
        sarData = amplitudeFactor.* sarData;
    end
    if nTarget > 1
        sarData = sum(sarData,2);
    end
    
    sarData = squeeze(reshape(sarData,nChannel,xPointM,yPointM));
    
    % Dimension should be nChannel - yAxis - xAxis
    if nChannel == 1
        sarData = sarData.';
    else
        sarData = permute(sarData,[1 3 2]);
    end
    
% profile viewer

end