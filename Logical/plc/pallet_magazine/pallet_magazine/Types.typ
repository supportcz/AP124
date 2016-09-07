
TYPE
	MagazineState : 
		(
		stateUndefined,
		stateMoveToUpperPosition,
		stateUpperPosition,
		stateMoveUpperToMiddlePosition,
		stateMoveLowerToMiddlePosition,
		stateMiddlePosition,
		stateMoveToLowerPosition,
		stateLowerPosition
		);
	ArmsState : 
		(
		stateArmsUndefined,
		stateArmsOpening,
		stateArmsOpened,
		stateArmsClosing,
		stateArmsClosed
		);
	ModeOfOperation : 
		(
		notReadyToStart,
		readyToStart,
		automatMode,
		manualMode,
		errorState
		);
END_TYPE
