PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	readyToStart := NOT diPalletizationEDM;
	
	IF NOT readyToStart THEN
		modeConveyors := modeConveyorsNotReadyToStart; 
	END_IF

	CASE modeConveyors OF
		
		modeConveyorsNotReadyToStart: //the automat is not ready to start
			
			IF readyToStart THEN
				modeConveyors := modeConveyorsManual;
			END_IF
		
		modeConveyorsManual:

			IF NOT alarmInZoneConveyors AND cmdAuto THEN
				cmdAuto := FALSE;
				modeConveyors := modeConveyorsAuto;
			END_IF
			cmdManual := FALSE;

		modeConveyorsAuto:
		
			IF alarmInZoneConveyors OR cmdManual THEN 
				modeConveyors := modeConveyorsManual;
			END_IF
		
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
	
	alarmImage[5] := NOT lightCurtainP15;
	alarmImage[8] := NOT lightCurtainP17;
	
	//detect if there is any alarm 
	alarmInZoneConveyors := FALSE;
	FOR i:=0 TO 39 DO
		IF alarmImage[i] OR acknowledgeImage[i] THEN
			alarmInZoneConveyors := TRUE;
		END_IF
	END_FOR
	 
END_PROGRAM
