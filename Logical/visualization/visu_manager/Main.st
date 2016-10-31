
PROGRAM _INIT
	PageControl := ButtonAutomaticMode;
	uiHandle := 0;
	gVisu.LanguageLayer := 1;
	StatusDatapointCmdAuto := 0;
	StatusDatapointCmdManual := 1;
	StatusDatapointCmdAutoPM := 0;
	StatusDatapointCmdManualPM := 1;
	StatusDatapointCmdAutoOF := 0;
	StatusDatapointCmdManualOF := 1;
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
	
	IF alarmCommon OR alarmInZoneMagazine OR alarmInZonePalletization OR alarmInZoneOutfeed THEN
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
	(* 					Locking Infos/Automatic Mode - START			  	   *)
	(***************************************************************************)
	
	IF (gVisu.CurrentPage = 11) AND (StatusDatapointCmdAutoPM = 0) THEN
		gVisu.InfoLock := 24576;
	ELSE
		gVisu.InfoLock := 8194;
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
	
	IF PalletStatus[12] THEN
		IF (statePalletP12 = palletMoving) THEN
			statePalletP12 := 0;
		ELSE statePalletP12 := statePalletP12 + 1;
		END_IF;
		PalletStatus[12] := 0;
	END_IF;
	
	IF PalletStatus[13] THEN
		IF (statePalletP13 = palletMoving) THEN
			statePalletP13 := 0;
		ELSE statePalletP13 := statePalletP13 + 1;
		END_IF; 
		PalletStatus[13] := 0;
	END_IF;
	
	IF PalletStatus[14] THEN
		IF (statePalletP14 = palletMoving) THEN
			statePalletP14 := 0;
		ELSE statePalletP14 := statePalletP14 + 1;
		END_IF;
		PalletStatus[14]:= 0;
	END_IF;
	
	IF PalletStatus[15] THEN
		IF (statePalletP15 = palletMoving) THEN
			statePalletP15 := 0;
		ELSE statePalletP15 := statePalletP15 + 1;
		END_IF;
		PalletStatus[15] := 0;
	END_IF;
	
	IF PalletStatus[16] THEN
		IF (statePalletP16 = palletMoving) THEN
			statePalletP16 := 0;
		ELSE statePalletP16 := statePalletP16 + 1;
		END_IF;
		PalletStatus[16] := 0;
	END_IF;
	
	IF PalletStatus[17] THEN
		IF (statePalletP17 = palletMoving) THEN
			statePalletP17 := 0;
		ELSE statePalletP17 := statePalletP17 + 1;
		END_IF;
		PalletStatus[17] := 0;
	END_IF;
	
	IF PalletStatus[18] THEN
		IF (statePalletP18 = palletMoving) THEN
			statePalletP18 := 0;
		ELSE statePalletP18 := statePalletP18 + 1;
		END_IF;
		PalletStatus[18] := 0;
	END_IF;

	IF PalletStatus[19] THEN
		IF (statePalletP19 = palletMoving) THEN
			statePalletP19 := 0;
		ELSE statePalletP19 := statePalletP19 + 1;
		END_IF;
		PalletStatus[19] := 0;
	END_IF;

	IF PalletStatus[20] THEN
		IF (statePalletP20 = palletMoving) THEN
			statePalletP20 := 0;
		ELSE statePalletP20 := statePalletP20 + 1;
		END_IF;
		PalletStatus[20] := 0;
	END_IF;

	IF PalletStatus[21] THEN
		IF (statePalletP21 = palletMoving) THEN
			statePalletP21 := 0;
		ELSE statePalletP21 := statePalletP21 + 1;
		END_IF;
		PalletStatus[21] := 0;
	END_IF;
	
	IF PalletStatus[22] THEN
		IF (statePalletP22 = palletMoving) THEN
			statePalletP22 := 0;
		ELSE statePalletP22 := statePalletP22 + 1;
		END_IF;
		PalletStatus[22] := 0;
	END_IF;

	(***************************************************************************)
	(* 							Password Managment						  	   *)
	(***************************************************************************)
	gVisu.TON_PW();
	CASE PasswordManagment OF
		LOGIN: 
			gVisu.PasswordStatusDatapoint := 8;
			PasswordManagment := AUTHORIZE;
		
		AUTHORIZE:
			gVisu.TON_PW(IN := TRUE, PT := 6000);
			IF gVisu.TON_PW.Q OR gVisu.PasswordStatusDatapoint = 16384 THEN
				gVisu.PasswordStatusDatapoint := 1;
				gVisu.TON_PW(IN := FALSE, PT := 6000);
				PasswordManagment := LOGOUT;
			END_IF;
			
			IF (gVisu.PasswordStatusDatapoint = 0)  THEN
				IF ((strcmp(ADR(gVisu.Password),ADR('357'))) = 0) THEN
					gVisu.ChangePage := gVisu.DesiredPage;
					PasswordManagment := LOGEDIN;
				END_IF;
				gVisu.Password := '';
			END_IF;

		LOGEDIN:
			gVisu.TON_PW(IN := FALSE, PT := 6000);
			IF ( gVisu.CurrentPage <> gVisu.DesiredPage) THEN
				PasswordManagment := LOGOUT;
			END_IF;
		LOGOUT:
			gVisu.Password := '';
	END_CASE;
	
	(***************************************************************************)
	(* 							Auto/Manual StatusDatapoint					   *)
	(***************************************************************************)
	
	IF modeZoneMagazine = modeZoneManual THEN
		magazineStatusDatapointManual := 0;
	ELSE
		magazineStatusDatapointManual := 1;
	END_IF

	IF modeZoneMagazine = modeZoneAuto THEN
		magazineStatusDatapointAuto := 0;
	ELSE
		magazineStatusDatapointAuto := 1;
	END_IF

	IF modeZonePalletization = modeZoneManual THEN
		palletizationStatusDatapointManu := 0;
	ELSE
		palletizationStatusDatapointManu := 1;
	END_IF

	IF modeZonePalletization = modeZoneAuto THEN
		palletizationStatusDatapointAuto := 0;
	ELSE
		palletizationStatusDatapointAuto := 1;
	END_IF
	
	IF modeZoneOutfeed = modeZoneManual THEN
		outfeedStatusDatapointManual := 0;
	ELSE
		outfeedStatusDatapointManual := 1;
	END_IF

	IF modeZoneOutfeed = modeZoneAuto THEN
		outfeedStatusDatapointAuto := 0;
	ELSE
		outfeedStatusDatapointAuto := 1;
	END_IF
	
	(***************************************************************************)
	(* 			Info - Actual Date and Time after reset pallet Count		   *)
	(***************************************************************************)
	DTStructureGetTime_0.enable := 1;
	IF ButtonResetTime > 0 THEN
		DTStructureGetTime_0(enable := 1,pDTStructure := ADR(ResetTime));
		IF DTStructureGetTime_0.status = 0 THEN
			ButtonResetTime := 0;
		ELSIF(DTStructureGetTime_0.status = 65535) THEN 
			ButtonResetTime := 1;
		ELSE ButtonResetTime := 0;
		END_IF;
	END_IF;
	
	(***************************************************************************)
	(* 						Automatic Mode - START button Logic		  		   *)
	(***************************************************************************)
		
	//all to auto or manual
	IF EDGEPOS(cmdAuto) THEN
		cmdMagazineAuto := TRUE;
		cmdPalletizationAuto := TRUE;
		cmdOutfeedAuto := TRUE;
		StatusDatapointCmdManual := 0;
		StatusDatapointCmdAuto := 1;
		StatusDatapointCmdAutoOF := 1;
		StatusDatapointCmdManualOF := 0;
		StatusDatapointCmdAutoPM := 1;
		StatusDatapointCmdManualPM := 0;
		gVisu.ChangePage := 10;
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
		StatusDatapointCmdManual := 1;
		StatusDatapointCmdAuto := 0;
		StatusDatapointCmdAutoOF := 0;
		StatusDatapointCmdManualOF := 1;
		StatusDatapointCmdAutoPM := 0;
		StatusDatapointCmdManualPM := 1;
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
		StatusDatapointCmdAutoPM := 1;
		StatusDatapointCmdManualPM := 0;
	END_IF

	IF EDGENEG(cmdAutoPM) THEN
		cmdMagazineAuto := FALSE;
		cmdPalletizationAuto := FALSE;
	END_IF

	IF EDGEPOS(cmdManualPM) THEN
		cmdMagazineManual := TRUE;
		cmdPalletizationManual := TRUE;
		StatusDatapointCmdAutoPM := 0;
		StatusDatapointCmdManualPM := 1;
	END_IF

	IF EDGENEG(cmdManualPM) THEN
		cmdMagazineManual := FALSE;
		cmdPalletizationManual := FALSE;
	END_IF
	
	IF EDGEPOS(cmdOutfeedAuto) THEN
		StatusDatapointCmdAutoOF := 1;
		StatusDatapointCmdManualOF := 0;
	END_IF
	
	IF EDGEPOS(cmdOutfeedManual) THEN
		StatusDatapointCmdAutoOF := 0;
		StatusDatapointCmdManualOF := 1;
	END_IF
	
	IF StatusDatapointCmdAutoOF = 1 AND StatusDatapointCmdAutoPM = 1 THEN
		StatusDatapointCmdManual := 0;
		StatusDatapointCmdAuto := 1;
	END_IF;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

