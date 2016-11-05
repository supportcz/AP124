FUNCTION_BLOCK DoorLogic
	
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

FUNCTION_BLOCK MakeMove
	
	moveActive := RawInput.0;
	IsItSafeToGoHome := RawInput.1;
	checkMoveType := UDINT_TO_USINT(SHR(RawInput, 8));
	checkProductType := UDINT_TO_USINT(SHR(RawInput, 16));
	checkNbOfLayers	:= UDINT_TO_USINT(SHR(RawInput, 24));


	IF NOT Execute THEN
		state := 0;
		Done := FALSE;
		startMove := FALSE;
	END_IF
	
	CASE state OF
		0:
			IF Execute THEN
				state := state + 1;
			END_IF
		
		1:
			IF MoveType = checkMoveType AND ProductType = checkProductType AND NbOfLayers = checkNbOfLayers THEN
				startMove := TRUE;
				state := state + 1;
			END_IF
		
		2:
			IF moveActive THEN
				startMove := FALSE;
				state := state + 1;
			END_IF
				
		3:	
			IF NOT moveActive THEN
				Done := TRUE;
				state := state + 1;
			END_IF
		
		4:

		
	END_CASE;
	
	tmpRawOutput := 0;
	tmpRawOutput.0 := startMove;
	tmpRawOutput := tmpRawOutput OR SHL(DINT_TO_UDINT(MoveType),8);
	tmpRawOutput := tmpRawOutput OR SHL(USINT_TO_UDINT(ProductType),16);
	tmpRawOutput := tmpRawOutput OR SHL(USINT_TO_UDINT(NbOfLayers),24);
	
	RawOutput := tmpRawOutput;
	
END_FUNCTION_BLOCK