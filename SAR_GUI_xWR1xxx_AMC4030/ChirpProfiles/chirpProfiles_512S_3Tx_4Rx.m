function params = chirpProfiles_512S_3Tx_4Rx()


%% choose which TX to used in TX TDM MIMO mode, all 4 RXs are enabled by default
% Radar studio is initially set using the startup parameters. 
% The following parameters overwrites the chirp configuation values from
% the lua script. 

TxToEnable                          =   [1 2 3]; %TX is configuable in this version
params.RxToEnable                   =   1:4; %all 4 RXs are always on by default, not configuable in this version
params.TxToEnable                   =   TxToEnable;
params.Num_TX                       =   length(TxToEnable); %number of chirp profiles within a frame. FOr TDM MIMO, this value equals to number of TX
params.Num_profiles                 =   1; %fixed for this version
params.Num_chirpConfigs             =   params.Num_TX*params.Num_profiles;

params.Start_Freq_GHz               =	77;		% For PG1 silicon, please avoid 76-77GHz band
params.Slope_MHzperus               =	63.343; % MHz/us
params.Idle_Time_us                 =	10;      % us
params.Tx_Start_Time_us             =   1;      % us
params.Adc_Start_Time_us            =	6;   % us
params.Samples_per_Chirp            =	512; 
params.Sampling_Rate_ksps           =	9121;	% ksps
params.Ramp_End_Time_us             =	63.14;   % us
params.Rx_Gain_dB                   =	30;
params.nchirp_loops                 =	1;		% Number of chirps per frame
params.Num_Frames                   =	16;     % Number of frames
params.Chirps_per_Frame             =   params.nchirp_loops*params.Num_profiles;
params.Frame_Repetition_Period_ms   =   100;

% Dutycycle                         =   0.5;    % (ON duration)/(ON+OFF duration)
% Chirp_Duration_us                 =   (params.Ramp_End_Time_us+params.Idle_Time_us); % us
%params.Frame_Repetition_Period_ms	=	Chirps_per_Frame*Chirp_Duration_us/(Dutycycle*1000);    % ms
end



