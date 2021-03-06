
FUNCTION_BLOCK Comau
		
	//RawInput1
	NoAlarm				:= RawInput1.0;
	DriveOnStatus		:= RawInput1.1;
	Start_NoHoldPrgMove	:= RawInput1.2;
	Remote 				:= RawInput1.3;
	SafetySpeedActive	:= RawInput1.10;
	ProgrammingMode		:= RawInput1.11;
	HeartBit			:= RawInput1.15;

	
	//RawInput2
	moveActive := RawInput2.0;
	IsItSafeToGoHome := RawInput2.1;
	//MoveCheckOk := RawInput2.2;
	checkMoveType := UDINT_TO_USINT(SHR(RawInput2, 8));
	checkProductType := UDINT_TO_USINT(SHR(RawInput2, 16));
	checkNbOfLayers	:= UDINT_TO_USINT(SHR(RawInput2, 24));


	IF NOT MakeMove THEN
		state := 0;
		MoveDone := FALSE;
		startMove := FALSE;
		Error := FALSE;
		ErrorHoldPressed := FALSE;
	END_IF
	
	CASE state OF
		0:
			IF MakeMove THEN
				state := state + 1;
			END_IF
		
		1:
			IF moveActive THEN
				IF MoveType = checkMoveType AND ProductType = checkProductType AND NbOfLayers = checkNbOfLayers THEN
					state := state + 1;
				ELSE
					Error := TRUE;
					state := 5;
				END_IF
			ELSE
				state := state + 1;				
			END_IF

		2:
			MTBasicsPWM_0(Enable :=  TRUE, Period := 1, DutyCycle := 50);
			Start := MTBasicsPWM_0.Out;

			IF Start_NoHoldPrgMove THEN
				Start := FALSE;
				state := state + 1;
			END_IF
		
		3:
			startMove := TRUE;

			IF moveActive THEN
				startMove := FALSE;
				state := state + 1;
			END_IF
				
		4:	
			IF NOT moveActive THEN
				MoveDone := TRUE;
				state := state + 1;
			END_IF
		
			IF NOT Start_NoHoldPrgMove THEN
				ErrorHoldPressed := TRUE;
				state := 5;
			END_IF
		5:

		
	END_CASE;
	
		
	//RawOutput1
	tmpRawOutput := 0;
	tmpRawOutput.0 := DriveOn;
	tmpRawOutput.1 := NoDriveOff;
	tmpRawOutput.2 := Start;
	tmpRawOutput.3 := NoHold;
	tmpRawOutput.8 := CancelAlarm;
	tmpRawOutput.9 := SafetySpeed;
	RawOutput1 := tmpRawOutput;
	
	//RawOutput2
	tmpRawOutput := 0;
	tmpRawOutput.0 := startMove;
	tmpRawOutput.1 := diSensorBellowHead;
	tmpRawOutput := tmpRawOutput OR SHL(DINT_TO_UDINT(MoveType),8);
	tmpRawOutput := tmpRawOutput OR SHL(USINT_TO_UDINT(ProductType),16);
	tmpRawOutput := tmpRawOutput OR SHL(USINT_TO_UDINT(NbOfLayers),24);
	RawOutput2 := tmpRawOutput;
	
	
	
END_FUNCTION_BLOCK
		
FUNCTION_BLOCK DoorLogic
	
	diDoorLocked;
	
	CASE stateDoor OF
		
		stateDoorLocked:
			
			stopRequest := FALSE;
			
			IF diOpenButton THEN
				stateDoor := stateDoorStopRequest;
			END_IF
	
			doLED := FALSE;
			doUnlockDoors := FALSE;

		stateDoorStopRequest:
		
			stopRequest := TRUE;
			
			IF modeZone <> modeZoneAuto THEN
				stateDoor := stateDoorUnlocked;
			END_IF
			
			doLED := TRUE;
			doUnlockDoors := FALSE;
			
		
		stateDoorUnlocked:
			
			IF diCloseButton THEN
				stateDoor := stateDoorLocked;
			END_IF
			
			MTBasicsPWM_0(Enable := 1, DutyCycle := 50, Period := 1);
			
			doLED := MTBasicsPWM_0.Out;
			doUnlockDoors := TRUE;
			
	END_CASE
	
END_FUNCTION_BLOCK
