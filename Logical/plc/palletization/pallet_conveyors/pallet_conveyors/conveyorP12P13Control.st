
ACTION ConveyorP12P13Control: 

	IF modePalletization = modePalletizationNotReadyToStart THEN
		statePalletP12 := palletNotPresent;
	END_IF
			
	CASE statePalletP12 OF
		
		palletNotPresent:
			
			doConveyorP12 := FALSE;
			doConveyorP13 := FALSE;
			
			IF cmdMovePalletP12P13 THEN
				IF statePalletP13 = palletPresent AND NOT diReset THEN
					alarmImagePalletization[1] := TRUE;
					cmdMovePalletP12P13 := FALSE;
				ELSE
					TON_ConveyorP12P13(IN := FALSE);
					statePalletP12 := palletMoving;
				END_IF
			END_IF
						
			IF diPalletStopP13 THEN
				alarmImagePalletization[9] := TRUE;
			END_IF	
		
		palletPresent:
		
			doConveyorP12 := FALSE;
			doConveyorP13 := FALSE;

			IF cmdMovePalletP12P13 THEN
				IF statePalletP13 = palletPresent AND NOT diReset THEN
					alarmImagePalletization[1] := TRUE;
//					statePalletP12 := stateConveyorStop;
				ELSE
					TON_ConveyorP12P13(IN := FALSE);
					statePalletP12 := palletMoving;
				END_IF
			END_IF	
			
		
		palletMoving:
			
			IF cmdMovePalletP12P13 THEN
				doConveyorP12 := TRUE;
				doConveyorP13 := TRUE;
			ELSE
				statePalletP12 := palletNotPresent;
			END_IF	
			
			//sensor reached?
			IF diPalletStopP13 AND NOT diReset THEN
				statePalletP13 := palletPresent;
				statePalletP12 := palletNotPresent;
			END_IF	
			
			//timeout?
			TON_ConveyorP12P13(IN := TRUE, PT := T#12s);
			IF TON_ConveyorP12P13.Q AND NOT diReset THEN
				alarmImagePalletization[0] := TRUE;
				cmdMovePalletP12P13 := FALSE;
			END_IF
		
	END_CASE

	
	alarmImagePalletization[12] := NOT diMotorProtectionP12;
	
	//edge alarms
	IF acknowledgeImagePalletization[0] THEN
		alarmImagePalletization[0] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[1] THEN
		alarmImagePalletization[1] := FALSE;
	END_IF	
	IF acknowledgeImagePalletization[9] THEN
		alarmImagePalletization[9] := FALSE;
	END_IF	
	
END_ACTION
