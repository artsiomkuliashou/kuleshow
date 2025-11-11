--
-- PostgreSQL database dump
--

\restrict bUohfcywcQd7aheAR8HaNiIoXfGtd4PovIx0hFxvaObUzhY4epZ45EPUbaLfdRC

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: analysis; Type: TABLE; Schema: public; Owner: kuleshow
--

CREATE TABLE public.analysis (
    an_id integer NOT NULL,
    an_name character varying(100) NOT NULL,
    an_cost numeric(10,2) NOT NULL,
    an_price numeric(10,2) NOT NULL,
    an_group integer
);


ALTER TABLE public.analysis OWNER TO kuleshow;

--
-- Name: analysis_an_id_seq; Type: SEQUENCE; Schema: public; Owner: kuleshow
--

CREATE SEQUENCE public.analysis_an_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analysis_an_id_seq OWNER TO kuleshow;

--
-- Name: analysis_an_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuleshow
--

ALTER SEQUENCE public.analysis_an_id_seq OWNED BY public.analysis.an_id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: kuleshow
--

CREATE TABLE public.groups (
    gr_id integer NOT NULL,
    gr_name character varying(100) NOT NULL,
    gr_temp character varying(50) NOT NULL
);


ALTER TABLE public.groups OWNER TO kuleshow;

--
-- Name: groups_gr_id_seq; Type: SEQUENCE; Schema: public; Owner: kuleshow
--

CREATE SEQUENCE public.groups_gr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.groups_gr_id_seq OWNER TO kuleshow;

--
-- Name: groups_gr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuleshow
--

ALTER SEQUENCE public.groups_gr_id_seq OWNED BY public.groups.gr_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: kuleshow
--

CREATE TABLE public.orders (
    ord_id integer NOT NULL,
    ord_datetime timestamp without time zone NOT NULL,
    ord_an integer
);


ALTER TABLE public.orders OWNER TO kuleshow;

--
-- Name: orders_ord_id_seq; Type: SEQUENCE; Schema: public; Owner: kuleshow
--

CREATE SEQUENCE public.orders_ord_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_ord_id_seq OWNER TO kuleshow;

--
-- Name: orders_ord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuleshow
--

ALTER SEQUENCE public.orders_ord_id_seq OWNED BY public.orders.ord_id;


--
-- Name: analysis an_id; Type: DEFAULT; Schema: public; Owner: kuleshow
--

ALTER TABLE ONLY public.analysis ALTER COLUMN an_id SET DEFAULT nextval('public.analysis_an_id_seq'::regclass);


--
-- Name: groups gr_id; Type: DEFAULT; Schema: public; Owner: kuleshow
--

ALTER TABLE ONLY public.groups ALTER COLUMN gr_id SET DEFAULT nextval('public.groups_gr_id_seq'::regclass);


--
-- Name: orders ord_id; Type: DEFAULT; Schema: public; Owner: kuleshow
--

ALTER TABLE ONLY public.orders ALTER COLUMN ord_id SET DEFAULT nextval('public.orders_ord_id_seq'::regclass);


--
-- Data for Name: analysis; Type: TABLE DATA; Schema: public; Owner: kuleshow
--

COPY public.analysis (an_id, an_name, an_cost, an_price, an_group) FROM stdin;
1	Complete Blood Count	150.00	300.00	1
2	Blood Chemistry	400.00	800.00	2
3	Blood Glucose	80.00	160.00	2
4	TSH (Thyroid Stimulating Hormone)	250.00	500.00	4
5	Prolactin	280.00	560.00	4
6	Total IgE	320.00	640.00	3
7	Urinalysis	120.00	240.00	5
8	Coagulogram	180.00	360.00	1
9	ALT	90.00	180.00	2
10	Creatinine	85.00	170.00	2
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: kuleshow
--

COPY public.groups (gr_id, gr_name, gr_temp) FROM stdin;
1	Hematological	2-8°C
2	Biochemical	2-8°C
3	Immunological	-20°C
4	Hormonal	-20°C
5	General Clinical	room temperature
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: kuleshow
--

COPY public.orders (ord_id, ord_datetime, ord_an) FROM stdin;
1	2020-02-05 09:15:00	1
2	2020-02-05 10:30:00	2
3	2020-02-05 11:45:00	3
4	2020-02-05 14:20:00	1
5	2020-02-05 16:00:00	4
6	2020-02-06 08:30:00	5
7	2020-02-06 10:15:00	2
8	2020-02-06 12:00:00	6
9	2020-02-06 15:45:00	3
10	2020-02-07 09:00:00	7
11	2020-02-07 11:30:00	1
12	2020-02-07 13:15:00	8
13	2020-02-07 16:30:00	4
14	2020-02-08 10:00:00	9
15	2020-02-08 12:45:00	5
16	2020-02-08 14:30:00	2
17	2020-02-09 09:30:00	10
18	2020-02-09 11:00:00	6
19	2020-02-09 13:45:00	3
20	2020-02-10 08:45:00	7
21	2020-02-10 10:30:00	8
22	2020-02-10 12:15:00	1
23	2020-02-11 09:15:00	9
24	2020-02-11 11:30:00	4
25	2020-02-11 14:00:00	5
26	2020-02-11 16:45:00	2
27	2020-02-04 10:00:00	1
28	2020-02-12 09:00:00	3
29	2020-01-15 11:00:00	2
30	2020-03-20 14:00:00	6
\.


--
-- Name: analysis_an_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kuleshow
--

SELECT pg_catalog.setval('public.analysis_an_id_seq', 10, true);


--
-- Name: groups_gr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kuleshow
--

SELECT pg_catalog.setval('public.groups_gr_id_seq', 5, true);


--
-- Name: orders_ord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kuleshow
--

SELECT pg_catalog.setval('public.orders_ord_id_seq', 30, true);


--
-- Name: analysis analysis_pkey; Type: CONSTRAINT; Schema: public; Owner: kuleshow
--

ALTER TABLE ONLY public.analysis
    ADD CONSTRAINT analysis_pkey PRIMARY KEY (an_id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: kuleshow
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (gr_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: kuleshow
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (ord_id);


--
-- Name: analysis analysis_an_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kuleshow
--

ALTER TABLE ONLY public.analysis
    ADD CONSTRAINT analysis_an_group_fkey FOREIGN KEY (an_group) REFERENCES public.groups(gr_id);


--
-- Name: orders orders_ord_an_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kuleshow
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_ord_an_fkey FOREIGN KEY (ord_an) REFERENCES public.analysis(an_id);


--
-- PostgreSQL database dump complete
--

\unrestrict bUohfcywcQd7aheAR8HaNiIoXfGtd4PovIx0hFxvaObUzhY4epZ45EPUbaLfdRC

