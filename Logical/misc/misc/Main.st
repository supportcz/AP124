
PROGRAM _INIT
		
	doSafetyCurtainSupplyP11 := TRUE;
	doSafetyCurtainSupplyP15 := TRUE;
	doSafetyCurtainSupplyP17 := TRUE;
	
	doSignColumnGreen;
	doSignColumnOrange;
	doSignColumnRed;
	doSignColumnHorn;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	sumEDM := BOOL_TO_INT(diMagazineEDM) + BOOL_TO_INT(diPalletizationEDM) + BOOL_TO_INT(diOutfeedEDM);
	
	CASE sumEDM OF
		0:	
			MTBasicsPWM_0.DutyCycle := 100;
		1:
			MTBasicsPWM_0.DutyCycle := 50;
		2:
			MTBasicsPWM_0.DutyCycle := 50;
		3:
			MTBasicsPWM_0.DutyCycle := 0;
	END_CASE
	
	MTBasicsPWM_0(Enable := 1, Period := 1);
	
	doLedOn := MTBasicsPWM_0.Out;

	doLedOff := NOT doLedOn;

	diActivateAllSafetyCircuits;

	//signalization column
	doSignColumnRed := doLedOff;
	
	sumAuto := BOOL_TO_INT(modeZoneMagazine = modeZoneAuto) + BOOL_TO_INT(modeZonePalletization = modeZoneAuto) + BOOL_TO_INT(modeZoneOutfeed = modeZoneAuto);
	
	CASE sumAuto OF
		0:	
			MTBasicsPWM_1.DutyCycle := 0;
		1:
			MTBasicsPWM_1.DutyCycle := 50;
		2:
			MTBasicsPWM_1.DutyCycle := 50;
		3:
			MTBasicsPWM_1.DutyCycle := 100;
	END_CASE
	
	MTBasicsPWM_1(Enable := 1, Period := 1);	
	
	doSignColumnGreen := MTBasicsPWM_1.Out;
	
	MTBasicsPWM_2(Enable := alarmPresent, DutyCycle := 50, Period := 1);
	
	doSignColumnOrange := MTBasicsPWM_2.Out OR bypassHorn;
	
	IF release THEN
		doSignColumnHorn := MTBasicsPWM_2.Out AND NOT bypassHorn;
	END_IF
	
	IF NOT alarmPresent THEN
		bypassHorn := FALSE;
	END_IF
	
	IF alarmPresent AND diReset THEN
		bypassHorn := TRUE;
	END_IF
	
END_PROGRAM
