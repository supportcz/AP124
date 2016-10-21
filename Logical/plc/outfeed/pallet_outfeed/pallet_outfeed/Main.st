PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
		 
	TON_PalletStopP20(IN := diPalletStopP20, PT := T#200ms);
	TON_PalletStopP21(IN := diPalletStopP21, PT := T#200ms);
	TON_PalletStopP22(IN := diPalletStopP22, PT := T#200ms);
	
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
		
			//not expected pallet
			IF TON_PalletStopP20.Q AND statePalletP20 = palletNotPresent AND NOT cmdMovePalletP19 THEN
//				statePalletP20 := palletPresent;
				alarmImageOutfeed[2] := TRUE;
			END_IF	
			IF TON_PalletStopP21.Q AND statePalletP21 = palletNotPresent AND NOT cmdMovePalletP20 THEN
//				statePalletP21 := palletPresent;
				alarmImageOutfeed[7] := TRUE;
			END_IF		
			IF TON_PalletStopP22.Q AND statePalletP22 = palletNotPresent AND NOT cmdMovePalletP21 THEN
//				statePalletP22 := palletPresent;
				alarmImageOutfeed[10] := TRUE;
			END_IF	
		
	END_CASE

	
	//conveyors
	ConveyorP19; 
	ConveyorP20; 
	ConveyorP21; 
	ConveyorP22; 
	
	alarmImageOutfeed[0] := NOT lightCurtainP17;
	
	IF acknowledgeImageOutfeed[2] THEN
		alarmImageOutfeed[2] := FALSE;
	END_IF	
	IF acknowledgeImageOutfeed[7] THEN
		alarmImageOutfeed[7] := FALSE;
	END_IF
	IF acknowledgeImageOutfeed[10] THEN
		alarmImageOutfeed[10] := FALSE;
	END_IF
END_PROGRAM
