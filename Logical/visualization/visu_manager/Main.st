
PROGRAM _INIT
	PageControl := ButtonAutomaticMode;
	uiHandle := 0;
	gVisu.LanguageLayer := 1;
END_PROGRAM

PROGRAM _CYCLIC
	
	(***************************************************************************)
	(* 							Active Alarm Count Check				 	   *)
	(***************************************************************************)
	IF uiHandle = 0 THEN
		uiHandle := VA_Setup(1,'Visu');
	END_IF	
	uiStatus := VA_Saccess(1,uiHandle);
	IF uiStatus = 0 THEN
		uiStatus := VA_GetAlarmCount(1,uiHandle,vaALS_CURRENT,ADR(uiAlarmCount));
		IF diReset THEN
			uiStatus := VA_QuitAlarms(1,uiHandle, 65535);
		END_IF
		VA_Srelease(1,uiHandle);
	END_IF;
	
	IF alarmCommon OR alarmInZoneMagazine OR alarmInZonePalletization THEN
		alarmPresent := TRUE;
	ELSE
		alarmPresent := FALSE;
	END_IF
	
	(***************************************************************************)
	(* 								Page Control						  	   *)
	(***************************************************************************)
	CASE PageControl OF
		ButtonAutomaticMode:
			gVisu.ChangePage := 10;
			ButtonColor := 0;
			ButtonColor_tmp := ButtonColor;
			PageControl := Idle;
		ButtonManualMode:
			gVisu.ChangePage := 20;
			ButtonColor := 1;
			ButtonColor_tmp := ButtonColor;
			PageControl := Idle;
		ButtonInfo:
			gVisu.ChangePage := 30;
			ButtonColor := 2;
			ButtonColor_tmp := ButtonColor;
			PageControl := Idle;
		ButtonAlarmPage:
			gVisu.ChangePage := 40;
			ButtonColor := 3;
			ButtonColor_tmp := ButtonColor;
			ButtonAlarmColor := 1;
			PageControl := Idle;
		ButtonSDM:
			gVisu.ChangePage := 50;
			ButtonColor := 4;
			ButtonColor_tmp := ButtonColor;
			PageControl := Idle;
		ButtonSettings:
			gVisu.ChangePage := 60;
			ButtonColor := 5;
			ButtonColor_tmp := ButtonColor;
			PageControl := Idle;
		Idle:
	END_CASE;
	
	IF (ButtonColor <> 3) AND alarmPresent THEN
		gVisu.TON_0(IN := TRUE, PT := ALARM_BLINK);
		IF gVisu.TON_0.Q THEN
			ButtonAlarmColor := NOT(ButtonAlarmColor);
			gVisu.TON_0(IN := FALSE, PT := ALARM_BLINK);
		END_IF;
	ELSIF (ButtonColor <> 3) AND NOT alarmPresent THEN
		ButtonAlarmColor := 0;
		gVisu.TON_0(IN := FALSE, PT := ALARM_BLINK);
	ELSE
		ButtonAlarmColor := 1;
		gVisu.TON_0(IN := FALSE, PT := ALARM_BLINK);
	END_IF;
 	
	(***************************************************************************)
	(* 							Robot Layout DropDown					  	   *)
	(***************************************************************************)
	IF adrRecipes <> 0 THEN 
		dRecipes ACCESS adrRecipes;
		IF EDGEPOS(RecipeChanged) THEN
			FOR i:= 0 TO 9 DO
				RecipeNames[i] := dRecipes.recipe[i].name;
			END_FOR;
			RecipeChanged := FALSE;
		END_IF;
	END_IF;		
	
	IF (EDGEPOS(PalletStatus[12])) THEN
		IF (statePalletP12 = palletMoving) THEN
			statePalletP12 := 0;
		ELSE statePalletP12 := statePalletP12 + 1;
		END_IF;
		PalletStatus[12] := 0;
	END_IF;
	
	IF (EDGEPOS(PalletStatus[13])) THEN
		IF (statePalletP13 = palletMoving) THEN
			statePalletP13 := 0;
		ELSE statePalletP13 := statePalletP13 + 1;
		END_IF; 
		PalletStatus[13] := 0;
	END_IF;
	
	IF (EDGEPOS(PalletStatus[14])) THEN
		IF (statePalletP14 = palletMoving) THEN
			statePalletP14 := 0;
		ELSE statePalletP14 := statePalletP14 + 1;
		END_IF;
		PalletStatus[14]:= 0;
	END_IF;
	
	IF (EDGEPOS(PalletStatus[15])) THEN
		IF (statePalletP15 = palletMoving) THEN
			statePalletP15 := 0;
		ELSE statePalletP15 := statePalletP15 + 1;
		END_IF;
		PalletStatus[15] := 0;
	END_IF;
	
	IF (EDGEPOS(PalletStatus[16])) THEN
		IF (statePalletP16 = palletMoving) THEN
			statePalletP16 := 0;
		ELSE statePalletP16 := statePalletP16 + 1;
		END_IF;
		PalletStatus[16] := 0;
	END_IF;
	
	IF (EDGEPOS(PalletStatus[17])) THEN
		IF (statePalletP17 = palletMoving) THEN
			statePalletP17 := 0;
		ELSE statePalletP17 := statePalletP17 + 1;
		END_IF;
		PalletStatus[17] := 0;
	END_IF;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

