
ACTION ConveyorP12: 
	
	CASE statePalletP12 OF
		
		palletNotPresent:
			
			doConveyorP12 := cmdMovePalletP12 AND (statePalletP13 = palletNotPresent OR diReset);
			
		palletPresent:
		
			doConveyorP12 := FALSE;

			IF cmdMovePalletP12 AND (statePalletP13 = palletNotPresent OR diReset) THEN
				TON_ConveyorP12(IN := FALSE);
				statePalletP12 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP13.Q AND cmdMovePalletP12 AND NOT diReset THEN
				statePalletP13 := palletPresent;
				statePalletP12 := palletNotPresent;
				cmdMovePalletP12 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP12(IN := TRUE, PT := T#20s);
				IF TON_ConveyorP12.Q THEN
					alarmImagePalletization[0] := TRUE;
					cmdMovePalletP12 := FALSE;
				END_IF
			END_IF
		
			doConveyorP12 := cmdMovePalletP12;
			
			IF NOT cmdMovePalletP12 THEN
				TON_ConveyorP12(IN := FALSE);
			END_IF	

	END_CASE

	
	// alarms
	IF acknowledgeImagePalletization[0] THEN
		alarmImagePalletization[0] := FALSE;
	END_IF
	

	
END_ACTION
