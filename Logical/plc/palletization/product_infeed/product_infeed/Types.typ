
TYPE
	StateBumper : 
		(
		stateBumperUndefined,
		stateBumperMovingForward,
		stateBumperForward,
		stateBumperMovingBack,
		stateBumperBack
		);
	StateRotation : 
		(
		stateRotationUndefined,
		stateRotationMovingForward,
		stateRotationForward,
		stateRotationMovingBack,
		stateRotationBack
		);
	StateConveyor : 
		(
		stateConveyorStop,
		stateConveyorWait,
		stateConveyorMoving,
		stateConveyorPause,
		stateConveyorNewTray,
		stateConveyorNewTray2,
		stateConveyorNewTray3,
		stateConveyorNewTray4
		);
	StatePusherLifting : 
		(
		statePusherLiftingUndefined,
		stateMoveToUpperPosition,
		stateUpperPosition,
		stateMoveToLowerPosition,
		stateLowerPosition
		);
	StateAuto : 
		(
		stateAutoUndefined,
		stateAutoStart,
		stateAutoWaitForNextTray,
		stateAutoLastTray,
		stateAutoPusherToTable,
		stateAutoPusherToTable2,
		stateAutoPusherLiftingUp,
		stateAutoPusherLiftingUp2,
		stateAutoPusherToBasic,
		stateAutoPusherToBasic2,
		stateAutoPusherLiftingDown,
		stateAutoPusherLiftingDown2,
		stateAutoPusherToRobotHead,
		stateAutoPusherToRobotHead2,
		stateAutoPusherToRobotHead3,
		stateAutoPusherToRobotHead4,
		stateAutoPusherToRobotHead5,
		stateAutoPusherToRobotHead6
		);
END_TYPE
