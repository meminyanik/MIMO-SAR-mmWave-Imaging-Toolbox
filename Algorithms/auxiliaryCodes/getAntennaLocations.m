%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function [rxAntPos,txAntPos,virtualChPos,distAntennas] = getAntennaLocations(radarType,isFigure)
% Radar Types:
% 'IWR1443'
% '2ChipCascade'
% 'Simulation'

% Note:
% virtualChPos and distAntennas are arranged as (nRx*nTx)
% reshape(virtualChPos,nRx,nTx) and reshape(distAntennas,nRx,nTx)
% should be used if needed

if (nargin < 2)
    isFigure = 0; % Plot the antenna locations
end
if (nargin < 1)
    radarType = 'IWR1443'; % Default is IWR1443
end

%% Speed of light
%-------------------------------------------------------------------------%
c = physconst('lightspeed');

switch radarType
    case 'IWR1443' % It is AWR1443
        fC = 79e9; % center frequency
        lambda = c/fC;
        
        dTxRx = 5e-3;
        % Rx Antenna 1 is the reference
        % Coordinates: [x y z], x-Horizontal, y-Vertical, z-Depth
        rxAntPos = [0 0             0;...
                    0 lambda/2      0;...
                    0 lambda        0;...
                    0 3*lambda/2    0];
        
        txAntPos = [0           3*lambda/2+dTxRx            0;...
                    -lambda/2   3*lambda/2+dTxRx+lambda     0;...
                    0           3*lambda/2+dTxRx+2*lambda   0];
    
        
    case '2ChipCascade'
        fC = 77e9; % center frequency
        lambda = c/fC;
        
        %% Version 1 - Cascaded 5Tx and 8Rx
        %     yAxis = (0:34).'*lambda/2;
        %     rxAntPos = [zeros(8,1) yAxis([1:4,12:15]) zeros(8,1)];
        %     txAntPos = [zeros(5,1) yAxis([6,10,27,31,35]) zeros(5,1)];
        
        %% Version 2 - Uniform Cascaded 6Tx and 8Rx
        yAxisRx = (0:27).'*lambda/2;
        rxAntPos = [zeros(8,1), yAxisRx([1:4,25:28]), zeros(8,1)];
        yAxisTx = (0:5).'*2*lambda;
        txAntPos = [lambda/2*ones(6,1), 7*lambda/4+yAxisTx, zeros(6,1)];
        % txAntPos = [zeros(6,1), 7*lambda/4+yAxisTx, zeros(6,1)];
        
    case 'Simulation'
        % inch2mm = 25.4;
        % lambda = inch2mm * 153.56e-3 * 1e-3;
        fC = 77e9; % center frequency
        lambda = c/fC;
        
        %% version 1 - Uniform Cascaded 12Tx and 16Rx
        yAxisRxBlock = (0:7).'*lambda/2;
        rxAntPos = [zeros(16,1), [yAxisRxBlock ; yAxisRxBlock+48*lambda], zeros(16,1)];
        yAxisTx = (0:11).'*4*lambda;
        
        dTx_X = 0; % 50e-3;
        dTx_Y = 0; % 15/4*lambda;
        txAntPos = [dTx_X+zeros(12,1), dTx_Y+yAxisTx, zeros(12,1)];
        
        %% Version 2 - Random 3Tx and 3Rx
        %         dTxRx = 5e-3;
        %         % Rx Antenna 1 is the reference
        %         % Coordinates: [x y z], x-Horizontal, y-Vertical, z-Depth
        %         rxAntPos = [0.3*lambda           0    0;...
        %                     -0.3*lambda 1.1*lambda    0;...
        %                     0.8*lambda  3*lambda/2    0];
        %
        %         txAntPos = [-0.7*lambda      3*lambda/2+dTxRx             0;...
        %                     1.4*lambda     3*lambda/2+dTxRx+1.3*lambda  0;...
        %                     0.3*lambda      3*lambda/2+dTxRx+2*lambda    0];
        
        %% Version 3 - Uniform Arrays
        %         rxAntYPos = (0:83).'*lambda/2;
        %         rxAntPos = [zeros(84,1), rxAntYPos , zeros(84,1)];
        %         
        %         %%%% Test for TDM-MIMO Effect
        %         % speed_mps = 400e-3;
        %         % interChirpTime_s = 70e-6;
        %         % offset_m = speed_mps * interChirpTime_s;
        %         % rxAntPos = [(0:85).'*offset_m, rxAntYPos , zeros(86,1)];
        %         
        %         %%%% Tx array offset
        %         dTx_Y = 0; % 171*lambda/4; % 0.04;
        %         dTx_X = 0; % 0.07;
        %         
        %         %%%% Multiple TX option
        %         txAntYPos = (0:5).'*8*lambda + dTx_Y;
        %         txAntPos = [dTx_X + zeros(6,1), txAntYPos , zeros(6,1)];
        %         
        %         %%%% Single TX option
        %         % txAntPos = [dTx_X,dTx_Y,0];
        %         
        %         %%%% Test for overlaps
        %         % txAntPos = [(0:8).'*lambda/2, txAntYPos , zeros(9,1)];
        
        %% Version 4 - Rectangular 12Tx and 16 Rx
        %         rxAntXPos = (-3:2:3)*lambda/4;
        %         rxAntYPos = (-3:2:3)*lambda/4;
        %         [rxAntXPos,rxAntYPos] = meshgrid(rxAntXPos,rxAntYPos);
        %         rxAntZPos = zeros(4,4);
        %         rxAntPos = [rxAntXPos(:),rxAntYPos(:),rxAntZPos(:)];
        %         
        %         txAntXPos = (-3:2:3)*lambda;
        %         txAntYPos = (-1:1)*2*lambda;
        %         [txAntXPos,txAntYPos] = meshgrid(txAntXPos,txAntYPos);
        %         txAntZPos = zeros(3,4);
        %         txAntPos = [txAntXPos(:),txAntYPos(:),txAntZPos(:)];
    
    otherwise
        error('Please enter a correct radar type.')
end


[nRx,~] = size(rxAntPos);
[nTx,~] = size(txAntPos);

txT = reshape(txAntPos,nTx,1,[]);
rxT = reshape(rxAntPos,1,nRx,[]);
virtualChPos = (txT+rxT)/2;
virtualChPos = reshape(permute(virtualChPos,[2,1,3]),[],3);

distAntennas = txT-rxT;
distAntennas = reshape(permute(distAntennas,[2,1,3]),[],3);

%% Plot antenna locations
if isFigure
    figure('OuterPosition',[695 166 670 712]);
    plot(rxAntPos(:,1),rxAntPos(:,2),'s')
    hold on
    plot(txAntPos(:,1),txAntPos(:,2),'o')
    plot((max(virtualChPos(:,1)) + min(virtualChPos(:,1)))/2,(max(virtualChPos(:,2))+min(virtualChPos(:,2)))/2,'x')
    xlabel('x-axis (meters)')
    ylabel('y-axis (meters)')
    title('MIMO Array')
    
    figure('OuterPosition',[695 166 670 712]);
    plot(virtualChPos(:,1),virtualChPos(:,2),'s')
    hold on
    plot((max(virtualChPos(:,1))+min(virtualChPos(:,1)))/2,(max(virtualChPos(:,2))+min(virtualChPos(:,2)))/2,'x')
    xlabel('x-axis (meters)')
    ylabel('y-axis (meters)')
    title('Virtual Array')
end