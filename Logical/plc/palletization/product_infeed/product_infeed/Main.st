PROGRAM _INIT

		 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor1opened;
	diOpenDoors1;
	diCloseDoors1;
	
	IF adrRecipes = 0 THEN 
		RETURN;
	END_IF
	
	dRecipes ACCESS adrRecipes;
	IF dRecipes.actualRecipeIndex < 0 OR dRecipes.actualRecipeIndex > 9 THEN
		RETURN;
	END_IF
	
	dActualRecipe ACCESS ADR(dRecipes.recipe[dRecipes.actualRecipeIndex]);
		
	//select actual layout
	IF actualLayer < 0 OR actualLayer > 9 THEN
		RETURN;
	END_IF
	
	dActualLayout ACCESS ADR(dRecipes.layout[dActualRecipe.layer[actualLayer]]);
	
	//detect tray on input of conveyor P2
	TOF_TrayOnOutputP1(IN := diTrayOnOutputP1, PT := T#60ms);
	IF TOF_TrayOnOutputP1.Q < trayOnInputP2old THEN
		nbOfTraysOnConveyorP2 := nbOfTraysOnConveyorP2 + 1;
	END_IF
	trayOnInputP2old := TOF_TrayOnOutputP1.Q;

	//detect tray behind roration
	TOF_TrayBehindRotation(IN := diTrayBehindRotation, PT := T#60ms);
	IF TOF_TrayBehindRotation.Q < trayBehindRotationOld THEN
		nbOfTraysBehindRotation := nbOfTraysBehindRotation + 1;
	END_IF
	trayBehindRotationOld := TOF_TrayBehindRotation.Q;
	
	//select next tray	
	IF nbOfTraysOnConveyorP2 >= 0 AND nbOfTraysOnConveyorP2 < dActualLayout.nbOfTrays THEN
		dTrayOnConveyorP2 ACCESS ADR(dActualLayout.tray[nbOfTraysOnConveyorP2]); 
	ELSE
		dTrayOnConveyorP2 ACCESS ADR(nullTray);
	END_IF	
	
	//select old tray
	IF nbOfTraysOnConveyorP2 > 0 AND nbOfTraysOnConveyorP2 <= dActualLayout.nbOfTrays THEN
		dTrayOnConveyorP2old ACCESS ADR(dActualLayout.tray[nbOfTraysOnConveyorP2-1]);
	ELSE
		dTrayOnConveyorP2old ACCESS ADR(nullTray);
	END_IF	
	
	//select tray behind rotation
	IF nbOfTraysBehindRotation >= 0 AND nbOfTraysBehindRotation < dActualLayout.nbOfTrays THEN
		dTrayBehindRotation ACCESS ADR(dActualLayout.tray[nbOfTraysBehindRotation]);
	ELSE
		dTrayBehindRotation ACCESS ADR(nullTray);
	END_IF		
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start


		modePalletizationManual:

			pusherDrive.speed := 200;
			IF modePalletizationOld <> modePalletizationManual THEN
				cmdRunConveyorP1 := FALSE;
				cmdRunConveyorP2 := FALSE;
			END_IF
			stateAuto := stateAutoUndefined;

		modePalletizationAuto:
			
			pusherDrive.speed := 500;


			CASE stateAuto OF
				
				stateAutoUndefined:
				
					IF statePusherLifting = stateLowerPosition THEN
						stateAuto := stateAutoPusherLiftingUp;
					END_IF
				
					IF statePusherLifting = stateUpperPosition THEN
						stateAuto := stateAutoPusherToBasic;
					END_IF
					
					IF statePusherLifting = stateUpperPosition AND pusherDrive.actualPositionIndex = 1 THEN
						stateAuto := stateAutoPusherLiftingDown;
					END_IF

					IF statePusherLifting = stateLowerPosition AND pusherDrive.actualPositionIndex = 1 THEN
						stateAuto := stateAutoRunConveyors;
					END_IF
				
				stateAutoRunConveyors:
					
					cmdRunConveyorP1 := TRUE;
					cmdRunConveyorP2 := TRUE;		
					stateAuto := stateAutoWaitForNextTray;
				
				stateAutoWaitForNextTray:
					
					rotationForward := dTrayBehindRotation.turnTray;
					
					IF nbOfTraysOnConveyorP2 > nbOfTraysOnConveyorP2old THEN
						IF dTrayOnConveyorP2.turnTray THEN
							cmdTurnTray := TRUE;
						END_IF					
						IF dTrayOnConveyorP2old.lastTrayInRow THEN
							cmdFillUpConveyorP1 := TRUE;
							stateAuto := stateAutoLastTray;
						END_IF	
					END_IF	
								
				stateAutoLastTray:
					
					IF nbOfTraysBehindRotation = nbOfTraysOnConveyorP2 THEN
						TON_WaitForLastTray(IN := FALSE);					
						stateAuto := stateAutoLastTray2;
					END_IF
				
				stateAutoLastTray2:
					
					TON_WaitForLastTray(IN := TRUE, PT := dActualRecipe.timeAfterLastTrayInRow);
					IF TON_WaitForLastTray.Q THEN
						cmdRunConveyorP2 := FALSE;
						stateAuto := stateAutoPusherToTable;
					END_IF
				
				stateAutoPusherToTable:
					
					pusherDrive.requestedPositionIndex := 2;
					pusherDrive.cmdAbsolute := TRUE;
					stateAuto := stateAutoPusherToTable2;
				
				stateAutoPusherToTable2:
					
					IF NOT pusherDrive.cmdAbsolute THEN
						stateAuto := stateAutoPusherLiftingUp;
					END_IF

				stateAutoPusherLiftingUp:
					
					cmdPusherLiftingUp := TRUE;
					stateAuto := stateAutoPusherLiftingUp2;
				
				stateAutoPusherLiftingUp2:
				
					IF NOT cmdPusherLiftingUp THEN
						stateAuto := stateAutoPusherToBasic;	
					END_IF
				
				stateAutoPusherToBasic:
					
					pusherDrive.requestedPositionIndex := 1;
					pusherDrive.cmdAbsolute := TRUE;
					stateAuto := stateAutoPusherToBasic2;				
				
				stateAutoPusherToBasic2:
				
					IF NOT pusherDrive.cmdAbsolute THEN
						stateAuto := stateAutoPusherLiftingDown;
					END_IF
				
				stateAutoPusherLiftingDown:
					
					cmdPusherLiftingDown := TRUE;
					stateAuto := stateAutoPusherLiftingDown2;
				
				stateAutoPusherLiftingDown2:

					IF NOT cmdPusherLiftingDown THEN
						stateAuto := stateAutoRunConveyors;
					END_IF
				
			END_CASE
		
	END_CASE
	
	nbOfTraysOnConveyorP2old := nbOfTraysOnConveyorP2;
	nbOfTraysBehindRotationOld := nbOfTraysBehindRotation;
	
	ConveyorP1;
	ConveyorP2;
	PusherLifting;
	Rotation;
	
	IF pusherDrive.driveError THEN
		alarmImagePalletization[14] := TRUE;
	ELSE
		alarmImagePalletization[14] := FALSE;
	END_IF

	IF pusherDrive.encoderError THEN
		alarmImagePalletization[15] := TRUE;
	ELSE
		alarmImagePalletization[15] := FALSE;
	END_IF

END_PROGRAM
