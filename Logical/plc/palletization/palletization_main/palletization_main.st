
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
			
			cmdManual := FALSE;
			cmdAuto := FALSE;
			
			IF readyToStart THEN
				modePalletization := modePalletizationManual;
			END_IF

		modePalletizationManual:

			cmdManual := FALSE;
			
			IF NOT alarmInZonePalletization AND cmdAuto THEN
				modePalletization := modePalletizationAuto;
			END_IF

		modePalletizationAuto:
				
			cmdAuto := FALSE;
			
			IF alarmInZonePalletization OR cmdManual THEN 
				modePalletization := modePalletizationManual;
			END_IF
		
	END_CASE
	

	 
END_PROGRAM


