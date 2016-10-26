PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	 
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
		


		modePalletizationManual:
			
			IF modePalletizationOld <> modePalletizationManual THEN

			END_IF

		modePalletizationAuto:
		
	END_CASE
	
	Railing;
	Suckers;
	Centering;
	Roller;

	//door logic
	DoorLogic_3(doorLocked := diDoor3locked);
	alarmImagePalletization[42] := NOT diDoor3locked;
	
END_PROGRAM
