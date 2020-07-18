/*  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/ 
*  
*  
*   Redistribution and use in source and binary forms, with or without 
*   modification, are permitted provided that the following conditions 
*   are met:
*  
*     Redistributions of source code must retain the above copyright 
*     notice, this list of conditions and the following disclaimer.
*  
*     Redistributions in binary form must reproduce the above copyright
*     notice, this list of conditions and the following disclaimer in the 
*     documentation and/or other materials provided with the   
*     distribution.
*  
*     Neither the name of Texas Instruments Incorporated nor the names of
*     its contributors may be used to endorse or promote products derived
*     from this software without specific prior written permission.
*  
*   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
*   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
*   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
*   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
*   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
*   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
*   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
*   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
*   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
*   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
*   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*  
* /

#include "extcode.h"
#ifdef __cplusplus
extern "C" {
#endif

/*!
 * This function is used to pass/modify the ADC Output Data Rate (previously 
 * known as "ADC Sampling Rate" in HSDCPro GUI).
 */
int32_t __cdecl Pass_ADC_Output_Data_Rate(double ADCOutputDataRate, 
	int32_t TimeoutInMs);
/*!
 * This function is used to pass/modify the ADC Input Target Frequency.
 */
int32_t __cdecl Set_ADC_Input_Target_Frequency(
	double ADCInputTargetFrequency, int32_t TimeoutInMs);
/*!
 * This function is used to set the number of samples per channel. The GUI 
 * will automatically coerce it to be a multiple of 4092.
 */
int32_t __cdecl Set_Number_of_Samples(uint64_t NumberOfSamplesPerChannel, 
	int32_t TimeoutInMs);
/*!
 * This function is used to set the Trigger mode. 
 * 
 * For normal capture, trigger mode enable, software trigger enable and "Arm 
 * On Next Capture Button Press, has to be disabled(0). 
 * 
 * For external trigger, "TriggerModeEnable" has to be enabled(1) and 
 * "SoftwareTriggerEnable" and "ArmOnNextCaptureButtonPress" has to be 
 * disabled(0).
 * 
 * For software trigger, "TriggerModeEnable" and "SoftwareTriggerEnable" has 
 * to be enabled(1) and "ArmOnNextCaptureButtonPress" has to be disabled(0).
 */
int32_t __cdecl Trigger_Option(int32_t TriggerModeEnable, 
	int32_t SoftwareTriggerEnable, int32_t ArmOnNextCaptureButtonPress, 
	uint8_t TriggerCLKDelays, int32_t TimeoutInMs);
/*!
 * This function is called to start a normal capture ("Trigger Mode Enable", 
 * "Software Trigger" and "Arm On Next Capture Button Press" have to be 
 * disabled using "Trigger Option" function before using this function).
 */
int32_t __cdecl Pass_Capture_Event(int32_t TimeoutInMs);
/*!
 * This function is used to generate a software trigger. Before this function 
 * is called, software trigger mode needs to be set("TriggerModeEnable" and 
 * "SoftwareTriggerEnable" should be "1" and "Arm On Next Capture Button 
 * Press" have to be "0" ) by using "Trigger Option" function.
 */
int32_t __cdecl Generate_Software_Trigger(int32_t WaitToCheckTrigger, 
	int32_t TimeoutInMs);
/*!
 * This function is used to read the data present in the DDR memory captured 
 * after the external trigger. Before this function is called, 
 * "TriggerModeEnable" has to be enabled(1) while "SoftwareTriggerEnable" and 
 * "Arm On Next Capture Button Press" should be disabled(0) using "Trigger 
 * Option" function.
 */
int32_t __cdecl Read_DDR_Memory(int32_t WaitToCheckTrigger, 
	int32_t TimeoutInMs);
/*!
 * HSDC_Ready
 */
int32_t __cdecl HSDC_Ready(int32_t TimeoutInMs);
/*!
 * The CSV file contains the time domain data of all channels(maximum 8), with 
 * each channel as a separate column.
 */
int32_t __cdecl Save_Raw_Data_As_CSV(char CSVFilePathWithName[], 
	int32_t TimeoutInMs);
/*!
 * This function is used to switch between the different Test Selection modes. 
 * Changing the Test Selection also affects the ADC Graph plot type.
 */
int32_t __cdecl ADC_Test_Selection(uint16_t TestSelection, 
	int32_t TimeoutInMs);
/*!
 * This function is used to change the plot type (Time domain/Frequency 
 * domain) of the graph. Changing the ADC Plot type also changes the "Test 
 * Selection" by switching to Time/Frequency domain.
 */
int32_t __cdecl ADC_Plot_Type(uint16_t PlotType, int32_t TimeoutInMs);
/*!
 * This function is used to change the FFT windowing technique to be applied 
 * to the active channel.
 */
int32_t __cdecl FFT_Window(uint16_t FFTWindowType, int32_t TimeoutInMs);
/*!
 * This function is used to change the active channel of the GUI. Channel 
 * Index is zero based.
 */
int32_t __cdecl Select_ADC_Channel(uint16_t ChannelIndex, 
	int32_t TimeoutInMs);
/*!
 * This function is used to set the FFT Window notching parameters. HSDCPro 
 * GUI maintains two separate sets of frequency notch parameters, one for 
 * "Rectangular" FFT and the second set is common for the other windowing 
 * techniques (Hamming, Hanning and Blackman). The number of harmonics and the 
 * custom frequencies are common for all FFT window types.
 */
int32_t __cdecl FFT_Window_Notching(uint16_t FFTSettingsType, 
	uint32_t NumberOfHarmonics, uint32_t NoOfBinsToRemoveEitherSideOfHarmonics, 
	uint32_t NoOfBinsToRemoveAfterDC, 
	uint32_t NoOfBinsToRemoveEitherSideOfFundamental, 
	double CustomNotchFrequencies[], 
	uint32_t NoOfBinsToRemoveOnEitherSideOfCustomFrequencies[], 
	uint32_t NumberOfCustomFreq, int32_t EnableFsby2MinusFinNotching, 
	uint32_t BinsToRemoveOnEitherSideOfFsby2MinusFin, int32_t TimeoutInMs);
/*!
 * This function is used to get the FFT data of the active channel. 
 */
int32_t __cdecl Get_FFT_Data(int32_t TimeoutInMs, double *f0, double *df, 
	double ActiveChannelFFT[], int32_t *FFTArrayLength);
/*!
 * This function takes a screen shot of the GUI in FFT mode for the channel 
 * number specified. "FFT Window" function can be called before this function 
 * to specify the FFT windowing technique of the FFT. If not, the last 
 * selected FFT windowing technique will be used.
 */
int32_t __cdecl Save_FFT_As_PNG(uint16_t ChannelIndex, 
	char PNGFilePathWithName[], int32_t TimeoutInMs);
/*!
 * This function is used to get the values of the required single tone 
 * parameters of active ADC channel.
 */
int32_t __cdecl Single_Tone_Parameters(char ParametersIn[], int32_t dBFs, 
	int32_t TimeoutInMs, double ParameterValues[], int32_t ParameterValuesLength);
/*!
 * Get_Error_Status
 */
int32_t __cdecl Get_Error_Status(int32_t StringLengthIn, int32_t TimeoutInMs, 
	char ErrorString[]);
/*!
 * This function returns the Automation DLL Version. 
 */
double __cdecl Automation_DLL_Version(void);
/*!
 * This function sets the Preamble value for the DAC.
 */
int32_t __cdecl DAC_Preamble(double DACPreamble, int32_t TimeoutInMs);
/*!
 * This function passes the DAC Data Rate to the HSDCPro GUI.
 */
int32_t __cdecl DAC_Data_Rate(double DACDataRate, int32_t TimeoutInMs);
/*!
 * This function is used to specify whether the data has to be in 2's 
 * Complement or Offset Binary mode.
 */
int32_t __cdecl DAC_Option(uint16_t DACOption, int32_t TimeoutInMs);
/*!
 * This function sets the provided channel index as the active channel.
 */
int32_t __cdecl DAC_Active_Channel(int32_t ActiveChannelIndex, 
	int32_t TimeoutInMs);
/*!
 * This function is used to enable/disable each of the DAC Channels.
 */
int32_t __cdecl DAC_Channel_Enable_Settings(int32_t ChannelEnableSettings[], 
	int32_t NumberOfChannels, int32_t TimeoutInMs);
/*!
 * This function is used to specify the data file path which needs to be 
 * loaded to the DAC.
 */
int32_t __cdecl DAC_Load_File(char DACFilePath[], int32_t TimeoutInMs);
/*!
 * This function generates tones as per the given requirements and the data 
 * generated is ready to be sent to DAC using "DAC Send".
 */
int32_t __cdecl DAC_Tone_Generation(double ToneBandwidth, 
	int32_t NumberOfTones, double ToneCenter, int32_t NumberOfSamples, 
	uint16_t ToneSelection, double ScalingFactor, int32_t TimeoutInMs);
/*!
 * This function sends the data loaded to DAC(from File provided by user or 
 * generated using DAC Tone Generation). 
 */
int32_t __cdecl DAC_Send(int32_t TimeoutInMs);
/*!
 * This function is used to specify the board to which the HSDC Pro GUI needs 
 * to be connected. If the board is already connected, it is disconnected and 
 * connected again.
 */
int32_t __cdecl Connect_Board(char BoardSerialNumber[], int32_t TimeoutInMs);
/*!
 * This function is used to disconnect the connected board. If no board is 
 * connected, it returns an error.
 */
int32_t __cdecl Disconnect_Board(int32_t TimeoutInMs);
/*!
 * This function is used to download firmware to the board. Using "Select 
 * ADC/DAC Device" function will itself automatically download the respective 
 * device's firmware, so there is no need to call this function separately. 
 * This function is made available to the user if he wants to download a 
 * specific firmware to the board.
 */
int32_t __cdecl Download_Firmware(char FirmwareFilePath[], 
	int32_t WaitToCheck, int32_t TimeoutInMs);
/*!
 * This function is used to select the ADC device in HSDC Pro GUI. 
 * 
 * The board needs to be connected before selecting the device. The selected 
 * ADC device's firmware will automatically be downloaded to the board(if the 
 * same firmware is not already present in the board). The function will 
 * return immediately after the operations complete.  A timeout value of 120s 
 * is recommended.s
 */
int32_t __cdecl Select_ADC_Device(char ADCDevice[], int32_t TimeoutInMs);
/*!
 * This function is used to select the DAC device in HSDC Pro GUI. 
 * 
 * The board needs to be connected before selecting the device. The selected 
 * DAC device's firmware will automatically be downloaded to the board(if the 
 * same firmware is not already present in the board). The function will 
 * return immediately after the operations complete. A Timepout of 120s or 
 * more is recommended.
 */
int32_t __cdecl Select_DAC_Device(char DACDevice[], int32_t TimeoutInMs);
/*!
 * This function is used to change the number of samples to be considered for 
 * analysis. The analysis window length(number of samples) should be one of 
 * the following values : 4096, 8192, 16384, 32768, 65536, 131072, 262144, and 
 * 524288. If any other value is passed, it will be coerced to the next 
 * highest value in the above list.
 */
int32_t __cdecl ADC_Analysis_Window_Length(
	uint32_t NumberOfSamplesForAnalysis, int32_t TimeoutInMs);
/*!
 * This function can be used to find the selected ADC device in HSDC Pro GUI. 
 * It returns the current ADC device selected in HSDC Pro GUI as a string. 
 * When no device is selected, it will return "Select ADC Device".
 */
int32_t __cdecl Get_ADC_Device(int32_t StringLengthAllocated, 
	int32_t TimeoutInMs, char CurrentADCDevice[]);
/*!
 * This function can be used to find the selected DAC device in HSDC Pro GUI. 
 * It returns the current DAC device selected in HSDC Pro GUI as a string. 
 * When no device is selected, it will return "Select DAC Device".
 */
int32_t __cdecl Get_DAC_Device(int32_t StringLengthAllocated, 
	int32_t TimeoutInMs, char CurrentDACDevice[]);
/*!
 * This function reads registers of HSDC Board.
 */
int32_t __cdecl Read_Registers(int32_t RegisterAddress[], 
	int32_t NumberOfRegisters, int32_t TimeoutInMs, int32_t RegisterValues[]);
/*!
 * This function is used to write registers of HSDC Board.
 */
int32_t __cdecl Write_Registers(int32_t RegisterAddress[], 
	int32_t NumberOfRegisters, uint8_t RegisterValues[], int32_t TimeoutInMs);
/*!
 * This function is used to set the Trigger mode. 
 * 
 * For normal capture, trigger mode enable, software trigger enable and "Arm 
 * On Next Capture Button Press, has to be disabled(0). 
 * 
 * For external trigger, "TriggerModeEnable" has to be enabled(1) and 
 * "SoftwareTriggerEnable" and "ArmOnNextCaptureButtonPress" has to be 
 * disabled(0).
 * 
 * For software trigger, "TriggerModeEnable" and "SoftwareTriggerEnable" has 
 * to be enabled(1) and "ArmOnNextCaptureButtonPress" has to be disabled(0).
 */
int32_t __cdecl ADC_Average_Settings(int32_t AverageFFTOn, 
	int32_t NumberOfAverages, int32_t TimeoutInMs);
/*!
 * This function is used to disconnect the connected board. If no board is 
 * connected, it returns an error.
 */
int32_t __cdecl Reset_Board(int32_t TimeoutInMs);
/*!
 * This function is used to pass/modify the ADC Input Target Frequency.
 */
int32_t __cdecl Set_ADC_BIM(int32_t EnableBIM, double BIM0, double BIM1, 
	int32_t TimeoutInMs);
/*!
 * This function is used to set the Trigger mode. 
 * 
 * For normal capture, trigger mode enable, software trigger enable and "Arm 
 * On Next Capture Button Press, has to be disabled(0). 
 * 
 * For external trigger, "TriggerModeEnable" has to be enabled(1) and 
 * "SoftwareTriggerEnable" and "ArmOnNextCaptureButtonPress" has to be 
 * disabled(0).
 * 
 * For software trigger, "TriggerModeEnable" and "SoftwareTriggerEnable" has 
 * to be enabled(1) and "ArmOnNextCaptureButtonPress" has to be disabled(0).
 */
int32_t __cdecl ADC_Channel_Power_Settings(double ADCCenterFrequency, 
	int32_t NumberOfChannels, double SignalWidth, double ChannelSeparation, 
	int32_t TimeoutInMs);
/*!
 * This function is used to get the values of the required single tone 
 * parameters of active ADC channel.
 */
int32_t __cdecl ADC_Channel_Power_Parameters(char ParametersIn[], 
	int32_t TimeoutInMs, double ParameterValues[], int32_t NumberOfParameters);
/*!
 * This function is used to pass/modify the ADC Input Target Frequency.
 */
int32_t __cdecl ADC_Sample_Offset(uint32_t ADCSampleStartingIndex, 
	int32_t TimeoutInMs);
/*!
 * This function is used to get the values of the required single tone 
 * parameters of active ADC channel.
 */
int32_t __cdecl Two_Tone_Parameters(char ParametersIn[], int32_t TimeoutInMs, 
	double ParameterValues[], int32_t ParameterValuesLength);
/*!
 * This function is used to pass/modify the ADC Input Target Frequency.
 */
int32_t __cdecl Set_ADC_2nd_Input_Frequency(double ADC2ndInputFrequency, 
	int32_t TimeoutInMs);
/*!
 * This function is used to generate a software trigger. Before this function 
 * is called, software trigger mode needs to be set("TriggerModeEnable" and 
 * "SoftwareTriggerEnable" should be "1" and "Arm On Next Capture Button 
 * Press" have to be "0" ) by using "Trigger Option" function.
 */
int32_t __cdecl DAC_Generate_Software_Trigger(int32_t TimeoutInMs);
/*!
 * This function is used to read the data present in the DDR memory captured 
 * after the external trigger. Before this function is called, 
 * "TriggerModeEnable" has to be enabled(1) while "SoftwareTriggerEnable" and 
 * "Arm On Next Capture Button Press" should be disabled(0) using "Trigger 
 * Option" function.
 */
int32_t __cdecl DAC_Write_DDR_Memory(int32_t TimeoutInMs);
/*!
 * This function is used to set the Trigger mode. 
 * 
 * For normal capture, trigger mode enable, software trigger enable and "Arm 
 * On Next Capture Button Press, has to be disabled(0). 
 * 
 * For external trigger, "TriggerModeEnable" has to be enabled(1) and 
 * "SoftwareTriggerEnable" and "ArmOnNextCaptureButtonPress" has to be 
 * disabled(0).
 * 
 * For software trigger, "TriggerModeEnable" and "SoftwareTriggerEnable" has 
 * to be enabled(1) and "ArmOnNextCaptureButtonPress" has to be disabled(0).
 */
int32_t __cdecl DAC_Trigger_Option(int32_t TriggerModeEnable, 
	int32_t SoftwareTriggerEnable, uint8_t TriggerCLKDelays, int32_t TimeoutInMs);
/*!
 * The CSV file contains the time domain data of all channels(maximum 8), with 
 * each channel as a separate column.
 */
int32_t __cdecl ADC_Save_Raw_Data_As_Binary_File(
	char BinaryFilePathWithName[], int32_t TimeoutInMs);
/*!
 * This function is used to set the Trigger mode. 
 * 
 * For normal capture, trigger mode enable, software trigger enable and "Arm 
 * On Next Capture Button Press, has to be disabled(0). 
 * 
 * For external trigger, "TriggerModeEnable" has to be enabled(1) and 
 * "SoftwareTriggerEnable" and "ArmOnNextCaptureButtonPress" has to be 
 * disabled(0).
 * 
 * For software trigger, "TriggerModeEnable" and "SoftwareTriggerEnable" has 
 * to be enabled(1) and "ArmOnNextCaptureButtonPress" has to be disabled(0).
 */
int32_t __cdecl FFT_Peak_Analysis_Settings(int32_t EnablePeakAnalysis, 
	double PeakAnalysisFactor, int32_t TimeoutInMs);
/*!
 * This function is used to get the values of the required single tone 
 * parameters of active ADC channel.
 */
int32_t __cdecl FFT_Peak_Analysis_Results(int32_t dBFs, int32_t TimeoutInMs, 
	double PeakValues[], double PeakFrequencies[], int32_t *NumberOfPeaks);
/*!
 * This function is used to get the values of the required single tone 
 * parameters of active ADC channel.
 */
int32_t __cdecl Time_Domain_Parameters(char ParametersIn[], 
	int32_t TimeoutInMs, double ParameterValues[], int32_t ParameterValuesLength);
/*!
 * The CSV file contains the time domain data of all channels(maximum 8), with 
 * each channel as a separate column.
 */
int32_t __cdecl ADC_Import_Binary_File(char BinaryFilePathWithName[], 
	int32_t NumberOfChannels, int32_t TimeoutInMs);
/*!
 * The CSV file contains the time domain data of all channels(maximum 8), with 
 * each channel as a separate column.
 */
int32_t __cdecl ADC_Import_Data_File(char DataFilePathWithName[], 
	int32_t NumberOfBits, int32_t NumberOfChannels, int32_t TimeoutInMs);
/*!
 * This function can be used to find the selected ADC device in HSDC Pro GUI. 
 * It returns the current ADC device selected in HSDC Pro GUI as a string. 
 * When no device is selected, it will return "Select ADC Device".
 */
int32_t __cdecl Get_Active_ADC_Channel(uint16_t *ActiveChannelIndex, 
	int32_t TimeoutInMs);
/*!
 * This function sets the provided channel index as the active channel.
 */
int32_t __cdecl DAC_Scaling_Factor(double DACScalingFactor, 
	int32_t TimeoutInMs);
/*!
 * This function is used to set the number of samples per channel. The GUI 
 * will automatically coerce it to be a multiple of 4092.
 */
int32_t __cdecl Set_Y_Scale_Unit(int32_t Volts, int32_t TimeoutInMs);
/*!
 * This function can be used to get the number of samples per samples in ADC.
 */
int32_t __cdecl Get_Number_of_Samples_Per_Channel(
	uint64_t *NumberOfSamplesPerChannel, int32_t TimeoutInMs);
/*!
 * This function is used to write registers of HSDC Board.
 */
int32_t __cdecl Write_Registers_U32(int32_t RegisterAddress[], 
	int32_t NumberOfRegisters, uint32_t RegisterValues[], int32_t TimeoutInMs);
/*!
 * This function is used to set the number of samples per channel. The GUI 
 * will automatically coerce it to be a multiple of 4092.
 */
int32_t __cdecl Set_AdditionalFrequencyParameters(
	uint32_t AdditionalDeviceParameters, double ADCOutputDataRate, 
	double ADCInputTargetFrequency, double NCOFrequency, double Decimation, 
	int32_t TimeoutInMs);

MgErr __cdecl LVDLLStatus(char *errStr, int errStrLen, void *module);

#ifdef __cplusplus
} // extern "C"
#endif

