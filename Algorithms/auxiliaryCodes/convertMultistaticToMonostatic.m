%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function [sarDataMonostatic_Ver1,sarDataMonostatic_Ver2] = convertMultistaticToMonostatic(sarDataMultistatic,chirpParameters,xStepM,yStepM,zTarget,radarType,activeTx,activeRx)
% For wideband processing:
% -------------------------------------------------------------------------
% sarDataMulti: should be nChannel x yPointM x xPointM x nSample

% Example function calls, see details below
% -------------------------------------------------------------------------
% lambda/4 = 0.9487, f0 = 77e9+6e-6*63.343e12;
% [77e9,150e12,3000e3,4e-6] = [fStart(Hz),fSlope(Hz/s),fSample(sps),adcStart(s)]
% [sarDataMono1,sarDataMono2] = convertMultistaticToMonostatic(sarDataMulti,[77e9,70.295e12,5000e3,4.66e-6],400/407,7.59/8,300,'IWR1443',[1 1 1],[1 1 1 1])

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
% zTarget: target distance in mm

% radarType: 'IWR1443', '4ChipCascade', 'Simulation'
% activeTx: active Tx antennas
% activeRx: active Rx antennas


%% Code Starts
% profile on


%% Define Frequency Spectrum
%-------------------------------------------------------------------------%
[nChannel,yPointM,xPointM,nSample] = size(sarDataMultistatic);
if (length(chirpParameters)>1) && (length(chirpParameters)<=4) && (nSample>1)
    chirpParameters = num2cell(chirpParameters);
    [f0,K,fS,adcStart] = chirpParameters{:};
    f0 = f0 + adcStart*K; % This is for ADC sampling offset
    f = f0 + (0:nSample-1)*K/fS; % wideband frequency
elseif (length(chirpParameters)==1) && (nSample==1)
    f = chirpParameters;
else
    error('Please correct the frequency configuration and data')
end


%% Define Fixed Parameters
%-------------------------------------------------------------------------%
c = 299792458; % physconst('lightspeed'); in m/s
k = 2*pi*f/c;
k = reshape(k,1,1,1,[]);


%% Check data size and active channels
nTx = sum(activeTx);
nRx = sum(activeRx);
if nChannel ~= (nTx*nRx)
    error('Please correct the active channel data');
end
    

%% Antenna Locations and distances
%-------------------------------------------------------------------------%
[rxAntPos,txAntPos,virtualChPos,d_r] = getAntennaLocations(radarType);  % in meters
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
xyzT = [0 0 zTarget] * 1e-3;


%% Multistatic to Monostatic Phase Correction - Version  1
%-------------------------------------------------------------------------%
% Get the active channels
d_r = reshape(d_r,length(activeRx),length(activeTx),[]);
d_r = d_r(activeRx==1,activeTx==1,:);
d_r = reshape(d_r,[],3);

% Get only x-y coordinates
dx_r = d_r(:,1); % in meters
dy_r = d_r(:,2); % in meters

phaseCorrection = exp(-1i*k.*(dx_r.^2+dy_r.^2)/(4*zTarget*1e-3));
sarDataMonostatic_Ver1 = sarDataMultistatic .* phaseCorrection;


%% Multistatic to Monostatic Phase Correction - Version  2
%-------------------------------------------------------------------------%
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

xyzM_Tx = xyzM + txAntPos;
xyzM_Rx = xyzM + rxAntPos;
xyzM_Tx = reshape(xyzM_Tx,[],3);
xyzM_Rx = reshape(xyzM_Rx,[],3);

%- Calculate monostatic transceiver measurement positions -%
virtualChPos = reshape(virtualChPos,nChannel,1,3);
xyzM_TRx = xyzM + virtualChPos;
xyzM_TRx = reshape(xyzM_TRx,[],3);

%- Calculate distance matrix for multistatic -%
R_Tx_T = pdist2(xyzM_Tx,xyzT);
R_Rx_T = pdist2(xyzM_Rx,xyzT);

%- Calculate distance matrix for monostatic -%
R_TRx_T = 2*pdist2(xyzM_TRx,xyzT);

%- Signal reference multistatic
k = squeeze(k).';

signalRefMultistatic = exp(1i*(R_Tx_T+R_Rx_T)*k);
signalRefMultistatic = reshape(signalRefMultistatic,nChannel,xPointM,yPointM,nSample);
signalRefMultistatic = permute(signalRefMultistatic,[1,3,2,4]);

%- Signal reference monostatic
signalRefMonostatic = exp(1i*R_TRx_T*k);
signalRefMonostatic = reshape(signalRefMonostatic,nChannel,xPointM,yPointM,nSample);
signalRefMonostatic = permute(signalRefMonostatic,[1,3,2,4]);


sarDataMonostatic_Ver2 = sarDataMultistatic .* signalRefMonostatic ./ signalRefMultistatic;

% profile viewer