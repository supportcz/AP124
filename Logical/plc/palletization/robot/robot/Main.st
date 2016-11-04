PROGRAM _INIT
	
	C5G.Data.OUT.NoDriveOff := TRUE;
	C5G.Data.OUT.NoHold := TRUE;
	 
END_PROGRAM

PROGRAM _CYCLIC

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
	//added:
	C5G.Data.IN.moveActive			:= C5G.Raw.IN[1].0;
	C5G.Data.IN.isItSafeToGoHome	:= C5G.Raw.IN[1].1;
	C5G.Data.IN.moveType			:= UDINT_TO_USINT(SHR(C5G.Raw.IN[1], 8));
	C5G.Data.IN.productType			:= UDINT_TO_USINT(SHR(C5G.Raw.IN[1], 16));
	C5G.Data.IN.nbOfLayers			:= UDINT_TO_USINT(SHR(C5G.Raw.IN[1], 24));
	

	//drive on	
	MTBasicsPWM_1(Enable :=  C5G.Data.IN.NoAlarm AND NOT C5G.Data.IN.DriveOnStatus, Period := 1, DutyCycle := 50);
	C5G.Data.OUT.DriveOn := MTBasicsPWM_1.Out;
		
	dataConsistent := C5G.Data.OUT.moveType = C5G.Data.IN.moveType AND C5G.Data.OUT.productType = C5G.Data.IN.productType AND C5G.Data.OUT.nbOfLayers = C5G.Data.IN.nbOfLayers; 
	
	
	CASE modeZonePalletization OF
		
		modeZoneOff:
		
		modeZoneManual:
			
			IF modeZonePalletizationOld <> modeZoneManual THEN

			END_IF
			stateRobotAuto := stateRobotAutoInit;
		
		
		modeZoneAuto:
		
			CASE stateRobotAuto OF
				
				stateRobotAutoInit:
				
					C5G.Data.OUT.moveType := moveTypeNo;
					
					stateRobotAuto := stateRobotAutoStart;
				
				stateRobotAutoStart:

					MTBasicsPWM_2(Enable :=  NOT C5G.Data.IN.Start_NoHoldPrgMove, Period := 1, DutyCycle := 50);
					C5G.Data.OUT.Start := MTBasicsPWM_2.Out;

					IF C5G.Data.IN.Start_NoHoldPrgMove THEN
						stateRobotAuto := stateRobotAutoStart2;
					END_IF

				stateRobotAutoStart2:

					stateRobotAuto := stateRobotAutoGoToHome;
				
				stateRobotAutoGoToHome:
				
					IF C5G.Data.IN.isItSafeToGoHome THEN
						stateRobotAuto := stateRobotAutoGoToHome2;
						C5G.Data.OUT.moveType := moveTypeGoHome;
					ELSE
						alarmImagePalletization[49] := TRUE;
					END_IF
				
				stateRobotAutoGoToHome2:
					
					IF dataConsistent THEN
						C5G.Data.OUT.startMove := TRUE;
						stateRobotAuto := stateRobotAutoGoToHome3;
					END_IF

				stateRobotAutoGoToHome3:
					
					IF NOT C5G.Data.OUT.startMove THEN
						stateRobotAuto := stateRobotAutoWait;
					END_IF						
				
				stateRobotAutoWait:

				
			END_CASE
		
	END_CASE
	
	IF C5G.Data.IN.moveActive THEN
		C5G.Data.OUT.startMove := TRUE;
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
	//added
	C5G.Raw.OUT[1] := 0;
	C5G.Raw.OUT[1].0 := C5G.Data.OUT.startMove;
	
	
	C5G.Raw.OUT[1] := C5G.Raw.OUT[1] OR SHL(DINT_TO_UDINT(C5G.Data.OUT.moveType),8);
	C5G.Raw.OUT[1] := C5G.Raw.OUT[1] OR SHL(USINT_TO_UDINT(C5G.Data.OUT.productType),16);
	C5G.Raw.OUT[1] := C5G.Raw.OUT[1] OR SHL(USINT_TO_UDINT(C5G.Data.OUT.nbOfLayers),24);

	
	//alarms
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
