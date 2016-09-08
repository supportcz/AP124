ACTION CheckAlarmXListboxIndex:
	IF (strcmp(ADR(MpAlarmXListUIConnect.AlarmList.Timestamp[0]),ADR('')) = 0) THEN
		gVisu.page_MpAlarmXList.AlarmCount := 0;
		gVisu.page_MpAlarmXList.SelectedIndex := 0;
		gVisu.page_MpAlarmXList.ListboxLineDisable[1] := TRUE;
	ELSIF gVisu.page_MpAlarmXList.AlarmCount <> (MpAlarmXListUIConnect.AlarmList.MaxSelection+1) THEN
		gVisu.page_MpAlarmXList.AlarmCount := (MpAlarmXListUIConnect.AlarmList.MaxSelection+1);
		FOR i := 1 TO 6 DO
			IF i <= gVisu.page_MpAlarmXList.AlarmCount THEN
				gVisu.page_MpAlarmXList.ListboxLineDisable[i] := FALSE;
			ELSE 
				gVisu.page_MpAlarmXList.ListboxLineDisable[i] := TRUE;
			END_IF;
		END_FOR;
		RefreshListbox;
	END_IF;
	
	IF gVisu.page_MpAlarmXList.ListboxSelected <> gVisu.page_MpAlarmXList.ListboxSelected_old THEN
		IF gVisu.page_MpAlarmXList.ListboxSelected > gVisu.page_MpAlarmXList.ListboxSelected_old THEN
			gVisu.page_MpAlarmXList.SelectedIndex := gVisu.page_MpAlarmXList.SelectedIndex + (gVisu.page_MpAlarmXList.ListboxSelected-gVisu.page_MpAlarmXList.ListboxSelected_old);
		ELSIF (gVisu.page_MpAlarmXList.ListboxSelected < gVisu.page_MpAlarmXList.ListboxSelected_old) THEN
			gVisu.page_MpAlarmXList.SelectedIndex := gVisu.page_MpAlarmXList.SelectedIndex - (gVisu.page_MpAlarmXList.ListboxSelected_old-gVisu.page_MpAlarmXList.ListboxSelected);	
		END_IF;
		gVisu.page_MpAlarmXList.ListboxSelected_old := gVisu.page_MpAlarmXList.ListboxSelected;
		gVisu.page_MpAlarmXList.SelectedIndex_old := gVisu.page_MpAlarmXList.SelectedIndex;
	END_IF;
	
	IF gVisu.page_MpAlarmXList.SelectedIndex <> gVisu.page_MpAlarmXList.SelectedIndex_old THEN
		IF gVisu.page_MpAlarmXList.SelectedIndex > gVisu.page_MpAlarmXList.SelectedIndex_old THEN
			IF ((gVisu.page_MpAlarmXList.SelectedIndex - gVisu.page_MpAlarmXList.SelectedIndex_old) + (gVisu.page_MpAlarmXList.ListboxSelected)) <= 6 THEN
				gVisu.page_MpAlarmXList.ListboxSelected := gVisu.page_MpAlarmXList.SelectedIndex - gVisu.page_MpAlarmXList.SelectedIndex_old + gVisu.page_MpAlarmXList.ListboxSelected;
			ELSE
				RefreshListbox;
				gVisu.page_MpAlarmXList.ListboxSelected := 6;
			END_IF;
		ELSIF gVisu.page_MpAlarmXList.SelectedIndex < gVisu.page_MpAlarmXList.SelectedIndex_old THEN
			IF gVisu.page_MpAlarmXList.SelectedIndex = 1 THEN
				gVisu.page_MpAlarmXList.ListboxSelected := gVisu.page_MpAlarmXList.SelectedIndex;
				RefreshListbox;
			ELSIF ((gVisu.page_MpAlarmXList.ListboxSelected)) - (gVisu.page_MpAlarmXList.SelectedIndex_old - gVisu.page_MpAlarmXList.SelectedIndex) >= 1 THEN
				gVisu.page_MpAlarmXList.ListboxSelected := gVisu.page_MpAlarmXList.SelectedIndex - gVisu.page_MpAlarmXList.SelectedIndex_old + gVisu.page_MpAlarmXList.ListboxSelected;
			ELSIF gVisu.page_MpAlarmXList.AlarmCount = 0 OR gVisu.page_MpAlarmXList.SelectedIndex = 0 THEN
				gVisu.page_MpAlarmXList.ListboxSelected := 0;
				gVisu.page_MpAlarmXList.SelectedIndex := 0;
			ELSE
				RefreshListbox;
				gVisu.page_MpAlarmXList.ListboxSelected := 1;
			END_IF;
		END_IF;
		gVisu.page_MpAlarmXList.ListboxSelected_old := gVisu.page_MpAlarmXList.ListboxSelected;
		gVisu.page_MpAlarmXList.SelectedIndex_old := gVisu.page_MpAlarmXList.SelectedIndex;
	END_IF;
	memcpy(ADR(gVisu.page_MpAlarmXList.StateAcknowledged[1]),ADR(MpAlarmXListUIConnect.AlarmList.StateAcknowledged[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.StateAcknowledged[1])*6);
	memcpy(ADR(gVisu.page_MpAlarmXList.StateActive[1]),ADR(MpAlarmXListUIConnect.AlarmList.StateActive[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.StateActive[1])*6);
END_ACTION

ACTION RefreshListbox:
	
	memcpy(ADR(gVisu.page_MpAlarmXList.Timestamp[1]),ADR(MpAlarmXListUIConnect.AlarmList.Timestamp[(gVisu.page_MpAlarmXList.SelectedIndex - gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.Timestamp[1])*6);
	memcpy(ADR(gVisu.page_MpAlarmXList.Name[1]),ADR(MpAlarmXListUIConnect.AlarmList.Name[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.Name[1])*6);
	memcpy(ADR(gVisu.page_MpAlarmXList.Message[1]),ADR(MpAlarmXListUIConnect.AlarmList.Message[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.Message[1])*6);
	memcpy(ADR(gVisu.page_MpAlarmXList.Code[1]),ADR(MpAlarmXListUIConnect.AlarmList.Code[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.Code[1]));
	
	//	memcpy(ADR(gVisu.page_MpAlarmXList.StateAcknowledged[1]),ADR(MpAlarmXListUIConnect.AlarmList.StateAcknowledged[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.StateAcknowledged[1])*6);
	//	memcpy(ADR(gVisu.page_MpAlarmXList.StateActive[1]),ADR(MpAlarmXListUIConnect.AlarmList.StateActive[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.StateActive[1])*6);
END_ACTION