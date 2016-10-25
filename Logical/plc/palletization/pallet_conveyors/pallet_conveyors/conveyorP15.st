ACTION ConveyorP15: 

	acpI_P15.switchOn := TRUE;
	acpI_P15.speed := 500;
			
	CASE statePalletP15 OF
		
		palletNotPresent:
			
			acpI_P15.stop := NOT (cmdMovePalletP15 AND (statePalletP16 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP14;
		
		palletPresent:

			IF cmdMovePalletP15 AND (statePalletP16 = palletNotPresent OR diReset) THEN
				statePalletP15 := palletMoving;
			END_IF	
		
			acpI_P15.stop := TRUE;

		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP16.Q AND cmdMovePalletP15 AND NOT diReset THEN
				statePalletP16 := palletPresent;
				statePalletP15 := palletNotPresent;
				cmdMovePalletP15 := FALSE;
			END_IF	
		
			acpI_P15.stop := NOT cmdMovePalletP15;

	END_CASE

	//control of ACOPOSinverter
	acpI_P15();

END_ACTION
