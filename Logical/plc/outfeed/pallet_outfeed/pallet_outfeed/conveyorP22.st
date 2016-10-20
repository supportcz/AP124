
ACTION ConveyorP22: 

//	TON_PalletStopP22(IN := diPalletStopP22, PT := T#200ms);
//			
//	IF EDGEPOS(TON_PalletStopP22.Q) AND statePalletP22 <> palletMoving THEN
//		alarmImageOutfeed[10] := TRUE;
//	END_IF	

	CASE statePalletP22 OF
		
		palletNotPresent:

			doConveyorP22 := (cmdMovePalletP22 AND diReset) OR cmdMovePalletP21;
			
		palletPresent:
		
			doConveyorP22 := FALSE;

			IF cmdMovePalletP22 AND diReset THEN
//				TON_ConveyorP22(IN := FALSE);
				statePalletP22 := palletMoving;
			END_IF	
		
		palletMoving:
			
//			//sensor reached?
//			IF TON_PalletStopP22.Q AND NOT diReset THEN
//				statePalletP22 := palletPresent;
//				statePalletP22 := palletNotPresent;
//				cmdMovePalletP22 := FALSE;
//			END_IF	

//			//timeout?
//			IF modePalletization = modePalletizationAuto THEN
//				TON_ConveyorP22(IN := TRUE, PT := T#12s);
//				IF TON_ConveyorP22.Q THEN
//					alarmImageOutfeed[11] := TRUE;
//					cmdMovePalletP22 := FALSE;
//				END_IF
//			ELSE
//				TON_ConveyorP22(IN := FALSE);
//			END_IF
		
			doConveyorP22 := cmdMovePalletP22;
			
	END_CASE

		
	// alarms
	alarmImageOutfeed[13] := NOT diMotorProtectionP22;
//
//	IF alarmImageOutfeed[10] THEN
//		alarmImageOutfeed[10] := FALSE;
//	END_IF
//	
//	IF alarmImageOutfeed[11] THEN
//		alarmImageOutfeed[11] := FALSE;
//	END_IF	
	
END_ACTION
