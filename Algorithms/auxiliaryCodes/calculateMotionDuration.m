%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function motionTime_s = calculateMotionDuration(distance_mm,speed_mmps,acceleration_mmps2)

% speed_mmps >= 0;
% acceleration_mmps2 >= 0;

%% A Typical motion profile
%   ___________________
%  /                    \
% /                      \
%/                        \
% t1        t2          t3
% t1: ramp-up time
% t2: running time
% t3: ramp-down time

%% Kinematic equations - uniform acceleration
% d0 is the initial position
% d is the final position
% v0 is the initial velocity
% v is the final velocity
% a is the acceleration
% t is the time interval
%
% v = v0 + a*t
% d = d0 + v0*t + 0.5*a*t^2
% d = d0 + 0.5*(v+v0)*t


%% Ramp-up time
% Initial speed is 0
% Initial position is 0
rampupTime_s = speed_mmps / acceleration_mmps2;
rampupDistance_mm = 0.5*acceleration_mmps2*rampupTime_s^2;

distance_mm = abs(distance_mm);
if (distance_mm >= 2*rampupDistance_mm)
    % Calculate the constant speed running time
    runningDistance_mm = distance_mm - 2*rampupDistance_mm;
    runningTime_s = runningDistance_mm/speed_mmps;
    motionTime_s = runningTime_s + 2*rampupTime_s;
    return;
else
    % recalculate ramp-up time
    rampupDistance_mm = distance_mm / 2;
    rampupTime_s = sqrt(2*rampupDistance_mm/acceleration_mmps2);
    motionTime_s = 2*rampupTime_s;
    return;
end