#include <motorky.h>
#include "auxiliaries.h"
#include "speed_ramping.h"

/*	this function determines pPathGenerator->vn and pPathGenerator->sn */
void PathGenerator(Motorky_PathGenerator *pPathGenerator)
{
	Motorky_SpeedRamping *pSpeedRamping = &pPathGenerator->speedRamping;
	DINT	distance, distance2;
	DINT	requiredDeceleration;


	/*	decide if SW limits are used */
	if (pPathGenerator->positiveSwLimit > pPathGenerator->negativeSwLimit)
	{
		/*	if going in positive direction */
		if (pPathGenerator->outputSpeed > 0)
		{
			/*	compute distance to SW limit */
			distance = pPathGenerator->positiveSwLimit - pPathGenerator->outputPosition;

			/*	compute required deceleration ramp */
			if (distance != 0)
			{
				requiredDeceleration = ABS(((long long)pPathGenerator->outputSpeed*pPathGenerator->outputSpeed)/(2*distance));
			}
			else
			{
				requiredDeceleration = 0;
			}

			if (distance < 0 || (distance > 0 && requiredDeceleration >= pPathGenerator->deceleration))
			{
				/*	set error */
				pPathGenerator->status = ERR_POSITIVE_SW_LIMIT_REACHED;

				pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
			}
		}
		/*	if going in negative direction */
		else if (pPathGenerator->outputSpeed < 0)
		{
			/*	compute distance to SW limit */
			distance = pPathGenerator->negativeSwLimit - pPathGenerator->outputPosition;

			/*	compute required deceleration ramp */
			if (distance != 0)
			{
				requiredDeceleration = ABS(((long long)pPathGenerator->outputSpeed*pPathGenerator->outputSpeed)/(2*distance));
			}
			else
			{
				requiredDeceleration = 0;
			}

			if (distance > 0 || (distance < 0 && requiredDeceleration >= pPathGenerator->deceleration))
			{
				/*	set error */
				pPathGenerator->status = ERR_NEGATIVE_SW_LIMIT_REACHED;

				pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
			}
		}
	}

	/* MOVE_ABSOLUTE */
	if (pPathGenerator->moveCommand == MOVE_COMMAND_ABSOLUTE)
	{
		/*	distance to go */
		distance = pPathGenerator->setPosition - pPathGenerator->outputPosition;

		/*	compute required deceleration ramp */
		if (distance != 0)
		{
			requiredDeceleration = ABS(((long long)pPathGenerator->outputSpeed*pPathGenerator->outputSpeed)/(2*distance));
		}
		else
		{
			requiredDeceleration = 0;
		}

		/*	must decelerate? */
		if (requiredDeceleration >= pPathGenerator->deceleration)
		{
			pSpeedRamping->setSpeed = 0;
			pSpeedRamping->acceleration = pPathGenerator->acceleration;
			pSpeedRamping->deceleration = requiredDeceleration;
		}
		else
		{
			/*	compute speed */
			if (distance > 0)
			{
				/*	go in positive direction */
				pSpeedRamping->setSpeed = ABS(pPathGenerator->setSpeed);
				pSpeedRamping->acceleration = pPathGenerator->acceleration;
				pSpeedRamping->deceleration = pPathGenerator->deceleration;
			}
			else if (distance < 0)
			{
				/*	go in negative direction */
				pSpeedRamping->setSpeed = -ABS(pPathGenerator->setSpeed);
				pSpeedRamping->acceleration = pPathGenerator->acceleration;
				pSpeedRamping->deceleration = pPathGenerator->deceleration;
			}
			else
			{
				/*	stop movement */
				pSpeedRamping->setSpeed = 0;
				pSpeedRamping->acceleration = pPathGenerator->acceleration;
				pSpeedRamping->deceleration = pPathGenerator->deceleration;
			}
		}

		/*	call speed ramping FUB */
		SpeedRamping(pSpeedRamping);

		/*	distance to go */
		distance2 = pPathGenerator->setPosition - pSpeedRamping->actualPosition;

		/*	detect if target position was reached */
		if ((distance > 0 && distance2 <= 0) || (distance < 0 && distance2 >=0))
		{
			SpeedRampingSetPosition(pSpeedRamping, pPathGenerator->setPosition);
			SpeedRampingSetSpeed(pSpeedRamping, 0);
		}
	}
	/* MOVE_VELOCITY */
	else if (pPathGenerator->moveCommand == MOVE_COMMAND_VELOCITY)
	{
		pSpeedRamping->setSpeed = pPathGenerator->setSpeed;
		pSpeedRamping->acceleration = pPathGenerator->acceleration;
		pSpeedRamping->deceleration = pPathGenerator->deceleration;

		/*	call speed ramping FUB */
		SpeedRamping(pSpeedRamping);
	}
	/* MOVE_STOP */
	else if (pPathGenerator->moveCommand == MOVE_COMMAND_STOP)
	{
		/*	must decelerate */
		pSpeedRamping->setSpeed = 0;
		pSpeedRamping->acceleration = pPathGenerator->acceleration;
		pSpeedRamping->deceleration = pPathGenerator->deceleration;

		/*	call speed ramping FUB */
		SpeedRamping(pSpeedRamping);
	}

	/*	copy actual position and speed */
	pPathGenerator->outputPosition = pSpeedRamping->actualPosition;
	pPathGenerator->outputSpeed = pSpeedRamping->actualSpeed;

	/*	copy motion state */
	if (pSpeedRamping->motionState == MOTION_STATE_CONSTANT_SPEED && pSpeedRamping->actualSpeed == 0)
	{
		/*	MOTION_STATE_STANDSTILL is a special case of MOTION_STATE_CONSTANT_SPEED */
		pPathGenerator->motionState = MOTION_STATE_STANDSTILL;
	}
	else
	{
		pPathGenerator->motionState = pSpeedRamping->motionState;
	}
}

/*	This function initializes PathGenerator */
void PathGeneratorInitialize(Motorky_PathGenerator *pPathGenerator, REAL taskTime)
{
	SpeedRampingInitialize(&pPathGenerator->speedRamping, ConvertTime(taskTime));
}

/*	This function resets error in PathGenerator */
void PathGeneratorResetError(Motorky_PathGenerator *pPathGenerator)
{
	pPathGenerator->status = 0;
}

/*	This function sets internal position to desired value */
void PathGeneratorSetPosition(Motorky_PathGenerator *pPathGenerator, DINT position)
{
	pPathGenerator->setPosition = position;
	SpeedRampingSetPosition(&pPathGenerator->speedRamping, position);
	pPathGenerator->outputPosition = position;
}


