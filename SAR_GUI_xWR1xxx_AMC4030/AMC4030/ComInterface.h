#ifndef COM_INTERFACE_H_BY_TP_20170313
#define COM_INTERFACE_H_BY_TP_20170313

#define CALLBACK_DEF			int
//#define CALLBACK_DEF __declspec(dllexport) int WINAPI

CALLBACK_DEF	COM_API_SetComType(int nType);
CALLBACK_DEF	COM_API_OpenLink(int nID,int nBound);
CALLBACK_DEF	COM_API_GetMachineStatus(unsigned char* unStatus);

CALLBACK_DEF	COM_API_ReadFileData(int nSrc,int StartAdd,int len,unsigned char* pOutput);
CALLBACK_DEF	COM_API_WriteFileData(int nSrc,int StartAdd,int len,unsigned char* pInput);

CALLBACK_DEF	COM_API_Jog(int nAxis,float fDis,float Speed);
CALLBACK_DEF	COM_API_Home(int nXAxisSet,int nYAxisSet,int nZAxisSet);
CALLBACK_DEF	COM_API_StartAutoRun(int nType,int nID);
CALLBACK_DEF	COM_API_StopAxis(int nXAxisSet,int nYAxisSet,int nZAxisSet);
CALLBACK_DEF	COM_API_StopAll();	
CALLBACK_DEF	COM_API_SetOutputBit(int OutputID,int nStatus);
CALLBACK_DEF	COM_API_GetLastError(unsigned int* dwErr);
CALLBACK_DEF	COM_API_DowloadSystemCfg(char* iniPath);
CALLBACK_DEF	COM_API_DowloadFile(char* szPath,int nType,int ShowProcess);
CALLBACK_DEF	COM_API_SendData(int nLen,unsigned char* pData);
CALLBACK_DEF	COM_API_ReadData(int nLen,unsigned char* pInput,unsigned char* pOutput);

#endif
