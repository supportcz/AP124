(*Control OF pallet magazine, also called "zásobník palet" nebo "stohovaè" *)

PROGRAM _INIT
	
	 
END_PROGRAM


PROGRAM _CYCLIC

	readyToStart := NOT diMagazineEDM AND diAirPresureOK AND diMotorProtectionP11;
	
	IF NOT readyToStart THEN
		modeMagazine := modeMagazineNotReadyToStart;
	END_IF

	CASE modeMagazine OF
		
		modeMagazineNotReadyToStart: //the automat is not ready to start
			
			IF readyToStart THEN
				modeMagazine := modeMagazineManual;
			END_IF
		
		modeMagazineManual:

			IF NOT alarmInZoneMagazine AND (cmdAuto OR cmdAllToAuto) THEN //OR diActivateMagazineSafetyCircuits THEN
				cmdAuto := FALSE;
				cmdAllToAuto := FALSE;
				modeMagazine := modeMagazineAuto;
				stateAuto := stateAutoUndefined;
			END_IF
			cmdManual := FALSE;

		modeMagazineAuto:
		
			IF alarmInZoneMagazine OR cmdManual THEN
				modeMagazine := modeMagazineManual;
			END_IF
				
			CASE stateAuto OF
				
				stateAutoUndefined:
					
					cmdUp := FALSE;
					IF stateMagazine = stateUpperPosition THEN
						stateAuto := stateAutoWaitForNoPallet;
					ELSIF stateMagazine = stateMiddlePosition THEN
						stateAuto := stateAutoCloseArms;
					ELSE
						cmdUp := TRUE;
					END_IF
							
				stateAutoWaitForNoPallet:
					
					IF NOT palletOnConveyorP12 THEN
						stateAuto := stateAutoMoveToLowerPosition;
					END_IF
				
				stateAutoMoveToLowerPosition:
					
					cmdDown := TRUE;
					stateAuto := stateAutoWaitForLowerPosition;
				
				stateAutoWaitForLowerPosition:
				
					IF stateMagazine = stateLowerPosition THEN
						stateAuto := stateAutoOpenArms;
					END_IF
				
				stateAutoOpenArms:
					
					cmdOpenArms := TRUE;
					stateAuto := stateAutoWaitForOpenedArms;
				
				stateAutoWaitForOpenedArms:
					
					IF stateArms = stateArmsOpened THEN
						stateAuto := stateAutoMoveToMiddlePosition;
					END_IF
				
				stateAutoMoveToMiddlePosition:
					
					cmdUp := TRUE;
					stateAuto := stateAutoWaitForMiddlePosition;			
				
				stateAutoWaitForMiddlePosition:

					IF stateMagazine = stateMiddlePosition THEN
						stateAuto := stateAutoCloseArms;
					END_IF
				
				stateAutoCloseArms:
					
					cmdCloseArms := TRUE;
					stateAuto := stateAutoWaitForClosedArms;
			
				stateAutoWaitForClosedArms:
				
					IF stateArms = stateArmsClosed THEN
						cmdUp := TRUE;
						stateAuto := stateAutoMoveToUpperPosition;
					END_IF
				
				stateAutoMoveToUpperPosition:
				
					IF stateMagazine = stateUpperPosition THEN
						stateAuto := stateAutoWaitForNoPallet;
					END_IF

						
			END_CASE
		
				
		
	END_CASE;
	
	//horizontal arms movement
	HorizontalArmsControl;

	//vertical arms movement
	VerticalArmsControl;
	
	//conveyor P12
	ConveyorP12Control;

	doSafetyCurtainSupplyP11 := TRUE;
	diActivateMagazineSafetyCircuits;
	
	//LED P11
	IF diMagazineEDM THEN
		MTBasicsPWM_0.DutyCycle := 50;
	ELSE
		MTBasicsPWM_0.DutyCycle := 0;
	END_IF
	
	MTBasicsPWM_0(Enable := 1, Period := 1);
	doLedP11 := MTBasicsPWM_0.Out;

	//detect if there is any alarm 
	alarmInZoneMagazine := FALSE;
	FOR i:=0 TO 39 DO
		IF alarmImage[i] OR acknowledgeImage[i] THEN
			alarmInZoneMagazine := TRUE;
		END_IF
	END_FOR
	
	(* error management *)
	IF diReset THEN
		FOR i:= 0 TO 39 DO
			acknowledgeImage[i] := 0;
		END_FOR
	END_IF

	alarmImage[1] := NOT lightCurtainP11;
	alarmImage[6] := NOT diMotorProtectionP11;
	alarmImage[12] := NOT diEStop5;

	
END_PROGRAM
