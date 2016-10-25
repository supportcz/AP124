
ACTION Railing: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
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
				doRailingDown := NOT doRailingUp;
			END_IF
						
		stateRailingMovingUp:
			
			//set output
			doRailingUp := TRUE;
			doRailingDown := NOT doRailingUp;

			//open check
			IF diRailingUp AND NOT diRailingDown THEN
				stateRailing := stateRailingUp;
			END_IF	
			// timer		
			TON_RailingRequest(IN := TRUE, PT := T#5s);
			IF TON_RailingRequest.Q THEN
				alarmImagePalletization[8] := TRUE;
				railingUp := FALSE;
				stateRailing := stateRailingDown;
			END_IF

		
		stateRailingUp:
		
			// command to go down 
			IF NOT railingUp THEN
				TON_RailingRequest(IN := FALSE);
				stateRailing := stateRailingMovingDown;
			END_IF

		stateRailingMovingDown:

			//set output
			doRailingUp := FALSE;
			doRailingDown := NOT doRailingUp;
			// check
			IF NOT diRailingUp AND diRailingDown THEN
				stateRailing := stateRailingDown;
			END_IF	
			//timer
			TON_RailingRequest(IN := TRUE, PT := T#5s);
			IF TON_RailingRequest.Q THEN
				alarmImagePalletization[32] := TRUE;
				railingUp := TRUE;
				stateRailing := stateRailingUp;
			END_IF

		stateRailingDown:

			// command to go ip 
			IF railingUp THEN
				TON_RailingRequest(IN := FALSE);
				stateRailing := stateRailingMovingUp;
			END_IF
	END_CASE

	//alarms
	IF stateRailing = stateRailingInit THEN
		alarmImagePalletization[33] := TRUE;
	ELSE
		alarmImagePalletization[33] := FALSE;
	END_IF
	
	//edge alarms
	IF acknowledgeImagePalletization[8] THEN
		alarmImagePalletization[8] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[32] THEN
		alarmImagePalletization[32] := FALSE;
	END_IF

	
END_ACTION
