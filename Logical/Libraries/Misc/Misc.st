FUNCTION_BLOCK DoorLogic
	
	CASE stateDoor OF
		
		stateDoorLocked:
			
			stopRequest := FALSE;
			
			IF buttonToOpen THEN
				stateDoor := stateDoorStopRequest;
			END_IF
	
			LED := FALSE;
			unlockDoors := FALSE;

		stateDoorStopRequest:
		
			stopRequest := TRUE;
			
			IF modeZone <> modeZoneAuto THEN
				stateDoor := stateDoorUnlocked;
			END_IF
			
			
			LED := TRUE;
			unlockDoors := FALSE;
			
		
		stateDoorUnlocked:
			
			IF buttonToClose THEN
				stateDoor := stateDoorLocked;
			END_IF

			MTBasicsPWM_0(Enable := 1, DutyCycle := 50, Period := 1);
			
			LED := MTBasicsPWM_0.Out;
			unlockDoors := TRUE;
			
	END_CASE
	
END_FUNCTION_BLOCK