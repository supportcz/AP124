(* control of arms *)

ACTION HorizontalArmsControl: 
	
	IF modeMagazine = modeMagazineNotReadyToStart THEN
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
		
			IF stateArms = stateArmsUndefined THEN
				// command to close 
				IF closeArms THEN
					TON_LeftRequest(IN := FALSE);
					TON_RightRequest(IN := FALSE);
					stateArms := stateArmsClosing;		
				ELSE
				// command to open 
					TON_LeftRequest(IN := FALSE);
					TON_RightRequest(IN := FALSE);
					stateArms := stateArmsOpening;	
				END_IF	
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
				alarmImageMagazine[4] := TRUE;
				stateArms := stateArmsUndefined;
			END_IF
			//timeout right side?
			IF TON_RightRequest.Q THEN
				alarmImageMagazine[5] := TRUE;
				stateArms := stateArmsUndefined;
			END_IF
		
		stateArmsOpened:
		
			// command to close 
			IF closeArms THEN
				IF stateMagazine = stateUpperPosition THEN
					alarmImageMagazine[16] := TRUE;
					stateArms := stateArmsUndefined;
				ELSE	
					TON_LeftRequest(IN := FALSE);
					TON_RightRequest(IN := FALSE);
					stateArms := stateArmsClosing;		
				END_IF
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
				alarmImageMagazine[2] := TRUE;
				stateArms := stateArmsUndefined;
			END_IF
			//timeout right side?
			IF TON_RightRequest.Q THEN
				alarmImageMagazine[3] := TRUE;
				stateArms := stateArmsUndefined;
			END_IF

		stateArmsClosed:

			// command to open 
			IF NOT closeArms THEN
				IF stateMagazine = stateLowerPosition OR (diReset AND stateMagazine <> stateUpperPosition) THEN
					TON_LeftRequest(IN := FALSE);
					TON_RightRequest(IN := FALSE);
					stateArms := stateArmsOpening;	
				ELSE	
					alarmImageMagazine[15] := TRUE;
				END_IF
			END_IF	
	END_CASE
	
	//alarms
	IF stateArms = stateArmsUndefined THEN
		alarmImageMagazine[0] := TRUE;
	ELSE
		alarmImageMagazine[0] := FALSE;
	END_IF
	
	//edge alarms
	IF acknowledgeImageMagazine[2] THEN
		alarmImageMagazine[2] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[3] THEN
		alarmImageMagazine[3] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[4] THEN
		alarmImageMagazine[4] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[5] THEN
		alarmImageMagazine[5] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[15] THEN
		alarmImageMagazine[15] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[16] THEN
		alarmImageMagazine[16] := FALSE;
	END_IF

END_ACTION


