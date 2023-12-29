--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2023-12-29 15:19:10

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 35846)
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    "Id" text NOT NULL,
    "CategoryName" character varying(255) NOT NULL,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 35855)
-- Name: Cinema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cinema" (
    "Id" text NOT NULL,
    "CinemaName" character varying(50) NOT NULL,
    "CinemaLocation" character varying(255) NOT NULL,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."Cinema" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 35864)
-- Name: Movie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Movie" (
    "Id" text NOT NULL,
    "MovieName" character varying(255) NOT NULL,
    "Poster" text,
    "Duration" integer NOT NULL,
    "ReleaseDate" timestamp without time zone DEFAULT now(),
    "Director" character varying(255) DEFAULT NULL::character varying,
    "Actor" character varying(255) DEFAULT NULL::character varying,
    "Description" text,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."Movie" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 35903)
-- Name: MovieCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MovieCategory" (
    "Id" text NOT NULL,
    "MovieId" text NOT NULL,
    "CategoryId" text NOT NULL,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."MovieCategory" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 36028)
-- Name: Payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Payment" (
    "Id" text NOT NULL,
    "ReservationId" text NOT NULL,
    "TotalPrice" integer NOT NULL,
    "PaymentMethod" character varying(255) NOT NULL,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."Payment" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 36009)
-- Name: Reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Reservation" (
    "Id" text NOT NULL,
    "ShowtimeId" text NOT NULL,
    "UserId" text NOT NULL,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."Reservation" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 36042)
-- Name: ReservationItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ReservationItem" (
    "Id" text NOT NULL,
    "ReservationId" text NOT NULL,
    "SeatId" text NOT NULL,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."ReservationItem" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 35943)
-- Name: RoleClaims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RoleClaims" (
    "Id" integer NOT NULL,
    "RoleId" text NOT NULL,
    "ClaimType" text,
    "ClaimValue" text
);


ALTER TABLE public."RoleClaims" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 35942)
-- Name: RoleClaims_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."RoleClaims" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."RoleClaims_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 35876)
-- Name: Roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Roles" (
    "Id" text NOT NULL,
    "Name" character varying(256),
    "NormalizedName" character varying(256),
    "ConcurrencyStamp" text
);


ALTER TABLE public."Roles" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 35883)
-- Name: Seat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Seat" (
    "Id" text NOT NULL,
    "RowNum" character varying(1) NOT NULL,
    "SeatNum" integer NOT NULL,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."Seat" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 35922)
-- Name: Showtime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Showtime" (
    "Id" text NOT NULL,
    "MovieId" text NOT NULL,
    "CinemaId" text NOT NULL,
    "StartTime" timestamp without time zone DEFAULT now(),
    "TicketPrice" integer NOT NULL,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public."Showtime" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 35892)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "Id" text NOT NULL,
    "FullName" character varying(100) NOT NULL,
    "Password" character varying(100) NOT NULL,
    "Role" character varying(25) NOT NULL,
    "Avatar" text,
    "DeleteFlag" boolean NOT NULL,
    "CreatedDate" timestamp without time zone DEFAULT now() NOT NULL,
    "CreatedBy" character varying(100) DEFAULT NULL::character varying,
    "ModifiedDate" timestamp without time zone DEFAULT now() NOT NULL,
    "ModifiedBy" character varying(100) DEFAULT NULL::character varying,
    "UserName" character varying(256),
    "NormalizedUserName" character varying(256),
    "Email" character varying(100),
    "NormalizedEmail" character varying(256),
    "EmailConfirmed" boolean NOT NULL,
    "PasswordHash" text,
    "SecurityStamp" text,
    "ConcurrencyStamp" text,
    "PhoneNumber" text,
    "PhoneNumberConfirmed" boolean NOT NULL,
    "TwoFactorEnabled" boolean NOT NULL,
    "LockoutEnd" timestamp with time zone,
    "LockoutEnabled" boolean NOT NULL,
    "AccessFailedCount" integer NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 35956)
-- Name: UserClaims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserClaims" (
    "Id" integer NOT NULL,
    "UserId" text NOT NULL,
    "ClaimType" text,
    "ClaimValue" text
);


ALTER TABLE public."UserClaims" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 35955)
-- Name: UserClaims_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."UserClaims" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."UserClaims_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 35968)
-- Name: UserLogins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserLogins" (
    "LoginProvider" text NOT NULL,
    "ProviderKey" text NOT NULL,
    "ProviderDisplayName" text,
    "UserId" text NOT NULL
);


ALTER TABLE public."UserLogins" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 35980)
-- Name: UserRoles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRoles" (
    "UserId" text NOT NULL,
    "RoleId" text NOT NULL
);


ALTER TABLE public."UserRoles" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 35997)
-- Name: UserTokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserTokens" (
    "UserId" text NOT NULL,
    "LoginProvider" text NOT NULL,
    "Name" text NOT NULL,
    "Value" text
);


ALTER TABLE public."UserTokens" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 35841)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- TOC entry 4979 (class 0 OID 35846)
-- Dependencies: 216
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" ("Id", "CategoryName", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4980 (class 0 OID 35855)
-- Dependencies: 217
-- Data for Name: Cinema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cinema" ("Id", "CinemaName", "CinemaLocation", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4981 (class 0 OID 35864)
-- Dependencies: 218
-- Data for Name: Movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Movie" ("Id", "MovieName", "Poster", "Duration", "ReleaseDate", "Director", "Actor", "Description", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4985 (class 0 OID 35903)
-- Dependencies: 222
-- Data for Name: MovieCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MovieCategory" ("Id", "MovieId", "CategoryId", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4995 (class 0 OID 36028)
-- Dependencies: 232
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Payment" ("Id", "ReservationId", "TotalPrice", "PaymentMethod", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4994 (class 0 OID 36009)
-- Dependencies: 231
-- Data for Name: Reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Reservation" ("Id", "ShowtimeId", "UserId", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4996 (class 0 OID 36042)
-- Dependencies: 233
-- Data for Name: ReservationItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ReservationItem" ("Id", "ReservationId", "SeatId", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4988 (class 0 OID 35943)
-- Dependencies: 225
-- Data for Name: RoleClaims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RoleClaims" ("Id", "RoleId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- TOC entry 4982 (class 0 OID 35876)
-- Dependencies: 219
-- Data for Name: Roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Roles" ("Id", "Name", "NormalizedName", "ConcurrencyStamp") FROM stdin;
e989c4ca-e1e7-4f7e-9e6c-a014e87e89fc	Admin	ADMIN	dea2237f-0d72-41f8-afbb-8cd386422fc4
7a6f0e8b-0705-4eaf-9714-14819cef32e8	Customer	CUSTOMER	3d0254b5-9b4f-4a89-96c7-97fd619e202f
\.


--
-- TOC entry 4983 (class 0 OID 35883)
-- Dependencies: 220
-- Data for Name: Seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Seat" ("Id", "RowNum", "SeatNum", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4986 (class 0 OID 35922)
-- Dependencies: 223
-- Data for Name: Showtime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Showtime" ("Id", "MovieId", "CinemaId", "StartTime", "TicketPrice", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
\.


--
-- TOC entry 4984 (class 0 OID 35892)
-- Dependencies: 221
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("Id", "FullName", "Password", "Role", "Avatar", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy", "UserName", "NormalizedUserName", "Email", "NormalizedEmail", "EmailConfirmed", "PasswordHash", "SecurityStamp", "ConcurrencyStamp", "PhoneNumber", "PhoneNumberConfirmed", "TwoFactorEnabled", "LockoutEnd", "LockoutEnabled", "AccessFailedCount") FROM stdin;
a6d1e91f-ef87-4635-93be-c6fc9fb6e3c6	Admin	000000	Admin	\N	f	2023-12-29 15:16:32.915467	\N	2023-12-29 15:16:32.915467	\N	Admin	ADMIN	admin@gmail.com	ADMIN@GMAIL.COM	f	AQAAAAEAACcQAAAAEBlwxq4+Vg2Wa2FAqAkgUE77BX1VakNo84I3/+EJC2U7ZbIUR329fMYtkSH3Aooolw==	4X6CCTXQY77LAAMD3AU6IKXTLAB7DWWE	e5935268-0dfd-479e-9c82-c8104e649274	\N	f	f	\N	t	0
73c0576b-9018-4672-9056-537c7a9d732d	tangtheanh123456789@gmail.com	tangtheanh123456789@gmail.com	Customer	\N	f	2023-12-29 15:16:54.499373	\N	2023-12-29 15:16:54.499373	\N	tangtheanh123456789@gmail.com	TANGTHEANH123456789@GMAIL.COM	tangtheanh123456789@gmail.com	TANGTHEANH123456789@GMAIL.COM	f	\N	7YOA3WMNWRHA3GPL4LYI3LQ6BRFROYCP	dfd6d9b8-ad20-4c62-b6f9-bf256d1c63a1	\N	f	f	\N	t	0
b0eb9a80-03c5-4e2d-ad63-67667807cb69	anhtheit2002@gmail.com	anhtheit2002@gmail.com	Customer	\N	f	2023-12-29 15:17:05.226824	\N	2023-12-29 15:17:05.226824	\N	anhtheit2002@gmail.com	ANHTHEIT2002@GMAIL.COM	anhtheit2002@gmail.com	ANHTHEIT2002@GMAIL.COM	f	\N	PIZYUORUIDHCPBBROM5WEZDGPSNXXCNF	b0e50f04-cee0-45d0-956d-e4b99bfc7691	\N	f	f	\N	t	0
\.


--
-- TOC entry 4990 (class 0 OID 35956)
-- Dependencies: 227
-- Data for Name: UserClaims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserClaims" ("Id", "UserId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- TOC entry 4991 (class 0 OID 35968)
-- Dependencies: 228
-- Data for Name: UserLogins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserLogins" ("LoginProvider", "ProviderKey", "ProviderDisplayName", "UserId") FROM stdin;
Google	105982558848847467093	Google	73c0576b-9018-4672-9056-537c7a9d732d
Google	105847268326525868540	Google	b0eb9a80-03c5-4e2d-ad63-67667807cb69
\.


--
-- TOC entry 4992 (class 0 OID 35980)
-- Dependencies: 229
-- Data for Name: UserRoles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRoles" ("UserId", "RoleId") FROM stdin;
a6d1e91f-ef87-4635-93be-c6fc9fb6e3c6	e989c4ca-e1e7-4f7e-9e6c-a014e87e89fc
73c0576b-9018-4672-9056-537c7a9d732d	7a6f0e8b-0705-4eaf-9714-14819cef32e8
b0eb9a80-03c5-4e2d-ad63-67667807cb69	7a6f0e8b-0705-4eaf-9714-14819cef32e8
\.


--
-- TOC entry 4993 (class 0 OID 35997)
-- Dependencies: 230
-- Data for Name: UserTokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserTokens" ("UserId", "LoginProvider", "Name", "Value") FROM stdin;
\.


--
-- TOC entry 4978 (class 0 OID 35841)
-- Dependencies: 215
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20231229081546_Initial	7.0.11
\.


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 224
-- Name: RoleClaims_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."RoleClaims_Id_seq"', 1, false);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 226
-- Name: UserClaims_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserClaims_Id_seq"', 1, false);


--
-- TOC entry 4802 (class 2606 OID 35949)
-- Name: RoleClaims PK_RoleClaims; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RoleClaims"
    ADD CONSTRAINT "PK_RoleClaims" PRIMARY KEY ("Id");


--
-- TOC entry 4788 (class 2606 OID 35882)
-- Name: Roles PK_Roles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Roles"
    ADD CONSTRAINT "PK_Roles" PRIMARY KEY ("Id");


--
-- TOC entry 4805 (class 2606 OID 35962)
-- Name: UserClaims PK_UserClaims; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserClaims"
    ADD CONSTRAINT "PK_UserClaims" PRIMARY KEY ("Id");


--
-- TOC entry 4808 (class 2606 OID 35974)
-- Name: UserLogins PK_UserLogins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLogins"
    ADD CONSTRAINT "PK_UserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey");


--
-- TOC entry 4811 (class 2606 OID 35986)
-- Name: UserRoles PK_UserRoles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "PK_UserRoles" PRIMARY KEY ("UserId", "RoleId");


--
-- TOC entry 4813 (class 2606 OID 36003)
-- Name: UserTokens PK_UserTokens; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserTokens"
    ADD CONSTRAINT "PK_UserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name");


--
-- TOC entry 4780 (class 2606 OID 35845)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 4782 (class 2606 OID 35854)
-- Name: Category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT category_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4784 (class 2606 OID 35863)
-- Name: Cinema cinema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cinema"
    ADD CONSTRAINT cinema_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4797 (class 2606 OID 35911)
-- Name: MovieCategory movie_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MovieCategory"
    ADD CONSTRAINT movie_category_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4786 (class 2606 OID 35875)
-- Name: Movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movie"
    ADD CONSTRAINT movie_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4817 (class 2606 OID 36036)
-- Name: Payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT payment_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4819 (class 2606 OID 36050)
-- Name: ReservationItem reservation_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ReservationItem"
    ADD CONSTRAINT reservation_item_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4815 (class 2606 OID 36017)
-- Name: Reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reservation"
    ADD CONSTRAINT reservation_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4791 (class 2606 OID 35891)
-- Name: Seat seat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT seat_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4799 (class 2606 OID 35931)
-- Name: Showtime showtime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Showtime"
    ADD CONSTRAINT showtime_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4795 (class 2606 OID 35902)
-- Name: User user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4792 (class 1259 OID 36063)
-- Name: EmailIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "EmailIndex" ON public."User" USING btree ("NormalizedEmail");


--
-- TOC entry 4800 (class 1259 OID 36061)
-- Name: IX_RoleClaims_RoleId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_RoleClaims_RoleId" ON public."RoleClaims" USING btree ("RoleId");


--
-- TOC entry 4803 (class 1259 OID 36065)
-- Name: IX_UserClaims_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_UserClaims_UserId" ON public."UserClaims" USING btree ("UserId");


--
-- TOC entry 4806 (class 1259 OID 36066)
-- Name: IX_UserLogins_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_UserLogins_UserId" ON public."UserLogins" USING btree ("UserId");


--
-- TOC entry 4809 (class 1259 OID 36067)
-- Name: IX_UserRoles_RoleId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_UserRoles_RoleId" ON public."UserRoles" USING btree ("RoleId");


--
-- TOC entry 4789 (class 1259 OID 36062)
-- Name: RoleNameIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "RoleNameIndex" ON public."Roles" USING btree ("NormalizedName");


--
-- TOC entry 4793 (class 1259 OID 36064)
-- Name: UserNameIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UserNameIndex" ON public."User" USING btree ("NormalizedUserName");


--
-- TOC entry 4824 (class 2606 OID 35950)
-- Name: RoleClaims FK_RoleClaims_Roles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RoleClaims"
    ADD CONSTRAINT "FK_RoleClaims_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."Roles"("Id") ON DELETE CASCADE;


--
-- TOC entry 4825 (class 2606 OID 35963)
-- Name: UserClaims FK_UserClaims_User_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserClaims"
    ADD CONSTRAINT "FK_UserClaims_User_UserId" FOREIGN KEY ("UserId") REFERENCES public."User"("Id") ON DELETE CASCADE;


--
-- TOC entry 4826 (class 2606 OID 35975)
-- Name: UserLogins FK_UserLogins_User_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLogins"
    ADD CONSTRAINT "FK_UserLogins_User_UserId" FOREIGN KEY ("UserId") REFERENCES public."User"("Id") ON DELETE CASCADE;


--
-- TOC entry 4827 (class 2606 OID 35987)
-- Name: UserRoles FK_UserRoles_Roles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "FK_UserRoles_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."Roles"("Id") ON DELETE CASCADE;


--
-- TOC entry 4828 (class 2606 OID 35992)
-- Name: UserRoles FK_UserRoles_User_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "FK_UserRoles_User_UserId" FOREIGN KEY ("UserId") REFERENCES public."User"("Id") ON DELETE CASCADE;


--
-- TOC entry 4829 (class 2606 OID 36004)
-- Name: UserTokens FK_UserTokens_User_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserTokens"
    ADD CONSTRAINT "FK_UserTokens_User_UserId" FOREIGN KEY ("UserId") REFERENCES public."User"("Id") ON DELETE CASCADE;


--
-- TOC entry 4820 (class 2606 OID 35912)
-- Name: MovieCategory fk_movie_category_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MovieCategory"
    ADD CONSTRAINT fk_movie_category_category_id FOREIGN KEY ("Id") REFERENCES public."Category"("Id");


--
-- TOC entry 4821 (class 2606 OID 35917)
-- Name: MovieCategory fk_movie_category_movie_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MovieCategory"
    ADD CONSTRAINT fk_movie_category_movie_id FOREIGN KEY ("Id") REFERENCES public."Movie"("Id");


--
-- TOC entry 4832 (class 2606 OID 36037)
-- Name: Payment fk_payment_reservation_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT fk_payment_reservation_id FOREIGN KEY ("Id") REFERENCES public."Reservation"("Id");


--
-- TOC entry 4833 (class 2606 OID 36051)
-- Name: ReservationItem fk_reservation_item_reservation_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ReservationItem"
    ADD CONSTRAINT fk_reservation_item_reservation_id FOREIGN KEY ("Id") REFERENCES public."Reservation"("Id");


--
-- TOC entry 4834 (class 2606 OID 36056)
-- Name: ReservationItem fk_reservation_item_seat_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ReservationItem"
    ADD CONSTRAINT fk_reservation_item_seat_id FOREIGN KEY ("Id") REFERENCES public."Seat"("Id");


--
-- TOC entry 4830 (class 2606 OID 36018)
-- Name: Reservation fk_reservation_showtime_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reservation"
    ADD CONSTRAINT fk_reservation_showtime_id FOREIGN KEY ("Id") REFERENCES public."Showtime"("Id");


--
-- TOC entry 4831 (class 2606 OID 36023)
-- Name: Reservation fk_reservation_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reservation"
    ADD CONSTRAINT fk_reservation_user_id FOREIGN KEY ("Id") REFERENCES public."User"("Id");


--
-- TOC entry 4822 (class 2606 OID 35932)
-- Name: Showtime fk_showtime_cinema_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Showtime"
    ADD CONSTRAINT fk_showtime_cinema_id FOREIGN KEY ("Id") REFERENCES public."Cinema"("Id");


--
-- TOC entry 4823 (class 2606 OID 35937)
-- Name: Showtime fk_showtime_movie_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Showtime"
    ADD CONSTRAINT fk_showtime_movie_id FOREIGN KEY ("Id") REFERENCES public."Movie"("Id");


-- Completed on 2023-12-29 15:19:11

--
-- PostgreSQL database dump complete
--

