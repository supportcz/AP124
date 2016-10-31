ACTION ConveyorP19: 

	CASE statePalletP19 OF
		
		palletNotPresent:

			doConveyorP19 := (cmdMovePalletP19 AND (statePalletP20 = palletNotPresent OR diReset)) OR (cmdMovePalletP18 AND stateTurnTable = stateTurnTableExitPosition);
			
		palletPresent:	

			IF cmdMovePalletP19 AND (statePalletP20 = palletNotPresent OR diReset) THEN
				statePalletP19 := palletMoving;
			END_IF	
			
			doConveyorP19 := FALSE;
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP20.Q AND cmdMovePalletP19 AND NOT diReset THEN
				statePalletP20 := palletPresent;
				statePalletP19 := palletNotPresent;
				cmdMovePalletP19 := FALSE;
			END_IF	

			doConveyorP19 := cmdMovePalletP19;
		
	END_CASE

END_ACTION
