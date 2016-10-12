
ACTION ConveyorP1: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP1 := stateConveyorStop;  
	END_IF
	
	//pause conveyor when no trays on input
	TOF_TrayOnInputP1(IN := diTrayOnInputP1 OR diTrayOnOutputP1, PT := T#10s);
	
	CASE stateConveyorP1 OF
		
		stateConveyorStop:
			
			//cmdRunConveyorP1 := FALSE;
			acpI_P10.switchOn := TRUE;
			acpI_P10.stop := TRUE;
			acpI_P10.reset := TRUE;
			IF modePalletization <> modePalletizationNotReadyToStart THEN
				stateConveyorP1 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
			
			IF cmdRunConveyorP1 THEN
				TOF_TrayOnInputP1(IN:=TRUE);
				stateConveyorP1 := stateConveyorMoving;
			END_IF	
		
		stateConveyorMoving:
			
			acpI_P10.stop := FALSE;	
			acpI_P10.speed := dActualRecipe.conveyorP1speed;
				
			IF modePalletization = modePalletizationAuto THEN
				//pause?
				IF NOT TOF_TrayOnInputP1.Q THEN
					stateConveyorP1 := stateConveyorPause;
				END_IF
	
				//detection of new tray
				IF TOF_TrayOnOutputP1.Q THEN
					acpI_P10.stop := TRUE;
					stateConveyorP1 := stateConveyorNewTray;
				END_IF
			END_IF
							
			IF NOT cmdRunConveyorP1 THEN
				stateConveyorP1 := stateConveyorStop;
			END_IF	

		
		stateConveyorPause:
			
			acpI_P10.stop := TRUE;
			
			//wake up
			IF TOF_TrayOnInputP1.Q THEN
				stateConveyorP1 := stateConveyorMoving;
			END_IF
		
//			IF modePalletization <> modePalletizationAuto THEN
//				stateConveyorP1 := stateConveyorStop;
//			END_IF	
				
		stateConveyorNewTray:
			
			//backup data of new tray
			fullRow := dNextTray.lastTrayInRow OR dNextTray.lastTrayHalfLayer OR dNextTray.lastTrayInLayer;
			turnTray := dNextTray.turnTray;
			
			//wait till rotation is in correct place
			IF turnTray THEN 
				IF stateRotation = stateRotationForward THEN	
					stateConveyorP1 := stateConveyorNewTray2;
				END_IF
			ELSE
				IF stateRotation = stateRotationBack THEN
					stateConveyorP1 := stateConveyorNewTray2;
				END_IF
			END_IF
		
		stateConveyorNewTray2:
			
			//move tray from P1 to P2 
			acpI_P10.stop := FALSE;
			
			IF NOT TOF_TrayOnOutputP1.Q THEN
				acpI_P10.stop := TRUE;
				TON_TurnTray(IN:=FALSE);
				stateConveyorP1 := stateConveyorNewTray3;
			END_IF
		
		stateConveyorNewTray3:
			
			//time delay
			TON_TurnTray(IN:=TRUE, PT := dActualRecipe.timeDelayForTurn);
			IF TON_TurnTray.Q OR NOT turnTray THEN	
				stateConveyorP1 := stateConveyorNewTray4;
			END_IF	
		
		stateConveyorNewTray4:
		
			//check if this was last tray in a row
			IF fullRow THEN
				stateConveyorP1 := stateConveyorNewTray5;
			ELSE
				stateConveyorP1 := stateConveyorMoving;
			END_IF
		
		stateConveyorNewTray5:
				
			//fill conveyor P1 and stop
			acpI_P10.stop := FALSE;	
			
			//pause?
			IF NOT TOF_TrayOnInputP1.Q THEN
				stateConveyorP1 := stateConveyorNewTray6;
			END_IF
			
			//tray detected
			IF TOF_TrayOnOutputP1.Q THEN
				acpI_P10.stop := TRUE;
				stateConveyorP1 := stateConveyorNewTray6;
			END_IF	
		
		stateConveyorNewTray6:
		
			//wait for P2 conveyor
			acpI_P10.stop := TRUE;
			
			IF NOT fullRow THEN
				stateConveyorP1 := stateConveyorMoving;
			END_IF				
		
	END_CASE
	
	//control of ACOPOSinverter P14
	acpI_P10();

	IF acpI_P10.error THEN
		alarmImagePalletization[22] := TRUE;
	ELSE
		alarmImagePalletization[22] := FALSE;
	END_IF
	
	//edge alarms
//	IF acknowledgeImagePalletization[19] THEN
//		alarmImagePalletization[19] := FALSE;
//	END_IF	


END_ACTION
