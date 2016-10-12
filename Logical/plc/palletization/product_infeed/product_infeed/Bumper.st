
ACTION Bumper: 

	IF modePalletization = modePalletizationNotReadyToStart THEN
		stateBumper := stateBumperUndefined;
	END_IF
	
	CASE stateBumper OF
		
		stateBumperUndefined:
			
			IF diBumperForward THEN
				stateBumper := stateBumperForward;
			ELSE
				stateBumper := stateBumperBack;
			END_IF
		
		stateBumperMovingForward:
			
			doBumper := TRUE;
			
			IF diBumperForward THEN 
				stateBumper := stateBumperForward;
			END_IF
		
		stateBumperForward:
			
			IF bumperAuto THEN
				bumperForward := FALSE;
			END_IF
		
			IF NOT bumperForward THEN
				stateBumper := stateBumperMovingBack;
			END_IF
		
		stateBumperMovingBack:
		
			doBumper := FALSE;
			
			IF NOT diBumperForward THEN 
				TON_Bumper(IN:=FALSE);
				stateBumper := stateBumperBack;
			END_IF
		
		stateBumperBack:
			
			TON_Bumper(IN:=TRUE,PT:=T#0.2s);
			IF bumperAuto AND TON_Bumper.Q THEN
				bumperForward := TRUE;
			END_IF
			
			IF bumperForward THEN
				stateBumper := stateBumperMovingForward;
			END_IF
		
	END_CASE
END_ACTION
