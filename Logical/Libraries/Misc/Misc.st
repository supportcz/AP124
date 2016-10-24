FUNCTION_BLOCK DoorLogic
	IF ButtonToOpen THEN
		UnlockDoors := TRUE;
		LED := TRUE;
	END_IF
	
	IF ButtonToClose THEN
		UnlockDoors := FALSE;
		LED := FALSE;
	END_IF
	
END_FUNCTION_BLOCK