(* control of arms *)

ACTION ArmsControl: 
	
	// get arms state 
	armsState := undefinedState;
		
	IF diLeftArmClosed AND diRightArmClosed AND NOT diLeftArmOpened AND NOT diRightArmOpened THEN
		armsState := armsClosed;
	END_IF

	IF diLeftArmOpened AND diRightArmOpened AND NOT diLeftArmClosed AND NOT diRightArmClosed THEN
		armsState := armsOpened;
	END_IF
	
	// command to close 
	IF cmdCloseArms THEN
		//set output
		doCloseArms := TRUE;
		(* invert second output *)
		doOpenArms := NOT doCloseArms;
	END_IF
						
	// command to open 
	IF cmdOpenArms THEN
		//set output
		doCloseArms := FALSE;
		(* invert second output *)
		doOpenArms := NOT doCloseArms;
	END_IF	
	
	//close left check
	TON_CloseLeftRequest.IN := doCloseArms;
	TON_CloseLeftRequest.PT := T#6s;
	IF diLeftArmClosed THEN
		TON_CloseLeftRequest.IN := FALSE;
	END_IF	
	
	TON_CloseLeftRequest();
	
	IF TON_CloseLeftRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'LeftArmNotClosed');
		doCloseArms := FALSE;
	END_IF

	//close right check
	TON_CloseRightRequest.IN := doCloseArms;
	TON_CloseRightRequest.PT := T#6s;
	IF diRightArmClosed THEN
		TON_CloseRightRequest.IN := FALSE;
	END_IF	
	
	TON_CloseRightRequest();
	
	IF TON_CloseRightRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'RightArmNotClosed');
		doCloseArms := FALSE;
	END_IF

	//open left check
	TON_OpenLeftRequest.IN := doOpenArms;
	TON_OpenLeftRequest.PT := T#6s;
	IF diLeftArmOpened THEN
		TON_OpenLeftRequest.IN := FALSE;
	END_IF	
	
	TON_OpenLeftRequest();
	
	IF TON_OpenLeftRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'LeftArmNotOpened');
		doOpenArms := FALSE;
	END_IF

	//open right check
	TON_OpenRightRequest.IN := doOpenArms;
	TON_OpenRightRequest.PT := T#6s;
	IF diRightArmOpened THEN
		TON_OpenRightRequest.IN := FALSE;
	END_IF	
	
	TON_OpenRightRequest();
	
	IF TON_OpenRightRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'RightArmNotOpened');
		doOpenArms := FALSE;
	END_IF

END_ACTION
