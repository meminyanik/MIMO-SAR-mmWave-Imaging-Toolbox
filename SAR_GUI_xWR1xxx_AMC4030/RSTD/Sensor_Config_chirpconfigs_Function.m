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

function ErrStatus = Sensor_Config_chirpconfigs_Function(params)
%-Sensor Configuration
NumProfiles                 =   params.Num_profiles;
NumChirpCfgs                =   params.Num_chirpConfigs;
%Profile config
Start_Freq_GHz              =	params.Start_Freq_GHz;							% For PG1 silicon, please avoid 76-77GHz band
Slope_MHzperus              =	params.Slope_MHzperus;                          % MHz/us

Idle_Time_us                =	params.Idle_Time_us;                            % us
Tx_Start_Time_us            =   params.Tx_Start_Time_us;                        % us
Adc_Start_Time_us           =	params.Adc_Start_Time_us;                       % us
Ramp_End_Time_us            =	params.Ramp_End_Time_us;                        % us
Sampling_Rate_ksps          =	params.Sampling_Rate_ksps;						% ksps
Samples_per_Chirp           =	params.Samples_per_Chirp;    					% Number of samples per chirp
Rx_Gain_dB                  =	params.Rx_Gain_dB;								% dB

%Chirp config
chirpStartIdx               =	0;
chirpEndIdx                 =	NumChirpCfgs-1;

% Frame config
nchirp_loops                =	params.nchirp_loops;							% Number of chirps per frame
Num_Frames                  =	params.Num_Frames;								% 42 frames gives 4GB
Frame_Repetition_Period_ms	=	params.Frame_Repetition_Period_ms;              % ms

%Misc parameters
if (isfield(params,'TriggerSelect_Arr'))
    TriggerSelect_Arr        =	params.TriggerSelect_Arr;
else
    TriggerSelect_Arr        =	1;                                              %1: Software trigger, 2: Hardware trigger
end

%%%%%%%%%%%%%-Sensor Configuration%%%%%%%%%%%%-
%Profile Configuration
%Syntax:
% Int32 ar1.ProfileConfig(UInt16 profileId, Single startFreqConst, Single idleTimeConst, Single adcStartTimeConst, Single rampEndTime, UInt32 tx1OutPowerBackoffCode, UInt32 tx2OutPowerBackoffCode, UInt32 tx3OutPowerBackoffCode, UInt16 tx1PhaseShifter, UInt16 tx2PhaseShifter, UInt16 tx3PhaseShifter, Single freqSlopeConst, Single txStartTime, UInt16 numAdcSamples, UInt16 digOutSampleRate, Char hpfCornerFreq1, Char hpfCornerFreq2, Char rxGain) - Profile configuration API which defines chirp profile parameters
% _I_ UInt16	profileId	 - Chirp Profile Id [0 to 3]
% _I_ Single	startFreqConst	 - Chirp Start Frequency in GHz
% _I_ Single	idleTimeConst	 - Chirp Idle Time in 탎
% _I_ Single	adcStartTimeConst	 - Chirp ADC Start Time in 탎
% _I_ Single	rampEndTime	 - Chirp Ramp End Time in 탎
% _I_ UInt32	tx1OutPowerBackoffCode	 - TX1 channel Power Backoff in dB
% _I_ UInt32	tx2OutPowerBackoffCode	 - TX2 channel Power Backoff in dB
% _I_ UInt32	tx3OutPowerBackoffCode	 - TX3 channel Power Backoff in dB
% _I_ UInt16	tx1PhaseShifter	 - TX1 channel Phase Shifter Value in deg
% _I_ UInt16	tx2PhaseShifter	 - TX2 channel Phase Shifter in deg
% _I_ UInt16	tx3PhaseShifter	 - TX3 channel Phase Shifter in deg
% _I_ Single	freqSlopeConst	 - Chirp Frequency Slope in MHz/탎
% _I_ Single	txStartTime	 - TX Start Time in 탎
% _I_ UInt16	numAdcSamples	 - RX Number of Adc Samples
% _I_ UInt16	digOutSampleRate	 - RX Sampling Rate in ksps
% _I_ Char	hpfCornerFreq1	 - RX HPF1 corner frequency, 0x00-175 kHz, 0x01-235 kHz, 0x02-350 kHz, 0x03-700 kHz
% _I_ Char	hpfCornerFreq2	 - RX HPF2 corner frequency, 0x00-350 kHz, 0x01-700 kHz, 0x02-1.4 MHz, 0x03-2.8 MHz
% _I_ Char	rxGain	 - RX Gain in dB
for ProfileNum = 0:(NumProfiles-1)

	Lua_String = sprintf('ar1.ProfileConfig(%d, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %d, %d, 0, 0, %d)', ProfileNum, Start_Freq_GHz, Idle_Time_us, Adc_Start_Time_us, Ramp_End_Time_us, 0, 0, 0, 0, 0, 0, Slope_MHzperus, Tx_Start_Time_us, Samples_per_Chirp, Sampling_Rate_ksps, Rx_Gain_dB);%Shankar
    ErrStatus =RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);

	if (ErrStatus ==30000)
		disp('Profile Configuration successful')
	else
		disp('Profile Configuration failed')
		return;
	end

%pause(wait_time);
TxToEnable=params.TxToEnable;
for ChirpCfg =0:(NumChirpCfgs/NumProfiles-1)%Shankar
	ChirpOffset = ProfileNum*NumChirpCfgs/NumProfiles; % Shankar
	TXenableMat = zeros(3,1);
	TXenableMat(TxToEnable(ChirpCfg+1)) = 1;
	Tx1_Enable = TXenableMat(1);
	Tx2_Enable = TXenableMat(2);
	Tx3_Enable = TXenableMat(3);
	%Chirp Configuration
	%Syntax:
	% Int32 ar1.ChirpConfig(UInt16 chirpStartIdx, UInt16 chirpEndIdx, UInt16 profileId, Single startFreqVar, Single freqSlopeVar, Single idleTimeVar, Single adcStartTimeVar, UInt16 tx1Enable, UInt16 tx2Enable, UInt16 tx3Enable) - Chirp configuration API which defines which profile is to be used for each chirp in a frame
	% _I_ UInt16	chirpStartIdx	 - First Chirp Start Index number
	% _I_ UInt16	chirpEndIdx	 - Last chirp Index number
	% _I_ UInt16	profileId	 - Chirp Configured profileId
	% _I_ Single	startFreqVar	 - Chirp start frequency var in MHz
	% _I_ Single	freqSlopeVar	 - frequency Slope Var in MHz/탎
	% _I_ Single	idleTimeVar	 - Idle Time Var in 탎
	% _I_ Single	adcStartTimeVar	 - ADC Start Time Var in 탎
	% _I_ UInt16	tx1Enable	 - tx1 channel
	% _I_ UInt16	tx2Enable	 - tx2 channel
	% _I_ UInt16	tx3Enable	 - tx3 channel
	Lua_String  = sprintf('ar1.ChirpConfig(%d, %d, %d, 0, 0, 0, 0, %d, %d, %d)', ChirpOffset+ChirpCfg, ChirpOffset+ChirpCfg, ProfileNum, Tx1_Enable, Tx2_Enable, Tx3_Enable);
	ErrStatus   =   RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
	if (ErrStatus ==30000)
		disp('Chirp config successful')
	else
		disp('Chirp config failed')
		return;
	end
	%pause(wait_time);
end
end

%Frame Configuration
%Syntax:
% Int32 ar1.FrameConfig(UInt16 chirpStartIdx, UInt16 chirpEndIdx, UInt16 frameCount, UInt16 loopCount, Single periodicity, Single triggerDelay, UInt16 TriggerSelect) - Frame Configuration API defines Frame formation which has sequence of chirps to be transmitted subsequently
% _I_ UInt16	chirpStartIdx	 - First Chirp Start Index number
% _I_ UInt16	chirpEndIdx	 - Last chirp Index number
% _I_ UInt16	frameCount	 - Number of frames to transmit.
% In 4-chip, need to transmit twice the nunber of frames due to capture issue with second half
% _I_ UInt16	loopCount	 - Number of times to repeat from start chirp to last chirp in each frame
% _I_ Single	periodicity	 - Each frame repetition period in ms
% _I_ Single	triggerDelay	 -  Optional time delay from sync in trigger to the occurrence of frame chirps in 탎
% _I_ UInt16	TriggerSelect	 - TriggerSelect
Lua_String = sprintf('ar1.FrameConfig(%d, %d, %d, %d, %f, 0, %d)', chirpStartIdx, chirpEndIdx, Num_Frames, nchirp_loops, Frame_Repetition_Period_ms, TriggerSelect_Arr);
ErrStatus =RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
if (ErrStatus==30000)  %n*2 for the work around to handle an issue in the TSW14J56 FW
    disp('Frame Config successful');
else
    disp('Frame Config failed');
    return;
end
%pause(wait_time);
disp('Configuration Successful');
return;
end