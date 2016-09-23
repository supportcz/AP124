
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	IF modeMagazine = modeMagazineManual THEN
		magazineStatusDatapointManual := 0;
	ELSE
		magazineStatusDatapointManual := 1;
	END_IF

	IF modeMagazine = modeMagazineAuto THEN
		magazineStatusDatapointAuto := 0;
	ELSE
		magazineStatusDatapointAuto := 1;
	END_IF

	IF modeConveyors = modeConveyorsManual THEN
		conveyorsStatusDatapointManual := 0;
	ELSE
		conveyorsStatusDatapointManual := 1;
	END_IF

	IF modeConveyors = modeConveyorsAuto THEN
		conveyorsStatusDatapointAuto := 0;
	ELSE
		conveyorsStatusDatapointAuto := 1;
	END_IF

	IF palletOnConveyorP12 THEN
		hideP12 := 0;
	ELSE
		hideP12 := 1;
	END_IF	

	IF palletOnConveyorP13 THEN
		hideP13 := 0;
	ELSE
		hideP13 := 1;
	END_IF	

	IF palletOnConveyorP14 THEN
		hideP14 := 0;
	ELSE
		hideP14 := 1;
	END_IF	

	IF palletOnConveyorP15 THEN
		hideP15 := 0;
	ELSE
		hideP15 := 1;
	END_IF	

END_PROGRAM


