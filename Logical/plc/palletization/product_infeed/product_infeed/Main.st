PROGRAM _INIT

		 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor1opened;
	diOpenDoors1;
	diCloseDoors1;
	HMIS;
	RFRD;
	
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
	TOF_TrayOnOutputP1(IN := diTrayOnOutputP1, PT := T#40ms);
	IF TOF_TrayOnOutputP1.Q < trayOnInputP2old THEN
		nbOfTraysOnConveyorP2 := nbOfTraysOnConveyorP2 + 1;
	END_IF
	trayOnInputP2old := TOF_TrayOnOutputP1.Q;
	
	//select next tray	
	IF nbOfTraysOnConveyorP2 >= 0 AND nbOfTraysOnConveyorP2 < dActualLayout.nbOfTrays THEN
		dNextTray ACCESS ADR(dActualLayout.tray[nbOfTraysOnConveyorP2]); 
	ELSE
		dNextTray ACCESS ADR(nullTray);
	END_IF	
	
	//detect tray behind roration
	TOF_TrayBehindRotation(IN := diTrayBehindRotation, PT := T#60ms);
	IF TOF_TrayBehindRotation.Q < trayBehindRotationOld THEN
		nbOfTraysBehindRotation := nbOfTraysBehindRotation + 1;
	END_IF
	trayBehindRotationOld := TOF_TrayBehindRotation.Q;
	
	//select tray behind rotation
	IF nbOfTraysBehindRotation > 0 AND nbOfTraysBehindRotation <= dActualLayout.nbOfTrays THEN
		dTrayBehindRotation ACCESS ADR(dActualLayout.tray[nbOfTraysBehindRotation-1]);
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
				rotationForward := FALSE;
				bumperAuto := FALSE;
			END_IF
			stateAuto := stateAutoUndefined;

		modePalletizationAuto:
			
			pusherDrive.speed := 500;
			bumperAuto := TRUE;

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

					IF statePusherLifting = stateLowerPosition AND pusherDrive.actualPositionIndex = 2 THEN
						stateAuto := stateAutoPusherToBasic;
					END_IF
					
					IF statePusherLifting = stateLowerPosition AND pusherDrive.actualPositionIndex = 1 THEN
						stateAuto := stateAutoRunConveyors;
					END_IF
				
				stateAutoRunConveyors:
					
					cmdRunConveyorP1 := TRUE;
					cmdRunConveyorP2 := TRUE;	
					
					stateAuto := stateAutoWaitForNextTray;
				
				stateAutoWaitForNextTray:
					
					IF nbOfTraysBehindRotation = nbOfTraysOnConveyorP2 THEN
						rotationForward := dNextTray.turnTray;
					END_IF
				
					IF nbOfTraysBehindRotation > nbOfTraysOnTable THEN 
						IF dTrayBehindRotation.lastTrayInRow OR dTrayBehindRotation.lastTrayHalfLayer OR dTrayBehindRotation.lastTrayInLayer THEN
							TON_WaitForLastTray(IN := FALSE);					
							stateAuto := stateAutoLastTray;
						END_IF
					END_IF
				
					IF nbOfTraysBehindRotation > nbOfTraysOnConveyorP2 THEN
						alarmImagePalletization[27] := TRUE;
					END_IF

				stateAutoLastTray:
					
					TON_WaitForLastTray(IN := TRUE, PT := dActualRecipe.timeAfterLastTrayInRow);
					IF TON_WaitForLastTray.Q THEN
						cmdRunConveyorP2 := FALSE;
						IF dTrayBehindRotation.lastTrayInRow THEN
							stateAuto := stateAutoPusherToTable;
						END_IF
						IF dTrayBehindRotation.lastTrayHalfLayer OR dTrayBehindRotation.lastTrayInLayer THEN
							stateAuto := stateAutoPusherToRobotHead;
						END_IF
					END_IF
				
				stateAutoPusherToTable:
					
					IF diPusherBlockedByTray THEN
						alarmImagePalletization[28] := TRUE;
					ELSE
						pusherDrive.requestedPositionIndex := 2;
						pusherDrive.cmdAbsolute := TRUE;
						stateAuto := stateAutoPusherToTable2;
					END_IF
				
				stateAutoPusherToTable2:
					
					IF NOT pusherDrive.cmdAbsolute THEN
						nbOfTraysOnTable := nbOfTraysBehindRotation;
						
						fullRow := FALSE;
						cmdRunConveyorP2 := TRUE;	
						
						stateAuto := stateAutoPusherToBasic;
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
				
				stateAutoPusherToRobotHead:
					//wait for robot
					IF diRobotReady THEN
						stateAuto := stateAutoPusherToRobotHead2;
					END_IF
				
				stateAutoPusherToRobotHead2:
					
					IF diPusherBlockedByTray THEN
						alarmImagePalletization[28] := TRUE;
					ELSE
						pusherDrive.requestedPositionIndex := 3;
						pusherDrive.cmdAbsolute := TRUE;
						stateAuto := stateAutoPusherToRobotHead3;
					END_IF
						
				stateAutoPusherToRobotHead3:
					
					IF NOT pusherDrive.cmdAbsolute THEN
						fullRow := FALSE;
						nbOfTraysOnTable := nbOfTraysBehindRotation;
						nbOfTraysInRobotHead := nbOfTraysBehindRotation;
						stateAuto := stateAutoPusherLiftingUp;
					END_IF

			END_CASE
		
	END_CASE
	
	ConveyorP1;
	ConveyorP2;
	PusherLifting;
	Rotation;
	Bumper;
	
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
	
	//edge alarms
	IF acknowledgeImagePalletization[27] THEN
		alarmImagePalletization[27] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[28] THEN
		alarmImagePalletization[28] := FALSE;
	END_IF
	
END_PROGRAM
