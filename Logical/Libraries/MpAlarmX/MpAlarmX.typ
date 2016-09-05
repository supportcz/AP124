(*Enumerations*)

TYPE
	MpAlarmXListUIStatusEnum : 
		(
		mpALARMX_LIST_UI_STATUS_IDLE := 0, (*Indicates that no process is currently active*)
		mpALARMX_LIST_UI_STATUS_ERROR := 99 (*The last operation generated an error*)
		);
	MpAlarmXStateEnum : 
		(
		mpALARMX_STATE_NONE := 0, (*Default state, alarm is not enabled*)
		mpALARMX_STATE_ACTIVE := 1, (*Active state, according OPC UA state model*)
		mpALARMX_STATE_INACTIVE := 2, (*Inactive state, according OPC UA state model*)
		mpALARMX_STATE_ACKNOWLEDGED := 3, (*Acknowledged state, according OPC UA state model*)
		mpALARMX_STATE_UNACKNOWLEDGED := 4 (*Unacknowledged state, according OPC UA state model*)
		);
	MpAlarmXHistoryUIStatusEnum : 
		(
		mpALARMX_HISTORY_UI_STATUS_IDLE := 0, (*Indicates that no process is currently active*)
		mpALARMX_HISTORY_UI_STATUS_ERROR := 99 (*The last operation generated an error*)
		);
END_TYPE

(*FB Info Types*)

TYPE
	MpAlarmXStatusIDType : 	STRUCT 
		ID : MpAlarmXErrorEnum; (*StatusID as enumerator*)
		Severity : MpComSeveritiesEnum; (*Severity of the error*)
		Code : UINT; (*Error code*)
	END_STRUCT;
	MpAlarmXDiagType : 	STRUCT 
		StatusID : MpAlarmXStatusIDType; (*Segmented StatusID output*)
	END_STRUCT;
	MpAlarmXInfoType : 	STRUCT 
		Diag : MpAlarmXDiagType; (*Additional diagnostic information*)
	END_STRUCT;
END_TYPE

(*UIConnect Types*)

TYPE
	MpAlarmXListUIAlarmListType : 	STRUCT 
		Severity : ARRAY[0..49]OF UDINT; (*Alarm severity*)
		Code : ARRAY[0..49]OF UDINT; (*Alarm code*)
		Message : ARRAY[0..49]OF WSTRING[255]; (*Message describing the alarm*)
		AdditionalInformation1 : ARRAY[0..49]OF WSTRING[255]; (*A link with addidional information*)
		AdditionalInformation2 : ARRAY[0..49]OF WSTRING[255]; (*A link with addidional information*)
		InstanceID : ARRAY[0..49]OF UDINT; (*Unique alarm identity*)
		Scope : ARRAY[0..49]OF STRING[255]; (*The scope of the alarm*)
		Name : ARRAY[0..49]OF STRING[255]; (*Unique alarm name within the current scope*)
		StateActive : ARRAY[0..49]OF BOOL; (*Alarm is in Active state (according OPC UA Part 9: Alarms and Conditions)*)
		StateAcknowledged : ARRAY[0..49]OF BOOL; (*Alarm is in Acknowledged state (according OPC UA Part 9: Alarms and Conditions)*)
		Timestamp : ARRAY[0..49]OF STRING[50]; (*Timestamp of when the alarm was set*)
		SelectedIndex : UINT; (*The index of the currently selected alarm*)
		MaxSelection : UINT; (*The index of the last available alarm*)
		PageUp : BOOL; (*Command: Page Up (Scroll Up)*)
		PageDown : BOOL; (*Command: Page Down (Scroll Down)*)
		StepUp : BOOL; (*Command: Line Up (Scroll Up)*)
		StepDown : BOOL; (*Command: Line Down (Scroll Down)*)
		RangeStart : REAL; (*Displayed range: Start %*)
		RangeEnd : REAL; (*Displayed range: End %*)
	END_STRUCT;
	MpAlarmXListUIDetailsType : 	STRUCT 
		Severity : UDINT; (*Alarm severity*)
		Code : UDINT; (*Alarm code*)
		Message : WSTRING[255]; (*Message describing the alarm*)
		AdditionalInformation1 : WSTRING[255]; (*A link with addidional information*)
		AdditionalInformation2 : WSTRING[255]; (*A link with addidional information*)
		InstanceID : UDINT; (*Unique alarm identity*)
		Scope : STRING[255]; (*The scope of the alarm*)
		Name : STRING[255]; (*Unique alarm name within the current scope*)
		StateActive : BOOL; (*Alarm is in Active state (according OPC UA Part 9: Alarms and Conditions)*)
		StateAcknowledged : BOOL; (*Alarm is in Acknowledged state (according OPC UA Part 9: Alarms and Conditions)*)
		Timestamp : STRING[50]; (*Timestamp of when the alarm was set*)
	END_STRUCT;
	MpAlarmXListUIConnectType : 	STRUCT 
		Status : MpAlarmXListUIStatusEnum; (*Current operation*)
		AlarmList : MpAlarmXListUIAlarmListType; (*List of available alarms*)
		Acknowledge : BOOL; (*Command: Acknowledge the selected alarm*)
		AcknowledgeAll : BOOL; (*Command: Acknowledge all alarms*)
		Details : MpAlarmXListUIDetailsType; (*Currently selected alarm*)
		Language : STRING[20]; (*Language ID that should be used when displaying data*)
	END_STRUCT;
	MpAlarmXListUISetupType : 	STRUCT 
		AlarmListSize : UINT := 20; (*Alarm list size*)
		AlarmListScrollWindow : USINT := 1; (*Scroll window (overlap for PageUp/Down)*)
	END_STRUCT;
	MpAlarmXHistoryUIAlarmListType : 	STRUCT 
		Severity : ARRAY[0..49]OF UDINT; (*Alarm severity*)
		Code : ARRAY[0..49]OF UDINT; (*Alarm code*)
		Message : ARRAY[0..49]OF WSTRING[255]; (*Message describing the alarm*)
		AdditionalInformation1 : ARRAY[0..49]OF WSTRING[255]; (*A link with addidional information*)
		AdditionalInformation2 : ARRAY[0..49]OF WSTRING[255]; (*A link with addidional information*)
		Scope : ARRAY[0..49]OF STRING[255]; (*The scope of the alarm*)
		Name : ARRAY[0..49]OF STRING[255]; (*Unique alarm name within the current scope*)
		OldState : ARRAY[0..49]OF MpAlarmXStateEnum; (*State change of this entry - the old state (according OPC UA Part 9: Alarms and Conditions)*)
		NewState : ARRAY[0..49]OF MpAlarmXStateEnum; (*State change of this entry - the new state (according OPC UA Part 9: Alarms and Conditions)*)
		Timestamp : ARRAY[0..49]OF STRING[50]; (*Timestamp of the state change (from OldState to NewState)*)
		SelectedIndex : UINT; (*The index of the currently selected alarm*)
		MaxSelection : UINT; (*The index of the last available alarm*)
		PageUp : BOOL; (*Command: Page Up (Scroll Up)*)
		PageDown : BOOL; (*Command: Page Down (Scroll Down)*)
		StepUp : BOOL; (*Command: Line Up (Scroll Up)*)
		StepDown : BOOL; (*Command: Line Down (Scroll Down)*)
		RangeStart : REAL; (*Displayed range: Start %*)
		RangeEnd : REAL; (*Displayed range: End %*)
	END_STRUCT;
	MpAlarmXHistoryUIDetailsType : 	STRUCT 
		Severity : UDINT; (*Alarm severity*)
		Code : UDINT; (*Alarm code*)
		Message : WSTRING[255]; (*Message describing the alarm*)
		AdditionalInformation1 : WSTRING[255]; (*A link with addidional information*)
		AdditionalInformation2 : WSTRING[255]; (*A link with addidional information*)
		Scope : STRING[255]; (*The scope of the alarm*)
		Name : STRING[255]; (*Unique alarm name within the current scope*)
		OldState : MpAlarmXStateEnum; (*State change of this entry - the old state (according OPC UA Part 9: Alarms and Conditions)*)
		NewState : MpAlarmXStateEnum; (*State change of this entry - the new state (according OPC UA Part 9: Alarms and Conditions)*)
		Timestamp : STRING[50]; (*Timestamp of the state change (from OldState to NewState)*)
		DataDescriptions : ARRAY[0..9]OF STRING[50]; (*List of attached data to the alarm: data descriptions*)
		DataValues : ARRAY[0..9]OF STRING[255]; (*List of attached data to the alarm: data values*)
	END_STRUCT;
	MpAlarmXHistoryUIConnectType : 	STRUCT 
		Status : MpAlarmXHistoryUIStatusEnum; (*Current operation*)
		AlarmList : MpAlarmXHistoryUIAlarmListType; (*List of available alarms*)
		Details : MpAlarmXHistoryUIDetailsType; (*Currently selected alarm*)
		Language : STRING[20]; (*Language ID that should be used when displaying data*)
	END_STRUCT;
	MpAlarmXHistoryUISetupType : 	STRUCT 
		AlarmListSize : UINT := 20; (*Alarm list size*)
		AlarmListScrollWindow : USINT := 1; (*Scroll window (overlap for PageUp/Down)*)
	END_STRUCT;
END_TYPE
