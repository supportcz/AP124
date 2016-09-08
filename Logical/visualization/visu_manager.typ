
TYPE
	gVisu_type : 	STRUCT 
		page_MpAlarmXList : page_MpAlarmXList_type;
		ChangePage : UINT;
		TON_0 : TON_10ms;
		CurrentPage : UINT;
	END_STRUCT;
	PageControl_enum : 
		(
		Idle := 0,
		ButtonAutomaticMode := 1,
		ButtonManualMode := 2,
		ButtonInfo := 3,
		ButtonAlarmPage := 4,
		ButtonSDM := 5,
		ButtonSettings := 6
		);
	page_Control : 	STRUCT 
	END_STRUCT;
	page_MpAlarmXList_type : 	STRUCT 
		Severity : ARRAY[0..6]OF UDINT; (*Alarm severity*)
		Code : ARRAY[0..6]OF UDINT; (*Alarm code*)
		Message : ARRAY[0..6]OF WSTRING[255]; (*Message describing the alarm*)
		Name : ARRAY[0..6]OF STRING[255]; (*Unique alarm name within the current scope*)
		StateActive : ARRAY[0..6]OF BOOL; (*Alarm is in Active state (according OPC UA Part 9: Alarms and Conditions)*)
		StateAcknowledged : ARRAY[0..6]OF BOOL; (*Alarm is in Acknowledged state (according OPC UA Part 9: Alarms and Conditions)*)
		ListboxLineDisable : ARRAY[0..6]OF INT;
		Timestamp : ARRAY[0..6]OF STRING[50]; (*Timestamp of when the alarm was set*)
		PositionFilter_layer : INT;
		ButtonMultiDown : BOOL;
		ButtonMultiUp : BOOL;
		ButtonDown : BOOL;
		ButtonUp : BOOL;
		SelectedIndex : UINT;
		SelectedIndex_old : UINT;
		ListboxSelected : UINT;
		ListboxSelected_old : UINT;
		AlarmCount : UINT;
		Ackownledge : BOOL;
		AckownledgeAll : BOOL;
	END_STRUCT;
END_TYPE
