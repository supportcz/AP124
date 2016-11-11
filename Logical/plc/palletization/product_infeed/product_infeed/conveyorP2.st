
ACTION ConveyorP2: 
	
	TOF_acpI_P10(IN := acpI_P10.run, PT := T#10s);
	
	IF modeZonePalletization = modeZoneOff OR (modeZonePalletizationOld = modeZoneAuto AND modeZonePalletization <> modeZoneAuto) THEN
		stateConveyorP2 := stateConveyorStop;  
	END_IF
	
	CASE stateConveyorP2 OF
		
		stateConveyorStop:
			
			acpI_P11.switchOn := TRUE;
			acpI_P11.run := FALSE;
			IF modeZonePalletization <> modeZoneOff THEN
				stateConveyorP2 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
		
			IF cmdRunConveyorP2 THEN
				stateConveyorP2 := stateConveyorMoving;
			END_IF
		
		stateConveyorMoving:
			
			acpI_P11.run := TRUE;
				
			IF modeZonePalletization = modeZoneAuto THEN
				//pause?
				IF NOT TOF_acpI_P10.Q THEN
					stateConveyorP2 := stateConveyorPause;
				END_IF

			END_IF
			
			IF NOT cmdRunConveyorP2 THEN
				stateConveyorP2 := stateConveyorStop;
			END_IF	

		stateConveyorPause:
			
			acpI_P11.run := FALSE;
			
			//wake up
			IF TOF_acpI_P10.Q THEN
				stateConveyorP2 := stateConveyorMoving;
			END_IF
			
	END_CASE
	
	//control of ACOPOSinverter
	acpI_P11();
	

END_ACTION
