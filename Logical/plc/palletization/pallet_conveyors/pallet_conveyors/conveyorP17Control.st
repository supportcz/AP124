

ACTION ConveyorP17Control: 

//	TON_PalletStopP17(IN := diPalletStopP17, PT := T#200ms);
	
	acpI_P17.switchOn := TRUE;
	acpI_P17.speed := 500;
			
	CASE statePalletP17 OF
		
		palletNotPresent:
			
//			acpI_P16.stop := NOT (cmdMovePalletP16 AND (statePalletP17 = palletNotPresent OR diReset)) AND NOT cmdMovePalletP15;

			acpI_P17.stop := NOT cmdMovePalletP17 AND NOT cmdMovePalletP16;
				
		
		palletPresent:
		
//			acpI_P16.stop := TRUE;
//
//			IF cmdMovePalletP16 AND (statePalletP17 = palletNotPresent OR diReset) THEN
//				TON_ConveyorP16(IN := FALSE);
//				statePalletP16 := palletMoving;
//			END_IF	
		
		palletMoving:
			
//			//sensor reached?
//			IF TON_PalletStopP17.Q AND NOT diReset THEN
//				statePalletP17 := palletPresent;
//				statePalletP16 := palletNotPresent;
//				cmdMovePalletP16 := FALSE;
//			END_IF	
//
//			//timeout?
//			IF modePalletization = modePalletizationAuto THEN
//				TON_ConveyorP16(IN := TRUE, PT := T#12s);
//				IF TON_ConveyorP16.Q THEN
//					alarmImagePalletization[6] := TRUE;
//					cmdMovePalletP16 := FALSE;
//				END_IF
//			ELSE
//				TON_ConveyorP16(IN := FALSE);
//			END_IF
//		
//			acpI_P16.stop := NOT cmdMovePalletP16;
			
	END_CASE

	//control of ACOPOSinverter
	acpI_P17();
	
	alarmImagePalletization[29] := acpI_P16.error;
	
//	IF EDGEPOS(TON_PalletStopP17.Q) AND statePalletP17 <> palletMoving THEN
//		alarmImagePalletization[4] := TRUE;
//	END_IF	
	
//	palletStopP17old := TON_PalletStopP17.Q;
	
	//edge alarms
//	IF acknowledgeImagePalletization[6] THEN
//		alarmImagePalletization[6] := FALSE;
//	END_IF
//	
//	IF acknowledgeImagePalletization[4] THEN
//		alarmImagePalletization[4] := FALSE;
//	END_IF	
	
	IF EDGENEG(acknowledgeImagePalletization[29]) THEN
		acpI_P17.reset := TRUE;
	END_IF	

END_ACTION
