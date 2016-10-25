ACTION ConveyorP13: 
	
	CASE statePalletP13 OF
		
		palletNotPresent:
			
			doConveyorP13 := (cmdMovePalletP13 AND (statePalletP14 = palletNotPresent OR diReset)) OR cmdMovePalletP12;
		
		palletPresent:
		
			IF cmdMovePalletP13 AND (statePalletP14 = palletNotPresent OR diReset) THEN
				statePalletP13 := palletMoving;
			END_IF	
		
			doConveyorP13 := FALSE;

		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP14.Q AND cmdMovePalletP13 AND NOT diReset THEN
				statePalletP14 := palletPresent;
				statePalletP13 := palletNotPresent;
				cmdMovePalletP13 := FALSE;
			END_IF	

			doConveyorP13 := cmdMovePalletP13;
		
	END_CASE
	
END_ACTION
