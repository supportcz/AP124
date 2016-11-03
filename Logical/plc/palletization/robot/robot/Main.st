PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

		(* @GET output data from RAW *)
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

	
	CASE modeZonePalletization OF
		
		modeZoneOff:
		
		modeZoneManual:
			
			IF modeZonePalletizationOld <> modeZoneManual THEN

			END_IF
			stateRobotAuto := stateRobotAutoInit;
		
		
		modeZoneAuto:
		
			CASE stateRobotAuto OF
				
				stateRobotAutoInit:
				
					stateRobotAuto := stateRobotAutoGoToHome;
				
				stateRobotAutoGoToHome:
				
					
				
			END_CASE
		
	END_CASE
	
	
	(* @SET output data to RAW *)
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

	
	alarmImagePalletization[45] := robotEdmError;
	alarmImagePalletization[46] := robotDoorEdmError;

	 
END_PROGRAM
