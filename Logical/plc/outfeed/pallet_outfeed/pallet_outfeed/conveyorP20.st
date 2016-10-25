ACTION ConveyorP20: 

	CASE statePalletP20 OF
		
		palletNotPresent:
			
			doConveyorP20 := (cmdMovePalletP20 AND (statePalletP21 = palletNotPresent OR diReset)) OR cmdMovePalletP19;

		palletPresent:

			IF cmdMovePalletP20 AND (statePalletP21 = palletNotPresent OR diReset) THEN
				statePalletP20 := palletMoving;
			END_IF	
		
			doConveyorP20 := FALSE;

		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP21.Q AND cmdMovePalletP20 AND NOT diReset THEN
				statePalletP21 := palletPresent;
				statePalletP20 := palletNotPresent;
				cmdMovePalletP20 := FALSE;
			END_IF	
		
			doConveyorP20 := cmdMovePalletP20;

	END_CASE	
	
END_ACTION
