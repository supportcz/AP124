
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	modeZoneOutfeedOld := modeZoneOutfeed;
	
	readyToStart := NOT diOutfeedEDM;
	
	IF cpuIsSimulated THEN
		readyToStart := TRUE;
	END_IF
	
	IF NOT readyToStart THEN
		modeZoneOutfeed := modeZoneOff; 
	END_IF

	CASE modeZoneOutfeed OF
		
		modeZoneOff: //the automat is not ready to start
			
			cmdOutfeedManual := FALSE;
			cmdOutfeedAuto := FALSE;
			
			IF readyToStart THEN
				modeZoneOutfeed := modeZoneManual;
			END_IF

		modeZoneManual:

			cmdOutfeedManual := FALSE;
			
			IF (NOT alarmInZoneOutfeed OR cpuIsSimulated) AND cmdOutfeedAuto THEN
				modeZoneOutfeed := modeZoneAuto;
			END_IF

		modeZoneAuto:
				
			cmdOutfeedAuto := FALSE;
			
			IF (alarmInZoneOutfeed AND NOT cpuIsSimulated) OR cmdOutfeedManual THEN 
				modeZoneOutfeed := modeZoneManual;
			END_IF
		
	END_CASE

	//alarms
	alarmImageOutfeed[0] := NOT lightCurtainP17;
	alarmImageOutfeed[3] := NOT diMotorProtectionP19;
	alarmImageOutfeed[9] := NOT diMotorProtectionP20;
	alarmImageOutfeed[12] := NOT diMotorProtectionP21;
	alarmImageOutfeed[13] := NOT diMotorProtectionP22;
END_PROGRAM


