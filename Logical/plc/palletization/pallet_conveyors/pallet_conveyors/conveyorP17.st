ACTION ConveyorP17: 

	acpI_P17.switchOn := TRUE;
	acpI_P17.speed := 500;
			
	CASE statePalletP17 OF
		
		palletNotPresent:
			
			acpI_P17.stop := NOT (cmdMovePalletP17 AND (statePalletP18 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP16;
		
		palletPresent:
		
//			IF cmdMovePalletP17 AND (statePalletP18 = palletNotPresent OR diReset) THEN
//				statePalletP17 := palletMoving;
//			END_IF	

			acpI_P17.stop := TRUE;

		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP18.Q AND cmdMovePalletP17 AND NOT diReset THEN
				statePalletP18 := palletPresent;
				statePalletP17 := palletNotPresent;
				cmdMovePalletP17 := FALSE;
			END_IF	
		
			acpI_P17.stop := NOT cmdMovePalletP17;
			
	END_CASE

	//control of ACOPOSinverter
	acpI_P17();

END_ACTION
