[LIT]
43
0	165	101	165	107
10	86	105	94	105
11	94	105	95	105
12	94	105	94	109
13	94	109	95	109
15	73	13	100	13
38	63	121	95	121
47	61	155	88	155
48	88	155	94	155
49	88	155	88	162
50	88	162	93	162
56	165	107	170	107
57	165	107	165	115
58	165	115	172	115
60	165	122	170	122
61	165	115	165	122
63	165	122	165	128
64	165	101	170	101
65	132	101	165	101
67	88	162	88	170
69	88	178	95	178
70	88	170	88	178
72	88	186	95	186
73	88	178	88	186
74	88	170	94	170
110	70	75	93	75
111	48	79	57	79
112	48	75	57	75
118	138	42	145	42
119	194	42	195	42
120	145	42	145	37
121	145	37	152	37
122	145	42	167	42
123	86	217	100	217
137	165	128	171	128
151	44	217	59	217
152	64	101	95	101
153	43	96	47	96
154	47	96	47	101
155	47	101	51	101
162	40	106	49	106
163	49	106	49	105
164	49	105	51	105

[TET]
44
1	170	100	199	102	4	3	doPalletizationContactor1
2	170	106	199	108	4	3	doPalletizationContactor2
3	79	112	95	114	4	5	TIME#500ms
4	87	96	95	98	4	5	TRUE
5	81	116	95	118	4	5	SAFEFALSE
6	94	154	120	156	4	3	SM6_ReleaseOutput01
7	93	161	119	163	4	3	SM6_ReleaseOutput02
8	18	95	43	97	4	5	allSafetyCircuitsReady
9	65	104	86	106	4	5	diPalletizationEDM
14	132	104	156	106	4	3	palletizationEdmError
17	113	12	143	14	4	3	activateSafetyPalletization
18	83	16	100	18	4	5	TIME#1000ms
19	31	11	61	13	4	5	diActivateAllSafetyCircuits
20	32	15	61	17	4	5	diActivateMagazineSafety
31	20	120	50	122	4	5	activateSafetyPalletization
32	34	124	50	126	4	5	TIME#200ms
39	18	154	48	156	4	5	activateSafetyPalletization
40	32	158	48	160	4	5	TIME#300ms
55	172	114	182	116	4	3	doFI14
59	170	121	180	123	4	3	doFI15
62	171	127	181	129	4	3	doFI16
66	94	169	120	171	4	3	SM3_ReleaseOutput01
68	95	177	121	179	4	3	SM3_ReleaseOutput02
71	95	185	121	187	4	3	SM3_ReleaseOutput03
77	85	37	93	39	4	5	TRUE
78	79	69	93	71	4	5	SAFEFALSE
79	80	53	93	55	4	5	SAFETRUE
80	82	57	93	59	4	5	TIME#1s
81	80	61	93	63	4	5	TIME#10s
82	63	45	93	47	4	5	diLightCurtainP15muting1
83	85	65	93	67	4	5	TRUE
84	63	49	93	51	4	5	diLightCurtainP15muting2
85	72	41	93	43	4	5	diLightCurtainP15
87	18	74	48	76	4	5	activateSafetyPalletization
88	32	78	48	80	4	5	TIME#100ms
113	152	36	171	38	4	3	lightCurtainP15
114	195	41	218	43	4	3	lightCurtainP15grey
124	113	216	139	218	4	3	SM7_ReleaseOutput03
126	85	220	100	222	4	5	TIME#50ms
135	22	216	44	218	4	5	doMutingLampP15
136	138	45	160	47	4	3	doMutingLampP15
160	9	105	28	107	4	5	lightCurtainP15
161	11	109	28	111	4	5	diOverrideP15
166	15	113	28	115	4	5	SAFETRUE

[FBS]
12
28	102	9	111	21	0	TP	TP_3
29	63	8	71	20	1	OR	
37	52	117	61	129	0	TON	TON_4
46	50	151	59	163	0	TON	TON_5
54	53	97	62	109	1	AND_S	
108	95	34	136	78	0	SF_MutingPar_2Sensor_V1_00	SF_MutingPar_2Sensor_V1_1
109	59	70	68	82	0	TON	TON_6
117	169	38	192	46	1	SAFEBOOL_TO_BOOL	
133	102	213	111	225	0	TON	TON_7
134	61	213	84	221	1	SAFEBOOL_TO_BOOL	
150	97	93	130	125	0	SF_EDM_V1_00	SF_EDM_V1_00_2
159	30	102	38	118	1	OR_S	

[FPT]
60
21	102	12	107	14	IN	0	129	0	BOOL
22	102	16	107	18	PT	0	128	0	TIME
23	108	12	111	14	Q	1	0	129	BOOL
24	107	16	111	18	ET	1	0	128	TIME
25	63	11	65	13		0	1665	0	ANY_BIT
26	63	15	65	17		0	1665	0	ANY_BIT
27	70	12	71	14		1	0	641	ANY_BIT
33	52	120	57	122	IN	0	129	0	BOOL
34	52	124	57	126	PT	0	128	0	TIME
35	58	120	61	122	Q	1	0	129	BOOL
36	57	124	61	126	ET	1	0	128	TIME
42	50	154	55	156	IN	0	129	0	BOOL
43	50	158	55	160	PT	0	128	0	TIME
44	56	154	59	156	Q	1	0	129	BOOL
45	55	158	59	160	ET	1	0	128	TIME
51	53	100	55	102		0	1665	0	ANY_SAFEBIT
52	53	104	55	106		0	1665	0	ANY_SAFEBIT
53	61	100	62	102		1	0	641	ANY_SAFEBIT
89	95	37	106	39	Activate	0	128	0	BOOL
90	95	41	110	43	S_AOPD_In	0	128	0	SAFEBOOL
91	95	45	118	47	S_MutingSwitch11	0	128	0	SAFEBOOL
92	95	49	118	51	S_MutingSwitch12	0	128	0	SAFEBOOL
93	95	53	113	55	S_MutingLamp	0	128	0	SAFEBOOL
94	95	57	112	59	DiscTimeEntry	0	128	0	TIME
95	95	61	114	63	MaxMutingTime	0	128	0	TIME
96	95	65	112	67	MutingEnable	0	128	0	BOOL
97	95	69	112	71	S_StartReset	0	128	0	SAFEBOOL
98	95	74	104	76	Reset	0	128	0	BOOL
99	128	37	136	39	Ready	1	0	128	BOOL
100	120	41	136	43	S_AOPD_Out	1	0	128	SAFEBOOL
101	118	45	136	47	S_MutingActive	1	0	128	SAFEBOOL
102	129	49	136	51	Error	1	0	128	BOOL
103	124	53	136	55	DiagCode	1	0	128	WORD
104	59	74	64	76	IN	0	129	0	BOOL
105	59	78	64	80	PT	0	128	0	TIME
106	65	74	68	76	Q	1	0	129	BOOL
107	64	78	68	80	ET	1	0	128	TIME
115	169	41	171	43		0	640	0	SAFEBOOL
116	191	41	192	43		1	0	640	BOOL
127	102	216	107	218	IN	0	129	0	BOOL
128	102	220	107	222	PT	0	128	0	TIME
129	108	216	111	218	Q	1	0	129	BOOL
130	107	220	111	222	ET	1	0	128	TIME
131	61	216	63	218		0	640	0	SAFEBOOL
132	83	216	84	218		1	0	640	BOOL
139	97	96	108	98	Activate	0	128	0	BOOL
140	97	100	114	102	S_OutControl	0	128	0	SAFEBOOL
141	97	104	108	106	S_EDM1	0	128	0	SAFEBOOL
142	97	108	108	110	S_EDM2	0	128	0	SAFEBOOL
143	97	112	116	114	MonitoringTime	0	128	0	TIME
144	97	116	114	118	S_StartReset	0	128	0	SAFEBOOL
145	97	120	106	122	Reset	0	128	0	BOOL
146	122	96	130	98	Ready	1	0	128	BOOL
147	116	100	130	102	S_EDM_Out	1	0	128	SAFEBOOL
148	123	104	130	106	Error	1	0	128	BOOL
149	118	108	130	110	DiagCode	1	0	128	WORD
156	30	105	32	107		0	1665	0	ANY_SAFEBIT
157	30	109	32	111		0	1665	0	ANY_SAFEBIT
158	37	105	38	107		1	0	643	ANY_SAFEBIT
165	30	113	32	115		0	1665	0	ANY_SAFEBIT

[KOT]
0

[VER]
0

