
TYPE
	PusherDrive : 	STRUCT 
		cmdAbsolute : BOOL;
		cmdJogPlus : BOOL;
		cmdJogMinus : BOOL;
		tolerance : DINT;
		positions : ARRAY[0..5]OF DINT;
		speed : DINT;
		requestedPositionIndex : INT;
		actualPositionIndex : INT;
		actualPosition : DINT;
	END_STRUCT;
	StatePallet : 
		(
		palletNotPresent,
		palletPresent,
		palletMoving
		);
	StateRobotAuto : 
		(
		stateRobotAutoInit,
		stateRobotAutoStart,
		stateRobotAutoStart2,
		stateRobotAutoGoToHome,
		stateRobotAutoGoToHome2,
		stateRobotAutoGoToHome3,
		stateRobotAutoWait
		);
	StateInterlayerAuto : 
		(
		stateInterlayerAutoInit,
		stateInterlayerAutoFill,
		stateInterlayerAutoEmpty
		);
END_TYPE
