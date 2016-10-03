	if (/*pIntern->step >= 100 && */pIntern->step < 1000)
	{
		/* check if drive is ready */
		if (p->info.powerOn && pIOMapping->DriveReady == 0)
		{
			p->info.status = ERR_DRIVE_NOT_READY;
		}

		#ifdef ENCODER_POSITION
			/*	check lag error */
			if (p->info.powerOn && ABS(p->info.lagError) > p->init.maxLagError)
			{
				p->info.status = ERR_LAG_ERROR;
			}
		#endif

		/*	check limit switches, but not in homing steps */
		if(pIntern->step < 200 || pIntern->step >= 300)
		{
			/*	if negative limit switch is closed */
			if (p->IOMapping.negativeLimitSwitch == 1)
			{
				/*	and we go in negative direction */
				if (pPathGenerator->outputSpeed < 0)
				{
					p->info.status = ERR_NEGATIVE_LIMIT_SWITCH_CLOSED;
				}
			}
			
			/*	if positive switch is closed */
			if (p->IOMapping.positiveLimitSwitch == 1)
			{
				/*	and we go in positive direction */
				if (pPathGenerator->outputSpeed > 0)
				{
					p->info.status = ERR_POSITIVE_LIMIT_SWITCH_CLOSED;
				}
			}
		}
		
		/*	check error from path generator */	
		if (pPathGenerator->status == ERR_POSITIVE_SW_LIMIT_REACHED && pPathGenerator->motionState == MOTION_STATE_STANDSTILL)
		{
			p->info.status = ERR_POSITIVE_SW_LIMIT_REACHED;
		}
							
		if (pPathGenerator->status == ERR_NEGATIVE_SW_LIMIT_REACHED && pPathGenerator->motionState == MOTION_STATE_STANDSTILL)
		{
			p->info.status = ERR_NEGATIVE_SW_LIMIT_REACHED;
		}					
			
		if 	(p->info.status != 0)
		{
			/*	new error */
			pIntern->oldStep = pIntern->step;
			/*	go to error step */
			pIntern->step = 1000;
		}
		else
		{
			/*	acknowledge pressed and there is no error, reset request */
			if (p->cmd.acknowledge)
			{
				p->cmd.acknowledge = 0;
			}

			/*	stop pressed? */
			if (p->cmd.stop == 1 || p->cmd.power == 0)  
			{
				/*	if moving, go to stop step */
				if (pPathGenerator->motionState != MOTION_STATE_STANDSTILL)
				{
					pIntern->step = 180;
				}
			
				/*	clear all commands, except of cmd.power */
				if (p->cmd.stop == 1) p->cmd.homing = 0;
				p->cmd.absolute = 0;
				p->cmd.additive = 0;
				p->cmd.cyclicPosition = 0;
				p->cmd.velocity = 0;
				p->cmd.acknowledge = 0;
				p->cmd.stop = 0;
			}
		}
	}
