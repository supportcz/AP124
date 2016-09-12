(* control of arms *)

ACTION HorizontalArmsControl: 
	
	IF modeOfOperation = modeNotReadyToStart THEN
		stateArms := stateArmsUndefined;
	END_IF
	
	CASE stateArms OF
		stateArmsUndefined:
			
			IF diLeftArmClosed AND diRightArmClosed AND NOT diLeftArmOpened AND NOT diRightArmOpened THEN
				stateArms := stateArmsClosed;
			END_IF

			IF diLeftArmOpened AND diRightArmOpened AND NOT diLeftArmClosed AND NOT diRightArmClosed THEN
				stateArms := stateArmsOpened;
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
				stateArms := stateArmsOpened;
			END_IF	
			//timeout left side?
			IF TON_LeftRequest.Q THEN
				alarmImage[4] := TRUE;
				stateArms := stateArmsClosed;
			END_IF
			//timeout right side?
			IF TON_RightRequest.Q THEN
				alarmImage[5] := TRUE;
				stateArms := stateArmsClosed;
			END_IF
		
		stateArmsOpened:
		
			// command to close 
			IF cmdCloseArms THEN
				TON_LeftRequest(IN := FALSE);
				TON_RightRequest(IN := FALSE);
				stateArms := stateArmsClosing;		
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
				stateArms := stateArmsClosed;
			END_IF	
			//timeout left side?
			IF TON_LeftRequest.Q THEN
				alarmImage[2] := TRUE;
				stateArms := stateArmsOpened;
			END_IF
			//timeout right side?
			IF TON_RightRequest.Q THEN
				alarmImage[3] := TRUE;
				stateArms := stateArmsOpened;
			END_IF

		stateArmsClosed:

			// command to open 
			IF cmdOpenArms THEN
				TON_LeftRequest(IN := FALSE);
				TON_RightRequest(IN := FALSE);
				stateArms := stateArmsOpening;	
			END_IF	
			
	END_CASE
	
	//edge alarms
	IF acknowledgeImage[2] THEN
		alarmImage[2] := FALSE;
	END_IF
	IF acknowledgeImage[3] THEN
		alarmImage[3] := FALSE;
	END_IF
	IF acknowledgeImage[4] THEN
		alarmImage[4] := FALSE;
	END_IF
	IF acknowledgeImage[5] THEN
		alarmImage[5] := FALSE;
	END_IF

END_ACTION


