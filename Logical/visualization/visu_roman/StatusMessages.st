
ACTION StatusMessageMagazine: 

	IF modeZoneMagazine = modeZoneAuto THEN
		statusMessageMagazine := 27;
	END_IF
	IF magazineEmpty THEN
		statusMessageMagazine := 32;
	END_IF
	IF alarmInZoneMagazine THEN
		statusMessageMagazine := 24;
	END_IF
	IF modeZoneMagazine = modeZoneManual THEN
		statusMessageMagazine := 21;
	END_IF
	IF alarmImageMagazine[1] THEN
		statusMessageMagazine := 11;
	END_IF
	IF diMagazineEDM THEN
		statusMessageMagazine := 15;
	END_IF
	IF alarmImageCommon[6] THEN
		statusMessageMagazine := 7;
	END_IF
	IF alarmImageCommon[5] THEN
		statusMessageMagazine := 6;
	END_IF
	IF alarmImageCommon[4] THEN
		statusMessageMagazine := 4;
	END_IF
	IF alarmImageCommon[3] THEN
		statusMessageMagazine := 3;
	END_IF
	IF alarmImageCommon[2] THEN
		statusMessageMagazine := 2;
	END_IF
	IF alarmImageCommon[1] THEN
		statusMessageMagazine := 1;
	END_IF
	
END_ACTION

ACTION StatusMessagePalletization: 

	IF modeZonePalletization = modeZoneAuto THEN
		statusMessagePalletization := 26;
	END_IF
	IF interlayerSheetMagazineEmpty THEN
		statusMessagePalletization := 31;
	END_IF	
	IF alarmInZonePalletization THEN
		statusMessagePalletization := 23;
	END_IF
	IF modeZonePalletization = modeZoneManual THEN
		statusMessagePalletization := 20;
	END_IF
	IF alarmImagePalletization[8] THEN
		statusMessagePalletization := 13;
	END_IF
	IF alarmImagePalletization[5] THEN
		statusMessagePalletization := 12;
	END_IF
	IF alarmImageOutfeed[0] THEN
		statusMessagePalletization := 13;
	END_IF
	IF diPalletizationEDM THEN
		statusMessagePalletization := 14;
	END_IF
	IF alarmImagePalletization[42] THEN
		statusMessagePalletization := 10;
	END_IF
	IF alarmImagePalletization[39] THEN
		statusMessagePalletization := 8;
	END_IF
	IF alarmImageCommon[6] THEN
		statusMessagePalletization := 7;
	END_IF
	IF alarmImageCommon[5] THEN
		statusMessagePalletization := 6;
	END_IF
	IF alarmImageCommon[4] THEN
		statusMessagePalletization := 4;
	END_IF
	IF alarmImageCommon[3] THEN
		statusMessagePalletization := 3;
	END_IF
	IF alarmImageCommon[2] THEN
		statusMessagePalletization := 2;
	END_IF
	IF alarmImageCommon[1] THEN
		statusMessagePalletization := 1;
	END_IF
	
	
END_ACTION

ACTION StatusMessageOutfeed: 

	IF modeZoneOutfeed = modeZoneAuto THEN
		statusMessageOutfeed := 28;
	END_IF
	IF alarmInZoneOutfeed THEN
		statusMessageOutfeed := 25;
	END_IF
	IF statePalletP22 <> palletNotPresent THEN
		statusMessageOutfeed := 34;
	END_IF		
	IF modeZoneOutfeed = modeZoneManual THEN
		statusMessageOutfeed := 22;
	END_IF
	IF alarmImageOutfeed[17] OR alarmImageOutfeed[19] THEN
		statusMessageOutfeed := 33;
	END_IF
	IF alarmImageOutfeed[0] THEN
		statusMessageOutfeed := 13;
	END_IF
	IF diOutfeedEDM THEN
		statusMessageOutfeed := 16;
	END_IF
	IF alarmImageOutfeed[15] THEN
		statusMessageOutfeed := 9;
	END_IF
	IF alarmImageCommon[6] THEN
		statusMessageOutfeed := 7;
	END_IF
	IF alarmImageCommon[5] THEN
		statusMessageOutfeed := 6;
	END_IF
	IF alarmImageCommon[4] THEN
		statusMessageOutfeed := 4;
	END_IF
	IF alarmImageCommon[3] THEN
		statusMessageOutfeed := 3;
	END_IF
	IF alarmImageCommon[2] THEN
		statusMessageOutfeed := 2;
	END_IF
	IF alarmImageCommon[1] THEN
		statusMessageOutfeed := 1;
	END_IF
	
END_ACTION