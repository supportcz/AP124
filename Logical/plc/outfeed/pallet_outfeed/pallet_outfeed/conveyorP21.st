
ACTION ConveyorP21: 

	CASE statePalletP21 OF
		
		palletNotPresent:

			doConveyorP21 := (cmdMovePalletP21 AND (statePalletP22 = palletNotPresent OR diReset)) OR cmdMovePalletP20;
			
		palletPresent:
		
			doConveyorP21 := FALSE;

			IF cmdMovePalletP21 AND (statePalletP22 = palletNotPresent OR diReset) THEN
				TON_ConveyorP21(IN := FALSE);
				statePalletP21 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP22.Q AND cmdMovePalletP21 AND NOT diReset THEN
				statePalletP22 := palletPresent;
				statePalletP21 := palletNotPresent;
				cmdMovePalletP21 := FALSE;
			END_IF	

			//timeout?
			IF modeOutfeed = modeOutfeedAuto THEN
				TON_ConveyorP21(IN := TRUE, PT := T#20s);
				IF TON_ConveyorP21.Q THEN
					alarmImageOutfeed[11] := TRUE;
					cmdMovePalletP21 := FALSE;
				END_IF
//			ELSE
//				TON_ConveyorP21(IN := FALSE);
			END_IF
		
			doConveyorP21 := cmdMovePalletP21;
			
			IF NOT cmdMovePalletP21 THEN
				TON_ConveyorP21(IN := FALSE);
			END_IF	
		
	END_CASE

		
	// alarms

	
	IF acknowledgeImageOutfeed[11] THEN
		alarmImageOutfeed[11] := FALSE;
	END_IF	
	
END_ACTION
