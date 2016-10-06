
TYPE
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
		stateConveyorFillUp,
		stateConveyorPause
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
		stateAutoRunConveyors,
		stateAutoWaitForFirstTray,
		stateAutoFillARow,
		stateAutoLastTray,
		stateAutoLastTray2,
		stateAutoPusherToTable,
		stateAutoPusherToTable2,
		stateAutoPusherLiftingUp,
		stateAutoPusherLiftingUp2,
		stateAutoPusherToBasic,
		stateAutoPusherToBasic2,
		stateAutoPusherLiftingDown,
		stateAutoPusherLiftingDown2
		);
END_TYPE
