
ACTION Interlayer: 

	doInterlayerEnable := TRUE;
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
			IF diInterlayerUp OR NOT cmdInterlayerUp THEN
				StopInterlayer;
			END_IF
			
		stateInterlayerUp:
		
			IF cmdInterlayerDown THEN
				stateInterlayer := stateInterlayerGoDown;
			END_IF	
			cmdInterlayerUp := FALSE;

		stateInterlayerGoDown:

			//set output		
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
			END_IF
		
			stateInterlayerAuto := stateInterlayerAutoInit;
		
		modeZoneAuto:
			
			CASE stateInterlayerAuto OF
				
				stateInterlayerAutoInit:
				
					stateInterlayerAuto := stateInterlayerAutoFill;
				
				stateInterlayerAutoFill:
				
					cmdInterlayerUp := NOT diInterlayerSheetPresent;
				
					IF stateInterlayer = stateInterlayerUp THEN
						stateInterlayerAuto := stateInterlayerAutoEmpty;
					END_IF						
				
				stateInterlayerAutoEmpty:
					
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
END_ACTION

