(* Control of pallet magazine, also called "zásobník palet" nebo "stohovaè" *)

PROGRAM _CYCLIC


	
	CASE modeOfOperation OF
		
		notReadyToStart: //the automat is not ready to start
			IF NOT PalletMagazineViolation AND airPresureOK THEN
				modeOfOperation := readyToStart;
			END_IF
		
		readyToStart:
			
			IF cmdManualMode OR cmdAllToManualMode THEN
				modeOfOperation := manualMode;
			END_IF

		manualMode:
			IF cmdCloseArms THEN
				closeArms := TRUE;
				openArms := FALSE;
			END_IF
		
			IF cmdOpenArms THEN
				closeArms := FALSE;
				openArms := TRUE;
			END_IF
		
	END_CASE;
	
	IF palletMagazineViolation THEN
		MpAlarmXSet(gAlarmXCore,'PalletMagazineViolation');
	ELSE
		MpAlarmXReset(gAlarmXCore,'PalletMagazineViolation');
	END_IF
	
END_PROGRAM
