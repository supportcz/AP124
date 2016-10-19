
PROGRAM _INIT

	
END_PROGRAM

PROGRAM _CYCLIC
	
	adrRecipes := ADR(recipes);
	
	readyToStart :=  NOT MpRecipeRegPar_0.Error AND NOT MpRecipeCsv_0.Error;
	
	IF NOT readyToStart THEN
		stateRecipe := stateRecipeError;
	END_IF
	
	CASE stateRecipe OF
		
		stateRecipeError:
			
			cmdLoad := FALSE;
			cmdSave := FALSE;
			VisuRecipeState := 4;							//Visu Error Text
			IF readyToStart THEN
				stateRecipe := stateRecipeInit;
			END_IF
		
		stateRecipeInit:
			
			MpRecipeRegPar_0.MpLink := ADR(gRecipeCsv);
			MpRecipeRegPar_0.Enable := TRUE;
			MpRecipeRegPar_0.PVName := ADR('recipe_man:recipes');
			
			MpRecipeCsv_0.MpLink := ADR(gRecipeCsv);
			MpRecipeCsv_0.Enable := TRUE;
			MpRecipeCsv_0.DeviceName := ADR('USER');
			MpRecipeCsv_0.FileName := ADR('recipe.csv');
			
			VisuRecipeState := 0;						//Visu Empty Text
			
			IF MpRecipeRegPar_0.Active AND MpRecipeCsv_0.Active THEN
				stateRecipe := stateRecipeLoad;
			END_IF
		
		stateRecipeWait:
			
			IF cmdLoad THEN
				stateRecipe := stateRecipeLoad;
			END_IF
			
			IF cmdSave THEN
				stateRecipe := stateRecipeSave;
			END_IF
		
		stateRecipeLoad:
			
			MpRecipeCsv_0.Load := TRUE;
			stateRecipe := stateRecipeLoad2;
			VisuRecipeState := 3;						//Visu Discart changes Text
		
		stateRecipeLoad2:
			
			IF MpRecipeCsv_0.CommandDone THEN
				cmdLoad := FALSE;
				MpRecipeCsv_0.Load := FALSE;
				stateRecipe := stateRecipeWait;
				VisuRecipeState := 0;					//Visu Empty Text
				RecipeChanged := TRUE;
			END_IF

		stateRecipeSave:
			
			MpRecipeCsv_0.Save := TRUE;
			stateRecipe := stateRecipeSave2;
			VisuRecipeState := 1;						//Visu Saving Text
			
		stateRecipeSave2:
		
			IF MpRecipeCsv_0.CommandDone THEN
				cmdSave := FALSE;
				MpRecipeCsv_0.Save := FALSE;
				stateRecipe := stateRecipeWait;
				VisuRecipeState := 2;					//Visu Saved Text
				RecipeChanged := TRUE;
			END_IF
		
	END_CASE
	

	MpRecipeRegPar_0();
	MpRecipeCsv_0();
	 
END_PROGRAM

PROGRAM _EXIT
	MpRecipeRegPar_0(Enable := FALSE);
	MpRecipeCsv_0(Enable := FALSE);
END_PROGRAM


