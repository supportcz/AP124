
FUNCTION_BLOCK DoorLogic
	VAR_INPUT
		ButtonToOpen : BOOL;
		ButtonToClose : BOOL;
		PermissionToOpen : BOOL;
	END_VAR
	VAR_OUTPUT
		UnlockDoors : BOOL;
		LED : BOOL;
	END_VAR
END_FUNCTION_BLOCK
