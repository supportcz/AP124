[LIT]
154
45	145	26	150	26
46	147	22	150	22
47	91	30	116	30
48	39	18	150	18
49	129	30	150	30
50	179	132	179	138
51	179	138	185	138
52	179	132	185	132
53	99	131	105	131
54	105	131	108	131
55	105	135	108	135
56	105	131	105	135
57	94	170	100	170
58	94	170	94	173
59	94	173	99	173
60	91	59	118	59
61	62	127	108	127
62	179	127	179	132
63	145	127	179	127
64	69	101	104	101
65	80	147	108	147
66	75	170	94	170
154	187	348	187	354
164	108	352	116	352
165	116	352	117	352
166	116	352	116	356
167	116	356	117	356
169	73	210	100	210
200	76	486	103	486
201	103	486	109	486
202	103	486	103	493
203	103	493	108	493
209	187	354	192	354
210	187	354	187	362
211	187	362	194	362
213	187	369	192	369
214	187	362	187	369
216	187	369	187	375
217	187	348	192	348
218	154	348	187	348
220	103	493	103	501
222	103	509	110	509
223	103	501	103	509
225	103	517	110	517
226	103	509	103	517
227	103	501	109	501
259	83	239	90	239
260	139	239	140	239
261	90	239	90	234
262	90	234	97	234
263	90	239	112	239
264	101	563	115	563
278	187	375	193	375
292	59	563	74	563
322	40	300	85	300
339	93	395	93	384
340	95	395	95	421
341	95	421	119	421
346	156	405	160	405
349	156	401	189	401
350	189	401	194	401
351	189	401	189	409
352	189	409	194	409
353	114	405	116	405
354	116	405	119	405
355	116	405	116	409
356	116	409	119	409
359	103	517	103	526
360	103	526	111	526
361	103	526	103	533
362	103	533	110	533
381	191	444	191	449
382	191	449	194	449
383	191	444	194	444
384	156	444	191	444
386	95	421	95	464
387	95	464	119	464
389	117	448	118	448
390	118	448	119	448
391	118	452	119	452
392	118	448	118	452
394	103	540	110	540
395	103	533	103	540
397	103	547	111	547
398	103	540	103	547
400	52	395	93	395
401	105	368	117	368
402	93	395	95	395
403	105	384	105	368
404	93	384	105	384
405	83	348	117	348
411	34	363	51	363
412	64	363	68	363
413	68	363	68	352
414	68	352	70	352
415	34	348	70	348
416	68	363	70	363
417	70	363	70	444
418	70	444	119	444
428	166	692	166	698
429	166	698	171	698
430	166	692	171	692
431	133	692	166	692
465	78	603	85	603
466	134	603	135	603
467	85	603	85	598
468	85	598	92	598
469	85	603	107	603
504	90	696	96	696
505	90	700	96	700
506	90	696	90	700
507	105	830	119	830
529	84	791	105	791
530	105	791	116	791
531	105	791	105	799
532	105	799	115	799
533	29	619	33	619
539	81	722	81	712
540	81	712	96	712
543	42	697	42	696
544	42	696	50	696
547	41	689	42	689
548	42	689	42	692
549	42	692	50	692
550	33	697	42	697
585	165	745	165	744
586	165	744	167	744
587	133	745	163	745
588	163	745	165	745
589	163	745	163	751
590	163	751	167	751
591	88	696	90	696
592	68	745	96	745
593	63	692	68	692
594	68	692	96	692
595	68	692	68	745
596	60	722	81	722
597	60	737	60	765
598	60	765	96	765
602	92	749	94	749
603	94	749	96	749
604	94	749	94	753
605	94	753	96	753
608	105	799	104	799
609	104	799	104	806
610	104	806	105	806
611	105	806	116	806
612	105	806	105	813
613	105	813	118	813
615	60	737	60	722
616	50	737	60	737
626	37	716	48	716
627	48	716	48	704
628	48	704	50	704
[TET]
168
9	14	17	26	19	4	5	diEStop1
10	14	21	26	23	4	5	diEStop2
11	14	25	26	27	4	5	diEStop3
12	14	29	26	31	4	5	diEStop4
13	14	33	26	35	4	5	diEStop5
14	9	37	26	39	4	5	diEStopRobot
15	7	41	26	43	4	5	diEStopWrapper
27	142	13	150	15	4	5	TRUE
28	133	21	147	23	4	5	SAFEFALSE
29	131	25	145	27	4	5	SAFEFALSE
30	186	17	207	19	4	3	allEStopsReleased
32	99	33	116	35	4	5	TIME#1000ms
33	49	28	79	30	4	5	diActivateAllSafetyCircuits
39	186	13	200	15	4	3	safetyAlive
40	50	32	79	34	4	5	diActivateMagazineSafety
68	185	131	211	133	4	3	doMagazineContactor1
69	185	137	211	139	4	3	doMagazineContactor2
70	92	138	108	140	4	5	TIME#500ms
71	100	122	108	124	4	5	TRUE
72	94	142	108	144	4	5	SAFEFALSE
73	100	169	126	171	4	3	SM6_ReleaseOutput03
74	99	172	125	174	4	3	SM6_ReleaseOutput04
75	28	126	49	128	4	5	allEStopsReleased
76	81	130	99	132	4	5	diMagazineEDM
77	145	130	166	132	4	3	magazineEdmError
79	96	84	104	86	4	5	TRUE
80	83	88	104	90	4	5	diLightCurtainP11
81	90	92	104	94	4	5	SAFEFALSE
82	90	96	104	98	4	5	SAFEFALSE
84	131	58	158	60	4	3	activateSafetyMagazine
85	101	62	118	64	4	5	TIME#1000ms
86	49	57	79	59	4	5	diActivateAllSafetyCircuits
87	40	146	67	148	4	5	activateSafetyMagazine
88	51	150	67	152	4	5	TIME#200ms
90	50	61	79	63	4	5	diActivateMagazineSafety
91	35	169	62	171	4	5	activateSafetyMagazine
92	46	173	62	175	4	5	TIME#300ms
95	29	100	56	102	4	5	activateSafetyMagazine
96	40	104	56	106	4	5	TIME#100ms
97	140	88	159	90	4	3	lightCurtainP11
98	30	130	49	132	4	5	lightCurtainP11
99	51	191	70	193	4	5	lightCurtainP11
100	97	191	120	193	4	3	lightCurtainP11grey
155	192	347	221	349	4	3	doPalletizationContactor1
156	192	353	221	355	4	3	doPalletizationContactor2
157	101	359	117	361	4	5	TIME#500ms
158	109	343	117	345	4	5	TRUE
159	103	363	117	365	4	5	SAFEFALSE
160	109	485	135	487	4	3	SM6_ReleaseOutput01
161	108	492	134	494	4	3	SM6_ReleaseOutput02
162	13	347	34	349	4	5	allEStopsReleased
163	87	351	108	353	4	5	diPalletizationEDM
168	154	351	178	353	4	3	palletizationEdmError
171	113	209	143	211	4	3	activateSafetyPalletization
172	83	213	100	215	4	5	TIME#1000ms
173	31	208	61	210	4	5	diActivateAllSafetyCircuits
174	32	212	61	214	4	5	diActivateMagazineSafety
185	9	394	39	396	4	5	activateSafetyPalletization
186	23	398	39	400	4	5	TIME#100ms
192	33	485	63	487	4	5	activateSafetyPalletization
193	47	489	63	491	4	5	TIME#200ms
208	194	361	204	363	4	3	doFI14
212	192	368	202	370	4	3	doFI15
215	193	374	203	376	4	3	doFI16
219	109	500	135	502	4	3	SM3_ReleaseOutput01
221	110	508	136	510	4	3	SM3_ReleaseOutput02
224	110	516	136	518	4	3	SM3_ReleaseOutput03
229	30	234	38	236	4	5	TRUE
230	24	266	38	268	4	5	SAFEFALSE
231	25	250	38	252	4	5	SAFETRUE
232	27	254	38	256	4	5	TIME#2s
233	25	258	38	260	4	5	TIME#12s
234	8	242	38	244	4	5	diLightCurtainP15muting1
235	30	262	38	264	4	5	TRUE
236	8	246	38	248	4	5	diLightCurtainP15muting2
237	17	238	38	240	4	5	diLightCurtainP15
254	97	233	116	235	4	3	lightCurtainP15
255	140	238	163	240	4	3	lightCurtainP15grey
265	128	562	154	564	4	3	SM7_ReleaseOutput03
267	100	566	115	568	4	5	TIME#50ms
276	37	562	59	564	4	5	doMutingLampP15
277	83	242	105	244	4	3	doMutingLampP15
297	3	362	22	364	4	5	lightCurtainP15
298	5	366	22	368	4	5	diOverrideP15
300	8	370	22	372	4	5	SAFEFALSE
301	10	299	27	301	4	5	diDoor1locked
302	10	303	27	305	4	5	diDoor3locked
304	121	299	138	301	4	3	door13locked
305	77	295	85	297	4	5	TRUE
306	71	303	85	305	4	5	SAFEFALSE
307	71	307	85	309	4	5	SAFEFALSE
323	55	311	85	313	4	5	activateSafetyPalletization
324	8	271	38	273	4	5	activateSafetyPalletization
338	111	396	119	398	4	5	TRUE
342	103	412	119	414	4	5	TIME#500ms
343	105	416	119	418	4	5	SAFEFALSE
344	99	404	114	406	4	5	diRobotEDM
345	160	404	178	406	4	3	robotEdmError
347	194	400	217	402	4	3	doRobotContactor1
348	194	408	217	410	4	3	doRobotContactor2
357	111	525	137	527	4	3	SM4_ReleaseOutput01
358	110	532	136	534	4	3	SM4_ReleaseOutput02
376	111	439	119	441	4	5	TRUE
377	103	455	119	457	4	5	TIME#500ms
378	105	459	119	461	4	5	SAFEFALSE
379	194	443	212	445	4	3	doRobotDoor1
380	194	448	212	450	4	3	doRobotDoor2
385	156	447	179	449	4	3	robotDoorEdmError
388	97	447	117	449	4	5	diRobotDoorEDM
393	110	539	136	541	4	3	SM4_ReleaseOutput03
396	111	546	137	548	4	3	SM4_ReleaseOutput04
399	98	400	119	402	4	5	allEStopsReleased
410	34	366	51	368	4	5	door13locked
419	82	579	108	581	4	3	activateSafetyOutfeed
420	52	583	69	585	4	5	TIME#1000ms
421	39	579	69	581	4	5	diActivateAllSafetyCircuits
433	171	691	196	693	4	3	doOutfeedContactor1
434	171	697	196	699	4	3	doOutfeedContactor2
435	80	703	96	705	4	5	TIME#500ms
436	88	687	96	689	4	5	TRUE
437	82	707	96	709	4	5	SAFEFALSE
438	20	688	41	690	4	5	allEStopsReleased
439	133	695	153	697	4	3	outfeedEdmError
441	11	736	37	738	4	5	activateSafetyOutfeed
442	21	740	37	742	4	5	TIME#100ms
443	2	696	21	698	4	5	lightCurtainP17
470	25	598	33	600	4	5	TRUE
471	19	630	33	632	4	5	SAFEFALSE
472	20	614	33	616	4	5	SAFETRUE
473	18	618	29	620	4	5	TIME#2s
474	20	622	33	624	4	5	TIME#12s
475	25	626	33	628	4	5	TRUE
476	3	610	33	612	4	5	diLightCurtainP17muting2
477	7	635	33	637	4	5	activateSafetyOutfeed
478	92	597	111	599	4	3	lightCurtainP17
479	135	602	158	604	4	3	lightCurtainP17grey
480	78	606	100	608	4	3	doMutingLampP17
501	12	602	33	604	4	5	diLightCurtainP17
502	3	606	33	608	4	5	diLightCurtainP17muting1
503	71	695	88	697	4	5	diOutfeedEDM
508	45	790	71	792	4	5	activateSafetyOutfeed
509	55	794	71	796	4	5	TIME#200ms
512	104	833	119	835	4	5	TIME#50ms
513	56	829	78	831	4	5	doMutingLampP17
527	116	790	142	792	4	3	SM7_ReleaseOutput01
528	115	798	141	800	4	3	SM7_ReleaseOutput02
534	132	829	158	831	4	3	SM7_ReleaseOutput04
542	4	700	21	702	4	5	diOverrideP17
545	7	704	21	706	4	5	SAFEFALSE
551	35	699	50	701	4	5	door2locked
552	19	656	36	658	4	5	diDoor2locked
554	72	656	87	658	4	3	door2locked
555	28	652	36	654	4	5	TRUE
556	22	660	36	662	4	5	SAFEFALSE
557	22	664	36	666	4	5	SAFEFALSE
558	10	668	36	670	4	5	activateSafetyOutfeed
569	167	750	193	752	4	3	doWrapperContactor2
583	88	740	96	742	4	5	TRUE
584	167	743	193	745	4	3	doWrapperContactor1
599	82	760	96	762	4	5	SAFEFALSE
600	80	756	96	758	4	5	TIME#500ms
601	74	748	92	750	4	5	diWrapperEDM
606	116	805	142	807	4	3	SM5_ReleaseOutput01
607	118	812	144	814	4	3	SM5_ReleaseOutput02
614	133	748	153	750	4	3	wrapperEdmError
618	6	715	25	717	4	5	lightCurtainP15
619	8	719	25	721	4	5	diOverrideP15
620	11	723	25	725	4	5	SAFEFALSE
[FBS]
42
3	28	14	37	46	1	AND_S	
25	152	10	184	34	0	SF_EmergencyStop_V1_00	SF_EmergencyStop_V1_00_1
38	118	26	127	38	0	TP	TP_1
44	81	25	89	37	1	OR	
145	110	119	143	151	0	SF_EDM_V1_00	SF_EDM_V1_00_1
146	106	81	138	105	0	SF_ESPE_V1_00	SF_ESPE_V1_00_1
147	120	55	129	67	0	TP	TP_2
148	69	143	78	155	0	TON	TON_2
149	81	54	89	66	1	OR	
150	64	166	73	178	0	TON	TON_3
151	58	97	67	109	0	TON	TON_1
152	51	123	60	139	1	AND_S	
153	72	188	95	196	1	SAFEBOOL_TO_BOOL	
182	102	206	111	218	0	TP	TP_3
183	63	205	71	217	1	OR	
191	41	391	50	403	0	TON	TON_4
199	65	482	74	494	0	TON	TON_5
207	72	344	81	360	1	AND_S	
253	40	231	81	275	0	SF_MutingPar_2Sensor_V1_00	SF_MutingPar_2Sensor_V1_1
258	114	235	137	243	1	SAFEBOOL_TO_BOOL	
274	117	559	126	571	0	TON	TON_7
275	76	559	99	567	1	SAFEBOOL_TO_BOOL	
291	119	340	152	372	0	SF_EDM_V1_00	SF_EDM_V1_00_2
296	24	359	32	375	1	OR_S	
320	29	296	38	312	1	AND_S	
321	87	292	119	316	0	SF_ESPE_V1_00	SF_ESPE_V1_00_2
336	121	393	154	425	0	SF_EDM_V1_00	SF_EDM_V1_00_5
374	121	436	154	468	0	SF_EDM_V1_00	SF_EDM_V1_00_6
409	53	359	62	371	1	AND_S	
427	71	576	80	588	0	TP	TP_4
462	98	684	131	716	0	SF_EDM_V1_00	SF_EDM_V1_00_3
463	39	733	48	745	0	TON	TON_8
464	52	688	61	708	1	AND_S	
483	109	599	132	607	1	SAFEBOOL_TO_BOOL	
500	35	595	76	639	0	SF_MutingPar_2Sensor_V1_00	SF_MutingPar_2Sensor_V1_2
524	73	787	82	799	0	TON	TON_10
525	121	826	130	838	0	TON	TON_11
526	80	826	103	834	1	SAFEBOOL_TO_BOOL	
538	23	693	31	709	1	OR_S	
568	38	649	70	673	0	SF_ESPE_V1_00	SF_ESPE_V1_00_3
581	98	737	131	769	0	SF_EDM_V1_00	SF_EDM_V1_00_4
625	27	712	35	728	1	OR_S	
[FPT]
240
0	28	17	30	19		0	1665	0	ANY_SAFEBIT	
1	28	21	30	23		0	1665	0	ANY_SAFEBIT	
2	36	17	37	19		1	0	641	ANY_SAFEBIT	
4	28	25	30	27		0	1665	0	ANY_SAFEBIT	
5	28	29	30	31		0	1665	0	ANY_SAFEBIT	
6	28	33	30	35		0	1665	0	ANY_SAFEBIT	
7	28	37	30	39		0	1665	0	ANY_SAFEBIT	
8	28	41	30	43		0	1665	0	ANY_SAFEBIT	
16	152	13	163	15	Activate	0	128	0	BOOL	
17	152	17	166	19	S_EStopIn	0	128	0	SAFEBOOL	
18	152	21	169	23	S_StartReset	0	128	0	SAFEBOOL	
19	152	25	169	27	S_AutoReset	0	128	0	SAFEBOOL	
20	152	29	161	31	Reset	0	128	0	BOOL	
21	176	13	184	15	Ready	1	0	128	BOOL	
22	169	17	184	19	S_EStopOut	1	0	128	SAFEBOOL	
23	177	21	184	23	Error	1	0	128	BOOL	
24	172	25	184	27	DiagCode	1	0	128	WORD	
34	118	29	123	31	IN	0	129	0	BOOL	
35	118	33	123	35	PT	0	128	0	TIME	
36	124	29	127	31	Q	1	0	129	BOOL	
37	123	33	127	35	ET	1	0	128	TIME	
41	81	28	83	30		0	1665	0	ANY_BIT	
42	81	32	83	34		0	1665	0	ANY_BIT	
43	88	29	89	31		1	0	641	ANY_BIT	
101	110	122	121	124	Activate	0	128	0	BOOL	
102	110	126	127	128	S_OutControl	0	128	0	SAFEBOOL	
103	110	130	121	132	S_EDM1	0	128	0	SAFEBOOL	
104	110	134	121	136	S_EDM2	0	128	0	SAFEBOOL	
105	110	138	129	140	MonitoringTime	0	128	0	TIME	
106	110	142	127	144	S_StartReset	0	128	0	SAFEBOOL	
107	110	146	119	148	Reset	0	128	0	BOOL	
108	135	122	143	124	Ready	1	0	128	BOOL	
109	129	126	143	128	S_EDM_Out	1	0	128	SAFEBOOL	
110	136	130	143	132	Error	1	0	128	BOOL	
111	131	134	143	136	DiagCode	1	0	128	WORD	
112	106	84	117	86	Activate	0	128	0	BOOL	
113	106	88	120	90	S_ESPE_In	0	128	0	SAFEBOOL	
114	106	92	123	94	S_StartReset	0	128	0	SAFEBOOL	
115	106	96	123	98	S_AutoReset	0	128	0	SAFEBOOL	
116	106	100	115	102	Reset	0	128	0	BOOL	
117	130	84	138	86	Ready	1	0	128	BOOL	
118	123	88	138	90	S_ESPE_Out	1	0	128	SAFEBOOL	
119	131	92	138	94	Error	1	0	128	BOOL	
120	126	96	138	98	DiagCode	1	0	128	WORD	
121	120	58	125	60	IN	0	129	0	BOOL	
122	120	62	125	64	PT	0	128	0	TIME	
123	126	58	129	60	Q	1	0	129	BOOL	
124	125	62	129	64	ET	1	0	128	TIME	
125	69	146	74	148	IN	0	129	0	BOOL	
126	69	150	74	152	PT	0	128	0	TIME	
127	75	146	78	148	Q	1	0	129	BOOL	
128	74	150	78	152	ET	1	0	128	TIME	
129	81	57	83	59		0	1665	0	ANY_BIT	
130	81	61	83	63		0	1665	0	ANY_BIT	
131	88	58	89	60		1	0	641	ANY_BIT	
132	64	169	69	171	IN	0	129	0	BOOL	
133	64	173	69	175	PT	0	128	0	TIME	
134	70	169	73	171	Q	1	0	129	BOOL	
135	69	173	73	175	ET	1	0	128	TIME	
136	58	100	63	102	IN	0	129	0	BOOL	
137	58	104	63	106	PT	0	128	0	TIME	
138	64	100	67	102	Q	1	0	129	BOOL	
139	63	104	67	106	ET	1	0	128	TIME	
140	51	126	53	128		0	1665	0	ANY_SAFEBIT	
141	51	130	53	132		0	1665	0	ANY_SAFEBIT	
142	59	126	60	128		1	0	641	ANY_SAFEBIT	
143	72	191	74	193		0	640	0	SAFEBOOL	
144	94	191	95	193		1	0	640	BOOL	
175	102	209	107	211	IN	0	129	0	BOOL	
176	102	213	107	215	PT	0	128	0	TIME	
177	108	209	111	211	Q	1	0	129	BOOL	
178	107	213	111	215	ET	1	0	128	TIME	
179	63	208	65	210		0	1665	0	ANY_BIT	
180	63	212	65	214		0	1665	0	ANY_BIT	
181	70	209	71	211		1	0	641	ANY_BIT	
187	41	394	46	396	IN	0	129	0	BOOL	
188	41	398	46	400	PT	0	128	0	TIME	
189	47	394	50	396	Q	1	0	129	BOOL	
190	46	398	50	400	ET	1	0	128	TIME	
195	65	485	70	487	IN	0	129	0	BOOL	
196	65	489	70	491	PT	0	128	0	TIME	
197	71	485	74	487	Q	1	0	129	BOOL	
198	70	489	74	491	ET	1	0	128	TIME	
204	72	347	74	349		0	1665	0	ANY_SAFEBIT	
205	72	351	74	353		0	1665	0	ANY_SAFEBIT	
206	80	347	81	349		1	0	641	ANY_SAFEBIT	
238	40	234	51	236	Activate	0	128	0	BOOL	
239	40	238	55	240	S_AOPD_In	0	128	0	SAFEBOOL	
240	40	242	63	244	S_MutingSwitch11	0	128	0	SAFEBOOL	
241	40	246	63	248	S_MutingSwitch12	0	128	0	SAFEBOOL	
242	40	250	58	252	S_MutingLamp	0	128	0	SAFEBOOL	
243	40	254	57	256	DiscTimeEntry	0	128	0	TIME	
244	40	258	59	260	MaxMutingTime	0	128	0	TIME	
245	40	262	57	264	MutingEnable	0	128	0	BOOL	
246	40	266	57	268	S_StartReset	0	128	0	SAFEBOOL	
247	40	271	49	273	Reset	0	128	0	BOOL	
248	73	234	81	236	Ready	1	0	128	BOOL	
249	65	238	81	240	S_AOPD_Out	1	0	128	SAFEBOOL	
250	63	242	81	244	S_MutingActive	1	0	128	SAFEBOOL	
251	74	246	81	248	Error	1	0	128	BOOL	
252	69	250	81	252	DiagCode	1	0	128	WORD	
256	114	238	116	240		0	640	0	SAFEBOOL	
257	136	238	137	240		1	0	640	BOOL	
268	117	562	122	564	IN	0	129	0	BOOL	
269	117	566	122	568	PT	0	128	0	TIME	
270	123	562	126	564	Q	1	0	129	BOOL	
271	122	566	126	568	ET	1	0	128	TIME	
272	76	562	78	564		0	640	0	SAFEBOOL	
273	98	562	99	564		1	0	640	BOOL	
280	119	343	130	345	Activate	0	128	0	BOOL	
281	119	347	136	349	S_OutControl	0	128	0	SAFEBOOL	
282	119	351	130	353	S_EDM1	0	128	0	SAFEBOOL	
283	119	355	130	357	S_EDM2	0	128	0	SAFEBOOL	
284	119	359	138	361	MonitoringTime	0	128	0	TIME	
285	119	363	136	365	S_StartReset	0	128	0	SAFEBOOL	
286	119	367	128	369	Reset	0	128	0	BOOL	
287	144	343	152	345	Ready	1	0	128	BOOL	
288	138	347	152	349	S_EDM_Out	1	0	128	SAFEBOOL	
289	145	351	152	353	Error	1	0	128	BOOL	
290	140	355	152	357	DiagCode	1	0	128	WORD	
293	24	362	26	364		0	1665	0	ANY_SAFEBIT	
294	24	366	26	368		0	1665	0	ANY_SAFEBIT	
295	31	362	32	364		1	0	641	ANY_SAFEBIT	
299	24	370	26	372		0	1665	0	ANY_SAFEBIT	
308	29	299	31	301		0	1665	0	ANY_SAFEBIT	
309	29	303	31	305		0	1665	0	ANY_SAFEBIT	
310	37	299	38	301		1	0	641	ANY_SAFEBIT	
311	87	295	98	297	Activate	0	128	0	BOOL	
312	87	299	101	301	S_ESPE_In	0	128	0	SAFEBOOL	
313	87	303	104	305	S_StartReset	0	128	0	SAFEBOOL	
314	87	307	104	309	S_AutoReset	0	128	0	SAFEBOOL	
315	87	311	96	313	Reset	0	128	0	BOOL	
316	111	295	119	297	Ready	1	0	128	BOOL	
317	104	299	119	301	S_ESPE_Out	1	0	128	SAFEBOOL	
318	112	303	119	305	Error	1	0	128	BOOL	
319	107	307	119	309	DiagCode	1	0	128	WORD	
325	121	396	132	398	Activate	0	128	0	BOOL	
326	121	400	138	402	S_OutControl	0	128	0	SAFEBOOL	
327	121	404	132	406	S_EDM1	0	128	0	SAFEBOOL	
328	121	408	132	410	S_EDM2	0	128	0	SAFEBOOL	
329	121	412	140	414	MonitoringTime	0	128	0	TIME	
330	121	416	138	418	S_StartReset	0	128	0	SAFEBOOL	
331	121	420	130	422	Reset	0	128	0	BOOL	
332	146	396	154	398	Ready	1	0	128	BOOL	
333	140	400	154	402	S_EDM_Out	1	0	128	SAFEBOOL	
334	147	404	154	406	Error	1	0	128	BOOL	
335	142	408	154	410	DiagCode	1	0	128	WORD	
363	121	439	132	441	Activate	0	128	0	BOOL	
364	121	443	138	445	S_OutControl	0	128	0	SAFEBOOL	
365	121	447	132	449	S_EDM1	0	128	0	SAFEBOOL	
366	121	451	132	453	S_EDM2	0	128	0	SAFEBOOL	
367	121	455	140	457	MonitoringTime	0	128	0	TIME	
368	121	459	138	461	S_StartReset	0	128	0	SAFEBOOL	
369	121	463	130	465	Reset	0	128	0	BOOL	
370	146	439	154	441	Ready	1	0	128	BOOL	
371	140	443	154	445	S_EDM_Out	1	0	128	SAFEBOOL	
372	147	447	154	449	Error	1	0	128	BOOL	
373	142	451	154	453	DiagCode	1	0	128	WORD	
406	53	362	55	364		0	1665	0	ANY_SAFEBIT	
407	53	366	55	368		0	1665	0	ANY_SAFEBIT	
408	61	362	62	364		1	0	641	ANY_SAFEBIT	
423	71	579	76	581	IN	0	129	0	BOOL	
424	71	583	76	585	PT	0	128	0	TIME	
425	77	579	80	581	Q	1	0	129	BOOL	
426	76	583	80	585	ET	1	0	128	TIME	
444	98	687	109	689	Activate	0	128	0	BOOL	
445	98	691	115	693	S_OutControl	0	128	0	SAFEBOOL	
446	98	695	109	697	S_EDM1	0	128	0	SAFEBOOL	
447	98	699	109	701	S_EDM2	0	128	0	SAFEBOOL	
448	98	703	117	705	MonitoringTime	0	128	0	TIME	
449	98	707	115	709	S_StartReset	0	128	0	SAFEBOOL	
450	98	711	107	713	Reset	0	128	0	BOOL	
451	123	687	131	689	Ready	1	0	128	BOOL	
452	117	691	131	693	S_EDM_Out	1	0	128	SAFEBOOL	
453	124	695	131	697	Error	1	0	128	BOOL	
454	119	699	131	701	DiagCode	1	0	128	WORD	
455	39	736	44	738	IN	0	129	0	BOOL	
456	39	740	44	742	PT	0	128	0	TIME	
457	45	736	48	738	Q	1	0	129	BOOL	
458	44	740	48	742	ET	1	0	128	TIME	
459	52	691	54	693		0	1665	0	ANY_SAFEBIT	
460	52	695	54	697		0	1665	0	ANY_SAFEBIT	
461	60	691	61	693		1	0	643	ANY_SAFEBIT	
481	109	602	111	604		0	640	0	SAFEBOOL	
482	131	602	132	604		1	0	640	BOOL	
485	35	598	46	600	Activate	0	128	0	BOOL	
486	35	602	50	604	S_AOPD_In	0	128	0	SAFEBOOL	
487	35	606	58	608	S_MutingSwitch11	0	128	0	SAFEBOOL	
488	35	610	58	612	S_MutingSwitch12	0	128	0	SAFEBOOL	
489	35	614	53	616	S_MutingLamp	0	128	0	SAFEBOOL	
490	35	618	52	620	DiscTimeEntry	0	128	0	TIME	
491	35	622	54	624	MaxMutingTime	0	128	0	TIME	
492	35	626	52	628	MutingEnable	0	128	0	BOOL	
493	35	630	52	632	S_StartReset	0	128	0	SAFEBOOL	
494	35	635	44	637	Reset	0	128	0	BOOL	
495	68	598	76	600	Ready	1	0	128	BOOL	
496	60	602	76	604	S_AOPD_Out	1	0	128	SAFEBOOL	
497	58	606	76	608	S_MutingActive	1	0	128	SAFEBOOL	
498	69	610	76	612	Error	1	0	128	BOOL	
499	64	614	76	616	DiagCode	1	0	128	WORD	
514	73	790	78	792	IN	0	129	0	BOOL	
515	73	794	78	796	PT	0	128	0	TIME	
516	79	790	82	792	Q	1	0	129	BOOL	
517	78	794	82	796	ET	1	0	128	TIME	
518	121	829	126	831	IN	0	129	0	BOOL	
519	121	833	126	835	PT	0	128	0	TIME	
520	127	829	130	831	Q	1	0	129	BOOL	
521	126	833	130	835	ET	1	0	128	TIME	
522	80	829	82	831		0	640	0	SAFEBOOL	
523	102	829	103	831		1	0	640	BOOL	
535	23	696	25	698		0	1665	0	ANY_SAFEBIT	
536	23	700	25	702		0	1665	0	ANY_SAFEBIT	
537	30	696	31	698		1	0	641	ANY_SAFEBIT	
541	23	704	25	706		0	1665	0	ANY_SAFEBIT	
546	52	699	54	701		0	1665	0	ANY_SAFEBIT	
559	38	652	49	654	Activate	0	128	0	BOOL	
560	38	656	52	658	S_ESPE_In	0	128	0	SAFEBOOL	
561	38	660	55	662	S_StartReset	0	128	0	SAFEBOOL	
562	38	664	55	666	S_AutoReset	0	128	0	SAFEBOOL	
563	38	668	47	670	Reset	0	128	0	BOOL	
564	62	652	70	654	Ready	1	0	128	BOOL	
565	55	656	70	658	S_ESPE_Out	1	0	128	SAFEBOOL	
566	63	660	70	662	Error	1	0	128	BOOL	
567	58	664	70	666	DiagCode	1	0	128	WORD	
570	98	740	109	742	Activate	0	128	0	BOOL	
571	98	744	115	746	S_OutControl	0	128	0	SAFEBOOL	
572	98	748	109	750	S_EDM1	0	128	0	SAFEBOOL	
573	98	752	109	754	S_EDM2	0	128	0	SAFEBOOL	
574	98	756	117	758	MonitoringTime	0	128	0	TIME	
575	98	760	115	762	S_StartReset	0	128	0	SAFEBOOL	
576	98	764	107	766	Reset	0	128	0	BOOL	
577	123	740	131	742	Ready	1	0	128	BOOL	
578	117	744	131	746	S_EDM_Out	1	0	128	SAFEBOOL	
579	124	748	131	750	Error	1	0	128	BOOL	
580	119	752	131	754	DiagCode	1	0	128	WORD	
617	52	703	54	705		0	1665	0	ANY_SAFEBIT	
621	27	715	29	717		0	1665	0	ANY_SAFEBIT	
622	27	719	29	721		0	1665	0	ANY_SAFEBIT	
623	34	715	35	717		1	0	641	ANY_SAFEBIT	
624	27	723	29	725		0	1665	0	ANY_SAFEBIT	
[KOT]
0
[VER]
0
