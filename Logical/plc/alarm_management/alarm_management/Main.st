
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
	
	acknowledgeImage[0];
	
	IF diReset THEN
		FOR i:= 0 TO 39 DO
			acknowledgeImage[i] := 0;
		END_FOR
	END_IF
	
END_PROGRAM
