
PROGRAM _INIT
	FI_12.init.taskTime := 0.01;
	FI_12.init.units := 2034;
	FI_12.init.encoderIncrements := 32537;
	FI_12.init.reverseDirection := 0;
	FI_12.init.maxLagError := 200;
	FI_12.init.Kp := 10;
	FI_12.init.Tn := 0;
	FI_12.init.speedFilter := 100;
	FI_12.init.settleTime := 0.5;
	FI_12.init.positiveSwLimit := 2270;
	FI_12.init.negativeSwLimit := 265;
	
	pusherRequredPosition := 1000;
	pusherRequredSpeed := 500;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	driveReady := modePalletization <> modePalletizationNotReadyToStart AND FI_12.info.status = 0 AND NOT acpI_P12.error;
	
	IF NOT driveReady THEN
		statePusherDriveP12 := statePusherDriveStop;
	END_IF
		
	CASE statePusherDriveP12 OF
		
		statePusherDriveStop:
			
			acpI_P12.switchOn := FALSE;
			FI_12.cmd.power := FALSE;

			IF diReset THEN
				acpI_P12.reset := TRUE;
				FI_12.cmd.acknowledge := TRUE;
			END_IF
		
			IF driveReady THEN
				statePusherDriveP12 := statePusherDriveWait;
			END_IF
		
		statePusherDriveWait:
		
//			acpI_P12.switchOn := FALSE;
//			FI_12.cmd.power := FALSE;

			IF cmdPusherJogPlus THEN
				IF FI_12.info.powerOn AND acpI_P12.switchedOn THEN
					statePusherDriveP12 := statePusherDriveJogPlus;
				ELSE
					FI_12.cmd.power := 1;
					acpI_P12.switchOn := TRUE;					
				END_IF				
			END_IF					
			
			IF cmdPusherGoToPosition THEN
				IF FI_12.info.powerOn AND acpI_P12.switchedOn THEN
					statePusherDriveP12 := statePusherDriveMoveToPos;
				ELSE
					FI_12.cmd.power := 1;
					acpI_P12.switchOn := TRUE;					
				END_IF				
			END_IF	
			
			IF NOT FI_12.info.homingOk THEN
				IF FI_12.info.powerOn AND acpI_P12.switchedOn THEN
					statePusherDriveP12 := statePusherDriveHoming;
				ELSE
					FI_12.cmd.power := 1;
					acpI_P12.switchOn := TRUE;					
				END_IF
			END_IF
		
		statePusherDriveHoming:
			
			IF FI_12.info.homingOk THEN
				statePusherDriveP12 := statePusherDriveStop;
			ELSE	
				FI_12.param.position := 265;//homing position
				FI_12.param.speed := 200;
				FI_12.param.acceleration := 2000;
				FI_12.param.deceleration := 2000;
				FI_12.param.homing.mode := 2;
				FI_12.param.homing.startDirection := 1;
				FI_12.param.homing.edgeSwitch := 1;
				FI_12.param.homing.speed2 := 100;
				FI_12.cmd.homing := 1;
			END_IF

		statePusherDriveMoveToPos:
			
			cmdPusherGoToPosition := FALSE;
			
			FI_12.cmd.absolute := TRUE;
			FI_12.param.position := pusherRequredPosition;
			FI_12.param.speed := pusherRequredSpeed;
			statePusherDriveP12 := statePusherDriveMovingToPos;
		
		statePusherDriveMovingToPos:
			
			IF NOT FI_12.info.moveActive THEN
				statePusherDriveP12 := statePusherDriveStop;
			END_IF
		
		statePusherDriveJogPlus:
			
			FI_12.cmd.velocity := cmdPusherJogPlus;
			FI_12.param.speed := pusherRequredSpeed;
		
			IF NOT cmdPusherJogPlus THEN
				statePusherDriveP12 := statePusherDriveStop;
			END_IF
		
	END_CASE

	FI_12();
	acpI_P12();
	
	aoPusherDriveP12 := FI_12.IOMapping.AnalogOutput;
	
	//hysteresis
	//	IF aoPusherDriveP12 > -100 AND aoPusherDriveP12 < 100 THEN
	//		aoPusherDriveP12 := 0;
	//	END_IF
	
	IF FI_12.info.status <> 0 OR acpI_P12.error THEN
		alarmImagePalletization[14] := TRUE;
	ELSE
		alarmImagePalletization[14] := FALSE;
	END_IF

	 
				END_PROGRAM
