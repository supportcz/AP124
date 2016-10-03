/***********************************************************************************************
	INITIALIZATION STATE
***********************************************************************************************/
case 10:
		/*	default initialization */
		if (p->init.units < 1) p->init.units = 1;
		
		if (p->init.taskTime <= 0 || p->init.taskTime >= 1)
		{
			p->info.status = ERR_WRONG_TASK_TIME;
			return;			
		}
		
		if (p->init.settleTime == 0) p->init.settleTime = 0;

		
		if (p->param.position == 0) p->param.position = 1000;		
		if (p->param.speed == 0) p->param.speed = DEFAULT_SPEED;		
		if (p->param.acceleration == 0) p->param.acceleration = DEFAULT_ACCELERATION;		
		if (p->param.deceleration == 0) p->param.deceleration = DEFAULT_ACCELERATION;	

		if (p->param.homing.speed2 == 0) p->param.homing.speed2 = p->param.speed;		
			
		/*	initialize path generator */
		PathGeneratorInitialize(pPathGenerator, p->init.taskTime);

		#ifdef ENCODER_USED
			/*	default initialization */
			if (p->init.maxLagError == 0) p->init.maxLagError = 1000;
			if (p->init.Kp == 0) p->init.Kp = 1;
			/*if (p->init.Tn == 0) p->init.Tn = 0;*/

			if (p->init.encoderIncrements == 0)
			{
				p->info.status = ERR_WRONG_ENCODER_INCREMENTS;
				return;			
			}
			/*	initialize conversion */
			ConvertPositionInitialize(pEncoder2units,p->init.encoderIncrements,p->init.units,p->init.reverseDirection,
				ENCODER_POSITION,p->info.position);
		
			ActualSpeedInitialize(pActualSpeed, p->init.taskTime, p->init.speedFilter);

		#else
			if (p->init.microsteps == 0) p->init.microsteps = 200*256;
		#endif

		#ifdef SPEED_PID_USED
			if (p->init.speedKp == 0) p->init.speedKp = 0.01;
			/*if (p->init.speedTn == 0) p->init.speedTn = 0;*/
		#endif

		MoveActiveInitialize(pMoveActive, p->init.taskTime, p->init.settleTime);
	
		RESET_OUTPUT
	
		p->info.initialized = 1;
		pIntern->step = 100;
		

/***********************************************************************************************
	COMMAND STATE
***********************************************************************************************/
	case 100:
		if (p->cmd.power && !p->info.powerOn)
		{
			/*	switch power on */
			pIntern->step = 110;
		}

		if (!p->cmd.power && p->info.powerOn)
		{
			/*	switch power off */
			pIntern->step = 120;
		}

		if (p->cmd.homing)
		{
			pIntern->step = 200;
			goto L_200;
		}

		if (p->cmd.absolute)
		{
			pIntern->step = 140;
			goto L_140;
		}

		if (p->cmd.additive)
		{
			pIntern->step = 150;
			goto L_150;
		}

		if (p->cmd.cyclicPosition)
		{
			pIntern->step = 160;
			goto L_160;
		}

		if (p->cmd.velocity)
		{
			pIntern->step = 170;
			goto L_170;
		}
		break;
	
/***********************************************************************************************
	SWITCH CONTROLLER ON
***********************************************************************************************/
	case 110:
		/*	switch on output */
		p->info.powerOn = 1;

		/*	set intern position inside path generator to actual position */
		PathGeneratorSetPosition(pPathGenerator, p->info.position);

		#ifdef ENCODER_USED
			/*	intialize speed filter */
			ActualSpeedInitialize(pActualSpeed, p->init.taskTime, p->init.speedFilter);

			/*	initialize PID */
			#ifdef SPEED_PID_USED
				PIDInitialize(pPID, p->init.Kp, p->init.Tn, p->init.taskTime, DINT_MAXVALUE, -DINT_MAXVALUE);
				PIDInitialize(pSpeedPID, p->init.speedKp, p->init.speedTn, p->init.taskTime, INT_MAXVALUE, -INT_MAXVALUE);
			#else
				PIDInitialize(pPID, p->init.Kp, p->init.Tn, p->init.taskTime, INT_MAXVALUE, -INT_MAXVALUE);
			#endif
		#endif


		pIntern->step = 100;
		break;
		
/***********************************************************************************************
	SWITCH CONTROLLER OFF
************************************************************************************************/
	case 120:

		p->info.powerOn = 0;
		pIntern->step = 100;
		break;

/***********************************************************************************************
	ABSOLUTE MOVE
************************************************************************************************/
	case 140:
L_140:	
		/*	prepare data for path generator */
		pPathGenerator->moveCommand = MOVE_COMMAND_ABSOLUTE;
		pPathGenerator->setPosition = p->param.position;
		pPathGenerator->setSpeed = p->param.speed;
		pPathGenerator->acceleration = p->param.acceleration;
		pPathGenerator->deceleration = p->param.deceleration;
		pPathGenerator->positiveSwLimit = p->init.positiveSwLimit;
		pPathGenerator->negativeSwLimit = p->init.negativeSwLimit;

		/*	clear flag */
		p->cmd.absolute = 0;		
		pIntern->step = 100;
		break;
	
/***********************************************************************************************
	ADDITIVE MOVE
************************************************************************************************/
	case 150:
L_150:	
		/*	prepare data for path generator */
		pPathGenerator->moveCommand = MOVE_COMMAND_ABSOLUTE;
		pPathGenerator->setPosition = pPathGenerator->outputPosition + p->param.position;
		pPathGenerator->setSpeed = p->param.speed;
		pPathGenerator->acceleration = p->param.acceleration;
		pPathGenerator->deceleration = p->param.deceleration;
		pPathGenerator->positiveSwLimit = p->init.positiveSwLimit;
		pPathGenerator->negativeSwLimit = p->init.negativeSwLimit;

		/*	clear flag */
		p->cmd.additive = 0;
		pIntern->step = 100;
		break;
		
/***********************************************************************************************
	POSITION MOVEMENT
************************************************************************************************/
	case 160:
L_160:	
		pPathGenerator->moveCommand = MOVE_COMMAND_ABSOLUTE;
		pPathGenerator->setPosition = p->param.position;
		pPathGenerator->setSpeed = p->param.speed;
		pPathGenerator->acceleration = p->param.acceleration;
		pPathGenerator->deceleration = p->param.deceleration;
		pPathGenerator->positiveSwLimit = p->init.positiveSwLimit;
		pPathGenerator->negativeSwLimit = p->init.negativeSwLimit;

		/*	attempt to stop? */		
		if (p->cmd.cyclicPosition == 0)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
			pIntern->step=100;
		}
		break;	

/***********************************************************************************************
	VELOCITY MOVEMENT
************************************************************************************************/
	case 170:
L_170:	
		pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
		pPathGenerator->setSpeed = p->param.speed;
		pPathGenerator->acceleration = p->param.acceleration;
		pPathGenerator->deceleration = p->param.deceleration;
		pPathGenerator->positiveSwLimit = p->init.positiveSwLimit;
		pPathGenerator->negativeSwLimit = p->init.negativeSwLimit;

		/*	attempt to stop? */
		if (p->cmd.velocity == 0)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
			pIntern->step = 100;
		}
		break;	
	
/***********************************************************************************************
	STOP MOVEMENT
************************************************************************************************/
	case 180:
		pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
		pPathGenerator->deceleration = p->param.deceleration;

		/*	wait till movement stopped */		
		if (pPathGenerator->motionState == MOTION_STATE_STANDSTILL)
		{
			pIntern->step=100;
		}
		break;

/***********************************************************************************************
	HOMING STATES
************************************************************************************************/
	case 200:
L_200:
		/*	reset flag */
		p->info.homingOk = 0;

		/*	set acceleration and deceleration */
		pPathGenerator->acceleration = p->param.acceleration;
		pPathGenerator->deceleration = p->param.deceleration;

		/*	set SW limits */
		pPathGenerator->positiveSwLimit = 0;
		pPathGenerator->negativeSwLimit = 0;

		/*	which homing mode */
		if (p->param.homing.mode == HOMING_DIRECT)
		{
			pIntern->step = 260;
		}
		else if (p->param.homing.mode == HOMING_END_SWITCH)
		{
			pIntern->step = 220;
		}
		else if (p->param.homing.mode == HOMING_REF_SWITCH)
		{
			pIntern->step = 240;
		}
		break;
		
/***********************************************************************************************
	HOMING_END_SWITCH
************************************************************************************************/
	case 220:
	
		/*	fast movement off positive HW end */
		if (p->IOMapping.positiveLimitSwitch)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = -ABS(p->param.speed);
			break;
		}

		/*	fast movement off negative HW end */
		if (p->IOMapping.negativeLimitSwitch)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = ABS(p->param.speed);
			break;
		}

		/*	fast movement to positive HW end */
		if (p->param.homing.edgeSwitch == DIRECTION_POSITIVE)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = ABS(p->param.speed);
			pIntern->step = 221;
			break;
		}
		
		/*	fast movement to negative HW end */
		if (p->param.homing.edgeSwitch == DIRECTION_NEGATIVE)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = -ABS(p->param.speed);
			pIntern->step = 224;
			break;
		}
		break;
	
	case 221:
		
		/*	turn when positive limit switch reached */
		if (p->IOMapping.positiveLimitSwitch)
		{
			/*	slow movement out off positive HW end */
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = -ABS(p->param.homing.speed2);
			pIntern->step++;
		}
		break;

	case 222:

		if (p->IOMapping.positiveLimitSwitch ==0)
		{
			if (p->param.homing.triggerDirection == DIRECTION_NEGATIVE)
			{
				/*	finished */
				pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
				pPathGenerator->deceleration = p->param.deceleration;
				pIntern->step = 250;
			}
			else
			{
				/*	change direction */
				pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
				pPathGenerator->setSpeed = ABS(p->param.homing.speed2);
				pIntern->step++;
			}
		}
		break;
		
	case 223:

		if (p->IOMapping.positiveLimitSwitch == 1)
		{
			/*	finished */
			pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
			pPathGenerator->deceleration = p->param.deceleration;
			pIntern->step = 250;
		}
		break;
		
	case 224:
	
		/*	turn when negative limit switch reached */
		if (p->IOMapping.negativeLimitSwitch)
		{
			/*	slow movement out off negative HW end */
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = ABS(p->param.homing.speed2);
			pIntern->step++;
		}
		break;
	
	case 225:	
	
		if (p->IOMapping.negativeLimitSwitch == 0)
		{
			if (p->param.homing.triggerDirection == DIRECTION_POSITIVE)
			{
				/*	finished */
				pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
				pPathGenerator->deceleration = p->param.deceleration;
				pIntern->step = 250;
			}
			else
			{
				/*	change direction */
				pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
				pPathGenerator->setSpeed = -ABS(p->param.homing.speed2);
				pIntern->step++;
			}
		}
		break;
	
	case 226:

		if (p->IOMapping.negativeLimitSwitch == 1)
		{
			/*	finished */
			pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
			pPathGenerator->deceleration = p->param.deceleration;
			pIntern->step = 250;
		}
		break;

/***********************************************************************************************
	HOMING_REF_SWITCH
************************************************************************************************/
	case 240:
		
		/*	go with high speed in startDirection */
		if (p->param.homing.startDirection == DIRECTION_POSITIVE)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = ABS(p->param.speed);
		}
		else
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = -ABS(p->param.speed);
		}
		pIntern->step++;
		break;
		
	case 241:
		
		/*	if right limit switch reached, turn direction */
		if (p->IOMapping.positiveLimitSwitch == 1)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = -ABS(p->param.speed);
		}

		/*	if left limit switch reached, turn direction */
		if (p->IOMapping.negativeLimitSwitch == 1)
		{
			pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
			pPathGenerator->setSpeed = ABS(p->param.speed);
		}

		/*	detect positive edge of reference switch */
		if (p->IOMapping.referenceSwitch == 1 && pIntern->oldReferenceSwitch == 0)
		{
			/*	detect positive edge */
			if (pPathGenerator->outputSpeed > 0 && p->param.homing.edgeSwitch == DIRECTION_POSITIVE)
			{
				/*	slow down */
				pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
				pPathGenerator->setSpeed = -ABS(p->param.homing.speed2);
				pIntern->step++;
			}
			
			/*	detect negative edge */
			if (pPathGenerator->outputSpeed < 0 && p->param.homing.edgeSwitch == DIRECTION_NEGATIVE) 
			{
				pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
				pPathGenerator->setSpeed = ABS(p->param.homing.speed2);
				pIntern->step++;
			}
		}

		/*	detect negative edge of reference switch */
		if (p->IOMapping.referenceSwitch == 0 && pIntern->oldReferenceSwitch == 1)
		{
			/*	detect negative edge */
			if (pPathGenerator->outputSpeed < 0)
			{
				if (p->param.homing.edgeSwitch == DIRECTION_POSITIVE)
				{
					pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
					pPathGenerator->setSpeed = ABS(p->param.homing.speed2);
					pIntern->step++;
				}
				else
				{
					/*	turn direction */
					pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
					pPathGenerator->setSpeed = ABS(p->param.speed);
				}
			}
			
			/*	detect positive edge */
			if (pPathGenerator->outputSpeed > 0) 
			{
				if (p->param.homing.edgeSwitch == DIRECTION_NEGATIVE)
				{
					pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
					pPathGenerator->setSpeed = -ABS(p->param.homing.speed2);
					pIntern->step++;
				}
				else
				{
					/*	turn direction */
					pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
					pPathGenerator->setSpeed = -ABS(p->param.speed);
				}
			}
		}
		break;
		
	case 242:
		
		/*	detect positive edge of reference switch */
		if (p->IOMapping.referenceSwitch == 1 && pIntern->oldReferenceSwitch == 0)
		{
			if (pPathGenerator->outputSpeed > 0)
			{
				if (p->param.homing.triggerDirection == DIRECTION_POSITIVE)
				{
					/*	finished */
					pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
					pPathGenerator->deceleration = p->param.deceleration;
					pIntern->step = 250;
				}
				else
				{
					/*	turn direction */
					pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
					pPathGenerator->setSpeed = -ABS(p->param.homing.speed2);
				}
			}
			
			if (pPathGenerator->outputSpeed < 0) 
			{
				if (p->param.homing.triggerDirection == DIRECTION_NEGATIVE)
				{
					/*	finished */
					pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
					pPathGenerator->deceleration = p->param.deceleration;
					pIntern->step = 250;
				}
				else
				{
					/*	turn direction */
					pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
					pPathGenerator->setSpeed = ABS(p->param.homing.speed2);
				}
			}
		}

		/*	detect negative edge of reference switch */
		if (p->IOMapping.referenceSwitch == 0 && pIntern->oldReferenceSwitch == 1)
		{
			if (pPathGenerator->outputSpeed > 0)
			{
				if (p->param.homing.triggerDirection == DIRECTION_POSITIVE)
				{
					/*	finished */
					pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
					pPathGenerator->deceleration = p->param.deceleration;
					pIntern->step = 250;
				}
				else
				{
					/*	turn direction */
					pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
					pPathGenerator->setSpeed = -ABS(p->param.homing.speed2);
				}
			}
			
			if (pPathGenerator->outputSpeed < 0)
			{
				if (p->param.homing.triggerDirection == DIRECTION_NEGATIVE)
				{
					/*	finished */
					pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
					pPathGenerator->deceleration = p->param.deceleration;
					pIntern->step = 250;
				}
				else
				{
					/*	turn direction */
					pPathGenerator->moveCommand = MOVE_COMMAND_VELOCITY;
					pPathGenerator->setSpeed = ABS(p->param.homing.speed2);
				}
			}
		}
		break;

	case 250:
		/*	wait till still */
		if (pPathGenerator->motionState == MOTION_STATE_STANDSTILL) pIntern->step = 260;
		break;

/***********************************************************************************************
	DIRECT_HOMING
************************************************************************************************/
	case 260:

		/*	set intern position inside path generator to actual position */
		PathGeneratorSetPosition(pPathGenerator, p->param.position);
		
		#ifdef ENCODER_POSITION
			ConvertPositionInitialize(pEncoder2units,p->init.encoderIncrements,p->init.units,p->init.reverseDirection,
				ENCODER_POSITION,p->param.position);
		#endif
	
		RESET_OUTPUT

		/*	set flag */
		p->info.homingOk = 1;
		/*	clear flag */
		p->cmd.homing = 0;
		pIntern->step=100;
		break;
		
	case 1000:
		/*	clear all commands, except of cmd.power */
		p->cmd.homing = 0;
		p->cmd.absolute = 0;
		p->cmd.additive = 0;
		p->cmd.cyclicPosition = 0;
		p->cmd.velocity = 0;
		p->cmd.acknowledge = 0;
		p->cmd.stop = 0;

		/*	stop movement */
		pPathGenerator->moveCommand = MOVE_COMMAND_STOP;
		pPathGenerator->deceleration = p->param.deceleration;

		/*	display error message */
		if(p->info.status == ERR_CONTROLLER_OFF)
		{
			strncpy(p->info.errorText,"It is not possible to make any movement because the controller is OFF ",sizeof(p->info.errorText));
		}
		
		if(p->info.status == ERR_WRONG_UNITS)
		{
			strncpy(p->info.errorText,"Value of \"init.units\" must be >= 1000",sizeof(p->info.errorText));
		}

		if(p->info.status == ERR_NEGATIVE_LIMIT_SWITCH_CLOSED)
		{
			strncpy(p->info.errorText,"Negative limit switch was activated",sizeof(p->info.errorText));
		}
		
		if(p->info.status == ERR_NEGATIVE_SW_LIMIT_REACHED)
		{
			strncpy(p->info.errorText,"Negative SW limit was reached",sizeof(p->info.errorText));
		} 
		
		if(p->info.status == ERR_DRIVE_NOT_READY)
		{
			strncpy(p->info.errorText,"Drive is not ready",sizeof(p->info.errorText));
		} 

		if(p->info.status == ERR_OVER_CURRENT)
		{
			strncpy(p->info.errorText,"Motor overcurrent",sizeof(p->info.errorText));
		} 
		
		if(p->info.status == ERR_OVER_TEMPERATURE)
		{
			strncpy(p->info.errorText,"Motor overtemperature",sizeof(p->info.errorText));
		} 
		
		if(p->info.status == ERR_POSITIVE_LIMIT_SWITCH_CLOSED)
		{
			strncpy(p->info.errorText,"Positive limit switch was activated",sizeof(p->info.errorText));
		}
		
		if(p->info.status == ERR_POSITIVE_SW_LIMIT_REACHED)
		{
			strncpy(p->info.errorText,"Positive SW limit was reached",sizeof(p->info.errorText));
		} 
		
		if(p->info.status == ERR_STALL)
		{
			strncpy(p->info.errorText,"Stall detected",sizeof(p->info.errorText));
		} 
		
		if(p->info.status == ERR_POWER_SUPPLY_ERROR)
		{
			strncpy(p->info.errorText,"Power supply problem",sizeof(p->info.errorText));
		} 

		if(p->info.status == ERR_UNDER_VOLTAGE)
		{
			strncpy(p->info.errorText,"Low supply voltage",sizeof(p->info.errorText));
		} 
		
		if(p->info.status == ERR_OVER_VOLTAGE)
		{
			strncpy(p->info.errorText,"High supply voltage",sizeof(p->info.errorText));
		} 

		if(p->info.status == ERR_LAG_ERROR)
		{
			strncpy(p->info.errorText,"Lag error exceeded \"init.maxLagError\"",sizeof(p->info.errorText));
		} 
		
		if(p->info.status == ERR_ENCODER_SUPPLY)
		{
			strncpy(p->info.errorText,"Encoder supply error",sizeof(p->info.errorText));
		} 
		
		if(p->info.status == ERR_WRONG_TASK_TIME)
		{
			strncpy(p->info.errorText,"Value of \"init.taskTime\" must be between 0 and 1 sec" ,sizeof(p->info.errorText));
		}
		
		if(p->info.status == ERR_LOW_DC_BUS_VOLTAGE)
		{
			strncpy(p->info.errorText,"Low DC BUS voltage",sizeof(p->info.errorText));
		} 

		if(p->info.status == ERR_WRONG_ENCODER_INCREMENTS)
		{
			strncpy(p->info.errorText,"Value of \"init.encoderIncrements\" must be > 0",sizeof(p->info.errorText));
		} 

		if(p->info.status == ERR_DRV_NOT_OK)
		{
			strncpy(p->info.errorText,"\"DrvOk\" must be \"TRUE\"",sizeof(p->info.errorText));
		} 
		pIntern->step++;
		break;
	
	case 1001:
		/*	wait till movement stopped */		
		if (p->info.moveActive == 0)
		{
			pIntern->step++;
		}
		break;


		pIntern->step++;
		break;
	
	case 1002:
		/*	if controller should be switched off */
		if	(p->cmd.power == 0 || p->info.status == ERR_OVER_TEMPERATURE || p->info.status == ERR_OVER_CURRENT ||
			p->info.status == ERR_LAG_ERROR || p->info.status == ERR_STALL)
		{
			/*	switch controller off */
			p->info.powerOn = 0;	
		}

		/*	wait for acknowledgement */
		if (p->cmd.acknowledge)
		{
			pIntern->step++;
		}
		break;	

	case 1003:

		/*	acknowledge error form path generator */
		PathGeneratorResetError(pPathGenerator);
		
		/*	clear commands */
		p->cmd.acknowledge = 0;
		//p->info.status = 0;
		strcpy(p->info.errorText,"");
		
		pIntern->step = 1010;
		break;
		


