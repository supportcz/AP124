(*Control OF pallet magazine, also called "zásobník palet" nebo "stohovaè" *)

PROGRAM _INIT
	
	 
END_PROGRAM


PROGRAM _CYCLIC


	CASE modeOfOperation OF
		
		notReadyToStart: //the automat is not ready to start
			IF NOT magazineSafetyViolation AND diAirPresureOK THEN
				modeOfOperation := readyToStart;
			END_IF
		
		readyToStart:
			
			IF cmdManualMode OR cmdAllToManualMode THEN
				modeOfOperation := manualMode;
			END_IF

		manualMode:
		
			MagazineControl;
				
		
	END_CASE;
	
	//action to control the arms
	ArmsControl;
				
	
	(* error detection *)
	IF magazineSafetyViolation THEN
		MpAlarmXSet(gAlarmXCore,'PalletMagazineSafetyViolation');
	ELSE
		MpAlarmXReset(gAlarmXCore,'PalletMagazineSafetyViolation');
	END_IF
	
	IF NOT diMotorProtectionP11 THEN
		MpAlarmXSet(gAlarmXCore,'MotorProtectionP11');
	ELSE
		MpAlarmXReset(gAlarmXCore,'MotorProtectionP11');
	END_IF
		
	
END_PROGRAM
