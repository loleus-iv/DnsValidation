--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: _tests; Type: SCHEMA; Schema: -; Owner: admin2289_4
--

CREATE SCHEMA _tests;


ALTER SCHEMA _tests OWNER TO admin2289_4;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: domain_heuristic_data; Type: TABLE; Schema: _tests; Owner: admin2289_4; Tablespace: 
--

CREATE TABLE _tests.domain_heuristic_data (
    dhdid integer NOT NULL,
    domain integer NOT NULL,
    http_code smallint,
    http_code_checks_count smallint DEFAULT 0,
    http_code_valid boolean DEFAULT false,
    body_check_data text,
    body_check_checks_count smallint DEFAULT 0,
    body_check_valid boolean DEFAULT false
);


ALTER TABLE _tests.domain_heuristic_data OWNER TO admin2289_4;

--
-- Name: domain_heuristic_data_dhdid_seq; Type: SEQUENCE; Schema: _tests; Owner: admin2289_4
--

CREATE SEQUENCE _tests.domain_heuristic_data_dhdid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _tests.domain_heuristic_data_dhdid_seq OWNER TO admin2289_4;

--
-- Name: domain_heuristic_data_dhdid_seq; Type: SEQUENCE OWNED BY; Schema: _tests; Owner: admin2289_4
--

ALTER SEQUENCE _tests.domain_heuristic_data_dhdid_seq OWNED BY _tests.domain_heuristic_data.dhdid;


--
-- Name: dns_domeny; Type: TABLE; Schema: public; Owner: admin2289_4; Tablespace: 
--

CREATE TABLE public.dns_domeny (
    dnsdid integer NOT NULL,
    nazwa character varying NOT NULL,
    __soa_not_valid timestamp without time zone
);


ALTER TABLE public.dns_domeny OWNER TO admin2289_4;

--
-- Name: dns_domeny_dnsdid_seq; Type: SEQUENCE; Schema: public; Owner: admin2289_4
--

CREATE SEQUENCE public.dns_domeny_dnsdid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dns_domeny_dnsdid_seq OWNER TO admin2289_4;

--
-- Name: dns_domeny_dnsdid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin2289_4
--

ALTER SEQUENCE public.dns_domeny_dnsdid_seq OWNED BY public.dns_domeny.dnsdid;


--
-- Name: domeny; Type: TABLE; Schema: public; Owner: admin2289_4; Tablespace: 
--

CREATE TABLE public.domeny (
    did integer NOT NULL,
    nazwa character varying NOT NULL,
    poczta_aktywna boolean,
    __mx_not_valid timestamp without time zone,
    __mx_disabled boolean
);


ALTER TABLE public.domeny OWNER TO admin2289_4;

--
-- Name: domeny_did_seq; Type: SEQUENCE; Schema: public; Owner: admin2289_4
--

CREATE SEQUENCE public.domeny_did_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domeny_did_seq OWNER TO admin2289_4;

--
-- Name: domeny_did_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin2289_4
--

ALTER SEQUENCE public.domeny_did_seq OWNED BY public.domeny.did;


--
-- Name: dhdid; Type: DEFAULT; Schema: _tests; Owner: admin2289_4
--

ALTER TABLE ONLY _tests.domain_heuristic_data ALTER COLUMN dhdid SET DEFAULT nextval('_tests.domain_heuristic_data_dhdid_seq'::regclass);


--
-- Name: dnsdid; Type: DEFAULT; Schema: public; Owner: admin2289_4
--

ALTER TABLE ONLY public.dns_domeny ALTER COLUMN dnsdid SET DEFAULT nextval('public.dns_domeny_dnsdid_seq'::regclass);


--
-- Name: did; Type: DEFAULT; Schema: public; Owner: admin2289_4
--

ALTER TABLE ONLY public.domeny ALTER COLUMN did SET DEFAULT nextval('public.domeny_did_seq'::regclass);


--
-- Data for Name: domain_heuristic_data; Type: TABLE DATA; Schema: _tests; Owner: admin2289_4
--

COPY _tests.domain_heuristic_data (dhdid, domain, http_code, http_code_checks_count, http_code_valid, body_check_data, body_check_checks_count, body_check_valid) FROM stdin;
\.


--
-- Name: domain_heuristic_data_dhdid_seq; Type: SEQUENCE SET; Schema: _tests; Owner: admin2289_4
--

SELECT pg_catalog.setval('_tests.domain_heuristic_data_dhdid_seq', 49, true);


--
-- Data for Name: dns_domeny; Type: TABLE DATA; Schema: public; Owner: admin2289_4
--

COPY public.dns_domeny (dnsdid, nazwa, __soa_not_valid) FROM stdin;
1	felek.art.pl	\N
5	onet.pl	\N
11	wp.pl	\N
14	test.pl	\N
\.


--
-- Name: dns_domeny_dnsdid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin2289_4
--

SELECT pg_catalog.setval('public.dns_domeny_dnsdid_seq', 14, true);


--
-- Data for Name: domeny; Type: TABLE DATA; Schema: public; Owner: admin2289_4
--

COPY public.domeny (did, nazwa, poczta_aktywna, __mx_not_valid, __mx_disabled) FROM stdin;
1	onet.pl	t	2018-12-02 13:57:38	t
2	wp.pl	t	2018-12-02 13:57:38	t
28	felek.art.pl	t	2018-12-02 13:57:38	t
\.


--
-- Name: domeny_did_seq; Type: SEQUENCE SET; Schema: public; Owner: admin2289_4
--

SELECT pg_catalog.setval('public.domeny_did_seq', 29, true);


--
-- Name: domain_heuristic_data_pkey; Type: CONSTRAINT; Schema: _tests; Owner: admin2289_4; Tablespace: 
--

ALTER TABLE ONLY _tests.domain_heuristic_data
    ADD CONSTRAINT domain_heuristic_data_pkey PRIMARY KEY (dhdid);


--
-- Name: dns_domeny_nazwa_key; Type: CONSTRAINT; Schema: public; Owner: admin2289_4; Tablespace: 
--

ALTER TABLE ONLY public.dns_domeny
    ADD CONSTRAINT dns_domeny_nazwa_key UNIQUE (nazwa);


--
-- Name: dns_domeny_pkey; Type: CONSTRAINT; Schema: public; Owner: admin2289_4; Tablespace: 
--

ALTER TABLE ONLY public.dns_domeny
    ADD CONSTRAINT dns_domeny_pkey PRIMARY KEY (dnsdid);


--
-- Name: domeny_nazwa_key; Type: CONSTRAINT; Schema: public; Owner: admin2289_4; Tablespace: 
--

ALTER TABLE ONLY public.domeny
    ADD CONSTRAINT domeny_nazwa_key UNIQUE (nazwa);


--
-- Name: domeny_pkey; Type: CONSTRAINT; Schema: public; Owner: admin2289_4; Tablespace: 
--

ALTER TABLE ONLY public.domeny
    ADD CONSTRAINT domeny_pkey PRIMARY KEY (did);


--
-- Name: domain_heuristic_data_domain_fkey; Type: FK CONSTRAINT; Schema: _tests; Owner: admin2289_4
--

ALTER TABLE ONLY _tests.domain_heuristic_data
    ADD CONSTRAINT domain_heuristic_data_domain_fkey FOREIGN KEY (domain) REFERENCES public.domeny(did);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

