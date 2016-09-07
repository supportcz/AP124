(* control of arms *)

ACTION ArmsControl: 
	
	CASE armsState OF
		stateInit1:
			
			IF diLeftArmClosed AND diRightArmClosed AND NOT diLeftArmOpened AND NOT diRightArmOpened THEN
				armsState := stateArmsClosed;
			END_IF

			IF diLeftArmOpened AND diRightArmOpened AND NOT diLeftArmClosed AND NOT diRightArmClosed THEN
				armsState := stateArmsOpened;
			END_IF
			
		stateArmsOpening:
		
		stateArmsOpened:
			
		stateArmsClosing:
			
		stateArmsClosed:
			
	END_CASE
	
	// command to close 
	IF cmdCloseArms THEN
		//set output
		doCloseArms := TRUE;
		//invert second output 
		doOpenArms := NOT doCloseArms;
		//start left timer		
		TON_CloseLeftRequest.IN := TRUE;
		TON_CloseLeftRequest.PT := T#6s;
		//start right timer		
		TON_CloseRightRequest.IN := TRUE;
		TON_CloseRightRequest.PT := T#6s;
	END_IF
						
	// command to open 
	IF cmdOpenArms THEN
		//set output
		doCloseArms := FALSE;
		//invert second output
		doOpenArms := NOT doCloseArms;
		//start left timer
		TON_OpenLeftRequest.IN := TRUE;
		TON_OpenLeftRequest.PT := T#6s;
		//start right timer		
		TON_OpenRightRequest.IN := TRUE;
		TON_OpenRightRequest.PT := T#6s;
	END_IF	
	
	//close left check
	IF diLeftArmClosed THEN
		TON_CloseLeftRequest.IN := FALSE;
	END_IF	
	
	TON_CloseLeftRequest();
	
	IF TON_CloseLeftRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'LeftArmNotClosed');
		doCloseArms := FALSE;
	END_IF

	//close right check
	IF diRightArmClosed THEN
		TON_CloseRightRequest.IN := FALSE;
	END_IF	
	
	TON_CloseRightRequest();
	
	IF TON_CloseRightRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'RightArmNotClosed');
		doCloseArms := FALSE;
	END_IF

	//open left check
	IF diLeftArmOpened THEN
		TON_OpenLeftRequest.IN := FALSE;
	END_IF	
	
	TON_OpenLeftRequest();
	
	IF TON_OpenLeftRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'LeftArmNotOpened');
		doOpenArms := FALSE;
	END_IF

	//open right check
	IF diRightArmOpened THEN
		TON_OpenRightRequest.IN := FALSE;
	END_IF	
	
	TON_OpenRightRequest();
	
	IF TON_OpenRightRequest.Q THEN
		MpAlarmXSet(gAlarmXCore,'RightArmNotOpened');
		doOpenArms := FALSE;
	END_IF

END_ACTION
