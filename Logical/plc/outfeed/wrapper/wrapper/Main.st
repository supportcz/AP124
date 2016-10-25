PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor2opened;
	
	TON_PalletStopP19(IN := diPalletStopP19, PT := T#200ms);

	
	CASE modeOutfeed OF
		
		modeOutfeedNotReadyToStart: //the automat is not ready to start
		
			acpI_P18.reset := TRUE;


		modeOutfeedManual:
			
			IF modeOutfeedOld <> modeOutfeedManual THEN
				cmdMovePalletP18 := FALSE;

			END_IF

		modeOutfeedAuto:
	
			//stop sensor not reached
			TON_ConveyorP18(IN := cmdMovePalletP18, PT := T#20s);
			alarmImageOutfeed[4] := TON_ConveyorP18.Q;
			
			
			
			IF statePalletP18 <> palletNotPresent AND statePalletP19 = palletNotPresent THEN
				cmdMovePalletP18 := TRUE;
			END_IF

			//unexpected pallet
			IF TON_PalletStopP19.Q AND statePalletP19 = palletNotPresent AND NOT cmdMovePalletP18 THEN
				alarmImageOutfeed[5] := TRUE;
			END_IF			
	END_CASE

	
	//conveyors
	ConveyorP18; 

	//door logic
	DoorLogic_2();
	
	//sensor not reached
	IF acknowledgeImageOutfeed[4] THEN
		alarmImageOutfeed[4] := FALSE;
	END_IF

	//unexpected pallet	
	IF acknowledgeImageOutfeed[5] THEN
		alarmImageOutfeed[5] := FALSE;
	END_IF	
	
	//problems with motors
	alarmImageOutfeed[6] := acpI_P18.error;
	IF EDGENEG(acknowledgeImageOutfeed[6]) THEN
		acpI_P18.reset := TRUE;
	END_IF	
	
END_PROGRAM
