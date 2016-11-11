PROGRAM _INIT
	
	Comau_0.NoDriveOff := TRUE;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	IF adrRecipes = 0 THEN 
		RETURN;
	END_IF
	
	dRecipes ACCESS adrRecipes;
	IF dRecipes.actualRecipeIndex < 0 OR dRecipes.actualRecipeIndex > 9 THEN
		RETURN;
	END_IF
	
	dActualRecipe ACCESS ADR(dRecipes.recipe[dRecipes.actualRecipeIndex]);
	
	Comau_0.ProductType := INT_TO_USINT(dRecipes.actualRecipeIndex+1);

	//drive on	
	MTBasicsPWM_1(Enable :=  Comau_0.NoAlarm AND NOT Comau_0.DriveOnStatus, Period := 1, DutyCycle := 50);
	Comau_0.DriveOn := MTBasicsPWM_1.Out;
		
	IF statePalletP14 <> palletPresent THEN
		palletComplete := FALSE;
	END_IF
	
	CASE modeZonePalletization OF
		
		modeZoneOff:
			
			//stateRobotAuto := stateRobotAutoInit;
		
		modeZoneManual:
			
			IF modeZonePalletizationOld <> modeZoneManual THEN
				Comau_0.MakeMove := FALSE;
//				doSuck := FALSE;
			END_IF

			Comau_0.NoHold := Comau_0.ProgrammingMode;
		
			IF Comau_0.ProgrammingMode THEN
				stateRobotAuto := stateRobotAutoInit;
			END_IF
			
		modeZoneAuto:
		
			Comau_0.NoHold := TRUE;

			CASE stateRobotAuto OF
				
				stateRobotAutoInit:
				
					stateRobotAuto := stateRobotAutoGoHome;
				
				
				stateRobotAutoGoHome:
				
					IF Comau_0.IsItSafeToGoHome THEN
						stateRobotAuto := stateRobotAutoGoHome2;
					ELSE
						alarmImagePalletization[49] := TRUE;
					END_IF
				
				stateRobotAutoGoHome2:
					
					Comau_0.MoveType := moveTypeGoHome;
					Comau_0.MakeMove := TRUE;
					
					IF Comau_0.MoveDone THEN
						stateRobotAuto := stateRobotAutoPrepareHead;
					END_IF	
				
				stateRobotAutoPrepareHead:
					
					IF nbOfTraysInRobotHead > 0 THEN
						
						suckersForward := TRUE;
						
						IF stateSuckers = stateSuckersForward THEN
							stateRobotAuto := stateRobotAutoGoToTable;
						END_IF
						
						stateRobotAuto := stateRobotAutoGoToTable;
						
					ELSE
						suckersForward := TRUE;
						railingUp := TRUE;
						centeringForward := FALSE;
						cmdRollerClose := TRUE;
						doSuck := FALSE;
					
						IF stateSuckers = stateSuckersForward AND stateRailing = stateRailingUp AND stateCentering = stateCenteringBack AND stateRoller = stateRollerClosed THEN
							stateRobotAuto := stateRobotAutoGoToTable;
						END_IF
					END_IF

				stateRobotAutoGoToTable:
					
					Comau_0.MoveType := moveTypeGoToTable;
					Comau_0.MakeMove := TRUE;			
					
					IF Comau_0.MoveDone THEN
						stateRobotAuto := stateRobotAutoWaitForBottles;
					END_IF
				
				stateRobotAutoWaitForBottles:
					
					//head full?
					IF nbOfTraysInRobotHead > 0 THEN
						
						robotData.layer := nbOfLayersOnPallet;
						robotData.placeFirstHalf := nbOfTraysInHalfLayer = 0;

						IF nbOfLayersOnPallet = 0 THEN
							robotData.placeSeparator := dActualRecipe.interlayerSheetBottom;
						ELSE
							robotData.placeSeparator := TRUE;
						END_IF

						IF NOT robotData.placeFirstHalf THEN
							robotData.placeSeparator := FALSE;
						END_IF
							
						IF nbOfLayersOnPallet = dActualRecipe.nbOfLayers - 1 THEN
							robotData.placeSeparatorAbove := dActualRecipe.interlayerSheetTop;
						ELSE
							robotData.placeSeparatorAbove := FALSE;
						END_IF

						IF robotData.placeFirstHalf THEN
							robotData.placeSeparatorAbove := FALSE;
						END_IF

						Comau_0.NbOfLayers := INT_TO_USINT(robotData.layer);

						stateRobotAuto := stateRobotAutoRailingDown;
					END_IF					
				
				stateRobotAutoRailingDown:
					
					railingUp := FALSE;
						
					IF stateRailing = stateRailingDown THEN
						stateRobotAuto := stateRobotAutoCenteringForward;
					END_IF		
					
				stateRobotAutoCenteringForward:
					
					centeringForward := TRUE;
					
					IF stateCentering = stateCenteringForward THEN
						stateRobotAuto := stateRobotAutoSwitch1;
					END_IF				
				
				stateRobotAutoSwitch1:

					IF robotData.placeFirstHalf AND robotData.placeSeparator THEN
						stateRobotAuto := stateRobotAutoSeparator;	
					ELSE
						stateRobotAuto := stateRobotAutoHideSuckers;	
					END_IF
						
				stateRobotAutoSeparator:
					
					Comau_0.MoveType := moveTypeGoForSeparator;
					Comau_0.MakeMove := TRUE;

					IF Comau_0.MoveDone THEN
						stateRobotAuto := stateRobotAutoSeparator2;
					END_IF
				
				stateRobotAutoSeparator2:
					
					doSuck := TRUE;
				
					TON_Robot(IN := TRUE, PT := T#2s);
					IF TON_Robot.Q THEN
						stateRobotAuto := stateRobotAutoSeparator3;	
					END_IF
				
				stateRobotAutoSeparator3:
				
					Comau_0.MoveType := moveTypeVerticalOffset2;
					Comau_0.MakeMove := TRUE;	
				
					IF Comau_0.MoveDone THEN
						stateRobotAuto := stateRobotAutoSeparator4;					
					END_IF	
				
				stateRobotAutoSeparator4:
					
					IF diSeparatorPresent THEN
						stateRobotAuto := stateRobotAutoSeparator5;					
					ELSE
						alarmImagePalletization[52] := TRUE;
						stateRobotAuto := stateRobotAutoSeparator;
					END_IF			
				
				stateRobotAutoSeparator5:
					
					IF statePalletP14 = palletPresent AND NOT palletComplete THEN
						stateRobotAuto := stateRobotAutoSeparator6;	
					END_IF
				
				stateRobotAutoSeparator6:
				
					Comau_0.MoveType := moveTypePutSeparatorOnPallet;
					Comau_0.MakeMove := TRUE;
					
					IF Comau_0.MoveDone THEN
						doSuck := FALSE;
						stateRobotAuto := stateRobotAutoHideSuckers;					
					END_IF

				stateRobotAutoHideSuckers:
					
					Comau_0.MoveType := moveTypeVerticalOffset;
					Comau_0.MakeMove := TRUE;	
				
					IF Comau_0.MoveDone THEN
						IF robotData.placeSeparatorAbove AND Comau_0.NbOfLayers = INT_TO_USINT(robotData.layer) + 1 THEN
							palletComplete := TRUE;
							stateRobotAuto := stateRobotAutoPrepareHead;					
						ELSE
							stateRobotAuto := stateRobotAutoHideSuckers2;					
						END_IF
					END_IF						

				stateRobotAutoHideSuckers2:
					
					suckersForward := FALSE;
				
					IF stateSuckers = stateSuckersBack THEN
						stateRobotAuto := stateRobotAutoWaitForPallet;					
					END_IF						
				
				stateRobotAutoWaitForPallet:
					
					IF statePalletP14 = palletPresent AND NOT palletComplete THEN
						IF robotData.placeFirstHalf THEN
							stateRobotAuto := stateRobotAutoPlaceFirstHalf;	
						ELSE
							stateRobotAuto := stateRobotAutoPlaceSecondHalf;	
						END_IF
					END_IF
						
				stateRobotAutoPlaceFirstHalf:
					
					Comau_0.MoveType := moveTypePlaceFirstHalf;
					Comau_0.MakeMove := TRUE;						
					
					IF Comau_0.MoveDone THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf2;
					END_IF					
				
				stateRobotAutoPlaceFirstHalf2:
	
					cmdRollerOpen := TRUE;
				
					IF stateRoller = stateRollerOpened THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf3;
					END_IF		
				
				stateRobotAutoPlaceFirstHalf3:
					
					railingUp := TRUE;
					centeringForward := FALSE;
				
					IF stateRailing = stateRailingUp AND stateCentering = stateCenteringBack THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf4;
					END_IF
				
				stateRobotAutoPlaceFirstHalf4:
					
					Comau_0.MoveType := moveTypeVerticalOffset2;
					Comau_0.MakeMove := TRUE;		
					
					IF Comau_0.MoveDone THEN
						counterTraysOnPallet := counterTraysInRobotHead;

						stateRobotAuto := stateRobotAutoPrepareHead;
					END_IF	
				
				stateRobotAutoPlaceSecondHalf:
					
					Comau_0.MoveType := moveTypePlaceSecondHalf;
					Comau_0.MakeMove := TRUE;						
					
					IF Comau_0.MoveDone THEN
						stateRobotAuto := stateRobotAutoPlaceSecondHalf2;
					END_IF					

				stateRobotAutoPlaceSecondHalf2:
					
					railingUp := TRUE;
						
					IF stateRailing = stateRailingUp THEN
						stateRobotAuto := stateRobotAutoPlaceSecondHalf3;
					END_IF	

				stateRobotAutoPlaceSecondHalf3:
					
					Comau_0.MoveType := moveTypeRelativeHorizontalOffset;
					Comau_0.MakeMove := TRUE;						
					
					IF Comau_0.MoveDone THEN
						stateRobotAuto := stateRobotAutoPlaceSecondHalf4;
					END_IF	
				
				stateRobotAutoPlaceSecondHalf4:
				
					cmdRollerOpen := TRUE;
				
					IF stateRoller = stateRollerOpened THEN
						stateRobotAuto := stateRobotAutoPlaceSecondHalf5;
					END_IF							
						
				stateRobotAutoPlaceSecondHalf5:
				
					centeringForward := FALSE;
				
					IF stateCentering = stateCenteringBack THEN
						stateRobotAuto := stateRobotAutoPlaceSecondHalf6;
					END_IF							
						
				stateRobotAutoPlaceSecondHalf6:
				
					Comau_0.MoveType := moveTypeVerticalOffset2;
					Comau_0.MakeMove := TRUE;		
					
					IF Comau_0.MoveDone THEN
						
						IF robotData.placeSeparatorAbove THEN
							stateRobotAuto := stateRobotAutoSeparatorAbove;
						ELSE
							IF counterTraysInRobotHead = 0 THEN
								palletComplete := TRUE;
							END_IF
							stateRobotAuto := stateRobotAutoPrepareHead;
						END_IF
						
						counterTraysOnPallet := counterTraysInRobotHead;
					END_IF				
				
				stateRobotAutoSeparatorAbove:
					
					Comau_0.NbOfLayers := INT_TO_USINT(robotData.layer) + 1;

					suckersForward := TRUE;
					railingUp := TRUE;
					centeringForward := FALSE;
					cmdRollerClose := TRUE;
					doSuck := FALSE;
				
					IF stateSuckers = stateSuckersForward AND stateRailing = stateRailingUp AND stateCentering = stateCenteringBack AND stateRoller = stateRollerClosed THEN
						stateRobotAuto := stateRobotAutoSeparator;
					END_IF
				
			END_CASE
		
			IF (pusherDrive.actualPositionIndex > 3 OR pusherDrive.requestedPositionIndex > 3) AND stateRobotAuto <> stateRobotAutoWaitForBottles THEN
				alarmImagePalletization[53] := TRUE;
			END_IF	
		
	END_CASE
	
	IF Comau_0.MoveDone THEN
		Comau_0.MakeMove := FALSE;
	END_IF
						
	IF TON_Robot.Q THEN
		TON_Robot(IN := FALSE);
	END_IF

	Comau_0();
	
	//alarms
	alarmImagePalletization[50] := NOT ModuleOk;
	alarmImagePalletization[45] := robotEdmError;
	alarmImagePalletization[46] := robotDoorEdmError;
	alarmImagePalletization[47] := NOT Comau_0.Remote;
	alarmImagePalletization[48] := NOT Comau_0.NoAlarm;
	
	IF Comau_0.Error THEN
		alarmImagePalletization[51] := TRUE;	
	END_IF
	
	IF Comau_0.ErrorHoldPressed THEN
		alarmImagePalletization[56] := TRUE;	
	END_IF

	MTBasicsPWM_0(Enable :=  alarmImagePalletization[48] AND NOT acknowledgeImagePalletization[48], Period := 1, DutyCycle := 50);
	Comau_0.CancelAlarm := MTBasicsPWM_0.Out;
	
	//edge alarms
	IF acknowledgeImagePalletization[49] THEN
		alarmImagePalletization[49] := FALSE;
	END_IF

	IF acknowledgeImagePalletization[51] THEN
		alarmImagePalletization[51] := FALSE;
	END_IF

	IF acknowledgeImagePalletization[52] THEN
		alarmImagePalletization[52] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[53] THEN
		alarmImagePalletization[53] := FALSE;
	END_IF

	IF acknowledgeImagePalletization[56] THEN
		alarmImagePalletization[56] := FALSE;
	END_IF

	
END_PROGRAM
