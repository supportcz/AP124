[LIT]
90
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
154	167	348	167	354
164	88	352	96	352
165	96	352	97	352
166	96	352	96	356
167	96	356	97	356
169	73	210	100	210
192	65	368	97	368
201	63	402	90	402
202	90	402	96	402
203	90	402	90	409
204	90	409	95	409
210	167	354	172	354
211	167	354	167	362
212	167	362	174	362
214	167	369	172	369
215	167	362	167	369
217	167	369	167	375
218	167	348	172	348
219	134	348	167	348
221	90	409	90	417
223	90	425	97	425
224	90	417	90	425
226	90	433	97	433
227	90	425	90	433
228	90	417	96	417
260	83	239	90	239
261	139	239	140	239
262	90	239	90	234
263	90	234	97	234
264	90	239	112	239
265	88	464	102	464
279	167	375	173	375
293	46	464	61	464
294	67	348	97	348
295	45	343	49	343
296	49	343	49	348
297	49	348	54	348
307	37	352	54	352
330	40	300	85	300
342	166	593	166	599
343	166	599	171	599
344	166	593	171	593
345	133	593	166	593
379	78	504	85	504
380	134	504	135	504
381	85	504	85	499
382	85	499	92	499
383	85	504	107	504
418	83	597	90	597
419	90	597	96	597
420	90	601	96	601
421	90	597	90	601
422	106	676	120	676
444	83	650	104	650
445	104	650	115	650
446	104	650	104	658
447	104	658	114	658
448	29	520	33	520
454	67	623	81	623
455	81	623	81	613
456	81	613	96	613
457	67	593	96	593
460	46	598	46	597
461	46	597	54	597
464	45	590	46	590
465	46	590	46	593
466	46	593	54	593
467	37	598	46	598
[TET]
137
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
155	172	347	201	349	4	3	doPalletizationContactor1
156	172	353	201	355	4	3	doPalletizationContactor2
157	81	359	97	361	4	5	TIME#500ms
158	89	343	97	345	4	5	TRUE
159	83	363	97	365	4	5	SAFEFALSE
160	96	401	122	403	4	3	SM6_ReleaseOutput01
161	95	408	121	410	4	3	SM6_ReleaseOutput02
162	24	342	45	344	4	5	allEStopsReleased
163	67	351	88	353	4	5	diPalletizationEDM
168	134	351	158	353	4	3	palletizationEdmError
171	113	209	143	211	4	3	activateSafetyPalletization
172	83	213	100	215	4	5	TIME#1000ms
173	31	208	61	210	4	5	diActivateAllSafetyCircuits
174	32	212	61	214	4	5	diActivateMagazineSafety
185	22	367	52	369	4	5	activateSafetyPalletization
186	36	371	52	373	4	5	TIME#100ms
193	20	401	50	403	4	5	activateSafetyPalletization
194	34	405	50	407	4	5	TIME#200ms
209	174	361	184	363	4	3	doFI14
213	172	368	182	370	4	3	doFI15
216	173	374	183	376	4	3	doFI16
220	96	416	122	418	4	3	SM3_ReleaseOutput01
222	97	424	123	426	4	3	SM3_ReleaseOutput02
225	97	432	123	434	4	3	SM3_ReleaseOutput03
230	30	234	38	236	4	5	TRUE
231	24	266	38	268	4	5	SAFEFALSE
232	25	250	38	252	4	5	SAFETRUE
233	27	254	38	256	4	5	TIME#1s
234	25	258	38	260	4	5	TIME#10s
235	8	242	38	244	4	5	diLightCurtainP15muting1
236	30	262	38	264	4	5	TRUE
237	8	246	38	248	4	5	diLightCurtainP15muting2
238	17	238	38	240	4	5	diLightCurtainP15
255	97	233	116	235	4	3	lightCurtainP15
256	140	238	163	240	4	3	lightCurtainP15grey
266	115	463	141	465	4	3	SM7_ReleaseOutput03
268	87	467	102	469	4	5	TIME#50ms
277	24	463	46	465	4	5	doMutingLampP15
278	83	242	105	244	4	3	doMutingLampP15
302	6	351	25	353	4	5	lightCurtainP15
303	8	355	25	357	4	5	diOverrideP15
305	11	359	25	361	4	5	SAFEFALSE
308	37	355	54	357	4	5	door13locked
309	10	299	27	301	4	5	diDoor1locked
310	10	303	27	305	4	5	diDoor3locked
312	121	299	138	301	4	3	door13locked
313	77	295	85	297	4	5	TRUE
314	71	303	85	305	4	5	SAFEFALSE
315	71	307	85	309	4	5	SAFEFALSE
331	55	311	85	313	4	5	activateSafetyPalletization
332	8	271	38	273	4	5	activateSafetyPalletization
333	82	480	108	482	4	3	activateSafetyOutfeed
334	52	484	69	486	4	5	TIME#1000ms
335	39	480	69	482	4	5	diActivateAllSafetyCircuits
347	171	592	196	594	4	3	doOutfeedContactor1
348	171	598	196	600	4	3	doOutfeedContactor2
349	80	604	96	606	4	5	TIME#500ms
350	88	588	96	590	4	5	TRUE
351	82	608	96	610	4	5	SAFEFALSE
352	24	589	45	591	4	5	allEStopsReleased
353	133	596	153	598	4	3	outfeedEdmError
355	28	622	54	624	4	5	activateSafetyOutfeed
356	38	626	54	628	4	5	TIME#100ms
357	6	597	25	599	4	5	lightCurtainP17
384	25	499	33	501	4	5	TRUE
385	19	531	33	533	4	5	SAFEFALSE
386	20	515	33	517	4	5	SAFETRUE
387	21	519	29	521	4	5	T#4s
388	20	523	33	525	4	5	TIME#12s
389	25	527	33	529	4	5	TRUE
390	3	511	33	513	4	5	diLightCurtainP17muting2
391	7	536	33	538	4	5	activateSafetyOutfeed
392	92	498	111	500	4	3	lightCurtainP17
393	135	503	158	505	4	3	lightCurtainP17grey
394	78	507	100	509	4	3	doMutingLampP17
415	12	503	33	505	4	5	diLightCurtainP17
416	3	507	33	509	4	5	diLightCurtainP17muting1
417	66	596	83	598	4	5	diOutfeedEDM
423	44	649	70	651	4	5	activateSafetyOutfeed
424	54	653	70	655	4	5	TIME#200ms
427	105	679	120	681	4	5	TIME#50ms
428	57	675	79	677	4	5	doMutingLampP17
442	115	649	141	651	4	3	SM7_ReleaseOutput01
443	114	657	140	659	4	3	SM7_ReleaseOutput02
449	133	675	159	677	4	3	SM7_ReleaseOutput04
459	8	601	25	603	4	5	diOverrideP17
462	11	605	25	607	4	5	SAFEFALSE
468	39	600	54	602	4	5	door2locked
469	19	557	36	559	4	5	diDoor2locked
471	72	557	87	559	4	3	door2locked
472	28	553	36	555	4	5	TRUE
473	22	561	36	563	4	5	SAFEFALSE
474	22	565	36	567	4	5	SAFEFALSE
475	10	569	36	571	4	5	activateSafetyOutfeed
[FBS]
37
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
191	54	364	63	376	0	TON	TON_4
200	52	398	61	410	0	TON	TON_5
208	56	344	65	360	1	AND_S	
254	40	231	81	275	0	SF_MutingPar_2Sensor_V1_00	SF_MutingPar_2Sensor_V1_1
259	114	235	137	243	1	SAFEBOOL_TO_BOOL	
275	104	460	113	472	0	TON	TON_7
276	63	460	86	468	1	SAFEBOOL_TO_BOOL	
292	99	340	132	372	0	SF_EDM_V1_00	SF_EDM_V1_00_2
301	27	348	35	364	1	OR_S	
328	29	296	38	312	1	AND_S	
329	87	292	119	316	0	SF_ESPE_V1_00	SF_ESPE_V1_00_2
341	71	477	80	489	0	TP	TP_4
376	98	585	131	617	0	SF_EDM_V1_00	SF_EDM_V1_00_3
377	56	619	65	631	0	TON	TON_8
378	56	589	65	605	1	AND_S	
397	109	500	132	508	1	SAFEBOOL_TO_BOOL	
414	35	496	76	540	0	SF_MutingPar_2Sensor_V1_00	SF_MutingPar_2Sensor_V1_2
439	72	646	81	658	0	TON	TON_10
440	122	672	131	684	0	TON	TON_11
441	81	672	104	680	1	SAFEBOOL_TO_BOOL	
453	27	594	35	610	1	OR_S	
485	38	550	70	574	0	SF_ESPE_V1_00	SF_ESPE_V1_00_3
[FPT]
200
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
187	54	367	59	369	IN	0	129	0	BOOL	
188	54	371	59	373	PT	0	128	0	TIME	
189	60	367	63	369	Q	1	0	129	BOOL	
190	59	371	63	373	ET	1	0	128	TIME	
196	52	401	57	403	IN	0	129	0	BOOL	
197	52	405	57	407	PT	0	128	0	TIME	
198	58	401	61	403	Q	1	0	129	BOOL	
199	57	405	61	407	ET	1	0	128	TIME	
205	56	347	58	349		0	1665	0	ANY_SAFEBIT	
206	56	351	58	353		0	1665	0	ANY_SAFEBIT	
207	64	347	65	349		1	0	643	ANY_SAFEBIT	
239	40	234	51	236	Activate	0	128	0	BOOL	
240	40	238	55	240	S_AOPD_In	0	128	0	SAFEBOOL	
241	40	242	63	244	S_MutingSwitch11	0	128	0	SAFEBOOL	
242	40	246	63	248	S_MutingSwitch12	0	128	0	SAFEBOOL	
243	40	250	58	252	S_MutingLamp	0	128	0	SAFEBOOL	
244	40	254	57	256	DiscTimeEntry	0	128	0	TIME	
245	40	258	59	260	MaxMutingTime	0	128	0	TIME	
246	40	262	57	264	MutingEnable	0	128	0	BOOL	
247	40	266	57	268	S_StartReset	0	128	0	SAFEBOOL	
248	40	271	49	273	Reset	0	128	0	BOOL	
249	73	234	81	236	Ready	1	0	128	BOOL	
250	65	238	81	240	S_AOPD_Out	1	0	128	SAFEBOOL	
251	63	242	81	244	S_MutingActive	1	0	128	SAFEBOOL	
252	74	246	81	248	Error	1	0	128	BOOL	
253	69	250	81	252	DiagCode	1	0	128	WORD	
257	114	238	116	240		0	640	0	SAFEBOOL	
258	136	238	137	240		1	0	640	BOOL	
269	104	463	109	465	IN	0	129	0	BOOL	
270	104	467	109	469	PT	0	128	0	TIME	
271	110	463	113	465	Q	1	0	129	BOOL	
272	109	467	113	469	ET	1	0	128	TIME	
273	63	463	65	465		0	640	0	SAFEBOOL	
274	85	463	86	465		1	0	640	BOOL	
281	99	343	110	345	Activate	0	128	0	BOOL	
282	99	347	116	349	S_OutControl	0	128	0	SAFEBOOL	
283	99	351	110	353	S_EDM1	0	128	0	SAFEBOOL	
284	99	355	110	357	S_EDM2	0	128	0	SAFEBOOL	
285	99	359	118	361	MonitoringTime	0	128	0	TIME	
286	99	363	116	365	S_StartReset	0	128	0	SAFEBOOL	
287	99	367	108	369	Reset	0	128	0	BOOL	
288	124	343	132	345	Ready	1	0	128	BOOL	
289	118	347	132	349	S_EDM_Out	1	0	128	SAFEBOOL	
290	125	351	132	353	Error	1	0	128	BOOL	
291	120	355	132	357	DiagCode	1	0	128	WORD	
298	27	351	29	353		0	1665	0	ANY_SAFEBIT	
299	27	355	29	357		0	1665	0	ANY_SAFEBIT	
300	34	351	35	353		1	0	643	ANY_SAFEBIT	
304	27	359	29	361		0	1665	0	ANY_SAFEBIT	
306	56	355	58	357		0	1665	0	ANY_SAFEBIT	
316	29	299	31	301		0	1665	0	ANY_SAFEBIT	
317	29	303	31	305		0	1665	0	ANY_SAFEBIT	
318	37	299	38	301		1	0	641	ANY_SAFEBIT	
319	87	295	98	297	Activate	0	128	0	BOOL	
320	87	299	101	301	S_ESPE_In	0	128	0	SAFEBOOL	
321	87	303	104	305	S_StartReset	0	128	0	SAFEBOOL	
322	87	307	104	309	S_AutoReset	0	128	0	SAFEBOOL	
323	87	311	96	313	Reset	0	128	0	BOOL	
324	111	295	119	297	Ready	1	0	128	BOOL	
325	104	299	119	301	S_ESPE_Out	1	0	128	SAFEBOOL	
326	112	303	119	305	Error	1	0	128	BOOL	
327	107	307	119	309	DiagCode	1	0	128	WORD	
337	71	480	76	482	IN	0	129	0	BOOL	
338	71	484	76	486	PT	0	128	0	TIME	
339	77	480	80	482	Q	1	0	129	BOOL	
340	76	484	80	486	ET	1	0	128	TIME	
358	98	588	109	590	Activate	0	128	0	BOOL	
359	98	592	115	594	S_OutControl	0	128	0	SAFEBOOL	
360	98	596	109	598	S_EDM1	0	128	0	SAFEBOOL	
361	98	600	109	602	S_EDM2	0	128	0	SAFEBOOL	
362	98	604	117	606	MonitoringTime	0	128	0	TIME	
363	98	608	115	610	S_StartReset	0	128	0	SAFEBOOL	
364	98	612	107	614	Reset	0	128	0	BOOL	
365	123	588	131	590	Ready	1	0	128	BOOL	
366	117	592	131	594	S_EDM_Out	1	0	128	SAFEBOOL	
367	124	596	131	598	Error	1	0	128	BOOL	
368	119	600	131	602	DiagCode	1	0	128	WORD	
369	56	622	61	624	IN	0	129	0	BOOL	
370	56	626	61	628	PT	0	128	0	TIME	
371	62	622	65	624	Q	1	0	129	BOOL	
372	61	626	65	628	ET	1	0	128	TIME	
373	56	592	58	594		0	1665	0	ANY_SAFEBIT	
374	56	596	58	598		0	1665	0	ANY_SAFEBIT	
375	64	592	65	594		1	0	643	ANY_SAFEBIT	
395	109	503	111	505		0	640	0	SAFEBOOL	
396	131	503	132	505		1	0	640	BOOL	
399	35	499	46	501	Activate	0	128	0	BOOL	
400	35	503	50	505	S_AOPD_In	0	128	0	SAFEBOOL	
401	35	507	58	509	S_MutingSwitch11	0	128	0	SAFEBOOL	
402	35	511	58	513	S_MutingSwitch12	0	128	0	SAFEBOOL	
403	35	515	53	517	S_MutingLamp	0	128	0	SAFEBOOL	
404	35	519	52	521	DiscTimeEntry	0	128	0	TIME	
405	35	523	54	525	MaxMutingTime	0	128	0	TIME	
406	35	527	52	529	MutingEnable	0	128	0	BOOL	
407	35	531	52	533	S_StartReset	0	128	0	SAFEBOOL	
408	35	536	44	538	Reset	0	128	0	BOOL	
409	68	499	76	501	Ready	1	0	128	BOOL	
410	60	503	76	505	S_AOPD_Out	1	0	128	SAFEBOOL	
411	58	507	76	509	S_MutingActive	1	0	128	SAFEBOOL	
412	69	511	76	513	Error	1	0	128	BOOL	
413	64	515	76	517	DiagCode	1	0	128	WORD	
429	72	649	77	651	IN	0	129	0	BOOL	
430	72	653	77	655	PT	0	128	0	TIME	
431	78	649	81	651	Q	1	0	129	BOOL	
432	77	653	81	655	ET	1	0	128	TIME	
433	122	675	127	677	IN	0	129	0	BOOL	
434	122	679	127	681	PT	0	128	0	TIME	
435	128	675	131	677	Q	1	0	129	BOOL	
436	127	679	131	681	ET	1	0	128	TIME	
437	81	675	83	677		0	640	0	SAFEBOOL	
438	103	675	104	677		1	0	640	BOOL	
450	27	597	29	599		0	1665	0	ANY_SAFEBIT	
451	27	601	29	603		0	1665	0	ANY_SAFEBIT	
452	34	597	35	599		1	0	641	ANY_SAFEBIT	
458	27	605	29	607		0	1665	0	ANY_SAFEBIT	
463	56	600	58	602		0	1665	0	ANY_SAFEBIT	
476	38	553	49	555	Activate	0	128	0	BOOL	
477	38	557	52	559	S_ESPE_In	0	128	0	SAFEBOOL	
478	38	561	55	563	S_StartReset	0	128	0	SAFEBOOL	
479	38	565	55	567	S_AutoReset	0	128	0	SAFEBOOL	
480	38	569	47	571	Reset	0	128	0	BOOL	
481	62	553	70	555	Ready	1	0	128	BOOL	
482	55	557	70	559	S_ESPE_Out	1	0	128	SAFEBOOL	
483	63	561	70	563	Error	1	0	128	BOOL	
484	58	565	70	567	DiagCode	1	0	128	WORD	
[KOT]
0
[VER]
0
