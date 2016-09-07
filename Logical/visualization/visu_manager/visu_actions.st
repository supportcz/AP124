ACTION CheckAlarmXListboxIndex:
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