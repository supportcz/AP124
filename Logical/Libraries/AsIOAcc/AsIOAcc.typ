(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsIOAcc
 * File: AsIOAcc.typ
 * Author: B+R
 ********************************************************************
 * Data types of library AsIOAcc
 ********************************************************************)
                                                                      
TYPE
	IOAC_I_TYPE : STRUCT			(*internal use*)
		StateMan	: UINT ;
		ErrMan	: UINT ;
		Init	: UDINT ;
		Taskhandle	: UDINT ;
		Semaphore	: UDINT ;
		Requestsize	: UDINT ;
		Answersize	: UDINT ;
		pAccessObj	: UDINT ;
		Offset	: UDINT ;
		flags	: UDINT ;
	END_STRUCT;
END_TYPE