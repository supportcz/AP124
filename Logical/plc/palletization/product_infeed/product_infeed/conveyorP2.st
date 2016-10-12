
ACTION ConveyorP2: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP2 := stateConveyorStop;  
	END_IF
	
	CASE stateConveyorP2 OF
		
		stateConveyorStop:
			
			//cmdRunConveyorP2 := FALSE;
			acpI_P11.switchOn := TRUE;
			acpI_P11.stop := TRUE;
			acpI_P11.reset := TRUE;
			IF modePalletization <> modePalletizationNotReadyToStart THEN
				stateConveyorP2 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
		
			IF cmdRunConveyorP2 THEN
				//intialize counters
				nbOfTraysOnConveyorP2 := nbOfTraysBehindRotation := nbOfTraysOnTable;
				
				stateConveyorP2 := stateConveyorMoving;
			END_IF
		
		stateConveyorMoving:
			
			acpI_P11.stop := FALSE;
			acpI_P11.speed := dActualRecipe.conveyorP2speed;
				
			IF modePalletization = modePalletizationAuto THEN
				//pause?
				IF NOT TOF_TrayOnInputP1.Q THEN
					stateConveyorP2 := stateConveyorPause;
				END_IF
			END_IF
			
			IF NOT cmdRunConveyorP2 THEN
				stateConveyorP2 := stateConveyorStop;
			END_IF	

		stateConveyorPause:
			
			acpI_P11.stop := TRUE;
			
			//wake up
			IF TOF_TrayOnInputP1.Q THEN
				stateConveyorP2 := stateConveyorMoving;
			END_IF
			
			IF modePalletization <> modePalletizationAuto THEN
				stateConveyorP2 := stateConveyorStop;
			END_IF	
	END_CASE
	
	//control of ACOPOSinverter P14
	acpI_P11();
	
	IF acpI_P11.error THEN
		alarmImagePalletization[23] := TRUE;
	ELSE
		alarmImagePalletization[23] := FALSE;
	END_IF
	
//	//edge alarms
//	IF acknowledgeImagePalletization[19] THEN
//		alarmImagePalletization[19] := FALSE;
//	END_IF	


END_ACTION
