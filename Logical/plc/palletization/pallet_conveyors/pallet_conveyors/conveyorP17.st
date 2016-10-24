

ACTION ConveyorP17: 


	acpI_P17.switchOn := TRUE;
	acpI_P17.speed := 500;
			
	CASE statePalletP17 OF
		
		palletNotPresent:
			
			acpI_P17.stop := NOT (cmdMovePalletP17 AND (statePalletP18 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP16;
		
		palletPresent:
		
			acpI_P17.stop := TRUE;
//
//			IF cmdMovePalletP17 AND (statePalletP18 = palletNotPresent OR diReset) THEN
//				TON_ConveyorP17(IN := FALSE);
//				statePalletP17 := palletMoving;
//			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP18.Q AND cmdMovePalletP17 AND NOT diReset THEN
				statePalletP18 := palletPresent;
				statePalletP17 := palletNotPresent;
				cmdMovePalletP17 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP17(IN := TRUE, PT := T#20s);
				IF TON_ConveyorP17.Q THEN
					alarmImagePalletization[30] := TRUE;
					cmdMovePalletP17 := FALSE;
				END_IF
			ELSE
				TON_ConveyorP17(IN := FALSE);
			END_IF
		
			acpI_P17.stop := NOT cmdMovePalletP17;
			
			IF NOT cmdMovePalletP17 THEN
				TON_ConveyorP17(IN := FALSE);
			END_IF	
	END_CASE

	//control of ACOPOSinverter
	acpI_P17();
	
	//alarms
	IF acknowledgeImagePalletization[30] THEN
		alarmImagePalletization[30] := FALSE;
	END_IF
	
	alarmImagePalletization[29] := acpI_P17.error;
	IF EDGENEG(acknowledgeImagePalletization[29]) THEN
		acpI_P17.reset := TRUE;
	END_IF	

END_ACTION
