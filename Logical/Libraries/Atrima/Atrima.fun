
FUNCTION_BLOCK Comau
	VAR_INPUT
		DriveOn : BOOL;
		NoDriveOff : BOOL;
		Start : BOOL;
		NoHold : BOOL;
		CancelAlarm : BOOL;
		SafetySpeed : BOOL;
		MakeMove : BOOL;
		MoveType : MoveType;
		ProductType : USINT;
		NbOfLayers : USINT;
		diSensorBellowHead : BOOL;
		RawInput1 : UDINT;
		RawInput2 : UDINT;
	END_VAR
	VAR_OUTPUT
		NoAlarm : BOOL;
		DriveOnStatus : BOOL;
		Start_NoHoldPrgMove : BOOL;
		Remote : BOOL;
		SafetySpeedActive : BOOL;
		ProgrammingMode : BOOL;
		HeartBit : BOOL;
		MoveDone : BOOL;
		IsItSafeToGoHome : BOOL;
		Error : BOOL;
		RawOutput1 : UDINT;
		RawOutput2 : UDINT;
	END_VAR
	VAR
		moveActive : BOOL;
		checkMoveType : MoveType;
		checkProductType : USINT;
		checkNbOfLayers : USINT;
		startMove : BOOL;
		tmpRawOutput : UDINT;
		state : INT;
		MTBasicsPWM_0 : MTBasicsPWM;
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
