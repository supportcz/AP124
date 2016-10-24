
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
			
	StatusMessageMagazine;
	StatusMessagePalletization;
	StatusMessageOutfeed;
	
	(* recipe edit *)
	IF adrRecipes <> 0 THEN 
		dRecipes ACCESS adrRecipes;
		IF dRecipes.actualRecipeIndex >= 0 AND dRecipes.actualRecipeIndex <= 9 THEN
			dActualRecipe ACCESS ADR(dRecipes.recipe[dRecipes.actualRecipeIndex]);
		
			//select actual layout
			IF actualLayerIndex >= 0 AND actualLayerIndex <= 9 THEN
				dActualLayoutIndex ACCESS ADR(dActualRecipe.layer[actualLayerIndex]);
			
				IF dActualLayoutIndex >= 0 AND dActualLayoutIndex <= 9 THEN 
					dActualLayout ACCESS ADR(dRecipes.layout[dActualLayoutIndex]);
					//select actual tray
					IF actualTrayIndex >= 0 AND actualTrayIndex <= 39 THEN
						dActualTray ACCESS ADR(dActualLayout.tray[actualTrayIndex]);
					ELSE
						dActualTray ACCESS ADR (nullTray);
					END_IF
				ELSE
					dActualLayout ACCESS ADR(nullLayout);
				END_IF
			END_IF
		ELSE
			dActualRecipe ACCESS ADR(nullRecipe);
		END_IF
	END_IF
	
	//all to auto or manual
	IF EDGEPOS(cmdAuto) THEN
		cmdMagazineAuto := TRUE;
		cmdPalletizationAuto := TRUE;
		cmdOutfeedAuto := TRUE;
	END_IF

	IF EDGENEG(cmdAuto) THEN
		cmdMagazineAuto := FALSE;
		cmdPalletizationAuto := FALSE;
		cmdOutfeedAuto := FALSE;
	END_IF

	IF EDGEPOS(cmdManual) THEN
		cmdMagazineManual := TRUE;
		cmdPalletizationManual := TRUE;
		cmdOutfeedManual := TRUE;
	END_IF

	IF EDGENEG(cmdManual) THEN
		cmdMagazineManual := FALSE;
		cmdPalletizationManual := FALSE;
		cmdOutfeedManual := FALSE;
	END_IF

	//palletization t auto or manual
	IF EDGEPOS(cmdAutoPM) THEN
		cmdMagazineAuto := TRUE;
		cmdPalletizationAuto := TRUE;
	END_IF

	IF EDGENEG(cmdAutoPM) THEN
		cmdMagazineAuto := FALSE;
		cmdPalletizationAuto := FALSE;
	END_IF

	IF EDGEPOS(cmdManualPM) THEN
		cmdMagazineManual := TRUE;
		cmdPalletizationManual := TRUE;
	END_IF

	IF EDGENEG(cmdManualPM) THEN
		cmdMagazineManual := FALSE;
		cmdPalletizationManual := FALSE;
	END_IF
	
END_PROGRAM


