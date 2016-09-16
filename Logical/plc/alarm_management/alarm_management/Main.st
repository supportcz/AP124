
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	alarmImage[0] := NOT diAirPresureOK;
	alarmImage[1] := NOT diEStop1;
	alarmImage[2] := NOT diEStop2;
	alarmImage[3] := NOT diEStop3;
	alarmImage[4] := NOT diEStop4;
	alarmImage[5] := NOT diEStopRobot;
	alarmImage[6] := NOT diEStopWrapper;

	alarmImage[7] := NOT safetyAlive;

	alarmImage[8] := diMagazineEDM;
	alarmImage[9] := diPalletizationEDM;
	alarmImage[10] := diOutfeedEDM;
	alarmImage[11] := magazineEdmError;
	alarmImage[12] := palletizationEdmError;
	alarmImage[13] := outfeedEdmError;
	
	
	IF diReset THEN
		FOR i:= 0 TO 39 DO
			acknowledgeImage[i] := 0;
		END_FOR
	END_IF
	
END_PROGRAM
