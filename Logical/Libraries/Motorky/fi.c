/***********************************************************************************************
	DEFINES
************************************************************************************************/
#define ENCODER_POSITION pIOMapping->Encoder
#define ENCODER_USED
#define RESET_OUTPUT 

/***********************************************************************************************
	INCLUDES
************************************************************************************************/
#include <motorky.h>
#include <string.h>
#include "path_generator.h"
#include "auxiliaries.h"

/****************************************************************************
Function    : FI()
Author      : RV
Description : Main function to control a frequency invertor with signal +-10V
Date        : 5.2.2008
Changes     :
****************************************************************************/
void FI(FI_typ *p)
{
	Motorky_FI_IOMapping			*pIOMapping = &p->IOMapping;
	Motorky_Intern_typ				*pIntern = &p->intern;
	Motorky_InternFI_typ			*pInternFI = &p->internFI;
	Motorky_PathGenerator			*pPathGenerator = &pIntern->pathGenerator;
	Motorky_ActualSpeed				*pActualSpeed = &pInternFI->actualSpeed;
	Motorky_MoveActive 				*pMoveActive = &pIntern->moveActive;
	Motorky_ConvertPosition			*pEncoder2units = &pInternFI->encoder2units;
	Motorky_PID						*pPID = &pInternFI->pid;

/***********************************************************************************************
	CHECK ERRORS
************************************************************************************************/
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
		pIntern->step = 10;
		break;

/***********************************************************************************************
	BASIC STATES 10 - 1009
************************************************************************************************/
	#include "basic.h"

	case 1010:
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
	pPID->enable =  p->info.powerOn;
	pPID->W = pPathGenerator->outputPosition;
	pPID->X = pEncoder2units->output;
	PID(pPID);
	if (pEncoder2units->reverseDirection)
	{
		pIOMapping->AnalogOutput = -pPID->Y;
	}
	else
	{
		pIOMapping->AnalogOutput = pPID->Y;
	}
}


