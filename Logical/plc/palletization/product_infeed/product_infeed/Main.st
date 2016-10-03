PROGRAM _INIT

		 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor1opened;
	diOpenDoors1;
	diCloseDoors1;
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
			

		


		modePalletizationManual:
			
			pusherDrive.speed := 200;



		modePalletizationAuto:

	END_CASE
	
	PusherLifting;
	ConveyorP1;
	
	IF pusherDrive.driveError THEN
		alarmImagePalletization[14] := TRUE;
	ELSE
		alarmImagePalletization[14] := FALSE;
	END_IF

	IF pusherDrive.encoderError THEN
		alarmImagePalletization[15] := TRUE;
	ELSE
		alarmImagePalletization[15] := FALSE;
	END_IF

END_PROGRAM
