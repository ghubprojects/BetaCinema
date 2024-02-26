--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2024-02-26 10:17:17

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

--
-- TOC entry 6 (class 2615 OID 52738)
-- Name: hangfire; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hangfire;


ALTER SCHEMA hangfire OWNER TO postgres;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 236 (class 1259 OID 53030)
-- Name: aggregatedcounter; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.aggregatedcounter (
    id bigint NOT NULL,
    key text NOT NULL,
    value bigint NOT NULL,
    expireat timestamp with time zone
);


ALTER TABLE hangfire.aggregatedcounter OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 53029)
-- Name: aggregatedcounter_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.aggregatedcounter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.aggregatedcounter_id_seq OWNER TO postgres;

--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 235
-- Name: aggregatedcounter_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.aggregatedcounter_id_seq OWNED BY hangfire.aggregatedcounter.id;


--
-- TOC entry 218 (class 1259 OID 52745)
-- Name: counter; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.counter (
    id bigint NOT NULL,
    key text NOT NULL,
    value bigint NOT NULL,
    expireat timestamp with time zone
);


ALTER TABLE hangfire.counter OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 52744)
-- Name: counter_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.counter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.counter_id_seq OWNER TO postgres;

--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 217
-- Name: counter_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.counter_id_seq OWNED BY hangfire.counter.id;


--
-- TOC entry 220 (class 1259 OID 52753)
-- Name: hash; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.hash (
    id bigint NOT NULL,
    key text NOT NULL,
    field text NOT NULL,
    value text,
    expireat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.hash OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 52752)
-- Name: hash_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.hash_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.hash_id_seq OWNER TO postgres;

--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 219
-- Name: hash_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.hash_id_seq OWNED BY hangfire.hash.id;


--
-- TOC entry 222 (class 1259 OID 52764)
-- Name: job; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.job (
    id bigint NOT NULL,
    stateid bigint,
    statename text,
    invocationdata jsonb NOT NULL,
    arguments jsonb NOT NULL,
    createdat timestamp with time zone NOT NULL,
    expireat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.job OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 52763)
-- Name: job_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.job_id_seq OWNER TO postgres;

--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 221
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.job_id_seq OWNED BY hangfire.job.id;


--
-- TOC entry 233 (class 1259 OID 52824)
-- Name: jobparameter; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.jobparameter (
    id bigint NOT NULL,
    jobid bigint NOT NULL,
    name text NOT NULL,
    value text,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.jobparameter OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 52823)
-- Name: jobparameter_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.jobparameter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.jobparameter_id_seq OWNER TO postgres;

--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 232
-- Name: jobparameter_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.jobparameter_id_seq OWNED BY hangfire.jobparameter.id;


--
-- TOC entry 226 (class 1259 OID 52789)
-- Name: jobqueue; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.jobqueue (
    id bigint NOT NULL,
    jobid bigint NOT NULL,
    queue text NOT NULL,
    fetchedat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.jobqueue OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 52788)
-- Name: jobqueue_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.jobqueue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.jobqueue_id_seq OWNER TO postgres;

--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 225
-- Name: jobqueue_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.jobqueue_id_seq OWNED BY hangfire.jobqueue.id;


--
-- TOC entry 228 (class 1259 OID 52797)
-- Name: list; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.list (
    id bigint NOT NULL,
    key text NOT NULL,
    value text,
    expireat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.list OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 52796)
-- Name: list_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.list_id_seq OWNER TO postgres;

--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 227
-- Name: list_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.list_id_seq OWNED BY hangfire.list.id;


--
-- TOC entry 234 (class 1259 OID 52838)
-- Name: lock; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.lock (
    resource text NOT NULL,
    updatecount integer DEFAULT 0 NOT NULL,
    acquired timestamp with time zone
);


ALTER TABLE hangfire.lock OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 52739)
-- Name: schema; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.schema (
    version integer NOT NULL
);


ALTER TABLE hangfire.schema OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 52805)
-- Name: server; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.server (
    id text NOT NULL,
    data jsonb,
    lastheartbeat timestamp with time zone NOT NULL,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.server OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 52813)
-- Name: set; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.set (
    id bigint NOT NULL,
    key text NOT NULL,
    score double precision NOT NULL,
    value text NOT NULL,
    expireat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.set OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 52812)
-- Name: set_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.set_id_seq OWNER TO postgres;

--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 230
-- Name: set_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.set_id_seq OWNED BY hangfire.set.id;


--
-- TOC entry 224 (class 1259 OID 52774)
-- Name: state; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.state (
    id bigint NOT NULL,
    jobid bigint NOT NULL,
    name text NOT NULL,
    reason text,
    createdat timestamp with time zone NOT NULL,
    data jsonb,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.state OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 52773)
-- Name: state_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hangfire.state_id_seq OWNER TO postgres;

--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 223
-- Name: state_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.state_id_seq OWNED BY hangfire.state.id;


--
-- TOC entry 4758 (class 2604 OID 53033)
-- Name: aggregatedcounter id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.aggregatedcounter ALTER COLUMN id SET DEFAULT nextval('hangfire.aggregatedcounter_id_seq'::regclass);


--
-- TOC entry 4741 (class 2604 OID 52871)
-- Name: counter id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.counter ALTER COLUMN id SET DEFAULT nextval('hangfire.counter_id_seq'::regclass);


--
-- TOC entry 4742 (class 2604 OID 52880)
-- Name: hash id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.hash ALTER COLUMN id SET DEFAULT nextval('hangfire.hash_id_seq'::regclass);


--
-- TOC entry 4744 (class 2604 OID 52890)
-- Name: job id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.job ALTER COLUMN id SET DEFAULT nextval('hangfire.job_id_seq'::regclass);


--
-- TOC entry 4755 (class 2604 OID 52940)
-- Name: jobparameter id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobparameter ALTER COLUMN id SET DEFAULT nextval('hangfire.jobparameter_id_seq'::regclass);


--
-- TOC entry 4748 (class 2604 OID 52963)
-- Name: jobqueue id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobqueue ALTER COLUMN id SET DEFAULT nextval('hangfire.jobqueue_id_seq'::regclass);


--
-- TOC entry 4750 (class 2604 OID 52983)
-- Name: list id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.list ALTER COLUMN id SET DEFAULT nextval('hangfire.list_id_seq'::regclass);


--
-- TOC entry 4753 (class 2604 OID 52992)
-- Name: set id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.set ALTER COLUMN id SET DEFAULT nextval('hangfire.set_id_seq'::regclass);


--
-- TOC entry 4746 (class 2604 OID 52917)
-- Name: state id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.state ALTER COLUMN id SET DEFAULT nextval('hangfire.state_id_seq'::regclass);


--
-- TOC entry 4967 (class 0 OID 53030)
-- Dependencies: 236
-- Data for Name: aggregatedcounter; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.aggregatedcounter (id, key, value, expireat) FROM stdin;
1	stats:succeeded:2024-02-26-02	2	2024-02-27 09:32:49.764273+07
4	stats:succeeded:2024-02-26-03	5	2024-02-27 10:09:22.914274+07
5	stats:deleted	5	\N
6	stats:deleted:2024-02-26	5	2024-03-26 10:07:57.023216+07
2	stats:succeeded:2024-02-26	7	2024-03-26 10:09:21.914274+07
3	stats:succeeded	7	\N
9	stats:deleted:2024-02-26-03	5	2024-02-27 10:07:58.023216+07
\.


--
-- TOC entry 4949 (class 0 OID 52745)
-- Dependencies: 218
-- Data for Name: counter; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.counter (id, key, value, expireat) FROM stdin;
37	stats:succeeded:2024-02-26	1	2024-03-26 10:12:52.249019+07
38	stats:succeeded:2024-02-26-03	1	2024-02-27 10:12:53.249019+07
39	stats:succeeded	1	\N
40	stats:succeeded:2024-02-26	1	2024-03-26 10:12:52.268085+07
41	stats:succeeded:2024-02-26	1	2024-03-26 10:12:52.268162+07
42	stats:succeeded:2024-02-26-03	1	2024-02-27 10:12:53.268085+07
43	stats:succeeded:2024-02-26-03	1	2024-02-27 10:12:53.268162+07
44	stats:succeeded	1	\N
45	stats:succeeded	1	\N
46	stats:succeeded:2024-02-26	1	2024-03-26 10:14:37.214406+07
47	stats:succeeded:2024-02-26-03	1	2024-02-27 10:14:38.214406+07
48	stats:succeeded	1	\N
49	stats:succeeded:2024-02-26	1	2024-03-26 10:14:37.217294+07
50	stats:succeeded:2024-02-26-03	1	2024-02-27 10:14:38.217294+07
51	stats:succeeded	1	\N
52	stats:succeeded:2024-02-26	1	2024-03-26 10:14:37.225687+07
53	stats:succeeded:2024-02-26-03	1	2024-02-27 10:14:38.225687+07
54	stats:succeeded	1	\N
\.


--
-- TOC entry 4951 (class 0 OID 52753)
-- Dependencies: 220
-- Data for Name: hash; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.hash (id, key, field, value, expireat, updatecount) FROM stdin;
\.


--
-- TOC entry 4953 (class 0 OID 52764)
-- Dependencies: 222
-- Data for Name: job; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.job (id, stateid, statename, invocationdata, arguments, createdat, expireat, updatecount) FROM stdin;
13	112	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"6f91da6e-7e63-46b0-97ce-f835986be522\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"af5ce027-8e55-36f2-8416-f79116a6b0a9\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:11:40.9864426+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:11:40.9864442+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"6f91da6e-7e63-46b0-97ce-f835986be522\\",\\"ShowtimeId\\":\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"af5ce027-8e55-36f2-8416-f79116a6b0a9\\",\\"CreatedDate\\":\\"2024-02-26T10:11:40.9864426+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:11:40.9864442+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:11:40.994709+07	2024-02-27 10:12:53.249019+07	0
4	81	Deleted	{"Type": "BetaCinema.ServerUI.Pages.Reservation.Reservation, BetaCinema.ServerUI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "TimerOutCallback", "Arguments": "[]", "ParameterTypes": "[]"}	[]	2024-02-26 09:59:42.243244+07	2024-02-27 10:07:58.005792+07	0
3	82	Deleted	{"Type": "BetaCinema.ServerUI.Pages.Reservation.Reservation, BetaCinema.ServerUI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "TimerOutCallback", "Arguments": "[]", "ParameterTypes": "[]"}	[]	2024-02-26 09:59:41.717185+07	2024-02-27 10:07:58.023216+07	0
2	7	Succeeded	{"Type": "System.Console, System.Console, Version=6.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "Method": "WriteLine", "Arguments": "[\\"\\\\\\"Delayed\\\\\\"\\"]", "ParameterTypes": "[\\"System.String, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["\\"Delayed\\""]	2024-02-26 09:31:48.811803+07	2024-02-27 09:32:49.764273+07	0
1	8	Succeeded	{"Type": "System.Console, System.Console, Version=6.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "Method": "WriteLine", "Arguments": "[\\"\\\\\\"Delayed\\\\\\"\\"]", "ParameterTypes": "[\\"System.String, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["\\"Delayed\\""]	2024-02-26 09:31:48.105177+07	2024-02-27 09:32:49.764146+07	0
16	124	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"b7966b36-314d-4dc7-840e-3b40ab837753\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"eac7e4a1-1f7c-cfc3-8e4a-cc9e2a5502ac\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:13:27.9092903+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:13:27.9092914+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"b7966b36-314d-4dc7-840e-3b40ab837753\\",\\"ShowtimeId\\":\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"eac7e4a1-1f7c-cfc3-8e4a-cc9e2a5502ac\\",\\"CreatedDate\\":\\"2024-02-26T10:13:27.9092903+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:13:27.9092914+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:13:27.917943+07	2024-02-27 10:14:38.214406+07	0
7	78	Deleted	{"Type": "BetaCinema.ServerUI.Pages.Reservation.Reservation, BetaCinema.ServerUI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "TimerOutCallback", "Arguments": "[]", "ParameterTypes": "[]"}	[]	2024-02-26 10:00:00.874414+07	2024-02-27 10:07:57.968027+07	0
6	79	Deleted	{"Type": "BetaCinema.ServerUI.Pages.Reservation.Reservation, BetaCinema.ServerUI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "TimerOutCallback", "Arguments": "[]", "ParameterTypes": "[]"}	[]	2024-02-26 10:00:00.422542+07	2024-02-27 10:07:57.985873+07	0
5	80	Deleted	{"Type": "BetaCinema.ServerUI.Pages.Reservation.Reservation, BetaCinema.ServerUI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "TimerOutCallback", "Arguments": "[]", "ParameterTypes": "[]"}	[]	2024-02-26 09:59:59.999585+07	2024-02-27 10:07:57.995983+07	0
14	113	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"c7a4dc1a-d288-4177-a372-25f33fa5f12e\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"2dfb1d34-fb0e-a2b5-180d-3e93184c79eb\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:11:41.6707818+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:11:41.6707835+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"c7a4dc1a-d288-4177-a372-25f33fa5f12e\\",\\"ShowtimeId\\":\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"2dfb1d34-fb0e-a2b5-180d-3e93184c79eb\\",\\"CreatedDate\\":\\"2024-02-26T10:11:41.6707818+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:11:41.6707835+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:11:41.67573+07	2024-02-27 10:12:53.268085+07	0
18	126	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"ab0c2ab5-d972-4e6a-9c0a-aa242c8fe6a0\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"e22436a8-5ace-b087-998e-9ff616dc742a\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:13:31.2583692+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:13:31.2583705+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"ab0c2ab5-d972-4e6a-9c0a-aa242c8fe6a0\\",\\"ShowtimeId\\":\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"e22436a8-5ace-b087-998e-9ff616dc742a\\",\\"CreatedDate\\":\\"2024-02-26T10:13:31.2583692+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:13:31.2583705+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:13:31.263695+07	2024-02-27 10:14:38.225687+07	0
12	102	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"e26ced06-1f6f-43f1-a60b-297a1a209045\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"24efc933-002f-ad02-0d98-b14ce6085b5d\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:08:19.7403242+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:08:19.7403253+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"e26ced06-1f6f-43f1-a60b-297a1a209045\\",\\"ShowtimeId\\":\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"24efc933-002f-ad02-0d98-b14ce6085b5d\\",\\"CreatedDate\\":\\"2024-02-26T10:08:19.7403242+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:08:19.7403253+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:08:19.744157+07	2024-02-27 10:09:22.914274+07	0
10	97	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"05b69018-3557-4c2c-83fa-fcf969042101\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"1e926d71-b430-008b-317b-af44259b24d8\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:08:16.7751619+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:08:16.7751859+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"05b69018-3557-4c2c-83fa-fcf969042101\\",\\"ShowtimeId\\":\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"1e926d71-b430-008b-317b-af44259b24d8\\",\\"CreatedDate\\":\\"2024-02-26T10:08:16.7751619+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:08:16.7751859+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:08:16.77808+07	2024-02-27 10:09:22.900098+07	0
11	101	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"5634543e-96c6-4fe3-83da-3b3ccdc9d425\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"e22436a8-5ace-b087-998e-9ff616dc742a\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:08:19.3915483+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:08:19.3915498+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"5634543e-96c6-4fe3-83da-3b3ccdc9d425\\",\\"ShowtimeId\\":\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"e22436a8-5ace-b087-998e-9ff616dc742a\\",\\"CreatedDate\\":\\"2024-02-26T10:08:19.3915483+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:08:19.3915498+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:08:19.395053+07	2024-02-27 10:09:22.909639+07	0
9	99	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"8ec86d1d-d311-49ac-a713-c1254e5e996a\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"586ffbb9-c764-711e-3e14-ff34e57a0b9e\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:08:16.1572487+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:08:16.1572512+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"8ec86d1d-d311-49ac-a713-c1254e5e996a\\",\\"ShowtimeId\\":\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"586ffbb9-c764-711e-3e14-ff34e57a0b9e\\",\\"CreatedDate\\":\\"2024-02-26T10:08:16.1572487+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:08:16.1572512+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:08:16.165371+07	2024-02-27 10:09:22.90008+07	0
8	98	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"c30fca71-0e15-4a60-9c7b-0b51451c4374\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"bd33fb71-66a3-cb98-385c-f381ec17c934\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:08:15.8604623+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:08:15.8605275+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"c30fca71-0e15-4a60-9c7b-0b51451c4374\\",\\"ShowtimeId\\":\\"f00a4f9b-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"bd33fb71-66a3-cb98-385c-f381ec17c934\\",\\"CreatedDate\\":\\"2024-02-26T10:08:15.8604623+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:08:15.8605275+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:08:16.085021+07	2024-02-27 10:09:22.900098+07	0
15	114	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"811daeac-aae3-4ef0-afb4-941868b95fb6\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"6e1a07c6-215f-ad63-24e4-16f7669dfe16\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:11:42.4295665+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:11:42.4295681+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"811daeac-aae3-4ef0-afb4-941868b95fb6\\",\\"ShowtimeId\\":\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"6e1a07c6-215f-ad63-24e4-16f7669dfe16\\",\\"CreatedDate\\":\\"2024-02-26T10:11:42.4295665+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:11:42.4295681+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:11:42.434572+07	2024-02-27 10:12:53.268162+07	0
17	125	Succeeded	{"Type": "BetaCinema.Application.Features.ProcessSeats.Commands.CreateProcessSeatCommandHandler, BetaCinema.Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null", "Method": "AutoDeleteAfterTimeout", "Arguments": "[\\"{\\\\\\"Id\\\\\\":\\\\\\"50ce5a05-ead9-4569-84bb-8facf3b0f649\\\\\\",\\\\\\"ShowtimeId\\\\\\":\\\\\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\\\\\",\\\\\\"SeatId\\\\\\":\\\\\\"f241f904-96b7-7b6b-ec23-998dfc27ae59\\\\\\",\\\\\\"CreatedDate\\\\\\":\\\\\\"2024-02-26T10:13:28.6862298+07:00\\\\\\",\\\\\\"CreatedBy\\\\\\":null,\\\\\\"ModifiedDate\\\\\\":\\\\\\"2024-02-26T10:13:28.6862322+07:00\\\\\\",\\\\\\"ModifiedBy\\\\\\":null,\\\\\\"DeleteFlag\\\\\\":false,\\\\\\"Seat\\\\\\":null,\\\\\\"Showtime\\\\\\":null}\\",null]", "ParameterTypes": "[\\"BetaCinema.Domain.Models.ProcessSeat, BetaCinema.Domain, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\\",\\"System.Threading.CancellationToken, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\\"]"}	["{\\"Id\\":\\"50ce5a05-ead9-4569-84bb-8facf3b0f649\\",\\"ShowtimeId\\":\\"f00a4d53-d14a-11ee-a723-c03eba28a56c\\",\\"SeatId\\":\\"f241f904-96b7-7b6b-ec23-998dfc27ae59\\",\\"CreatedDate\\":\\"2024-02-26T10:13:28.6862298+07:00\\",\\"CreatedBy\\":null,\\"ModifiedDate\\":\\"2024-02-26T10:13:28.6862322+07:00\\",\\"ModifiedBy\\":null,\\"DeleteFlag\\":false,\\"Seat\\":null,\\"Showtime\\":null}", null]	2024-02-26 10:13:28.691859+07	2024-02-27 10:14:38.217294+07	0
\.


--
-- TOC entry 4964 (class 0 OID 52824)
-- Dependencies: 233
-- Data for Name: jobparameter; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.jobparameter (id, jobid, name, value, updatecount) FROM stdin;
1	1	CurrentCulture	"vi-VN"	0
2	1	CurrentUICulture	"en-US"	0
3	2	CurrentCulture	"vi-VN"	0
4	2	CurrentUICulture	"en-US"	0
5	3	CurrentCulture	"vi-VN"	0
6	3	CurrentUICulture	"en-US"	0
7	4	CurrentCulture	"vi-VN"	0
8	4	CurrentUICulture	"en-US"	0
9	5	CurrentCulture	"vi-VN"	0
10	5	CurrentUICulture	"en-US"	0
11	6	CurrentCulture	"vi-VN"	0
12	6	CurrentUICulture	"en-US"	0
13	7	CurrentCulture	"vi-VN"	0
14	7	CurrentUICulture	"en-US"	0
19	7	RetryCount	3	0
15	3	RetryCount	4	0
18	6	RetryCount	3	0
17	5	RetryCount	3	0
16	4	RetryCount	3	0
20	8	CurrentCulture	"vi-VN"	0
21	8	CurrentUICulture	"en-US"	0
22	9	CurrentCulture	"vi-VN"	0
23	9	CurrentUICulture	"en-US"	0
24	10	CurrentCulture	"vi-VN"	0
25	10	CurrentUICulture	"en-US"	0
26	11	CurrentCulture	"vi-VN"	0
27	11	CurrentUICulture	"en-US"	0
28	12	CurrentCulture	"vi-VN"	0
29	12	CurrentUICulture	"en-US"	0
30	13	CurrentCulture	"vi-VN"	0
31	13	CurrentUICulture	"en-US"	0
32	14	CurrentCulture	"vi-VN"	0
33	14	CurrentUICulture	"en-US"	0
34	15	CurrentCulture	"vi-VN"	0
35	15	CurrentUICulture	"en-US"	0
36	16	CurrentCulture	"vi-VN"	0
37	16	CurrentUICulture	"en-US"	0
38	17	CurrentCulture	"vi-VN"	0
39	17	CurrentUICulture	"en-US"	0
40	18	CurrentCulture	"vi-VN"	0
41	18	CurrentUICulture	"en-US"	0
\.


--
-- TOC entry 4957 (class 0 OID 52789)
-- Dependencies: 226
-- Data for Name: jobqueue; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.jobqueue (id, jobid, queue, fetchedat, updatecount) FROM stdin;
\.


--
-- TOC entry 4959 (class 0 OID 52797)
-- Dependencies: 228
-- Data for Name: list; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.list (id, key, value, expireat, updatecount) FROM stdin;
\.


--
-- TOC entry 4965 (class 0 OID 52838)
-- Dependencies: 234
-- Data for Name: lock; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.lock (resource, updatecount, acquired) FROM stdin;
\.


--
-- TOC entry 4947 (class 0 OID 52739)
-- Dependencies: 216
-- Data for Name: schema; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.schema (version) FROM stdin;
21
\.


--
-- TOC entry 4960 (class 0 OID 52805)
-- Dependencies: 229
-- Data for Name: server; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.server (id, data, lastheartbeat, updatecount) FROM stdin;
user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac	{"Queues": ["default"], "StartedAt": "2024-02-26T03:07:51.731808Z", "WorkerCount": 20}	2024-02-26 10:16:52.221368+07	0
\.


--
-- TOC entry 4962 (class 0 OID 52813)
-- Dependencies: 231
-- Data for Name: set; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.set (id, key, score, value, expireat, updatecount) FROM stdin;
\.


--
-- TOC entry 4955 (class 0 OID 52774)
-- Dependencies: 224
-- Data for Name: state; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

COPY hangfire.state (id, jobid, name, reason, createdat, data, updatecount) FROM stdin;
1	1	Scheduled	\N	2024-02-26 09:31:48.186058+07	{"EnqueueAt": "2024-02-26T02:32:48.0890044Z", "ScheduledAt": "2024-02-26T02:31:48.0890998Z"}	0
2	2	Scheduled	\N	2024-02-26 09:31:48.821687+07	{"EnqueueAt": "2024-02-26T02:32:48.8115942Z", "ScheduledAt": "2024-02-26T02:31:48.8115958Z"}	0
3	1	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 09:32:49.695059+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T02:32:49.4194879Z"}	0
4	2	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 09:32:49.704814+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T02:32:49.7019982Z"}	0
5	1	Processing	\N	2024-02-26 09:32:49.712439+07	{"ServerId": "user:22228:dd1f6b5e-771c-4dc4-903e-ad27a39edc86", "WorkerId": "91149e12-78de-4fbf-af20-b343419e56e2", "StartedAt": "2024-02-26T02:32:49.7039628Z"}	0
6	2	Processing	\N	2024-02-26 09:32:49.718414+07	{"ServerId": "user:22228:dd1f6b5e-771c-4dc4-903e-ad27a39edc86", "WorkerId": "b03a5dd2-71d3-4d74-9b90-e58d218e5b5c", "StartedAt": "2024-02-26T02:32:49.7087107Z"}	0
7	2	Succeeded	\N	2024-02-26 09:32:49.770837+07	{"Latency": "60910", "SucceededAt": "2024-02-26T02:32:49.7398088Z", "PerformanceDuration": "17"}	0
8	1	Succeeded	\N	2024-02-26 09:32:49.770846+07	{"Latency": "61614", "SucceededAt": "2024-02-26T02:32:49.7398166Z", "PerformanceDuration": "19"}	0
9	3	Scheduled	\N	2024-02-26 09:59:41.765351+07	{"EnqueueAt": "2024-02-26T03:00:41.6971405Z", "ScheduledAt": "2024-02-26T02:59:41.6971962Z"}	0
10	4	Scheduled	\N	2024-02-26 09:59:42.253886+07	{"EnqueueAt": "2024-02-26T03:00:42.2428878Z", "ScheduledAt": "2024-02-26T02:59:42.2428913Z"}	0
11	5	Scheduled	\N	2024-02-26 10:00:00.006146+07	{"EnqueueAt": "2024-02-26T03:00:59.9994118Z", "ScheduledAt": "2024-02-26T02:59:59.9994136Z"}	0
12	6	Scheduled	\N	2024-02-26 10:00:00.432866+07	{"EnqueueAt": "2024-02-26T03:01:00.4223480Z", "ScheduledAt": "2024-02-26T03:00:00.4223490Z"}	0
13	7	Scheduled	\N	2024-02-26 10:00:00.882488+07	{"EnqueueAt": "2024-02-26T03:01:00.8742171Z", "ScheduledAt": "2024-02-26T03:00:00.8742180Z"}	0
14	3	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:00:49.019362+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:00:49.0051675Z"}	0
15	4	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:00:49.029674+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:00:49.0253631Z"}	0
17	4	Processing	\N	2024-02-26 10:00:49.036203+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "6f691404-9db5-4447-8179-65a846d1fa86", "StartedAt": "2024-02-26T03:00:49.0334248Z"}	0
16	3	Processing	\N	2024-02-26 10:00:49.035225+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "10d690d9-834c-45f7-9ada-6922d68874c8", "StartedAt": "2024-02-26T03:00:49.0282605Z"}	0
19	3	Failed	An exception occurred during performance of the job.	2024-02-26 10:00:49.169326+07	{"FailedAt": "2024-02-26T03:00:49.0843416Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
18	4	Failed	An exception occurred during performance of the job.	2024-02-26 10:00:49.169291+07	{"FailedAt": "2024-02-26T03:00:49.0843503Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
20	3	Scheduled	Retry attempt 1 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:00:49.175402+07	{"EnqueueAt": "2024-02-26T03:01:18.0968198Z", "ScheduledAt": "2024-02-26T03:00:49.0968233Z"}	0
21	4	Scheduled	Retry attempt 1 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:00:49.175604+07	{"EnqueueAt": "2024-02-26T03:01:28.0976383Z", "ScheduledAt": "2024-02-26T03:00:49.0976388Z"}	0
22	5	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:04.047645+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:04.0445306Z"}	0
23	6	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:04.054851+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:04.0518287Z"}	0
24	5	Processing	\N	2024-02-26 10:01:04.058021+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "6f691404-9db5-4447-8179-65a846d1fa86", "StartedAt": "2024-02-26T03:01:04.0522360Z"}	0
25	7	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:04.061452+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:04.0582267Z"}	0
26	6	Processing	\N	2024-02-26 10:01:04.064548+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "10d690d9-834c-45f7-9ada-6922d68874c8", "StartedAt": "2024-02-26T03:01:04.0597819Z"}	0
27	7	Processing	\N	2024-02-26 10:01:04.071409+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "90d1a885-d809-4852-8242-300c519fe3ac", "StartedAt": "2024-02-26T03:01:04.0653243Z"}	0
29	6	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:04.086069+07	{"FailedAt": "2024-02-26T03:01:04.0810294Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
28	5	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:04.085223+07	{"FailedAt": "2024-02-26T03:01:04.0785362Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
31	5	Scheduled	Retry attempt 1 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:04.087934+07	{"EnqueueAt": "2024-02-26T03:01:46.0839578Z", "ScheduledAt": "2024-02-26T03:01:04.0839590Z"}	0
49	7	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:49.169405+07	{"FailedAt": "2024-02-26T03:01:49.1596538Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
50	7	Scheduled	Retry attempt 2 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:49.170807+07	{"EnqueueAt": "2024-02-26T03:02:15.1681204Z", "ScheduledAt": "2024-02-26T03:01:49.1681240Z"}	0
32	7	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:04.088396+07	{"FailedAt": "2024-02-26T03:01:04.0788313Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
33	7	Scheduled	Retry attempt 1 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:04.092679+07	{"EnqueueAt": "2024-02-26T03:01:35.0871182Z", "ScheduledAt": "2024-02-26T03:01:04.0871193Z"}	0
40	4	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:34.133489+07	{"FailedAt": "2024-02-26T03:01:34.1282937Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
41	4	Scheduled	Retry attempt 2 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:34.136538+07	{"EnqueueAt": "2024-02-26T03:01:54.1323526Z", "ScheduledAt": "2024-02-26T03:01:34.1323540Z"}	0
46	6	Processing	\N	2024-02-26 10:01:49.158739+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "c546974f-4893-43ea-8d04-f13c09c93a69", "StartedAt": "2024-02-26T03:01:49.1527604Z"}	0
52	6	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:49.172993+07	{"FailedAt": "2024-02-26T03:01:49.1634585Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
53	6	Scheduled	Retry attempt 2 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:49.174539+07	{"EnqueueAt": "2024-02-26T03:02:09.1718962Z", "ScheduledAt": "2024-02-26T03:01:49.1718977Z"}	0
56	5	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:49.193629+07	{"FailedAt": "2024-02-26T03:01:49.1830740Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
57	5	Scheduled	Retry attempt 2 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:49.197048+07	{"EnqueueAt": "2024-02-26T03:02:59.1924119Z", "ScheduledAt": "2024-02-26T03:01:49.1924130Z"}	0
69	5	Failed	An exception occurred during performance of the job.	2024-02-26 10:07:52.935516+07	{"FailedAt": "2024-02-26T03:07:52.8235671Z", "ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync(HubConnection hubConnection, String methodName, Object arg1, CancellationToken cancellationToken)\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 283\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
72	6	Failed	An exception occurred during performance of the job.	2024-02-26 10:07:52.935507+07	{"FailedAt": "2024-02-26T03:07:52.8235916Z", "ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync(HubConnection hubConnection, String methodName, Object arg1, CancellationToken cancellationToken)\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 283\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
71	3	Failed	An exception occurred during performance of the job.	2024-02-26 10:07:52.935485+07	{"FailedAt": "2024-02-26T03:07:52.8235645Z", "ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync(HubConnection hubConnection, String methodName, Object arg1, CancellationToken cancellationToken)\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 283\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
73	6	Scheduled	Retry attempt 3 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:07:52.94634+07	{"EnqueueAt": "2024-02-26T03:08:53.8455206Z", "ScheduledAt": "2024-02-26T03:07:52.8456714Z"}	0
75	4	Scheduled	Retry attempt 3 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:07:52.947935+07	{"EnqueueAt": "2024-02-26T03:09:47.8458686Z", "ScheduledAt": "2024-02-26T03:07:52.8458688Z"}	0
74	5	Scheduled	Retry attempt 3 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:07:52.94669+07	{"EnqueueAt": "2024-02-26T03:09:05.8456861Z", "ScheduledAt": "2024-02-26T03:07:52.8456867Z"}	0
76	3	Scheduled	Retry attempt 4 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:07:52.94637+07	{"EnqueueAt": "2024-02-26T03:10:12.8458609Z", "ScheduledAt": "2024-02-26T03:07:52.8458614Z"}	0
77	7	Scheduled	Retry attempt 3 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:07:52.951268+07	{"EnqueueAt": "2024-02-26T03:09:44.8455205Z", "ScheduledAt": "2024-02-26T03:07:52.8455996Z"}	0
30	6	Scheduled	Retry attempt 1 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:04.087513+07	{"EnqueueAt": "2024-02-26T03:01:36.0850581Z", "ScheduledAt": "2024-02-26T03:01:04.0850591Z"}	0
35	3	Processing	\N	2024-02-26 10:01:19.097853+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "6f691404-9db5-4447-8179-65a846d1fa86", "StartedAt": "2024-02-26T03:01:19.0941910Z"}	0
34	3	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:19.089421+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:19.0856560Z"}	0
36	3	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:19.114554+07	{"FailedAt": "2024-02-26T03:01:19.1029734Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
37	3	Scheduled	Retry attempt 2 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:19.117103+07	{"EnqueueAt": "2024-02-26T03:01:45.1137084Z", "ScheduledAt": "2024-02-26T03:01:19.1137092Z"}	0
38	4	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:34.110646+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:34.1058430Z"}	0
39	4	Processing	\N	2024-02-26 10:01:34.121451+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "6f691404-9db5-4447-8179-65a846d1fa86", "StartedAt": "2024-02-26T03:01:34.1183767Z"}	0
42	7	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:49.140236+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:49.1358125Z"}	0
43	6	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:49.148826+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:49.1437273Z"}	0
44	7	Processing	\N	2024-02-26 10:01:49.154298+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "6f691404-9db5-4447-8179-65a846d1fa86", "StartedAt": "2024-02-26T03:01:49.1449714Z"}	0
45	3	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:49.155572+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:49.1522957Z"}	0
47	5	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:01:49.161872+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:01:49.1586245Z"}	0
48	3	Processing	\N	2024-02-26 10:01:49.166151+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "75b3ec1e-0cc2-4fb7-9071-6d2c22571718", "StartedAt": "2024-02-26T03:01:49.1586991Z"}	0
51	5	Processing	\N	2024-02-26 10:01:49.170588+07	{"ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "WorkerId": "432a3ec7-6ed4-4ffc-9c12-1911caac91c1", "StartedAt": "2024-02-26T03:01:49.1659517Z"}	0
54	3	Failed	An exception occurred during performance of the job.	2024-02-26 10:01:49.187654+07	{"FailedAt": "2024-02-26T03:01:49.1736371Z", "ServerId": "user:2732:384f64f1-31ca-4118-bc46-eaa60479210c", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 285\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
55	3	Scheduled	Retry attempt 3 of 10: Object reference not set to an instance of an obj…	2024-02-26 10:01:49.190685+07	{"EnqueueAt": "2024-02-26T03:03:11.1863841Z", "ScheduledAt": "2024-02-26T03:01:49.1863849Z"}	0
58	4	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:07:52.704132+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:07:52.4655379Z"}	0
59	6	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:07:52.742835+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:07:52.7315827Z"}	0
60	4	Processing	\N	2024-02-26 10:07:52.753759+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "a252fa68-1846-46af-ab05-f57bc16fbc46", "StartedAt": "2024-02-26T03:07:52.7330825Z"}	0
61	7	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:07:52.757495+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:07:52.7528475Z"}	0
62	6	Processing	\N	2024-02-26 10:07:52.758683+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "465538a7-a792-4380-b075-5a3cfb5aac22", "StartedAt": "2024-02-26T03:07:52.7545499Z"}	0
63	7	Processing	\N	2024-02-26 10:07:52.765545+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "62876139-4d38-4e78-b664-eb8b182d896b", "StartedAt": "2024-02-26T03:07:52.7619431Z"}	0
64	5	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:07:52.76691+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:07:52.7616163Z"}	0
65	5	Processing	\N	2024-02-26 10:07:52.775621+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "9a25a56e-162d-40ad-8c9f-dc511e3ed64a", "StartedAt": "2024-02-26T03:07:52.7714386Z"}	0
66	3	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:07:52.77686+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:07:52.7714831Z"}	0
67	3	Processing	\N	2024-02-26 10:07:52.788924+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "b349c242-155b-45dc-a3ca-956d8d31d393", "StartedAt": "2024-02-26T03:07:52.7840996Z"}	0
68	4	Failed	An exception occurred during performance of the job.	2024-02-26 10:07:52.935469+07	{"FailedAt": "2024-02-26T03:07:52.8235777Z", "ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync(HubConnection hubConnection, String methodName, Object arg1, CancellationToken cancellationToken)\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 283\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
70	7	Failed	An exception occurred during performance of the job.	2024-02-26 10:07:52.935446+07	{"FailedAt": "2024-02-26T03:07:52.8235670Z", "ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "ExceptionType": "System.NullReferenceException", "ExceptionDetails": "System.NullReferenceException: Object reference not set to an instance of an object.\\r\\n   at Microsoft.AspNetCore.SignalR.Client.HubConnectionExtensions.SendAsync(HubConnection hubConnection, String methodName, Object arg1, CancellationToken cancellationToken)\\r\\n   at BetaCinema.ServerUI.Pages.Reservation.ReservationBase.TimerOutCallback() in D:\\\\Workspace\\\\blazor\\\\BetaCinema\\\\BetaCinema.ServerUI\\\\Pages\\\\Reservation\\\\Reservation.razor.cs:line 283\\r\\n   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()", "ExceptionMessage": "Object reference not set to an instance of an object."}	0
78	7	Deleted	Triggered via Dashboard UI	2024-02-26 10:07:57.97565+07	{"DeletedAt": "2024-02-26T03:07:57.9537035Z"}	0
79	6	Deleted	Triggered via Dashboard UI	2024-02-26 10:07:57.987758+07	{"DeletedAt": "2024-02-26T03:07:57.9818115Z"}	0
87	12	Scheduled	\N	2024-02-26 10:08:19.748947+07	{"EnqueueAt": "2024-02-26T03:09:19.7439307Z", "ScheduledAt": "2024-02-26T03:08:19.7439319Z"}	0
93	10	Processing	\N	2024-02-26 10:09:22.889129+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "62876139-4d38-4e78-b664-eb8b182d896b", "StartedAt": "2024-02-26T03:09:22.8866096Z"}	0
99	9	Succeeded	\N	2024-02-26 10:09:22.900971+07	{"Latency": "66722", "SucceededAt": "2024-02-26T03:09:22.8958307Z", "PerformanceDuration": "7"}	0
80	5	Deleted	Triggered via Dashboard UI	2024-02-26 10:07:57.998086+07	{"DeletedAt": "2024-02-26T03:07:57.9907538Z"}	0
81	4	Deleted	Triggered via Dashboard UI	2024-02-26 10:07:58.009695+07	{"DeletedAt": "2024-02-26T03:07:58.0008080Z"}	0
96	11	Processing	\N	2024-02-26 10:09:22.898785+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "9a25a56e-162d-40ad-8c9f-dc511e3ed64a", "StartedAt": "2024-02-26T03:09:22.8959191Z"}	0
98	8	Succeeded	\N	2024-02-26 10:09:22.901+07	{"Latency": "66793", "SucceededAt": "2024-02-26T03:09:22.8963305Z", "PerformanceDuration": "17"}	0
101	11	Succeeded	\N	2024-02-26 10:09:22.91042+07	{"Latency": "63507", "SucceededAt": "2024-02-26T03:09:22.9063125Z", "PerformanceDuration": "4"}	0
103	13	Scheduled	\N	2024-02-26 10:11:41.003902+07	{"EnqueueAt": "2024-02-26T03:12:40.9934970Z", "ScheduledAt": "2024-02-26T03:11:40.9935075Z"}	0
105	15	Scheduled	\N	2024-02-26 10:11:42.445354+07	{"EnqueueAt": "2024-02-26T03:12:42.4343233Z", "ScheduledAt": "2024-02-26T03:11:42.4343253Z"}	0
82	3	Deleted	Triggered via Dashboard UI	2024-02-26 10:07:58.02501+07	{"DeletedAt": "2024-02-26T03:07:58.0188502Z"}	0
84	9	Scheduled	\N	2024-02-26 10:08:16.169447+07	{"EnqueueAt": "2024-02-26T03:09:16.1632107Z", "ScheduledAt": "2024-02-26T03:08:16.1632120Z"}	0
89	8	Processing	\N	2024-02-26 10:09:22.876352+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "b349c242-155b-45dc-a3ca-956d8d31d393", "StartedAt": "2024-02-26T03:09:22.8740309Z"}	0
97	10	Succeeded	\N	2024-02-26 10:09:22.900983+07	{"Latency": "66113", "SucceededAt": "2024-02-26T03:09:22.8962787Z", "PerformanceDuration": "4"}	0
83	8	Scheduled	\N	2024-02-26 10:08:16.112263+07	{"EnqueueAt": "2024-02-26T03:09:16.0665371Z", "ScheduledAt": "2024-02-26T03:08:16.0665422Z"}	0
88	8	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:09:22.870258+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:09:22.8660316Z"}	0
90	9	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:09:22.876634+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:09:22.8737652Z"}	0
91	10	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:09:22.883248+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:09:22.8794037Z"}	0
94	11	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:09:22.890278+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:09:22.8864601Z"}	0
95	12	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:09:22.898454+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:09:22.8935422Z"}	0
102	12	Succeeded	\N	2024-02-26 10:09:22.915217+07	{"Latency": "63162", "SucceededAt": "2024-02-26T03:09:22.9103800Z", "PerformanceDuration": "3"}	0
104	14	Scheduled	\N	2024-02-26 10:11:41.687086+07	{"EnqueueAt": "2024-02-26T03:12:41.6752939Z", "ScheduledAt": "2024-02-26T03:11:41.6752958Z"}	0
85	10	Scheduled	\N	2024-02-26 10:08:16.783335+07	{"EnqueueAt": "2024-02-26T03:09:16.7778519Z", "ScheduledAt": "2024-02-26T03:08:16.7778537Z"}	0
86	11	Scheduled	\N	2024-02-26 10:08:19.398591+07	{"EnqueueAt": "2024-02-26T03:09:19.3948364Z", "ScheduledAt": "2024-02-26T03:08:19.3948377Z"}	0
92	9	Processing	\N	2024-02-26 10:09:22.884482+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "465538a7-a792-4380-b075-5a3cfb5aac22", "StartedAt": "2024-02-26T03:09:22.8798084Z"}	0
100	12	Processing	\N	2024-02-26 10:09:22.904205+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "a252fa68-1846-46af-ab05-f57bc16fbc46", "StartedAt": "2024-02-26T03:09:22.9018103Z"}	0
106	13	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:12:53.076329+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:12:53.0678073Z"}	0
107	14	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:12:53.087868+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:12:53.0833122Z"}	0
108	15	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:12:53.0972+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:12:53.0928372Z"}	0
109	13	Processing	\N	2024-02-26 10:12:53.096884+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "a706236d-0343-4068-a2c6-e34f98bf8418", "StartedAt": "2024-02-26T03:12:53.0835393Z"}	0
110	14	Processing	\N	2024-02-26 10:12:53.106787+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "969edaf7-bc95-444c-a71a-96a562479ca3", "StartedAt": "2024-02-26T03:12:53.0942408Z"}	0
111	15	Processing	\N	2024-02-26 10:12:53.113229+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "282604db-ceb3-47e7-8013-3a58206d04cf", "StartedAt": "2024-02-26T03:12:53.1015959Z"}	0
112	13	Succeeded	\N	2024-02-26 10:12:53.25156+07	{"Latency": "72108", "SucceededAt": "2024-02-26T03:12:53.2357783Z", "PerformanceDuration": "132"}	0
113	14	Succeeded	\N	2024-02-26 10:12:53.270039+07	{"Latency": "71438", "SucceededAt": "2024-02-26T03:12:53.2608364Z", "PerformanceDuration": "147"}	0
114	15	Succeeded	\N	2024-02-26 10:12:53.270331+07	{"Latency": "70685", "SucceededAt": "2024-02-26T03:12:53.2639599Z", "PerformanceDuration": "143"}	0
115	16	Scheduled	\N	2024-02-26 10:13:27.931+07	{"EnqueueAt": "2024-02-26T03:14:27.9175512Z", "ScheduledAt": "2024-02-26T03:13:27.9175561Z"}	0
116	17	Scheduled	\N	2024-02-26 10:13:28.695154+07	{"EnqueueAt": "2024-02-26T03:14:28.6916451Z", "ScheduledAt": "2024-02-26T03:13:28.6916470Z"}	0
117	18	Scheduled	\N	2024-02-26 10:13:31.272222+07	{"EnqueueAt": "2024-02-26T03:14:31.2634383Z", "ScheduledAt": "2024-02-26T03:13:31.2634409Z"}	0
118	16	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:14:38.174946+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:14:38.1680649Z"}	0
120	17	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:14:38.190852+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:14:38.1861561Z"}	0
119	16	Processing	\N	2024-02-26 10:14:38.190095+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "282604db-ceb3-47e7-8013-3a58206d04cf", "StartedAt": "2024-02-26T03:14:38.1865353Z"}	0
121	17	Processing	\N	2024-02-26 10:14:38.200255+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "969edaf7-bc95-444c-a71a-96a562479ca3", "StartedAt": "2024-02-26T03:14:38.1970574Z"}	0
122	18	Enqueued	Triggered by DelayedJobScheduler	2024-02-26 10:14:38.200778+07	{"Queue": "default", "EnqueuedAt": "2024-02-26T03:14:38.1961748Z"}	0
123	18	Processing	\N	2024-02-26 10:14:38.212263+07	{"ServerId": "user:13200:1f10ca89-93f0-4cc7-a1d8-4c578db1ccac", "WorkerId": "a706236d-0343-4068-a2c6-e34f98bf8418", "StartedAt": "2024-02-26T03:14:38.2049452Z"}	0
124	16	Succeeded	\N	2024-02-26 10:14:38.215437+07	{"Latency": "70278", "SucceededAt": "2024-02-26T03:14:38.2096561Z", "PerformanceDuration": "13"}	0
125	17	Succeeded	\N	2024-02-26 10:14:38.218373+07	{"Latency": "69512", "SucceededAt": "2024-02-26T03:14:38.2135254Z", "PerformanceDuration": "9"}	0
126	18	Succeeded	\N	2024-02-26 10:14:38.227663+07	{"Latency": "66953", "SucceededAt": "2024-02-26T03:14:38.2220447Z", "PerformanceDuration": "4"}	0
\.


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 235
-- Name: aggregatedcounter_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.aggregatedcounter_id_seq', 9, true);


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 217
-- Name: counter_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.counter_id_seq', 54, true);


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 219
-- Name: hash_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.hash_id_seq', 1, false);


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 221
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.job_id_seq', 18, true);


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 232
-- Name: jobparameter_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.jobparameter_id_seq', 41, true);


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 225
-- Name: jobqueue_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.jobqueue_id_seq', 29, true);


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 227
-- Name: list_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.list_id_seq', 1, false);


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 230
-- Name: set_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.set_id_seq', 50, true);


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 223
-- Name: state_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.state_id_seq', 126, true);


--
-- TOC entry 4799 (class 2606 OID 53039)
-- Name: aggregatedcounter aggregatedcounter_key_key; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.aggregatedcounter
    ADD CONSTRAINT aggregatedcounter_key_key UNIQUE (key);


--
-- TOC entry 4801 (class 2606 OID 53037)
-- Name: aggregatedcounter aggregatedcounter_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.aggregatedcounter
    ADD CONSTRAINT aggregatedcounter_pkey PRIMARY KEY (id);


--
-- TOC entry 4762 (class 2606 OID 52873)
-- Name: counter counter_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.counter
    ADD CONSTRAINT counter_pkey PRIMARY KEY (id);


--
-- TOC entry 4766 (class 2606 OID 53008)
-- Name: hash hash_key_field_key; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.hash
    ADD CONSTRAINT hash_key_field_key UNIQUE (key, field);


--
-- TOC entry 4768 (class 2606 OID 52882)
-- Name: hash hash_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.hash
    ADD CONSTRAINT hash_pkey PRIMARY KEY (id);


--
-- TOC entry 4773 (class 2606 OID 52892)
-- Name: job job_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- TOC entry 4795 (class 2606 OID 52942)
-- Name: jobparameter jobparameter_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobparameter
    ADD CONSTRAINT jobparameter_pkey PRIMARY KEY (id);


--
-- TOC entry 4780 (class 2606 OID 52965)
-- Name: jobqueue jobqueue_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobqueue
    ADD CONSTRAINT jobqueue_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 52985)
-- Name: list list_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.list
    ADD CONSTRAINT list_pkey PRIMARY KEY (id);


--
-- TOC entry 4797 (class 2606 OID 52864)
-- Name: lock lock_resource_key; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.lock
    ADD CONSTRAINT lock_resource_key UNIQUE (resource);

ALTER TABLE ONLY hangfire.lock REPLICA IDENTITY USING INDEX lock_resource_key;


--
-- TOC entry 4760 (class 2606 OID 52743)
-- Name: schema schema_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.schema
    ADD CONSTRAINT schema_pkey PRIMARY KEY (version);


--
-- TOC entry 4786 (class 2606 OID 53011)
-- Name: server server_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.server
    ADD CONSTRAINT server_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 53013)
-- Name: set set_key_value_key; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.set
    ADD CONSTRAINT set_key_value_key UNIQUE (key, value);


--
-- TOC entry 4792 (class 2606 OID 52994)
-- Name: set set_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.set
    ADD CONSTRAINT set_pkey PRIMARY KEY (id);


--
-- TOC entry 4776 (class 2606 OID 52919)
-- Name: state state_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id);


--
-- TOC entry 4763 (class 1259 OID 53047)
-- Name: ix_hangfire_counter_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_counter_expireat ON hangfire.counter USING btree (expireat);


--
-- TOC entry 4764 (class 1259 OID 53002)
-- Name: ix_hangfire_counter_key; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_counter_key ON hangfire.counter USING btree (key);


--
-- TOC entry 4769 (class 1259 OID 53056)
-- Name: ix_hangfire_hash_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_hash_expireat ON hangfire.hash USING btree (expireat);


--
-- TOC entry 4770 (class 1259 OID 53073)
-- Name: ix_hangfire_job_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_job_expireat ON hangfire.job USING btree (expireat);


--
-- TOC entry 4771 (class 1259 OID 53009)
-- Name: ix_hangfire_job_statename; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_job_statename ON hangfire.job USING btree (statename);


--
-- TOC entry 4793 (class 1259 OID 53014)
-- Name: ix_hangfire_jobparameter_jobidandname; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_jobparameter_jobidandname ON hangfire.jobparameter USING btree (jobid, name);


--
-- TOC entry 4777 (class 1259 OID 52974)
-- Name: ix_hangfire_jobqueue_jobidandqueue; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_jobqueue_jobidandqueue ON hangfire.jobqueue USING btree (jobid, queue);


--
-- TOC entry 4778 (class 1259 OID 53082)
-- Name: ix_hangfire_jobqueue_queueandfetchedat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_jobqueue_queueandfetchedat ON hangfire.jobqueue USING btree (queue, fetchedat);


--
-- TOC entry 4782 (class 1259 OID 53093)
-- Name: ix_hangfire_list_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_list_expireat ON hangfire.list USING btree (expireat);


--
-- TOC entry 4787 (class 1259 OID 53113)
-- Name: ix_hangfire_set_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_set_expireat ON hangfire.set USING btree (expireat);


--
-- TOC entry 4788 (class 1259 OID 53028)
-- Name: ix_hangfire_set_key_score; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_set_key_score ON hangfire.set USING btree (key, score);


--
-- TOC entry 4774 (class 1259 OID 52927)
-- Name: ix_hangfire_state_jobid; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_state_jobid ON hangfire.state USING btree (jobid);


--
-- TOC entry 4781 (class 1259 OID 53083)
-- Name: jobqueue_queue_fetchat_jobid; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX jobqueue_queue_fetchat_jobid ON hangfire.jobqueue USING btree (queue, fetchedat, jobid);


--
-- TOC entry 4803 (class 2606 OID 52951)
-- Name: jobparameter jobparameter_jobid_fkey; Type: FK CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobparameter
    ADD CONSTRAINT jobparameter_jobid_fkey FOREIGN KEY (jobid) REFERENCES hangfire.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4802 (class 2606 OID 52928)
-- Name: state state_jobid_fkey; Type: FK CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.state
    ADD CONSTRAINT state_jobid_fkey FOREIGN KEY (jobid) REFERENCES hangfire.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2024-02-26 10:17:18

--
-- PostgreSQL database dump complete
--

