
ACTION ConveyorP12P13Control: 

	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP12P13 := stateConveyorStop;
	END_IF
		
	//detect pallet on conveyor
	IF diPalletStopP13 THEN
		palletOnConveyorP13 := TRUE;
	END_IF
	
	CASE stateConveyorP12P13 OF
		
		stateConveyorStop:
			
			cmdMovePalletP12P13 := FALSE;
			doConveyorP12 := FALSE;
			doConveyorP13 := FALSE;
			stateConveyorP12P13 := stateConveyorWait;
		
		stateConveyorWait:
		
			IF cmdMovePalletP12P13 THEN
				IF palletOnConveyorP13 AND NOT diReset THEN
					alarmImagePalletization[1] := TRUE;
					stateConveyorP12P13 := stateConveyorStop;
				ELSE
					TON_ConveyorP12P13(IN := FALSE);
					stateConveyorP12P13 := stateConveyorMoving;
				END_IF
			END_IF
		
		stateConveyorMoving:
			
			doConveyorP12 := TRUE;
			doConveyorP13 := TRUE;

			IF NOT cmdMovePalletP12P13 THEN
				stateConveyorP12P13 := stateConveyorStop;
			END_IF	
				
			//sensor reached?
			IF palletOnConveyorP13 AND NOT diReset THEN
				palletOnConveyorP12 := FALSE;
				stateConveyorP12P13 := stateConveyorStop;
			END_IF	
			
			//timeout?
			TON_ConveyorP12P13(IN := TRUE, PT := T#12s);
			IF TON_ConveyorP12P13.Q AND NOT diReset THEN
				alarmImagePalletization[0] := TRUE;
				stateConveyorP12P13 := stateConveyorStop;
			END_IF
		
	END_CASE

	
	//edge alarms
	IF acknowledgeImagePalletization[0] THEN
		alarmImagePalletization[0] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[1] THEN
		alarmImagePalletization[1] := FALSE;
	END_IF	

	
END_ACTION
