
ACTION ConveyorP12: 

	TON_PalletStopP13(IN := diPalletStopP13, PT := T#200ms);
	
	IF EDGEPOS(TON_PalletStopP13.Q) AND statePalletP12 <> palletMoving THEN
		alarmImagePalletization[9] := TRUE;
	END_IF	
	
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
			IF TON_PalletStopP13.Q AND NOT diReset THEN
				statePalletP13 := palletPresent;
				statePalletP12 := palletNotPresent;
				cmdMovePalletP12 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP12(IN := TRUE, PT := T#12s);
				IF TON_ConveyorP12.Q THEN
					alarmImagePalletization[0] := TRUE;
					cmdMovePalletP12 := FALSE;
				END_IF
			ELSE
				TON_ConveyorP12(IN := FALSE);
			END_IF
		
			doConveyorP12 := cmdMovePalletP12;
			
	END_CASE

	
	// alarms
	alarmImagePalletization[12] := NOT diMotorProtectionP12;
	
	IF acknowledgeImagePalletization[0] THEN
		alarmImagePalletization[0] := FALSE;
	END_IF
	
		
	IF acknowledgeImagePalletization[9] THEN
		alarmImagePalletization[9] := FALSE;
	END_IF	
	
END_ACTION
