
ACTION ConveyorP12Control: 
	
	//detect pallet on conveyor
	IF diPalletOnConveyorP12 THEN
		palletOnConveyorP12 := TRUE;
	END_IF

	CASE stateConveyor OF
		stateConveyorUndefined:
		
	END_CASE
	
END_ACTION
