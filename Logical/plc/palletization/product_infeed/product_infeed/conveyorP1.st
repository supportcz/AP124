
ACTION ConveyorP1: 
	
	IF modeZonePalletization = modeZoneOff OR (modeZonePalletizationOld = modeZoneAuto AND modeZonePalletization <> modeZoneAuto) THEN
		stateConveyorP1 := stateConveyorStop;  
	END_IF
	
	//pause conveyor when no trays on input
	TOF_TrayOnInputP1(IN := diTrayOnInputP1 OR diTrayOnOutputP1, PT := T#10s);
	
	CASE stateConveyorP1 OF
		
		stateConveyorStop:
			
			//cmdRunConveyorP1 := FALSE;
			acpI_P10.switchOn := TRUE;
			acpI_P10.run := FALSE;
			IF modeZonePalletization <> modeZoneOff THEN
				stateConveyorP1 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
			
			IF cmdRunConveyorP1 THEN
				TOF_TrayOnInputP1(IN:=TRUE);
				stateConveyorP1 := stateConveyorMoving;
			END_IF	
		
		stateConveyorMoving:
			
			acpI_P10.run := TRUE;	

			IF modeZonePalletization = modeZoneAuto THEN
				//pause?
				IF NOT TOF_TrayOnInputP1.Q THEN
					stateConveyorP1 := stateConveyorPause;
				END_IF
	
				//detection of new tray
				IF TOF_TrayOnOutputP1.Q THEN
					stateConveyorP1 := stateConveyorWaitForRotation;
				END_IF
			END_IF
					
			IF NOT cmdRunConveyorP1 THEN
				stateConveyorP1 := stateConveyorStop;
			END_IF							
		
		stateConveyorPause:
			
			acpI_P10.run := FALSE;
			
			//wake up
			IF TOF_TrayOnInputP1.Q THEN
				stateConveyorP1 := stateConveyorMoving;
			END_IF
				
		stateConveyorWaitForRotation:
			
			//stop request?
			IF dNextTray.lastTray <> lastTrayNo THEN
				cmdRunConveyorP1 := FALSE;
			END_IF
			
			//wait till rotation is in correct place
			acpI_P10.run := FALSE;
			
			IF dNextTray.turnTray THEN 
				IF stateRotation = stateRotationForward THEN	
					stateConveyorP1 := stateConveyorMoveTrayFromP1toP2;
				END_IF
			ELSE
				IF stateRotation = stateRotationBack THEN
					stateConveyorP1 := stateConveyorMoveTrayFromP1toP2;
				END_IF
			END_IF
		
		stateConveyorMoveTrayFromP1toP2:
			
			//move tray from P1 to P2 
			acpI_P10.run := TRUE;
			
			IF NOT TOF_TrayOnOutputP1.Q THEN
				TON_TurnTray(IN:=FALSE);
				stateConveyorP1 := stateConveyorDelayForTurn;
			END_IF
		
		stateConveyorDelayForTurn:
			
			//time delay for turn
			acpI_P10.run := FALSE;
			
			TON_TurnTray(IN:=TRUE, PT := dActualRecipe.timeDelayForTurn);
			IF TON_TurnTray.Q OR stateRotation = stateRotationBack THEN	
				stateConveyorP1 := stateConveyorFillP1;
			END_IF	
		
		stateConveyorFillP1:
		
			//fill conveyor P1 
			acpI_P10.run := TRUE;	
			
			//pause?
			IF NOT TOF_TrayOnInputP1.Q THEN
				stateConveyorP1 := stateConveyorMoving;
			END_IF
			
			//tray detected
			IF TOF_TrayOnOutputP1.Q THEN
				stateConveyorP1 := stateConveyorMoving;
			END_IF	

	END_CASE
	
	//control of ACOPOSinverter P14
	acpI_P10();


END_ACTION
