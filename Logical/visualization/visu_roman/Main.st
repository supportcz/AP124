
PROGRAM _INIT

	 
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
	

	
END_PROGRAM


