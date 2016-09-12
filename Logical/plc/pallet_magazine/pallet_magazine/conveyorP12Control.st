
ACTION ConveyorP12Control: 
	
	//detect pallet on conveyor
	IF diPalletOnConveyorP12 THEN
		palletOnConveyorP12 := TRUE;
	END_IF

	IF modeOfOperation = modeNotReadyToStart THEN
		stateConveyor := stateConveyorUndefined;
	END_IF
	
	CASE stateConveyor OF
		
		stateConveyorUndefined:
			stateConveyor := stateConveyorEmpty;
		
		//conveyor is empty
		stateConveyorEmpty:
		
			IF palletOnConveyorP12 THEN
				stateConveyor := stateConveyorOccupied;
			END_IF
		
		//conveyor is occupied
		stateConveyorOccupied:
		
			IF cmdMovePallet AND NOT palletOnConveyorP13 THEN
				TON_ConveyorP12(IN := FALSE);
				stateConveyor := stateConveyorMoving;
			END_IF
		
		//start conveyor
		stateConveyorMoving:
			doConveyorP12 := TRUE;
			//start timer		
			TON_ConveyorP12(IN := TRUE, PT := T#6s);
			//sensor reached?
			IF palletOnConveyorP13 THEN
				palletOnConveyorP12 := FALSE;
				stateConveyor := stateConveyorStop;
			END_IF	
			//timeout?
			IF TON_ConveyorP12.Q THEN
				alarmImage[14] := TRUE;
				stateConveyor := stateConveyorStop;
			END_IF
		
		//stop conveyor
		stateConveyorStop:
			doConveyorP12 := FALSE;
			stateConveyor := stateConveyorEmpty;
		
	END_CASE
	
		
	//edge alarms
	IF acknowledgeImage[14] THEN
		alarmImage[14] := FALSE;
	END_IF
	
END_ACTION
