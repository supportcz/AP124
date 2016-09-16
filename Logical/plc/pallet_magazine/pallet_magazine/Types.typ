
TYPE
	StateAuto : 
		(
		stateAutoUndefined,
		stateAutoWaitForNoPallet,
		stateAutoMoveToLowerPosition,
		stateAutoWaitForLowerPosition,
		stateAutoOpenArms,
		stateAutoWaitForOpenedArms,
		stateAutoMoveToMiddlePosition,
		stateAutoWaitForMiddlePosition,
		stateAutoCloseArms,
		stateAutoWaitForClosedArms,
		stateAutoMoveToUpperPosition
		);
	StateConveyor : 
		(
		stateConveyorUndefined,
		stateConveyorEmpty,
		stateConveyorOccupied,
		stateConveyorMoving,
		stateConveyorStop
		);
	StateMagazine : 
		(
		stateMagazineUndefined,
		stateMoveToUpperPosition,
		stateUpperPosition,
		stateMoveLowerToMiddlePosition,
		stateMiddlePosition,
		stateMoveToLowerPosition,
		stateLowerPosition
		);
	StateArms : 
		(
		stateArmsUndefined,
		stateArmsOpening,
		stateArmsOpened,
		stateArmsClosing,
		stateArmsClosed
		);
	ModeOfOperation : 
		(
		modeNotReadyToStart,
		modeManual,
		modeAuto
		);
END_TYPE
