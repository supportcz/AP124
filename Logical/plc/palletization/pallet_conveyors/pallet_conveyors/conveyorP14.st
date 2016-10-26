ACTION ConveyorP14: 

	acpI_P14.switchOn := TRUE;
	acpI_P14.speed := 500;
	
	CASE statePalletP14 OF
		
		palletNotPresent:
			
			acpI_P14.run := (cmdMovePalletP14 AND (statePalletP15 = palletNotPresent OR diReset)) OR cmdMovePalletP13;
			
			//slow down sensor?
			IF diPalletSlowDownP14 THEN
				acpI_P14.speed := 200;
			END_IF
		
		palletPresent:
		
			IF cmdMovePalletP14 AND (statePalletP15 = palletNotPresent OR diReset) THEN
				statePalletP14 := palletMoving;
			END_IF	
		
			acpI_P14.run := FALSE;

		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP15.Q AND cmdMovePalletP14 AND NOT diReset THEN
				statePalletP15 := palletPresent;
				statePalletP14 := palletNotPresent;
				cmdMovePalletP14 := FALSE;
			END_IF	

			acpI_P14.run := cmdMovePalletP14;
			
	END_CASE

	//control of ACOPOSinverter
	acpI_P14();
	
END_ACTION
