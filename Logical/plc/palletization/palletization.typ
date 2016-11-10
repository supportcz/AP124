
TYPE
	RobotData : 	STRUCT 
		layer : INT;
		placeFirstHalf : BOOL;
		placeSeparator : BOOL;
		placeSeparatorAbove : BOOL;
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
		stateRobotAutoSeparator4,
		stateRobotAutoSeparator5,
		stateRobotAutoSeparator6,
		stateRobotAutoHideSuckers,
		stateRobotAutoHideSuckers2,
		stateRobotAutoWaitForPallet,
		stateRobotAutoPlaceFirstHalf,
		stateRobotAutoPlaceFirstHalf2,
		stateRobotAutoPlaceFirstHalf3,
		stateRobotAutoPlaceFirstHalf4,
		stateRobotAutoPlaceSecondHalf,
		stateRobotAutoPlaceSecondHalf2,
		stateRobotAutoPlaceSecondHalf3,
		stateRobotAutoPlaceSecondHalf4,
		stateRobotAutoPlaceSecondHalf5,
		stateRobotAutoPlaceSecondHalf6,
		stateRobotAutoSeparatorAbove
		);
	StateInterlayerAuto : 
		(
		stateInterlayerAutoInit,
		stateInterlayerAutoGoDown,
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
