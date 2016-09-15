(*Control OF pallet magazine, also called "zásobník palet" nebo "stohovaè" *)

PROGRAM _INIT
	
	 
END_PROGRAM


PROGRAM _CYCLIC

	readyToStart := NOT diMagazineEDM AND diAirPresureOK AND diMotorProtectionP11;
	
	IF NOT readyToStart THEN
		modeOfOperation := modeNotReadyToStart;
	END_IF

	CASE modeOfOperation OF
		
		modeNotReadyToStart: //the automat is not ready to start
			
			IF readyToStart THEN
				modeOfOperation := modeManual;
			END_IF
		
		modeManual:

			IF cmdAuto OR cmdAllToAuto OR diAuto THEN
				modeOfOperation := modeAuto;
			END_IF

		modeAuto:
		
		
				
		
	END_CASE;
	
	//horizontal arms movement
	HorizontalArmsControl;

	//vertical arms movement
	VerticalArmsControl;
	
	//conveyor P12
	ConveyorP12Control;

	//request to activate safety
	//activateSafetyCircuit := diAuto OR diActivateAllSafetyCircuits;

	(* error management *)
	IF diReset THEN
		FOR i:= 0 TO 39 DO
			acknowledgeImage[i] := 0;
		END_FOR
	END_IF

	alarmImage[1] := diLightCurtainP11;
	alarmImage[6] := NOT diMotorProtectionP11;
	alarmImage[12] := NOT diEStop5;

	
END_PROGRAM
