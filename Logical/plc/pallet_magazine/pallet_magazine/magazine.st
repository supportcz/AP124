(* control of magazine *)

ACTION MagazineControl: 
	
	CASE magazineState OF
		stateInit:
			
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
			
			TON_VerticalMovement.IN := TRUE;
			TON_VerticalMovement.PT := T#6s;
			//position reached?
			IF diMagazineUpperPosition THEN
				TON_VerticalMovement.IN := FALSE;
				doMagazineDown := doMagazineUp :=  FALSE;
				magazineState := stateUpperPosition;
			END_IF	

			//timeout
			IF TON_VerticalMovement.Q THEN
				MpAlarmXSet(gAlarmXCore,'UpperPositionNotReached');
				TON_VerticalMovement.IN := FALSE;
				doMagazineDown := doMagazineUp :=  FALSE;
				magazineState := oldMagazineState;
			END_IF	
		
		stateUpperPosition:
	
			IF cmdDown THEN
				cmdDown := FALSE;
				doMagazineDown := TRUE;
				oldMagazineState := magazineState;
				magazineState := stateMoveToMiddlePosition;
			END_IF	
	
		stateMoveToMiddlePosition:
			
			TON_VerticalMovement.IN := TRUE;
			TON_VerticalMovement.PT := T#6s;
			//position reached?
			IF diMagazineMiddlePositon THEN
				TON_VerticalMovement.IN := FALSE;
				doMagazineDown := doMagazineUp :=  FALSE;
				magazineState := stateMiddlePosition;
			END_IF	

			//timeout
			IF TON_VerticalMovement.Q THEN
				MpAlarmXSet(gAlarmXCore,'MiddlePositionNotReached');
				TON_VerticalMovement.IN := FALSE;
				doMagazineDown := doMagazineUp :=  FALSE;
				magazineState := oldMagazineState;
			END_IF
				
		stateMiddlePosition:
			IF cmdDown THEN
				cmdDown := FALSE;
				doMagazineDown := TRUE;
				oldMagazineState := magazineState;
				magazineState := stateMoveToLowerPosition;
			END_IF	
			
			IF cmdUp THEN
				cmdUp := FALSE;
				doMagazineUp := TRUE;
				oldMagazineState := magazineState;
				magazineState := stateMoveToUpperPosition;
			END_IF	
		
		stateMoveToLowerPosition:
		
			TON_VerticalMovement.IN := TRUE;
			TON_VerticalMovement.PT := T#6s;
			//position reached?
			IF diMagazineLowerPosition THEN
				TON_VerticalMovement.IN := FALSE;
				doMagazineDown := doMagazineUp :=  FALSE;
				magazineState := stateLowerPosition;
			END_IF	

			//timeout
			IF TON_VerticalMovement.Q THEN
				MpAlarmXSet(gAlarmXCore,'LowerPositionNotReached');
				TON_VerticalMovement.IN := FALSE;
				doMagazineDown := doMagazineUp :=  FALSE;
				magazineState := oldMagazineState;
			END_IF
		
		stateLowerPosition:
			IF cmdUp THEN
				cmdUp := FALSE;
				doMagazineUp := TRUE;
				oldMagazineState := magazineState;
				magazineState := stateMoveToMiddlePosition;
			END_IF	

	END_CASE
				
	TON_VerticalMovement();

	//brake control
	IF doMagazineUp OR doMagazineDown THEN
		doMagazineBrake := TRUE;
	ELSE
		doMagazineBrake := FALSE;
	END_IF
	
END_ACTION
