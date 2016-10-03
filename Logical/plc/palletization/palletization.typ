
TYPE
	PusherDrive : 	STRUCT 
		cmdAbsolute : BOOL;
		cmdJogPlus : BOOL;
		cmdJogMinus : BOOL;
		positions : ARRAY[0..4]OF DINT;
		speed : DINT;
		selectedPosition : USINT;
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
