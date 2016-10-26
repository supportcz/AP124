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