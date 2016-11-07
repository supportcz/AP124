PROGRAM _INIT
	
	Comau_0.NoDriveOff := TRUE;
	Comau_0.NoHold := TRUE;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	IF adrRecipes = 0 THEN 
		RETURN;
	END_IF
	
	dRecipes ACCESS adrRecipes;
	IF dRecipes.actualRecipeIndex < 0 OR dRecipes.actualRecipeIndex > 9 THEN
		RETURN;
	END_IF
	
	Comau_0.ProductType := INT_TO_USINT(dRecipes.actualRecipeIndex+1);

	//drive on	
	MTBasicsPWM_1(Enable :=  Comau_0.NoAlarm AND NOT Comau_0.DriveOnStatus, Period := 1, DutyCycle := 50);
	Comau_0.DriveOn := MTBasicsPWM_1.Out;
		
	
	CASE modeZonePalletization OF
		
		modeZoneOff:
		
		modeZoneManual:
			
			IF modeZonePalletizationOld <> modeZoneManual THEN
				Comau_0.MakeMove := FALSE;
				doSuck := FALSE;
			END_IF
//			stateRobotAuto := stateRobotAutoInit;
		
		
		modeZoneAuto:
		
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
					
					suckersForward := TRUE;
					railingUp := TRUE;
					centeringForward := FALSE;
					cmdRollerClose := TRUE;
					doSuck := FALSE;
				
					IF stateSuckers = stateSuckersForward AND stateRailing = stateRailingUp AND stateCentering = stateCenteringBack AND stateRoller = stateRollerClosed THEN
						stateRobotAuto := stateRobotAutoGoToTable;
					END_IF

				stateRobotAutoGoToTable:
					
					Comau_0.MoveType := moveTypeGoToTable;
					Comau_0.MakeMove := TRUE;			
					
					IF Comau_0.MoveDone THEN
						stateRobotAuto := stateRobotAutoWaitForBottles;
					END_IF
				
				stateRobotAutoWaitForBottles:
					
					IF robotData.start THEN
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
						stateRobotAuto := stateRobotAutoSeparator;
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
						stateRobotAuto := stateRobotAutoHideSuckers2;					
					END_IF						

				stateRobotAutoHideSuckers2:
					
					suckersForward := FALSE;
				
					IF stateSuckers = stateSuckersBack THEN
						stateRobotAuto := stateRobotAutoWhichHalf;					
					END_IF						
				
				stateRobotAutoWhichHalf:
					
					IF robotData.placeFirstHalf THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf;	
					ELSE
						stateRobotAuto := stateRobotAutoPlaceSecondHalf;	
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

			END_CASE
		
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
	
	MTBasicsPWM_0(Enable :=  alarmImagePalletization[48] AND NOT acknowledgeImagePalletization[48], Period := 1, DutyCycle := 50);
	Comau_0.CancelAlarm := MTBasicsPWM_0.Out;
	
	//edge alarms
	IF acknowledgeImagePalletization[49] THEN
		alarmImagePalletization[49] := FALSE;
	END_IF
	
END_PROGRAM
