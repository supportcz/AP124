
FUNCTION_BLOCK DoorLogic
	VAR_INPUT
		buttonToOpen : BOOL;
		buttonToClose : BOOL;
		modeZone : ModeZone;
		doorLocked : BOOL;
	END_VAR
	VAR_OUTPUT
		unlockDoors : BOOL;
		LED : BOOL;
		stopRequest : BOOL;
	END_VAR
	VAR
		stateDoor : StateDoor;
		MTBasicsPWM_0 : MTBasicsPWM;
	END_VAR
END_FUNCTION_BLOCK
