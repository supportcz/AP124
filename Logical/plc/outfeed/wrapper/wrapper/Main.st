PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor2opened;
	diOpenDoors2;
	diCloseDoors2; 
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
		
			acpI_P18.reset := TRUE;


		modePalletizationManual:
			
			IF modePalletizationOld <> modePalletizationManual THEN
				cmdMovePalletP18 := FALSE;

			END_IF

		modePalletizationAuto:
	
			IF statePalletP18 <> palletNotPresent AND statePalletP19 = palletNotPresent THEN
				cmdMovePalletP18 := TRUE;
			END_IF

		
	END_CASE

	
	//conveyors
	ConveyorP18; 

	
END_PROGRAM
