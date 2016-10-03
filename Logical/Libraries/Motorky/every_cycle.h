/***********************************************************************************************
	THINGS TO DO EVERY CYCLE
************************************************************************************************/
	if (!p->info.initialized) return;

/***********************************************************************************************
	PATH GENERATOR
************************************************************************************************/
	PathGenerator(pPathGenerator);

/***********************************************************************************************
	ACTUAL POSITION, LAG ERROR
************************************************************************************************/
#ifdef ENCODER_USED
	p->info.position = ConvertPosition(pEncoder2units, ENCODER_POSITION);
	p->info.lagError = pPathGenerator->outputPosition - p->info.position;
#else
	p->info.position = pPathGenerator->outputPosition;
#endif

/***********************************************************************************************
	ACTUAL SPEED
************************************************************************************************/
#ifdef ENCODER_USED
	pActualSpeed->actPosition = p->info.position;
	ActualSpeed(pActualSpeed);
	p->info.speed = pActualSpeed->actSpeed;
#else
	p->info.speed = pPathGenerator->outputSpeed;
#endif


/***********************************************************************************************
	FOR HOMING
************************************************************************************************/
	pIntern->oldReferenceSwitch = p->IOMapping.referenceSwitch;
	
/***********************************************************************************************
	DETERMINE MoveActive
************************************************************************************************/
	pMoveActive->motionState = pPathGenerator->motionState;
	MoveActive(pMoveActive);
	p->info.moveActive = pMoveActive->moveActive;

/***********************************************************************************************
	Set DriveEnable
************************************************************************************************/
	pIOMapping->DriveEnable = p->info.powerOn;

