

ACTION ConveyorP16Control: 

	TON_PalletStopP17(IN := diPalletStopP17, PT := T#50ms);
	
	acpI_P16.switchOn := TRUE;
	acpI_P16.speed := 500;
			
	CASE statePalletP16 OF
		
		palletNotPresent:
			
			acpI_P16.stop := NOT (cmdMovePalletP16 AND (statePalletP17 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP15;
				
			IF TON_PalletStopP17.Q > palletStopP17old THEN
				alarmImagePalletization[4] := TRUE;
			END_IF	
		
		palletPresent:
		
			acpI_P16.stop := TRUE;

			IF cmdMovePalletP16 AND (statePalletP17 = palletNotPresent OR diReset) THEN
				TON_ConveyorP16(IN := FALSE);
				statePalletP16 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP17.Q AND NOT diReset THEN
				statePalletP17 := palletPresent;
				statePalletP16 := palletNotPresent;
				cmdMovePalletP16 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP16(IN := TRUE, PT := T#12s);
				IF TON_ConveyorP16.Q THEN
					alarmImagePalletization[6] := TRUE;
					cmdMovePalletP16 := FALSE;
				END_IF
			ELSE
				TON_ConveyorP16(IN := FALSE);
			END_IF
		
			acpI_P16.stop := NOT cmdMovePalletP16;
			
	END_CASE

	//control of ACOPOSinverter
	acpI_P16();
	
	alarmImagePalletization[26] := acpI_P16.error;
	
	palletStopP17old := TON_PalletStopP17.Q;
	
	//edge alarms
	IF acknowledgeImagePalletization[6] THEN
		alarmImagePalletization[6] := FALSE;
	END_IF
	
	IF acknowledgeImagePalletization[4] THEN
		alarmImagePalletization[4] := FALSE;
	END_IF	
	
	IF EDGENEG(acknowledgeImagePalletization[26]) THEN
		acpI_P16.reset := TRUE;
	END_IF	

END_ACTION
