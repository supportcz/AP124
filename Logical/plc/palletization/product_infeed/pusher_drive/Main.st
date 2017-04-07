
PROGRAM _INIT
	FI_12.init.positiveSwLimit := 2300;
	FI_12.init.negativeSwLimit := 200;
	FI_12.init.taskTime := 0.01;
	FI_12.init.units := FI_12.init.positiveSwLimit-FI_12.init.negativeSwLimit;
	FI_12.init.encoderIncrements := 32537;
	FI_12.init.reverseDirection := 0;
	FI_12.init.maxLagError := 200;
	FI_12.init.Kp := 10;
	FI_12.init.Tn := 0;
	FI_12.init.speedFilter := 100;
	FI_12.init.settleTime := 0.5;

	pusherDrive.tolerance := 30;
	pusherDrive.positions[0] := FI_12.init.negativeSwLimit + pusherDrive.tolerance;
	pusherDrive.positions[1] := 925;
	pusherDrive.positions[2] := 1470;
	pusherDrive.positions[3] := 1650;
	pusherDrive.positions[4] := 1970;
	pusherDrive.positions[5] := 2040;//FI_12.init.positiveSwLimit-tolerance;
	pusherDrive.speed := 500;
	
	acpI_P12.run := TRUE;

	 
END_PROGRAM

PROGRAM _CYCLIC
	
	actualPosition := FI_12.init.units*INT_TO_DINT(aiDistanceSensor)/32767+FI_12.init.negativeSwLimit;
	
	IF modeZonePalletization = modeZoneOff OR (modeZonePalletizationOld = modeZoneAuto AND modeZonePalletization <> modeZoneAuto) THEN
		statePusherDriveP12 := statePusherDriveStop;
	END_IF
	
	CASE statePusherDriveP12 OF
		
		statePusherDriveUndefined:
			
			FOR i := 0 TO 5 DO
				IF actualPosition >= pusherDrive.positions[i] - pusherDrive.tolerance AND  actualPosition <= pusherDrive.positions[i] + pusherDrive.tolerance THEN
					EXIT;
				END_IF
			END_FOR
			IF i <= 5 THEN
				pusherDrive.actualPositionIndex := i;
			ELSE
				pusherDrive.actualPositionIndex := 0;				
			END_IF
			statePusherDriveP12 := statePusherDriveStop;
		
		statePusherDriveStop:
			
			acpI_P12.switchOn := FALSE;
			FI_12.cmd.power := FALSE;
			
			pusherDrive.cmdAbsolute := FALSE;
			pusherDrive.cmdJogPlus := FALSE;
			pusherDrive.cmdJogMinus := FALSE;
			
			IF modeZonePalletization <> modeZoneOff THEN
				statePusherDriveP12 := statePusherDriveWait;
			END_IF
		
		statePusherDriveWait:

			IF pusherDrive.cmdJogPlus THEN
				statePusherDriveP12 := statePusherDriveJogPlus;
			END_IF	

			IF pusherDrive.cmdJogMinus THEN
				statePusherDriveP12 := statePusherDriveJogMinus;
			END_IF	

			IF pusherDrive.cmdAbsolute THEN
				statePusherDriveP12 := statePusherDriveAbsolute;
			END_IF	
			
			IF NOT FI_12.info.homingOk THEN
				statePusherDriveP12 := statePusherDriveHoming;
			END_IF
		
		statePusherDriveHoming:
			
			//compute actual position
			FI_12.param.position := actualPosition;
			FI_12.param.homing.mode := 0;
			FI_12.cmd.homing := 1;
			statePusherDriveP12 := statePusherDriveHoming2;			

		statePusherDriveHoming2:
			
			IF FI_12.info.homingOk THEN
				statePusherDriveP12 := statePusherDriveStop;
			END_IF

		statePusherDriveAbsolute:
			
			FI_12.cmd.power := 1;
			acpI_P12.switchOn := TRUE;					
			
			IF FI_12.info.powerOn AND acpI_P12.switchedOn THEN
				FI_12.cmd.absolute := TRUE;
				FI_12.param.position := pusherDrive.positions[pusherDrive.requestedPositionIndex];
				FI_12.param.speed := pusherDrive.speed;
				statePusherDriveP12 := statePusherDriveAbsolute2;
			END_IF
		
		statePusherDriveAbsolute2:
			
			IF NOT pusherDrive.cmdAbsolute THEN
				FI_12.cmd.stop := TRUE;	
			END_IF
			
			IF oldMoveActive > FI_12.info.moveActive THEN
				pusherDrive.actualPositionIndex := pusherDrive.requestedPositionIndex;
				statePusherDriveP12 := statePusherDriveStop;
			END_IF
				
		statePusherDriveJogPlus:
			
			FI_12.cmd.power := 1;
			acpI_P12.switchOn := TRUE;					
			
			IF FI_12.info.powerOn AND acpI_P12.switchedOn THEN

				pusherDrive.requestedPositionIndex := pusherDrive.actualPositionIndex + 1;
				IF pusherDrive.requestedPositionIndex > 5 THEN
					pusherDrive.requestedPositionIndex := 5;
				END_IF
				
				FI_12.cmd.absolute := TRUE;
				FI_12.param.position := pusherDrive.positions[pusherDrive.requestedPositionIndex];
				FI_12.param.speed := pusherDrive.speed;
				statePusherDriveP12 := statePusherDriveJogPlus2;
			END_IF
		
		statePusherDriveJogPlus2:
			
			IF NOT pusherDrive.cmdJogPlus THEN
				FI_12.cmd.stop := TRUE;	
			END_IF
			
			//IF oldMoveActive > FI_12.info.moveActive THEN
			IF NOT FI_12.info.moveActive THEN
				pusherDrive.actualPositionIndex := pusherDrive.requestedPositionIndex;
				statePusherDriveP12 := statePusherDriveStop;
			END_IF
		
		statePusherDriveJogMinus:
			
			FI_12.cmd.power := 1;
			acpI_P12.switchOn := TRUE;					
			
			IF FI_12.info.powerOn AND acpI_P12.switchedOn THEN	
				pusherDrive.requestedPositionIndex := pusherDrive.actualPositionIndex - 1;
				IF pusherDrive.requestedPositionIndex < 1 THEN
					pusherDrive.requestedPositionIndex := 1;
				END_IF
				
				FI_12.cmd.absolute := TRUE;
				FI_12.param.position := pusherDrive.positions[pusherDrive.requestedPositionIndex];
				FI_12.param.speed := pusherDrive.speed;
				statePusherDriveP12 := statePusherDriveJogMinus2;
			END_IF
		
		statePusherDriveJogMinus2:
			
			IF NOT pusherDrive.cmdJogMinus THEN
				FI_12.cmd.stop := TRUE;	
			END_IF
			
			IF NOT FI_12.info.moveActive THEN
				pusherDrive.actualPositionIndex := pusherDrive.requestedPositionIndex;
				statePusherDriveP12 := statePusherDriveStop;
			END_IF
	END_CASE

	oldMoveActive :=  FI_12.info.moveActive;
	
	memcpy(ADR(FI_12.IOMapping.Encoder), ADR(aiDistanceSensor), 2);
	FI_12();
	acpI_P12();
	
	aoPusherDriveP12 := FI_12.IOMapping.AnalogOutput;
	pusherDrive.actualPosition := FI_12.info.position;
	
	alarmImagePalletization[15] := aiDistanceSensor < -4000 OR aiDistanceSensor = 32767;
	
	alarmImagePalletization[14] := FI_12.info.status <> 0 OR acpI_P12.error;
	
	IF EDGENEG(acknowledgeImagePalletization[14]) THEN
		acpI_P12.reset := TRUE;
		FI_12.cmd.acknowledge := TRUE;
	END_IF
	 
END_PROGRAM
