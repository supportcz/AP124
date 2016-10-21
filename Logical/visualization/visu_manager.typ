
TYPE
	gVisu_type : 	STRUCT 
		ChangePage : UINT;
		TON_0 : TON_10ms;
		CurrentPage : UINT;
		ChangeLanguage : UINT;
		LanguageLayer : UINT;
		CurrentLanguage : UINT;
		TON_PW : TON_10ms;
		DesiredPage : UINT;
		Password : STRING[80];
		PasswordStatusDatapoint : UINT;
		InfoLock : UINT;
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
	PasswordManagment_enum : 
		(
		LOGOUT := 0,
		LOGIN := 1,
		AUTHORIZE := 2,
		LOGEDIN := 3
		);
END_TYPE
