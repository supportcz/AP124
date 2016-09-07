(* control of arms *)

ACTION HorizontalArmsControl: 
	
	IF modeOfOperation = notReadyToStart THEN
		armsState := stateArmsUndefined;
	END_IF
	
	CASE armsState OF
		stateArmsUndefined:
			
			IF diLeftArmClosed AND diRightArmClosed AND NOT diLeftArmOpened AND NOT diRightArmOpened THEN
				armsState := stateArmsClosed;
			END_IF

			IF diLeftArmOpened AND diRightArmOpened AND NOT diLeftArmClosed AND NOT diRightArmClosed THEN
				armsState := stateArmsOpened;
			END_IF
			
		stateArmsOpening:
			
			//set output
			doCloseArms := FALSE;
			//invert second output
			doOpenArms := NOT doCloseArms;
			//start left timer		
			TON_LeftRequest(IN := NOT diLeftArmOpened, PT := T#6s);
			//start right timer		
			TON_RightRequest(IN := NOT diRightArmOpened, PT := T#6s);
			//open check
			IF diLeftArmOpened AND diRightArmOpened THEN
				armsState := stateArmsOpened;
			END_IF	
			//timeout left side?
			IF TON_LeftRequest.Q THEN
				MpAlarmXSet(gAlarmXCore,'LeftArmNotOpened');
				armsState := stateArmsClosed;
			END_IF
			//timeout right side?
			IF TON_RightRequest.Q THEN
				MpAlarmXSet(gAlarmXCore,'RightArmNotOpened');
				armsState := stateArmsClosed;
			END_IF
		
		stateArmsOpened:
		
			// command to close 
			IF cmdCloseArms THEN
				TON_LeftRequest(IN := FALSE);
				TON_RightRequest(IN := FALSE);
				armsState := stateArmsClosing;		
			END_IF

		stateArmsClosing:

			//set output
			doCloseArms := TRUE;
			//invert second output 
			doOpenArms := NOT doCloseArms;
			//start left timer		
			TON_LeftRequest(IN := NOT diLeftArmClosed, PT := T#6s);
			//start right timer		
			TON_RightRequest(IN := NOT diRightArmClosed, PT := T#6s);
			//close check
			IF diLeftArmClosed AND diRightArmClosed THEN
				armsState := stateArmsClosed;
			END_IF	
			//timeout left side?
			IF TON_LeftRequest.Q THEN
				MpAlarmXSet(gAlarmXCore,'LeftArmNotClosed');
				armsState := stateArmsOpened;
			END_IF
			//timeout right side?
			IF TON_RightRequest.Q THEN
				MpAlarmXSet(gAlarmXCore,'RightArmNotClosed');
				armsState := stateArmsOpened;
			END_IF

		stateArmsClosed:

			// command to open 
			IF cmdOpenArms THEN
				TON_LeftRequest(IN := FALSE);
				TON_RightRequest(IN := FALSE);
				armsState := stateArmsOpening;	
			END_IF	
			
	END_CASE
	
END_ACTION


