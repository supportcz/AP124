
ACTION PusherDriveP12: 

	IF modePalletization = modePalletizationNotReadyToStart THEN
		statePusherDriveP12 := statePusherDriveStop;
	END_IF
		
	CASE statePusherDriveP12 OF
		
		statePusherDriveStop:
			
			acpI_P12.switchOn := TRUE;
			acpI_P12.speed := 0;
			acpI_P12.reset := TRUE;
			
			FI_12.cmd.power := 1;
			
			IF modePalletization <> modePalletizationNotReadyToStart AND FI_12.info.powerOn THEN
				statePusherDriveP12 := statePusherDriveWait;
			END_IF
		
		statePusherDriveWait:
		
			IF NOT FI_12.info.homingOk THEN
				FI_12.param.position := 265;//homing position
				FI_12.param.speed := 50;
				FI_12.param.acceleration := 1000;
				FI_12.param.deceleration := 1000;
				FI_12.param.homing.mode := 2;
				FI_12.param.homing.startDirection := 1;
				FI_12.param.homing.edgeSwitch := 1;
				FI_12.param.homing.speed2 := 10;
				FI_12.cmd.homing := 1;
				statePusherDriveP12 := statePusherDriveHoming;
			END_IF
		
		statePusherDriveHoming:
			
			IF FI_12.info.homingOk THEN
				statePusherDriveP12 := statePusherDriveWait;
			END_IF
		
	END_CASE

	FI_12();
	acpI_P12();
	//acpI_P12.switchOn := FI_12.info.powerOn;
	
END_ACTION
