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


function ErrStatus = Transfer_Data_to_PC(DataFilePathWithName,HSDCPRO_TimeoutInMs)
%ReadDDR_and_SaveRawData transfers the captured data to PC
%   This function should be called after the frames are transmitted
%   This function returns 0 if no error

Trigger_TimeStamp = datetime('now');

% int32_t __cdecl Read_DDR_Memory ( int32_t WaitToCheckTrigger , int32_t TimeoutInMs );
ErrStatus = calllib('HSDCProAutomation_64Bit','Read_DDR_Memory',0,HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while reading DDR memory line11');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end

%Check if capture is complete
iter = 1;
ErrStatus = -1;
while (ErrStatus ~=0) && (iter <=40)
    % int32_t __cdecl HSDC_Ready ( int32_t TimeoutInMs );
    ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',30000); % Waiting to check if HSDCPro has completed all its operations.
    iter = iter+1;
end
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line25');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end

% DataFilePathWithName = 'C:\Users\Public\Documents\Texas Instruments\High Speed Data Converter Pro\ADC Temp.bin';
HSDCProDataPath = dir(DataFilePathWithName) ;
CaptureTimeStamp = [HSDCProDataPath.date];
if ((CaptureTimeStamp - Trigger_TimeStamp) <= (-1/(3600*24)))
    ErrStatus = -1000;
    disp('HSDCPRO did not receive data from AR line33');
    return;
end
end