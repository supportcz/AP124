
TYPE
	StateConveyor : 
		(
		stateConveyorEmpty,
		stateConveyorReady,
		stateConveyorMoving
		);
	StateMagazine : 
		(
		stateMagazineUndefined,
		stateMoveToUpperPosition,
		stateUpperPosition,
		stateMoveUpperToMiddlePosition,
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
