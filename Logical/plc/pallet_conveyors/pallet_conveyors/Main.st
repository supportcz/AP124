PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//detect pallet on conveyor
	IF diPalletOnConveyorP13 THEN
		palletOnConveyorP13 := TRUE;
	END_IF
	
	//conveyor P12 + P13
	ConveyorP12P13Control; 

	 
END_PROGRAM
