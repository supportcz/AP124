ACTION ConveyorP18: 
	
	RETURN;
	


	acpI_P18.switchOn := TRUE;
	acpI_P18.speed := 500;
			
	CASE statePalletP18 OF
		
		palletNotPresent:
			
			acpI_P18.stop := NOT (cmdMovePalletP18 AND (statePalletP18 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP17;
		
		palletPresent:
		
			acpI_P18.stop := TRUE;

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

			acpI_P18.stop := NOT cmdMovePalletP18;
			
	END_CASE

	//control of ACOPOSinverter
	acpI_P18();

END_ACTION
