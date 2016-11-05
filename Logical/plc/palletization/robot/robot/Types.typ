
TYPE
	C5GMap_In_typ : 	STRUCT 
		NoAlarm : BOOL;
		DriveOnStatus : BOOL;
		Start_NoHoldPrgMove : BOOL;
		Remote : BOOL;
		TeachEnabled : BOOL;
		U1 : BOOL;
		U2 : BOOL;
		U3 : BOOL;
		U4 : BOOL;
		NoLatchAlarmActive : BOOL;
		SafetySpeedActive : BOOL;
		ProgrammingMode : BOOL;
		Reserved : BOOL;
		Local_Remote : BOOL;
		SystemReady : BOOL;
		HeartBit : BOOL;
	END_STRUCT;
	C5GMap_Out_typ : 	STRUCT 
		DriveOn : BOOL;
		NoDriveOff : BOOL;
		Start : BOOL;
		NoHold : BOOL;
		U1 : BOOL;
		U2 : BOOL;
		U3 : BOOL;
		U4 : BOOL;
		CancelAlarm : BOOL;
		SafetySpeed : BOOL;
	END_STRUCT;
	C5GMap_DATA_typ : 	STRUCT 
		IN : C5GMap_In_typ;
		OUT : C5GMap_Out_typ;
	END_STRUCT;
	C5GMap_RAW_typ : 	STRUCT 
		IN : ARRAY[0..IN_SIZE]OF UDINT;
		OUT : ARRAY[0..OUT_SIZE]OF UDINT;
	END_STRUCT;
	C5GMap_typ : 	STRUCT 
		ModuleOk : BOOL;
		Data : C5GMap_DATA_typ;
		Raw : C5GMap_RAW_typ;
	END_STRUCT;
END_TYPE
