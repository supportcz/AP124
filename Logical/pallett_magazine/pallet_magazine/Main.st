(*Control OF pallet magazine, also called "zásobník palet" nebo "stohovaè" *)

PROGRAM _INIT
	
	 
END_PROGRAM


PROGRAM _CYCLIC


	CASE modeOfOperation OF
		
		notReadyToStart: //the automat is not ready to start
			IF NOT palletMagazineViolation AND airPresureOK THEN
				modeOfOperation := readyToStart;
			END_IF
		
		readyToStart:
			
			IF cmdManualMode OR cmdAllToManualMode THEN
				modeOfOperation := manualMode;
			END_IF

		manualMode:
		
	END_CASE;
	
	//action to control the arms
	ArmsControl;
				

				
				
	palletDetected;
		
	(* error detection *)
	IF palletMagazineViolation THEN
		MpAlarmXSet(gAlarmXCore,'PalletMagazineViolation');
	ELSE
		MpAlarmXReset(gAlarmXCore,'PalletMagazineViolation');
	END_IF
	
END_PROGRAM
