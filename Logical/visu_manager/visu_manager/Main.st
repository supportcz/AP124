
PROGRAM _INIT
	
	gVisu.page_MpAlarmXList.SelectedIndex := 0; 
	gVisu.page_MpAlarmXList.PositionFilter_layer := 1;
	
END_PROGRAM

PROGRAM _CYCLIC
	(***************************************************************************)		
	(* 								Container listbox arrows				   *)	
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

