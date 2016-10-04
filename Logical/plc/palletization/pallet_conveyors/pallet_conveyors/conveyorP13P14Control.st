
ACTION ConveyorP13P14Control: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP13P14 := stateConveyorStop;
	END_IF
	
	//detect pallet	
	IF diPalletStopP14 THEN
		palletOnConveyorP14 := TRUE;
	END_IF
	
	CASE stateConveyorP13P14 OF
		
		stateConveyorStop:
			
			cmdMovePalletP13P14 := FALSE;
			doConveyorP13 := FALSE;
			acpI_P14.switchOn := TRUE;
			acpI_P14.speed := 0;
			acpI_P14.reset := TRUE;
			IF modePalletization <> modePalletizationNotReadyToStart THEN
				stateConveyorP13P14 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
		
			IF cmdMovePalletP13P14 THEN
				IF palletOnConveyorP14 AND NOT diReset THEN
					alarmImagePalletization[3] := TRUE;
					stateConveyorP12P13 := stateConveyorStop;
				ELSE
					TON_ConveyorP13P14(IN := FALSE);
					stateConveyorP13P14 := stateConveyorMoving;
				END_IF
			END_IF
						
			IF palletOnConveyorP14 > palletOnConveyorP14old THEN
				alarmImagePalletization[10] := TRUE;
				stateConveyorP13P14 := stateConveyorStop;
			END_IF	
		
		stateConveyorMoving:
			
			doConveyorP13 := TRUE;
			acpI_P14.speed := 500;
			
			IF NOT cmdMovePalletP13P14 THEN
				stateConveyorP13P14 := stateConveyorStop;
			END_IF	
				
			//sensor reached?
			IF diPalletSlowDownP14 THEN
				palletOnConveyorP13 := FALSE;
				TON_ConveyorP13P14(IN := FALSE);
				stateConveyorP13P14 := stateConveyorMovingSlow;
			END_IF	
			
			//timeout?
			TON_ConveyorP13P14(IN := TRUE, PT := T#12s);
			IF TON_ConveyorP13P14.Q AND NOT diReset THEN
				alarmImagePalletization[4] := TRUE;
				stateConveyorP13P14 := stateConveyorStop;
			END_IF
		
		stateConveyorMovingSlow:
			
			acpI_P14.speed := 200;

			IF NOT cmdMovePalletP13P14 THEN
				stateConveyorP13P14 := stateConveyorStop;
			END_IF	
			
			IF palletOnConveyorP14 AND NOT diReset THEN
				stateConveyorP13P14 := stateConveyorStop;
			END_IF
		
			//timeout?
			TON_ConveyorP13P14(IN := TRUE, PT := T#6s);
			IF TON_ConveyorP13P14.Q AND NOT diReset THEN
				alarmImagePalletization[2] := TRUE;
				stateConveyorP13P14 := stateConveyorStop;
			END_IF
	END_CASE
	
	//control of ACOPOSinverter P14
	acpI_P14();

	palletOnConveyorP14old := palletOnConveyorP14;
	
	alarmImagePalletization[13] := NOT diMotorProtectionP13;
	
	IF acknowledgeImagePalletization[2] THEN
		alarmImagePalletization[2] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[3] THEN
		alarmImagePalletization[3] := FALSE;
	END_IF
		
	IF acknowledgeImagePalletization[4] THEN
		alarmImagePalletization[4] := FALSE;
	END_IF
	
	IF acknowledgeImagePalletization[10] THEN
		alarmImagePalletization[10] := FALSE;
	END_IF	
	
	IF acpI_P14.error THEN
		alarmImagePalletization[24] := TRUE;
	ELSE
		alarmImagePalletization[24] := FALSE;
	END_IF	

END_ACTION
