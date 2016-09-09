
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	alarmImage[0] := NOT diAirPresureOK;
	alarmImage[1] := diEStop1;
	alarmImage[2] := diEStop2;
	alarmImage[3] := diEStop3;
	alarmImage[4] := diEStop4;
	alarmImage[5] := diEStopRobot;
	alarmImage[6] := diEStopWrapper;
	
	acknowledgeImage[0];
	
	IF EDGEPOS(diReset) THEN
		//MpAlarmXListUIConnect.AcknowledgeAll := TRUE;
	END_IF
	
END_PROGRAM
