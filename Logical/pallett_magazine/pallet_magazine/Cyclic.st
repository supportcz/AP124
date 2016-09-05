(* Control of pallet magazine, also called "zásobník palet" nebo "stohovaè" *)

PROGRAM _CYCLIC


	
	CASE modeOfOperation OF
		
		notReadyToStart: //the automat is not ready to start
			IF NOT PalletMagazineViolation AND AirPresureOK THEN
				modeOfOperation := readyToStart;
			END_IF
		
		readyToStart:
			
			IF switchToManualMode OR switchAllToManualMode THEN
				modeOfOperation := manualMode;
			END_IF

		manualMode:
			IF closeArms THEN
			END_IF
		
			IF openArms THEN
			END_IF
		
	END_CASE;
	
	IF palletMagazineViolation THEN
		MpAlarmXSet(gAlarmXCore,'PalletMagazineViolation');
	ELSE
		MpAlarmXReset(gAlarmXCore,'PalletMagazineViolation');
	END_IF
	
END_PROGRAM
