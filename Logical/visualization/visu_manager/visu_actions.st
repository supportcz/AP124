ACTION CheckAlarmXListboxIndex:
	
	IF gVisu.page_MpAlarmXList.AlarmCount <> (MpAlarmXListUIConnect.AlarmList.MaxSelection+1) THEN
		gVisu.page_MpAlarmXList.AlarmCount := (MpAlarmXListUIConnect.AlarmList.MaxSelection+1);
		memcpy(ADR(gVisu.page_MpAlarmXList.Timestamp[1]),ADR(MpAlarmXListUIConnect.AlarmList.Timestamp[(gVisu.page_MpAlarmXList.SelectedIndex - gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.Timestamp[1])*6);
		memcpy(ADR(gVisu.page_MpAlarmXList.Name[1]),ADR(MpAlarmXListUIConnect.AlarmList.Name[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.Name[1])*6);
		memcpy(ADR(gVisu.page_MpAlarmXList.Message[1]),ADR(MpAlarmXListUIConnect.AlarmList.Message[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.Message[1])*6);
		memcpy(ADR(gVisu.page_MpAlarmXList.Code[1]),ADR(MpAlarmXListUIConnect.AlarmList.Code[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.Code[1]));
		memcpy(ADR(gVisu.page_MpAlarmXList.StateAcknowledged[1]),ADR(MpAlarmXListUIConnect.AlarmList.StateAcknowledged[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.StateAcknowledged[1])*6);
		memcpy(ADR(gVisu.page_MpAlarmXList.StateActive[1]),ADR(MpAlarmXListUIConnect.AlarmList.StateActive[(gVisu.page_MpAlarmXList.SelectedIndex-gVisu.page_MpAlarmXList.ListboxSelected)]),SIZEOF(gVisu.page_MpAlarmXList.StateActive[1])*6);
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
			//	memcpy(ADR(gContainerContent_tmp.container),ADR(gContainerContent[gVisu.sideDtpnts.pageAuto.trayIndexNew_tmp].container[(gVisu.page_MpAlarmXList.SelectedIndex)-9]),SIZEOF(gContainerContent_tmp.container));
			//	gContainerContent_tmp.pocet_polozek := gContainerContent[gVisu.sideDtpnts.pageAuto.trayIndexNew_tmp].pocet_polozek;
				gVisu.page_MpAlarmXList.ListboxSelected := 6;
			END_IF;
		ELSIF gVisu.page_MpAlarmXList.SelectedIndex < gVisu.page_MpAlarmXList.SelectedIndex_old THEN
			IF gVisu.page_MpAlarmXList.SelectedIndex = 1 THEN
				gVisu.page_MpAlarmXList.ListboxSelected := gVisu.page_MpAlarmXList.SelectedIndex;
			//	memcpy(ADR(gContainerContent_tmp.container),ADR(gContainerContent[gVisu.sideDtpnts.pageAuto.trayIndexNew_tmp].container[gVisu.page_MpAlarmXList.SelectedIndex-1]),SIZEOF(gContainerContent_tmp.container));
			//	gContainerContent_tmp.pocet_polozek := gContainerContent[gVisu.sideDtpnts.pageAuto.trayIndexNew_tmp].pocet_polozek;
			ELSIF ((gVisu.page_MpAlarmXList.ListboxSelected)) - (gVisu.page_MpAlarmXList.SelectedIndex_old - gVisu.page_MpAlarmXList.SelectedIndex) >= 1 THEN
				gVisu.page_MpAlarmXList.ListboxSelected := gVisu.page_MpAlarmXList.SelectedIndex - gVisu.page_MpAlarmXList.SelectedIndex_old + gVisu.page_MpAlarmXList.ListboxSelected;
			ELSIF gVisu.page_MpAlarmXList.AlarmCount = 0 OR gVisu.page_MpAlarmXList.SelectedIndex = 0 THEN
				gVisu.page_MpAlarmXList.ListboxSelected := 0;
				gVisu.page_MpAlarmXList.SelectedIndex := 0;
			ELSE
			//	memcpy(ADR(gContainerContent_tmp.container),ADR(gContainerContent[gVisu.sideDtpnts.pageAuto.trayIndexNew_tmp].container[gVisu.page_MpAlarmXList.SelectedIndex-1]),SIZEOF(gContainerContent_tmp));
			//	gContainerContent_tmp.pocet_polozek := gContainerContent[gVisu.sideDtpnts.pageAuto.trayIndexNew_tmp].pocet_polozek;
				gVisu.page_MpAlarmXList.ListboxSelected := 1;
			END_IF;
		END_IF;
		gVisu.page_MpAlarmXList.ListboxSelected_old := gVisu.page_MpAlarmXList.ListboxSelected;
		gVisu.page_MpAlarmXList.SelectedIndex_old := gVisu.page_MpAlarmXList.SelectedIndex;
	END_IF;
	

	
END_ACTION