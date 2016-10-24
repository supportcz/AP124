
ACTION ConveyorP22: 

	TOF_PalletStopP22(IN := diPalletStopP22, PT := T#30s);

	IF NOT TOF_PalletStopP22.Q THEN
		statePalletP22 := palletNotPresent;
	END_IF	

	CASE statePalletP22 OF
		
		palletNotPresent:

			doConveyorP22 := (cmdMovePalletP22 AND diReset) OR cmdMovePalletP21;
			
		palletPresent:
		
			doConveyorP22 := FALSE;

//			IF cmdMovePalletP22 AND diReset THEN
//				statePalletP22 := palletMoving;
//			END_IF	
//		
		palletMoving:
			
			statePalletP22 := palletNotPresent;
//			doConveyorP22 := cmdMovePalletP22;
			
	END_CASE

		
	// alarms

	
END_ACTION
