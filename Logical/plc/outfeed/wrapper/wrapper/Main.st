PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	TON_PalletStopP19(IN := diPalletStopP19, PT := T#200ms);

	
	CASE modeZoneOutfeed OF
		
		modeZoneOff: //the automat is not ready to start

		modeZoneManual:
			
			IF modeZoneOutfeedOld <> modeZoneManual THEN
				cmdMovePalletP18 := FALSE;

			END_IF

		modeZoneAuto:
	
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

	
	//modules
	ConveyorP18; 
	TurnTable;

	//door logic
	DoorLogic_2();
	alarmImageOutfeed[15] := NOT DoorLogic_2.diDoorLocked;
	


	
	//sensor not reached
	IF acknowledgeImageOutfeed[4] THEN
		alarmImageOutfeed[4] := FALSE;
	END_IF

	//unexpected pallet	
	IF acknowledgeImageOutfeed[5] THEN
		alarmImageOutfeed[5] := FALSE;
	END_IF	
	
	//problems with motors
	alarmImageOutfeed[6] := acpI_P18_1.error;
	acpI_P18_1.reset := EDGENEG(acknowledgeImageOutfeed[6]);

	alarmImageOutfeed[14] := acpI_P18_2.error;
	acpI_P18_2.reset := EDGENEG(acknowledgeImageOutfeed[14]);
	
END_PROGRAM
