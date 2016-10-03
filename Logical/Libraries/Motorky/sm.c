/***********************************************************************************************
	DEFINES
************************************************************************************************/
#define RESET_OUTPUT 	ConvertPositionInitialize(pUnits2output, p->init.units, p->init.microsteps, p->init.reverseDirection, \
						pPathGenerator->outputPosition, pUnits2output->output);

/***********************************************************************************************
	INCLUDES
************************************************************************************************/
#include <motorky.h>
#include <string.h>
#include "path_generator.h"
#include "auxiliaries.h"


/****************************************************************************
Function    : SM()
Author      : RV
Description : Main function to control a stepper motor modul
Date        : 7.12.2006
Changes     :
****************************************************************************/
void SM(SM_typ *p) 
{
	Motorky_SM_IOMapping		*pIOMapping = &p->IOMapping;
	Motorky_Intern_typ			*pIntern = &p->intern;
	Motorky_PathGenerator		*pPathGenerator = &pIntern->pathGenerator;
	Motorky_MoveActive 			*pMoveActive = &pIntern->moveActive;
	Motorky_ConvertPosition		*pUnits2output = &p->units2output;

/***********************************************************************************************
	CHECK ERRORS
************************************************************************************************/
	if (pIOMapping->StallError)
	{
		p->info.status = ERR_STALL;
	}

	if (pIOMapping->OvertemperatureError)
	{
		p->info.status = ERR_OVER_TEMPERATURE;
	}

	if (pIOMapping->OvercurrentError)
	{
		p->info.status = ERR_OVER_CURRENT;
	}

	if (pIOMapping->ModulePowerSupplyError)
	{
		p->info.status = ERR_POWER_SUPPLY_ERROR;
	}
	
	if (pIOMapping->UZKStatus == 0)
	{
		p->info.status = ERR_LOW_DC_BUS_VOLTAGE;
	}

//	if (pIOMapping->Enable == 0)
//	{
//		p->info.status = ERR_ENABLE_INPUT_NOT_ACTIVE;
//	}
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

		TOFInitialize(&p->tofBoostCurrent,p->init.taskTime, 0.1); // =100ms
		
		if (p->init.outputFilter < 0) p->init.outputFilter = 0;
		if (p->init.outputFilter > 0.1) p->init.outputFilter = 0.1;
			
		if (p->init.taskTime > 0)	
		{
			p->filterLevel = 1 + p->init.outputFilter / p->init.taskTime;
		}
		
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
		/*	wait till module resets error */
		pIntern->step++;
		break;
		
	case 1013:
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
	ConvertPosition(pUnits2output,pPathGenerator->outputPosition);

	pIOMapping->DriveEnable = p->info.powerOn;
	
	p->dPosition  = pUnits2output->output - p->oldPosition;

	pIOMapping->MotorStep0 = 0;
	
	if (p->dPosition > 0)
	{
		if (p->dPosition >= p->filterLevel) 
		{
			pIOMapping->MotorStep0 = p->dPosition / p->filterLevel;
		}
		else
		{
			pIOMapping->MotorStep0 = 1;
		}
	}
	
	if (p->dPosition < 0)
	{
		if (p->dPosition <= -p->filterLevel) 
		{
			pIOMapping->MotorStep0 = p->dPosition / p->filterLevel;
		}
		else
		{
			pIOMapping->MotorStep0 = -1;
		}
	}

	p->oldPosition += pIOMapping->MotorStep0;
	
	/*	determine if boost current should be used */
	if 	(pPathGenerator->motionState == MOTION_STATE_ACCELERATING || pPathGenerator->motionState == MOTION_STATE_DECELERATING)
	{
		p->tofBoostCurrent.IN = 1;
	}
	else
	{
		p->tofBoostCurrent.IN = 0;
	}

	TOF(&p->tofBoostCurrent);
	pIOMapping->BoostCurrent = p->tofBoostCurrent.Q;

	if (pPathGenerator->motionState == MOTION_STATE_STANDSTILL && p->tofBoostCurrent.Q == 0)
	{
		pIOMapping->StandstillCurrent = 1;
	}
	else
	{
		pIOMapping->StandstillCurrent = 0;
	}

}


