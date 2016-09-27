PROGRAM _INIT
	FI_12.init.taskTime := 0.02;
	FI_12.init.units := 2034;
	FI_12.init.encoderIncrements := 32537;
	FI_12.init.reverseDirection := 0;
	FI_12.init.maxLagError := 100;
	FI_12.init.Kp := 2;
	FI_12.init.Tn := 0;
	FI_12.init.speedFilter := 100;
	FI_12.init.settleTime := 0.5;
	FI_12.init.positiveSwLimit := 2270;
	FI_12.init.negativeSwLimit := 265;
	 
END_PROGRAM

PROGRAM _CYCLIC
	diDoor1opened;
	diOpenDoors1;
	diCloseDoors1;
	

	 
	PusherDriveP12;
	
END_PROGRAM
