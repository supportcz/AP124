
FUNCTION_BLOCK FI
	VAR_INPUT
		init : Motorky_Init_Enc_typ;
		cmd : Motorky_Cmd_typ;
		param : Motorky_Param_typ;
	END_VAR
	VAR_OUTPUT
		info : Motorky_Info_typ;
		IOMapping : Motorky_FI_IOMapping;
	END_VAR
	VAR
		intern : Motorky_Intern_typ;
		internFI : Motorky_InternFI_typ;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MM
	VAR_INPUT
		init : Motorky_Init_MM_typ;
		cmd : Motorky_Cmd_typ;
		param : Motorky_Param_typ;
	END_VAR
	VAR_OUTPUT
		info : Motorky_Info_typ;
		IOMapping : Motorky_MM_IOMapping;
	END_VAR
	VAR
		intern : Motorky_Intern_typ;
		internMM : Motorky_InternMM_typ;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK DS
	VAR_INPUT
		init : Motorky_Init_NoEnc_typ;
		cmd : Motorky_Cmd_typ;
		param : Motorky_Param_typ;
	END_VAR
	VAR_OUTPUT
		info : Motorky_Info_typ;
		IOMapping : Motorky_DS_IOMapping;
	END_VAR
	VAR
		intern : Motorky_Intern_typ;
		movTargetTimeOffset : DINT;
		units2output : Motorky_ConvertPosition;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK SM
	VAR_INPUT
		init : Motorky_Init_SM_typ;
		cmd : Motorky_Cmd_typ;
		param : Motorky_Param_typ;
	END_VAR
	VAR_OUTPUT
		info : Motorky_Info_typ;
		IOMapping : Motorky_SM_IOMapping;
	END_VAR
	VAR
		intern : Motorky_Intern_typ;
		tofBoostCurrent : Motorky_TOF;
		dPosition : DINT;
		oldPosition : DINT;
		units2output : Motorky_ConvertPosition;
		filterLevel : INT;
	END_VAR
END_FUNCTION_BLOCK
