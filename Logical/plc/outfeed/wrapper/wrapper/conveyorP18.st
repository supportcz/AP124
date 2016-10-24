

ACTION ConveyorP18: 
	
	RETURN;
	


	acpI_P18.switchOn := TRUE;
	acpI_P18.speed := 500;
			
	CASE statePalletP18 OF
		
		palletNotPresent:
			
			acpI_P18.stop := NOT (cmdMovePalletP18 AND (statePalletP18 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP17;
		
		palletPresent:
		
			acpI_P18.stop := TRUE;

			IF cmdMovePalletP18 AND (statePalletP18 = palletNotPresent OR diReset) THEN
				TON_ConveyorP18(IN := FALSE);
				statePalletP18 := palletMoving;
			END_IF	
		
		palletMoving:
			
			//sensor reached?
			IF TON_PalletStopP19.Q AND cmdMovePalletP18 AND NOT diReset THEN
				statePalletP19 := palletPresent;
				statePalletP18 := palletNotPresent;
				cmdMovePalletP18 := FALSE;
			END_IF	

			//timeout?
			IF modeOutfeed = modeOutfeedAuto THEN
				TON_ConveyorP18(IN := TRUE, PT := T#20s);
				IF TON_ConveyorP18.Q THEN
					alarmImageOutfeed[4] := TRUE;
					cmdMovePalletP18 := FALSE;
				END_IF
			END_IF
		
			acpI_P18.stop := NOT cmdMovePalletP18;
			
			IF NOT cmdMovePalletP18 THEN
				TON_ConveyorP18(IN := FALSE);
			END_IF	
		
	END_CASE

	//control of ACOPOSinverter
	acpI_P18();
	

	//alarms
	IF acknowledgeImageOutfeed[4] THEN
		alarmImageOutfeed[4] := FALSE;
	END_IF

	
	alarmImageOutfeed[6] := acpI_P18.error;
	IF EDGENEG(acknowledgeImageOutfeed[6]) THEN
		acpI_P18.reset := TRUE;
	END_IF	

END_ACTION
