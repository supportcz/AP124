ACTION TurnTable: 
		
	acpI_P18_2.switchOn := TRUE;
	turnTableSpeed := 1500;

	CASE stateTurnTable OF
		
		stateTurnTableInit:
			
			acpI_P18_2.run := FALSE;
		
			IF diEntrySwitch THEN		
				stateTurnTable := stateTurnTableEntryPosition;
			END_IF
		
			IF diExitSwitch THEN		
				stateTurnTable := stateTurnTableExitPosition;
			END_IF
		
			IF stateTurnTable = stateTurnTableInit THEN
				
				IF cmdTurnToEntryPosition THEN
					stateTurnTable := stateTurnTableMovingToEntryPos;					
				END_IF
				
				IF cmdTurnToExitPosition THEN
					stateTurnTable := stateTurnTableMovingToExitPos;					
				END_IF
			END_IF	
			
		stateTurnTableEntryPosition:
		
			IF cmdTurnToExitPosition THEN
				stateTurnTable := stateTurnTableMovingToExitPos;
			END_IF
			
			cmdTurnToEntryPosition := FALSE;				

		stateTurnTableMovingToExitPos:
			
			acpI_P18_2.speed := turnTableSpeed;
			acpI_P18_2.run := TRUE;
		
			IF diExitSwitch OR NOT cmdTurnToExitPosition THEN
				StopMovement;
			END_IF

		stateTurnTableExitPosition:
			
			IF cmdTurnToEntryPosition THEN
				stateTurnTable := stateTurnTableMovingToEntryPos;
			END_IF
			
			cmdTurnToExitPosition := FALSE;	
		
		stateTurnTableMovingToEntryPos:
			
			acpI_P18_2.speed := -turnTableSpeed;
			acpI_P18_2.run := TRUE;
		
			IF diEntrySwitch OR NOT cmdTurnToEntryPosition THEN
				StopMovement;
			END_IF
		
	END_CASE

	//control of ACOPOSinverter
	acpI_P18_2();

END_ACTION

ACTION StopMovement: 
	cmdTurnToEntryPosition := FALSE;
	cmdTurnToExitPosition := FALSE;
	stateTurnTable := stateTurnTableInit;
END_ACTION
