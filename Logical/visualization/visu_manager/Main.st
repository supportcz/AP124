
PROGRAM _INIT
	PageControl := ButtonAutomaticMode;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	(***************************************************************************)		
	(* 								Page Control						  	   *)	
	(***************************************************************************)
	CASE PageControl OF
		ButtonAutomaticMode:
			gVisu.ChangePage := 10;
			ButtonColor := 0;
			PageControl := Idle;
		ButtonManualMode:
			gVisu.ChangePage := 20;
			ButtonColor := 1;
			PageControl := Idle;
		ButtonInfo:
			gVisu.ChangePage := 30;
			ButtonColor := 2;
			PageControl := Idle;
		ButtonAlarmPage:
			gVisu.ChangePage := 40;
			ButtonColor := 3;
			ButtonAlarmColor := 1;
			PageControl := Idle;
		ButtonSDM:
			gVisu.ChangePage := 50;
			ButtonColor := 4;
			PageControl := Idle;
		ButtonSettings:
			gVisu.ChangePage := 60;
			ButtonColor := 5;
			PageControl := Idle;
		Idle:
	END_CASE;
	
//	IF (ButtonColor = 3) AND (gVisu.page_MpAlarmXList.AlarmCount > 0) THEN
//		gVisu.TON_0.IN := TRUE;
//		gVisu.TON_0.PT := 200;
//		IF gVisu.TON_0.Q THEN
//			ButtonAlarmColor := NOT(ButtonAlarmColor);
//			gVisu.TON_0.IN := FALSE;
//		END_IF;
	(*ELS*)//IF (gVisu.CurrentPage <> 40) THEN
	//	ButtonAlarmColor := 0;
//	//	gVisu.TON_0.IN := FALSE;
//	ELSE 
//		ButtonAlarmColor := 1;
//		gVisu.TON_0.IN := FALSE;
//	END_IF;
 	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

