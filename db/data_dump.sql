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
-- Name: prediction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('prediction_id_seq', 1, false);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('role_id_seq', 2, true);


--
-- Name: ticker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('ticker_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zany
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Data for Name: ticker; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY ticker (id, code, text) FROM stdin;
1	SPX	S&P500
2	EURO50	Euro50
3	FTSE	FTSE
4	ASX200	ASX200
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY users (id, username, password, upi, student_id, email, first_name, last_name, mobile, degree, major, year, experience) FROM stdin;
1	zane	z	zmos003	4893512	zjmoser@gmail.com	zane	moser	021 163 5403	BCom/BE	Eco, Fin, SE	4th Year	experienced
\.


--
-- Data for Name: prediction; Type: TABLE DATA; Schema: public; Owner: zany
--

COPY prediction (id, ticker_id, user_id, "time", direction) FROM stdin;
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

