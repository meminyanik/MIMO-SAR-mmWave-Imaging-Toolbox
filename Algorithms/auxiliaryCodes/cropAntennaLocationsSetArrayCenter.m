%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function [rxAntPos,txAntPos,virtualChPos] = cropAntennaLocationsSetArrayCenter(rxAntPos,txAntPos,virtualChPos,activeTx,activeRx)

%- Crop virtual antenna positions -%
virtualChPos = reshape(virtualChPos,length(activeRx),length(activeTx),[]);
virtualChPos = virtualChPos(activeRx==1,activeTx==1,:);
virtualChPos = reshape(virtualChPos,[],3);

%- Crop transmit and receive antenna positions -%
txAntPos = txAntPos(find(activeTx).',:);
rxAntPos = rxAntPos(find(activeRx).',:);

%- Set the array center (Array virtual center will be at (0,0,0)) -%
xOffsetArray = (max(virtualChPos(:,1))+min(virtualChPos(:,1)))/2;
yOffsetArray = (max(virtualChPos(:,2))+min(virtualChPos(:,2)))/2;
xyzOffsetArray = [xOffsetArray yOffsetArray 0];
txAntPos = txAntPos - xyzOffsetArray;
rxAntPos = rxAntPos - xyzOffsetArray;
virtualChPos = virtualChPos - xyzOffsetArray;