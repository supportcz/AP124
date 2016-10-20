
ACTION ConveyorP20: 

	TON_PalletStopP21(IN := diPalletStopP21, PT := T#200ms);
			
	IF EDGEPOS(TON_PalletStopP21.Q) AND statePalletP20 <> palletMoving THEN
		alarmImageOutfeed[7] := TRUE;
	END_IF	

	CASE statePalletP20 OF
		
		palletNotPresent:
			
			doConveyorP20 := (cmdMovePalletP20 AND (statePalletP21 = palletNotPresent OR diReset)) OR cmdMovePalletP19;

		palletPresent:
		
			doConveyorP20 := FALSE;

			IF cmdMovePalletP20 AND (statePalletP21 = palletNotPresent OR diReset) THEN
				TON_ConveyorP20(IN := FALSE);
				statePalletP20 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP21.Q AND NOT diReset THEN
				statePalletP21 := palletPresent;
				statePalletP20 := palletNotPresent;
				cmdMovePalletP20 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP20(IN := TRUE, PT := T#12s);
				IF TON_ConveyorP20.Q THEN
					alarmImageOutfeed[8] := TRUE;
					cmdMovePalletP20 := FALSE;
				END_IF
			ELSE
				TON_ConveyorP20(IN := FALSE);
			END_IF
		
			doConveyorP20 := cmdMovePalletP20;
			
	END_CASE

		
	// alarms
	alarmImageOutfeed[9] := NOT diMotorProtectionP20;

	IF alarmImageOutfeed[7] THEN
		alarmImageOutfeed[7] := FALSE;
	END_IF
	
	IF alarmImageOutfeed[8] THEN
		alarmImageOutfeed[8] := FALSE;
	END_IF	
	
END_ACTION
