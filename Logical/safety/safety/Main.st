
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	sum := BOOL_TO_INT(diMagazineEDM) + BOOL_TO_INT(diPalletizationEDM) + BOOL_TO_INT(diOutfeedEDM);
	
	CASE sum OF
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
	
	
	doSafetyCurtainSupplyP15 := TRUE;
	doSafetyCurtainSupplyP17 := TRUE;
	
	
END_PROGRAM
