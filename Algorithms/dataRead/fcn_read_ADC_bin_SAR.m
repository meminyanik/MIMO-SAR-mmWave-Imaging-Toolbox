%  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/ 
%  
%  
%   Redistribution and use in source and binary forms, with or without 
%   modification, are permitted provided that the following conditions 
%   are met:
%  
%     Redistributions of source code must retain the above copyright 
%     notice, this list of conditions and the following disclaimer.
%  
%     Redistributions in binary form must reproduce the above copyright
%     notice, this list of conditions and the following disclaimer in the 
%     documentation and/or other materials provided with the   
%     distribution.
%  
%     Neither the name of Texas Instruments Incorporated nor the names of
%     its contributors may be used to endorse or promote products derived
%     from this software without specific prior written permission.
%  
%   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
%   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
%   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
%   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
%   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
%   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
%   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
%   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
%   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
%   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
%   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%  
% 

% AngleArr is phases for current Tx across Rx at the bin specified in radar_fft.m. Similarly ValueArr is the complex value.
% RangeArr is the actual bin number where the highest peak is after near DC
% FFT phase is the phase variation near specified bin in radar_fft.m. bin_axis is corresponding bins.
% RMS Noise gives noise power

% plot_switch is 1 for plotting the range fft and 0 for not plotting range fft

function [rawData_Rxchain]= fcn_read_ADC_bin_SAR(sensorParams,sarParams,adcBinData_folderName)

Num_RX_channels = 4; % Fixed for this version

Samples_per_Chirp = sensorParams.Samples_per_Chirp;
Chirps_per_Frame = sensorParams.Chirps_per_Frame;
Num_TX = sensorParams.Num_TX;
Num_Frames = sensorParams.Num_Frames;
Num_measurements = sarParams.Num_horizontalScan * sarParams.Num_verticalScan;

adc_file_name = [adcBinData_folderName '\ADC Temp.bin'];
[ErrStatus,rawData] = Parse_Datafile_bin_SAR(adc_file_name,2*Num_RX_channels,Samples_per_Chirp,Chirps_per_Frame*Num_TX,Num_Frames,Num_measurements);
if ErrStatus~=0
    disp('Error in parsing data file for Rxchain');
    return
end

rawData = reshape(rawData,2*Num_RX_channels,[]);
rawData_Rxchain = rawData([1,3,5,7],:) + 1i*rawData([2,4,6,8],:);

% reshape the rawData_Rxchain
rawData_Rxchain = reshape(rawData_Rxchain,Num_RX_channels,Samples_per_Chirp,Num_TX,Chirps_per_Frame,Num_Frames,Num_measurements);

% reshape the rawData_Rxchain as Num_RX_channels x Num_TX x Samples_per_Chirp x Chirps_per_Frame x Num_Frames x Num_measurements
rawData_Rxchain = permute(rawData_Rxchain,[1,3,2,4,5,6]);
