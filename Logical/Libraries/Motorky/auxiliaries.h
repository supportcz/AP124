#ifndef _MOTORKY_AUXILIARIES_
#define _MOTORKY_AUXILIARIES_

#include <bur/plctypes.h>

#define INT_MAXVALUE	0x7FFF
#define DINT_MAXVALUE	0x7FFFFFFF
#define DEFAULT_SPEED			1000
#define DEFAULT_ACCELERATION	5000
/*
#define BIT_SET(value,bit)		value|=1<<(bit)
#define BIT_GET(value,bit)  	(value&(1<<(bit)))?1:0
#define BIT_CLR(value,bit)		value&=~(1<<(bit))
*/

void ActualSpeedInitialize(Motorky_ActualSpeed *pActualSpeed, REAL taskTime, REAL filterTime);
void ActualSpeed(Motorky_ActualSpeed *pActualSpeed);

void ConvertPositionInitialize(Motorky_ConvertPosition *pConvertPosition, DINT inputScale, DINT outputScale, BOOL reverseDirection, 
	INT input, DINT output);
DINT ConvertPosition(Motorky_ConvertPosition *pConvertPosition, INT input);
DINT ConvertTime(REAL realVar);
void MoveActiveInitialize(Motorky_MoveActive *pMoveActive, REAL TaskTime, REAL SettleTime);
void MoveActive(Motorky_MoveActive *pMoveActive);
void TOFInitialize(Motorky_TOF *pTOF, REAL TaskTime, REAL PT);
void TOF(Motorky_TOF *pTOF);
void PIDInitialize(Motorky_PID *pPID, REAL Kp, REAL Tn, REAL TaskTime, DINT Y_max, DINT Y_min);
void PID(Motorky_PID *pPID);

#endif /* _MOTORKY_AUXILIARIES_ */
