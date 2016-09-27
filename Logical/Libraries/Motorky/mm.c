/***********************************************************************************************
	DEFINES
************************************************************************************************/
#define ENCODER_POSITION pIOMapping->Counter
#define ENCODER_USED
#define RESET_OUTPUT 
#define SPEED_PID_USED

/***********************************************************************************************
	INCLUDES
************************************************************************************************/
#include <motorky.h>
#include <string.h>
#include "path_generator.h"
#include "auxiliaries.h"

/****************************************************************************
Function    : MM()
Author      : RV
Description : Main function to control a MM motor modul
Date        : 5.2.2008
Changes     :
****************************************************************************/
void MM(MM_typ *p)
{
	Motorky_MM_IOMapping			*pIOMapping = &p->IOMapping;
	Motorky_Intern_typ				*pIntern = &p->intern;
	Motorky_InternMM_typ			*pInternMM = &p->internMM;
	Motorky_PathGenerator			*pPathGenerator = &pIntern->pathGenerator;
	Motorky_ActualSpeed				*pActualSpeed = &pInternMM->actualSpeed;
	Motorky_MoveActive 				*pMoveActive = &pIntern->moveActive;
	Motorky_ConvertPosition			*pEncoder2units = &pInternMM->encoder2units;
	Motorky_PID						*pPID = &pInternMM->pid;
	Motorky_PID						*pSpeedPID = &pInternMM->speedPID;

/***********************************************************************************************
	CHECK ERRORS
************************************************************************************************/
	if (pIOMapping->UnderVoltageError)
	{
		p->info.status = ERR_UNDER_VOLTAGE;
	}

	if (pIOMapping->OverVoltageError)
	{
		p->info.status = ERR_OVER_VOLTAGE;
	}

	if (pIOMapping->OvertemperatureError)
	{
		p->info.status = ERR_OVER_TEMPERATURE;
	}

	if (pIOMapping->OvercurrentError)
	{
		p->info.status = ERR_OVER_CURRENT;
	}

	#include "check_errors.h"

/***********************************************************************************************
	BIG STATE MACHINE
************************************************************************************************/
	switch(pIntern->step)
	{
/***********************************************************************************************
	STATES 0 - 99 PERFORM INITIALIZATION
************************************************************************************************/
	case 0:
		pIOMapping->PeriodDuration = 50;/* 100 us ... 10 kHz */
		pIntern->step = 10;
		break;

/***********************************************************************************************
	BASIC STATES 10 - 1009
************************************************************************************************/
	#include "basic.h"

	case 1010:
		/*	acknowledge motor error */
		pIOMapping->ClearError = 1;
		pIntern->step++;
		break;

	case 1011:
		/*	acknowledge motor error */
		pIOMapping->ClearError = 0;
		pIntern->step++;
		break;

	case 1012:
		p->info.status = 0;
		
		/*	return from error */
		if (p->info.initialized)
		{
			pIntern->step = 100;
		}
		else
		{
			pIntern->step = 0;
		}
		break;
	}

	#include "every_cycle.h"
	
/***********************************************************************************************
	OUTPUT GENERATOR
************************************************************************************************/
	/*	position PID */
	pPID->enable =  p->info.powerOn;
	pPID->W = pPathGenerator->outputPosition;
	pPID->X = pEncoder2units->output;
	PID(pPID);
	
	/* speed PID */
	pSpeedPID->enable =  p->info.powerOn;
	pSpeedPID->W = pPID->Y;
	pSpeedPID->X = pActualSpeed->actSpeed;
	PID(pSpeedPID);
	
	pIOMapping->PulseWidth = pSpeedPID->Y;
	
	if (pEncoder2units->reverseDirection)
	{
		pIOMapping->PulseWidth = -pIOMapping->PulseWidth;
	}
}


