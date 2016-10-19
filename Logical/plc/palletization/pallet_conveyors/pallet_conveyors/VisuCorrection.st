
ACTION CopyToArray: 

	PalletStatus[12] := statePalletP12;
	PalletStatus[13] := statePalletP13;
	PalletStatus[14] := statePalletP14;
	PalletStatus[15] := statePalletP15;
	PalletStatus[16] := statePalletP16;
	PalletStatus[17] := statePalletP17;		
END_ACTION

ACTION CopyFromArray: 

	statePalletP12 := PalletStatus[12];
	statePalletP13 := PalletStatus[13];
	statePalletP14 := PalletStatus[14];
	statePalletP15 := PalletStatus[15];
	statePalletP16 := PalletStatus[16];
	statePalletP17 := PalletStatus[17];
			
END_ACTION