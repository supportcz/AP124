(* control of magazine *)

ACTION VerticalArmsControl: 
	
	IF modeOfOperation = modeNotReadyToStart THEN
		stateMagazine := stateMagazineUndefined;
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
					cmdDown := FALSE;
					TON_VerticalMovement(IN := FALSE);
					stateMagazine := stateMoveToLowerPosition;
				END_IF	
			
				IF cmdUp THEN
					cmdUp := FALSE;
					TON_VerticalMovement(IN := FALSE);
					stateMagazine := stateMoveToUpperPosition;
				END_IF	
			END_IF
			
			doMagazineDown := doMagazineUp :=  FALSE;
		
		stateMoveToUpperPosition:
			//set output			
			doMagazineUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineUpperPosition THEN
				stateMagazine := stateMagazineUndefined;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				alarmImage[7] := TRUE;
				stateMagazine := stateMagazineUndefined;
			END_IF	
		
		stateUpperPosition:
	
			IF cmdDown THEN
				cmdDown := FALSE;
				IF palletOnConveyorP12 AND stateArms = stateArmsClosed THEN
					alarmImage[13] := TRUE;
				ELSE
					TON_VerticalMovement(IN := FALSE);
					stateMagazine := stateMoveToLowerPosition;
				END_IF
			END_IF	
	
		stateMoveLowerToMiddlePosition:
			//set output			
			doMagazineUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineMiddlePositon THEN
				stateMagazine := stateMagazineUndefined;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				alarmImage[8] := TRUE;
				stateMagazine := stateMagazineUndefined;
			END_IF
		
		stateMiddlePosition:
			
			IF cmdDown THEN
				cmdDown := FALSE;
				IF palletOnConveyorP12 AND stateArms = stateArmsClosed THEN
					alarmImage[13] := TRUE;
				ELSE
					TON_VerticalMovement(IN := FALSE);
					stateMagazine := stateMoveToLowerPosition;
				END_IF
			END_IF	
			
			IF cmdUp THEN
				cmdUp := FALSE;
				TON_VerticalMovement(IN := FALSE);
				stateMagazine := stateMoveToUpperPosition;
			END_IF	
		
		stateMoveToLowerPosition:
			//set output		
			doMagazineDown := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineLowerPosition THEN
				stateMagazine := stateMagazineUndefined;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				alarmImage[9] := TRUE;
				stateMagazine := stateMagazineUndefined;
			END_IF
		
		stateLowerPosition:
			IF cmdUp THEN
				cmdUp := FALSE;
				TON_VerticalMovement(IN := FALSE);
				stateMagazine := stateMoveLowerToMiddlePosition;
			END_IF	

	END_CASE
				
	//brake control
	IF doMagazineUp OR doMagazineDown THEN
		doMagazineBrake := TRUE;
	ELSE
		doMagazineBrake := FALSE;
	END_IF
	
	IF diMagazineUpperHwEnd AND cmdUp THEN
		alarmImage[10] := TRUE;
	END_IF

	IF diMagazineLooseChain AND cmdDown THEN
		alarmImage[11] := TRUE;
	END_IF
	

	
	//edge alarms
	IF acknowledgeImage[7] THEN
		alarmImage[7] := FALSE;
	END_IF
	IF acknowledgeImage[8] THEN
		alarmImage[8] := FALSE;
	END_IF
	IF acknowledgeImage[9] THEN
		alarmImage[9] := FALSE;
	END_IF
	IF acknowledgeImage[10] THEN
		alarmImage[10] := FALSE;
	END_IF
	IF acknowledgeImage[11] THEN
		alarmImage[11] := FALSE;
	END_IF
	IF acknowledgeImage[13] THEN
		alarmImage[13] := FALSE;
	END_IF
	
END_ACTION
