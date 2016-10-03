
ACTION ConveyorP1: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP1 := stateConveyorStop;  
	END_IF
	
	
	CASE stateConveyorP1 OF
		
		stateConveyorStop:
			

			acpI_P10.switchOn := TRUE;
			acpI_P10.speed := 0;
			acpI_P10.reset := TRUE;
			IF modePalletization <> modePalletizationNotReadyToStart THEN
				stateConveyorP1 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
		
//			IF cmdMovePalletP13P14 THEN
//				IF palletOnConveyorP14 AND NOT diReset THEN
//					alarmImagePalletization[3] := TRUE;
//					stateConveyorP12P13 := stateConveyorStop;
//				ELSE
//					TON_ConveyorP13P14(IN := FALSE);
//					stateConveyorP13P14 := stateConveyorMoving;
//				END_IF
//			END_IF
//						
//			IF palletOnConveyorP14 > palletOnConveyorP14old THEN
//				alarmImagePalletization[10] := TRUE;
//				stateConveyorP13P14 := stateConveyorStop;
//			END_IF	
		
		stateConveyorMoving:
			
//			doConveyorP13 := TRUE;
//			acpI_P14.speed := 500;
//			
//			IF NOT cmdMovePalletP13P14 THEN
//				stateConveyorP13P14 := stateConveyorStop;
//			END_IF	
//				
//			//sensor reached?
//			IF diPalletSlowDownP14 THEN
//				palletOnConveyorP13 := FALSE;
//				TON_ConveyorP13P14(IN := FALSE);
//				stateConveyorP13P14 := stateConveyorMovingSlow;
//			END_IF	
//			
//			//timeout?
//			TON_ConveyorP13P14(IN := TRUE, PT := T#12s);
//			IF TON_ConveyorP13P14.Q AND NOT diReset THEN
//				alarmImagePalletization[4] := TRUE;
//				stateConveyorP13P14 := stateConveyorStop;
//			END_IF
		

	END_CASE
	
	//control of ACOPOSinverter P14
	acpI_P10();



	

END_ACTION
