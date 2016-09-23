
ACTION ConveyorP14P15Control: 
	
	IF modeMagazine = modeMagazineNotReadyToStart THEN
		stateConveyorP14P15 := stateConveyorStop;
	END_IF
	
	CASE stateConveyorP14P15 OF
		
		stateConveyorStop:
			
			cmdMovePalletP14P15 := FALSE;
			acpI_P14.switchOn := TRUE;
			acpI_P14.speed := 0;
			acpI_P14.reset := TRUE;
			acpI_P15.switchOn := TRUE;
			acpI_P15.speed := 0;
			acpI_P15.reset := TRUE;
			stateConveyorP14P15 := stateConveyorWait;
		
		stateConveyorWait:
		
			IF cmdMovePalletP14P15 THEN
				IF palletOnConveyorP15 THEN
					alarmImage[6] := TRUE;
					stateConveyorP14P15 := stateConveyorStop;
				ELSE
					TON_ConveyorP14P15(IN := FALSE);
					stateConveyorP14P15 := stateConveyorMoving;
				END_IF
			END_IF
		
		stateConveyorMoving:
			
			acpI_P14.speed := 500;
			acpI_P15.speed := 500;
			
			IF NOT cmdMovePalletP14P15 THEN
				stateConveyorP14P15 := stateConveyorStop;
			END_IF	
				
			//sensor reached?
			IF diPalletStopP15 THEN
				palletOnConveyorP14 := FALSE;
				stateConveyorP14P15 := stateConveyorStop;
			END_IF	
			
			//timeout?
			TON_ConveyorP14P15(IN := TRUE, PT := T#12s);
			IF TON_ConveyorP14P15.Q THEN
				alarmImage[7] := TRUE;
				stateConveyorP14P15 := stateConveyorStop;
			END_IF
		
	END_CASE
	
	//control of ACOPOSinverter P15
	acpI_P15();
	
	//detect pallet	
	IF diPalletStopP14 THEN
		palletOnConveyorP14 := TRUE;
	END_IF
		
	//edge alarms
	IF acknowledgeImage[6] THEN
		alarmImage[6] := FALSE;
	END_IF
	IF acknowledgeImage[7] THEN
		alarmImage[7] := FALSE;
	END_IF

END_ACTION
