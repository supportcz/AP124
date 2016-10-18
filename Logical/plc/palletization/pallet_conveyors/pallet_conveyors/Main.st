PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
		


		modePalletizationManual:


		modePalletizationAuto:
	
			IF statePalletP12 = palletPresent AND statePalletP13 = palletNotPresent THEN
				cmdMovePalletP12P13 := TRUE;
			END_IF

			IF statePalletP13 = palletPresent AND statePalletP14 = palletNotPresent THEN
				cmdMovePalletP13P14 := TRUE;
			END_IF

			IF statePalletP14 = palletPresent AND statePalletP15 = palletNotPresent THEN
				cmdMovePalletP14P15 := TRUE;
			END_IF

	END_CASE

	
	//conveyor P12 + P13
	ConveyorP12P13Control; 
//	ConveyorP13P14Control; 
//	ConveyorP14P15Control; 

	alarmImagePalletization[5] := NOT lightCurtainP15;
	alarmImagePalletization[8] := NOT lightCurtainP17;

	
END_PROGRAM
