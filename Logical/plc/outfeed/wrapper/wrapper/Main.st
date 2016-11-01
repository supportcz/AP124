PROGRAM _INIT
	



	diWrapperDoorCanBeOpened;
	


	
END_PROGRAM

PROGRAM _CYCLIC
	
	TON_PalletStopP19(IN := diPalletStopP19, PT := T#200ms);

	
	CASE modeZoneOutfeed OF
		
		modeZoneOff: //the automat is not ready to start

		modeZoneManual:
			
			IF modeZoneOutfeedOld <> modeZoneManual THEN
				cmdMovePalletP18 := FALSE;			
			END_IF
			
			doWrapperNoExternalStop := TRUE;
			doWrappingStart := FALSE;
			stateAuto := stateAutoUndefined;
		
		modeZoneAuto:
	
			IF adrRecipes = 0 THEN 
				RETURN;
			END_IF
	
			dRecipes ACCESS adrRecipes;
			IF dRecipes.actualRecipeIndex < 0 OR dRecipes.actualRecipeIndex > 9 THEN
				RETURN;
			END_IF
	
			dActualRecipe ACCESS ADR(dRecipes.recipe[dRecipes.actualRecipeIndex]);
			
			doWrapperSortiment1 := dActualRecipe.wrapperSortiment.0;
			doWrapperSortiment2 := dActualRecipe.wrapperSortiment.1;
			
			//stop sensor not reached
			TON_ConveyorP18(IN := cmdMovePalletP18, PT := T#20s);
			alarmImageOutfeed[4] := TON_ConveyorP18.Q;
			
			CASE stateAuto OF
				
				stateAutoUndefined:
					
					IF stateTurnTable = stateTurnTableEntryPosition THEN
						stateAuto := stateAutoWait;
					ELSE
						stateAuto := stateAutoRemovePallet;
					END_IF
					
				stateAutoWait:
					
					IF statePalletP18 = palletPresent AND stateTurnTable = stateTurnTableEntryPosition AND diWrapperInAuto THEN
						TON_Wrapper(IN:=FALSE);
						stateAuto := stateAutoWait2;
					END_IF
						
				stateAutoWait2:
					
					TON_Wrapper(IN:=TRUE, PT:=T#2s);
					IF TON_Wrapper.Q THEN
						stateAuto := stateAutoRun;
					END_IF						
				
				stateAutoRun:
				
					doWrappingStart := TRUE;
				
					IF diWrappingFinished THEN
						stateAuto := stateAutoTurnToExitPosition;
					END_IF
				
				stateAutoTurnToExitPosition:
				
					doWrappingStart := FALSE;
					cmdTurnToExitPosition := TRUE;
					stateAuto := stateAutoWaitForExitPosition;
				
				stateAutoWaitForExitPosition:
				
					IF stateTurnTable = stateTurnTableExitPosition THEN
						stateAuto := stateAutoRemovePallet;
					END_IF
						
				stateAutoRemovePallet:
				
					IF statePalletP18 <> palletNotPresent AND statePalletP19 = palletNotPresent AND stateTurnTable = stateTurnTableExitPosition AND diWrapperExitFree THEN
						cmdMovePalletP18 := TRUE;
					END_IF	
				
					IF statePalletP18 = palletNotPresent THEN
						stateAuto := stateAutoTurnToEntryPosition;	
					END_IF
				
				stateAutoTurnToEntryPosition:
				
					cmdTurnToEntryPosition := TRUE;
					stateAuto := stateAutoWaitForEntryPosition;
				
				stateAutoWaitForEntryPosition:
				
					IF stateTurnTable = stateTurnTableEntryPosition THEN
						stateAuto := stateAutoWait;
					END_IF		
						
			END_CASE		

			//unexpected pallet
			IF TON_PalletStopP19.Q AND statePalletP19 = palletNotPresent AND NOT cmdMovePalletP18 THEN
				alarmImageOutfeed[5] := TRUE;
			END_IF			
	END_CASE

	
	//modules
	ConveyorP18; 
	TurnTable;

	//door logic
	DoorLogic_2();
	alarmImageOutfeed[15] := NOT DoorLogic_2.diDoorLocked;
	

	alarmImageOutfeed[16] := wrapperEdmError;
	alarmImageOutfeed[17] := NOT diWrapperNoError;
	alarmImageOutfeed[18] := diWrapperLowFoil;
	alarmImageOutfeed[19] := NOT diWrapperInAuto;
	
	//sensor not reached
	IF acknowledgeImageOutfeed[4] THEN
		alarmImageOutfeed[4] := FALSE;
	END_IF

	//unexpected pallet	
	IF acknowledgeImageOutfeed[5] THEN
		alarmImageOutfeed[5] := FALSE;
	END_IF	
	
	//problems with motors
	alarmImageOutfeed[6] := acpI_P18_1.error;
	acpI_P18_1.reset := EDGENEG(acknowledgeImageOutfeed[6]);

	alarmImageOutfeed[14] := acpI_P18_2.error;
	acpI_P18_2.reset := EDGENEG(acknowledgeImageOutfeed[14]);
	
END_PROGRAM
