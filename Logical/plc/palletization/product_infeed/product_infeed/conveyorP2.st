
ACTION ConveyorP2: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP2 := stateConveyorStop;  
	END_IF
	

	
	CASE stateConveyorP2 OF
		
		stateConveyorStop:
			
			//cmdMoveTrayP1 := FALSE;
			acpI_P11.switchOn := TRUE;
			acpI_P11.speed := 0;
			acpI_P11.reset := TRUE;
			IF modePalletization <> modePalletizationNotReadyToStart THEN
				stateConveyorP2 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
		
			IF cmdMoveTrayP2 THEN
//				IF trayOnConveyorP1 AND NOT diReset THEN
//					alarmImagePalletization[19] := TRUE;
//					stateConveyorP1 := stateConveyorStop;
//				ELSE
//					TON_ConveyorP1(IN := FALSE);
					stateConveyorP2 := stateConveyorMoving;
//				END_IF
			END_IF
//						
//			IF trayOnConveyorP1 > trayOnConveyorP1old THEN
//				alarmImagePalletization[20] := TRUE;
//				stateConveyorP1 := stateConveyorStop;
//			END_IF	
		
		stateConveyorMoving:
			
			acpI_P11.speed := actualRecipe.conveyorP2speed;
//				
			IF NOT cmdMoveTrayP2 THEN
				stateConveyorP2 := stateConveyorStop;
			END_IF	
//				
//			//sensor reached?
//			IF trayOnConveyorP1 AND NOT diReset THEN
//				stateConveyorP1 := stateConveyorStop;
//			END_IF	
//			
//			//timeout?
//			TON_ConveyorP1(IN := TRUE, PT := T#12s);
//			IF TON_ConveyorP1.Q AND NOT diReset THEN
//				alarmImagePalletization[21] := TRUE;
//				stateConveyorP1 := stateConveyorStop;
//			END_IF
		
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
//	IF acknowledgeImagePalletization[20] THEN
//		alarmImagePalletization[20] := FALSE;
//	END_IF	
//	IF acknowledgeImagePalletization[21] THEN
//		alarmImagePalletization[21] := FALSE;
//	END_IF					
//	trayOnConveyorP1old := trayOnConveyorP1;

END_ACTION
