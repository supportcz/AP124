
TYPE
	Layout : 	STRUCT 
		nbOfTrays : INT;
		tray : ARRAY[0..39]OF Tray;
	END_STRUCT;
	Recipe : 	STRUCT 
		name : STRING[80];
		interlayerSheetBottom : BOOL;
		interlayerSheetTop : BOOL;
		conveyorP1speed : INT;
		conveyorP2speed : INT;
		nbOfLayers : INT;
		layer : ARRAY[0..9]OF INT;
	END_STRUCT;
	Recipes : 	STRUCT 
		actualRecipeIndex : INT;
		recipe : ARRAY[0..9]OF Recipe;
		layout : ARRAY[0..9]OF Layout;
	END_STRUCT;
	Tray : 	STRUCT 
		gapBetweenTrays : TIME;
		makeGap : BOOL;
		turnTray : BOOL;
		lastTrayInLayer : BOOL;
		lastTrayHalfLayer : BOOL;
		lastTrayInRow : BOOL;
		timeAfterLastTray : TIME;
	END_STRUCT;
END_TYPE
