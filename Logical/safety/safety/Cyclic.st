
PROGRAM _CYCLIC
	
	IF diEStop1 THEN
		MpAlarmXReset(gAlarmXCore,'EStop1');
	ELSE
		MpAlarmXSet(gAlarmXCore,'EStop1');
	END_IF

	IF diEStop2 THEN
		MpAlarmXReset(gAlarmXCore,'EStop2');
	ELSE
		MpAlarmXSet(gAlarmXCore,'EStop2');
	END_IF

	IF diEStop3 THEN
		MpAlarmXReset(gAlarmXCore,'EStop3');
	ELSE
		MpAlarmXSet(gAlarmXCore,'EStop3');
	END_IF

	IF diEStop4 THEN
		MpAlarmXReset(gAlarmXCore,'EStop4');
	ELSE
		MpAlarmXSet(gAlarmXCore,'EStop4');
	END_IF

	IF diEStop5 THEN
		MpAlarmXReset(gAlarmXCore,'EStop5');
	ELSE
		MpAlarmXSet(gAlarmXCore,'EStop5');
	END_IF

	IF diEStopRobot THEN
		MpAlarmXReset(gAlarmXCore,'EStopRobot');
	ELSE
		MpAlarmXSet(gAlarmXCore,'EStopRobot');
	END_IF

	IF diEStopWrapper THEN
		MpAlarmXReset(gAlarmXCore,'EStopWrapper');
	ELSE
		MpAlarmXSet(gAlarmXCore,'EStopWrapper');
	END_IF

	
END_PROGRAM
