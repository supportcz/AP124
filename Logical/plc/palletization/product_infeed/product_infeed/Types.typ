
TYPE
	AutomatMode : 
		(
		automatModeInit,
		automatModeParking,
		automatModeRun
		);
	StateAuto : 
		(
		stateAutoInit,
		stateAutoPusherToBasic,
		stateAutoPusherLiftingDown,
		stateAutoFillRow,
		stateAutoLastTray,
		stateAutoPusherToTable,
		stateAutoPusherToTable2,
		stateAutoPusherLiftingUp,
		stateAutoPusherToRobotHead,
		stateAutoPusherToRobotHead2,
		stateAutoPusherToRobotHead3,
		stateAutoPusherToRobotHead4,
		stateAutoPusherToRobotHead5
		);
	StateBumper : 
		(
		stateBumperUndefined,
		stateBumperMovingForward,
		stateBumperForward,
		stateBumperMovingBack,
		stateBumperBack
		);
	StateConveyor : 
		(
		stateConveyorStop,
		stateConveyorWait,
		stateConveyorMoving,
		stateConveyorPause,
		stateConveyorWaitForRotation,
		stateConveyorMoveTrayFromP1toP2,
		stateConveyorDelayForTurn,
		stateConveyorFillP1
		);
	StatePusherLifting : 
		(
		statePusherLiftingUndefined,
		stateMoveToUpperPosition,
		stateUpperPosition,
		stateMoveToLowerPosition,
		stateLowerPosition
		);
	StateRotation : 
		(
		stateRotationUndefined,
		stateRotationMovingForward,
		stateRotationForward,
		stateRotationMovingBack,
		stateRotationBack
		);
	StateInterlayer : 
		(
		stateInterlayerInit,
		stateInterlayerDown,
		stateInterlayerGoUp,
		stateInterlayerUp,
		stateInterlayerGoDown,
		stateInterlayerGoDown2
		);
END_TYPE
