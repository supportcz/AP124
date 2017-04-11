PROGRAM _INIT
	
	dNextTray ACCESS ADR(nullTray);
	dTrayBehindRotation ACCESS ADR(nullTray);
		 
END_PROGRAM

PROGRAM _CYCLIC
	
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
	
	nbOfTraysInCompletePallet := dActualRecipe.nbOfLayers*dActualLayout.nbOfTrays;
	
	TOF_TrayOnOutputP1(IN := diTrayOnOutputP1, PT := T#10ms);
	TOF_TrayBehindRotation(IN := diTrayBehindRotation, PT := T#30ms);
	
	CASE modeZonePalletization OF
		
		modeZoneOff: 


		modeZoneManual:

			IF modeZonePalletizationOld <> modeZoneManual THEN
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

			automatMode := automatModeInit;

		modeZoneAuto:
			
			CASE automatMode OF
				automatModeInit:
				
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
					counterTraysInRobotHead := (counterTraysOnPallet + nbOfTraysInRobotHead)(* MOD nbOfTraysInCompletePallet*);
					counterTraysOnTable := (counterTraysInRobotHead + nbOfTraysOnTable) (*MOD nbOfTraysInCompletePallet*);			
					counterTraysBehindRotation := (counterTraysOnTable + nbOfTraysOnP2) (*MOD nbOfTraysInCompletePallet*);
					
					counterTraysOnConveyorP2 := counterTraysBehindRotation;
					
					IF dActualLayout.nbOfTrays > 0 THEN
						IF counterTraysBehindRotation > 0 THEN
							actualLayerIndex := (counterTraysBehindRotation - 1) / dActualLayout.nbOfTrays;	
						ELSE
							actualLayerIndex := 0;
						END_IF
					END_IF
					
					IF counterTraysOnPallet  = nbOfTraysInCompletePallet THEN
						palletComplete := TRUE;
					END_IF
					
					TON_Parking(IN := FALSE);
					automatMode := automatModeParking;
				
				automatModeParking:
					
					cmdRunConveyorP2 := TRUE;

					TON_Parking(IN := TRUE, PT := T#5s);
					IF TON_Parking.Q THEN
						dTrayBehindRotation ACCESS ADR(dActualLayout.tray[(counterTraysBehindRotation - 1) MOD dActualLayout.nbOfTrays]);
						cmdRunConveyorP1 := dTrayBehindRotation.lastTray = lastTrayNo OR counterTraysBehindRotation = counterTraysOnTable;
						automatMode := automatModeRun;
					END_IF
						
				automatModeRun:

					//detect tray on output of conveyor P1
					IF TOF_TrayOnOutputP1.Q < trayOnOutputP1old THEN
						counterTraysOnConveyorP2 := counterTraysOnConveyorP2 MOD nbOfTraysInCompletePallet;
						counterTraysOnConveyorP2 := counterTraysOnConveyorP2 + 1;
						//reset timer
						TON_TransitTime(IN := FALSE);
					END_IF

					//select next tray	
					dNextTray ACCESS ADR(dActualLayout.tray[counterTraysOnConveyorP2 MOD dActualLayout.nbOfTrays]); 

					//detect tray behind rotation
					IF TOF_TrayBehindRotation.Q < trayBehindRotationOld THEN
						counterTraysBehindRotation := counterTraysBehindRotation MOD nbOfTraysInCompletePallet;
						counterTraysBehindRotation := counterTraysBehindRotation + 1;						
					END_IF

					//select tray behind rotation
					IF counterTraysBehindRotation > 0 THEN
						dTrayBehindRotation ACCESS ADR(dActualLayout.tray[(counterTraysBehindRotation-1) MOD dActualLayout.nbOfTrays]);
					END_IF	
			
					IF counterTraysBehindRotation = counterTraysOnTable THEN
						dTrayBehindRotation ACCESS ADR(nullTray);
					END_IF				

					acpI_P10.speed := dActualRecipe.conveyorP1speed;
					acpI_P11.speed := dActualRecipe.conveyorP2speed;
					pusherDrive.speed := 500;
					bumperAuto := TRUE;
			

					CASE stateAuto OF
				
						stateAutoInit:
				
							stateAuto := stateAutoPusherToBasic;
								
						stateAutoPusherToBasic:
											
							pusherDrive.requestedPositionIndex := 1;
							pusherDrive.cmdAbsolute := TRUE;

							IF pusherDrive.actualPositionIndex = 1 THEN
								stateAuto := stateAutoPusherLiftingDown;
							END_IF
				
						stateAutoPusherLiftingDown:
					
							cmdPusherLiftingDown := TRUE;

							IF statePusherLifting = stateLowerPosition OR cpuIsSimulated THEN
								stateAuto := stateAutoFillRow;
							END_IF
				
						stateAutoFillRow:
					
							IF dTrayBehindRotation.lastTray <> lastTrayNo THEN
								stateAuto := stateAutoLastTray;
							END_IF

						stateAutoLastTray:
					
							TON_WaitForLastTray(IN := TRUE, PT := dActualRecipe.timeAfterLastTrayInRow);
							IF TON_WaitForLastTray.Q THEN
								cmdRunConveyorP1 := FALSE;
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
								stateAuto := stateAutoPusherToTable2;
							END_IF
				
						stateAutoPusherToTable2:
					
							pusherDrive.requestedPositionIndex := 2;
							pusherDrive.cmdAbsolute := TRUE;
					
							IF pusherDrive.actualPositionIndex = 2 THEN
								cmdRunConveyorP1 := TRUE;
								counterTraysOnTable := counterTraysBehindRotation;
								stateAuto := stateAutoPusherToBasic;
							END_IF
				
						stateAutoPusherLiftingUp:
					
							cmdPusherLiftingUp := TRUE;
				
							IF statePusherLifting = stateUpperPosition OR cpuIsSimulated THEN
								stateAuto := stateAutoPusherToBasic;	
							END_IF

				
						stateAutoPusherToRobotHead:
					
							//wait for robot
							IF stateRobotAuto = stateRobotAutoWaitForBottles THEN
								IF stateRailing = stateRailingUp AND stateCentering = stateCenteringBack AND stateRoller = stateRollerClosed AND NOT diHeadIsFull AND nbOfTraysInRobotHead = 0 THEN	
									stateAuto := stateAutoPusherToRobotHead2;					
								END_IF
							END_IF
				
						stateAutoPusherToRobotHead2:
					
							//prepare data for robot
							robotData.layer := actualLayerIndex;
							robotData.placeFirstHalf := dTrayBehindRotation.lastTray = lastTrayInHalfLayer;
					
							IF actualLayerIndex = 0 THEN
								robotData.placeSeparator := dActualRecipe.interlayerSheetBottom;
							ELSE
								robotData.placeSeparator := TRUE;
							END_IF

							IF NOT robotData.placeFirstHalf THEN
								robotData.placeSeparator := FALSE;
							END_IF
							
							IF actualLayerIndex = dActualRecipe.nbOfLayers - 1 THEN
								robotData.placeSeparatorAbove := dActualRecipe.interlayerSheetTop;
							ELSE
								robotData.placeSeparatorAbove := FALSE;
							END_IF

							IF robotData.placeFirstHalf THEN
								robotData.placeSeparatorAbove := FALSE;
							END_IF

							//remember value for next states
							counterTraysOnTable := counterTraysBehindRotation;

							//correct counters
							IF dTrayBehindRotation.lastTray = lastTrayInLayer THEN
								//start new layer
								actualLayerIndex := actualLayerIndex + 1;
								IF actualLayerIndex = dActualRecipe.nbOfLayers THEN
									//new pallet, reset counters
//									counterTraysOnTable := 0;
									counterTraysBehindRotation := 0;
									counterTraysOnConveyorP2 := 0;
									actualLayerIndex := 0;
								END_IF
							END_IF
					
							stateAuto := stateAutoPusherToRobotHead3;

							dTrayBehindRotation ACCESS ADR(nullTray);

							//run conveyors
							cmdRunConveyorP1 := TRUE;
											

						stateAutoPusherToRobotHead3:
					
							//push to robot head
							IF diPusherBlockedByTray THEN
								alarmImagePalletization[28] := TRUE;
							ELSE
								stateAuto := stateAutoPusherToRobotHead4;
							END_IF
						
						stateAutoPusherToRobotHead4:
					
							pusherDrive.requestedPositionIndex := 4;
							pusherDrive.cmdAbsolute := TRUE;

							IF pusherDrive.actualPositionIndex = 4 THEN
								stateAuto := stateAutoPusherToRobotHead5;
							END_IF

						stateAutoPusherToRobotHead5:
									
							pusherDrive.requestedPositionIndex := 3;
							pusherDrive.cmdAbsolute := TRUE;
							
							IF pusherDrive.actualPositionIndex = 3 THEN
								//send data to robot
								counterTraysInRobotHead := counterTraysOnTable;
								IF counterTraysOnTable > counterTraysBehindRotation THEN
									counterTraysOnTable := 0;
								END_IF
					
//								robotData.start := TRUE; 
								stateAuto := stateAutoPusherLiftingUp;
							END_IF
					END_CASE
			
					//control rotation only when no tray is in rotation zone
					IF counterTraysBehindRotation = counterTraysOnConveyorP2 THEN
						rotationForward := dNextTray.turnTray;
					END_IF
												
					//check sensor error
					TON_TransitTime(IN := TRUE, PT:=T#4s);
					IF TON_TransitTime.Q THEN
						IF counterTraysOnConveyorP2 > counterTraysBehindRotation THEN
							alarmImagePalletization[27] := TRUE;
						END_IF
						IF counterTraysOnConveyorP2 < counterTraysBehindRotation THEN
							alarmImagePalletization[55] := TRUE;
						END_IF
					END_IF
				
					//for start dialog
					nbOfLayersOnPallet := counterTraysOnPallet / dActualLayout.nbOfTrays;
					nbOfTraysInHalfLayer := counterTraysOnPallet MOD dActualLayout.nbOfTrays;
					nbOfTraysInRobotHead := (counterTraysInRobotHead - counterTraysOnPallet + nbOfTraysInCompletePallet) MOD nbOfTraysInCompletePallet;
					nbOfTraysOnTable := (counterTraysOnTable - counterTraysInRobotHead + nbOfTraysInCompletePallet) MOD nbOfTraysInCompletePallet;
					nbOfTraysOnP2 := (counterTraysBehindRotation - counterTraysOnTable + nbOfTraysInCompletePallet) MOD nbOfTraysInCompletePallet;
			
			END_CASE
	END_CASE


	trayOnOutputP1old := TOF_TrayOnOutputP1.Q;
	trayBehindRotationOld := TOF_TrayBehindRotation.Q;

	IF TON_WaitForLastTray.Q THEN
		TON_WaitForLastTray(IN := FALSE);					
	END_IF
		
	ConveyorP1;
	ConveyorP2;
	PusherLifting;
	Rotation;
	Bumper;
	Interlayer;
	
	//door logic
	DoorLogic_1();
	alarmImagePalletization[39] := NOT DoorLogic_1.diDoorLocked;

	
	//edge alarms
	IF acknowledgeImagePalletization[27] THEN
		alarmImagePalletization[27] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[28] THEN
		alarmImagePalletization[28] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[55] THEN
		alarmImagePalletization[55] := FALSE;
	END_IF
	
	//problems with motors
	alarmImagePalletization[18] := NOT diMotorProtectionP3;

	alarmImagePalletization[22] := acpI_P10.error;
	acpI_P10.reset := EDGENEG(acknowledgeImagePalletization[22]);

	alarmImagePalletization[23] := acpI_P11.error;
	acpI_P11.reset := EDGENEG(acknowledgeImagePalletization[23]);
	
END_PROGRAM
