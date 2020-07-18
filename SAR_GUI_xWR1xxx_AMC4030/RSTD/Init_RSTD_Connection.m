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


function ErrStatus = Init_RSTD_Connection(RSTD_DLL_Path)
%This script establishes the connection with Radarstudio software
%   Pre-requisites:
%   Type RSTD.NetStart() in Radarstudio Luashell before running the script. This would open port 2777
%   Returns 30000 if no error.

if (strcmp(which('RtttNetClientAPI.RtttNetClient.IsConnected'),'')) %First time the code is run after opening MATLAB
    disp('Adding RSTD Assembly');
    RSTD_Assembly = NET.addAssembly(RSTD_DLL_Path);
    if ~strcmp(RSTD_Assembly.Classes{1},'RtttNetClientAPI.RtttClient')
        disp('RSTD Assembly not loaded correctly. Check DLL path');
        ErrStatus = -10;
        return
    end
    Init_RSTD_Connection = 1;
elseif ~RtttNetClientAPI.RtttNetClient.IsConnected() %Not the first time but port is diconnected
    % Reason:
    % Init will reset the value of Isconnected. Hence Isconnected should be checked before Init
    % However, Isconnected returns null for the 1st time after opening MATLAB (since init was never called before)
    Init_RSTD_Connection = 1;
else
    Init_RSTD_Connection = 0;
end
if Init_RSTD_Connection
    disp('Initializing RSTD client');
    ErrStatus = RtttNetClientAPI.RtttNetClient.Init();
    if (ErrStatus ~= 0)
        disp('Unable to initialize NetClient DLL');
        return;
    end
    disp('Connecting to RSTD client');
    ErrStatus = RtttNetClientAPI.RtttNetClient.Connect('127.0.0.1',2777);
    if (ErrStatus ~= 0)
        disp('Unable to connect to Radarstudio');
        disp('Reopen port in Radarstudio. Type RSTD.NetClose() followed by RSTD.NetStart()')
        return;
    end
    pause(1);%Wait for 1sec. NOT a MUST have.
end
disp('Sending test message to RSTD');
Lua_String = 'WriteToLog("Running script from MATLAB\n", "green")';
ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
if (ErrStatus ~= 30000)
    disp('Radarstudio Connection Failed');
end
disp('Test message success');
end

