
ACTION Roller: 
	
	IF modeZonePalletization = modeZoneOff THEN
		stateRoller := stateRollerInit;
	END_IF
	
	CASE stateRoller OF
		
		stateRollerInit:
			
			IF diRollerOpened AND NOT diRollerClosed THEN
				stateRoller := stateRollerOpened;
			END_IF

			IF NOT diRollerOpened AND diRollerClosed  THEN
				stateRoller := stateRollerClosed;
			END_IF
			
			//default state
			IF stateRoller = stateRollerInit THEN
				IF cmdRollerOpen THEN
					TON_RollerRequest(IN := FALSE);
					stateRoller := stateRollerOpening;
				END_IF	
			
				IF cmdRollerClose THEN
					TON_RollerRequest(IN := FALSE);
					stateRoller := stateRollerClosing;
				END_IF	
			END_IF
						
		stateRollerOpening:
			
			//set output
			doRollerOpen := TRUE;

			// check
			IF diRollerOpened OR NOT cmdRollerOpen THEN
				StopMovement;
			END_IF
			
			// timer		
			TON_RollerRequest(IN := TRUE, PT := T#6s);
			IF TON_RollerRequest.Q THEN
				alarmImagePalletization[40] := TRUE;
				StopMovement;
			END_IF
		
		stateRollerOpened:
		
			IF cmdRollerClose THEN
				TON_RollerRequest(IN := FALSE); 
				stateRoller := stateRollerClosing;
			END_IF	
			cmdRollerOpen := FALSE;

		stateRollerClosing:

			//set output		
			doRollerClose := TRUE;
			//position reached?
			IF diRollerClosed OR NOT cmdRollerClose THEN
				StopMovement;
			END_IF	
			
			// timer
			TON_RollerRequest(IN := TRUE, PT := T#6s);
			IF TON_RollerRequest.Q THEN
				alarmImagePalletization[41] := TRUE;
				StopMovement;
			END_IF

		stateRollerClosed:

			IF cmdRollerOpen THEN
				TON_RollerRequest(IN := FALSE);
				stateRoller := stateRollerOpening;
			END_IF	
			cmdRollerClose := FALSE;
	END_CASE

	// brake control
	doRollerBrake := doRollerOpen OR doRollerClose;
	
	
	// alarms
	IF acknowledgeImagePalletization[40] THEN
		alarmImagePalletization[40] := FALSE;
	END_IF
	IF acknowledgeImagePalletization[41] THEN
		alarmImagePalletization[41] := FALSE;
	END_IF

	
	
END_ACTION

ACTION StopMovement: 
	cmdRollerClose := FALSE;
	cmdRollerOpen := FALSE;
	doRollerClose := doRollerOpen :=  FALSE;
	stateRoller := stateRollerInit;
END_ACTION