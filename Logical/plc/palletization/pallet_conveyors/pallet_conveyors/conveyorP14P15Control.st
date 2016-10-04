
ACTION ConveyorP14P15Control: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateConveyorP14P15 := stateConveyorStop;
	END_IF
	
	//detect pallet	
	IF diPalletStopP15 THEN
		palletOnConveyorP15 := TRUE;
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
			IF modePalletization <> modePalletizationNotReadyToStart THEN
				stateConveyorP14P15 := stateConveyorWait;
			END_IF
		
		stateConveyorWait:
		
			IF cmdMovePalletP14P15 THEN
				IF palletOnConveyorP15 AND NOT diReset THEN
					alarmImagePalletization[6] := TRUE;
					stateConveyorP14P15 := stateConveyorStop;
				ELSE
					TON_ConveyorP14P15(IN := FALSE);
					stateConveyorP14P15 := stateConveyorMoving;
				END_IF
			END_IF
		
			IF palletOnConveyorP15 > palletOnConveyorP15old THEN
				alarmImagePalletization[11] := TRUE;
				stateConveyorP14P15 := stateConveyorStop;
			END_IF	
		
		stateConveyorMoving:
			
			acpI_P14.speed := 500;
			acpI_P15.speed := 500;
			
			IF NOT cmdMovePalletP14P15 THEN
				stateConveyorP14P15 := stateConveyorStop;
			END_IF	
				
			//sensor reached?
			IF palletOnConveyorP15 AND NOT diReset THEN
				palletOnConveyorP14 := FALSE;
				stateConveyorP14P15 := stateConveyorStop;
			END_IF	
			
			//timeout?
			TON_ConveyorP14P15(IN := TRUE, PT := T#12s);
			IF TON_ConveyorP14P15.Q AND NOT diReset THEN
				alarmImagePalletization[7] := TRUE;
				stateConveyorP14P15 := stateConveyorStop;
			END_IF
		
	END_CASE
	
	//control of ACOPOSinverter P15
	acpI_P15();
	
	palletOnConveyorP15old := palletOnConveyorP15;

	IF acknowledgeImagePalletization[6] THEN
		alarmImagePalletization[6] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[7] THEN
		alarmImagePalletization[7] := FALSE;
	END_IF

	IF acknowledgeImagePalletization[11] THEN
		alarmImagePalletization[11] := FALSE;
	END_IF	
	
	IF acpI_P15.error THEN
		alarmImagePalletization[25] := TRUE;
	ELSE
		alarmImagePalletization[25] := FALSE;
	END_IF	
	
END_ACTION
