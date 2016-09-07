(*Control OF pallet magazine, also called "zásobník palet" nebo "stohovaè" *)

PROGRAM _INIT
	
	 
END_PROGRAM


PROGRAM _CYCLIC

	IF magazineSafetyViolation OR NOT diAirPresureOK OR NOT diMotorProtectionP11 THEN
		modeOfOperation := notReadyToStart;
	END_IF

	CASE modeOfOperation OF
		
		notReadyToStart: //the automat is not ready to start
			IF NOT magazineSafetyViolation AND diAirPresureOK AND diMotorProtectionP11 THEN
				modeOfOperation := readyToStart;
			END_IF
		
		readyToStart:
			
			IF cmdManualMode OR cmdAllToManualMode THEN
				modeOfOperation := manualMode;
			END_IF

		manualMode:
		
				
		
	END_CASE;
	
	//horizontal arms movement
	HorizontalArmsControl;

	//vertical arms movement
	VerticalArmsControl;
	
	IF diPalletOnConveyorP12 THEN
		palletOnConveyor := TRUE;
	END_IF
	
	(* error detection *)
	IF magazineSafetyViolation THEN
		MpAlarmXSet(gAlarmXCore,'PalletMagazineSafetyViolation');
	ELSE
		MpAlarmXReset(gAlarmXCore,'PalletMagazineSafetyViolation');
	END_IF
	

		
	
END_PROGRAM
