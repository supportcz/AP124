[LIT]
35
0	165	101	165	107
23	86	105	94	105
24	94	105	95	105
25	94	105	94	109
26	94	109	95	109
28	73	13	100	13
51	63	121	95	121
60	61	155	88	155
61	88	155	94	155
62	88	155	88	162
63	88	162	93	162
68	49	101	95	101
70	165	107	170	107
71	165	107	165	115
72	165	115	172	115
74	165	122	170	122
75	165	115	165	122
77	165	128	171	128
78	165	122	165	128
79	165	101	170	101
80	132	101	165	101
82	88	162	88	170
84	88	178	95	178
85	88	170	88	178
87	88	186	95	186
88	88	178	88	186
89	88	170	94	170
125	70	75	93	75
126	48	79	57	79
127	48	75	57	75
134	145	42	145	55
135	145	42	150	42
136	138	42	145	42
137	145	55	149	55
138	176	55	177	55

[TET]
38
2	170	100	199	102	4	3	doPalletizationContactor1
3	170	106	199	108	4	3	doPalletizationContactor2
4	79	112	95	114	4	5	TIME#500ms
5	87	96	95	98	4	5	TRUE
6	81	116	95	118	4	5	SAFEFALSE
7	94	154	120	156	4	3	SM6_ReleaseOutput01
8	93	161	119	163	4	3	SM6_ReleaseOutput02
9	11	100	36	102	4	5	allSafetyCircuitsReady
22	65	104	86	106	4	5	diPalletizationEDM
27	132	104	156	106	4	3	palletizationEdmError
30	113	12	143	14	4	3	activateSafetyPalletization
31	83	16	100	18	4	5	TIME#1000ms
32	31	11	61	13	4	5	diActivateAllSafetyCircuits
33	32	15	61	17	4	5	diActivateMagazineSafety
44	20	120	50	122	4	5	activateSafetyPalletization
45	34	124	50	126	4	5	TIME#200ms
52	18	154	48	156	4	5	activateSafetyPalletization
53	32	158	48	160	4	5	TIME#300ms
69	172	114	182	116	4	3	doFI14
73	170	121	180	123	4	3	doFI15
76	171	127	181	129	4	3	doFI16
81	94	169	120	171	4	3	SM3_ReleaseOutput01
83	95	177	121	179	4	3	SM3_ReleaseOutput02
86	95	185	121	187	4	3	SM3_ReleaseOutput03
92	85	37	93	39	4	5	TRUE
93	79	69	93	71	4	5	SAFEFALSE
94	80	53	93	55	4	5	SAFETRUE
95	85	57	93	59	4	5	T#4s
96	80	61	93	63	4	5	TIME#15s
97	63	45	93	47	4	5	diLightCurtainP15muting1
98	85	65	93	67	4	5	TRUE
99	63	49	93	51	4	5	diLightCurtainP15muting2
100	72	41	93	43	4	5	diLightCurtainP15
102	18	74	48	76	4	5	activateSafetyPalletization
103	32	78	48	80	4	5	TIME#100ms
128	150	41	169	43	4	3	lightCurtainP15
129	17	104	36	106	4	5	lightCurtainP15
130	177	54	200	56	4	3	lightCurtainP15grey

[FBS]
10
21	97	93	130	125	0	SF_EDM_V1_00	SF_EDM_V1_00_2
41	102	9	111	21	0	TP	TP_3
42	63	8	71	20	1	OR	
50	52	117	61	129	0	TON	TON_4
59	50	151	59	163	0	TON	TON_5
67	38	97	47	109	1	AND_S	
123	95	34	136	78	0	SF_MutingPar_2Sensor_V1_00	SF_MutingPar_2Sensor_V1_1
124	59	70	68	82	0	TON	TON_6
133	151	51	174	59	1	SAFEBOOL_TO_BOOL	
148	67	203	103	231	0	DoorLock	DoorLock_1

[FPT]
58
10	97	96	108	98	Activate	0	128	0	BOOL
11	97	100	114	102	S_OutControl	0	128	0	SAFEBOOL
12	97	104	108	106	S_EDM1	0	128	0	SAFEBOOL
13	97	108	108	110	S_EDM2	0	128	0	SAFEBOOL
14	97	112	116	114	MonitoringTime	0	128	0	TIME
15	97	116	114	118	S_StartReset	0	128	0	SAFEBOOL
16	97	120	106	122	Reset	0	128	0	BOOL
17	122	96	130	98	Ready	1	0	128	BOOL
18	116	100	130	102	S_EDM_Out	1	0	128	SAFEBOOL
19	123	104	130	106	Error	1	0	128	BOOL
20	118	108	130	110	DiagCode	1	0	128	WORD
34	102	12	107	14	IN	0	129	0	BOOL
35	102	16	107	18	PT	0	128	0	TIME
36	108	12	111	14	Q	1	0	129	BOOL
37	107	16	111	18	ET	1	0	128	TIME
38	63	11	65	13		0	1665	0	ANY_BIT
39	63	15	65	17		0	1665	0	ANY_BIT
40	70	12	71	14		1	0	641	ANY_BIT
46	52	120	57	122	IN	0	129	0	BOOL
47	52	124	57	126	PT	0	128	0	TIME
48	58	120	61	122	Q	1	0	129	BOOL
49	57	124	61	126	ET	1	0	128	TIME
55	50	154	55	156	IN	0	129	0	BOOL
56	50	158	55	160	PT	0	128	0	TIME
57	56	154	59	156	Q	1	0	129	BOOL
58	55	158	59	160	ET	1	0	128	TIME
64	38	100	40	102		0	1665	0	ANY_SAFEBIT
65	38	104	40	106		0	1665	0	ANY_SAFEBIT
66	46	100	47	102		1	0	641	ANY_SAFEBIT
104	95	37	106	39	Activate	0	128	0	BOOL
105	95	41	110	43	S_AOPD_In	0	128	0	SAFEBOOL
106	95	45	118	47	S_MutingSwitch11	0	128	0	SAFEBOOL
107	95	49	118	51	S_MutingSwitch12	0	128	0	SAFEBOOL
108	95	53	113	55	S_MutingLamp	0	128	0	SAFEBOOL
109	95	57	112	59	DiscTimeEntry	0	128	0	TIME
110	95	61	114	63	MaxMutingTime	0	128	0	TIME
111	95	65	112	67	MutingEnable	0	128	0	BOOL
112	95	69	112	71	S_StartReset	0	128	0	SAFEBOOL
113	95	74	104	76	Reset	0	128	0	BOOL
114	128	37	136	39	Ready	1	0	128	BOOL
115	120	41	136	43	S_AOPD_Out	1	0	128	SAFEBOOL
116	118	45	136	47	S_MutingActive	1	0	128	SAFEBOOL
117	129	49	136	51	Error	1	0	128	BOOL
118	124	53	136	55	DiagCode	1	0	128	WORD
119	59	74	64	76	IN	0	129	0	BOOL
120	59	78	64	80	PT	0	128	0	TIME
121	65	74	68	76	Q	1	0	129	BOOL
122	64	78	68	80	ET	1	0	128	TIME
131	151	54	153	56		0	640	0	SAFEBOOL
132	173	54	174	56		1	0	640	BOOL
140	67	206	83	208	ButtonOpen	0	129	0	BOOL
141	67	210	83	212	ButtonClose	0	129	0	BOOL
142	67	214	88	216	S_DoorLocked_In	0	129	0	SAFEBOOL
143	67	218	76	220	EStop	0	129	0	BOOL
144	67	222	89	224	DoorCanBeOpened	0	129	0	BOOL
145	67	226	80	228	TestLamp	0	129	0	BOOL
146	89	206	103	208	UnlockDoor	1	0	129	BOOL
147	90	210	103	212	LightWhite	1	0	129	BOOL

[KOT]
0

[VER]
0

