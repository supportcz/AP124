
TYPE
	gVisu_type : 	STRUCT 
		page_MpAlarmXList : page_MpAlarmXList_type;
	END_STRUCT;
	page_MpAlarmXList_type : 	STRUCT 
		Severity : ARRAY[0..6]OF UDINT; (*Alarm severity*)
		Code : ARRAY[0..6]OF UDINT; (*Alarm code*)
		Message : ARRAY[0..6]OF WSTRING[255]; (*Message describing the alarm*)
		Name : ARRAY[0..6]OF STRING[255]; (*Unique alarm name within the current scope*)
		StateActive : ARRAY[0..6]OF BOOL; (*Alarm is in Active state (according OPC UA Part 9: Alarms and Conditions)*)
		StateAcknowledged : ARRAY[0..6]OF BOOL; (*Alarm is in Acknowledged state (according OPC UA Part 9: Alarms and Conditions)*)
		Timestamp : ARRAY[0..6]OF STRING[50]; (*Timestamp of when the alarm was set*)
		PositionFilter_layer : INT;
		SelectedIndex_old : USINT;
		ButtonMultiDown : BOOL;
		ButtonMultiUp : BOOL;
		ButtonDown : BOOL;
		ButtonUp : BOOL;
		SelectedIndex : USINT;
		ListboxSelected_old : USINT;
		AlarmCount : USINT;
		ListboxSelected : USINT;
	END_STRUCT;
END_TYPE
