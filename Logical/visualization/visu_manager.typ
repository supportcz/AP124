
TYPE
	gVisu_type : 	STRUCT 
		ChangePage : UINT;
		TON_0 : TON_10ms;
		CurrentPage : UINT;
		ChangeLanguage : UINT;
		CurrentLanguage : UINT;
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
END_TYPE
