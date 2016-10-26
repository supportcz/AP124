ACTION TurnTable: 
	
	acpI_P18_2.switchOn := TRUE;
	acpI_P18_2.speed := 500;
			
	CASE stateTurnTable OF
		
		stateTurnTableInit:
			
		
		stateTurnTablePos1:
		
		
		stateTurnTableMovingToPos2:

		stateTurnTablePos2:
		
		stateTurnTableMovingToPos1:

	END_CASE

	//control of ACOPOSinverter
	acpI_P18_2();

END_ACTION
