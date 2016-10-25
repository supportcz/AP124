

ACTION ConveyorP16: 


	acpI_P16.switchOn := TRUE;
	acpI_P16.speed := 500;
			
	CASE statePalletP16 OF
		
		palletNotPresent:
			
			acpI_P16.stop := NOT (cmdMovePalletP16 AND (statePalletP17 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP15;
		
		palletPresent:
		
			acpI_P16.stop := TRUE;

			IF cmdMovePalletP16 AND (statePalletP17 = palletNotPresent OR diReset) THEN
				TON_ConveyorP16(IN := FALSE);
				statePalletP16 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP17.Q AND cmdMovePalletP16 AND NOT diReset THEN
				statePalletP17 := palletPresent;
				statePalletP16 := palletNotPresent;
				cmdMovePalletP16 := FALSE;
			END_IF	

			//timeout?
			IF modePalletization = modePalletizationAuto THEN
				TON_ConveyorP16(IN := TRUE, PT := T#20s);
				IF TON_ConveyorP16.Q THEN
					alarmImagePalletization[6] := TRUE;
					cmdMovePalletP16 := FALSE;
				END_IF
			END_IF
		
			acpI_P16.stop := NOT cmdMovePalletP16;
			
			IF NOT cmdMovePalletP16 THEN
				TON_ConveyorP16(IN := FALSE);
			END_IF	
	END_CASE

	//control of ACOPOSinverter
	acpI_P16();
	
	
				
	//alarms
	IF acknowledgeImagePalletization[6] THEN
		alarmImagePalletization[6] := FALSE;
	END_IF



END_ACTION
