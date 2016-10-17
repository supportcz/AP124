
ACTION Rotation: 

	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateRotation := stateRotationUndefined;
	END_IF
	
	CASE stateRotation OF
		
		stateRotationUndefined:
			
			IF diRotationBack AND NOT diRotationForward THEN
				stateRotation := stateRotationBack;
			END_IF

			IF NOT diRotationBack AND diRotationForward THEN
				stateRotation := stateRotationForward;
			END_IF
		
			IF stateRotation = stateRotationUndefined THEN
				// command back 
				IF NOT rotationForward THEN
					TON_RotationRequest(IN := FALSE);
					stateRotation := stateRotationMovingBack;		
				END_IF

				// command forward 
				IF rotationForward THEN
					TON_RotationRequest(IN := FALSE);
					stateRotation := stateRotationMovingForward;	
				END_IF	
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
			//run timer		
			TON_RotationRequest(IN := NOT diRotationForward, PT := T#5s);
			//timeout?
			IF TON_RotationRequest.Q THEN
				alarmImagePalletization[20] := TRUE;
				stateRotation := stateRotationUndefined;
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
			//start timer		
			TON_RotationRequest(IN := NOT diRotationBack, PT := T#5s);
			//timeout ?
			IF TON_RotationRequest.Q THEN
				alarmImagePalletization[21] := TRUE;
				stateRotation := stateRotationUndefined;
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
	IF acknowledgeImagePalletization[26] THEN
		alarmImagePalletization[26] := FALSE;
	END_IF	
END_ACTION
