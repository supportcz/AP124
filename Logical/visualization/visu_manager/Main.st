
PROGRAM _INIT
	
	gVisu.page_MpAlarmXList.SelectedIndex := 0; 
	gVisu.page_MpAlarmXList.PositionFilter_layer := 1;
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
		ButtonSettings:
			gVisu.ChangePage := 30;
			ButtonColor := 2;
			PageControl := Idle;
		ButtonAlarmPage:
			gVisu.ChangePage := 40;
			ButtonColor := 3;
			PageControl := Idle;
		ButtonSDM:
			gVisu.ChangePage := 50;
			ButtonColor := 4;
			PageControl := Idle;
		Idle:
	END_CASE;
	
	(***************************************************************************)		
	(* 								AlarmX listbox arrows				  	   *)	
	(***************************************************************************)
	CheckAlarmXListboxIndex;
	IF (EDGEPOS(gVisu.page_MpAlarmXList.ButtonDown)) AND (gVisu.page_MpAlarmXList.SelectedIndex < gVisu.page_MpAlarmXList.AlarmCount) THEN
		gVisu.page_MpAlarmXList.SelectedIndex := gVisu.page_MpAlarmXList.SelectedIndex +1;
	END_IF;
	
	IF (EDGEPOS(gVisu.page_MpAlarmXList.ButtonUp) AND (gVisu.page_MpAlarmXList.SelectedIndex > 1)) THEN
		gVisu.page_MpAlarmXList.SelectedIndex := gVisu.page_MpAlarmXList.SelectedIndex - 1;
	END_IF;
	
	IF (EDGEPOS(gVisu.page_MpAlarmXList.ButtonMultiDown) AND (gVisu.page_MpAlarmXList.SelectedIndex < gVisu.page_MpAlarmXList.AlarmCount)) THEN
		gVisu.page_MpAlarmXList.SelectedIndex := gVisu.page_MpAlarmXList.AlarmCount;
	END_IF;
		
	IF (EDGEPOS(gVisu.page_MpAlarmXList.ButtonMultiUp) AND gVisu.page_MpAlarmXList.SelectedIndex > 0) THEN
		gVisu.page_MpAlarmXList.SelectedIndex := 1;
	END_IF;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

