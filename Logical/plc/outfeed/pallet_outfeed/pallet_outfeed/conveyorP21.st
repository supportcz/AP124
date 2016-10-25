ACTION ConveyorP21: 

	CASE statePalletP21 OF
		
		palletNotPresent:

			doConveyorP21 := (cmdMovePalletP21 AND (statePalletP22 = palletNotPresent OR diReset)) OR cmdMovePalletP20;
			
		palletPresent:
		
			IF cmdMovePalletP21 AND (statePalletP22 = palletNotPresent OR diReset) THEN
				statePalletP21 := palletMoving;
			END_IF	
		
			doConveyorP21 := FALSE;

		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP22.Q AND cmdMovePalletP21 AND NOT diReset THEN
				statePalletP22 := palletPresent;
				statePalletP21 := palletNotPresent;
				cmdMovePalletP21 := FALSE;
			END_IF	

			doConveyorP21 := cmdMovePalletP21;
			
	END_CASE
	
END_ACTION
