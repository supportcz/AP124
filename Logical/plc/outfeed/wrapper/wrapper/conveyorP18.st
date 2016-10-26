ACTION ConveyorP18: 
	
	acpI_P18_1.switchOn := TRUE;
	acpI_P18_1.speed := 500;
			
	CASE statePalletP18 OF
		
		palletNotPresent:
			
			acpI_P18_1.run := (cmdMovePalletP18 AND (statePalletP18 = palletNotPresent OR diReset)) OR cmdMovePalletP17;
		
		palletPresent:
		
			acpI_P18_1.run := FALSE;

			IF cmdMovePalletP18 AND (statePalletP18 = palletNotPresent OR diReset) THEN
				statePalletP18 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP19.Q AND cmdMovePalletP18 AND NOT diReset THEN
				statePalletP19 := palletPresent;
				statePalletP18 := palletNotPresent;
				cmdMovePalletP18 := FALSE;
			END_IF	

			acpI_P18_1.run := cmdMovePalletP18;
			
	END_CASE

	//control of ACOPOSinverter
	acpI_P18_1();

END_ACTION
