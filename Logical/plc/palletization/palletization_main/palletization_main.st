
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	modePalletizationOld := modePalletization;
	
	readyToStart := NOT diPalletizationEDM AND diAirPresureOK;
	
	IF cpuIsSimulated THEN
		readyToStart := TRUE;
	END_IF
	
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
			
			IF (NOT alarmInZonePalletization OR cpuIsSimulated)  AND cmdPalletizationAuto THEN
				modePalletization := modePalletizationAuto;
			END_IF

		modePalletizationAuto:
				
			cmdPalletizationAuto := FALSE;
			
			IF (alarmInZonePalletization AND NOT cpuIsSimulated) OR cmdPalletizationManual THEN 
				modePalletization := modePalletizationManual;
			END_IF
		
	END_CASE
	
	//alarms

	
END_PROGRAM


