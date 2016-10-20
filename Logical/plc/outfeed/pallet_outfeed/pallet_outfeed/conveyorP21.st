
ACTION ConveyorP21: 

	TON_PalletStopP22(IN := diPalletStopP22, PT := T#200ms);
			
	IF EDGEPOS(TON_PalletStopP22.Q) AND statePalletP21 <> palletMoving THEN
		alarmImageOutfeed[10] := TRUE;
	END_IF	

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
			IF TON_PalletStopP22.Q AND NOT diReset THEN
				statePalletP22 := palletPresent;
				statePalletP21 := palletNotPresent;
				cmdMovePalletP21 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP21(IN := TRUE, PT := T#12s);
				IF TON_ConveyorP21.Q THEN
					alarmImageOutfeed[11] := TRUE;
					cmdMovePalletP21 := FALSE;
				END_IF
			ELSE
				TON_ConveyorP21(IN := FALSE);
			END_IF
		
			doConveyorP21 := cmdMovePalletP21;
			
	END_CASE

		
	// alarms
	alarmImageOutfeed[12] := NOT diMotorProtectionP21;

	IF alarmImageOutfeed[10] THEN
		alarmImageOutfeed[10] := FALSE;
	END_IF
	
	IF alarmImageOutfeed[11] THEN
		alarmImageOutfeed[11] := FALSE;
	END_IF	
	
END_ACTION
