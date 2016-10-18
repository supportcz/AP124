(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SafetySample
 * File: SafetySample.st
 * Author: B&R
 ********************************************************************
 * Implementation of program SafetySample
 ********************************************************************)

PROGRAM _INIT

(* command structure for remote control FUB *)
remotecmd.Version := safeVERSION_R107;	(* version *)
remotecmd.Password := '123456';				(* password *)

(* command structure for application download *)
appcmd1.Version := safeVERSION_R107;	(* version *)
appcmd1.Password := '123456';					(* password *)
appcmd1.ApplicationID := 1;				(* application id *)

(* command structure for machine options download *)
datacmd1.Version := safeVERSION_R107;								(* version *)
datacmd1.Password := '123456';											(* password *)
datacmd1.pDeviceListInput := ADR(visuDeviceListInput);				(* device list *)
datacmd1.pMachineOptionsInput := ADR(dataMachineOptionsBitInput);	(* bit machine options *)
datacmd1.pModuleFlagsInput := ADR(dataModuleFlagsInput);			(* module flags *)
datacmd1.pAcknMachineOptions := ADR(dataAcknMachineOptions);		(* acknowledge information *)

(* command structure for extended machine options *)
datacmd2.Version := safeVERSION_R107;					(* version *)
datacmd2.Password := '123456';								(* password *)
datacmd2.pIntDataInput := ADR(visuIntInput);			(* INT channels *)
datacmd2.NumberIntInput := 1;							(* number of INT channels *)
datacmd2.pUintDataInput := ADR(visuUintInput);			(* UINT channels *)
datacmd2.NumberUintInput := 1;							(* number of UINT channels *)
datacmd2.pDintDataInput := ADR(visuDintInput);			(* DINT channels *)
datacmd2.NumberDintInput := 1;							(* number of DINT channels *)
datacmd2.pUdintDataInput := ADR(visuUdintInput);		(* UDINT channels *)
datacmd2.NumberUdintInput := 1;							(* number of UDINT channels *)
datacmd2.pAcknMachineOptions := ADR(visuAcknExtData);	(* acknowledge information *)



(* hide elements in visualization *)
FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
	statusButtonActiv[xcnt] := 1;
END_FOR

(* hide elements in visualization *)
statusButtonUnlockApp := 1;
statusButtonUnlockData := 1;
statusAcknInfoData := 1;
statusButtonUnlockExtData := 1;
statusAcknInfoExtData := 1;
statusDialog := 1;

(* set SafeLOGIC ID *)
visuUsedSLIDRemote := 1;
visuUsedSLIDData := 1;

END_PROGRAM

PROGRAM _CYCLIC
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(* show dialog to ackn command *)
	IF (dialogRemoteCmd = 1) THEN
		statusDialog := 0;
		dialogRemoteCmd := 0;
		indexButtonLeft := 0;
		indexButtonRight := 1;
		indexHeaderText := 0;
		IF (remotecmd.Data = safeCMD_SK_FORMAT) THEN
			indexMessageText := 0;
		ELSIF (remotecmd.Data = safeCMD_SK_XCHG) THEN
			indexMessageText := 1;
		ELSIF (remotecmd.Data = safeCMD_1_UDID_ACKN) THEN
			indexMessageText := 2;
		ELSIF (remotecmd.Data = safeCMD_2_UDID_ACKN) THEN
			indexMessageText := 3;
		ELSIF (remotecmd.Data = safeCMD_3_UDID_ACKN) THEN
			indexMessageText := 4;
		ELSIF (remotecmd.Data = safeCMD_4_UDID_ACKN) THEN
			indexMessageText := 5;
		ELSIF (remotecmd.Data =  safeCMD_N_UDID_ACKN) THEN
			indexMessageText := 6;
		ELSIF (remotecmd.Data =  safeCMD_CLEAR_DATA) THEN
			indexMessageText := 7;
		ELSIF (remotecmd.Data = safeCMD_FW_ACKN) THEN
			indexMessageText := 8;
		ELSIF (remotecmd.Data = safeCMD_RESET) THEN
			indexMessageText := 9;
		END_IF
	END_IF
	
	(* if dialog is ackn execute fub *)
	IF (dialogButtonLeft = 1 AND indexHeaderText = 0) THEN
		executeRemoteCmd := 1;
		dialogButtonLeft := 0;
		statusDialog := 1;
	ELSIF (dialogButtonRight = 1 AND indexHeaderText = 0) THEN
		dialogButtonRight := 0;
		statusDialog := 1;
	END_IF

	(* password must be at least 6 characters long *)
	IF brsstrlen(ADR(remotecmd.NewPassword)) < 6 THEN
		statusSetPassword := 2;
	ELSE
		statusSetPassword := 0;
	END_IF

	safeRemoteControl_0(SafeLOGICID := visuUsedSLIDRemote, Execute := executeRemoteCmd, pCommandData := ADR(remotecmd));
	(* reset execution flag *)
	IF (safeRemoteControl_0.Done = 1 OR safeRemoteControl_0.Error = 1) THEN
		executeRemoteCmd := 0;
	END_IF

	(* variables for visualization *)
	IF (safeRemoteControl_0.SafeLOGICStatus.SafeKEYChanged = 1) THEN
		FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
			statusButtonActiv[xcnt] := 1;
 			statusButtonInactiv[xcnt] := 0;
		END_FOR
		statusButtonActiv[1] := 0;
 		statusButtonInactiv[1] := 1;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 1 AND safeRemoteControl_0.SafeLOGICStatus.Scanning = 0) THEN
		FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
			statusButtonActiv[xcnt] := 1;
 			statusButtonInactiv[xcnt] := 0;
		END_FOR
		statusButtonActiv[3] := 0;
 		statusButtonInactiv[3] := 1;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 2 AND safeRemoteControl_0.SafeLOGICStatus.Scanning = 0) THEN
		FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
			statusButtonActiv[xcnt] := 1;
 			statusButtonInactiv[xcnt] := 0;
		END_FOR
		statusButtonActiv[4] := 0;
 		statusButtonInactiv[4] := 1;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 3 AND safeRemoteControl_0.SafeLOGICStatus.Scanning = 0) THEN
		FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
			statusButtonActiv[xcnt] := 1;
 			statusButtonInactiv[xcnt] := 0;
		END_FOR
		statusButtonActiv[5] := 0;
 		statusButtonInactiv[5] := 1;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 4 AND safeRemoteControl_0.SafeLOGICStatus.Scanning = 0) THEN
		FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
			statusButtonActiv[xcnt] := 1;
 			statusButtonInactiv[xcnt] := 0;
		END_FOR
		statusButtonActiv[6] := 0;
 		statusButtonInactiv[6] := 1;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches > 4 AND safeRemoteControl_0.SafeLOGICStatus.Scanning = 0) THEN
		FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
			statusButtonActiv[xcnt] := 1;
 			statusButtonInactiv[xcnt] := 0;
		END_FOR
		statusButtonActiv[7] := 0;
 		statusButtonInactiv[7] := 1;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfDifferentFirmware <> 0 AND safeRemoteControl_0.SafeLOGICStatus.Scanning = 0) THEN
		FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
			statusButtonActiv[xcnt] := 1;
 			statusButtonInactiv[xcnt] := 0;
		END_FOR
		statusButtonActiv[11] := 0;
 		statusButtonInactiv[11] := 1;
	ELSE
		FOR xcnt := 0 TO SIZEOF(statusButtonActiv) - 1 DO
			statusButtonActiv[xcnt] := 1;
 			statusButtonInactiv[xcnt] := 0;
		END_FOR
	END_IF
	(* status text - MXCHG *)
	IF (safeRemoteControl_0.SafeLOGICStatus.LedTestActive = 1) THEN
		indexMxchgLed := 40;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.Scanning = 1) THEN
		indexMxchgLed := 30;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 1) THEN
		indexMxchgLed := 1;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 2) THEN
		indexMxchgLed := 2;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 3) THEN
		indexMxchgLed := 3;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 4) THEN
		indexMxchgLed := 4;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches > 4) THEN
		indexMxchgLed := 5;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfMissingModules <> 0) THEN
		indexMxchgLed := 20;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfUDIDMismatches = 0) THEN
		indexMxchgLed := 10;
	END_IF
	(* status text - FW-ACKN *)
	IF (safeRemoteControl_0.SafeLOGICStatus.SafeKEYChanged = 0 AND safeRemoteControl_0.SafeLOGICStatus.NumberOfDifferentFirmware = 0) THEN
		indexFwAcknLed := 10;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.SafeKEYChanged = 1) THEN
		indexFwAcknLed := 1;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.NumberOfDifferentFirmware <> 0) THEN
		indexFwAcknLed := 2;
	END_IF
	(* status text - FAIL *)
	IF (safeRemoteControl_0.SafeLOGICStatus.FailSafe <> 16#55) THEN
		indexFAILLed := 2;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.openSAFETYstate = 0) THEN
		indexFAILLed := 0;
	ELSIF (safeRemoteControl_0.SafeLOGICStatus.openSAFETYstate = 1) THEN
		indexFAILLed := 1;
	END_IF
	(* status text - R/E *)
	indexRELed := safeRemoteControl_0.SafeLOGICStatus.SafeOSState;
	
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(* show dialog to ackn command *)
	IF (dialogApplication = 1) THEN
		statusDialog := 0;
		dialogApplication := 0;
		indexButtonLeft := 0;
		indexButtonRight := 1;
		indexHeaderText := 1;
		indexMessageText := 10;
	END_IF
	
	(* if dialog is ackn unlock application *)
	IF (dialogButtonLeft = 1 AND indexHeaderText = 1) THEN
		appcmd1.Unlock := 1;
		dialogButtonLeft := 0;
		statusDialog := 1;
	ELSIF (dialogButtonRight = 1 AND indexHeaderText = 1) THEN
		appcmd1.Unlock := 2;
		dialogButtonRight := 0;
		statusDialog := 1;
	END_IF

	(* convert application CRC to HEX string *)
	itoahex(safeDownloadApplication_0.ApplicationCRC, ADR(visuApplicationCRC));

	safeDownloadApplication_0(SafeLOGICID := appcmd1.ApplicationID, Execute := executeapp1, pCommandData := ADR(appcmd1));
	
	(* show unlock button *)
	IF (safeDownloadApplication_0.UnlockRequired = 1) THEN
		statusButtonUnlockApp := 0;
	ELSE
		appcmd1.Unlock := 0;
		statusButtonUnlockApp := 1;
	END_IF
	
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(* disable machine options *)
	IF (visuEnableMachineOptions = FALSE) THEN
		datacmd1.pMachineOptionsInput := 0;
	ELSE
		datacmd1.pMachineOptionsInput := ADR(dataMachineOptionsBitInput);
	END_IF

	(* disable module flags *)
	IF (visuEnableModuleFlags = FALSE) THEN
		datacmd1.pModuleFlagsInput := 0;
	ELSE
		datacmd1.pModuleFlagsInput := ADR(dataModuleFlagsInput);
	END_IF

	(* Machine Option Bit #000 *)
	IF (visuMachineOptionsBitInput[0] = 1) THEN
		dataMachineOptionsBitInput.BitData[0].0 := 1;
	ELSE
		dataMachineOptionsBitInput.BitData[0].0 := 0;
	END_IF
	(* Machine Option Bit #001 *)
	IF (visuMachineOptionsBitInput[1] = 1) THEN
		dataMachineOptionsBitInput.BitData[0].1 := 1;
	ELSE
		dataMachineOptionsBitInput.BitData[0].1 := 0;
	END_IF
	(* Machine Option Bit #002 *)
	IF (visuMachineOptionsBitInput[2] = 1) THEN
		dataMachineOptionsBitInput.BitData[0].2 := 1;
	ELSE
		dataMachineOptionsBitInput.BitData[0].2 := 0;
	END_IF
	(* Optional Flag Module #1 *)
	IF (visuModuleFlagsOptionalInput[1] = 1) THEN
		dataModuleFlagsInput.Optional[0].1 := 1;
	ELSE
		dataModuleFlagsInput.Optional[0].1 := 0;
	END_IF
	(* Optional Flag Module #2 *)
	IF (visuModuleFlagsOptionalInput[2] = 1) THEN
		dataModuleFlagsInput.Optional[0].2 := 1;
	ELSE
		dataModuleFlagsInput.Optional[0].2 := 0;
	END_IF
	(* Startup Flag Module #1 *)
	IF (visuModuleFlagsStartupInput[1] = 1) THEN
		dataModuleFlagsInput.Startup[0].1 := 1;
	ELSE
		dataModuleFlagsInput.Startup[0].1 := 0;
	END_IF
	(* Startup Flag Module #2 *)
	IF (visuModuleFlagsStartupInput[2] = 1) THEN
		dataModuleFlagsInput.Startup[0].2 := 1;
	ELSE
		dataModuleFlagsInput.Startup[0].2 := 0;
	END_IF
	(* Not_Present Flag Module #1 *)
	IF (visuModuleFlagsNotPresentInput[1] = 1) THEN
		dataModuleFlagsInput.NotPresent[0].1 := 1;
	ELSE
		dataModuleFlagsInput.NotPresent[0].1 := 0;
	END_IF
	(* Not_Present Flag Module #2 *)
	IF (visuModuleFlagsNotPresentInput[2] = 1) THEN
		dataModuleFlagsInput.NotPresent[0].2 := 1;
	ELSE
		dataModuleFlagsInput.NotPresent[0].2 := 0;
	END_IF

	(* Ackn Machine Option Bit #000 *)
	IF (visuAcknMachineOptions[0] = 1) THEN
		dataAcknMachineOptions.AcknBitOptions[0].0 := 1;
	ELSE
		dataAcknMachineOptions.AcknBitOptions[0].0 := 0;
	END_IF
	(* Ackn Machine Option Bit #001 *)
	IF (visuAcknMachineOptions[1] = 1) THEN
		dataAcknMachineOptions.AcknBitOptions[0].1 := 1;
	ELSE
		dataAcknMachineOptions.AcknBitOptions[0].1 := 0;
	END_IF
	(* Ackn Machine Option Bit #002 *)
	IF (visuAcknMachineOptions[2] = 1) THEN
		dataAcknMachineOptions.AcknBitOptions[0].2 := 1;
	ELSE
		dataAcknMachineOptions.AcknBitOptions[0].2 := 0;
	END_IF

	(* show dialog to ackn command *)
	IF (dialogData = 1) THEN
		statusDialog := 0;
		dialogData := 0;
		indexButtonLeft := 0;
		indexButtonRight := 1;
		indexHeaderText := 2;
		indexMessageText := 11;
	END_IF

	(* if dialog is ackn unlock data *)
	IF (dialogButtonLeft = 1 AND indexHeaderText = 2) THEN
		datacmd1.Unlock := 1;
		dialogButtonLeft := 0;
		statusDialog := 1;
	ELSIF (dialogButtonRight = 1 AND indexHeaderText = 2) THEN
		datacmd1.Unlock := 2;
		dialogButtonRight := 0;
		statusDialog := 1;
	END_IF

	safeDownloadData_0(SafeLOGICID := visuUsedSLIDData, Execute := executedata1, Type:= safeDATA_TYPE_MAOP, pCommandData := ADR(datacmd1));
	
	(* data compare failed *)
	IF (safeDownloadData_0.StatusID = safeERR_DL_COMPARE_FAILED) THEN
		indexCompareTextData := 2;
	ELSE
		indexCompareTextData := 0;
	END_IF

	IF (safeDownloadData_0.UnlockRequired = 1) THEN
		(* data compare successful *)
		indexCompareTextData := 1;
		IF (datacmd1.pDeviceListOutput <> 0 AND datacmd1.NumberDevicesOutput <> 0) THEN
			pDeviceListOut ACCESS datacmd1.pDeviceListOutput;
			
			(* device #1 *)
			visuDeviceListOutput[0].SADR := pDeviceListOut[0].SADR;
			brsmemcpy(ADR(visuDeviceListOutput[0].UDID_High), ADR(pDeviceListOut[0].UDID[0]), 2);
			(* swap UDID *)
			visuDeviceListOutput[0].UDID_High := swapUINT(visuDeviceListOutput[0].UDID_High);
			brsmemcpy(ADR(visuDeviceListOutput[0].UDID_Low), ADR(pDeviceListOut[0].UDID[2]), 4);
			(* swap UDID *)
			visuDeviceListOutput[0].UDID_Low := swapUDINT(visuDeviceListOutput[0].UDID_Low);
			(* device #2 *)
			visuDeviceListOutput[1].SADR := pDeviceListOut[1].SADR;
			brsmemcpy(ADR(visuDeviceListOutput[1].UDID_High), ADR(pDeviceListOut[1].UDID[0]), 2);
			(* swap UDID *)
			visuDeviceListOutput[1].UDID_High := swapUINT(visuDeviceListOutput[1].UDID_High);
			brsmemcpy(ADR(visuDeviceListOutput[1].UDID_Low), ADR(pDeviceListOut[1].UDID[2]), 4);
			(* swap UDID *)
			visuDeviceListOutput[1].UDID_Low := swapUDINT(visuDeviceListOutput[1].UDID_Low);
		END_IF
		
		IF (datacmd1.pMachineOptionsOutput <> 0) THEN
			pMachineOptionsBitOut ACCESS datacmd1.pMachineOptionsOutput;
			
			(* Machine Option Bit #000 *)
			IF (pMachineOptionsBitOut.BitData[0].0 = 1) THEN
				visuMachineOptionsBitOutput[0] := 1;
			END_IF
			(* Machine Option Bit #001 *)
			IF (pMachineOptionsBitOut.BitData[0].1 = 1) THEN
				visuMachineOptionsBitOutput[1] := 1;
			END_IF
			(* Machine Option Bit #002 *)
			IF (pMachineOptionsBitOut.BitData[0].2 = 1) THEN
				visuMachineOptionsBitOutput[2] := 1;
			END_IF
		END_IF

		IF (datacmd1.pModuleFlagsOutput <> 0) THEN
			pModuleFlagsOut ACCESS datacmd1.pModuleFlagsOutput;	
		
			(* Optional Flag Module #1 *)
			IF (pModuleFlagsOut.Optional[0].1 = 1) THEN
				visuModuleFlagsOptionalOutput[1] := 1;
			END_IF
			(* Optional Flag Module #2 *)
			IF (pModuleFlagsOut.Optional[0].2 = 1) THEN
				visuModuleFlagsOptionalOutput[2] := 1;
			END_IF
			(* Startup Flag Module #1 *)
			IF (pModuleFlagsOut.Startup[0].1 = 1) THEN
				visuModuleFlagsStartupOutput[1] := 1;
			END_IF
			(* Startup Flag Module #2 *)
			IF (pModuleFlagsOut.Startup[0].2 = 1) THEN
				visuModuleFlagsStartupOutput[2] := 1;
			END_IF
			(* Not_Present Flag Module #1 *)
			IF (pModuleFlagsOut.NotPresent[0].1 = 1) THEN
				visuModuleFlagsNotPresentOutput[1] := 1;
			END_IF
			(* Not_Present Flag Module #2 *)
			IF (pModuleFlagsOut.NotPresent[0].2 = 1) THEN
				visuModuleFlagsNotPresentOutput[2] := 1;
			END_IF
		END_IF
		(* show ackn box *)
		statusAcknInfoData := 0;
		(* show unlock button unlocked if one ACK is set *)
		IF (visuAcknMachineOptions[0] = 1 OR visuAcknMachineOptions[1] = 1 OR visuAcknMachineOptions[2] = 1) THEN
			statusButtonUnlockData := 0;
		END_IF
	ELSIF (safeDownloadData_0.Done = 1 OR safeDownloadData_0.Error = 1) THEN
		(* reset visualization elements *)
		brsmemset(ADR(visuDeviceListOutput), 0, SIZEOF(visuDeviceListOutput));
		brsmemset(ADR(visuMachineOptionsBitOutput), 0, SIZEOF(visuMachineOptionsBitOutput));
		brsmemset(ADR(visuModuleFlagsOptionalOutput), 0, SIZEOF(visuModuleFlagsOptionalOutput));
		brsmemset(ADR(visuModuleFlagsStartupOutput), 0, SIZEOF(visuModuleFlagsStartupOutput));
		brsmemset(ADR(visuModuleFlagsNotPresentOutput), 0, SIZEOF(visuModuleFlagsNotPresentOutput));
		(* hide ackn box *)
		statusAcknInfoData := 1;
		(* hide unlock button *)
		datacmd1.Unlock := 0;
		statusButtonUnlockData := 1;
		(* reset ackn flags *)
		visuAcknMachineOptions[0] := 0;
		visuAcknMachineOptions[1] := 0;
		visuAcknMachineOptions[2] := 0;
	ELSE
		(* hide ackn box *)
		statusAcknInfoData := 1;
		(* hide unlock button *)
		datacmd1.Unlock := 0;
		statusButtonUnlockData := 1;
	END_IF

	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(* Enable for INT set *)
	IF (visuEnableINTOptions <> 0) THEN
		datacmd2.pIntDataInput := ADR(visuIntInput);
		datacmd2.NumberIntInput := 1;
	ELSE
		datacmd2.pIntDataInput := 0;
		datacmd2.NumberIntInput := 0;
	END_IF
	(* Enable for UINT set *)
	IF (visuEnableUINTOptions <> 0) THEN
		datacmd2.pUintDataInput := ADR(visuUintInput);
		datacmd2.NumberUintInput := 1;
	ELSE
		datacmd2.pUintDataInput := 0;
		datacmd2.NumberUintInput := 0;
	END_IF
	(* Enable for DINT set *)
	IF (visuEnableDINTOptions <> 0) THEN
		datacmd2.pDintDataInput := ADR(visuDintInput);
		datacmd2.NumberDintInput := 1;
	ELSE
		datacmd2.pDintDataInput := 0;
		datacmd2.NumberDintInput := 0;
	END_IF
	(* Enable for UDINT set *)
	IF (visuEnableUDINTOptions <> 0) THEN
		datacmd2.pUdintDataInput := ADR(visuUdintInput);
		datacmd2.NumberUdintInput := 1;
	ELSE
		datacmd2.pUdintDataInput := 0;
		datacmd2.NumberUdintInput := 0;
	END_IF

	(* show dialog to ackn command *)
	IF (dialogExtData = 1) THEN
		statusDialog := 0;
		dialogExtData := 0;
		indexButtonLeft := 0;
		indexButtonRight := 1;
		indexHeaderText := 3;
		indexMessageText := 11;
	END_IF

	(* if dialog is ackn unlock data *)
	IF (dialogButtonLeft = 1 AND indexHeaderText = 3) THEN
		datacmd2.Unlock := 1;
		dialogButtonLeft := 0;
		statusDialog := 1;
	ELSIF (dialogButtonRight = 1 AND indexHeaderText = 3) THEN
		datacmd2.Unlock := 2;
		dialogButtonRight := 0;
		statusDialog := 1;
	END_IF

	safeDownloadData_1(SafeLOGICID := visuUsedSLIDData, Execute := executedata2, Type:= safeDATA_TYPE_EXTMAOP, pCommandData := ADR(datacmd2));

	(* data compare failed *)
	IF (safeDownloadData_1.StatusID = safeERR_DL_COMPARE_FAILED) THEN
		indexCompareTextExtData := 2;
	ELSE
		indexCompareTextExtData := 0;
	END_IF
	
	IF (safeDownloadData_1.UnlockRequired = 1) THEN
		(* data compare successful *)
		indexCompareTextExtData := 1;
		
		(* INT channels *)
		IF (datacmd2.pIntDataOutput <> 0 AND datacmd2.NumberIntOutput <> 0) THEN
			brsmemcpy(ADR(visuIntOutput), datacmd2.pIntDataOutput, SIZEOF(visuIntOutput));
		END_IF
		(* UINT channels *)
		IF (datacmd2.pUintDataOutput <> 0 AND datacmd2.NumberUintOutput <> 0) THEN
			brsmemcpy(ADR(visuUintOutput), datacmd2.pUintDataOutput, SIZEOF(visuUintOutput));
		END_IF
		(* DINT channels *)
		IF (datacmd2.pDintDataOutput <> 0 AND datacmd2.NumberDintOutput <> 0) THEN
			brsmemcpy(ADR(visuDintOutput), datacmd2.pDintDataOutput, SIZEOF(visuDintOutput));
		END_IF
		(* UDINT channels *)
		IF (datacmd2.pUdintDataOutput <> 0 AND datacmd2.NumberUdintOutput <> 0) THEN
			brsmemcpy(ADR(visuUdintOutput), datacmd2.pUdintDataOutput, SIZEOF(visuUdintOutput));
		END_IF
		(* show ackn box *)
		statusAcknInfoExtData := 0;
		(* show unlock button if one ACK is set *)
		IF (visuAcknExtData.AcknIntOptions[0] = 1 OR visuAcknExtData.AcknUintOptions[0] = 1 OR visuAcknExtData.AcknDintOptions[0] = 1 OR visuAcknExtData.AcknUdintOptions[0] = 1) THEN
			statusButtonUnlockExtData := 0;
		END_IF
	ELSIF (safeDownloadData_1.Done = 1 OR safeDownloadData_1.Error = 1) THEN
		(* reset visualization elements *)
		brsmemset(ADR(visuIntOutput), 0, SIZEOF(visuIntOutput));
		brsmemset(ADR(visuUintOutput), 0, SIZEOF(visuUintOutput));
		brsmemset(ADR(visuDintOutput), 0, SIZEOF(visuDintOutput));
		brsmemset(ADR(visuUdintOutput), 0, SIZEOF(visuUdintOutput));
		(* hide ackn box *)
		statusAcknInfoExtData := 1;
		(* hide unlock button *)
		datacmd2.Unlock := 0;
		statusButtonUnlockExtData := 1;
		(* reset ackn flags *)
		visuAcknExtData.AcknIntOptions[0] := 0;
		visuAcknExtData.AcknUintOptions[0] := 0;
		visuAcknExtData.AcknDintOptions[0] := 0;
		visuAcknExtData.AcknUdintOptions[0] := 0;
	ELSE
		(* hide ackn box *)
		statusAcknInfoExtData := 1;
		(* hide unlock button *)
		datacmd2.Unlock := 0;
		statusButtonUnlockExtData := 1;
	END_IF

	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(* read UDID from SafeLOGIC-X *)
	IF slxused = 1 THEN
		readUDIDlowSLX(enable := 1, pDeviceName := ADR(Station), pChannelName := ADR('UDID_low'));
	
		IF readUDIDlowSLX.status = 0 THEN
			UDID_Low := readUDIDlowSLX.value;
		ELSIF readUDIDlowSLX.status <> 65535 THEN
			UDID_Low := 0;
		END_IF
	
		readUDIDhighSLX(enable := 1, pDeviceName := ADR(Station), pChannelName := ADR('UDID_high'));
	
		IF readUDIDhighSLX.status = 0 THEN
			UDID_High := UDINT_TO_UINT(readUDIDhighSLX.value);
		ELSIF readUDIDhighSLX.status <> 65535 THEN
			UDID_High := 0;
		END_IF
		
		(* hide / show visualization elements *)
		stautsSLXInformation := 0;
		statusSLInformation := 1;
	(* read UDID form SafeLOGIC *)
	ELSE
		readUDIDlowSL(enable := 1, pDevice := ADR(Interface), node := Node, index := 16#2000, subindex := 6, pData := ADR(UDID_Low), datalen := SIZEOF(UDID_Low));

		IF readUDIDlowSL.status <> 0 AND readUDIDlowSL.status <> 65535 THEN
			UDID_Low := 0;
		END_IF

		readUDIDhighSL(enable := 1, pDevice := ADR(Interface), node := Node, index := 16#2000, subindex := 7, pData := ADR(UDID_High), datalen := SIZEOF(UDID_High));

		IF readUDIDhighSL.status <> 0 AND readUDIDhighSL.status <> 65535 THEN
			UDID_High := 0;
		END_IF
		
		(* hide / show visualization elements *)
		stautsSLXInformation := 1;
		statusSLInformation := 0;
	END_IF

	(* convert UDID to HEX string *)
	itoahex(UDID_Low, ADR(visuUDID_Low));
	itoahex(UDID_High, ADR(visuUDID_High));

	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(****************************************************************************************************************************************)
	(* write UDID for SafeLOGIC to command structure *)
	appcmd1.UDID_Low := UDID_Low;
	appcmd1.UDID_High := UDID_High;
	datacmd1.UDID_Low := UDID_Low;
	datacmd1.UDID_High := UDID_High;
	datacmd2.UDID_Low := UDID_Low;
	datacmd2.UDID_High := UDID_High;


END_PROGRAM
