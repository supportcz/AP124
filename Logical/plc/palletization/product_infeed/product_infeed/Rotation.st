
ACTION Rotation: 

	IF modeZonePalletization = modeZoneOff THEN
		stateRotation := stateRotationUndefined;
	END_IF
	
	CASE stateRotation OF
		
		stateRotationUndefined:
			
			IF diRotationBack AND NOT diRotationForward THEN
				rotationForward := FALSE;
				stateRotation := stateRotationBack;
			END_IF

			IF NOT diRotationBack AND diRotationForward THEN
				rotationForward := TRUE;
				stateRotation := stateRotationForward;
			END_IF
		
			IF stateRotation = stateRotationUndefined THEN
				//set output
				doRotationForward := FALSE;
				//invert second output
				doRotationBack := NOT doRotationForward;
			END_IF
						
		stateRotationMovingForward:
			
			//set output
			doRotationForward := TRUE;
			//invert second output
			doRotationBack := NOT doRotationForward;
			//check
			IF diRotationForward THEN
				stateRotation := stateRotationForward;
			END_IF	
			// timer		
			TON_RotationRequest(IN := NOT diRotationForward, PT := T#5s);
			IF TON_RotationRequest.Q THEN
				rotationForward := FALSE;
				alarmImagePalletization[20] := TRUE;
				stateRotation := stateRotationBack;
			END_IF
			
		stateRotationForward:
		
			// command back 
			IF NOT rotationForward THEN
				TON_RotationRequest(IN := FALSE);
				stateRotation := stateRotationMovingBack;		
			END_IF

		stateRotationMovingBack:

			//set output
			doRotationBack := TRUE;
			//invert second output 
			doRotationForward := NOT doRotationBack;
			//check
			IF diRotationBack THEN
				stateRotation := stateRotationBack;
			END_IF	
			// timer		
			TON_RotationRequest(IN := NOT diRotationBack, PT := T#5s);
			IF TON_RotationRequest.Q THEN
				rotationForward := TRUE;
				alarmImagePalletization[21] := TRUE;
				stateRotation := stateRotationForward;
			END_IF

		stateRotationBack:

			// command forward 
			IF rotationForward THEN
				TON_RotationRequest(IN := FALSE);
				stateRotation := stateRotationMovingForward;	
			END_IF	
	END_CASE
	
	//alarms
	IF stateRotation = stateRotationUndefined THEN
		alarmImagePalletization[19] := TRUE;
	ELSE
		alarmImagePalletization[19] := FALSE;
	END_IF
		
	//edge alarms
	IF acknowledgeImagePalletization[20] THEN
		alarmImagePalletization[20] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[21] THEN
		alarmImagePalletization[21] := FALSE;
	END_IF

END_ACTION
