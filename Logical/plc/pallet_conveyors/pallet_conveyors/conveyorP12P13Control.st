
ACTION ConveyorP12P13Control: 


	IF modeMagazine = modeMagazineNotReadyToStart THEN
		stateConveyorP12P13 := stateConveyorStop;
	END_IF
	
	CASE stateConveyorP12P13 OF
		
		stateConveyorStop:
			
			cmdMovePalletP12P13 := FALSE;
			doConveyorP12 := FALSE;
			doConveyorP13 := FALSE;
			stateConveyorP12P13 := stateConveyorWait;
		
		stateConveyorWait:
		
			IF cmdMovePalletP12P13 THEN
				TON_ConveyorP12P13(IN := FALSE);
				stateConveyorP12P13 := stateConveyorMoving;
			END_IF
		
		stateConveyorMoving:
			
			doConveyorP12 := TRUE;
			doConveyorP13 := TRUE;

			//start timer		
			TON_ConveyorP12P13(IN := TRUE, PT := T#6s);
			
			IF NOT cmdMovePalletP12P13 THEN
				stateConveyorP12P13 := stateConveyorStop;
			END_IF	
				
			//sensor reached?
			IF palletOnConveyorP13 THEN
				palletOnConveyorP12 := FALSE;
				stateConveyorP12P13 := stateConveyorStop;
			END_IF	
			//timeout?
			IF TON_ConveyorP12P13.Q THEN
				alarmImage[0] := TRUE;
				stateConveyorP12P13 := stateConveyorStop;
			END_IF
		
	END_CASE
	
		
	//edge alarms
	IF acknowledgeImage[0] THEN
		alarmImage[0] := FALSE;
	END_IF
	
END_ACTION
