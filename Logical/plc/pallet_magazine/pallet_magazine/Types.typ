
TYPE
	MagazineState : 
		(
		stateInit,
		stateMoveToUpperPosition,
		stateUpperPosition,
		stateMoveToMiddlePosition,
		stateMiddlePosition,
		stateMoveToLowerPosition,
		stateLowerPosition
		);
	ArmsState : 
		(
		stateInit1,
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
