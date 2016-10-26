PROGRAM _INIT
	
	dNextTray ACCESS ADR(nullTray);
	dTrayBehindRotation ACCESS ADR(nullTray);
		 
END_PROGRAM

PROGRAM _CYCLIC

	
	HMIS;
	RFRD;
	
	TOF_TrayOnOutputP1(IN := diTrayOnOutputP1, PT := T#50ms);
	TOF_TrayBehindRotation(IN := diTrayBehindRotation, PT := T#50ms);
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start


		modePalletizationManual:

			IF modePalletizationOld <> modePalletizationManual THEN
				cmdRunConveyorP1 := FALSE;
				cmdRunConveyorP2 := FALSE;
				rotationForward := FALSE;
				bumperAuto := FALSE;
			END_IF
			
			acpI_P10.speed := 1000;
			acpI_P11.speed := 1200;
			pusherDrive.speed := 300;
			
			IF EDGEPOS(cmdRunConveyorsP1P2) THEN
				cmdRunConveyorP1 := TRUE;
				cmdRunConveyorP2 := TRUE;
			END_IF
			
			IF EDGENEG(cmdRunConveyorsP1P2) THEN
				cmdRunConveyorP1 := FALSE;
				cmdRunConveyorP2 := FALSE;
			END_IF

			stateAuto := stateAutoUndefined;

		modePalletizationAuto:
			
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
	
			//detect tray on output of conveyor P1
			IF TOF_TrayOnOutputP1.Q < trayOnInputP2old THEN
				counterTraysOnConveyorP2 := counterTraysOnConveyorP2 + 1;
				//reset timer
				TON_TransitTime(IN := FALSE);
			END_IF

			//select next tray	
			IF counterTraysOnConveyorP2 - firstTrayInLayer >= 0 AND counterTraysOnConveyorP2 - firstTrayInLayer < dActualLayout.nbOfTrays THEN
				dNextTray ACCESS ADR(dActualLayout.tray[counterTraysOnConveyorP2 - firstTrayInLayer]); 
			END_IF	

			//detect tray behind roration
			IF TOF_TrayBehindRotation.Q < trayBehindRotationOld THEN
				counterTraysBehindRotation := counterTraysBehindRotation + 1;		
				
				//select tray behind rotation
				IF counterTraysBehindRotation - firstTrayInLayer > 0 AND counterTraysBehindRotation - firstTrayInLayer <= dActualLayout.nbOfTrays THEN
					dTrayBehindRotation ACCESS ADR(dActualLayout.tray[counterTraysBehindRotation - firstTrayInLayer - 1]);
				END_IF	


			END_IF

			acpI_P10.speed := dActualRecipe.conveyorP1speed;
			acpI_P11.speed := dActualRecipe.conveyorP2speed;
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
										
					//initialize counters when program changes
					IF dRecipes.actualRecipeIndex <> actualRecipeIndexOld THEN
						nbOfLayersOnPallet := 0;
						nbOfTraysInHalfLayer := 0;
						nbOfTraysInRobotHead := 0;
						nbOfTraysOnTable := 0;
						nbOfTraysOnP2 := 0;
					END_IF
					actualRecipeIndexOld := dRecipes.actualRecipeIndex;
					
					counterTraysOnPallet := nbOfLayersOnPallet * dActualLayout.nbOfTrays;
					counterTraysOnPallet := counterTraysOnPallet + nbOfTraysInHalfLayer;
					counterTraysInRobotHead := nbOfLayersOnPallet + nbOfTraysInRobotHead;
					counterTraysOnTable := counterTraysInRobotHead + nbOfTraysOnTable;			
					counterTraysBehindRotation := counterTraysOnTable + nbOfTraysOnP2;
					
					counterTraysOnConveyorP2 := counterTraysBehindRotation;
					
					IF dActualLayout.nbOfTrays > 0 AND counterTraysBehindRotation > 0 THEN
						actualLayerIndex := (counterTraysBehindRotation - 1) / dActualLayout.nbOfTrays;
					ELSE
						actualLayerIndex := 0;						
					END_IF
					firstTrayInLayer := dActualLayout.nbOfTrays * actualLayerIndex; 
					
					//select tray behind rotation
					IF counterTraysBehindRotation - firstTrayInLayer > 0 AND counterTraysBehindRotation - firstTrayInLayer <= dActualLayout.nbOfTrays THEN
						dTrayBehindRotation ACCESS ADR(dActualLayout.tray[counterTraysBehindRotation - firstTrayInLayer - 1]);
					END_IF	
					
					cmdRunConveyorP1 := TRUE;
					cmdRunConveyorP2 := TRUE;		
					
					stateAuto := stateAutoFillRow;
				
				stateAutoFillRow:
					
					IF dTrayBehindRotation.lastTray <> lastTrayNo THEN
						TON_WaitForLastTray(IN := FALSE);					
						stateAuto := stateAutoLastTray;
					END_IF


				stateAutoLastTray:
					
					TON_WaitForLastTray(IN := TRUE, PT := dActualRecipe.timeAfterLastTrayInRow);
					IF TON_WaitForLastTray.Q THEN
						cmdRunConveyorP1 := FALSE;
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
						
						dTrayBehindRotation ACCESS ADR(nullTray);
						counterTraysOnTable := counterTraysBehindRotation;
						
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
						stateAuto := stateAutoFillRow;
					END_IF
				
				stateAutoPusherToRobotHead:
					
					//wait for robot
					IF diRobotReady THEN	
						stateAuto := stateAutoPusherToRobotHead2;
					END_IF
				
				stateAutoPusherToRobotHead2:
					
					//correct counters
					IF counterTraysBehindRotation - firstTrayInLayer = dActualLayout.nbOfTrays THEN
						//start new layer
						actualLayerIndex := actualLayerIndex + 1;
						IF actualLayerIndex = dActualRecipe.nbOfLayers THEN
							//new pallet, reset counters
							counterTraysOnPallet := 0;
							counterTraysInRobotHead := 0;
							counterTraysOnTable := 0;
							counterTraysBehindRotation := 0;
							counterTraysOnConveyorP2 := 0;
							actualLayerIndex := 0;
						END_IF
						firstTrayInLayer := counterTraysBehindRotation;
						
						counterTraysInRobotHead := counterTraysBehindRotation;
						
					END_IF
					stateAuto := stateAutoPusherToRobotHead3;
						

				stateAutoPusherToRobotHead3:
					
					dTrayBehindRotation ACCESS ADR(nullTray);

					//run conveyors
					cmdRunConveyorP1 := TRUE;
					cmdRunConveyorP2 := TRUE;
					
					//push to robot head
					IF diPusherBlockedByTray THEN
						alarmImagePalletization[28] := TRUE;
					ELSE
						pusherDrive.requestedPositionIndex := 4;
						pusherDrive.cmdAbsolute := TRUE;
						stateAuto := stateAutoPusherToRobotHead4;
					END_IF
						
				stateAutoPusherToRobotHead4:
					
					IF NOT pusherDrive.cmdAbsolute THEN
						stateAuto := stateAutoPusherToRobotHead5;
					END_IF

				stateAutoPusherToRobotHead5:
									
					//correct counters
					counterTraysOnTable := counterTraysBehindRotation;
					counterTraysInRobotHead := counterTraysBehindRotation;
					stateAuto := stateAutoPusherToRobotHead6;
						
				stateAutoPusherToRobotHead6:
					//back
					pusherDrive.requestedPositionIndex := 3;
					pusherDrive.cmdAbsolute := TRUE;
					stateAuto := stateAutoPusherToRobotHead7;
				
				stateAutoPusherToRobotHead7:
					
					IF NOT pusherDrive.cmdAbsolute THEN
						stateAuto := stateAutoPusherLiftingUp;
					END_IF
			END_CASE
			
			IF stateAuto > stateAutoStart THEN	
				//control rotation only when no tray is in rotation zone
				IF counterTraysBehindRotation = counterTraysOnConveyorP2 THEN
					rotationForward := dNextTray.turnTray;
				END_IF
												
				//check sensor error
				TON_TransitTime(IN := TRUE, PT:=T#4s);
				IF TON_TransitTime.Q AND counterTraysBehindRotation <> counterTraysOnConveyorP2 THEN
					alarmImagePalletization[27] := TRUE;
				END_IF
				
				//for start dialog
				nbOfLayersOnPallet := counterTraysOnPallet / dActualLayout.nbOfTrays;
				nbOfTraysInHalfLayer := counterTraysOnPallet MOD dActualLayout.nbOfTrays;
				nbOfTraysInRobotHead := counterTraysInRobotHead - counterTraysOnPallet;
				nbOfTraysOnTable := counterTraysOnTable - counterTraysInRobotHead;
				nbOfTraysOnP2 := counterTraysBehindRotation - counterTraysOnTable;
			
			END_IF
	END_CASE


	trayOnInputP2old := TOF_TrayOnOutputP1.Q;
	trayBehindRotationOld := TOF_TrayBehindRotation.Q;
	
		
	ConveyorP1;
	ConveyorP2;
	PusherLifting;
	Rotation;
	Bumper;
	
	//door logic
	DoorLogic_1(doorLocked := diDoor1locked);
	alarmImagePalletization[39] := NOT diDoor1locked;

	
	//edge alarms
	IF acknowledgeImagePalletization[27] THEN
		alarmImagePalletization[27] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[28] THEN
		alarmImagePalletization[28] := FALSE;
	END_IF
	
	//problems with motors
	alarmImagePalletization[18] := NOT diMotorProtectionP3;

	alarmImagePalletization[22] := acpI_P10.error;
	acpI_P10.reset := EDGENEG(acknowledgeImagePalletization[22]);

	alarmImagePalletization[23] := acpI_P11.error;
	acpI_P11.reset := EDGENEG(acknowledgeImagePalletization[23]);
	
END_PROGRAM
