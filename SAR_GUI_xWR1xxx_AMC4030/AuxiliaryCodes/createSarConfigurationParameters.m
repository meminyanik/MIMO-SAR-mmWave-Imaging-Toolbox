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


function sarParams = createSarConfigurationParameters()


%% configure SAR parameters

sarParams.Num_horizontalScan        =   1;  % Number of horizontal scans
sarParams.Num_verticalScan          =   1;	% Number of vertical scans

sarParams.Horizontal_scanSize_mm    =   0;	% Horizontal scan size in mm
sarParams.Vertical_scanSize_mm      =   0;	% Vertical scan size in mm

sarParams.Horizontal_stepSize_mm    =   0;	% Horizontal step size in mm
sarParams.Vertical_stepSize_mm      =   0;  % Vertical step size in mm

sarParams.Platform_Speed_mmps       =   0; % Platform speed in mm/s

sarParams.Trigger_timeOffset_s      =   0; % Time offset for the Radar trigger in s ((-) if the trigger is ahead of scanning)

sarParams.dataCaptureMode           =   'Continuous';    % Data capture mode: 'Continuous' or 'Discrete' or 'Stationary'

sarParams.scanTrajectoryMode        =   'Rectangular';   % Scan Trajectory mode: 'Rectangular' or 'Raster'
end



