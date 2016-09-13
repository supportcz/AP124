
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	doLedOn := allSafetyCircuitsReady;
	doLedOff := NOT allSafetyCircuitsReady;

	diActivateAllSafetyCircuits;
	
END_PROGRAM
