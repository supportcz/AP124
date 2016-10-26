PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	TON_PalletStopP13(IN := diPalletStopP13, PT := T#200ms);
	TON_PalletStopP14(IN := diPalletStopP14, PT := T#200ms);
	TON_PalletStopP15(IN := diPalletStopP15, PT := T#200ms);
	TON_PalletStopP16(IN := diPalletStopP16, PT := T#200ms);
	TON_PalletStopP17(IN := diPalletStopP17, PT := T#200ms);
	TON_PalletStopP18(IN := diPalletStopP18, PT := T#200ms);
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
		

		modePalletizationManual:
			
			IF modePalletizationOld <> modePalletizationManual THEN
				cmdMovePalletP12 := FALSE;
				cmdMovePalletP13 := FALSE;
				cmdMovePalletP14 := FALSE;
				cmdMovePalletP15 := FALSE;
				cmdMovePalletP16 := FALSE;
				cmdMovePalletP17 := FALSE;
			END_IF

		modePalletizationAuto:
			
			//stop sensor not reached
			TON_ConveyorP12(IN := cmdMovePalletP12, PT := T#20s);
			alarmImagePalletization[0] := TON_ConveyorP12.Q;

			TON_ConveyorP13(IN := cmdMovePalletP13, PT := T#20s);
			alarmImagePalletization[2] := TON_ConveyorP13.Q;

			TON_ConveyorP14(IN := cmdMovePalletP14, PT := T#20s);
			alarmImagePalletization[7] := TON_ConveyorP14.Q;

			TON_ConveyorP15(IN := cmdMovePalletP15, PT := T#20s);
			alarmImagePalletization[3] := TON_ConveyorP15.Q;

			TON_ConveyorP16(IN := cmdMovePalletP16, PT := T#20s);
			alarmImagePalletization[6] := TON_ConveyorP16.Q;
			
			TON_ConveyorP17(IN := cmdMovePalletP17, PT := T#20s);
			alarmImagePalletization[30] := TON_ConveyorP17.Q;
			
			
			// control conveyors
			IF statePalletP12 <> palletNotPresent AND statePalletP13 = palletNotPresent AND modeMagazine = modeMagazineAuto THEN
				cmdMovePalletP12 := TRUE;
			END_IF

			IF statePalletP13 <> palletNotPresent AND statePalletP14 = palletNotPresent THEN
				cmdMovePalletP13 := TRUE;
			END_IF

			IF statePalletP14 <> palletNotPresent AND statePalletP15 = palletNotPresent THEN
				cmdMovePalletP14 := TRUE;
			END_IF

			IF statePalletP15 <> palletNotPresent AND statePalletP16 = palletNotPresent THEN
				cmdMovePalletP15 := TRUE;
			END_IF

			IF statePalletP16 <> palletNotPresent AND statePalletP17 = palletNotPresent THEN
				cmdMovePalletP16 := TRUE;
			END_IF

			IF statePalletP17 <> palletNotPresent AND statePalletP18 = palletNotPresent THEN
				cmdMovePalletP17 := TRUE;
			END_IF
		
			//unexpected pallet
			IF TON_PalletStopP13.Q AND statePalletP13 = palletNotPresent AND NOT cmdMovePalletP12 THEN
				alarmImagePalletization[9] := TRUE;
			END_IF	
			IF TON_PalletStopP14.Q AND statePalletP14 = palletNotPresent AND NOT cmdMovePalletP13 THEN
				alarmImagePalletization[10] := TRUE;
			END_IF	
			IF TON_PalletStopP15.Q AND statePalletP15 = palletNotPresent AND NOT cmdMovePalletP14 THEN
				alarmImagePalletization[11] := TRUE;
			END_IF	
			IF TON_PalletStopP16.Q AND statePalletP16 = palletNotPresent AND NOT cmdMovePalletP15 THEN
				alarmImagePalletization[1] := TRUE;
			END_IF	
			IF TON_PalletStopP17.Q AND statePalletP17 = palletNotPresent AND NOT cmdMovePalletP16 THEN
				alarmImagePalletization[4] := TRUE;
			END_IF	
			IF TON_PalletStopP18.Q AND statePalletP18 = palletNotPresent AND NOT cmdMovePalletP17 THEN
				alarmImagePalletization[31] := TRUE;
			END_IF	
		

	END_CASE

	
	//conveyors
	ConveyorP12; 
	ConveyorP13; 
	ConveyorP14; 
	ConveyorP15; 
	ConveyorP16; 
	ConveyorP17; 

	//stop sensor not reached
	IF acknowledgeImagePalletization[0] THEN
		alarmImagePalletization[0] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[2] THEN
		alarmImagePalletization[2] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[7] THEN
		alarmImagePalletization[7] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[3] THEN
		alarmImagePalletization[3] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[6] THEN
		alarmImagePalletization[6] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[30] THEN
		alarmImagePalletization[30] := FALSE;
	END_IF
	
	
	//unexpected pallet	
	IF acknowledgeImagePalletization[9] THEN
		alarmImagePalletization[9] := FALSE;
	END_IF	
	IF acknowledgeImagePalletization[10] THEN
		alarmImagePalletization[10] := FALSE;
	END_IF	
	IF acknowledgeImagePalletization[11] THEN
		alarmImagePalletization[11] := FALSE;
	END_IF	
	IF acknowledgeImagePalletization[1] THEN
		alarmImagePalletization[1] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[4] THEN
		alarmImagePalletization[4] := FALSE;
	END_IF	
	IF acknowledgeImagePalletization[31] THEN
		alarmImagePalletization[31] := FALSE;
	END_IF	
	

	
	//problems with motors
	alarmImagePalletization[5] := NOT lightCurtainP15;
	alarmImagePalletization[12] := NOT diMotorProtectionP12;
	alarmImagePalletization[13] := NOT diMotorProtectionP13;

	alarmImagePalletization[24] := acpI_P14.error;
	acpI_P14.reset := EDGENEG(acknowledgeImagePalletization[24]);

	alarmImagePalletization[25] := acpI_P15.error;
	acpI_P15.reset := EDGENEG(acknowledgeImagePalletization[25]);

	alarmImagePalletization[26] := acpI_P16.error;
	acpI_P16.reset := EDGENEG(acknowledgeImagePalletization[26]);

	alarmImagePalletization[29] := acpI_P17.error;
	acpI_P17.reset := EDGENEG(acknowledgeImagePalletization[29]);

END_PROGRAM
