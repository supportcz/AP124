(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SafetySample
 * File: SafetySample.fun
 * Author: B&R
 ********************************************************************
 * Functions and function blocks of program SafetySample
 ********************************************************************)

FUNCTION itoahex : UINT (*converts a UDINT values into a HEX character string*) (*$GROUP=User*)
	VAR_INPUT
		value : UDINT; (*UDINT value to be converted into a HEX character string*)
		pString : UDINT; (*pointer to the destination character string*)
	END_VAR
	VAR
		i_counter : USINT; (*internal variable*)
		i_value : UDINT; (*internal variable*)
		i_cvalue : USINT; (*internal variable*)
	END_VAR
END_FUNCTION
