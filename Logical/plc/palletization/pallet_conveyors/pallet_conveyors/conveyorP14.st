

ACTION ConveyorP14: 
	

	acpI_P14.switchOn := TRUE;
	acpI_P14.speed := 500;
	

	
	CASE statePalletP14 OF
		
		palletNotPresent:
			
			acpI_P14.stop := NOT (cmdMovePalletP14 AND (statePalletP15 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP13;
			
			//slow down sensor?
			IF diPalletSlowDownP14 THEN
				acpI_P14.speed := 200;
			END_IF
		
		palletPresent:
		
			acpI_P14.stop := TRUE;

			IF cmdMovePalletP14 AND (statePalletP15 = palletNotPresent OR diReset) THEN
				TON_ConveyorP14(IN := FALSE);
				statePalletP14 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP15.Q AND cmdMovePalletP14 AND NOT diReset THEN
				statePalletP15 := palletPresent;
				statePalletP14 := palletNotPresent;
				cmdMovePalletP14 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP14(IN := TRUE, PT := T#20s);
				IF TON_ConveyorP14.Q THEN
					alarmImagePalletization[7] := TRUE;
					cmdMovePalletP14 := FALSE;
				END_IF
			END_IF
		
			acpI_P14.stop := NOT cmdMovePalletP14;
			
			IF NOT cmdMovePalletP14 THEN
				TON_ConveyorP14(IN := FALSE);
			END_IF	
		
	END_CASE

	//control of ACOPOSinverter
	acpI_P14();
	
	
	// alarms
	IF acknowledgeImagePalletization[7] THEN
		alarmImagePalletization[7] := FALSE;
	END_IF

	
	alarmImagePalletization[24] := acpI_P14.error;
	IF EDGENEG(acknowledgeImagePalletization[24]) THEN
		acpI_P14.reset := TRUE;
	END_IF	

END_ACTION
