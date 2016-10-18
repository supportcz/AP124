(* control of magazine *)

ACTION VerticalArmsControl: 
	
	IF modeMagazine = modeMagazineNotReadyToStart THEN
		StopMovement;
	END_IF
	
	CASE stateMagazine OF
		stateMagazineUndefined:
			
			IF diMagazineUpperPosition AND NOT diMagazineMiddlePositon AND NOT diMagazineLowerPosition THEN
				stateMagazine := stateUpperPosition;
			END_IF

			IF NOT diMagazineUpperPosition AND diMagazineMiddlePositon AND NOT diMagazineLowerPosition THEN
				stateMagazine := stateMiddlePosition;
			END_IF

			IF NOT diMagazineUpperPosition AND NOT diMagazineMiddlePositon AND diMagazineLowerPosition THEN
				stateMagazine := stateLowerPosition;
			END_IF
		
			IF stateMagazine = stateMagazineUndefined THEN
				IF cmdDown THEN
					TON_VerticalMovement(IN := FALSE);
					stateMagazine := stateMoveToLowerPosition;
				END_IF	
			
				IF cmdUp THEN
					TON_VerticalMovement(IN := FALSE);
					stateMagazine := stateMoveToUpperPosition;
				END_IF	
			END_IF
							
		stateMoveToUpperPosition:
			//set output			
			doMagazineUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineUpperPosition OR NOT cmdUp THEN
				StopMovement;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				alarmImageMagazine[7] := TRUE;
				StopMovement;
			END_IF	
		
		stateUpperPosition:
	
			IF cmdDown THEN
				IF palletOnConveyorP12 = palletPresent AND stateArms = stateArmsClosed THEN
					alarmImageMagazine[13] := TRUE;
					StopMovement;
				ELSE
					TON_VerticalMovement(IN := FALSE);
					stateMagazine := stateMoveToLowerPosition;
				END_IF
			END_IF	
			cmdUp := FALSE;
	
		stateMoveLowerToMiddlePosition:
			//set output			
			doMagazineUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineMiddlePositon OR NOT cmdUp THEN
				StopMovement;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				alarmImageMagazine[8] := TRUE;
				StopMovement;
			END_IF
		
		stateMiddlePosition:
			
			IF cmdDown THEN
				IF palletOnConveyorP12 = palletPresent AND stateArms = stateArmsClosed THEN
					alarmImageMagazine[13] := TRUE;
					StopMovement;
				ELSE
					TON_VerticalMovement(IN := FALSE);
					stateMagazine := stateMoveToLowerPosition;
				END_IF
			END_IF	
			
			IF cmdUp THEN
				TON_VerticalMovement(IN := FALSE);
				stateMagazine := stateMoveToUpperPosition;
			END_IF	
		
		stateMoveToLowerPosition:
			//set output		
			doMagazineDown := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineLowerPosition OR NOT cmdDown THEN
				StopMovement;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				alarmImageMagazine[9] := TRUE;
				StopMovement;
			END_IF
		
		stateLowerPosition:
			
			IF cmdUp THEN
				TON_VerticalMovement(IN := FALSE);
				stateMagazine := stateMoveLowerToMiddlePosition;
			END_IF	
			cmdDown := FALSE;

	END_CASE
				
	//brake control
	IF doMagazineUp OR doMagazineDown THEN
		doMagazineBrake := TRUE;
	ELSE
		doMagazineBrake := FALSE;
	END_IF
	
	IF diMagazineUpperHwEnd AND cmdUp THEN
		alarmImageMagazine[10] := TRUE;
	END_IF

	IF diMagazineLooseChain AND cmdDown THEN
		alarmImageMagazine[11] := TRUE;
	END_IF
	

	
	//edge alarms
	IF acknowledgeImageMagazine[7] THEN
		alarmImageMagazine[7] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[8] THEN
		alarmImageMagazine[8] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[9] THEN
		alarmImageMagazine[9] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[10] THEN
		alarmImageMagazine[10] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[11] THEN
		alarmImageMagazine[11] := FALSE;
	END_IF
	IF acknowledgeImageMagazine[13] THEN
		alarmImageMagazine[13] := FALSE;
	END_IF
	
END_ACTION

ACTION StopMovement: 
	cmdUp := FALSE;
	cmdDown := FALSE;
	doMagazineDown := doMagazineUp :=  FALSE;
	stateMagazine := stateMagazineUndefined;
END_ACTION