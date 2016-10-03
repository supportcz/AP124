
(* control of ACOPOSinverter without SDC *)
FUNCTION_BLOCK AcpInoSdc
	
	LFRD_Output := speed;
	
	CASE ETAD_Input AND 16#FF  OF
		16#40, 16#50: (* Switch on disabled *)
		CMDD_Output := 16#0006;
		
		16#21, 16#31: (*Ready to switch on *)
		IF switchOn THEN
			CMDD_Output := 16#0007;
		END_IF
		
		16#33, 16#23: (*Switched on *)
		CMDD_Output := 16#000F;
		
		16#37, 16#27: (*Operation enabled *)
		IF stop THEN
			CMDD_Output := 16#010F;
		ELSE
			CMDD_Output := 16#000F;			
		END_IF

		IF NOT switchOn THEN
			CMDD_Output := 16#0006;
		END_IF
			
		IF quickStop THEN
			CMDD_Output := 16#0002;						
		END_IF		
		
		16#17, 16#07: (*Quick stop active *)
		quickStop := FALSE;
		switchOn := FALSE;
		CMDD_Output := 16#0000;	
	END_CASE;

	(* Fault *)
	error := ETAD_Input.3;
	
	IF reset AND error THEN
		CMDD_Output := 16#0080;						
	END_IF	
	reset := FALSE;
	
	switchedOn := ETAD_Input.1;
END_FUNCTION_BLOCK
