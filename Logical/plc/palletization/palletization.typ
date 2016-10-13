
TYPE
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
		driveError : BOOL;
		encoderError : BOOL;
	END_STRUCT;
	ModePalletization : 
		(
		modePalletizationNotReadyToStart,
		modePalletizationManual,
		modePalletizationAuto
		);
END_TYPE
