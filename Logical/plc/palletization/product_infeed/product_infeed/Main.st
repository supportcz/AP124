PROGRAM _INIT

		 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor1opened;
	diOpenDoors1;
	diCloseDoors1;
	
	//detect tray on input of conveyor P2
	TOF_TrayOnInputP2(IN := diTrayOnInputP2, PT := T#60ms);
	IF TOF_TrayOnInputP2.Q < trayOnInputP2old THEN
		nbOfTraysOnInputP2 := nbOfTraysOnInputP2 + 1;
	END_IF
	trayOnInputP2old := TOF_TrayOnInputP2.Q;

	//detect tray behind roration
	TOF_TrayBehindRotation(IN := diTrayBehindRotation, PT := T#60ms);
	IF TOF_TrayBehindRotation.Q < trayBehindRotationOld THEN
		nbOfTraysBehindRotation := nbOfTraysBehindRotation + 1;
	END_IF
	trayBehindRotationOld := TOF_TrayBehindRotation.Q;
	
	//select actual layout
	requestedLayoutIndex := actualRecipe.layer[actualLayer];
	
	IF requestedLayoutIndex = actualLayoutIndex AND nbOfTraysOnInputP2 > 0 AND nbOfTraysOnInputP2 <= actualLayout.nbOfTrays THEN
		//select actual tray
		actualTray ACCESS ADR(actualLayout.tray[nbOfTraysOnInputP2-1]); 
	END_IF
	
	CASE modePalletization OF
		
		modePalletizationNotReadyToStart: //the automat is not ready to start


		modePalletizationManual:

			pusherDrive.speed := 200;
			IF modePalletizationOld <> modePalletizationManual THEN
				cmdRunConveyorP1 := FALSE;
				cmdRunConveyorP2 := FALSE;
			END_IF
			stateAuto := stateAutoUndefined;

		modePalletizationAuto:
			
			pusherDrive.speed := 500;

			CASE stateAuto OF
				
				stateAutoUndefined:
				
					IF statePusherLifting = stateUpperPosition AND pusherDrive.actualPositionIndex = 1 THEN
						stateAuto := stateAutoPusherLiftingDown;
					END_IF

					IF statePusherLifting = stateLowerPosition AND pusherDrive.actualPositionIndex = 1 THEN
						stateAuto := stateAutoRunConveyors;
					END_IF
				
				stateAutoRunConveyors:
					
					cmdRunConveyorP1 := TRUE;
					cmdRunConveyorP2 := TRUE;		
					stateAuto := stateAutoWaitForFirstTray;
				
				stateAutoWaitForFirstTray:
					
					IF nbOfTraysOnInputP2 > nbOfTraysOnInputP2old THEN
						stateAuto := stateAutoFillARow;
					END_IF						
				
				stateAutoFillARow:
					
//					IF actualTray.turnTray THEN
//						cmdRotationForward := TRUE;
					
					IF actualTray.lastTrayInRow THEN
						cmdFillUpConveyorP1 := TRUE;
						stateAuto := stateAutoLastTray;
					END_IF	
				
				stateAutoLastTray:
					
					IF nbOfTraysBehindRotation = nbOfTraysOnInputP2 THEN
						TON_WaitForLastTray(IN := FALSE);					
						stateAuto := stateAutoLastTray2;
					END_IF
				
				stateAutoLastTray2:
					
					TON_WaitForLastTray(IN := TRUE, PT := actualTray.timeAfterLastTray);
					IF TON_WaitForLastTray.Q THEN
						cmdRunConveyorP2 := FALSE;
						stateAuto := stateAutoPusherToTable;
					END_IF
				
				stateAutoPusherToTable:
					
					pusherDrive.requestedPositionIndex := 2;
					pusherDrive.cmdAbsolute := TRUE;
					stateAuto := stateAutoPusherToTable2;
				
				stateAutoPusherToTable2:
					
					IF NOT pusherDrive.cmdAbsolute THEN
						stateAuto := stateAutoPusherLiftingUp;
					END_IF

				stateAutoPusherLiftingUp:
					
					cmdPusherLiftingUp := TRUE;
					stateAuto := stateAutoPusherLiftingUp2;
				
				stateAutoPusherLiftingUp2:
				
					IF NOT cmdPusherLiftingUp THEN
						stateAuto := stateAutoPusherToBasic;	
					END_IF
				
				stateAutoPusherToBasic:
					
					pusherDrive.requestedPositionIndex := 1;
					pusherDrive.cmdAbsolute := TRUE;
					stateAuto := stateAutoPusherToBasic2;				
				
				stateAutoPusherToBasic2:
				
					IF NOT pusherDrive.cmdAbsolute THEN
						stateAuto := stateAutoPusherLiftingDown;
					END_IF
				
				stateAutoPusherLiftingDown:
					
					cmdPusherLiftingDown := TRUE;
					stateAuto := stateAutoPusherLiftingDown2;
				
				stateAutoPusherLiftingDown2:

					IF NOT cmdPusherLiftingDown THEN
						stateAuto := stateAutoRunConveyors;
					END_IF
				
			END_CASE
		
	END_CASE
	
	nbOfTraysOnInputP2old := nbOfTraysOnInputP2;
	
	ConveyorP1;
	ConveyorP2;
	PusherLifting;
	Rotation;
	
	IF pusherDrive.driveError THEN
		alarmImagePalletization[14] := TRUE;
	ELSE
		alarmImagePalletization[14] := FALSE;
	END_IF

	IF pusherDrive.encoderError THEN
		alarmImagePalletization[15] := TRUE;
	ELSE
		alarmImagePalletization[15] := FALSE;
	END_IF

END_PROGRAM
