ACTION ConveyorP16: 

	acpI_P16.switchOn := TRUE;
	acpI_P16.speed := 500;
			
	CASE statePalletP16 OF
		
		palletNotPresent:
			
			acpI_P16.stop := NOT (cmdMovePalletP16 AND (statePalletP17 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP15;
		
		palletPresent:

			IF cmdMovePalletP16 AND (statePalletP17 = palletNotPresent OR diReset) THEN
				statePalletP16 := palletMoving;
			END_IF	
		
			acpI_P16.stop := TRUE;

		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP17.Q AND cmdMovePalletP16 AND NOT diReset THEN
				statePalletP17 := palletPresent;
				statePalletP16 := palletNotPresent;
				cmdMovePalletP16 := FALSE;
			END_IF	

			acpI_P16.stop := NOT cmdMovePalletP16;

	END_CASE

	//control of ACOPOSinverter
	acpI_P16();
	
END_ACTION
