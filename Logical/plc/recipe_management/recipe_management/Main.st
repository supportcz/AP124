
PROGRAM _INIT
	
//	actualRecipeIndex := 255;
//	actualLayoutIndex := 255;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	readyToStart :=  NOT MpRecipeRegPar_0.Error AND NOT MpRecipeCsv_0.Error;
	
	IF NOT readyToStart THEN
		stateRecipe := stateRecipeError;
	END_IF
	
	CASE stateRecipe OF
		
		stateRecipeError:
			
			//MpRecipeRegPar_0.Enable := FALSE;
			//MpRecipeCsv_0.Enable := FALSE;
			cmdLoad := FALSE;
			cmdSave := FALSE;
			
			IF readyToStart THEN
				stateRecipe := stateRecipeInit;
			END_IF
		
		stateRecipeInit:
			
			MpRecipeRegPar_0.MpLink := ADR(gRecipeCsv);
			MpRecipeRegPar_0.Enable := TRUE;
//			MpRecipeRegPar_0.PVName := ADR('recipes');
			MpRecipeRegPar_0.PVName := ADR('recipe_man:recipes');
			
			MpRecipeCsv_0.MpLink := ADR(gRecipeCsv);
			MpRecipeCsv_0.Enable := TRUE;
			MpRecipeCsv_0.DeviceName := ADR('USER');
			MpRecipeCsv_0.FileName := ADR('recipe.csv');
			
			IF MpRecipeRegPar_0.Active AND MpRecipeCsv_0.Active THEN
				stateRecipe := stateRecipeLoad;
			END_IF
		
		stateRecipeWait:
			
			IF requestedRecipeIndex <> actualRecipeIndex THEN
				memcpy (ADR(recipes.recipe[actualRecipeIndex]), ADR(actualRecipe),SIZEOF(actualRecipe));
				memcpy (ADR(actualRecipe), ADR(recipes.recipe[requestedRecipeIndex]), SIZEOF(actualRecipe));
				actualRecipeIndex := requestedRecipeIndex;
			END_IF
			
			IF requestedLayoutIndex <> actualLayoutIndex THEN
				memcpy (ADR(recipes.layout[actualLayoutIndex]), ADR(actualLayout), SIZEOF(actualLayout));
				memcpy (ADR(actualLayout), ADR(recipes.layout[requestedLayoutIndex]), SIZEOF(actualLayout));
				actualLayoutIndex := requestedLayoutIndex;
			END_IF
			
			IF cmdLoad THEN
				stateRecipe := stateRecipeLoad;
			END_IF
			
			IF cmdSave THEN
				stateRecipe := stateRecipeSave;
			END_IF
		
		stateRecipeLoad:
			
			MpRecipeCsv_0.Load := TRUE;
			stateRecipe := stateRecipeLoad2;
	
		stateRecipeLoad2:
			
			IF MpRecipeCsv_0.CommandDone THEN
				cmdLoad := FALSE;
				MpRecipeCsv_0.Load := FALSE;
				stateRecipe := stateRecipeLoad3;
			END_IF
		
		stateRecipeLoad3:
			
			//refresh actual recipe and layout
			memcpy (ADR(actualRecipe), ADR(recipes.recipe[actualRecipeIndex]), SIZEOF(actualRecipe));
			memcpy (ADR(actualLayout), ADR(recipes.layout[actualLayoutIndex]), SIZEOF(actualLayout));
			stateRecipe := stateRecipeWait;

		stateRecipeSave:
			
			//refresh actual recipe and layout
			memcpy (ADR(recipes.recipe[actualRecipeIndex]), ADR(actualRecipe),SIZEOF(actualRecipe));
			memcpy (ADR(recipes.layout[actualLayoutIndex]), ADR(actualLayout), SIZEOF(actualLayout));
			stateRecipe := stateRecipeSave2;
		
		stateRecipeSave2:
			
			MpRecipeCsv_0.Save := TRUE;
			stateRecipe := stateRecipeSave3;
			
		stateRecipeSave3:
		
			IF MpRecipeCsv_0.CommandDone THEN
				cmdSave := FALSE;
				MpRecipeCsv_0.Save := FALSE;
				stateRecipe := stateRecipeWait;
			END_IF
		
	END_CASE
	

	MpRecipeRegPar_0();
	MpRecipeCsv_0();
	 
END_PROGRAM

PROGRAM _EXIT
	MpRecipeRegPar_0(Enable := FALSE);
	MpRecipeCsv_0(Enable := FALSE);
END_PROGRAM


