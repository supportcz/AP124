
FUNCTION_BLOCK DoorLogic
	VAR_INPUT
		diOpenButton : BOOL;
		diCloseButton : BOOL;
		modeZone : ModeZone;
		diDoorLocked : BOOL;
	END_VAR
	VAR_OUTPUT
		doUnlockDoors : BOOL;
		doLED : BOOL;
		stopRequest : BOOL;
	END_VAR
	VAR
		stateDoor : StateDoor;
		MTBasicsPWM_0 : MTBasicsPWM;
	END_VAR
END_FUNCTION_BLOCK
