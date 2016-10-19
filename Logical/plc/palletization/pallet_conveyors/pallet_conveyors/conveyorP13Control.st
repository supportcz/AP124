

ACTION ConveyorP13Control: 

	TON_PalletStopP14(IN := diPalletStopP14, PT := T#50ms);
	
	CASE statePalletP13 OF
		
		palletNotPresent:
			
			doConveyorP13 := (cmdMovePalletP13 AND (statePalletP14 = palletNotPresent OR diReset)) OR cmdMovePalletP12;
									
			IF TON_PalletStopP14.Q > palletStopP14old THEN
				alarmImagePalletization[10] := TRUE;
			END_IF	
		
		palletPresent:
		
			doConveyorP13 := FALSE;

			IF cmdMovePalletP13 AND (statePalletP14 = palletNotPresent OR diReset) THEN
				TON_ConveyorP13(IN := FALSE);
				statePalletP13 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//slow down sensor?
			IF diPalletSlowDownP14 THEN
				acpI_P14.speed := 200;
			END_IF
			
			//sensor reached?
			IF TON_PalletStopP14.Q AND NOT diReset THEN
				statePalletP14 := palletPresent;
				statePalletP13 := palletNotPresent;
				cmdMovePalletP13 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP13(IN := TRUE, PT := T#12s);
				IF TON_ConveyorP13.Q THEN
					alarmImagePalletization[2] := TRUE;
					cmdMovePalletP13 := FALSE;
				END_IF
			ELSE
				TON_ConveyorP13(IN := FALSE);
			END_IF
		
			doConveyorP13 := cmdMovePalletP13;
			
	END_CASE

	palletStopP14old := TON_PalletStopP14.Q;
	
	alarmImagePalletization[13] := NOT diMotorProtectionP13;
	
	//edge alarms
	IF acknowledgeImagePalletization[2] THEN
		alarmImagePalletization[2] := FALSE;
	END_IF
	
	IF acknowledgeImagePalletization[10] THEN
		alarmImagePalletization[10] := FALSE;
	END_IF	
	
END_ACTION
