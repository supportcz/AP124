PROGRAM _INIT
	
	C5G.Data.OUT.NoDriveOff := TRUE;
	C5G.Data.OUT.NoHold := TRUE;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	IF adrRecipes = 0 THEN 
		RETURN;
	END_IF
	
	dRecipes ACCESS adrRecipes;
	IF dRecipes.actualRecipeIndex < 0 OR dRecipes.actualRecipeIndex > 9 THEN
		RETURN;
	END_IF
	
	MakeMove_0.ProductType := INT_TO_USINT(dRecipes.actualRecipeIndex+1);


	(* Comau -> Atrima *)
	C5G.Data.IN.NoAlarm				:= C5G.Raw.IN[0].0;
	C5G.Data.IN.DriveOnStatus		:= C5G.Raw.IN[0].1;
	C5G.Data.IN.Start_NoHoldPrgMove	:= C5G.Raw.IN[0].2;
	C5G.Data.IN.Remote 				:= C5G.Raw.IN[0].3;
	C5G.Data.IN.TeachEnabled		:= C5G.Raw.IN[0].4;
	C5G.Data.IN.U1					:= C5G.Raw.IN[0].5;
	C5G.Data.IN.U2					:= C5G.Raw.IN[0].6;
	C5G.Data.IN.U3					:= C5G.Raw.IN[0].7;
	C5G.Data.IN.U4					:= C5G.Raw.IN[0].8;
	C5G.Data.IN.NoLatchAlarmActive	:= C5G.Raw.IN[0].9;
	C5G.Data.IN.SafetySpeedActive	:= C5G.Raw.IN[0].10;
	C5G.Data.IN.ProgrammingMode		:= C5G.Raw.IN[0].11;
	C5G.Data.IN.Reserved			:= C5G.Raw.IN[0].12;
	C5G.Data.IN.Local_Remote		:= C5G.Raw.IN[0].13;
	C5G.Data.IN.SystemReady			:= C5G.Raw.IN[0].14;
	C5G.Data.IN.HeartBit			:= C5G.Raw.IN[0].15;
	

	//drive on	
	MTBasicsPWM_1(Enable :=  C5G.Data.IN.NoAlarm AND NOT C5G.Data.IN.DriveOnStatus, Period := 1, DutyCycle := 50);
	C5G.Data.OUT.DriveOn := MTBasicsPWM_1.Out;
		
	
	CASE modeZonePalletization OF
		
		modeZoneOff:
		
		modeZoneManual:
			
			IF modeZonePalletizationOld <> modeZoneManual THEN
				MakeMove_0.Execute := FALSE;
				doSuck := FALSE;
			END_IF
			stateRobotAuto := stateRobotAutoInit;
		
		
		modeZoneAuto:
		
			CASE stateRobotAuto OF
				
				stateRobotAutoInit:
				
					stateRobotAuto := stateRobotAutoStart;
				
				stateRobotAutoStart:

					MTBasicsPWM_2(Enable :=  NOT C5G.Data.IN.Start_NoHoldPrgMove, Period := 1, DutyCycle := 50);
					C5G.Data.OUT.Start := MTBasicsPWM_2.Out;

					IF C5G.Data.IN.Start_NoHoldPrgMove THEN
						stateRobotAuto := stateRobotAutoGoHome;
					END_IF
				
				stateRobotAutoGoHome:
				
					IF MakeMove_0.IsItSafeToGoHome THEN
						MakeMove_0.MoveType := moveTypeGoHome;
						MakeMove_0.Execute := TRUE;
						stateRobotAuto := stateRobotAutoGoHome2;
					ELSE
						alarmImagePalletization[49] := TRUE;
					END_IF
				
				stateRobotAutoGoHome2:
					
					IF MakeMove_0.Done THEN
						stateRobotAuto := stateRobotAutoPrepareHead;
					END_IF	
				
				stateRobotAutoPrepareHead:
					
					suckersForward := TRUE;
					railingUp := TRUE;
					centeringForward := FALSE;
					cmdRollerClose := TRUE;
					doSuck := FALSE;
				
					stateRobotAuto := stateRobotAutoPrepareHead2;
				
				stateRobotAutoPrepareHead2:
				
					IF stateSuckers = stateSuckersForward AND stateRailing = stateRailingUp AND stateCentering = stateCenteringBack AND stateRoller = stateRollerClosed THEN
						stateRobotAuto := stateRobotAutoGoToTable;
					END_IF

				stateRobotAutoGoToTable:
					
					MakeMove_0.MoveType := moveTypeGoToTable;
					MakeMove_0.Execute := TRUE;		
					stateRobotAuto := stateRobotAutoGoToTable2;
				
				stateRobotAutoGoToTable2:
						
					IF MakeMove_0.Done THEN
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
				
				stateRobotAutoSeparator:

					IF robotData.placeSaparator THEN
						stateRobotAuto := stateRobotAutoSeparator2;	
					ELSE
						stateRobotAuto := stateRobotAutoPlaceFirstHalf;	
					END_IF

				stateRobotAutoSeparator2:
					
					MakeMove_0.MoveType := moveTypeGoForSeparator;
					MakeMove_0.Execute := TRUE;
					stateRobotAuto := stateRobotAutoSeparator3;	

				stateRobotAutoSeparator3:

					IF MakeMove_0.Done THEN
						TON_Robot(IN := FALSE);
						stateRobotAuto := stateRobotAutoSeparator4;
					END_IF
				
				stateRobotAutoSeparator4:
					
					doSuck := TRUE;
				
					TON_Robot(IN := TRUE, PT := T#2s);
					IF TON_Robot.Q THEN
						MakeMove_0.MoveType := moveTypePutSeparatorOnPallet;
						MakeMove_0.Execute := TRUE;
						stateRobotAuto := stateRobotAutoSeparator5;					
					END_IF
				
				stateRobotAutoSeparator5:
				
					IF MakeMove_0.Done THEN
						doSuck := FALSE;
						stateRobotAuto := stateRobotAutoSeparator6;					
					END_IF

				stateRobotAutoSeparator6:
					
					MakeMove_0.MoveType := moveTypeVerticalOffset;
					MakeMove_0.Execute := TRUE;	
					stateRobotAuto := stateRobotAutoSeparator7;	
				
				stateRobotAutoSeparator7:
				
					IF MakeMove_0.Done THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf;					
					END_IF						

				stateRobotAutoPlaceFirstHalf:
					
					suckersForward := FALSE;
					stateRobotAuto := stateRobotAutoPlaceFirstHalf2;					

				
				stateRobotAutoPlaceFirstHalf2:
				
					IF stateSuckers = stateSuckersBack THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf3;					
					END_IF						
						
				stateRobotAutoPlaceFirstHalf3:
					
					MakeMove_0.MoveType := moveTypePlaceFirstHalf;
					MakeMove_0.Execute := TRUE;						
					stateRobotAuto := stateRobotAutoPlaceFirstHalf4;		
				
				stateRobotAutoPlaceFirstHalf4:
					
					IF MakeMove_0.Done THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf5;
					END_IF					
				
				stateRobotAutoPlaceFirstHalf5:
	
					cmdRollerOpen := TRUE;
				
					IF stateRoller = stateRollerOpened THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf6;
					END_IF		
				
				stateRobotAutoPlaceFirstHalf6:
					
					railingUp := TRUE;
					centeringForward := FALSE;
				
					IF stateRailing = stateRailingUp AND stateCentering = stateCenteringBack THEN
						stateRobotAuto := stateRobotAutoPlaceFirstHalf7;
					END_IF
				
				stateRobotAutoPlaceFirstHalf7:
					
					MakeMove_0.MoveType := moveTypeVerticalOffset2;
					MakeMove_0.Execute := TRUE;		
					stateRobotAuto := stateRobotAutoPlaceFirstHalf8;
					
				stateRobotAutoPlaceFirstHalf8:
					
					IF MakeMove_0.Done THEN
						stateRobotAuto := stateRobotAutoPrepareHead;
					END_IF	
				
			END_CASE
		
	END_CASE
	
	IF MakeMove_0.Done THEN
		MakeMove_0.Execute := FALSE;
	END_IF
						
	
	(* Atrima -> Comau *)
	C5G.Raw.OUT[0].0 := C5G.Data.OUT.DriveOn;
	C5G.Raw.OUT[0].1 := C5G.Data.OUT.NoDriveOff;
	C5G.Raw.OUT[0].2 := C5G.Data.OUT.Start;
	C5G.Raw.OUT[0].3 := C5G.Data.OUT.NoHold;
	C5G.Raw.OUT[0].4 := C5G.Data.OUT.U1;
	C5G.Raw.OUT[0].5 := C5G.Data.OUT.U2;
	C5G.Raw.OUT[0].6 := C5G.Data.OUT.U3;
	C5G.Raw.OUT[0].7 := C5G.Data.OUT.U4;
	C5G.Raw.OUT[0].8 := C5G.Data.OUT.CancelAlarm;
	C5G.Raw.OUT[0].9 := C5G.Data.OUT.SafetySpeed;


	MakeMove_0();
	
	//alarms
	alarmImagePalletization[50] := NOT C5G.ModuleOk;
	alarmImagePalletization[45] := robotEdmError;
	alarmImagePalletization[46] := robotDoorEdmError;
	alarmImagePalletization[47] := NOT C5G.Data.IN.Remote;
	alarmImagePalletization[48] := NOT C5G.Data.IN.NoAlarm;
	
	MTBasicsPWM_0(Enable :=  alarmImagePalletization[48] AND NOT acknowledgeImagePalletization[48], Period := 1, DutyCycle := 50);
	C5G.Data.OUT.CancelAlarm := MTBasicsPWM_0.Out;
	
	//edge alarms
	IF acknowledgeImagePalletization[49] THEN
		alarmImagePalletization[49] := FALSE;
	END_IF
	
END_PROGRAM
