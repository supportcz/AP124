PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
		


		modePalletizationManual:


		modePalletizationAuto:
	
			IF palletOnConveyorP12 AND NOT palletOnConveyorP13 THEN
				cmdMovePalletP12P13 := TRUE;
			END_IF

			IF palletOnConveyorP13 AND NOT palletOnConveyorP14 THEN
				cmdMovePalletP13P14 := TRUE;
			END_IF

			IF palletOnConveyorP14 AND NOT palletOnConveyorP15 THEN
				cmdMovePalletP14P15 := TRUE;
			END_IF

	END_CASE

	
	//conveyor P12 + P13
	ConveyorP12P13Control; 
	ConveyorP13P14Control; 
	ConveyorP14P15Control; 

	alarmImagePalletization[5] := NOT lightCurtainP15;
	alarmImagePalletization[8] := NOT lightCurtainP17;

	
END_PROGRAM
