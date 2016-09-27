#include <motorky.h>
#include "speed_ramping.h"

/*	compute new speed and position */
void SpeedRamping(Motorky_SpeedRamping *pSpeedRamping)
{
	DINT speedDifference;
	DINT absoluteSpeedDifference;
	DINT speedDifference2;

	/*	compute speed difference */
	speedDifference = pSpeedRamping->setSpeed - pSpeedRamping->actualSpeed;

	if (speedDifference > 0)
	{
		/*	compute absolute speed difference */
		absoluteSpeedDifference = ABS(pSpeedRamping->setSpeed) - ABS(pSpeedRamping->actualSpeed);

		/*	speed must be increased ? */
		if (absoluteSpeedDifference > 0)
		{
			/*	accelerate in positive direction  */
			pSpeedRamping->vIntegral += pSpeedRamping->acceleration;
			/*	set state "accelerating" */
			pSpeedRamping->motionState = MOTION_STATE_ACCELERATING;
		}
		else
		{
			/*	decelerate in positive direction */
			pSpeedRamping->vIntegral += pSpeedRamping->deceleration;
			/*	set state "decelerating" */
			pSpeedRamping->motionState = MOTION_STATE_DECELERATING;
		}
	}
	else if (speedDifference < 0)
	{
		/*	compute absolute speed difference */
		absoluteSpeedDifference = ABS(pSpeedRamping->setSpeed) - ABS(pSpeedRamping->actualSpeed);

		/*	speed must be increased ? */
		if (absoluteSpeedDifference > 0)
		{
			/*	accelerate in negative direction */
			pSpeedRamping->vIntegral -= pSpeedRamping->acceleration;
			/*	set state "accelerating" */
			pSpeedRamping->motionState = MOTION_STATE_ACCELERATING;
		}
		else
		{
			/*	decelerate in negative direction */
			pSpeedRamping->vIntegral -= pSpeedRamping->deceleration;
			/*	set state "decelerating" */
			pSpeedRamping->motionState = MOTION_STATE_DECELERATING;
		}
	}
	else
	{
		/*	no speed change is needed */
		pSpeedRamping->motionState = MOTION_STATE_CONSTANT_SPEED;
	}

	/*	compute new value of speed */
	pSpeedRamping->actualSpeed += pSpeedRamping->vIntegral/pSpeedRamping->divisor;
	pSpeedRamping->vIntegral %= pSpeedRamping->divisor;

	/*	check if speed was not reached */
	speedDifference2 = pSpeedRamping->setSpeed - pSpeedRamping->actualSpeed;

	if ((speedDifference > 0 && speedDifference2 <= 0)||(speedDifference < 0 && speedDifference2 >= 0))
	{
		pSpeedRamping->actualSpeed = pSpeedRamping->setSpeed;
		pSpeedRamping->vIntegral = 0;
		pSpeedRamping->motionState = MOTION_STATE_CONSTANT_SPEED;
	}

	/*	compute new position */
	pSpeedRamping->sIntegral += pSpeedRamping->actualSpeed;
	pSpeedRamping->actualPosition += pSpeedRamping->sIntegral/pSpeedRamping->divisor;
	pSpeedRamping->sIntegral %= pSpeedRamping->divisor;
}

void SpeedRampingSetPosition(Motorky_SpeedRamping *pSpeedRamping, DINT position)
{
	pSpeedRamping->actualPosition = position;
	pSpeedRamping->sIntegral = 0;
}

void SpeedRampingSetSpeed(Motorky_SpeedRamping *pSpeedRamping, DINT speed)
{
	pSpeedRamping->actualSpeed = speed;
	pSpeedRamping->vIntegral = 0;
}

void SpeedRampingInitialize(Motorky_SpeedRamping *pSpeedRamping, DINT taskTime)
{
	/*	compute divisor */
	pSpeedRamping->divisor = 1000000/taskTime;
}


