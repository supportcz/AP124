

ACTION ConveyorP13: 
	

	CASE statePalletP13 OF
		
		palletNotPresent:
			
			doConveyorP13 := (cmdMovePalletP13 AND (statePalletP14 = palletNotPresent OR diReset)) OR cmdMovePalletP12;
		
		palletPresent:
		
			doConveyorP13 := FALSE;

			IF cmdMovePalletP13 AND (statePalletP14 = palletNotPresent OR diReset) THEN
				TON_ConveyorP13(IN := FALSE);
				statePalletP13 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP14.Q AND cmdMovePalletP13 AND NOT diReset THEN
				statePalletP14 := palletPresent;
				statePalletP13 := palletNotPresent;
				cmdMovePalletP13 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP13(IN := TRUE, PT := T#20s);
				IF TON_ConveyorP13.Q THEN
					alarmImagePalletization[2] := TRUE;
					cmdMovePalletP13 := FALSE;
				END_IF
			END_IF
		
			doConveyorP13 := cmdMovePalletP13;
			
			IF NOT cmdMovePalletP13 THEN
				TON_ConveyorP13(IN := FALSE);
			END_IF		
		
	END_CASE

									
	// alarms

	
	IF acknowledgeImagePalletization[2] THEN
		alarmImagePalletization[2] := FALSE;
	END_IF

	
END_ACTION
