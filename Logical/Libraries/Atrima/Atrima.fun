
FUNCTION_BLOCK MakeMove
	VAR_INPUT
		Execute : BOOL;
		MoveType : MoveType;
		ProductType : USINT;
		NbOfLayers : USINT;
		RawInput : UDINT;
	END_VAR
	VAR_OUTPUT
		Done : BOOL;
		RawOutput : UDINT;
		IsItSafeToGoHome : BOOL;
	END_VAR
	VAR
		moveActive : BOOL;
		checkMoveType : MoveType;
		checkProductType : USINT;
		checkNbOfLayers : USINT;
		startMove : BOOL;
		tmpRawOutput : UDINT;
		state : INT;
	END_VAR
END_FUNCTION_BLOCK

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
