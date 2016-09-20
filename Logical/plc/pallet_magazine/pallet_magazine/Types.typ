
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
		stateAutoMoveToUpperPosition,
		stateAutoDetectPalletOnConveyor
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
END_TYPE
