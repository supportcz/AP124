ACTION ConveyorP12: 
	
	CASE statePalletP12 OF
		
		palletNotPresent:
			
			doConveyorP12 := cmdMovePalletP12 AND (statePalletP13 = palletNotPresent OR diReset);
			
		palletPresent:
		
			IF cmdMovePalletP12 AND (statePalletP13 = palletNotPresent OR diReset) THEN
				statePalletP12 := palletMoving;
			END_IF	
		
			doConveyorP12 := FALSE;

		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP13.Q AND cmdMovePalletP12 AND NOT diReset THEN
				statePalletP13 := palletPresent;
				statePalletP12 := palletNotPresent;
				cmdMovePalletP12 := FALSE;
			END_IF	
		
			doConveyorP12 := cmdMovePalletP12;
			
	END_CASE
	
END_ACTION
