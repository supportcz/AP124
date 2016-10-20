
ACTION ConveyorP19: 

	TON_PalletStopP20(IN := diPalletStopP20, PT := T#200ms);
			
	IF EDGEPOS(TON_PalletStopP20.Q) AND statePalletP19 <> palletMoving THEN
		alarmImageOutfeed[2] := TRUE;
	END_IF	

	CASE statePalletP19 OF
		
		palletNotPresent:
			
			doConveyorP19 := cmdMovePalletP19 AND (statePalletP20 = palletNotPresent OR diReset);
			
		palletPresent:
		
			doConveyorP19 := FALSE;

			IF cmdMovePalletP19 AND (statePalletP20 = palletNotPresent OR diReset) THEN
				TON_ConveyorP19(IN := FALSE);
				statePalletP19 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP20.Q AND NOT diReset THEN
				statePalletP20 := palletPresent;
				statePalletP19 := palletNotPresent;
				cmdMovePalletP19 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP19(IN := TRUE, PT := T#12s);
				IF TON_ConveyorP19.Q THEN
					alarmImageOutfeed[1] := TRUE;
					cmdMovePalletP19 := FALSE;
				END_IF
			ELSE
				TON_ConveyorP19(IN := FALSE);
			END_IF
		
			doConveyorP19 := cmdMovePalletP19;
			
	END_CASE

		
	// alarms
	alarmImageOutfeed[3] := NOT diMotorProtectionP19;

	IF alarmImageOutfeed[1] THEN
		alarmImageOutfeed[1] := FALSE;
	END_IF
	
	IF alarmImageOutfeed[2] THEN
		alarmImageOutfeed[2] := FALSE;
	END_IF	
	
END_ACTION
