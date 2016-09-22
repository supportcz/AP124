(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SafetySample
 * File: itoahex.st
 * Author: B&R
 ********************************************************************
 * Implementation of program SafetySample
 ********************************************************************) 

(* converts a UDINT values into a HEX character string *)
FUNCTION itoahex

	i_value := value;

	FOR i_counter := 0 TO 7 BY 1  DO
		i_cvalue := REAL_TO_USINT(brmfloor(UDINT_TO_REAL(i_value / REAL_TO_UDINT(EXPT(16, 7 - i_counter)))));
		IF i_cvalue = 0 THEN
			brsmemset(pString + i_counter, 48, 1); // 48 Dec = ASCII '0'
		ELSIF i_cvalue > 0 AND i_cvalue < 10 THEN
			brsitoa(i_cvalue, pString + i_counter);
		ELSIF i_cvalue >= 10 THEN
			brsmemset(pString + i_counter, i_cvalue + 55, 1); // 65 Dec = ASCII 'A'
		END_IF
			
		IF i_cvalue > 0 THEN	
			i_value := i_value - REAL_TO_UDINT(EXPT(16, 7 - i_counter)) * i_cvalue;
		END_IF
				
	END_FOR

	itoahex := 0;

END_FUNCTION
