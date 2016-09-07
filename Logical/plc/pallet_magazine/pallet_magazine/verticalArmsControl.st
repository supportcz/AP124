(* control of magazine *)

ACTION VerticalArmsControl: 
	
	IF modeOfOperation = notReadyToStart THEN
		magazineState := stateMagazineUndefined;
	END_IF
	
	CASE magazineState OF
		stateMagazineUndefined:
			
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
				VerticalFinishMovement;
				magazineState := stateUpperPosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				VerticalFinishMovement;
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
				VerticalFinishMovement;
				magazineState := stateMiddlePosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				VerticalFinishMovement;
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
				VerticalFinishMovement;
				magazineState := stateMiddlePosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				VerticalFinishMovement;
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
				VerticalFinishMovement;
				magazineState := stateLowerPosition;
			END_IF	
			//timeout?
			IF TON_VerticalMovement.Q THEN
				VerticalFinishMovement;
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
	
	IF diMagazineUpperHwEnd AND cmdUp THEN
		MpAlarmXSet(gAlarmXCore,'MagazineUpperHwEndReached');
	END_IF

	IF diMagazineLooseChain AND cmdDown THEN
		MpAlarmXSet(gAlarmXCore,'MagazineLooseChain');
	END_IF
	
	IF diMotorProtectionP11 THEN
		MpAlarmXReset(gAlarmXCore,'MotorProtectionP11');
	ELSE
		MpAlarmXSet(gAlarmXCore,'MotorProtectionP11');
	END_IF
	
END_ACTION

ACTION VerticalFinishMovement:
	TON_VerticalMovement(IN := FALSE);
	doMagazineDown := doMagazineUp :=  FALSE;
END_ACTION