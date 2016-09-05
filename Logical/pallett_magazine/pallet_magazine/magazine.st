(* control of magazine *)

ACTION MagazineControl: 
	
	magazineState := undefinedState1;
	
	IF magazineUpperPosition AND NOT magazineMiddlePositon AND NOT magazineLowerPosition THEN
		magazineState := upperPosition;
	END_IF

	IF NOT magazineUpperPosition AND magazineMiddlePositon AND NOT magazineLowerPosition THEN
		magazineState := middlePosition;
	END_IF

	IF NOT magazineUpperPosition AND NOT magazineMiddlePositon AND magazineLowerPosition THEN
		magazineState := lowerPosition;
	END_IF

	
	CASE magazineState OF
		undefinedState1:
		
		upperPosition:
	
			IF cmdDown THEN
				moveToMiddlePosition := TRUE;
			END_IF	
	
		middlePosition:
			IF cmdDown THEN
				moveToLowerPosition := TRUE;
			END_IF	
			
			IF cmdUp THEN
				moveToUpperPosition := TRUE;
			END_IF	
		
		lowerPosition:
			IF cmdUp THEN
				moveToUpperPosition := TRUE;
			END_IF	

	END_CASE
				
	
	//move to upper position check
	TON_MoveToTheUpperPositon.IN := moveToUpperPosition;
	TON_MoveToTheUpperPositon.PT := T#6s;
	IF magazineUpperPosition THEN
		TON_MoveToTheUpperPositon.IN := FALSE;
	END_IF	

	TON_MoveToTheUpperPositon();

	IF TON_MoveToTheUpperPositon.Q THEN
		MpAlarmXSet(gAlarmXCore,'UpperPositionNotReached');
		moveToUpperPosition := FALSE;
	END_IF
				
				
	//brake control
	IF magazineUp OR magazineDown THEN
		magazineBrake := TRUE;
	ELSE
		magazineBrake := FALSE;
	END_IF
	
END_ACTION
