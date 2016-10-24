
ACTION Railing: 
	
	IF modeMagazine = modeMagazineNotReadyToStart THEN
		stateRailing := stateRailingInit;
	END_IF
	
	CASE stateRailing OF
		
		stateRailingInit:
			
			IF diRailingUp AND NOT diRailingDown THEN
				railingUp := TRUE;
				stateRailing := stateRailingUp;
			END_IF

			IF NOT diRailingUp AND diRailingDown THEN
				railingUp := FALSE;
				stateRailing := stateRailingDown;
			END_IF
		
			//default state
			IF stateRailing = stateRailingInit THEN
				doRailingUp := TRUE;
			END_IF
						
		stateRailingMovingUp:
			
			//set output
			doRailingUp := TRUE;

			//open check
			IF diRailingUp AND NOT diRailingDown THEN
				stateRailing := stateRailingUp;
			END_IF	
			//start timer		
			TON_MoveRequest(IN := NOT diRailingUp, PT := T#5s);
			//timeout ?
			IF TON_MoveRequest.Q THEN
				alarmImagePalletization[8] := TRUE;
				railingUp := FALSE;
				stateRailing := stateRailingDown;
			END_IF

		
		stateRailingUp:
		
//			// command to close 
//			IF closeArms THEN
//				IF stateMagazine = stateUpperPosition THEN
//					alarmImageMagazine[16] := TRUE;
//					closeArms := FALSE;
//				ELSE	
//					TON_LeftRequest(IN := FALSE);
//					TON_RightRequest(IN := FALSE);
//					stateArms := stateArmsClosing;		
//				END_IF
//			END_IF

		stateRailingMovingDown:

//			//set output
//			doCloseArms := TRUE;
//			//invert second output 
//			doOpenArms := NOT doCloseArms;
//			//start left timer		
//			TON_LeftRequest(IN := NOT diLeftArmClosed, PT := T#6s);
//			//start right timer		
//			TON_RightRequest(IN := NOT diRightArmClosed, PT := T#6s);
//			//close check
//			IF diLeftArmClosed AND diRightArmClosed THEN
//				stateArms := stateArmsClosed;
//			END_IF	
//			//timeout left side?
//			IF TON_LeftRequest.Q THEN
//				alarmImageMagazine[2] := TRUE;
//				closeArms := FALSE;
//				stateArms := stateArmsOpened;
//			END_IF
//			//timeout right side?
//			IF TON_RightRequest.Q THEN
//				alarmImageMagazine[3] := TRUE;
//				closeArms := FALSE;
//				stateArms := stateArmsOpened;
//			END_IF

		stateRailingDown:

//			// command to open 
//			IF NOT closeArms THEN
//				IF stateMagazine = stateLowerPosition OR (diReset AND stateMagazine <> stateUpperPosition) THEN
//					TON_LeftRequest(IN := FALSE);
//					TON_RightRequest(IN := FALSE);
//					stateArms := stateArmsOpening;	
//				ELSE	
//					alarmImageMagazine[15] := TRUE;
//					closeArms := TRUE;
//				END_IF
//			END_IF	
	END_CASE

	doRailingDown := NOT doRailingUp;

	//alarms
//	IF stateArms = stateArmsInit THEN
//		alarmImageMagazine[0] := TRUE;
//	ELSE
//		alarmImageMagazine[0] := FALSE;
//	END_IF
	
	//edge alarms
//	IF acknowledgeImageMagazine[2] THEN
//		alarmImageMagazine[2] := FALSE;
//	END_IF
//	IF acknowledgeImageMagazine[3] THEN
//		alarmImageMagazine[3] := FALSE;
//	END_IF
//	IF acknowledgeImageMagazine[4] THEN
//		alarmImageMagazine[4] := FALSE;
//	END_IF
//	IF acknowledgeImageMagazine[5] THEN
//		alarmImageMagazine[5] := FALSE;
//	END_IF
//	IF acknowledgeImageMagazine[15] THEN
//		alarmImageMagazine[15] := FALSE;
//	END_IF
//	IF acknowledgeImageMagazine[16] THEN
//		alarmImageMagazine[16] := FALSE;
//	END_IF

	
END_ACTION
