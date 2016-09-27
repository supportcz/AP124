#include <motorky.h>
#include "auxiliaries.h"

void ActualSpeedInitialize(Motorky_ActualSpeed *pActualSpeed, REAL taskTime, REAL filterTime)
{
	pActualSpeed->taskTime = ConvertTime(taskTime);
	pActualSpeed->filterTime = ConvertTime(filterTime);
	
	/*	calculate FIFO size */
	if (pActualSpeed->taskTime > 0)
	{
		pActualSpeed->FIFOsize = pActualSpeed->filterTime/pActualSpeed->taskTime;
	}
	
	/* correct FIFOsize */
	if (pActualSpeed->FIFOsize <= 0) pActualSpeed->FIFOsize = 1;
	if (pActualSpeed->FIFOsize > SPEED_FIFO_UBOUND+1) pActualSpeed->FIFOsize = SPEED_FIFO_UBOUND+1;
	
	/* calculate FIFO length in us */
	pActualSpeed->filterTime = pActualSpeed->taskTime*pActualSpeed->FIFOsize;
	
	/* initialize FIFO with actual position */
/*	INT index1;
	for (index1=0; index1<=SPEED_FIFO_UBOUND; index1++)
	{
		pActualSpeed->positionFIFO[index1] = pActualSpeed->actPosition;
	}*/
}

void ActualSpeed(Motorky_ActualSpeed *pActualSpeed)
{
	DINT *pPosition;

	/*	increase FIFO index */
	if (++pActualSpeed->FIFOindex >= pActualSpeed->FIFOsize)
	{
		pActualSpeed->FIFOindex = 0;
	}

	/* get pointer to old value */
	pPosition = pActualSpeed->positionFIFO + pActualSpeed->FIFOindex;

	/*	calculate position difference */
	pActualSpeed->positionDifference = pActualSpeed->actPosition - *pPosition;
	
	/*	store new value to FIFO */
	*pPosition = pActualSpeed->actPosition;

	/* compute speed */
	pActualSpeed->actSpeed = (long long)pActualSpeed->positionDifference*1000000/pActualSpeed->filterTime;

}

void ConvertPositionInitialize(Motorky_ConvertPosition *pConvertPosition, DINT inputScale, DINT outputScale, 
	BOOL reverseDirection, INT input, DINT output)
{
	pConvertPosition->inputScale = inputScale;
	pConvertPosition->outputScale = outputScale;
	pConvertPosition->reverseDirection = reverseDirection;

	pConvertPosition->input = input;
	pConvertPosition->output = output;
	pConvertPosition->integral = 0;
}

/*	this FUB converts units to steps */
DINT ConvertPosition(Motorky_ConvertPosition *pConvertPosition, INT input)
{
	long long integral;

	if (pConvertPosition->inputScale == 0) return 0;

	/*	difference */
	pConvertPosition->dInput = input - pConvertPosition->input;

	/*	store old value */
	pConvertPosition->input = input;

	/*	if there was an change, do computation */
	if (pConvertPosition->dInput != 0)
	{
		/*	reverse direction? */
		if (pConvertPosition->reverseDirection)
		{
			pConvertPosition->dInput = -pConvertPosition->dInput;
		}

		/*	copy value */
		integral = pConvertPosition->integral;

		/*	integrate */
		integral += (long long)pConvertPosition->dInput*pConvertPosition->outputScale;

		/*	modify output */
		pConvertPosition->output += integral/pConvertPosition->inputScale;

		/*	and compute rest */
		integral %= pConvertPosition->inputScale;

		/*	store back */
		pConvertPosition->integral = integral;
	}

	return pConvertPosition->output;
}

DINT ConvertTime(REAL realVar)
{
	if (realVar >=0 && realVar <= DINT_MAXVALUE/1000000)
	{
		return (1000000*realVar+0.5);
	}
	else
	{
		/* error */
		return -1;
	}
}


void MoveActiveInitialize(Motorky_MoveActive *pMoveActive, REAL TaskTime, REAL SettleTime)
{
	pMoveActive->taskTime = ConvertTime(TaskTime);
	pMoveActive->settleTime = ConvertTime(SettleTime);
}

void MoveActive(Motorky_MoveActive *pMoveActive)
{
	if (pMoveActive->motionState == MOTION_STATE_STANDSTILL)
	{
		/*	increase timer */
		pMoveActive->settleTimer += pMoveActive->taskTime;

		if (pMoveActive->settleTimer > pMoveActive->settleTime)
		{
			/*	limit timer */
			pMoveActive->settleTimer = pMoveActive->settleTime;
			/*	position reached */
			pMoveActive->moveActive = 0;
		}
	}
	else
	{
		/*	reset timer */
		pMoveActive->settleTimer = 0;
		/*	position not reached */
		pMoveActive->moveActive = 1;
	}
}

void TOFInitialize(Motorky_TOF *pTOF, REAL TaskTime, REAL PT)
{
	pTOF->PT = ConvertTime(PT)/ConvertTime(TaskTime);
}

void TOF(Motorky_TOF *pTOF)
{
	if (pTOF->IN == 1)
	{
		pTOF->Q = 1;
		pTOF->ET = 0;
	}
	else
	{
		if (++pTOF->ET > pTOF->PT) pTOF->ET = pTOF->PT;
	}
	
	if (pTOF->ET == pTOF->PT)
	{
		pTOF->Q = 0;
	}
	else
	{
		pTOF->Q = 1;
	}
}

void PIDInitialize(Motorky_PID *pPID, REAL Kp, REAL Tn, REAL TaskTime, DINT Y_max, DINT Y_min)
{
	pPID->Yi = 0;
	pPID->Yi_sum = 0;	
	pPID->Y = 0;
	
	/*	scale REALs to DINT */
	pPID->Kp = INT_MAXVALUE * Kp;

	/*	compute divisor of Kp */
	pPID->Ki = Tn/TaskTime;
	
	pPID->Y_max = Y_max;
	pPID->Y_min = Y_min;
}

void PID(Motorky_PID *pPID)
{
	if (pPID->enable)
	{
		/* 	compute deviation */
		pPID->e = pPID->W - pPID->X;

		/*	compute proportional action */
		pPID->Yp = ((long long)pPID->Kp*pPID->e)/INT_MAXVALUE;
		
		/*	compute integral action */
		if (pPID->Ki > 0)
		{
			pPID->Yi_sum += pPID->Yp;
			pPID->Yi += pPID->Yi_sum/pPID->Ki;
			pPID->Yi_sum %= pPID->Ki;
		}
		else
		{
			/*	integral action is not used */
			pPID->Yi = 0;
			pPID->Yi_sum = 0;
		}
	}
	else
	{
		/*	no output */
		pPID->Yp = 0;
		pPID->Yi = 0;
		pPID->Yi_sum = 0;	
	}

	/*	compute output value */
	pPID->Ytotal = pPID->Yp + pPID->Yi;

	/*	limit output */
	if (pPID->Ytotal > pPID->Y_max)
	{
		pPID->Ylim = pPID->Y_max;
	}
	else if (pPID->Ytotal < pPID->Y_min)
	{
		pPID->Ylim = pPID->Y_min;
	}
	else
	{
		pPID->Ylim = pPID->Ytotal;
	}

	/*	ramp limiter - at this time not implemented */
	pPID->Y = pPID->Ylim; 

	/*	anti-windup */		
	pPID->Ywindup = pPID->Y - pPID->Ytotal;
	pPID->Yi += pPID->Ywindup;
}


