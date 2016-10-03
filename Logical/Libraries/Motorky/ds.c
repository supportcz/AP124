/***********************************************************************************************
	DEFINES
************************************************************************************************/
#define RESET_OUTPUT 	ConvertPositionInitialize(pUnits2output, p->init.units, p->init.microsteps, p->init.reverseDirection, pPathGenerator->outputPosition, pUnits2output->output);
			 			
/***********************************************************************************************
	INCLUDES
************************************************************************************************/
#include <motorky.h>
#include <string.h>
#include "path_generator.h" 
#include "auxiliaries.h"

/****************************************************************************
Function    : DS()
Author      : RV
Description : Main function to control a stepper motor modul with a DS modul
Date        : 7.12.2006
Changes     :
****************************************************************************/
void DS(DS_typ *p)
{
	Motorky_DS_IOMapping		*pIOMapping = &p->IOMapping;
	Motorky_Intern_typ			*pIntern = &p->intern;
	Motorky_PathGenerator		*pPathGenerator = &pIntern->pathGenerator;
//	Motorky_ActualSpeed			*pActualSpeed = &pIntern->actualSpeed;
	Motorky_MoveActive 			*pMoveActive = &pIntern->moveActive;
	Motorky_ConvertPosition		*pUnits2output = &p->units2output;

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
		p->movTargetTimeOffset = 4*ConvertTime(p->init.taskTime);

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
	ConvertPosition(pUnits2output,pPathGenerator->outputPosition);

	pIOMapping->MovTargetPosition = pUnits2output->output ;
	pIOMapping->MovTargetTime = pIOMapping->SystemTime + p->movTargetTimeOffset;
}


