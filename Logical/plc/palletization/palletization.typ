
TYPE
	RobotData : 	STRUCT 
		start : BOOL;
		layer : INT;
		placeFirstHalf : BOOL;
		placeSeparator : BOOL;
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
		stateRobotAutoGoHome,
		stateRobotAutoGoHome2,
		stateRobotAutoPrepareHead,
		stateRobotAutoGoToTable,
		stateRobotAutoWaitForBottles,
		stateRobotAutoRailingDown,
		stateRobotAutoCenteringForward,
		stateRobotAutoSwitch1,
		stateRobotAutoSeparator,
		stateRobotAutoSeparator2,
		stateRobotAutoSeparator3,
		stateRobotAutoHideSuckers,
		stateRobotAutoHideSuckers2,
		stateRobotAutoWhichHalf,
		stateRobotAutoPlaceFirstHalf,
		stateRobotAutoPlaceFirstHalf2,
		stateRobotAutoPlaceFirstHalf3,
		stateRobotAutoPlaceFirstHalf4,
		stateRobotAutoPlaceSecondHalf,
		stateRobotAutoPlaceSecondHalf2,
		stateRobotAutoPlaceSecondHalf3
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
