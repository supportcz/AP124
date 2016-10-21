PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor2opened;
	diOpenDoors2;
	diCloseDoors2; 
	
	TON_PalletStopP19(IN := diPalletStopP19, PT := T#200ms);

	
	CASE modeOutfeed OF
		
		modeOutfeedNotReadyToStart: //the automat is not ready to start
		
			acpI_P18.reset := TRUE;


		modeOutfeedManual:
			
			IF modeOutfeedOld <> modeOutfeedManual THEN
				cmdMovePalletP18 := FALSE;

			END_IF

		modeOutfeedAuto:
	
			IF statePalletP18 <> palletNotPresent AND statePalletP19 = palletNotPresent THEN
				cmdMovePalletP18 := TRUE;
			END_IF

	
			IF TON_PalletStopP19.Q AND statePalletP19 = palletNotPresent AND NOT cmdMovePalletP18 THEN
//				statePalletP19 := palletPresent;
				alarmImageOutfeed[5] := TRUE;
			END_IF			
	END_CASE

	
	//conveyors
	ConveyorP18; 

	
	IF acknowledgeImageOutfeed[5] THEN
		alarmImageOutfeed[5] := FALSE;
	END_IF	
	
END_PROGRAM
