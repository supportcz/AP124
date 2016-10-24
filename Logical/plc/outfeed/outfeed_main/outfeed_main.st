
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	modeOutfeedOld := modeOutfeed;
	
	readyToStart := NOT diOutfeedEDM AND diMotorProtectionP19 AND diMotorProtectionP20 AND diMotorProtectionP21 AND diMotorProtectionP22;
	
	IF NOT readyToStart THEN
		modeOutfeed := modeOutfeedNotReadyToStart; 
	END_IF

	CASE modeOutfeed OF
		
		modeOutfeedNotReadyToStart: //the automat is not ready to start
			
			cmdOutfeedManual := FALSE;
			cmdOutfeedAuto := FALSE;
			
			IF readyToStart THEN
				modeOutfeed := modeOutfeedManual;
			END_IF

		modeOutfeedManual:

			cmdOutfeedManual := FALSE;
			
			IF NOT alarmInZoneOutfeed AND cmdOutfeedAuto THEN
				modeOutfeed := modeOutfeedAuto;
			END_IF

		modeOutfeedAuto:
				
			cmdOutfeedAuto := FALSE;
			
			IF alarmInZoneOutfeed OR cmdOutfeedManual THEN 
				modeOutfeed := modeOutfeedManual;
			END_IF
		
	END_CASE

	//alarms
	alarmImageOutfeed[3] := NOT diMotorProtectionP19;
	alarmImageOutfeed[9] := NOT diMotorProtectionP20;
	alarmImageOutfeed[12] := NOT diMotorProtectionP21;
	alarmImageOutfeed[13] := NOT diMotorProtectionP22;
	 
END_PROGRAM


