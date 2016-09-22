
FUNCTION_BLOCK AcpInoSdc (*control of ACOPOSinverter without SDC*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		switchOn : BOOL;
		quickStop : BOOL;
		reset : BOOL;
		speed : INT;
		ETAD_Input : UINT;
	END_VAR
	VAR_OUTPUT
		CMDD_Output : UINT;
		LFRD_Output : INT;
	END_VAR
END_FUNCTION_BLOCK