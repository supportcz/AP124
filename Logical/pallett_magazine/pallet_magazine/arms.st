(* control of arms *)

ACTION ArmsControl: 
	
	// get arms state 
	armsState := undefinedState;
		
	IF leftArmClosed AND rightArmClosed AND NOT leftArmOpened AND NOT rightArmOpened THEN
		armsState := armsClosed;
	END_IF

	IF leftArmOpened AND rightArmOpened AND NOT leftArmClosed AND NOT rightArmClosed THEN
		armsState := armsOpened;
	END_IF
	
	// command to close 
	IF cmdCloseArms THEN
		//set output
		closeArms := TRUE;
		(* invert second output *)
		openArms := NOT closeArms;
	END_IF
						
	// command to open 
	IF cmdOpenArms THEN
		//set output
		closeArms := FALSE;
		(* invert second output *)
		openArms := NOT closeArms;
	END_IF	
	
	//close left check
	TON_CloseLeftRequest.IN := closeArms;
	TON_CloseLeftRequest.PT := T#6s;
	IF leftArmClosed THEN
		TON_CloseLeftRequest.IN := FALSE;
	END_IF	
	
	TON_CloseLeftRequest();
	
	IF TON_CloseLeftRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'LeftArmNotClosed');
	ELSE
		MpAlarmXReset(gAlarmXCore,'LeftArmNotClosed');
	END_IF

	//close right check
	TON_CloseRightRequest.IN := closeArms;
	TON_CloseRightRequest.PT := T#6s;
	IF rightArmClosed THEN
		TON_CloseRightRequest.IN := FALSE;
	END_IF	
	
	TON_CloseRightRequest();
	
	IF TON_CloseRightRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'RightArmNotClosed');
	ELSE
		MpAlarmXReset(gAlarmXCore,'RightArmNotClosed');		
	END_IF

	//open left check
	TON_OpenLeftRequest.IN := openArms;
	TON_OpenLeftRequest.PT := T#6s;
	IF leftArmOpened THEN
		TON_OpenLeftRequest.IN := FALSE;
	END_IF	
	
	TON_OpenLeftRequest();
	
	IF TON_OpenLeftRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'LeftArmNotOpened');
	ELSE
		MpAlarmXReset(gAlarmXCore,'LeftArmNotOpened');
	END_IF


	//open right check
	TON_OpenRightRequest.IN := openArms;
	TON_OpenRightRequest.PT := T#6s;
	IF rightArmOpened THEN
		TON_OpenRightRequest.IN := FALSE;
	END_IF	
	
	TON_OpenRightRequest();
	
	IF TON_OpenRightRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'RightArmNotOpened');
	ELSE
		MpAlarmXReset(gAlarmXCore,'RightArmNotOpened');
	END_IF

END_ACTION
