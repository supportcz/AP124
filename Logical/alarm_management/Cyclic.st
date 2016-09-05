
PROGRAM _CYCLIC
	
	MpAlarmXCore_0.MpLink := ADR(gAlarmXCore);
	MpAlarmXCore_0.Enable := 1;
	
	MpAlarmXCore_0();
	
	IF airPresureOK THEN
		MpAlarmXReset(gAlarmXCore,'AirPressureNotOK');
	ELSE
		MpAlarmXSet(gAlarmXCore,'AirPressureNotOK');
	END_IF
	
	 
END_PROGRAM
