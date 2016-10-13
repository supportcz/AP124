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
	
	//correct wrong value in recipe
	IF dActualRecipe.nbOfLayers < 1 THEN
		dActualRecipe.nbOfLayers := 1;
	END_IF
	
	//select actual layout
	IF actualLayerIndex < 0 OR actualLayerIndex > 9 THEN
		RETURN;
	END_IF
	
	dActualLayout ACCESS ADR(dRecipes.layout[dActualRecipe.layer[actualLayerIndex]]);
	
	//the last tray in layout has to have set flag lastTrayInLayer
	dActualLayout.tray[dActualLayout.nbOfTrays - 1].lastTray := lastTrayInLayer;
	
	//detect tray on input of conveyor P2
	TOF_TrayOnOutputP1(IN := diTrayOnOutputP1, PT := T#40ms);
	IF TOF_TrayOnOutputP1.Q < trayOnInputP2old THEN
		nbOfTraysOnConveyorP2 := nbOfTraysOnConveyorP2 + 1;
	END_IF
	trayOnInputP2old := TOF_TrayOnOutputP1.Q;
	
	//select next tray	
	IF nbOfTraysOnConveyorP2 - firstTrayInLayer >= 0 AND nbOfTraysOnConveyorP2 - firstTrayInLayer < dActualLayout.nbOfTrays THEN
		dNextTray ACCESS ADR(dActualLayout.tray[nbOfTraysOnConveyorP2 - firstTrayInLayer]); 
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
	IF nbOfTraysBehindRotation - firstTrayInLayer > 0 AND nbOfTraysBehindRotation - firstTrayInLayer <= dActualLayout.nbOfTrays THEN
		dTrayBehindRotation ACCESS ADR(dActualLayout.tray[nbOfTraysBehindRotation - firstTrayInLayer - 1]);
	ELSE
		dTrayBehindRotation ACCESS ADR(nullTray);
	END_IF		

	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start


		modePalletizationManual:

			pusherDrive.speed := 300;
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
						stateAuto := stateAutoStart;
					END_IF
				
				stateAutoStart:
					
//					actualLayerIndex := 0;
//					firstTrayInLayer := 0;
					cmdRunConveyorP1 := TRUE;
					cmdRunConveyorP2 := TRUE;						
					stateAuto := stateAutoWaitForNextTray;
				
				stateAutoWaitForNextTray:
					
					IF nbOfTraysBehindRotation = nbOfTraysOnConveyorP2 THEN
						rotationForward := dNextTray.turnTray;
					END_IF
				
					IF nbOfTraysBehindRotation > nbOfTraysOnTable THEN 
						IF dTrayBehindRotation.lastTray <> lastTrayNo THEN
							TON_WaitForLastTray(IN := FALSE);					
							stateAuto := stateAutoLastTray;
						END_IF
					END_IF

				stateAutoLastTray:
					
					TON_WaitForLastTray(IN := TRUE, PT := dActualRecipe.timeAfterLastTrayInRow);
					IF TON_WaitForLastTray.Q THEN
						cmdRunConveyorP2 := FALSE;
						IF dTrayBehindRotation.lastTray = lastTrayInRow THEN
							stateAuto := stateAutoPusherToTable;
						END_IF
						IF dTrayBehindRotation.lastTray = lastTrayInHalfLayer OR dTrayBehindRotation.lastTray = lastTrayInLayer THEN
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
						
						cmdRunConveyorP1 := TRUE;
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
						stateAuto := stateAutoWaitForNextTray;
					END_IF
				
				stateAutoPusherToRobotHead:
					//wait for robot
					IF diRobotReady THEN
						stateAuto := stateAutoPusherToRobotHead2;
					END_IF
				
				stateAutoPusherToRobotHead2:
					//push to robot head
					IF diPusherBlockedByTray THEN
						alarmImagePalletization[28] := TRUE;
					ELSE
						pusherDrive.requestedPositionIndex := 4;
						pusherDrive.cmdAbsolute := TRUE;
						stateAuto := stateAutoPusherToRobotHead3;
					END_IF
						
				stateAutoPusherToRobotHead3:
					
					IF NOT pusherDrive.cmdAbsolute THEN
						stateAuto := stateAutoPusherToRobotHead4;
					END_IF

				stateAutoPusherToRobotHead4:
					
					cmdRunConveyorP1 := TRUE;
					cmdRunConveyorP2 := TRUE;
				
					IF nbOfTraysBehindRotation = dActualLayout.nbOfTrays THEN
						//start new layer
						actualLayerIndex := actualLayerIndex + 1;
						IF actualLayerIndex = dActualRecipe.nbOfLayers THEN
							//new pallet
							nbOfTraysBehindRotation := 0;
							actualLayerIndex := 0;
						END_IF
						firstTrayInLayer := nbOfTraysBehindRotation;
					END_IF
					
					//correct counters
					nbOfTraysOnTable := nbOfTraysBehindRotation;
					nbOfTraysInRobotHead := nbOfTraysBehindRotation;
					stateAuto := stateAutoPusherToRobotHead5;
						
				stateAutoPusherToRobotHead5:
					//back
					pusherDrive.requestedPositionIndex := 3;
					pusherDrive.cmdAbsolute := TRUE;
					stateAuto := stateAutoPusherToRobotHead6;
				
				stateAutoPusherToRobotHead6:
					
					IF NOT pusherDrive.cmdAbsolute THEN
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
