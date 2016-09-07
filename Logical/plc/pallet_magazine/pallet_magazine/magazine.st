(* control of magazine *)

ACTION MagazineControl: 
	
	CASE magazineState OF
		stateUndefined:
			
			IF diMagazineUpperPosition AND NOT diMagazineMiddlePositon AND NOT diMagazineLowerPosition THEN
				magazineState := stateUpperPosition;
			END_IF

			IF NOT diMagazineUpperPosition AND diMagazineMiddlePositon AND NOT diMagazineLowerPosition THEN
				magazineState := stateMiddlePosition;
			END_IF

			IF NOT diMagazineUpperPosition AND NOT diMagazineMiddlePositon AND diMagazineLowerPosition THEN
				magazineState := stateLowerPosition;
			END_IF
		
		stateMoveToUpperPosition:
			//set output			
			doMagazineUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineUpperPosition THEN
				FinishMovement;
				magazineState := stateUpperPosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				FinishMovement;
				MpAlarmXSet(gAlarmXCore,'UpperPositionNotReached');
				magazineState := stateMiddlePosition;
			END_IF	
		
		stateUpperPosition:
	
			IF cmdDown THEN
				magazineState := stateMoveUpperToMiddlePosition;
			END_IF	
	
		stateMoveUpperToMiddlePosition:

			//set output
			doMagazineDown := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineMiddlePositon THEN
				FinishMovement;
				magazineState := stateMiddlePosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				FinishMovement;
				MpAlarmXSet(gAlarmXCore,'MiddlePositionNotReached');
				magazineState := stateUpperPosition;
			END_IF
				
		stateMoveLowerToMiddlePosition:
			//set output			
			doMagazineUp := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineMiddlePositon THEN
				FinishMovement;
				magazineState := stateMiddlePosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				FinishMovement;
				MpAlarmXSet(gAlarmXCore,'MiddlePositionNotReached');
				magazineState := stateLowerPosition;
			END_IF
		
		stateMiddlePosition:
			
			IF cmdDown THEN
				magazineState := stateMoveToLowerPosition;
			END_IF	
			
			IF cmdUp THEN
				magazineState := stateMoveToUpperPosition;
			END_IF	
		
		stateMoveToLowerPosition:
			//set output		
			doMagazineDown := TRUE;
			//start timer
			TON_VerticalMovement(IN := TRUE, PT := T#6s);
			//position reached?
			IF diMagazineLowerPosition THEN
				FinishMovement;
				magazineState := stateLowerPosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				FinishMovement;
				MpAlarmXSet(gAlarmXCore,'LowerPositionNotReached');
				magazineState := stateMiddlePosition;
			END_IF
		
		stateLowerPosition:
			IF cmdUp THEN
				magazineState := stateMoveLowerToMiddlePosition;
			END_IF	

	END_CASE
				
	//brake control
	IF doMagazineUp OR doMagazineDown THEN
		doMagazineBrake := TRUE;
	ELSE
		doMagazineBrake := FALSE;
	END_IF
	
END_ACTION

ACTION FinishMovement:
	cmdUp := FALSE;
	cmdDown := FALSE;
	TON_VerticalMovement(IN := FALSE);
	doMagazineDown := doMagazineUp :=  FALSE;
END_ACTION