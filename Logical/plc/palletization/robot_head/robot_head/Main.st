PROGRAM _INIT
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	 
	CASE modeZonePalletization OF
		
		modeZoneOff: //the automat is not ready to start
		


		modeZoneManual:
			
			IF modeZonePalletizationOld <> modeZoneManual THEN

			END_IF

		modeZoneAuto:
		
	END_CASE
	
	Railing;
	Suckers;
	Centering;
	Roller;

	//door logic
	DoorLogic_3();
	alarmImagePalletization[42] := NOT DoorLogic_3.diDoorLocked;
	
END_PROGRAM
