
ACTION ConveyorP1: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP1 := stateConveyorStop;  
	END_IF
	
	//pause conveyor when no trays on input
	TOF_TrayOnInputP1(IN := diTrayOnInputP1 OR diTrayOnOutputP1, PT := T#10s);
	
	CASE stateConveyorP1 OF
		
		stateConveyorStop:
			
			cmdRunConveyorP1 := FALSE;
			stopOnSensor := FALSE;
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
				
			IF NOT TOF_TrayOnInputP1.Q AND modePalletization = modePalletizationAuto THEN
				stateConveyorP1 := stateConveyorPause;
			END_IF

			
			IF TOF_TrayOnOutputP1.Q THEN
				acpI_P10.stop := TRUE;
				stateConveyorP1 := stateConveyorNewTray;
			END_IF	
							
			IF NOT cmdRunConveyorP1 THEN
				stateConveyorP1 := stateConveyorStop;
			END_IF	
		
			IF stopOnSensor AND TOF_TrayOnOutputP1.Q THEN
				//cmdRunConveyorP1 := FALSE;
				stateConveyorP1 := stateConveyorStop;
			END_IF	
		
		stateConveyorPause:
			
			stopOnSensor := FALSE;
			acpI_P10.stop := TRUE;
			
			IF TOF_TrayOnInputP1.Q THEN
				stateConveyorP1 := stateConveyorMoving;
			END_IF
		
			IF modePalletization <> modePalletizationAuto THEN
				stateConveyorP1 := stateConveyorStop;
			END_IF	
				
		stateConveyorNewTray:
	
			IF dNextTray.lastTrayInRow THEN
				stopOnSensor := TRUE;
			END_IF
			
			IF dNextTray.turnTray AND stateRotation = stateRotationForward THEN	
				stateConveyorP1 := stateConveyorNewTray2;
			END_IF

			IF NOT dNextTray.turnTray AND stateRotation = stateRotationBack THEN
				stateConveyorP1 := stateConveyorNewTray2;
			END_IF

		
		stateConveyorNewTray2:
			
			//move tray from P1 to P2 
			acpI_P10.speed := dActualRecipe.conveyorP1speed;
			acpI_P10.stop := FALSE;
			
			IF NOT TOF_TrayOnOutputP1.Q THEN
				acpI_P10.stop := TRUE;
				TON_TurnTray(IN:=FALSE);
				stateConveyorP1 := stateConveyorNewTray3;
			END_IF
		
		stateConveyorNewTray3:
			
			//time delay
			TON_TurnTray(IN:=TRUE, PT := dActualRecipe.timeDelayForTurn);
			IF TON_TurnTray.Q OR NOT dNextTray.turnTray THEN	
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
