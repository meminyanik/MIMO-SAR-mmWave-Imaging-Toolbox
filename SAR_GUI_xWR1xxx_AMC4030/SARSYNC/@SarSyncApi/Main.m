% Copyright(C) 2018 The University of Texas at Dallas
% Developed By: Muhammet Emin Yanik
% Advisor: Prof. Murat Torlak
% Department of Electrical and Computer Engineering
% 
% This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
% through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).
% 
% Redistributions and use of source must retain the above copyright notice
% Redistributions in binary form must reproduce the above copyright notice
% 
% 
% Module Name:
% Main.m
% 
% Abstract:
% The main script to use the SarSyncApi class to communicate with the hardware



%% Create the API object
SarSyncApi = SarSyncApi("COM13");

%% Call the Radar Trigger Command
SarSyncApi.radarTrigger()

%% Call the Set Pulse Count Command
SarSyncApi.setPulseCount(1200)

%% Read the input data
readline(SarSyncApi.serialPort)