[LIT]
17
0	179	85	179	91
1	179	91	185	91
2	179	85	185	85
3	99	84	105	84
4	105	84	108	84
5	105	88	108	88
6	105	84	105	88
7	94	123	100	123
8	94	123	94	126
9	94	126	99	126
10	91	12	118	12
11	62	80	108	80
12	179	80	179	85
13	145	80	179	80
14	69	54	104	54
15	80	100	108	100
16	75	123	94	123

[TET]
28
18	185	84	211	86	4	3	doMagazineContactor1
19	185	90	211	92	4	3	doMagazineContactor2
20	92	91	108	93	4	5	TIME#500ms
21	100	75	108	77	4	5	TRUE
22	94	95	108	97	4	5	SAFEFALSE
23	100	122	126	124	4	3	SM6_ReleaseOutput03
24	99	125	125	127	4	3	SM6_ReleaseOutput04
25	24	79	49	81	4	5	allSafetyCircuitsReady
26	81	83	99	85	4	5	diMagazineEDM
27	145	83	166	85	4	3	magazineEdmError
29	96	37	104	39	4	5	TRUE
30	83	41	104	43	4	5	diLightCurtainP11
31	90	45	104	47	4	5	SAFEFALSE
32	90	49	104	51	4	5	SAFEFALSE
34	131	11	158	13	4	3	activateSafetyMagazine
35	101	15	118	17	4	5	TIME#1000ms
36	49	10	79	12	4	5	diActivateAllSafetyCircuits
37	40	99	67	101	4	5	activateSafetyMagazine
38	51	103	67	105	4	5	TIME#200ms
40	50	14	79	16	4	5	diActivateMagazineSafety
41	35	122	62	124	4	5	activateSafetyMagazine
42	46	126	62	128	4	5	TIME#300ms
45	29	53	56	55	4	5	activateSafetyMagazine
46	40	57	56	59	4	5	TIME#100ms
47	140	41	159	43	4	3	lightCurtainP11
48	30	83	49	85	4	5	lightCurtainP11
49	51	144	70	146	4	5	lightCurtainP11
50	97	144	120	146	4	3	lightCurtainP11grey

[FBS]
9
95	110	72	143	104	0	SF_EDM_V1_00	SF_EDM_V1_00_1
96	106	34	138	58	0	SF_ESPE_V1_00	SF_ESPE_V1_00_1
97	120	8	129	20	0	TP	TP_2
98	69	96	78	108	0	TON	TON_2
99	81	7	89	19	1	OR	
100	64	119	73	131	0	TON	TON_3
101	58	50	67	62	0	TON	TON_1
102	51	76	60	88	1	AND_S	
103	72	141	95	149	1	SAFEBOOL_TO_BOOL	

[FPT]
44
51	110	75	121	77	Activate	0	128	0	BOOL
52	110	79	127	81	S_OutControl	0	128	0	SAFEBOOL
53	110	83	121	85	S_EDM1	0	128	0	SAFEBOOL
54	110	87	121	89	S_EDM2	0	128	0	SAFEBOOL
55	110	91	129	93	MonitoringTime	0	128	0	TIME
56	110	95	127	97	S_StartReset	0	128	0	SAFEBOOL
57	110	99	119	101	Reset	0	128	0	BOOL
58	135	75	143	77	Ready	1	0	128	BOOL
59	129	79	143	81	S_EDM_Out	1	0	128	SAFEBOOL
60	136	83	143	85	Error	1	0	128	BOOL
61	131	87	143	89	DiagCode	1	0	128	WORD
62	106	37	117	39	Activate	0	128	0	BOOL
63	106	41	120	43	S_ESPE_In	0	128	0	SAFEBOOL
64	106	45	123	47	S_StartReset	0	128	0	SAFEBOOL
65	106	49	123	51	S_AutoReset	0	128	0	SAFEBOOL
66	106	53	115	55	Reset	0	128	0	BOOL
67	130	37	138	39	Ready	1	0	128	BOOL
68	123	41	138	43	S_ESPE_Out	1	0	128	SAFEBOOL
69	131	45	138	47	Error	1	0	128	BOOL
70	126	49	138	51	DiagCode	1	0	128	WORD
71	120	11	125	13	IN	0	129	0	BOOL
72	120	15	125	17	PT	0	128	0	TIME
73	126	11	129	13	Q	1	0	129	BOOL
74	125	15	129	17	ET	1	0	128	TIME
75	69	99	74	101	IN	0	129	0	BOOL
76	69	103	74	105	PT	0	128	0	TIME
77	75	99	78	101	Q	1	0	129	BOOL
78	74	103	78	105	ET	1	0	128	TIME
79	81	10	83	12		0	1665	0	ANY_BIT
80	81	14	83	16		0	1665	0	ANY_BIT
81	88	11	89	13		1	0	641	ANY_BIT
82	64	122	69	124	IN	0	129	0	BOOL
83	64	126	69	128	PT	0	128	0	TIME
84	70	122	73	124	Q	1	0	129	BOOL
85	69	126	73	128	ET	1	0	128	TIME
86	58	53	63	55	IN	0	129	0	BOOL
87	58	57	63	59	PT	0	128	0	TIME
88	64	53	67	55	Q	1	0	129	BOOL
89	63	57	67	59	ET	1	0	128	TIME
90	51	79	53	81		0	1665	0	ANY_SAFEBIT
91	51	83	53	85		0	1665	0	ANY_SAFEBIT
92	59	79	60	81		1	0	641	ANY_SAFEBIT
93	72	144	74	146		0	640	0	SAFEBOOL
94	94	144	95	146		1	0	640	BOOL

[KOT]
0

[VER]
0

