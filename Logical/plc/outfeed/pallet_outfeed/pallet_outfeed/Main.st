PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
		 
	CASE modeOutfeed OF
		
		modeOutfeedNotReadyToStart: //the automat is not ready to start
		

		modeOutfeedManual:
			
			IF modeOutfeedOld <> modeOutfeedManual THEN
				cmdMovePalletP19 := FALSE;
				cmdMovePalletP20 := FALSE;
				cmdMovePalletP21 := FALSE;
				cmdMovePalletP22 := FALSE;
			END_IF

		modeOutfeedAuto:

			IF statePalletP19 <> palletNotPresent AND statePalletP20 = palletNotPresent THEN
				cmdMovePalletP19 := TRUE;
			END_IF

			IF statePalletP20 <> palletNotPresent AND statePalletP21 = palletNotPresent THEN
				cmdMovePalletP20 := TRUE;
			END_IF

			IF statePalletP21 <> palletNotPresent AND statePalletP22 = palletNotPresent THEN
				cmdMovePalletP21 := TRUE;
			END_IF

			IF statePalletP22 <> palletNotPresent THEN
				cmdMovePalletP22 := TRUE;
			END_IF
		
	END_CASE

	
	//conveyors
	ConveyorP19; 
	ConveyorP20; 
	
	alarmImageOutfeed[0] := NOT lightCurtainP17;
	
END_PROGRAM
