
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	modeZonePalletizationOld := modeZonePalletization;
	
	readyToStart := NOT diPalletizationEDM;
	
	IF cpuIsSimulated THEN
		readyToStart := TRUE;
	END_IF
	
	IF NOT readyToStart THEN
		modeZonePalletization := modeZoneOff; 
	END_IF

	CASE modeZonePalletization OF
		
		modeZoneOff: //the automat is not ready to start
			
			cmdPalletizationManual := FALSE;
			cmdPalletizationAuto := FALSE;
			
			IF readyToStart THEN
				modeZonePalletization := modeZoneManual;
			END_IF

		modeZoneManual:

			cmdPalletizationManual := FALSE;
			
			IF (NOT alarmInZonePalletization OR cpuIsSimulated)  AND cmdPalletizationAuto THEN
				modeZonePalletization := modeZoneAuto;
			END_IF

		modeZoneAuto:
				
			cmdPalletizationAuto := FALSE;
			
			IF (alarmInZonePalletization AND NOT cpuIsSimulated) OR cmdPalletizationManual THEN 
				modeZonePalletization := modeZoneManual;
			END_IF
		
	END_CASE
	
	//alarms

	
END_PROGRAM


