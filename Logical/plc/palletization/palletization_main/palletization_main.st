
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	modePalletizationOld := modePalletization;
	
	readyToStart := NOT diPalletizationEDM AND NOT pusherDrive.driveError AND NOT pusherDrive.encoderError;
	
	IF NOT readyToStart THEN
		modePalletization := modePalletizationNotReadyToStart; 
	END_IF

	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start
			
			cmdPalletizationManual := FALSE;
			cmdPalletizationAuto := FALSE;
			
			IF readyToStart THEN
				modePalletization := modePalletizationManual;
			END_IF

		modePalletizationManual:

			cmdPalletizationManual := FALSE;
			
			IF NOT alarmInZonePalletization AND cmdPalletizationAuto THEN
				modePalletization := modePalletizationAuto;
			END_IF

		modePalletizationAuto:
				
			cmdPalletizationAuto := FALSE;
			
			IF alarmInZonePalletization OR cmdPalletizationManual THEN 
				modePalletization := modePalletizationManual;
			END_IF
		
	END_CASE
	

	 
END_PROGRAM


