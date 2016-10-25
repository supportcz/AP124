
ACTION Centering: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateCentering := stateCenteringInit;
	END_IF
	
	CASE stateCentering OF
		
		stateCenteringInit:
			
			IF diCenteringBack THEN
				centeringForward := FALSE;
				stateCentering := stateCenteringBack;
			END_IF

			IF NOT diCenteringBack THEN
				centeringForward := TRUE;
				stateCentering := stateCenteringForward;
			END_IF
			
			//default state
			IF stateCentering = stateCenteringInit THEN
				doCenteringForward := FALSE;
				doCenetringBack := FALSE;
			END_IF
						
		stateCenteringMovingBack:
			
			//set outputs
			doCenteringForward := FALSE;
			doCenteringBack := TRUE;

			// check
			IF diCenteringBack THEN
//				centeringForward := FALSE;
				stateCentering := stateCenteringBack;
			END_IF
			
			// timer		
			TON_CenteringRequest(IN := TRUE, PT := T#6s);
			IF TON_CenteringRequest.Q THEN
				alarmImagePalletization[38] := TRUE;
				centeringForward := TRUE;
				stateCentering := stateCenteringForward;
			END_IF
		
		stateCenteringBack:
		
			//set outputs
			doCenteringForward := FALSE;
			doCenteringBack := FALSE;

			// command to go down 
			IF centeringForward THEN
				TON_CenteringRequest(IN := FALSE);
				stateCentering := stateCenteringMovingForward;
			END_IF

		stateCenteringMovingForward:

			//set outputs
			doCenteringForward := TRUE;
			doCenteringBack := FALSE;
			
			//timer
			TON_CenteringRequest(IN := TRUE, PT := T#2s);
			IF TON_CenteringRequest.Q OR diCenteringForward THEN
//				centeringForward := TRUE;
				stateCentering := stateCenteringForward;
			END_IF

		stateCenteringForward:

			//set outputs
			doCenteringForward := FALSE;
			doCenteringBack := FALSE;

			// command to go up 
			IF NOT centeringForward THEN
				TON_CenteringRequest(IN := FALSE);
				stateCentering := stateCenteringMovingBack;
			END_IF
	END_CASE

	// brake control
	doCenetringBrake := doCenteringForward OR doCenteringBack;
	
	//alarms
	IF stateCentering = stateCenteringInit THEN
		alarmImagePalletization[37] := TRUE;
	ELSE
		alarmImagePalletization[37] := FALSE;
	END_IF
	
	//edge alarms
	IF acknowledgeImagePalletization[38] THEN
		alarmImagePalletization[38] := FALSE;
	END_IF


	
END_ACTION
