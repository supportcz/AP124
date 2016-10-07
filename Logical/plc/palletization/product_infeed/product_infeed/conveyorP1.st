
ACTION ConveyorP1: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP1 := stateConveyorStop;  
	END_IF
	
	//pause conveyor when no trays on input
	TOF_TrayOnInputP1(IN := diTrayOnInputP1 OR diTrayOnOutputP1, PT := T#10s);
	
	CASE stateConveyorP1 OF
		
		stateConveyorStop:
			
			cmdRunConveyorP1 := FALSE;
			cmdFillUpConveyorP1 := FALSE;
			acpI_P10.switchOn := TRUE;
			acpI_P10.speed := 0;
			acpI_P10.reset := TRUE;
			IF modePalletization <> modePalletizationNotReadyToStart THEN
				acpI_P10.stop := FALSE;		
				stateConveyorP1 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
			
			IF cmdRunConveyorP1 THEN
				TOF_TrayOnInputP1(IN:=TRUE);
				stateConveyorP1 := stateConveyorMoving;
			END_IF
			
			IF cmdFillUpConveyorP1 THEN
				TOF_TrayOnInputP1(IN:=TRUE);
				stateConveyorP1 := stateConveyorFillUp;
			END_IF
						
		
		stateConveyorMoving:
			
			acpI_P10.speed := dActualRecipe.conveyorP1speed;
				
			IF NOT TOF_TrayOnInputP1.Q AND modePalletization = modePalletizationAuto THEN
				stateConveyorP1 := stateConveyorPause;
			END_IF
			
			IF NOT cmdRunConveyorP1 THEN
				stateConveyorP1 := stateConveyorStop;
			END_IF	
			
			IF cmdMakeGap THEN 
				TON_MakeGap(IN:=FALSE);
				stateConveyorP1 := stateConveyorMakeGap;
			END_IF
				
			IF cmdFillUpConveyorP1 THEN
				TOF_TrayOnInputP1(IN:=TRUE);
				stateConveyorP1 := stateConveyorFillUp;
			END_IF
		
				
		stateConveyorFillUp:
			
			cmdFillUpConveyorP1 := FALSE;

			acpI_P10.speed := dActualRecipe.conveyorP1speed;

			IF NOT TOF_TrayOnInputP1.Q THEN
				stateConveyorP1 := stateConveyorPause;
			END_IF
			
			IF diTrayOnOutputP1 THEN
				acpI_P10.stop := TRUE;
				stateConveyorP1 := stateConveyorStop;
			END_IF
		
//			IF cmdRunConveyorP1 THEN
//				stateConveyorP1 := stateConveyorMoving;
//			END_IF
		
		stateConveyorPause:
			
			acpI_P10.speed := 0;
			
			IF TOF_TrayOnInputP1.Q THEN
				stateConveyorP1 := stateConveyorMoving;
			END_IF
		
			IF modePalletization <> modePalletizationAuto THEN
				stateConveyorP1 := stateConveyorStop;
			END_IF	
				
		stateConveyorMakeGap:
			
			acpI_P10.speed := 0;
			TON_MakeGap(IN:=TRUE, PT := conveyorP1gap);
			IF TON_MakeGap.Q THEN	
				cmdMakeGap := FALSE;
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
