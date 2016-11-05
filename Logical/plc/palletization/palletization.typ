
TYPE
	RobotData : 	STRUCT 
		start : BOOL;
		layer : INT;
		placeFirstHalf : BOOL;
		placeSecondHalf : BOOL;
		placeSaparator : BOOL;
		placeSeparatorOnTop : BOOL;
	END_STRUCT;
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
		stateRobotAutoGoHome,
		stateRobotAutoGoHome2,
		stateRobotAutoPrepareHead,
		stateRobotAutoPrepareHead2,
		stateRobotAutoGoToTable,
		stateRobotAutoGoToTable2,
		stateRobotAutoWaitForBottles,
		stateRobotAutoRailingDown,
		stateRobotAutoCenteringForward,
		stateRobotAutoSeparator,
		stateRobotAutoSeparator2,
		stateRobotAutoSeparator3,
		stateRobotAutoSeparator4,
		stateRobotAutoSeparator5,
		stateRobotAutoSeparator6,
		stateRobotAutoSeparator7,
		stateRobotAutoPlaceFirstHalf,
		stateRobotAutoPlaceFirstHalf2,
		stateRobotAutoPlaceFirstHalf3,
		stateRobotAutoPlaceFirstHalf4,
		stateRobotAutoPlaceFirstHalf5,
		stateRobotAutoPlaceFirstHalf6,
		stateRobotAutoPlaceFirstHalf7,
		stateRobotAutoPlaceFirstHalf8
		);
	StateInterlayerAuto : 
		(
		stateInterlayerAutoInit,
		stateInterlayerAutoFill,
		stateInterlayerAutoEmpty
		);
	StateRoller : 
		(
		stateRollerInit,
		stateRollerOpening,
		stateRollerOpened,
		stateRollerClosing,
		stateRollerClosed
		);
	StateCentering : 
		(
		stateCenteringInit,
		stateCenteringMovingForward,
		stateCenteringForward,
		stateCenteringMovingBack,
		stateCenteringBack
		);
	StateRailing : 
		(
		stateRailingInit,
		stateRailingMovingUp,
		stateRailingUp,
		stateRailingMovingDown,
		stateRailingDown
		);
	StateSuckers : 
		(
		stateSuckersInit,
		stateSuckersMovingForward,
		stateSuckersForward,
		stateSuckersMovingBack,
		stateSuckersBack
		);
END_TYPE
