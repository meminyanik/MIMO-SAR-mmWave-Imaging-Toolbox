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
% SarSyncApi.m
% 
% Abstract:
% The Api class to communicate with the hardware


classdef SarSyncApi
    
    %% Properties
    properties
        serialPort   % Serial port object
        uartQueueDelay_s = 0.1; % Extra 100 ms delay to process Uart command in the FW
    end
    
    %% Methods
    methods
        %% Constructor
        function obj = SarSyncApi(port)
            if nargin == 1
                obj.serialPort = serialport(port,115200);
                configureTerminator(obj.serialPort,"CR/LF")
                flush(obj.serialPort)
                configureCallback(obj.serialPort,"terminator",@readSerialData)
            end
        end
        
        %% Radar Trigger Command
        function radarTrigger(obj)
            write(obj.serialPort, "$RTG#", "char")
            pause(obj.uartQueueDelay_s) 
        end
        
        %% Set Desired Number of Radar Trigger Command
        function setDesiredRadarTrigger(obj, desiredTrigger)
            write(obj.serialPort, "$DTG" + num2str(desiredTrigger) + "#", "char")
            pause(obj.uartQueueDelay_s)
        end
        
        %% Clear Number of Radar Trigger Command
        function clearNumTrigger(obj)
            write(obj.serialPort, "$CTG#", "char")
            pause(obj.uartQueueDelay_s)
        end
        
        %% Set Pulse Count Command
        function setPulseCount(obj, numPulses)
            write(obj.serialPort, "$PLS" + num2str(numPulses) + "#", "char")
            pause(obj.uartQueueDelay_s)
        end
        
        %% Reset Pulse Counter Command
        function resetPcnt(obj)
            write(obj.serialPort, "$RST#", "char")
            pause(obj.uartQueueDelay_s)
        end
        
        %% Pause Pulse Counter Command
        function pausePcnt(obj)
            write(obj.serialPort, "$PAU#", "char")
            pause(obj.uartQueueDelay_s)
        end
        
        %% Resume Pulse Counter Command
        function resumePcnt(obj)
            write(obj.serialPort, "$RES#", "char")
            pause(obj.uartQueueDelay_s)
        end
        
        %% Set Number of Measurement Command
        function setNumMeasurement(obj, numMeasurement)
            write(obj.serialPort, "$MSR" + num2str(numMeasurement) + "#", "char")
            pause(obj.uartQueueDelay_s)
        end
    end
end