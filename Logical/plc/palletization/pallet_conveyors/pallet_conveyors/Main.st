PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
		
			acpI_P14.reset := TRUE;
			acpI_P15.reset := TRUE;
			acpI_P16.reset := TRUE;
			acpI_P17.reset := TRUE;


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
	
			IF statePalletP12 <> palletNotPresent AND statePalletP13 = palletNotPresent THEN
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
	END_CASE

	
	//conveyors
	ConveyorP12; 
	ConveyorP13; 
	ConveyorP14; 
	ConveyorP15; 
	ConveyorP16; 
	ConveyorP17; 

	alarmImagePalletization[5] := NOT lightCurtainP15;


	
END_PROGRAM
