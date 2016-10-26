
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
	END_STRUCT;
	StatePallet : 
		(
		palletNotPresent,
		palletPresent,
		palletMoving
		);
END_TYPE
