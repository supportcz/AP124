
ACTION Interlayer: 

	doInterlayerEnable := modeZonePalletization <> modeZoneOff;
	doInterlayerPowerOn := TRUE;
	
//	diInterlayerSheetPresent;
	
	IF modeZonePalletization = modeZoneOff THEN
		stateInterlayer := stateInterlayerInit;
	END_IF
	
	CASE stateInterlayer OF
		
		stateInterlayerInit:
			
			IF diInterlayerUp AND NOT diInterlayerDown THEN
				stateInterlayer := stateInterlayerUp;
			END_IF

			IF NOT diInterlayerUp AND diInterlayerDown THEN
				stateInterlayer := stateInterlayerDown;
			END_IF
		
			IF stateInterlayer = stateInterlayerInit THEN
				IF cmdInterlayerUp THEN
					stateInterlayer := stateInterlayerGoUp;
				END_IF	
			
				IF cmdInterlayerDown THEN
					stateInterlayer := stateInterlayerGoDown;
				END_IF	
			END_IF
						
		stateInterlayerGoUp:
			
			//set output
			doInterlayerUp := TRUE;

			//position reached?
			IF diInterlayerUp OR NOT diNoInterlayerSheet OR NOT cmdInterlayerUp THEN
				StopInterlayer;
			END_IF
			
		stateInterlayerUp:
		
			IF cmdInterlayerDown THEN
				stateInterlayer := stateInterlayerGoDown;
			END_IF	
			cmdInterlayerUp := FALSE;

		stateInterlayerGoDown:
			
			//first go up 
			doInterlayerUp := TRUE;
			doInterlayerDown := FALSE;
			
			TON_JumpUp(IN := TRUE, PT := T#0.05s);
			IF TON_JumpUp.Q THEN
				stateInterlayer := stateInterlayerGoDown2;
			END_IF
		
		stateInterlayerGoDown2:
		
			//set output		
			doInterlayerUp := FALSE;
			doInterlayerDown := TRUE;
			
			//position reached?
			IF diInterlayerDown OR NOT cmdInterlayerDown THEN
				StopInterlayer;
			END_IF			
			
		stateInterlayerDown:

			IF cmdInterlayerUp THEN
				stateInterlayer := stateInterlayerGoUp;
			END_IF	
			cmdInterlayerDown := FALSE;
	END_CASE
	
	CASE modeZonePalletization OF
		
		modeZoneOff: 

		modeZoneManual:

			IF modeZonePalletizationOld <> modeZoneManual THEN
				cmdInterlayerUp := FALSE;
				cmdInterlayerDown := FALSE;
				interlayerSheetMagazineEmpty := FALSE;
			END_IF	
			
			stateInterlayerAuto := stateInterlayerAutoInit;
		
		modeZoneAuto:
			
			CASE stateInterlayerAuto OF
				
				stateInterlayerAutoInit:
				
					stateInterlayerAuto := stateInterlayerAutoGoDown;
				
				stateInterlayerAutoGoDown:
				
					IF diNoInterlayerSheet THEN
						stateInterlayerAuto := stateInterlayerAutoFill;
					ELSE
						cmdInterlayerDown := TRUE;	
					END_IF
					cmdInterlayerUp := FALSE;
				
				stateInterlayerAutoFill:
					
					IF diNoInterlayerSheet THEN
						cmdInterlayerUp := TRUE;
					END_IF
					cmdInterlayerDown := FALSE;	
				
					IF stateInterlayer = stateInterlayerUp THEN
						stateInterlayerAuto := stateInterlayerAutoEmpty;
					END_IF	
				
				stateInterlayerAutoEmpty:
					
					interlayerSheetMagazineEmpty := TRUE;
					cmdInterlayerDown := TRUE;
				
			END_CASE
		
	END_CASE	
	
	alarmImagePalletization[43] := diInterlayerUpperHwEnd;
	alarmImagePalletization[44] := diInterlayerSafeFrame;
	
			
END_ACTION

ACTION StopInterlayer: 
	cmdInterlayerUp := FALSE;
	cmdInterlayerDown := FALSE;
	doInterlayerUp := doInterlayerDown :=  FALSE;
	stateInterlayer := stateInterlayerInit;
	TON_JumpUp(IN := FALSE);
END_ACTION

