(* control of magazine *)

ACTION MagazineControl: 
	
	magazineState := undefinedState1;
	
	IF diMagazineUpperPosition AND NOT diMagazineMiddlePositon AND NOT diMagazineLowerPosition THEN
		magazineState := upperPosition;
	END_IF

	IF NOT diMagazineUpperPosition AND diMagazineMiddlePositon AND NOT diMagazineLowerPosition THEN
		magazineState := middlePosition;
	END_IF

	IF NOT diMagazineUpperPosition AND NOT diMagazineMiddlePositon AND diMagazineLowerPosition THEN
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
	IF diMagazineUpperPosition THEN
		TON_MoveToTheUpperPositon.IN := FALSE;
	END_IF	

	TON_MoveToTheUpperPositon();

	IF TON_MoveToTheUpperPositon.Q THEN
		MpAlarmXSet(gAlarmXCore,'UpperPositionNotReached');
		moveToUpperPosition := FALSE;
	END_IF
				
				
	//brake control
	IF doMagazineUp OR doMagazineDown THEN
		doMagazineBrake := TRUE;
	ELSE
		doMagazineBrake := FALSE;
	END_IF
	
END_ACTION
