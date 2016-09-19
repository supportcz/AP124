
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	IF modeMagazine = modeMagazineManual THEN
		magazineStatusDatapoint := 0;
	ELSE
		magazineStatusDatapoint := 1;
	END_IF
	 
END_PROGRAM


