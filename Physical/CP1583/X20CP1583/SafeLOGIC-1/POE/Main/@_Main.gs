[LIT]
31
55	43	71	100	71
65	115	165	115	171
66	115	171	121	171
88	115	165	121	165
100	48	199	69	199
101	69	199	69	206
102	69	199	74	199
103	69	206	73	206
105	35	169	41	169
106	41	169	44	169
107	41	173	44	173
108	41	169	41	173
110	81	165	115	165
127	43	223	56	223
130	130	365	130	371
131	130	371	136	371
132	130	365	136	365
133	65	399	86	399
134	86	399	86	406
135	86	399	91	399
136	86	406	90	406
169	52	369	60	369
170	60	369	61	369
171	60	369	60	373
172	60	373	61	373
174	98	365	130	365
178	101	227	112	227
179	112	227	112	232
180	112	232	116	232
181	112	227	116	227
182	101	223	111	223
[TET]
60
12	24	109	49	111	4	5	allSafetyCircuitsReady
13	76	109	104	111	4	3	allSafetyCircuitsReadyNS
14	18	70	30	72	4	5	diEStop1
15	18	74	30	76	4	5	diEStop2
16	18	78	30	80	4	5	diEStop3
17	18	82	30	84	4	5	diEStop4
18	18	86	30	88	4	5	diEStop5
19	13	90	30	92	4	5	diEStopRobot
20	11	94	30	96	4	5	diEStopWrapper
32	92	66	100	68	4	5	TRUE
33	86	74	100	76	4	5	SAFEFALSE
34	86	78	100	80	4	5	SAFEFALSE
35	83	82	100	84	4	5	activateSafety
36	136	70	161	72	4	3	allSafetyCircuitsReady
38	49	7	66	9	4	3	activateSafety
39	19	11	36	13	4	5	TIME#1000ms
40	6	7	36	9	4	5	diActivateAllSafetyCircuits
42	13	26	30	28	4	5	activateSafety
43	14	30	30	32	4	5	TIME#100ms
44	43	26	68	28	4	3	activateSafetyDelayed
56	14	45	31	47	4	5	activateSafety
57	15	49	31	51	4	5	TIME#200ms
58	44	45	71	47	4	3	activateSafetyDelayed2
68	121	164	147	166	4	3	doMagazineContactor1
69	121	170	147	172	4	3	doMagazineContactor2
70	28	176	44	178	4	5	TIME#250ms
71	36	160	44	162	4	5	TRUE
84	30	180	44	182	4	5	SAFEFALSE
85	19	184	44	186	4	5	activateSafetyDelayed
86	74	198	100	200	4	3	SM6_ReleaseOutput03
87	73	205	99	207	4	3	SM6_ReleaseOutput04
89	9	164	44	166	4	5	pallet_mag_safetyCircuitsReady
90	54	120	89	122	4	3	pallet_mag_safetyCircuitsReady
91	28	124	41	126	4	5	SAFETRUE
92	28	128	41	130	4	5	SAFETRUE
93	16	120	41	122	4	5	allSafetyCircuitsReady
99	21	198	48	200	4	5	activateSafetyDelayed2
104	17	168	35	170	4	5	diMagazineEDM
109	81	168	102	170	4	3	magazineEdmError
126	25	222	43	224	4	5	diDoor1opened
128	48	218	56	220	4	5	TRUE
129	111	222	126	224	4	3	door1locked
138	136	364	165	366	4	3	doPalletizationContactor1
139	136	370	165	372	4	3	doPalletizationContactor2
140	45	376	61	378	4	5	TIME#250ms
141	53	360	61	362	4	5	TRUE
142	47	380	61	382	4	5	SAFEFALSE
143	36	384	61	386	4	5	activateSafetyDelayed
144	91	398	117	400	4	3	SM6_ReleaseOutput01
145	90	405	116	407	4	3	SM6_ReleaseOutput02
146	32	364	61	366	4	5	palletization_safetyReady
147	71	320	100	322	4	3	palletization_safetyReady
148	45	328	58	330	4	5	SAFETRUE
149	33	320	58	322	4	5	allSafetyCircuitsReady
150	38	398	65	400	4	5	activateSafetyDelayed2
168	31	368	52	370	4	5	diPalletizationEDM
173	98	368	122	370	4	3	palletizationEdmError
175	43	324	58	326	4	5	door1locked
176	116	226	134	228	4	3	doUnlockDoor1
177	116	231	134	233	4	3	doUnlockDoor2
[FBS]
11
3	32	67	41	99	1	AND_S	
11	51	106	74	114	1	SAFEBOOL_TO_BOOL	
30	102	63	134	87	0	SF_EmergencyStop_V1_00	SF_EmergencyStop_V1_00_1
53	38	4	47	16	0	TP	TP_1
54	32	23	41	35	0	TON	TON_1
64	33	42	42	54	0	TON	TON_2
83	46	157	79	189	0	SF_EDM_V1_00	SF_EDM_V1_00_1
98	43	117	52	149	1	AND_S	
124	58	215	99	251	0	SF_GuardLocking_V1_00	SF_GuardLocking_V1_00_1
166	63	357	96	389	0	SF_EDM_V1_00	SF_EDM_V1_00_2
167	60	317	69	349	1	AND_S	
[FPT]
74
0	32	70	34	72		0	1665	0	ANY_SAFEBIT	
1	32	74	34	76		0	1665	0	ANY_SAFEBIT	
2	40	70	41	72		1	0	641	ANY_SAFEBIT	
4	32	78	34	80		0	1665	0	ANY_SAFEBIT	
5	32	82	34	84		0	1665	0	ANY_SAFEBIT	
6	32	86	34	88		0	1665	0	ANY_SAFEBIT	
7	32	90	34	92		0	1665	0	ANY_SAFEBIT	
8	32	94	34	96		0	1665	0	ANY_SAFEBIT	
9	51	109	53	111		0	640	0	SAFEBOOL	
10	73	109	74	111		1	0	640	BOOL	
21	102	66	113	68	Activate	0	128	0	BOOL	
22	102	70	116	72	S_EStopIn	0	128	0	SAFEBOOL	
23	102	74	119	76	S_StartReset	0	128	0	SAFEBOOL	
24	102	78	119	80	S_AutoReset	0	128	0	SAFEBOOL	
25	102	82	111	84	Reset	0	128	0	BOOL	
26	126	66	134	68	Ready	1	0	128	BOOL	
27	119	70	134	72	S_EStopOut	1	0	128	SAFEBOOL	
28	127	74	134	76	Error	1	0	128	BOOL	
29	122	78	134	80	DiagCode	1	0	128	WORD	
45	38	7	43	9	IN	0	129	0	BOOL	
46	38	11	43	13	PT	0	128	0	TIME	
47	44	7	47	9	Q	1	0	129	BOOL	
48	43	11	47	13	ET	1	0	128	TIME	
49	32	26	37	28	IN	0	129	0	BOOL	
50	32	30	37	32	PT	0	128	0	TIME	
51	38	26	41	28	Q	1	0	129	BOOL	
52	37	30	41	32	ET	1	0	128	TIME	
60	33	45	38	47	IN	0	129	0	BOOL	
61	33	49	38	51	PT	0	128	0	TIME	
62	39	45	42	47	Q	1	0	129	BOOL	
63	38	49	42	51	ET	1	0	128	TIME	
72	46	160	57	162	Activate	0	128	0	BOOL	
73	46	164	63	166	S_OutControl	0	128	0	SAFEBOOL	
74	46	168	57	170	S_EDM1	0	128	0	SAFEBOOL	
75	46	172	57	174	S_EDM2	0	128	0	SAFEBOOL	
76	46	176	65	178	MonitoringTime	0	128	0	TIME	
77	46	180	63	182	S_StartReset	0	128	0	SAFEBOOL	
78	46	184	55	186	Reset	0	128	0	BOOL	
79	71	160	79	162	Ready	1	0	128	BOOL	
80	65	164	79	166	S_EDM_Out	1	0	128	SAFEBOOL	
81	72	168	79	170	Error	1	0	128	BOOL	
82	67	172	79	174	DiagCode	1	0	128	WORD	
94	43	120	45	122		0	1665	0	ANY_SAFEBIT	
95	43	124	45	126		0	1665	0	ANY_SAFEBIT	
96	51	120	52	122		1	0	643	ANY_SAFEBIT	
97	43	128	45	130		0	1665	0	ANY_SAFEBIT	
111	58	218	69	220	Activate	0	128	0	BOOL	
112	58	222	81	224	S_GuardMonitoring	0	128	0	SAFEBOOL	
113	58	226	77	228	S_SafetyActive	0	128	0	SAFEBOOL	
114	58	230	74	232	S_GuardLock	0	128	0	SAFEBOOL	
115	58	234	76	236	UnlockRequest	0	128	0	BOOL	
116	58	238	75	240	S_StartReset	0	128	0	SAFEBOOL	
117	58	242	75	244	S_AutoReset	0	128	0	SAFEBOOL	
118	58	246	67	248	Reset	0	128	0	BOOL	
119	91	218	99	220	Ready	1	0	128	BOOL	
120	81	222	99	224	S_GuardLocked	1	0	128	SAFEBOOL	
121	82	226	99	228	S_UnlockGuard	1	0	128	SAFEBOOL	
122	92	230	99	232	Error	1	0	128	BOOL	
123	87	234	99	236	DiagCode	1	0	128	WORD	
151	63	360	74	362	Activate	0	128	0	BOOL	
152	63	364	80	366	S_OutControl	0	128	0	SAFEBOOL	
153	63	368	74	370	S_EDM1	0	128	0	SAFEBOOL	
154	63	372	74	374	S_EDM2	0	128	0	SAFEBOOL	
155	63	376	82	378	MonitoringTime	0	128	0	TIME	
156	63	380	80	382	S_StartReset	0	128	0	SAFEBOOL	
157	63	384	72	386	Reset	0	128	0	BOOL	
158	88	360	96	362	Ready	1	0	128	BOOL	
159	82	364	96	366	S_EDM_Out	1	0	128	SAFEBOOL	
160	89	368	96	370	Error	1	0	128	BOOL	
161	84	372	96	374	DiagCode	1	0	128	WORD	
162	60	320	62	322		0	1665	0	ANY_SAFEBIT	
163	60	324	62	326		0	1665	0	ANY_SAFEBIT	
164	68	320	69	322		1	0	643	ANY_SAFEBIT	
165	60	328	62	330		0	1665	0	ANY_SAFEBIT	
[KOT]
0
[VER]
0
