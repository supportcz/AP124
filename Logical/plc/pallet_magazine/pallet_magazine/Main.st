(*Control OF pallet magazine, also called "zásobník palet" nebo "stohovaè" *)

PROGRAM _INIT
	
	 
END_PROGRAM


PROGRAM _CYCLIC

	readyToStart := NOT magazineSafetyViolation AND diAirPresureOK AND diMotorProtectionP11;
	
	IF NOT readyToStart THEN
		modeOfOperation := modeNotReadyToStart;
	END_IF

	CASE modeOfOperation OF
		
		modeNotReadyToStart: //the automat is not ready to start
			
			IF readyToStart THEN
				modeOfOperation := modeManual;
			END_IF
		
		modeManual:
			
			IF cmdAutoMode OR cmdAllToAutoMode OR diAutoMode THEN
				modeOfOperation := modeAuto;
			END_IF

		modeAuto:
		
			activateSafetyCircuit := TRUE;
		
				
		
	END_CASE;
	
	//horizontal arms movement
	HorizontalArmsControl;

	//vertical arms movement
	VerticalArmsControl;
	
	IF diPalletOnConveyorP12 THEN
		palletOnConveyor := TRUE;
	END_IF
	
	(* error detection *)
	
	alarmImage[0] := magazineSafetyViolation;
	alarmImage[1] := diLightCurtainP11;
	
	acknowledgeImage[0];
		
	
END_PROGRAM
