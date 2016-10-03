
ACTION ConveyorP1: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP1 := stateConveyorStop;  
	END_IF
	
	//detect tray on conveyor
	IF diTrayStopP1 THEN
		trayOnConveyorP1 := TRUE;
	END_IF
	
	CASE stateConveyorP1 OF
		
		stateConveyorStop:
			
			cmdMoveTrayP1 := FALSE;
			acpI_P10.switchOn := TRUE;
			acpI_P10.speed := 0;
			acpI_P10.reset := TRUE;
			IF modePalletization <> modePalletizationNotReadyToStart THEN
				stateConveyorP1 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
		
			IF cmdMoveTrayP1 THEN
				IF trayOnConveyorP1 AND NOT diReset THEN
					alarmImagePalletization[19] := TRUE;
					stateConveyorP1 := stateConveyorStop;
				ELSE
					TON_ConveyorP1(IN := FALSE);
					stateConveyorP1 := stateConveyorMoving;
				END_IF
			END_IF
						
			IF trayOnConveyorP1 > trayOnConveyorP1old THEN
				alarmImagePalletization[20] := TRUE;
				stateConveyorP1 := stateConveyorStop;
			END_IF	
		
		stateConveyorMoving:
			
			acpI_P10.speed := 100;
				
			IF NOT cmdMoveTrayP1 THEN
				stateConveyorP1 := stateConveyorStop;
			END_IF	
				
			//sensor reached?
			IF trayOnConveyorP1 AND NOT diReset THEN
				stateConveyorP1 := stateConveyorStop;
			END_IF	
			
			//timeout?
			TON_ConveyorP1(IN := TRUE, PT := T#12s);
			IF TON_ConveyorP1.Q AND NOT diReset THEN
				alarmImagePalletization[21] := TRUE;
				stateConveyorP1 := stateConveyorStop;
			END_IF
		
	END_CASE
	
	//control of ACOPOSinverter P14
	acpI_P10();

	//edge alarms
	IF acknowledgeImagePalletization[19] THEN
		alarmImagePalletization[19] := FALSE;
	END_IF	
	IF acknowledgeImagePalletization[20] THEN
		alarmImagePalletization[20] := FALSE;
	END_IF	
	IF acknowledgeImagePalletization[21] THEN
		alarmImagePalletization[21] := FALSE;
	END_IF					
	trayOnConveyorP1old := trayOnConveyorP1;

END_ACTION
