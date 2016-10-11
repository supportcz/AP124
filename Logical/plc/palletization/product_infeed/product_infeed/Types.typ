
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
		stateConveyorPause,
		stateConveyorNewTray,
		stateConveyorNewTray2,
		stateConveyorNewTray3
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
		stateAutoWaitForNextTray,
		stateAutoLastTray,
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
