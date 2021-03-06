
PROGRAM _INIT
	 	
	cpuIsSimulated := DiagCpuIsSimulated();

END_PROGRAM

PROGRAM _CYCLIC

	alarmImageCommon[0] := NOT diAirPresureOK;
	alarmImageCommon[1] := NOT diEStop1;
	alarmImageCommon[2] := NOT diEStop2;
	alarmImageCommon[3] := NOT diEStop3;
	alarmImageCommon[4] := NOT diEStop4;
	alarmImageCommon[14] := NOT diEStop5;

	alarmImageCommon[5] := NOT diEStopRobot;
	alarmImageCommon[6] := NOT diEStopWrapper;
	alarmImageCommon[7] := NOT safetyAlive;
	
	alarmImageCommon[8] := diMagazineEDM;
	alarmImageCommon[9] := diPalletizationEDM;
	alarmImageCommon[10] := diOutfeedEDM;
	alarmImageCommon[11] := magazineEdmError;
	alarmImageCommon[12] := palletizationEdmError;
	alarmImageCommon[13] := outfeedEdmError;
	


	
	//detect if there is any alarm 
	alarmCommon := FALSE;
	FOR i:=0 TO 39 DO
		IF alarmImageCommon[i] OR acknowledgeImage[i] THEN
			alarmCommon := TRUE;
		END_IF
	END_FOR
	
	//detect if there is any alarm in zone Magazine
	alarmInZoneMagazine := FALSE;
	FOR i:=0 TO 39 DO
		IF alarmImageMagazine[i] OR acknowledgeImageMagazine[i] THEN
			alarmInZoneMagazine := TRUE;
		END_IF
	END_FOR
	
	//detect if there is any alarm in zone Palletization
	alarmInZonePalletization := FALSE;
	FOR i:=0 TO 69 DO
		IF alarmImagePalletization[i] OR acknowledgeImagePalletization[i] THEN
			alarmInZonePalletization := TRUE;
		END_IF
	END_FOR
	
	//detect if there is any alarm in zone Outfeed
	alarmInZoneOutfeed := FALSE;
	FOR i:=0 TO 39 DO
		IF alarmImageOutfeed[i] OR acknowledgeImageOutfeed[i] THEN
			alarmInZoneOutfeed := TRUE;
		END_IF
	END_FOR
		
	IF alarmCommon OR alarmInZoneMagazine OR alarmInZonePalletization OR alarmInZoneOutfeed THEN
		alarmPresent := TRUE;
	ELSE
		alarmPresent := FALSE;
	END_IF
	
END_PROGRAM
