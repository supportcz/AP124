(* control of magazine *)

ACTION PusherLifting: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		StopMovement;
	END_IF
	
	CASE statePusherLifting OF
		statePusherLiftingUndefined:
			
			IF diPusherLiftingUpperPosition AND NOT diPusherLiftingLowerPosition THEN
				statePusherLifting := stateUpperPosition;
			END_IF

			IF NOT diPusherLiftingUpperPosition AND diPusherLiftingLowerPosition THEN
				statePusherLifting := stateLowerPosition;
			END_IF

		
			IF statePusherLifting = statePusherLiftingUndefined THEN
				IF cmdPusherLiftingDown THEN
					TON_VerticalMovement(IN := FALSE);
					statePusherLifting := stateMoveToLowerPosition;
				END_IF	
			
				IF cmdPusherLiftingUp THEN
					TON_VerticalMovement(IN := FALSE);
					statePusherLifting := stateMoveToUpperPosition;
				END_IF	
			END_IF
							
		stateMoveToUpperPosition:
			//set output			
			doPusherLiftingUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#3s);
			//position reached?
			IF diPusherLiftingUpperPosition OR NOT cmdPusherLiftingUp THEN
				StopMovement;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				alarmImagePalletization[16] := TRUE;
				StopMovement;
			END_IF	
		
		stateUpperPosition:
	
			IF cmdPusherLiftingDown THEN
				TON_VerticalMovement(IN := FALSE); 
				statePusherLifting := stateMoveToLowerPosition;
			END_IF	
			cmdPusherLiftingUp := FALSE;
		
		
		stateMoveToLowerPosition:
			//set output		
			doPusherLiftingDown := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#3s);
			//position reached?
			IF diPusherLiftingLowerPosition OR NOT cmdPusherLiftingDown THEN
				StopMovement;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				alarmImagePalletization[17] := TRUE;
				StopMovement;
			END_IF
		
		stateLowerPosition:
			
			IF cmdPusherLiftingUp THEN
				TON_VerticalMovement(IN := FALSE);
				statePusherLifting := stateMoveToUpperPosition;
			END_IF	
			cmdPusherLiftingDown := FALSE;

	END_CASE
				
	//brake control
	IF doPusherLiftingUp OR doPusherLiftingDown THEN
		doPusherLiftingBrake := TRUE;
	ELSE
		doPusherLiftingBrake := FALSE;
	END_IF

	alarmImagePalletization[18] := NOT diMotorProtectionP3;
	
	//edge alarms
	IF acknowledgeImagePalletization[16] THEN
		alarmImagePalletization[16] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[17] THEN
		alarmImagePalletization[17] := FALSE;
	END_IF	
END_ACTION

ACTION StopMovement: 
	cmdPusherLiftingUp := FALSE;
	cmdPusherLiftingDown := FALSE;
	doPusherLiftingDown := doPusherLiftingUp :=  FALSE;
	statePusherLifting := statePusherLiftingUndefined;
END_ACTION