/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: Motorky
 * File: speed_ramping.h
 * Author: vancurar
 * Created: June 29, 2008
 *******************************************************************/

#include <bur/plctypes.h>

void SpeedRamping(Motorky_SpeedRamping *pSpeedRamping);

void SpeedRampingInitialize(Motorky_SpeedRamping *pSpeedRamping, DINT taskTime);

void SpeedRampingSetPosition(Motorky_SpeedRamping *pSpeedRamping, DINT position);

void SpeedRampingSetSpeed(Motorky_SpeedRamping *pSpeedRamping, DINT speed);

#define ABS(c)		(((c) >= 0) ? (c) : -(c))
