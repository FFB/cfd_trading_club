--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Name: confidence_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('confidence_id_seq', 1, false);


--
-- Name: estimate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('estimate_id_seq', 1, false);


--
-- Name: prediction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('prediction_id_seq', 1, false);


--
-- Name: predictor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('predictor_id_seq', 1, false);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('role_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Data for Name: confidence; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY confidence (id, name, value) FROM stdin;
\.


--
-- Data for Name: estimate; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY estimate (id, name, icon) FROM stdin;
\.


--
-- Data for Name: predictor; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY predictor (id, ticker, open_time, close_time) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY users (id, username, password, upi, email, first_name, last_name, mobile) FROM stdin;
1	zane	zane15	zmos003	zjmoser@gmail.com	zane	moser	021 163 5403
\.


--
-- Data for Name: prediction; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY prediction (id, p_id, user_id, "time", est_id, conf_id) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY role (id, rolename) FROM stdin;
1	member
2	admin
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY user_role (user_id, role_id) FROM stdin;
1	1
1	2
\.


--
-- PostgreSQL database dump complete
--

