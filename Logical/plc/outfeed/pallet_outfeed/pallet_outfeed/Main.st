PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
		 
	TON_PalletStopP20(IN := diPalletStopP20, PT := T#200ms);
	TON_PalletStopP21(IN := diPalletStopP21, PT := T#200ms);
	TON_PalletStopP22(IN := diPalletStopP22, PT := T#200ms);
	
	CASE modeZoneOutfeed OF
		
		modeZoneOff: //the automat is not ready to start
		

		modeZoneManual:
			
			IF modeZoneOutfeedOld <> modeZoneManual THEN
				cmdMovePalletP19 := FALSE;
				cmdMovePalletP20 := FALSE;
				cmdMovePalletP21 := FALSE;
				cmdMovePalletP22 := FALSE;
			END_IF

		modeZoneAuto:
			
			//stop sensor not reached
			TON_ConveyorP19(IN := cmdMovePalletP19, PT := T#20s);
			alarmImageOutfeed[1] := TON_ConveyorP19.Q;
			
			TON_ConveyorP20(IN := cmdMovePalletP20, PT := T#20s);
			alarmImageOutfeed[8] := TON_ConveyorP20.Q;
			
			TON_ConveyorP21(IN := cmdMovePalletP21, PT := T#20s);
			alarmImageOutfeed[11] := TON_ConveyorP21.Q;

			
			// control conveyors			
			IF NOT testAtAtrima THEN	
				IF statePalletP19 <> palletNotPresent AND statePalletP20 = palletNotPresent THEN
					cmdMovePalletP19 := TRUE;
				END_IF
			END_IF
			
			IF statePalletP20 <> palletNotPresent AND statePalletP21 = palletNotPresent THEN
				cmdMovePalletP20 := TRUE;
			END_IF

			IF statePalletP21 <> palletNotPresent AND statePalletP22 = palletNotPresent THEN
				cmdMovePalletP21 := TRUE;
			END_IF
		
			//unexpected pallet
			IF TON_PalletStopP20.Q AND statePalletP20 = palletNotPresent AND NOT cmdMovePalletP19 THEN
				alarmImageOutfeed[2] := TRUE;
			END_IF	
			IF TON_PalletStopP21.Q AND statePalletP21 = palletNotPresent AND NOT cmdMovePalletP20 THEN
				alarmImageOutfeed[7] := TRUE;
			END_IF		
			IF TON_PalletStopP22.Q AND statePalletP22 = palletNotPresent AND NOT cmdMovePalletP21 THEN
				alarmImageOutfeed[10] := TRUE;
			END_IF	
		
	END_CASE

	
	//conveyors
	ConveyorP19; 
	ConveyorP20; 
	ConveyorP21; 
	ConveyorP22; 

	//stop sensor not reached
	IF acknowledgeImageOutfeed[1] THEN
		alarmImageOutfeed[1] := FALSE;
	END_IF
	IF acknowledgeImageOutfeed[8] THEN
		alarmImageOutfeed[8] := FALSE;
	END_IF	
	IF acknowledgeImageOutfeed[11] THEN
		alarmImageOutfeed[11] := FALSE;
	END_IF	

	//unexpected pallet
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
