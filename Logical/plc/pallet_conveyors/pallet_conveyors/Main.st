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
				stateAuto := stateAutoUndefined;
			END_IF
			cmdManual := FALSE;

		modeConveyorsAuto:
		
			IF alarmInZoneConveyors OR cmdManual THEN 
				modeConveyors := modeConveyorsManual;
			END_IF
		
			CASE stateAuto OF
				
				stateAutoUndefined:
					
					stateAuto := stateAutoWaitForPallet;
				
				stateAutoWaitForPallet:
					
					IF palletOnConveyorP12 AND NOT palletOnConveyorP13 THEN
						stateAuto := stateAutoMovePallet;
					END_IF
				
				stateAutoMovePallet:
					
					cmdMovePalletP12P13 := TRUE;
					stateAuto := stateAutoWaitForSensor;
				
				stateAutoWaitForSensor:
					
					IF palletOnConveyorP13 THEN
						stateAuto := stateAutoWaitForPallet;
					END_IF
				
			END_CASE

	END_CASE
	
	//detect pallet on conveyor
	IF diPalletOnConveyorP13 THEN
		palletOnConveyorP13 := TRUE;
	END_IF
	
	//conveyor P12 + P13
	ConveyorP12P13Control; 

	//detect if there is any alarm 
	alarmInZoneConveyors := FALSE;
	FOR i:=0 TO 39 DO
		IF alarmImage[i] OR acknowledgeImage[i] THEN
			alarmInZoneConveyors := TRUE;
		END_IF
	END_FOR
	 
END_PROGRAM
