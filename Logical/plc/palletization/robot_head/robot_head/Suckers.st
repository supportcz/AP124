
ACTION Suckers: 
	
	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateSuckers := stateSuckersInit;
	END_IF
	
	CASE stateSuckers OF
		
		stateSuckersInit:
			
			IF diSuckerLeftFrontBack AND diSuckerLeftBackBack AND diSuckerRightFrontBack AND diSuckerRightBackBack THEN
				suckersForward := FALSE;
				stateSuckers := stateSuckersBack;
			END_IF

			IF NOT diSuckerLeftFrontBack AND NOT diSuckerLeftBackBack AND NOT diSuckerRightFrontBack AND NOT diSuckerRightBackBack THEN
				suckersForward := TRUE;
				stateSuckers := stateSuckersForward;
			END_IF
			
			//default state
			IF stateSuckers = stateSuckersInit THEN
				doSuckersForward := FALSE;
				doSuckersBack := NOT doSuckersForward;
			END_IF
						
		stateSuckersMovingBack:
			
			//set output
			doSuckersForward := FALSE;
			doSuckersBack := NOT doSuckersForward;

			// check
			IF diSuckerLeftFrontBack AND diSuckerLeftBackBack AND diSuckerRightFrontBack AND diSuckerRightBackBack THEN
//				suckersForward := FALSE;
				stateSuckers := stateSuckersBack;
			END_IF
			
			// timer		
			TON_SuckersRequest(IN := TRUE, PT := T#5s);
			IF TON_SuckersRequest.Q THEN
				alarmImagePalletization[36] := TRUE;
				suckersForward := TRUE;
				stateSuckers := stateSuckersForward;
			END_IF
		
		stateSuckersBack:
		
			// command to go down 
			IF suckersForward THEN
				TON_SuckersRequest(IN := FALSE);
				stateSuckers := stateSuckersMovingForward;
			END_IF

		stateSuckersMovingForward:

			//set output
			doSuckersForward := TRUE;
			doSuckersBack := NOT doSuckersForward;

			// check
			IF NOT diSuckerLeftFrontBack AND NOT diSuckerLeftBackBack AND NOT diSuckerRightFrontBack AND NOT diSuckerRightBackBack THEN
//				suckersForward := TRUE;
				stateSuckers := stateSuckersForward;
			END_IF
			
			//timer
			TON_SuckersRequest(IN := TRUE, PT := T#5s);
			IF TON_SuckersRequest.Q THEN
				alarmImagePalletization[35] := TRUE;
				suckersForward := FALSE;
				stateSuckers := stateSuckersBack;
			END_IF

		stateSuckersForward:

			// command to go ip 
			IF NOT suckersForward THEN
				TON_SuckersRequest(IN := FALSE);
				stateSuckers := stateSuckersMovingBack;
			END_IF
	END_CASE

	doNoSuck := NOT doSuck;
	
	//alarms
	IF stateSuckers = stateSuckersInit THEN
		alarmImagePalletization[34] := TRUE;
	ELSE
		alarmImagePalletization[34] := FALSE;
	END_IF
	
	//edge alarms
	IF acknowledgeImagePalletization[35] THEN
		alarmImagePalletization[35] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[36] THEN
		alarmImagePalletization[36] := FALSE;
	END_IF

	
END_ACTION
