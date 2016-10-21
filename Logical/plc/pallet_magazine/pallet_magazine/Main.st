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
			cmdMagazineManual := FALSE;
			cmdMagazineAuto := FALSE;
		
		modeMagazineManual:

			IF NOT alarmInZoneMagazine AND (cmdMagazineAuto OR TP_Start.Q) THEN 
				modeMagazine := modeMagazineAuto;
				stateAuto := stateAutoUndefined;
				magazineEmpty := FALSE;
			END_IF
			cmdMagazineManual := FALSE;

		modeMagazineAuto:
			
			IF alarmInZoneMagazine OR cmdMagazineManual THEN
				modeMagazine := modeMagazineManual;
			END_IF
			cmdMagazineAuto := FALSE;
				
			CASE stateAuto OF
				
				stateAutoUndefined:
					
					cmdUp := FALSE;
					IF stateMagazine = stateUpperPosition THEN
						stateAuto := stateAutoWaitForNoPallet;
					ELSIF stateMagazine = stateMiddlePosition THEN
						stateAuto := stateAutoCloseArms;
					ELSIF stateMagazine = stateLowerPosition THEN
						stateAuto := stateAutoOpenArms;
					ELSE
						cmdUp := TRUE;
					END_IF
							
				stateAutoWaitForNoPallet:
					
					IF statePalletP12 = palletNotPresent AND NOT magazineEmpty THEN
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
					
					closeArms := FALSE;
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
					
					closeArms := TRUE;
					stateAuto := stateAutoWaitForClosedArms;
			
				stateAutoWaitForClosedArms:
				
					IF stateArms = stateArmsClosed THEN
						cmdUp := TRUE;
						stateAuto := stateAutoMoveToUpperPosition;
					END_IF
				
				stateAutoMoveToUpperPosition:
				
					IF stateMagazine = stateUpperPosition THEN
						stateAuto := stateAutoDetectPalletOnConveyor;
					END_IF

				stateAutoDetectPalletOnConveyor:
					
					IF statePalletP12 = palletNotPresent THEN
						magazineEmpty := TRUE;
					END_IF
					stateAuto := stateAutoWaitForNoPallet;
				
						
			END_CASE
		
				
		
	END_CASE;
	
	//horizontal arms movement
	HorizontalArmsControl;

	//vertical arms movement
	VerticalArmsControl;
	
	//conveyor P12
	//ConveyorP12Control;

	TON_PalletOnConveyorP12(IN := diPalletOnConveyorP12, PT := T#50ms);
	
	//detect pallet on conveyor
	IF TON_PalletOnConveyorP12.Q AND stateMagazine = stateUpperPosition AND statePalletP12 = palletNotPresent THEN
		statePalletP12 := palletPresent;
	END_IF
	
	//LED P11
	IF diMagazineEDM THEN
		MTBasicsPWM_0.DutyCycle := 50;
	ELSE
		MTBasicsPWM_0.DutyCycle := 0;
	END_IF
	
	MTBasicsPWM_0(Enable := 1, Period := 1);
	doLedP11 := MTBasicsPWM_0.Out;

//	IF diActivateMagazineSafetyCircuits  AND modePalletization = modePalletizationAuto THEN
//		cmdAuto := TRUE;
//	END_IF
	
	TP_Start(IN := diActivateMagazineSafetyCircuits AND modePalletization = modePalletizationAuto, PT := T#1s);

	alarmImageMagazine[1] := NOT lightCurtainP11;
	alarmImageMagazine[6] := NOT diMotorProtectionP11;
	alarmImageMagazine[12] := NOT diEStop5;


	
END_PROGRAM
