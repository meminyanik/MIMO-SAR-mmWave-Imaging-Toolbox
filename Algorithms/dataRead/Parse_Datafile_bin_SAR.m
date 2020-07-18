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

function [ErrStatus,radar_data] = Parse_Datafile_bin_SAR(adc_file_name,Num_channels,Samples_per_Chirp,Chirps_per_Frame,Num_frames,Num_measurements)
Expected_Num_Samples = Num_channels * Samples_per_Chirp * Chirps_per_Frame * Num_frames * Num_measurements;

fileID = fopen(adc_file_name,'r');
if fileID < 0
    if isdeployed()
        exit(-1);
    else
        ErrStatus = -1;
        return
    end
end
radar_data = fread(fileID,'uint16');
radar_data = radar_data - 2^15;
fclose(fileID);

if numel(radar_data) ~= Expected_Num_Samples
    disp('Number of samples in data file not matchig expected');
    ErrStatus = -2;
    return;
end

ErrStatus = 0; %No Err
end