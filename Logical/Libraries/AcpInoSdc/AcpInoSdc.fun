
FUNCTION_BLOCK AcpInoSdc (*control of ACOPOSinverter without SDC*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		switchOn : BOOL;
		quickStop : BOOL;
		reset : BOOL := TRUE;
		speed : INT;
		ETAD_Input : UINT;
		run : BOOL;
	END_VAR
	VAR_OUTPUT
		CMDD_Output : UINT;
		LFRD_Output : INT;
		switchedOn : BOOL;
		error : BOOL;
	END_VAR
END_FUNCTION_BLOCK
