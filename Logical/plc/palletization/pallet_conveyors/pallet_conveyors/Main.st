PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
		


		modePalletizationManual:
			
			IF modePalletizationOld <> modePalletizationManual THEN
				cmdMovePalletP12 := FALSE;
				cmdMovePalletP13 := FALSE;
				cmdMovePalletP14 := FALSE;
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

	END_CASE

	
	//conveyors
	ConveyorP12Control; 
	ConveyorP13Control; 
	ConveyorP14Control; 
	ConveyorP15Control; 
	ConveyorP16Control; 

	alarmImagePalletization[5] := NOT lightCurtainP15;
	alarmImagePalletization[8] := NOT lightCurtainP17;

	
END_PROGRAM
