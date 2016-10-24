PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor3opened;
	diOpenDoors3;
	diCloseDoors3; 
	 
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
		


		modePalletizationManual:
			
			IF modePalletizationOld <> modePalletizationManual THEN

			END_IF

		modePalletizationAuto:
		
	END_CASE
	
	Railing;

END_PROGRAM
