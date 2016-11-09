
ACTION ConveyorP2: 
	
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
						
			IF NOT cmdRunConveyorP2 THEN
				stateConveyorP2 := stateConveyorStop;
			END_IF	

	END_CASE
	
	//control of ACOPOSinverter P14
	acpI_P11();
	

	
//	//edge alarms
//	IF acknowledgeImagePalletization[19] THEN
//		alarmImagePalletization[19] := FALSE;
//	END_IF	


END_ACTION
