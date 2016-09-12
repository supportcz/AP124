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
		
			VerticalFinishMovement;
		
		stateMoveToUpperPosition:
			//set output			
			doMagazineUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineUpperPosition THEN
				VerticalFinishMovement;
				stateMagazine := stateUpperPosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				VerticalFinishMovement;
				alarmImage[7] := TRUE;
				stateMagazine := stateMiddlePosition;
			END_IF	
		
		stateUpperPosition:
	
			IF cmdDown THEN
				stateMagazine := stateMoveUpperToMiddlePosition;
			END_IF	
	
		stateMoveUpperToMiddlePosition:

			//set output
			doMagazineDown := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineMiddlePositon THEN
				VerticalFinishMovement;
				stateMagazine := stateMiddlePosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				VerticalFinishMovement;
				alarmImage[8] := TRUE;
				stateMagazine := stateUpperPosition;
			END_IF
				
		stateMoveLowerToMiddlePosition:
			//set output			
			doMagazineUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineMiddlePositon THEN
				VerticalFinishMovement;
				stateMagazine := stateMiddlePosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				VerticalFinishMovement;
				alarmImage[8] := TRUE;
				stateMagazine := stateLowerPosition;
			END_IF
		
		stateMiddlePosition:
			
			IF cmdDown THEN
				stateMagazine := stateMoveToLowerPosition;
			END_IF	
			
			IF cmdUp THEN
				stateMagazine := stateMoveToUpperPosition;
			END_IF	
		
		stateMoveToLowerPosition:
			//set output		
			doMagazineDown := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineLowerPosition THEN
				VerticalFinishMovement;
				stateMagazine := stateLowerPosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				VerticalFinishMovement;
				alarmImage[9] := TRUE;
				stateMagazine := stateMiddlePosition;
			END_IF
		
		stateLowerPosition:
			IF cmdUp THEN
				stateMagazine := stateMoveLowerToMiddlePosition;
			END_IF	

	END_CASE
				
	//brake control
	IF doMagazineUp OR doMagazineDown THEN
		doMagazineBrake := TRUE;
	ELSE
		doMagazineBrake := FALSE;
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
	
END_ACTION

ACTION VerticalFinishMovement:
	TON_VerticalMovement(IN := FALSE);
	doMagazineDown := doMagazineUp :=  FALSE;
END_ACTION