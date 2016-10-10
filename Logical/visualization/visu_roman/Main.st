
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	IF modeMagazine = modeMagazineManual THEN
		magazineStatusDatapointManual := 0;
	ELSE
		magazineStatusDatapointManual := 1;
	END_IF

	IF modeMagazine = modeMagazineAuto THEN
		magazineStatusDatapointAuto := 0;
	ELSE
		magazineStatusDatapointAuto := 1;
	END_IF

	IF modePalletization = modePalletizationManual THEN
		conveyorsStatusDatapointManual := 0;
	ELSE
		conveyorsStatusDatapointManual := 1;
	END_IF

	IF modePalletization = modePalletizationAuto THEN
		conveyorsStatusDatapointAuto := 0;
	ELSE
		conveyorsStatusDatapointAuto := 1;
	END_IF

	IF palletOnConveyorP12 THEN
		hideP12 := 0;
	ELSE
		hideP12 := 1;
	END_IF	

	IF palletOnConveyorP13 THEN
		hideP13 := 0;
	ELSE
		hideP13 := 1;
	END_IF	

	IF palletOnConveyorP14 THEN
		hideP14 := 0;
	ELSE
		hideP14 := 1;
	END_IF	

	IF palletOnConveyorP15 THEN
		hideP15 := 0;
	ELSE
		hideP15 := 1;
	END_IF	
	
		
	StatusMessageMagazine;
	StatusMessagePalletization;
	
	
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
					END_IF
				END_IF
			END_IF
		END_IF
	END_IF
	
END_PROGRAM


