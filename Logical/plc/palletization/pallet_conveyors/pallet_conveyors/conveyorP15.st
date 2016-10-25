

ACTION ConveyorP15: 
	

	acpI_P15.switchOn := TRUE;
	acpI_P15.speed := 500;
			
	CASE statePalletP15 OF
		
		palletNotPresent:
			
			acpI_P15.stop := NOT (cmdMovePalletP15 AND (statePalletP16 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP14;

		
		palletPresent:
		
			acpI_P15.stop := TRUE;

			IF cmdMovePalletP15 AND (statePalletP16 = palletNotPresent OR diReset) THEN
				TON_ConveyorP15(IN := FALSE);
				statePalletP15 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP16.Q AND cmdMovePalletP15 AND NOT diReset THEN
				statePalletP16 := palletPresent;
				statePalletP15 := palletNotPresent;
				cmdMovePalletP15 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP15(IN := TRUE, PT := T#20s);
				IF TON_ConveyorP15.Q THEN
					alarmImagePalletization[3] := TRUE;
					cmdMovePalletP15 := FALSE;
				END_IF
			END_IF
		
			acpI_P15.stop := NOT cmdMovePalletP15;
			
			IF NOT cmdMovePalletP15 THEN
				TON_ConveyorP15(IN := FALSE);
			END_IF	
	END_CASE

	//control of ACOPOSinverter
	acpI_P15();
	
			
	// alarms
	IF acknowledgeImagePalletization[3] THEN
		alarmImagePalletization[3] := FALSE;
	END_IF



END_ACTION
