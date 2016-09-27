
TYPE
	Motorky_ActualSpeed : 	STRUCT 
		actPosition : DINT;
		actSpeed : DINT;
		taskTime : DINT;
		filterTime : DINT;
		positionDifference : DINT;
		FIFOsize : DINT;
		FIFOindex : DINT;
		positionFIFO : ARRAY[0..SPEED_FIFO_UBOUND]OF DINT;
	END_STRUCT;
	Motorky_Cmd_typ : 	STRUCT 
		power : BOOL;
		homing : BOOL;
		absolute : BOOL;
		additive : BOOL;
		cyclicPosition : BOOL;
		velocity : BOOL;
		acknowledge : BOOL;
		stop : BOOL;
	END_STRUCT;
	Motorky_ConvertAcceleration : 	STRUCT 
		inputScale : DINT;
		outputScale : DINT;
		maxAcceleration : DINT;
		status : UINT;
	END_STRUCT;
	Motorky_ConvertPosition : 	STRUCT 
		inputScale : DINT;
		outputScale : DINT;
		reverseDirection : BOOL;
		input : INT;
		output : DINT;
		dInput : INT;
		integral : DINT;
	END_STRUCT;
	Motorky_ConvertSpeed : 	STRUCT 
		inputScale : DINT;
		outputScale : DINT;
		maxSpeed : DINT;
		status : UINT;
	END_STRUCT;
	Motorky_DS_Intern_typ : 	STRUCT 
		step : UINT;
		oldStep : UINT;
		oldPosition : DINT;
		oldReferenceSwitch : BOOL;
		movTargetTimeOffset : DINT;
		pathGenerator : Motorky_PathGenerator;
		convertPosition : Motorky_ConvertPosition;
		actualSpeed : Motorky_ActualSpeed;
	END_STRUCT;
	Motorky_DS_IOMapping : 	STRUCT 
		DriveReady : BOOL;
		SystemTime : DINT;
		DriveEnable : BOOL;
		MovTargetTime : DINT;
		MovTargetPosition : DINT;
		positiveLimitSwitch : BOOL;
		negativeLimitSwitch : BOOL;
		referenceSwitch : BOOL;
	END_STRUCT;
	Motorky_FI_IOMapping : 	STRUCT 
		DriveReady : BOOL;
		Encoder : INT;
		DriveEnable : BOOL;
		AnalogOutput : INT;
		positiveLimitSwitch : BOOL;
		negativeLimitSwitch : BOOL;
		referenceSwitch : BOOL;
	END_STRUCT;
	Motorky_Info_typ : 	STRUCT 
		initialized : BOOL;
		powerOn : BOOL;
		homingOk : BOOL;
		position : DINT;
		speed : DINT;
		moveActive : BOOL;
		lagError : DINT;
		status : UINT;
		errorText : STRING[100];
	END_STRUCT;
	Motorky_Init_MM_typ : 	STRUCT 
		taskTime : REAL;
		units : DINT;
		encoderIncrements : DINT;
		reverseDirection : BOOL;
		maxLagError : DINT;
		Kp : REAL;
		Tn : REAL;
		speedKp : REAL;
		speedTn : REAL;
		speedFilter : REAL;
		settleTime : REAL;
		positiveSwLimit : DINT;
		negativeSwLimit : DINT;
	END_STRUCT;
	Motorky_Init_Enc_typ : 	STRUCT 
		taskTime : REAL;
		units : DINT;
		encoderIncrements : DINT;
		reverseDirection : BOOL;
		maxLagError : DINT;
		Kp : REAL;
		Tn : REAL;
		speedFilter : REAL;
		settleTime : REAL;
		positiveSwLimit : DINT;
		negativeSwLimit : DINT;
	END_STRUCT;
	Motorky_Init_SM_typ : 	STRUCT 
		taskTime : REAL;
		units : DINT;
		microsteps : DINT;
		reverseDirection : BOOL;
		settleTime : REAL;
		positiveSwLimit : DINT;
		negativeSwLimit : DINT;
		outputFilter : REAL;
	END_STRUCT;
	Motorky_Init_NoEnc_typ : 	STRUCT 
		taskTime : REAL;
		units : DINT;
		microsteps : DINT;
		reverseDirection : BOOL;
		settleTime : REAL;
		positiveSwLimit : DINT;
		negativeSwLimit : DINT;
	END_STRUCT;
	Motorky_Intern_typ : 	STRUCT 
		step : UINT;
		oldStep : UINT;
		oldPosition : DINT;
		oldReferenceSwitch : BOOL;
		pathGenerator : Motorky_PathGenerator;
		moveActive : Motorky_MoveActive;
	END_STRUCT;
	Motorky_InternFI_typ : 	STRUCT 
		encoder2units : Motorky_ConvertPosition;
		pid : Motorky_PID;
		actualSpeed : Motorky_ActualSpeed;
	END_STRUCT;
	Motorky_InternMM_typ : 	STRUCT 
		encoder2units : Motorky_ConvertPosition;
		pid : Motorky_PID;
		actualSpeed : Motorky_ActualSpeed;
		speedPID : Motorky_PID;
	END_STRUCT;
	Motorky_MM_Intern_typ : 	STRUCT 
		step : UINT;
		oldStep : UINT;
		encoderPosition : INT;
		oldPosition : DINT;
		oldReferenceSwitch : BOOL;
		pathGenerator : Motorky_PathGenerator;
		convertPosition : Motorky_ConvertPosition;
		actualSpeed : Motorky_ActualSpeed;
		moveActive : Motorky_MoveActive;
		pid : Motorky_PID;
	END_STRUCT;
	Motorky_MM_IOMapping : 	STRUCT 
		DriveReady : BOOL;
		DriveEnable : BOOL;
		PeriodDuration : UINT;
		PulseWidth : INT;
		ClearError : BOOL;
		Counter : INT;
		UnderVoltageError : BOOL;
		OverVoltageError : BOOL;
		OvertemperatureError : BOOL;
		OvercurrentError : BOOL;
		positiveLimitSwitch : BOOL;
		negativeLimitSwitch : BOOL;
		referenceSwitch : BOOL;
	END_STRUCT;
	Motorky_MoveActive : 	STRUCT 
		motionState : UINT;
		taskTime : DINT;
		settleTime : DINT;
		settleTimer : DINT;
		moveActive : BOOL;
	END_STRUCT;
	Motorky_OutputGenerator : 	STRUCT 
		enable : BOOL;
		encoderUsed : BOOL;
		reverseDirection : BOOL;
		setPosition : DINT;
		actPosition : DINT;
		setSpeed : DINT;
		motionState : UINT;
		settleTime : DINT;
		Y : DINT;
		moveActive : BOOL;
		settleTimer : DINT;
		taskTime : DINT;
		e : DINT;
		Kp : DINT;
		Ki : DINT;
		Yp : DINT;
		Yi : DINT;
		Yiintegral : DINT;
	END_STRUCT;
	Motorky_Param_Homing : 	STRUCT 
		mode : USINT;
		startDirection : BOOL;
		edgeSwitch : BOOL;
		triggerDirection : BOOL;
		speed2 : DINT;
	END_STRUCT;
	Motorky_Param_typ : 	STRUCT 
		position : DINT;
		speed : DINT;
		acceleration : DINT;
		deceleration : DINT;
		homing : Motorky_Param_Homing;
	END_STRUCT;
	Motorky_PathGenerator : 	STRUCT 
		moveCommand : USINT;
		setPosition : DINT;
		setSpeed : DINT;
		acceleration : DINT;
		deceleration : DINT;
		positiveSwLimit : DINT;
		negativeSwLimit : DINT;
		outputPosition : DINT;
		outputSpeed : DINT;
		motionState : UINT;
		status : UINT;
		step : UINT;
		speedRamping : Motorky_SpeedRamping;
	END_STRUCT;
	Motorky_PID : 	STRUCT 
		enable : BOOL;
		W : DINT;
		X : DINT;
		Y : DINT;
		Kp : DINT;
		Y_max : DINT;
		Y_min : DINT;
		e : DINT;
		Yp : DINT;
		Yi : DINT;
		Yi_sum : DINT;
		Ki : DINT;
		Ytotal : DINT;
		Ylim : DINT;
		Ywindup : DINT;
	END_STRUCT;
	Motorky_SM_Intern_typ : 	STRUCT 
		step : UINT;
		oldStep : UINT;
		setPosition : DINT;
		oldPosition : DINT;
		dPosition : DINT;
		oldReferenceSwitch : BOOL;
		pathGenerator : Motorky_PathGenerator;
		outputConversion : Motorky_ConvertPosition;
		actualSpeed : Motorky_ActualSpeed;
		tofBoostCurrent : Motorky_TOF;
		moveActive : Motorky_MoveActive;
	END_STRUCT;
	Motorky_SM_IOMapping : 	STRUCT 
		DriveReady : BOOL;
		MotorStep0 : INT;
		DriveEnable : BOOL;
		BoostCurrent : BOOL;
		StandstillCurrent : BOOL;
		StallError : BOOL;
		OvertemperatureError : BOOL;
		OvercurrentError : BOOL;
		ModulePowerSupplyError : BOOL;
		ClearError : BOOL;
		UZKStatus : BOOL;
		positiveLimitSwitch : BOOL;
		negativeLimitSwitch : BOOL;
		referenceSwitch : BOOL;
	END_STRUCT;
	Motorky_SpeedRamping : 	STRUCT 
		setSpeed : DINT;
		acceleration : DINT;
		deceleration : DINT;
		actualPosition : DINT;
		actualSpeed : DINT;
		motionState : UINT;
		divisor : DINT;
		sIntegral : DINT;
		vIntegral : DINT;
	END_STRUCT;
	Motorky_TOF : 	STRUCT 
		IN : BOOL;
		PT : DINT;
		Q : BOOL;
		ET : DINT;
	END_STRUCT;
END_TYPE
