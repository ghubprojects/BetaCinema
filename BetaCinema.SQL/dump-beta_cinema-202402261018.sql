--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2024-02-26 10:18:54

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
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 35846)
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
-- TOC entry 218 (class 1259 OID 35855)
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
-- TOC entry 219 (class 1259 OID 35864)
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
-- TOC entry 223 (class 1259 OID 35903)
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
-- TOC entry 233 (class 1259 OID 36028)
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
-- TOC entry 235 (class 1259 OID 52720)
-- Name: ProcessSeat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProcessSeat" (
    "Id" text NOT NULL,
    "ShowtimeId" text NOT NULL,
    "SeatId" text NOT NULL,
    "CreatedDate" timestamp without time zone NOT NULL,
    "CreatedBy" character varying(100),
    "ModifiedDate" timestamp without time zone NOT NULL,
    "ModifiedBy" character varying(100),
    "DeleteFlag" boolean NOT NULL
);


ALTER TABLE public."ProcessSeat" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 36009)
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
-- TOC entry 234 (class 1259 OID 36042)
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
-- TOC entry 226 (class 1259 OID 35943)
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
-- TOC entry 225 (class 1259 OID 35942)
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
-- TOC entry 220 (class 1259 OID 35876)
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
-- TOC entry 221 (class 1259 OID 35883)
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
-- TOC entry 224 (class 1259 OID 35922)
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
-- TOC entry 222 (class 1259 OID 35892)
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
-- TOC entry 228 (class 1259 OID 35956)
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
-- TOC entry 227 (class 1259 OID 35955)
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
-- TOC entry 229 (class 1259 OID 35968)
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
-- TOC entry 230 (class 1259 OID 35980)
-- Name: UserRoles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRoles" (
    "UserId" text NOT NULL,
    "RoleId" text NOT NULL
);


ALTER TABLE public."UserRoles" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 35997)
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
-- TOC entry 216 (class 1259 OID 35841)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- TOC entry 4999 (class 0 OID 35846)
-- Dependencies: 217
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" ("Id", "CategoryName", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
39bc63d0-6bae-49f8-9d26-b8b20ff3e5c8	Lãng mạn	f	2024-01-30 03:15:56.758813	\N	2024-01-30 03:15:56.758898	\N
1f066c91-6e21-495b-85d8-d405655307de	Thần thoại	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
379546d5-2639-4c1c-bc3b-fd155e5e6bf7	Hài hước	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
3b9c89a1-6f55-4a7b-bba1-19c123efa917	Tâm lý	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
5a00148e-0f3e-43c0-9e83-f8684bd81878	Bí ẩn	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
5dee9be2-3be5-4bbc-b724-9bf159b97861	Hoạt hình	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
77799d5b-2e98-4952-9b7c-3a99a98db412	Hành động	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
865d55e5-25e8-4d61-a755-bb3710f19010	Phiêu lưu	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
97bd07ba-1470-49d7-b455-f237392b4dae	Tình cảm	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
a7c7b61c-26e4-4260-8f1b-417c393d44c1	Kinh dị	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
dedbc97e-a553-410b-81f5-7871cea02288	Hồi hộp	f	2024-01-18 16:36:27.849747	\N	2024-01-18 16:36:27.849747	\N
c6041c74-17cc-4ea8-ad72-5682390ec86c	Lịch sử	t	2024-02-22 15:45:22.424715	\N	2024-02-22 15:45:22.424803	\N
\.


--
-- TOC entry 5000 (class 0 OID 35855)
-- Dependencies: 218
-- Data for Name: Cinema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cinema" ("Id", "CinemaName", "CinemaLocation", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	Beta Thanh Xuân	Hà Nội	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	Beta Mỹ Đình	Hà Nội	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
8bdac2c9-2cc7-464b-8cff-4bc41403b74f	Beta Đan Phượng	Hà Nội	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
94d6c0ca-125b-43d0-8f65-9f0880b90beb	Beta Giải Phóng	Hà Nội	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
0fdbe392-734d-402b-9399-d22bd37b6cee	Beta Quang Trung	TP. Hồ Chí Minh	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
8f2c1f5f-d274-4081-9c87-441e13dab3ee	Beta Trần Quang Khải	TP. Hồ Chí Minh	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
ed75f9eb-4f2c-4448-aef8-7804178df564	Beta Bắc Giang	Bắc Giang	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	Beta Biên Hòa	Đồng Nai	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
d1678477-49ce-4417-bc39-a080cad0e9e8	Beta Long Khánh	Đồng Nai	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
b0e45ea2-443f-404f-9412-b97a6001f157	Beta Nha Trang	Khánh Hòa	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	Beta Thái Nguyên	Thái Nguyên	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	Beta Thanh Hóa	Thanh Hóa	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
3db16884-48c4-406d-b873-fa65147f939a	Beta Phú Mỹ	Bà Rịa - Vũng Tàu	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
3aa17be3-387c-4271-a313-2e5bb069b509	Beta Hồ Tràm	Bà Rịa - Vũng Tàu	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
a4ed71b7-2af3-46d4-acff-b7778fb2c91d	Beta Empire Bình Dương	Bình Dương	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
65966bb8-ec4a-4ef6-bd0d-429deb2b563e	Beta Tân Uyên	Bình Dương	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
6e476e92-a262-4792-8120-daeb4433c025	Beta TRMall Phú Quốc	Kiên Giang	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
dac58b9b-f8f7-4f75-8586-2b43fb8824c0	Beta Lào Cai	Lào Cai	f	2024-01-04 10:35:58.402144	Admin	2024-01-04 10:35:58.402144	Admin
\.


--
-- TOC entry 5001 (class 0 OID 35864)
-- Dependencies: 219
-- Data for Name: Movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Movie" ("Id", "MovieName", "Poster", "Duration", "ReleaseDate", "Director", "Actor", "Description", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
76a3f26d-22ee-46b4-8377-ea17757ebd06	Nàng Thơ Của Miller	iajuuou1.jpg	93	2024-02-16 00:00:00	Jade Halley Bartlett	Christine Adams, Jenna Ortega, Dagmara Dominczyk, Bashir Salahuddin,...	Chuyện phim kể về 1 nữ sinh học giỏi nhưng đầy bí ẩn (Jenna Ortega) phải hoàn thành 1 dự án với giáo sư của mình (Martin Freeman). Giữa họ dần hình thành mối quan hệ phức tạp buộc cả 2 phải đấu tranh nhằm giữ vững những gì họ yêu quý khỏi trước những hành động sai lầm của bản thân.	f	2024-02-22 11:43:02.77372	\N	2024-02-22 11:43:37.028377	\N
253b1ac6-7619-491c-a60e-dddcbcaae135	Trốn Tìm Với Quỷ	zutenwgh.jpg	76	2024-01-26 00:00:00	Eren Celeboglu, Ari Costa	Asa Butterfield, Natalia Dyer, Benjamin Ainsworth, Laurel Marsden, Kolton Stewart, Annabeth Gish,..	Trốn Tìm Với Quỷ theo chân 3 anh chị em khi họ bắt đầu vén màn một bí mật về sự hiện diện của quỷ dữ. Tin rằng đó chỉ là những trò trẻ con, cả nhóm gồm Jo, Billie và Marcus quyết định đọc lại câu chú và vô tình triệu hồi con quỷ, khiến cho Marcus bị chiếm xác và buộc 3 anh em phải tham gia trò chơi. Theo truyền thuyết, cách duy nhất để kết thúc trò chơi là khi quỷ dữ chiến thắng và mọi người chơi đều mất mạng.	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:44:24.731201	\N
4f296c4d-be10-4161-942d-161e8ceb21fa	Đào, Phở và Piano	2dxsriuy.jpg	100	2024-02-21 00:00:00	Phi Tiến Sơn	NSƯT Trần Lực, NSND Trung Hiếu, Doãn Quốc Đam, Tuấn Hưng, Nguyệt Hằng...	Lấy bối cảnh trận chiến đông xuân kéo dài 60 ngày đêm từ cuối năm 1946 đến đầu năm 1947 ở Hà Nội. Câu chuyện theo chân chàng dân quân Văn Dân (Doãn Quốc Đam đóng) và chuyện tình với nàng tiểu thư đam mê dương cầm Thục Hương (Cao Thị Thùy Linh thủ vai). Khi những người khác đã di tản lên chiến khu, họ quyết định cố thủ lại mảnh đất thủ đô đã tan hoang vì bom đạn, mặc cho những hiểm nguy đang chờ đợi trước mắt.	f	2024-02-22 11:48:05.899917	\N	2024-02-26 10:14:22.248256	\N
663eb791-e46c-4103-a0f2-75a9101ef83a	Kẻ Thế Thân	hzavz3qu.jpg	114	2024-05-03 00:00:00	David Leitch	Ryan Gosling, Emily Blunt, Aaron Taylor-Johnson, Hannah Waddingham	Colt Seavers là một diễn viên đóng thế “lão làng. Bất ngờ, anh được mời làm “bản sao” cho một nhân vật nổi tiếng trong phim do người yêu cũ  – Jody (Emily Blunt) đạo diễn. Mọi chuyện dần chệch hướng khi ngôi sao của bộ phim bỗng mất tích, không ai có thể liên lạc được. Để cứu lấy công việc và giành lại tình yêu của đời mình, Colt vướng vào âm mưu khó lường khi cố gắng đi tìm diễn viên đó.	f	2024-01-18 15:15:40.128766	\N	2024-02-06 20:42:29.040996	\N
116b341f-1aaa-4750-bb64-a9af906e416c	Aquaman và Vương Quốc Thất Lạc	tmixk1fg.jpg	124	2023-12-22 00:00:00	James Wan	Jason Momoa, Ben Affleck, Patrick Wilson...	Aquaman Và Vương Quốc Thất Lạc là phần hậu truyện của Aquaman năm 2018 khi Arthur lên ngôi vua của Atlantis.  Giờ đây, Arthur Curry ngày nào đã trở thành ông bố bỉm sữa ngày ngày chăm con kiêm cai quản cả vùng Atlantis rộng lớn. Thế nhưng, kẻ thù cũ đời nào để cho nhà vua biển cả yên ổn. Nhờ sự trợ giúp của công nghệ, Black Manta lần nữa trỗi dậy với sức mạnh kinh khủng hơn xưa. Không thể chiến đấu một mình, Arthur đành phải nhờ sự trợ giúp của một kẻ thù khác - đứa em cùng mẹ khác cha Orm. Cùng chống lại kẻ thù chung, liệu cặp anh em chẳng đội chung trời này có thể hàn gắn tình cảm?	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:46:55.069968	\N
3c3ccbb7-61a2-4296-a2a5-55252f89b900	Mật Vụ Ong	1rapnuck.jpg	105	2024-01-12 00:00:00	David Ayer	Jason Statham, Emmy Raver-Lampman, Bobby Naderi,...	Jason Statham vào vai Adam Clay, một người nuôi ong cần mẫn và đơn độc. Anh có mối quan hệ tốt với bà chủ nhà, thậm chí coi bà như người thân duy nhất của mình. Thế nhưng, một sự kiện xảy ra khiến bà qua đời, và “người nuôi ong” Adam Clay quyết định bắt đầu kế hoạch trả thù tàn bạo của mình. Trong khi Clay vạch trần bí mật đằng sau đường dây lừa đảo cỡ lớn và bắt những kẻ có tội phải trả giá, thân phận thật của anh cũng dần được hé lộ.	t	2024-01-18 15:15:40.128766	\N	2024-01-26 17:03:32.616407	\N
51ae6fef-e45c-46df-9a5f-a0bdc2b58b2f	Quỷ Cẩu	nc1grm5l.jpg	99	2023-12-29 00:00:00	Lưu Thành Luân	Quang Tuấn, NSND Kim Xuân, Vân Dung, Quốc Quân, Nam Thư, Mie….	Nam về quê để lo đám tang cho bố sau cái chết kinh hoàng của ông, trong khi phải che giấu bạn gái đang mang thai. Nam mơ thấy gia đình bị giết sau khi mai táng bố, và Mít – con chó trắng của gia đình có biểu hiện kì lạ. Ông Quyết, bà Thúy, và bà Liễu thì tin vào thầy cúng, còn Nam nghi ngờ về lò mổ chó truyền thống của gia đình và phải điều tra để giải quyết sự kiện kỳ lạ đang diễn ra.	t	2024-01-18 15:15:40.128766	\N	2024-01-26 17:04:29.633979	\N
2ac5fade-52ff-4482-8e53-7804feef97a0	Sen Boss Sum Vầy	bvwwsela.jpg	120	2024-02-23 00:00:00	Kim Douck-min	Youn Yuh-jung, Yoo Hai-jin, Kim Yun-jin , Chung Sung-hwa, Kim Seo-hyung, Daniel Philip Henney, Lee Hyun-woo, Tang Joon-sang, Yoon Chae-na	Bộ phim xoay quanh những tình huống dở khóc dở cười của những con người khác biệt và những người bạn lông xù, Hàng loạt những sự sắp đặt trời định sẽ đưa tất cả họ xích lại gần nhau hơn.	f	2024-02-22 15:43:49.87297	\N	2024-02-23 16:29:51.884717	\N
4d9cd279-1ef2-4cbb-9a7b-467a326990bc	Arkie và Ngày Mặt Trời Mất Tích	c04xrcw1.jpg	93	2024-01-05 00:00:00	Ricard Cussó, Tania Vincent	Anna Torv, Sam Neill, Tim Minchin,...	Khi thế giới của cô bị đe dọa bởi mất ánh sáng mặt trời, một cô gái trẻ phải vượt qua nỗi sợ hãi và hành trình đến một thành phố kỳ ảo để cứu cha cô khỏi một nhà khoa học bí ẩn và ngăn chặn sự hủy diệt hành tinh của cô.	t	2024-01-18 15:15:40.128766	\N	2024-01-18 15:15:40.128766	\N
31b05358-8084-4918-a9c4-05e76a162510	Điệp Vụ Cuối Cùng	badscmac.jpg	110	2024-01-05 00:00:00	Renny Harlin	Aaron Eckhart, Nina Dobrev, Clifton Collins Jr.....	Trong The Bricklayer, một thế lực bí ẩn tống tiền CIA—ám sát các nhà báo nước ngoài và làm ra vẻ như cơ quan này phải chịu trách nhiệm. Khi thế giới bắt đầu chống lại Hoa Kỳ, CIA phải lôi kéo một đặc vụ cũ của mình — tuy nổi loạn — và đã nghỉ hưu, nhưng lại là người xuất sắc nhất, buộc anh ta phải đối mặt với quá khứ của mình trong khi cố gắng làm sáng tỏ một âm mưu tầm cỡ quốc tế.	t	2024-01-18 15:15:40.128766	\N	2024-01-18 15:15:40.128766	\N
6ec2252e-7940-4298-a6df-c822392a1044	Kung Fu Panda 4	dpd24wtg.png	92	2024-03-08 00:00:00	Mike Mitchell	Jack Black, Dustin Hoffman, James Hong, Awkwafina,...	Sau khi Po được chọn trở thành Thủ lĩnh tinh thần của Thung lũng Bình Yên, Po cần tìm và huấn luyện một Chiến binh Rồng mới, trong khi đó một mụ phù thủy độc ác lên kế hoạch triệu hồi lại tất cả những kẻ phản diện mà Po đã đánh bại về cõi linh hồn.	f	2024-01-18 15:15:40.128766	\N	2024-02-06 20:43:07.199579	\N
60093677-5aac-4207-ada4-1a76012fff2f	Bơi Đêm	tajwt1x0.jpg	98	2024-02-23 00:00:00	Bryce McGuire	Wyatt Russell, Kerry Condon, Gavin Warren, Jodi Long, Nancy Lenehan,...	Từ câu chuyện về cuộc sống gia đình bình thường đã biến thành một nỗi ám ảnh kinh hoàng. Không chạy, không lặn, không cứu hộ và không bơi sau khi màn đêm buông xuống. Bơi Đêm chạm đến nỗi sợ hãi sâu thẳm của bất kỳ ai mỗi khi bước xuống hồ bơi rằng họ sẽ bị mắc kẹt dưới nước.	f	2024-01-18 15:15:40.128766	\N	2024-02-06 20:43:31.785817	\N
3c4007ee-a12d-4a0b-b92a-1e40eca0b447	Argylle Siêu Điệp Viên	jnwsy14x.png	135	2024-02-10 00:00:00	Matthew Vaughn	Sofia Boutella, Henry Cavill, Catherine O'Hara,...	Elly một tiểu thuyết gia nổi tiếng, trở thành một điệp viên bất đắc dĩ khi bị lôi kéo vào các hoạt động của một tập đoàn ngầm nham hiểm.	f	2024-01-18 15:15:40.128766	\N	2024-02-06 20:43:46.205858	\N
13541362-df47-4393-b1b4-39a631472a01	Godzilla x Kong: The New Empire	ncba4n5x.jpg	121	2024-03-29 00:00:00	Adam Wingard	Rebecca Hall; Brian Tyree Henry; Dan Stevens; Kaylee Hottle; Alex Ferns; Fala Chen,...	Kong và Godzilla - hai sinh vật vĩ đại huyền thoại, hai kẻ thủ truyền kiếp sẽ cùng bắt tay thực thi một sứ mệnh chung mang tính sống còn để bảo vệ nhân loại, và trận chiến gắn kết chúng với loài người mãi mãi sẽ bắt đầu.	f	2024-02-22 15:43:49.904717	\N	2024-02-23 16:39:14.940186	\N
36eaf3ec-a347-4749-9cc7-11557d176b32	Trên Bàn Nhậu Dưới Bàn Mưu	1ixhjv3t.jpg	116	2023-12-29 00:00:00	TIEN M.NGUYEN	Kiều Minh Tuấn, Diệu Nhi, Khả Như, Thúy Ngân, Trần Ngọc Vàng, Xuân Nghị,...	Trên Bàn Nhậu Dưới Bàn Mưu là câu chuyện về tình bạn đầy thú vị của một hội bạn thân. Trong hành trình tìm kiếm những ước mơ và kế hoạch cuộc sống, họ đã vô tình bị kéo vào một âm mưu đen tối ngoài ý muốn. Sự vô tri của Gạo (Diệu Nhi), sự hậu đậu của Du Lai (Khả Như) và sự nóng nảy của Triệu (Thúy Ngân), kết hợp cùng những sáng kiến bá đạo của Trí (Kiều Minh Tuấn), đã mang đến một màn "trả thù" có một không hai dành cho Trực (Trần Ngọc Vàng) - một tên siêu lừa đội lốt doanh nhân và cũng là kẻ khiến cho Gạo gặp nhiều khốn đốn...	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:45:21.34745	\N
76cf2797-f1b1-49a3-8f8a-ea34f91feb43	Siêu Khỉ Cuồng Nộ	ajvymw0o.jpg	86	2024-01-12 00:00:00	Marc Gottlieb	Tom Arnold, Anna Telfer, Lisa Lee,...	Thử nghiệm Siêu Khỉ robot đã tạo ra sai lầm khủng khiếp, quân đội không còn lựa chọn nào khác ngoài việc đưa Vua Khỉ khổng lồ trở về. Cuộc đại chiến giữa những sinh vật khổng lồ với sức mạnh khủng khiếp, hứa hẹn những màn giao đấu bùng nổ và nghẹt thở.	t	2024-01-18 15:15:40.128766	\N	2024-01-26 01:49:46.574116	\N
b8539ffb-749a-435a-830c-b126caa27a9b	Trú Quỷ: Truyền Thuyết Ma Kéo Giò	4qk5amfp.jpg	86	2024-01-26 00:00:00	Jiro Nagae	Rikka Ihara, Taiyu Fujiwara, Shiori Akita,...	Lần đầu tiên truyền thuyết đô thị Nhật Bản về nữ quỷ Hasshaku-sama chuyên bắt cóc trẻ em từng làm rúng động cõi mạng những năm 2000 được đưa lên màn ảnh rộng	t	2024-01-18 15:15:40.128766	\N	2024-01-26 01:59:26.231499	\N
7d09b7f4-223a-465e-a5e6-64f0098bd3e1	Thanh Gươm Diệt Quỷ: Phép Màu Tình Thân, Cho Đến Chuyến Đặc Huấn Của Đại Trụ	32zerlft.jpg	103	2024-02-23 00:00:00	Haruo Sotozaki	Natsuki Hanae, Akari Kitô, Yoshitsugu Matsuoka	Phim lấy bối cảnh ở làng thợ rèn, kể về hồi kết của trận ác chiến giữa Tanjiro với Thượng Huyền Tứ Hantengu, và việc Nezuko khắc chế được mặt trời. Thêm vào đó, tập đầu tiên của phần "Đại Trụ Đặc Huấn", mở màn cho khóa đặc huấn của các Đại Trụ cho cuộc quyết chiến với Kibutsuji Muzan.	f	2024-02-22 15:43:49.854306	\N	2024-02-23 16:29:31.926352	\N
abd03ced-dae2-4b75-b57a-35ebd7cd03e8	Gặp Lại Chị Bầu	5ofamgrv.jpg	110	2024-02-10 00:00:00	Nhất Trung	Anh Tú, Diệu Nhi, Kiều Minh Tuấn, Lê Giang,..	Một chàng trai với với niềm đam mê diễn xuất nhưng lại có một quá khứ không bình yên, cùng cuộc gặp gỡ định mệnh với một cô giáo hơi "lố tuổi" , với câu chào đầu đầy ấn tượng "Em có ý gì với chị không?"	f	2024-01-18 15:15:40.128766	\N	2024-02-06 20:35:35.070697	\N
98944c73-f47c-455a-a3f5-3c111d278fd0	Katak và Sứ Mệnh Chinh Phục Đại Dương	1c1fsqme.jpg	78	2024-01-26 00:00:00	Christine Dallaire-Dupont, Nicola Lemay	Robert Naylor, Skyler Clark, Eleanor Noble,..	Trong khi các bạn đồng trang lứa đều đã chuyển sang màu trắng thì chú cá voi Katak vẫn còn nhỏ bé và xám xịt. Để chứng minh rằng mình đã trưởng thành và thực hiện ước nguyện cuối cùng của người bà yêu quý, Katak khởi hành chuyến hành trình đầy nguy hiểm đến Great North. Trong chuyến đi cậu đã học nhiều bài học quý giá và trở thành một chú cá voi dũng cảm.	t	2024-01-18 15:15:40.128766	\N	2024-01-30 05:15:21.555081	\N
fa6bea21-353a-4aba-9635-297d30fdbefe	Alienoid 2: Đa Chiều Hỗn Chiến	t3cswhbi.jpg	122	2024-01-12 00:00:00	Choi Dong-hoon	Ryu Jun-Yeol, Kim Tae-ri, Kim Woo-bin,...	Phần thứ hai của Alienoid, sẽ tập trung vào các Đạo giáo cổ đại du hành xuyên thời gian và không gian với nỗ lực giành được Thanh kiếm thần thánh.	t	2024-01-18 15:15:40.128766	\N	2024-01-26 17:04:09.506854	\N
a88d9881-8440-4eee-ad3e-947ec300d138	Xin Chào Jadoo	2ode2ul0.jpg	76	2023-12-15 00:00:00	Son Seok Woo	Kim Hyeon - ji, Jeong Yu-mi, Kim Young-eun,...	Bộ phim Hello Jadoo nổi bật với cốt truyện vô cùng khác biệt, đưa nhân vật Jadoo bước đến cuộc hành trình phiêu lưu vào một thế giới cổ tích tuyệt vời thông qua cuốn sách ma thuật mà Jadoo phát hiện ra trong chuyến thăm công viên giải trí.	t	2024-01-18 15:15:40.128766	\N	2024-01-18 15:15:40.128766	\N
b5d730ce-563f-42d6-94c5-f12b8c272e1c	Giao Ước Quỷ	1zyugsrq.jpg	97	2024-01-05 00:00:00	Azhar Kinoi Lubis	Taskya Namya, T. Rifnu Wikana, Wafda Saifan Lubis,..	Cuộc sống gia đình Nadia trở nên đảo lộn khi mẹ cô tự sát trong đêm giao thừa năm 2002. Hai anh em Nadia cũng phát hiện ra người bố đạo mạo, thành đạt của họ thường xuyên ra vào một căn phòng bí mật trong nhà với một con dê đen. Khi những nghi thức ghê rợn trong căn phòng bị phát hiện cũng là lúc anh trai Nadia tiếp tục qua đời vào đúng đêm giao thừa 10 năm sau đó, 2012. Một lời nguyền đáng sợ được thành lập từ giao ước với thế lực tà ác giáng xuống gia đình Nadia, buộc cô phải cùng cha mình chiến đấu để giành giật sự sống với quỷ dữ	t	2024-01-18 15:15:40.128766	\N	2024-01-18 15:15:40.128766	\N
cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	Mai	ddlz4qej.jpg	125	2024-02-10 00:00:00	Trấn Thành	Phương Anh Đào, Tuấn Trần, Trấn Thành, Hồng Đào, Uyển n, Ngọc Giàu, Việt Anh, Quỳnh Anh, Anh Thư,..	MAI xoay quanh câu chuyện về cuộc đời của một người phụ nữ cùng tên với bộ phim. Trên First-look Poster, Phương Anh Đào tạo ấn tượng mạnh với cái nhìn tĩnh lặng, xuyên thấu, đặc biệt, trên bờ môi nữ diễn viên là hình ảnh cô đang nằm nghiêng trên mặt nước. Được phủ một màn sương mờ ảo, poster đậm chất nghệ thuật của Mai gây tò mò với lời tựa: “Quá khứ chưa ngủ yên, ngày mai liệu sẽ đến?”.	f	2024-01-18 15:15:40.128766	\N	2024-02-06 20:35:07.492281	\N
a0ede518-5ae0-4209-b8c5-934773791e56	Kinh Cầu Ma	v1jbwpkc.jpg	100	2024-01-12 00:00:00	Takashi Shimizu	Alan Shirahama, Ryôta Katayose, Hayato Komori,..	Không dừng lại ở đó, năm 2019 Takashi Shimizu tiếp tục làm chấn động màn ảnh rộng với tác phẩm kinh dị Ngôi Làng Tử Khí. Và trong lần trở lại mới nhất, Takashi Shimizu sẽ đem đến hình ảnh một ma nữ cũng bí ẩn và đáng sợ chẳng kém Sana trong Kinh Cầu Ma. Đây là một cô gái trẻ nắm giữ trong tay một giai điệu bị nguyền rủa. Nếu bất cứ ai nghe thấy nó, họ đều sẽ nhận kết cục thảm khốc.	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:45:08.566649	\N
aaaf2ce8-83d9-4ab9-80ef-518c12fff65b	Rượu Cốt Người	cc5vp4fr.jpg	89	2024-01-19 00:00:00	Sầm Gia Ngạn	Lư Hãn Đình, Viên Lễ Lâm, Khương Đại Vệ,…	Nhân vật chính trong Rượu Cốt Người là Trương Tử Kiệt (Lư Hãn Đình), một chàng trai quyết định tham gia tour du lịch trên đảo hoang cùng bạn bè để quên đi nỗi đau trước cái chết đột ngột của bạn gái Ava (Viên Lễ Lâm). Nhưng chuyến hành trình về miền hoang dã lại không vui như kì vọng. Bốn người bạn bắt đầu gặp thấy những điều kì lạ, rồi những sự kiện siêu nhiên đáng sợ lần lượt xảy ra. Không lâu sau, họ phát hiện sự tồn tại của một thế lực tà ác cổ xưa và nó đang rình rập, theo dõi họ mọi lúc mọi nơi. Chuyến đi tưởng chừng rất vui vẻ lại trở thành nỗi kinh hoàng chết chóc.	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:41:41.760523	\N
a6fc3905-9277-447c-b171-acc9bbde56f5	Bà Thím Báo Thù	gwyv4arn.jpg	114	2024-03-01 00:00:00	Young-ju Park	Park Byeong-eun, Ahn Eun-jin, Myoung Gong,..	Đang chật vật vay mượn khắp nơi để tiếp tục duy trì cửa tiệm giặt ủi sau hoả hoạn, Duk Hee nhận được cú điện thoại từ Son, tự xưng là nhân viên ngân hàng với lời hứa hẹn sẽ cấp cho cô một khoản vay với lãi suất ưu đãi. Sau khi chuyển tiền, người phụ nữ mới nhận ra mình vừa trở thành nạn nhân của một kẻ chuyên lừa đảo qua điện thoại di động (a voice phishing scam). Cho tới một ngày nọ, Son bỗng chủ động liên lạc với Duk Hee và đưa ra một lời cầu cứu thảm thiết…	f	2024-02-22 15:43:49.888841	\N	2024-02-23 16:31:00.036431	\N
8e84dbd4-f888-42f8-9232-a4ec7f6753a8	Pororo: Hành Trình Siêu Sao Âm Nhạc	njrqaasf.jpg	77	2024-02-20 00:00:00	Yoon Je-wan	Jung Mi-sook, Hong So-young, Lee Sun, Imiza,...	Pororo và những người bạn của anh ấy sắp sửa chiến thắng trong một cuộc thi ca hát mà họ tham gia cho vui. Liệu Pororo và những người bạn của anh ấy có thoát khỏi sự phiền nhiễu của Big Ben và cuối cùng giành chiến thắng trong cuộc thi siêu sao âm nhạc?	f	2024-01-30 03:19:32.212497	\N	2024-02-22 11:45:52.847024	\N
dec3b3d5-8c78-4fa9-9489-d23a9905e4d7	Kẻ Ăn Hồn	r1qkpi4l.jpg	110	2023-12-15 00:00:00	Trần Hữu Tấn	Hoàng Hà, Võ Điền Gia Huy, Huỳnh Thanh Trực, NSƯT Chiều Xuân,...	Phim về hàng loạt cái chết bí ẩn ở Làng Địa Ngục, nơi có ma thuật cổ xưa: 5 mạng đổi bình Rượu Sọ Người. Thập Nương - cô gái áo đỏ là kẻ nắm giữ bí thuật luyện nên loại rượu mạnh nhất!	t	2024-01-18 15:15:40.128766	\N	2024-01-18 15:15:40.128766	\N
88072e16-0264-4498-ab30-ce5a67d5106e	Cún Cưng Đại Náo Nhà Hát	1wsuxv0s.jpg	98	2024-02-16 00:00:00	Vasiliy Rovenskiy	Anna Starshenbaum, Diomid Vinogradov, Garik Kharlamov	Chú chó lang tham Samson vô tình lạc vào nhà hát opera Bolshoi nổi tiếng bậc nhất thủ đô Moscow hoa lệ. Vướng vào vụ trộm chiếc vương miện kim cương của nữ diễn viên Anastasia; Samson cùng nàng cún Margot xinh đẹp của Anastasia dấn thân vào cuộc phiêu lưu đại náo nhà hát, truy lùng bọn cướp và giành lại món nữ trang quý giá.	f	2024-01-30 03:19:32.20128	\N	2024-01-30 03:25:50.338304	\N
a61eafa6-3170-42b5-b1ab-42afaea7cd41	Gia Đình Điệp Viên Mã: Trắng	53y3ztic.jpg	110	2024-02-10 00:00:00	Kazuhiro Furuhashi	Atsumi Tanezaki, Takuya Eguchi, Saori Hayami,…	Bộ phim là phần phim điện ảnh của series anime nổi tiếng Spy x Family. Trong bộ phim lần này, sau khi nhận được yêu cầu thay thế mình trong Chiến dịch Strix, Loid Forger quyết định giúp con gái Anya chiến thắng trong cuộc thi nấu ăn tại Học viện Eden bằng cách nấu bữa ăn yêu thích của hiệu trưởng để tránh bị thay thế khỏi nhiệm vụ mật. Nhưng từ đây, gia đình Forger phát hiện ra bí mật kinh hoàng ảnh hưởng đến hòa bình thế giới.	f	2024-01-30 03:19:32.0605	\N	2024-01-30 03:31:04.397425	\N
9a09b6c6-92b4-4fd8-ad57-2927f08d2b2e	Dune: Hành tinh cát - Phần Hai	kipnv5ao.jpg	166	2024-03-01 00:00:00	Denis Villeneuve	Denis Villeneuve, Jon Spaihts, Frank Herbert	“Dune: Hành Tinh Cát – Phần 2” sẽ tiếp tục khám phá hành trình đậm chất thần thoại của Paul Atreides khi anh đồng hành cùng Chani và những người Fremen trên chặng đường trả thù những kẻ đã hủy hoại gia đình mình. Đối mặt với những lựa chọn giữa tình yêu của cuộc đời mình và số phận của vũ trụ, Paul phải ngăn chặn viễn cảnh tương lai tồi tệ chỉ mình anh nhìn thấy.	f	2024-02-22 15:43:49.919259	\N	2024-02-23 16:39:21.566017	\N
bdea8635-5b88-4002-bb05-d12a09d7016f	Hành Trình Digimon 02: Khởi Đầu	e5siazyk.jpg	80	2024-01-19 00:00:00	Tomohisa Taguchi	Fukujurou Katayama, Junko Noda, Arthur Lounsbery	Phần phim này kể về vài năm sau Sự Kiện của Movie [ Kizuna ] - Khi 1 quả DigiEgg khổng lồ xuất hiện, chuyện gì sẽ   xảy đến trên toàn Thế Giới.... Trong khi họ đã dấn thân vào con đường riêng của mình, Daisuke và các "DigiDestined" khác cùng cộng sự Digimon của họ vẫn bị r ràng buộc với nhau bởi cùng một mối liên kết. Rồi một ngày nọ, một Digitama khổng lồ bất ngờ xuất hiện trên bầu trời Tokyo Tower và gửi một thông điệp tới thế giới. Liệu Daisuke và đội ngũ "02" sẽ chọn con đường nào?	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:45:02.184947	\N
cfb12716-5f9d-43f4-a2b0-72a09c3d10ad	Tee Yod: Quỷ Ăn Tạng	qpoqfiyb.jpg	119	2023-12-29 00:00:00	Taweewat Wantha	Nadech Kugimiya, Denise Jelilcha Kapaun, Mim Rattawadee Wongthong, Junior Kajbhunditt Jaidee,..	Vào năm 1972, một sự việc kinh hoàng nhất đã xảy ra. Một cô gái trẻ ở một ngôi làng hẻo lánh ở tỉnh Kanchanaburi đã qua đời một cách bí ẩn. Mọi chuyện phải kể từ lúc Yam (Mim Rattanawadee Wongthong) bị ốm thì những bí ẩn cũng bắt đầu xuất hiện.  Và người ta tin rằng, Yam đã bị "ma cà rồng" nhập, nó ăn mòn nội tạng. Khiến cơ thể của Yam dần yếu đi. Cứ đêm xuống, là nghe thấy tiếng rên rỉ cùng với từ "Tee Yod". Dẫn đến một câu chuyện bí ẩn đầy ám ảnh, dù đã hơn 50 năm trôi qua nhưng vẫn khiến người nghe khiếp sợ.	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:45:41.581351	\N
c474761c-c5cf-41b4-8dea-7a04c244ac4e	Madame Web	pt2s2emg.jpg	116	2024-02-14 00:00:00	S.J. Clarkson	Dakota Johnson, Sydney Sweeney, Emma Roberts, Adam Scott,...	Bộ phim kể về nguồn gốc của một đồng minh Người Nhện, một nhân vật trong truyện tranh Marvel có sức mạnh liên kết đa vũ trụ - Madame Web. Sở hữu khả năng và giác quan nhạy bén của loài nhện, Cassandra có khả năng thấu thị, thần giao cách cảm và nhìn trước tương lai.	f	2024-01-30 03:19:32.164997	\N	2024-01-30 03:26:21.412389	\N
c0a830d7-b082-4c37-8251-ca9453277aea	Sáng Đèn	pfvvwv35.jpg	122	2024-02-10 00:00:00	Hoàng Tuấn Cường	NSƯT Hữu Châu, Nghệ sĩ Chí Tâm, Bạch Công Khanh, Cao Minh Đạt, NSND Hồng Vân, NSƯT Kim Tử Long, Hồng Loan,...	Câu chuyện vào những năm 1994, lúc bấy giờ đoàn hát cải lương chính thống, được khán giả săn đón… Mười năm sau, tình trạng ế khách kéo dài dù chủ đoàn đã dùng đủ mọi cách từ một đoàn cải lương chính thống, giờ trở thành một đoàn tạp kỷ có xiếc có lô tô ca nhạc, riêng tuồng hát thì chỉ còn trích đoạn và tân cổ giao duyên. Mặc dù phải vật lộn với hoàn cảnh khó khăn của đoàn hát nhưng tình yêu nghề, tình yêu đôi lứa vẫn luôn được đề cao trong mỗi cá nhân.	t	2024-01-30 03:19:32.154472	\N	2024-01-30 03:26:30.791585	\N
de0f0cb4-8238-45f1-8342-fdd678bbc9e3	Cám Dỗ Giảng Đường	stm5lazk.jpg	93	2024-02-16 00:00:00	Jade Halley Bartlett	Christine Adams, Jenna Ortega, Dagmara Dominczyk, Bashir Salahuddin,...	Chuyện phim kể về 1 nữ sinh học giỏi nhưng đầy bí ẩn (Jenna Ortega) phải hoàn thành 1 dự án với giáo sư của mình (Martin Freeman). Giữa họ dần hình thành mối quan hệ phức tạp buộc cả 2 phải đấu tranh nhằm giữ vững những gì họ yêu quý khỏi trước những hành động sai lầm của bản thân.	t	2024-01-30 03:19:32.189275	\N	2024-01-30 03:25:59.909806	\N
f8778c8c-7190-4c2a-8505-77c6dc7e13e4	Biệt Đội Săn Rồng	30llx240.jpg	99	2024-02-16 00:00:00	Panjapong Kongkanoy - Supawit Suwannet	Ishikawa Plowden, Mookda Narinrak, Peemapol Panichtamrong,...	Khi thế giới tương lai đứng trước thảm họa diệt vong, hy vọng cuối cùng của loài người là dòng máu bất tử của loài sinh vật kì bí trong truyền thuyết. Chủng rồng Slyth với sức mạnh vô song cùng khả năng biến hóa thành người vốn không phải là con mồi dễ dàng. Cuộc săn lùng nghẹt thở đã bắt đầu!	t	2024-01-30 03:19:32.176517	\N	2024-01-30 03:26:09.740998	\N
49b2f6cc-ffaa-4e4e-a23e-5f9a5c39ad49	Chiếu Lại: Con Nhót Mót Chồng	neq1y3kj.jpg	112	2024-01-19 00:00:00	Vũ Ngọc Đãng	Thái Hòa, Thu Trang, Tiến Luật, NSND Hồng Vân, Huỳnh Phương, Vinh Râu, Thái Vũ,...	Lấy cảm hứng từ web drama Chuyện Xóm Tui, phiên bản điện ảnh sẽ mang một màu sắc hoàn toàn khác: hài hước hơn, gần gũi và nhiều cảm xúc hơn Bộ phim là câu chuyện của Nhót - người phụ nữ “chưa kịp già” đã sắp bị mãn kinh, vội vàng đi tìm chồng. Nhưng sâu thẳm trong cô, là khao khát muốn có một đứa con và luôn muốn hàn gắn với người cha suốt ngày say xỉn của mình.	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:44:33.938548	\N
f91de30a-87a3-4e47-9f40-fbc9bb3a8ad9	Chiếu Lại: Người Vợ Cuối Cùng	m0l3n1gx.jpg	132	2024-01-19 00:00:00	Victor Vũ	Kaity Nguyễn, Thuận Nguyễn, Ngọc Diệp, Quang Thắng,...	Lấy cảm hứng từ tiểu thuyết Hồ Oán Hận, của nhà văn Hồng Thái, Người Vợ Cuối Cùng là một bộ phim tâm lý cổ trang, lấy bối cảnh Việt Nam vào triều Nguyễn. LINH - Người vợ bất đắc dĩ của một viên quan tri huyện, xuất thân là con của một gia đình nông dân nghèo khó, vì không thể hoàn thành nghĩa vụ sinh con nối dõi nên đã chịu sự chèn ép của những người vợ lớn trong gia đình. Sự gặp gỡ tình cờ của cô và người yêu thời thanh mai trúc mã của mình - NHÂN đã dẫn đến nhiều câu chuyện bất ngờ xảy ra khiến cuộc sống cô hoàn toàn thay đổi.	t	2024-01-18 15:15:40.128766	\N	2024-01-18 15:15:40.128766	\N
7c986c90-d46b-402d-8ef6-ed911bff0ea5	Chiếu Lại: Gấu Đỏ Biến Hình	kywzhaj4.jpg	99	2024-02-10 00:00:00	Domee Shi	Rosalie Chiang, Sandra Oh, James Hong	"Turning Red - Gấu Đỏ Biến Hình" từ Disney và Pixar kể về Mei Lee, cô bé 13 tuổi tự tin và ngổ ngáo với những sự hỗn loạn của tuổi mới lớn. Mẹ của Mei luôn cố gắng bảo bọc và ở bên cạnh con gái mọi lúc mọi nơi, khiến cô bé cảm thấy như một thảm hoạ vậy. Và cứ như thể những thay đổi về sở thích, các mối quan hệ và thể chất còn chưa đủ, mỗi khi Mei trở nên quá phấn khích (mà thật ra lúc nào cũng vậy), "bùm", cô bé sẽ biến hình thành một chú gấu đỏ siêu cute khổng lồ luôn!	t	2024-01-30 22:12:00.10846	\N	2024-01-30 22:12:45.79582	\N
91fca915-8f0b-4501-a60c-3cb54c617169	Lễ Trừ Tà	ufwzklu3.jpg	85	2024-02-23 00:00:00	Jose Prendes	Doug Bradley, Kayla Fields, Victor Maraña,...	3 linh mục được triệu tập đến nhà thờ để thực hiện lễ trừ tà liên tục 3 ngày 3 đêm cho cô bé bị quỷ dữ chiếm lấy thân xác. Nó trở thành một cái bẫy để lũ quỷ từ địa ngục đưa lời tuyên chiến đến thế giới. Liệu các linh mục có chặn đứng được hay sẽ biến trái đất thành cuộc chiến giữ thiên đàng và địa ngục?	t	2024-02-06 20:12:46.636868	\N	2024-02-06 20:12:46.636959	\N
b55598ea-6617-4549-9ed0-01f971afffc1	Trà	tbcackhu.png	123	2024-02-10 00:00:00	Lê Hoàng	Việt Hương, NSƯT Trương Minh Quốc Thái, Đoàn Trinh	Phim điện ảnh Trà của đạo diễn Lê Hoàng thuộc thể loại tâm lý - tình cảm, khai thác một vấn đề hôn nhân vẫn vô cùng “nhức nhối” ở thời điểm hiện tại: Ngoại tình. Bộ phim với sự tham gia diễn xuất của dàn diễn viên thực lực: Việt Hương, NSƯT Trương Minh Quốc Thái cùng tân binh Đoàn Trinh	t	2024-01-18 15:15:40.128766	\N	2024-01-30 03:27:54.010156	\N
d85e8011-4d65-480e-bcd6-6970cf5df040	Vong Ám	z2pn2wxx.png	94	2023-11-10 00:00:00	John McPhail	Justin Long, Andrea Bang, Augustus Prew,...	Ngay sau khi hoạ sĩ truyện tranh Adam (Augustus Prew) đáp trả những lời bắt nạt trên Internet, anh bắt đầu bị bóng đè khi ngủ - trong lúc đó một chiếc ghế bập bênh trống rỗng di chuyển trong góc căn hộ của anh ấy. Khi ghi lại những sự đáng sợ này trong một loạt dòng tweet, Adam bắt đầu tin rằng mình đang bị ám ảnh bởi hồn ma của một đứa trẻ đã chết tên là David. Được ông chủ BuzzFeed khuyến khích đào sâu chủ đề "Dear David", Adam bắt đầu mất nhận thức, không biết ranh giới giữa thực và ảo. Phim dựa trên chủ đề lan truyền trên Twitter của hoạ sĩ truyện tranh BuzzFeed Adma Ellis năm 2017.	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:47:02.393824	\N
f0b35534-869a-474e-b9ff-68b0eaf1e733	Nhà Vịt Di Cư	mjj3u4xc.jpg	83	2023-12-29 00:00:00	Benjamin Renner	Kumail Nanjiani, Elizabeth Banks, Caspar Jennings, Tresi Gazal, Awkwafina,…	Nhà Vịt Di Cư theo chân một gia đình vịt trời gồm vịt bố, vịt mẹ, cậu con trai tuổi teen Dax và vịt út Gwen, trong lần đầu tiên trải nghiệm chuyến di cư tiến về phía nam để trú đông. Thế nhưng, niềm vui vẻ sự háo hức kéo dài không bao lâu, gia đình vịt nhận ra, họ đang bay ngược chiều với tất cả các đàn vịt khác. Không kịp quay đầu, họ bất ngờ gặp phải loạt “chướng ngại vật” là những tòa nhà cao tầng của thành phố hiện đại. Liên tiếp sau đó là những thước phim đầy kịch tính nhưng vô cùng hài hước của nhà vịt trong quá trình khám phá đô thị mới.	t	2024-01-18 15:15:40.128766	\N	2024-02-06 20:46:18.128832	\N
\.


--
-- TOC entry 5005 (class 0 OID 35903)
-- Dependencies: 223
-- Data for Name: MovieCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MovieCategory" ("Id", "MovieId", "CategoryId", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
31f654c2-14ae-46a6-856e-8f707859fa71	76cf2797-f1b1-49a3-8f8a-ea34f91feb43	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-01-26 01:49:46.576725	\N	2024-01-26 01:49:46.576726	\N
f539dc2a-8bdb-411f-bca2-3e771704d163	b8539ffb-749a-435a-830c-b126caa27a9b	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-01-26 01:59:26.258426	\N	2024-01-26 01:59:26.258458	\N
e5abf874-78a4-4881-9b8d-1a3bd64ca588	3c3ccbb7-61a2-4296-a2a5-55252f89b900	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-01-26 17:03:32.647102	\N	2024-01-26 17:03:32.647135	\N
5496468a-1746-4e87-8087-15dcaaf6b191	fa6bea21-353a-4aba-9635-297d30fdbefe	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-01-26 17:04:09.510161	\N	2024-01-26 17:04:09.510162	\N
cb62e504-2013-4d4a-b5cd-33a85fd5113a	fa6bea21-353a-4aba-9635-297d30fdbefe	865d55e5-25e8-4d61-a755-bb3710f19010	f	2024-01-26 17:04:09.511777	\N	2024-01-26 17:04:09.511779	\N
e2fa66c7-165a-4425-8e6e-0f6c9a820a28	51ae6fef-e45c-46df-9a5f-a0bdc2b58b2f	5a00148e-0f3e-43c0-9e83-f8684bd81878	f	2024-01-26 17:04:29.637597	\N	2024-01-26 17:04:29.637598	\N
fb7bf698-aeb5-4a5d-80f1-c809284ef030	51ae6fef-e45c-46df-9a5f-a0bdc2b58b2f	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-01-26 17:04:29.636026	\N	2024-01-26 17:04:29.636028	\N
12f50870-e861-4be8-9cf8-d32511b32d40	b55598ea-6617-4549-9ed0-01f971afffc1	97bd07ba-1470-49d7-b455-f237392b4dae	f	2024-01-30 02:15:55.257541	\N	2024-01-30 02:15:55.257542	\N
e4b831fd-ca2f-46f4-a08e-fb7104779d25	b55598ea-6617-4549-9ed0-01f971afffc1	3b9c89a1-6f55-4a7b-bba1-19c123efa917	f	2024-01-30 02:15:55.235816	\N	2024-01-30 02:15:55.235847	\N
303895b5-f7e6-4c16-9759-aca94e32b821	de0f0cb4-8238-45f1-8342-fdd678bbc9e3	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-01-30 03:19:32.196054	\N	2024-01-30 03:19:32.196056	\N
3d865353-c81d-4011-b448-f70ca670bded	c474761c-c5cf-41b4-8dea-7a04c244ac4e	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-01-30 03:19:32.167556	\N	2024-01-30 03:19:32.167559	\N
3ed89c15-1738-420c-92af-952e7a003650	a61eafa6-3170-42b5-b1ab-42afaea7cd41	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-01-30 03:19:32.143351	\N	2024-01-30 03:19:32.143353	\N
48be0258-69c5-43e3-92c7-81028c8ce457	c0a830d7-b082-4c37-8251-ca9453277aea	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-01-30 03:19:32.157175	\N	2024-01-30 03:19:32.157177	\N
62234125-1f43-473a-8dc1-e9cec926cd5f	88072e16-0264-4498-ab30-ce5a67d5106e	865d55e5-25e8-4d61-a755-bb3710f19010	f	2024-01-30 03:19:32.206379	\N	2024-01-30 03:19:32.206381	\N
6432e3e6-c18a-49e0-9809-1336cd5bcc7a	c474761c-c5cf-41b4-8dea-7a04c244ac4e	865d55e5-25e8-4d61-a755-bb3710f19010	f	2024-01-30 03:19:32.170402	\N	2024-01-30 03:19:32.170404	\N
6bd9accd-8fd7-4823-9f35-edb1e33fe7d4	a61eafa6-3170-42b5-b1ab-42afaea7cd41	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-01-30 03:19:32.106088	\N	2024-01-30 03:19:32.106153	\N
6e2582cc-fec8-4d60-9a57-8769354863d5	f8778c8c-7190-4c2a-8505-77c6dc7e13e4	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-01-30 03:19:32.179018	\N	2024-01-30 03:19:32.17902	\N
70e919f6-8fb5-454a-97fb-cbc8af59e835	c0a830d7-b082-4c37-8251-ca9453277aea	97bd07ba-1470-49d7-b455-f237392b4dae	f	2024-01-30 03:19:32.160352	\N	2024-01-30 03:19:32.160354	\N
c656f180-83a3-41d5-b078-973cb64f409a	88072e16-0264-4498-ab30-ce5a67d5106e	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-01-30 03:19:32.203723	\N	2024-01-30 03:19:32.203725	\N
dbdea14d-f6c7-42db-8c52-e2b91d7b7a1e	f8778c8c-7190-4c2a-8505-77c6dc7e13e4	39bc63d0-6bae-49f8-9d26-b8b20ff3e5c8	f	2024-01-30 03:19:32.181864	\N	2024-01-30 03:19:32.181866	\N
f9c4e1fa-3b9a-48f9-9636-de585eeabf2b	de0f0cb4-8238-45f1-8342-fdd678bbc9e3	97bd07ba-1470-49d7-b455-f237392b4dae	f	2024-01-30 03:19:32.192361	\N	2024-01-30 03:19:32.192364	\N
7ac1ca97-d487-4cf8-a412-27ac0906fcd0	98944c73-f47c-455a-a3f5-3c111d278fd0	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-01-30 05:15:21.583401	\N	2024-01-30 05:15:21.583487	\N
20bdba90-c4f3-4916-89d9-edb99640ae53	7c986c90-d46b-402d-8ef6-ed911bff0ea5	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-01-30 22:12:45.816352	\N	2024-01-30 22:12:45.816354	\N
72c9be65-b02b-4448-86cf-a8e747079db3	7c986c90-d46b-402d-8ef6-ed911bff0ea5	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-01-30 22:12:45.814721	\N	2024-01-30 22:12:45.814722	\N
4f3beb00-1b54-4e85-b4b4-6c7c2cc4afd3	91fca915-8f0b-4501-a60c-3cb54c617169	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-02-06 20:12:46.63984	\N	2024-02-06 20:12:46.639879	\N
754d85a9-5ca9-43f4-bed3-1d69b55ed123	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3b9c89a1-6f55-4a7b-bba1-19c123efa917	f	2024-02-06 20:35:07.505272	\N	2024-02-06 20:35:07.505274	\N
afb02e09-69ee-41e4-8eec-57a295f5adc5	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	97bd07ba-1470-49d7-b455-f237392b4dae	f	2024-02-06 20:35:07.508613	\N	2024-02-06 20:35:07.508614	\N
2e3c7cfc-8d2c-4709-adff-0af504528e23	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-02-06 20:35:35.075261	\N	2024-02-06 20:35:35.075262	\N
f117d5e5-6738-4121-be2d-3b2f899d65f5	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	97bd07ba-1470-49d7-b455-f237392b4dae	f	2024-02-06 20:35:35.073871	\N	2024-02-06 20:35:35.073872	\N
0de891eb-8729-45ff-b03d-7594e3bbe476	aaaf2ce8-83d9-4ab9-80ef-518c12fff65b	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-02-06 20:41:41.764311	\N	2024-02-06 20:41:41.764312	\N
62c97b3f-d8be-4cb3-ae07-f289503a55c9	663eb791-e46c-4103-a0f2-75a9101ef83a	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-02-06 20:42:29.044952	\N	2024-02-06 20:42:29.044954	\N
ba707768-21cd-4f24-bf62-74d65fd47da6	6ec2252e-7940-4298-a6df-c822392a1044	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-02-06 20:43:07.202481	\N	2024-02-06 20:43:07.202483	\N
4820e5f3-17ff-4223-ae3d-a1cfa1db0f5c	60093677-5aac-4207-ada4-1a76012fff2f	dedbc97e-a553-410b-81f5-7871cea02288	f	2024-02-06 20:43:31.791031	\N	2024-02-06 20:43:31.791032	\N
6e6a4e70-f128-4579-8f67-cee11bc95644	60093677-5aac-4207-ada4-1a76012fff2f	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-02-06 20:43:31.788276	\N	2024-02-06 20:43:31.788278	\N
ee036fb0-cd3d-40c7-bcc5-a1f857c28ff5	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-02-06 20:43:46.211457	\N	2024-02-06 20:43:46.211459	\N
f4e4c5a1-ec34-433c-9652-49872fe28c2c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-02-06 20:43:46.209416	\N	2024-02-06 20:43:46.209418	\N
c1c2ab3f-6365-4bca-b5fd-3d1af1976fd3	253b1ac6-7619-491c-a60e-dddcbcaae135	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-02-06 20:44:24.734564	\N	2024-02-06 20:44:24.734565	\N
1601d861-8507-4855-8b9d-9226e7e2684c	49b2f6cc-ffaa-4e4e-a23e-5f9a5c39ad49	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-02-06 20:44:33.94234	\N	2024-02-06 20:44:33.942341	\N
6029bf8f-941b-4514-8e40-34349752673a	49b2f6cc-ffaa-4e4e-a23e-5f9a5c39ad49	97bd07ba-1470-49d7-b455-f237392b4dae	f	2024-02-06 20:44:33.944042	\N	2024-02-06 20:44:33.944043	\N
0b36e3bd-ea66-4aa3-ad30-87fac16c7622	bdea8635-5b88-4002-bb05-d12a09d7016f	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-02-06 20:45:02.187547	\N	2024-02-06 20:45:02.187548	\N
eee31dd4-abdf-40a5-bb53-d6ef9b533b97	bdea8635-5b88-4002-bb05-d12a09d7016f	865d55e5-25e8-4d61-a755-bb3710f19010	f	2024-02-06 20:45:02.190302	\N	2024-02-06 20:45:02.190303	\N
6cacf2bf-7044-49b7-80dd-5e0c27d51e67	a0ede518-5ae0-4209-b8c5-934773791e56	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-02-06 20:45:08.569982	\N	2024-02-06 20:45:08.569983	\N
336eb934-24db-4205-b8f4-ae71ff8b1c39	36eaf3ec-a347-4749-9cc7-11557d176b32	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-02-06 20:45:21.350086	\N	2024-02-06 20:45:21.350087	\N
b7d4e88f-5140-42bc-aaec-5dab93624d9d	cfb12716-5f9d-43f4-a2b0-72a09c3d10ad	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-02-06 20:45:41.584559	\N	2024-02-06 20:45:41.58456	\N
0a924bf6-0f04-41b2-99fe-54e413fbdb89	f0b35534-869a-474e-b9ff-68b0eaf1e733	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-02-06 20:46:18.133636	\N	2024-02-06 20:46:18.133637	\N
cd92761d-3f87-430a-8d8b-bf068ba0ac5e	f0b35534-869a-474e-b9ff-68b0eaf1e733	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-02-06 20:46:18.131908	\N	2024-02-06 20:46:18.131909	\N
d2b9c145-d98c-4be6-8683-4274aa963761	116b341f-1aaa-4750-bb64-a9af906e416c	1f066c91-6e21-495b-85d8-d405655307de	f	2024-02-06 20:46:55.075596	\N	2024-02-06 20:46:55.075598	\N
f9b61a18-a211-44f0-8f2f-4976d1af0172	116b341f-1aaa-4750-bb64-a9af906e416c	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-02-06 20:46:55.07377	\N	2024-02-06 20:46:55.073771	\N
bf7d6dc9-0138-49ad-a1af-d869c023ed35	d85e8011-4d65-480e-bcd6-6970cf5df040	a7c7b61c-26e4-4260-8f1b-417c393d44c1	f	2024-02-06 20:47:02.39677	\N	2024-02-06 20:47:02.396771	\N
3efd1f51-a689-4b64-a1c0-3e9e54f8e113	76a3f26d-22ee-46b4-8377-ea17757ebd06	97bd07ba-1470-49d7-b455-f237392b4dae	f	2024-02-22 11:43:37.06684	\N	2024-02-22 11:43:37.066842	\N
a924b90c-c166-45f0-8418-81c012cae251	76a3f26d-22ee-46b4-8377-ea17757ebd06	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-02-22 11:43:37.070514	\N	2024-02-22 11:43:37.070516	\N
bf6df707-868e-4057-a1bb-e7d08479d471	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-02-22 11:45:52.853698	\N	2024-02-22 11:45:52.853701	\N
eeac6807-f8e2-4b03-8533-4d5d80134fb7	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	865d55e5-25e8-4d61-a755-bb3710f19010	f	2024-02-22 11:45:52.858848	\N	2024-02-22 11:45:52.85885	\N
67ece3e5-60a5-42bc-a589-2aff0de4fc6a	7d09b7f4-223a-465e-a5e6-64f0098bd3e1	5dee9be2-3be5-4bbc-b724-9bf159b97861	f	2024-02-23 16:29:31.95893	\N	2024-02-23 16:29:31.958932	\N
6b1ee0b1-42fd-4610-806e-d0df4793c0da	7d09b7f4-223a-465e-a5e6-64f0098bd3e1	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-02-23 16:29:31.95114	\N	2024-02-23 16:29:31.95117	\N
7e629996-6a5b-49d0-a179-c3ab4d0d7092	2ac5fade-52ff-4482-8e53-7804feef97a0	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-02-23 16:29:51.889175	\N	2024-02-23 16:29:51.889176	\N
99733fa7-e1f3-4245-8bcb-c68e7617c212	a6fc3905-9277-447c-b171-acc9bbde56f5	379546d5-2639-4c1c-bc3b-fd155e5e6bf7	f	2024-02-23 16:31:00.043108	\N	2024-02-23 16:31:00.04311	\N
d83e3a70-e16b-4555-ac23-05899d9129da	a6fc3905-9277-447c-b171-acc9bbde56f5	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-02-23 16:31:00.045485	\N	2024-02-23 16:31:00.045487	\N
b5cbd335-43c4-4bf6-8eac-05ee18656ac5	13541362-df47-4393-b1b4-39a631472a01	865d55e5-25e8-4d61-a755-bb3710f19010	f	2024-02-23 16:39:14.943458	\N	2024-02-23 16:39:14.943459	\N
c7af66e2-cb38-4860-89ae-d6bb309e2933	13541362-df47-4393-b1b4-39a631472a01	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-02-23 16:39:14.945924	\N	2024-02-23 16:39:14.945926	\N
1b4accd5-4754-4166-b5a2-46fe92e116d9	9a09b6c6-92b4-4fd8-ad57-2927f08d2b2e	77799d5b-2e98-4952-9b7c-3a99a98db412	f	2024-02-23 16:39:21.570291	\N	2024-02-23 16:39:21.570292	\N
314dc6e3-dedd-40bb-9c51-1ca993448e38	9a09b6c6-92b4-4fd8-ad57-2927f08d2b2e	865d55e5-25e8-4d61-a755-bb3710f19010	f	2024-02-23 16:39:21.572381	\N	2024-02-23 16:39:21.572382	\N
b79fffb8-ef7b-474a-8862-1725321d8860	4f296c4d-be10-4161-942d-161e8ceb21fa	97bd07ba-1470-49d7-b455-f237392b4dae	f	2024-02-26 10:14:22.286064	\N	2024-02-26 10:14:22.28624	\N
\.


--
-- TOC entry 5015 (class 0 OID 36028)
-- Dependencies: 233
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Payment" ("Id", "ReservationId", "TotalPrice", "PaymentMethod", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
695498e1-4ad9-4497-b879-8ee4ec17fe91	7105fe58-b56c-41dc-88b2-51f42d2618f3	80000	Ví VnPay	f	2024-02-22 14:07:39.73526	\N	2024-02-22 14:07:39.735327	\N
3aee393e-7ea4-4c6c-8486-8bd98c4b2667	157db1cc-57b5-4330-ada1-e51f92848581	120000	Ví VnPay	f	2024-02-22 14:09:21.115479	\N	2024-02-22 14:09:21.11548	\N
308e0835-e490-4ef4-a8d6-cb802e41e482	a2ed1a2a-0989-4cda-8e7d-76d29ff69b13	80000	Ví VnPay	f	2024-02-22 15:38:01.928372	\N	2024-02-22 15:38:01.928402	\N
f24f624c-9bb1-4c54-b1a6-a2ac3529ab0e	a3cc3c06-223a-4730-83d9-00bd6ccd8cd8	120000	Ví VnPay	f	2024-02-22 15:39:09.786176	\N	2024-02-22 15:39:09.786177	\N
97618503-eb0d-47c6-95ae-d21c7f504721	d6f129b6-4b0e-4eba-a3ca-adfc096a9791	100000	Ví VnPay	f	2024-02-22 15:50:45.601527	\N	2024-02-22 15:50:45.601528	\N
88e8593f-e86e-4a3f-8203-82ac14d9768b	19272748-d78c-4fb8-b66e-0b6f08a48017	80000	Ví VnPay	f	2024-02-22 15:54:27.660293	\N	2024-02-22 15:54:27.660295	\N
\.


--
-- TOC entry 5017 (class 0 OID 52720)
-- Dependencies: 235
-- Data for Name: ProcessSeat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ProcessSeat" ("Id", "ShowtimeId", "SeatId", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy", "DeleteFlag") FROM stdin;
6f91da6e-7e63-46b0-97ce-f835986be522	f00a4d53-d14a-11ee-a723-c03eba28a56c	af5ce027-8e55-36f2-8416-f79116a6b0a9	2024-02-26 10:11:40.986442	\N	2024-02-26 10:11:40.986444	\N	t
c7a4dc1a-d288-4177-a372-25f33fa5f12e	f00a4d53-d14a-11ee-a723-c03eba28a56c	2dfb1d34-fb0e-a2b5-180d-3e93184c79eb	2024-02-26 10:11:41.670781	\N	2024-02-26 10:11:41.670783	\N	t
811daeac-aae3-4ef0-afb4-941868b95fb6	f00a4d53-d14a-11ee-a723-c03eba28a56c	6e1a07c6-215f-ad63-24e4-16f7669dfe16	2024-02-26 10:11:42.429566	\N	2024-02-26 10:11:42.429568	\N	t
b7966b36-314d-4dc7-840e-3b40ab837753	f00a4d53-d14a-11ee-a723-c03eba28a56c	eac7e4a1-1f7c-cfc3-8e4a-cc9e2a5502ac	2024-02-26 10:13:27.90929	\N	2024-02-26 10:13:27.909291	\N	t
50ce5a05-ead9-4569-84bb-8facf3b0f649	f00a4d53-d14a-11ee-a723-c03eba28a56c	f241f904-96b7-7b6b-ec23-998dfc27ae59	2024-02-26 10:13:28.686229	\N	2024-02-26 10:13:28.686232	\N	t
ab0c2ab5-d972-4e6a-9c0a-aa242c8fe6a0	f00a4d53-d14a-11ee-a723-c03eba28a56c	e22436a8-5ace-b087-998e-9ff616dc742a	2024-02-26 10:13:31.258369	\N	2024-02-26 10:13:31.25837	\N	t
\.


--
-- TOC entry 5014 (class 0 OID 36009)
-- Dependencies: 232
-- Data for Name: Reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Reservation" ("Id", "ShowtimeId", "UserId", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
7105fe58-b56c-41dc-88b2-51f42d2618f3	f015f73d-d14a-11ee-a723-c03eba28a56c	bde51f66-8ea7-473a-b96c-64eb479ef294	f	2024-02-22 14:07:39.556718	\N	2024-02-22 14:07:39.556745	\N
157db1cc-57b5-4330-ada1-e51f92848581	f015f73d-d14a-11ee-a723-c03eba28a56c	bde51f66-8ea7-473a-b96c-64eb479ef294	f	2024-02-22 14:09:21.097564	\N	2024-02-22 14:09:21.097565	\N
a2ed1a2a-0989-4cda-8e7d-76d29ff69b13	f0090ccf-d14a-11ee-a723-c03eba28a56c	16415794-faab-4b48-a61e-e3a11be4f14d	f	2024-02-22 15:38:01.803091	\N	2024-02-22 15:38:01.80315	\N
a3cc3c06-223a-4730-83d9-00bd6ccd8cd8	f0090ccf-d14a-11ee-a723-c03eba28a56c	16415794-faab-4b48-a61e-e3a11be4f14d	f	2024-02-22 15:39:09.765696	\N	2024-02-22 15:39:09.765698	\N
d6f129b6-4b0e-4eba-a3ca-adfc096a9791	f007ccae-d14a-11ee-a723-c03eba28a56c	a6d1e91f-ef87-4635-93be-c6fc9fb6e3c6	f	2024-02-22 15:50:45.573777	\N	2024-02-22 15:50:45.57378	\N
19272748-d78c-4fb8-b66e-0b6f08a48017	f0090ccf-d14a-11ee-a723-c03eba28a56c	a6d1e91f-ef87-4635-93be-c6fc9fb6e3c6	f	2024-02-22 15:54:27.640672	\N	2024-02-22 15:54:27.640673	\N
\.


--
-- TOC entry 5016 (class 0 OID 36042)
-- Dependencies: 234
-- Data for Name: ReservationItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ReservationItem" ("Id", "ReservationId", "SeatId", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
1e22d5fb-e8a7-47d0-97a6-c3be7b7eafe1	7105fe58-b56c-41dc-88b2-51f42d2618f3	2dfb1d34-fb0e-a2b5-180d-3e93184c79eb	f	2024-02-22 14:07:39.648723	\N	2024-02-22 14:07:39.648785	\N
c1b9fdf2-f78a-4d2e-b235-996f12afb342	7105fe58-b56c-41dc-88b2-51f42d2618f3	6e1a07c6-215f-ad63-24e4-16f7669dfe16	f	2024-02-22 14:07:39.650885	\N	2024-02-22 14:07:39.650886	\N
2c7ecb9b-0efb-4792-a7e5-840ee6ab3319	157db1cc-57b5-4330-ada1-e51f92848581	586ffbb9-c764-711e-3e14-ff34e57a0b9e	f	2024-02-22 14:09:21.104875	\N	2024-02-22 14:09:21.104877	\N
c429fb4a-befc-4733-9d5f-d33601c9cf9d	157db1cc-57b5-4330-ada1-e51f92848581	6f1e560a-691c-b849-2788-181f4353bb5d	f	2024-02-22 14:09:21.108915	\N	2024-02-22 14:09:21.108917	\N
f675f092-39a2-4c63-989e-d2433c1952ff	157db1cc-57b5-4330-ada1-e51f92848581	1e926d71-b430-008b-317b-af44259b24d8	f	2024-02-22 14:09:21.106817	\N	2024-02-22 14:09:21.106818	\N
227fc44b-d743-4350-811c-1939d0839027	a2ed1a2a-0989-4cda-8e7d-76d29ff69b13	6e1a07c6-215f-ad63-24e4-16f7669dfe16	f	2024-02-22 15:38:01.88024	\N	2024-02-22 15:38:01.880241	\N
4abe5079-e3ef-45d7-8bdb-b041736c663a	a2ed1a2a-0989-4cda-8e7d-76d29ff69b13	2dfb1d34-fb0e-a2b5-180d-3e93184c79eb	f	2024-02-22 15:38:01.878587	\N	2024-02-22 15:38:01.878617	\N
8caf0497-9140-43a8-85fa-ce81dc619a5b	a3cc3c06-223a-4730-83d9-00bd6ccd8cd8	1e926d71-b430-008b-317b-af44259b24d8	f	2024-02-22 15:39:09.77687	\N	2024-02-22 15:39:09.776872	\N
a20ae191-54ac-4df3-9a60-4fab6913f37c	a3cc3c06-223a-4730-83d9-00bd6ccd8cd8	6f1e560a-691c-b849-2788-181f4353bb5d	f	2024-02-22 15:39:09.77946	\N	2024-02-22 15:39:09.779461	\N
e3727b1c-1fc1-4ff4-bc8f-b33ca388915f	a3cc3c06-223a-4730-83d9-00bd6ccd8cd8	586ffbb9-c764-711e-3e14-ff34e57a0b9e	f	2024-02-22 15:39:09.775207	\N	2024-02-22 15:39:09.775208	\N
24198923-532c-4ec1-b49d-2f3dd4270b98	d6f129b6-4b0e-4eba-a3ca-adfc096a9791	2dfb1d34-fb0e-a2b5-180d-3e93184c79eb	f	2024-02-22 15:50:45.592266	\N	2024-02-22 15:50:45.592267	\N
f86ebb6f-f778-426f-80bf-7b3c50835adb	d6f129b6-4b0e-4eba-a3ca-adfc096a9791	af5ce027-8e55-36f2-8416-f79116a6b0a9	f	2024-02-22 15:50:45.589802	\N	2024-02-22 15:50:45.589805	\N
4ffebd8a-bd21-40cd-857d-c98522685e29	19272748-d78c-4fb8-b66e-0b6f08a48017	223ac2a9-d65b-9ba5-c5c1-0cb34fe5fafb	f	2024-02-22 15:54:27.65291	\N	2024-02-22 15:54:27.652911	\N
74eba404-d16b-4d8c-9731-e8c9c8869dbd	19272748-d78c-4fb8-b66e-0b6f08a48017	dffc3239-c87b-ec72-e265-79845384df2c	f	2024-02-22 15:54:27.650848	\N	2024-02-22 15:54:27.65085	\N
\.


--
-- TOC entry 5008 (class 0 OID 35943)
-- Dependencies: 226
-- Data for Name: RoleClaims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RoleClaims" ("Id", "RoleId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- TOC entry 5002 (class 0 OID 35876)
-- Dependencies: 220
-- Data for Name: Roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Roles" ("Id", "Name", "NormalizedName", "ConcurrencyStamp") FROM stdin;
e989c4ca-e1e7-4f7e-9e6c-a014e87e89fc	Admin	ADMIN	dea2237f-0d72-41f8-afbb-8cd386422fc4
7a6f0e8b-0705-4eaf-9714-14819cef32e8	Customer	CUSTOMER	3d0254b5-9b4f-4a89-96c7-97fd619e202f
\.


--
-- TOC entry 5003 (class 0 OID 35883)
-- Dependencies: 221
-- Data for Name: Seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Seat" ("Id", "RowNum", "SeatNum", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
68f20922-df61-4009-a8fc-9229bad81486	B	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c6b7845d-72cf-a57b-7a10-d03d1f20cf12	C	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
14c5d3bd-9426-fa6b-ab1f-f4c17a3f0e52	D	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
5efed4e9-4072-cb20-f131-2da9bdecaeef	E	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
bd33fb71-66a3-cb98-385c-f381ec17c934	F	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c29bcf7a-15ad-bdad-5520-26c762d3d46b	G	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
e73d39f8-08ab-e663-3d50-8a26498b4e05	I	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
ed389011-2aab-c4a1-d873-39e2723af753	J	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
4b24b981-3604-54ae-72df-42807e56e5ab	K	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
4c9cbac7-2982-982c-0bcb-5f907dfb279e	A	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
b880d7e0-9b84-7e15-5d0f-9941274c0dee	B	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c31e9dce-a119-6b86-4908-4967811eaa34	C	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
86a981ff-bc4b-f64b-4e3c-98c2332aa8c3	D	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
773f489a-98e6-3d6b-d89f-266c87d90533	E	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
cdd728b0-3790-9714-77ad-d6561aab1998	F	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
dffc3239-c87b-ec72-e265-79845384df2c	G	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
fe58fca9-db0e-9ce1-2a24-b3634ec31268	H	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
218a7c33-5efc-9162-8706-b48bbccb2443	I	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
af0179c0-cc67-2de7-3787-7c6d4eb53b3f	J	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
b744aa78-e140-091f-c45e-2ecce51e94a7	K	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
d3f4dc3c-a8be-30e3-a907-cf8baca133ce	A	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
71908fff-7f1a-439a-14b7-bc6e1222edaa	B	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
f068d254-bd18-7e41-fd15-b433930c7ba4	C	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
49cd4b18-09fe-7b60-ead4-50c93a0336ad	D	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
5ce3e9b6-1976-519c-63dd-521f62045001	E	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
02d9d78e-a60f-7601-ae3e-8f7cc0d50ade	F	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
d2bcda93-8609-7040-4418-b47b4a739236	G	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
011b94e8-b39d-f353-b3ca-8aec3998db05	H	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c0d2cd12-bb4a-1158-c807-73477df39f36	I	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
84bcf913-65fc-5fa3-e66c-0f2cbf7cc298	J	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
63f37375-2ede-5808-80b7-72d1165c6920	K	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
57fc9f1a-6537-8f10-226f-82712e4b0975	A	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c2be69c2-fa88-cd61-34a2-588d0409e9c2	B	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
572fa76e-72d1-6784-22e5-65ef09612448	C	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
f241f904-96b7-7b6b-ec23-998dfc27ae59	D	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
6e1a07c6-215f-ad63-24e4-16f7669dfe16	E	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
6f1e560a-691c-b849-2788-181f4353bb5d	F	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
bc0b4fb8-7d9a-589b-1e12-e478879bfb05	G	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c5d34ed9-de0b-865d-2ad7-78cf912cb29a	H	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
5ac01a27-2b3b-636a-abab-4495ed7ca9cd	I	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
9f104782-d46d-93a3-efdd-43dc5c0ae6ac	J	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
74a60563-40ca-6690-351c-31211b6d1791	K	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
4bed7117-5826-b9d8-be56-80476d68feb7	A	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
abd6e7b1-2988-1c07-fe84-9fabc7304eaa	B	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c4cd76c7-cb8b-9c25-057f-f14779499bf1	C	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
3e44a6c4-1962-ed4a-de38-48c8ff018e44	D	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
f479e3c0-1cd0-99c9-5719-98118e15f5c7	E	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
b98fc675-18f8-8322-90b4-33a244276209	F	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
f91a4bac-ccf9-6003-1076-7c2076e75314	G	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
6f7e14e5-8b8f-2e5f-bff9-69eda1e92161	I	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
41ac3600-aa0c-2de1-68ff-efed39149101	J	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
8deb2a0c-be5c-b767-778a-828230d13d81	K	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
62513b22-8bb4-cbdf-3b04-f98cae9f0fa6	A	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
0c012305-9a8e-5e4b-025e-7f89ea29cf12	B	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
8d71435a-a074-c207-c113-b58bec4a890b	C	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
a8554607-c850-cf82-6c2b-2c4135024251	D	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
7894f962-3d3f-dded-d3e1-68e0bcd435f3	E	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
2b60140d-5108-450c-e16c-906af607a578	F	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1941afc9-7e0e-2932-60c3-8edcf1e2219a	G	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
119e04a3-af1e-e0ec-8faf-d585af158727	H	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
01262690-2ac0-a94a-dfaf-6f96a485f111	I	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c0a9776f-9f83-1ce7-096a-00496a87b4d1	J	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
0e23f4fa-dda6-be3c-8eaf-22cab66c82a3	K	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
f0d9fa90-29ad-8c29-b0e2-3f57df913317	A	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
bfa74867-b32a-522e-daad-e024999049c0	B	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
2cd74e71-678b-1010-3d49-c8ffba9d63c5	C	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
9d1715e7-f299-4a84-0a00-4d32f5d95e4d	D	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
3e8b3728-e8de-fb48-92af-7d6ff4a22731	E	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1af8c685-9cf2-b38b-00b1-eb0cab3b1e07	F	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
d5a5000e-014a-859d-00ac-9221fc5385e8	G	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
2edd1541-6105-fbae-c766-7b5ead3daa68	H	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
bd9a0d66-a0cb-3155-2f1f-2501bf7c6419	I	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
d5b7f359-d77b-aa35-0ee1-397ad32fe047	J	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
5dab76d8-fd99-0cd9-7a5c-93861618104c	K	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
764f73c6-cb89-9f68-92e7-a8a3d3694360	A	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
9dd4df1b-508b-b48f-9685-aa4ce3247e26	B	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
52c4b84c-39fd-ba65-cba3-09edeb9a8b3c	C	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
eac7e4a1-1f7c-cfc3-8e4a-cc9e2a5502ac	D	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
2dfb1d34-fb0e-a2b5-180d-3e93184c79eb	E	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1e926d71-b430-008b-317b-af44259b24d8	F	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
dc005ee7-dd15-8042-36ad-bec8e0588782	G	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
aa67c8c3-3dfd-9230-92a1-aeb855c38af2	H	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
81169ccb-17bb-c722-4c50-e82397e0f1db	I	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
57143c32-d150-2038-ac81-eed65d34ff72	J	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
a4538467-7104-79a3-8c24-aa02ec9b86d6	K	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c8d636d9-7a0a-3d2c-adc5-502fa66174ed	A	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
b3217115-eaeb-0ee4-562c-f4619841ba95	B	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
631f3179-163b-a347-1ece-662ac9d2dab3	C	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
f92e4669-4d5f-e4a7-620c-239a7f404d79	D	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
be9a83f0-74fd-e086-d1f3-236f9156892c	E	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
63fcd089-8850-e28d-2e04-e1fd8269b63b	F	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
ad57cb58-fc10-1681-072b-3c8a2e1bdd37	G	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
121238cc-8c35-8ce1-45ef-6c78e5caa24f	I	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
268257ef-eb22-e8e8-94ea-18b464146585	J	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
f3f77826-9339-9e07-921f-f85ed8406df2	K	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
9e5cf80b-2cfd-8c2e-3fc7-838b7dde8def	A	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1c75a9df-8a1b-231a-91f8-4788ba86ff77	B	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
a15ba832-c176-2f8a-4fb6-058f883412e8	C	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
e8674d9d-aefa-7204-0bca-8e9a92d3350c	D	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
899ebbef-296e-5d25-2229-0f2b03639781	E	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
6e4fa5c2-71aa-7716-7163-c304f4bce408	F	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
971196b5-4147-4930-bd6e-c16624b7ec9f	G	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
539fdd76-61da-f3a3-65cb-6873b6951650	H	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1e6d5e41-112d-d3a7-b15d-c23c1677f2c8	I	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
b13b6732-8ae9-9102-fea3-a00529f6502c	J	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
372a5e3c-9ea4-07cd-1108-f0f59413487f	K	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
a53166c0-3e9f-49a0-094f-c8be2db5664d	A	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
215906a9-d85d-3e4f-a9e0-d6eb76cab4bf	B	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
79a1ae68-4645-21c2-f92f-b1db9846a65d	C	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
24efc933-002f-ad02-0d98-b14ce6085b5d	D	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
b1038502-739a-9cba-8795-50dcf7a35b7d	E	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1c8c4b95-a231-f5fb-7f1b-42d26c437856	F	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
b03ce85a-6ca8-f92b-bd2d-6868c15b3d1b	G	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
8629a63f-8c62-8dba-5e48-5ce9ca4f4375	H	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
dadc350b-7d5a-ec8d-3b76-a7aff74c2769	I	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
7dd72392-5915-df0e-2e93-c5ee29246d33	J	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c2785aef-9ac5-3c5c-d1ca-6a90ec64af7c	K	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
d7381885-9d35-21d2-3491-0dc66c8b8385	A	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
53dabb39-561a-05d2-8b55-4af91d42e71a	B	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
385e01f1-5c1a-8c2f-b5b1-bb1167731ed7	C	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
ca938e22-9178-425b-1a0b-b6c9c9611a46	D	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
af5ce027-8e55-36f2-8416-f79116a6b0a9	E	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
586ffbb9-c764-711e-3e14-ff34e57a0b9e	F	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1c9b6e25-2d47-6d9f-ae49-603f0f6238d7	G	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
478290de-a415-8726-4d8b-a756d0654c16	I	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
d4d6afef-d802-1180-e580-2c64d3660e4b	J	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
5f27e9f6-e69a-1815-2dd2-e4850a6b378e	K	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
4f5dc581-604f-7d87-01c2-0d3286ff2402	A	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
4686742c-62e9-ad47-0832-dd5a55122516	B	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1c5d7bb2-ae01-9a8b-d843-60af4d596437	C	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
bb22243f-6e89-a74d-d67f-7efe91aeae24	D	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
920115e0-35af-6b05-1bed-3ed6c6bbe094	E	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
278607df-30c1-a447-4291-c508d54e655c	F	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
223ac2a9-d65b-9ba5-c5c1-0cb34fe5fafb	G	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
7d25edd9-93b7-4ae9-c68e-20a1c42e1462	I	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
86073c64-4594-296c-3f3a-eb954a5d2c9a	J	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
995b872a-4cb5-e195-0f61-6186e9e595de	K	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
17cc1299-7e61-de40-5b34-c794bde7ca7a	A	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
13ef81be-9f7b-31be-5c3e-47a121ad832a	B	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
4f9e042f-d531-4a25-c3b9-8d1479661b85	C	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
fae636e6-796c-c7d8-e2f9-c69782e0ac6b	D	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
afc7f977-262c-06c0-ca28-5c7966c3c8f6	E	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
f7fb2978-71fb-9036-db9a-ff132f9cb1a7	F	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
c8a69bae-b8a6-49da-867b-3ca8f55e2d91	G	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
ec734335-3996-4676-9a6a-0b98c9f4a965	H	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
56f8d7bc-0bd6-660f-b0cf-6c9d57868acb	I	2	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
a0e1520e-88ea-2f7a-c521-9b5ee80fedc6	J	3	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
ce7d7552-c7e4-a801-dcb9-e3e1b40f0d30	K	4	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
54fb7771-aad8-a610-dbde-e6bb391d0d76	A	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
32e71f45-74fb-c4db-10c3-f42373b2f092	B	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1d6e5b99-44ab-8871-63a3-009ac0a6cd7b	C	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
e22436a8-5ace-b087-998e-9ff616dc742a	D	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
72dc0bdd-9d22-ec12-b061-d6015886c7a5	E	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
e7deeaba-5ad6-0e6c-ef20-e1540f2254db	F	10	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
abfc566a-7c88-7c75-b5f8-442c2f6b435b	G	11	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
4b152e67-525d-25a8-c8d8-61f481ff4462	H	12	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
b12d30e5-6bba-3dd8-991e-67a65913e482	I	13	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
1e480a89-d5f2-4b37-9de3-1d9fdfcefb35	J	14	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
982e3621-28c4-80c7-bc63-ed2b97c60a25	K	15	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
86a3fef7-0e3a-1a00-fcbe-159e2fb387b5	A	1	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
bcd1a059-1d94-d08e-7054-436a03c3184d	H	5	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
db4e20ed-c553-d371-5ec2-f277fa35358c	H	6	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
75f9bfc2-ec62-f0df-d62b-a3dd1dc13a6d	H	8	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
652017d6-5259-5492-27dd-b13ceb883c79	H	7	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
8230ad74-5b00-d8cd-afd1-b9ff3da093b7	H	9	f	2024-01-11 14:57:22.505058	\N	2024-01-11 14:57:22.505058	\N
\.


--
-- TOC entry 5006 (class 0 OID 35922)
-- Dependencies: 224
-- Data for Name: Showtime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Showtime" ("Id", "MovieId", "CinemaId", "StartTime", "TicketPrice", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy") FROM stdin;
710c1803-0abd-4c67-b2e3-08e5857cb6d2	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 18:00:00	40000	f	2024-02-22 13:34:40.265202	\N	2024-02-22 13:34:40.265231	\N
f016c85f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 19:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c93a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 20:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ca62-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016cb31-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016cc02-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 22:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ccd3-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016cdcb-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ceaa-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016cf80-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d053-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 13:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d27f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d36a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d441-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 11:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d516-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d5f2-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d6c9-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d79f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d879-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016d94a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 14:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016da1c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016daf8-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016dbd0-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 09:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016dca5-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 17:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016dd78-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016de4a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016df1f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 14:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016dffa-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016e0cf-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016e1a4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 10:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016e283-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016e35a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016e42e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016e503-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016e7bd-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ccae-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 13:20:00	50000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 15:49:48.217117	NULL::character varying
b859737f-7e45-4a63-891d-fee01d8cd9bb	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 20:00:00	60000	f	2024-02-22 13:44:28.191035	\N	2024-02-22 13:44:28.191036	\N
f016e8f7-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 10:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016e9ea-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016eae4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ebb7-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ec8a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ed5b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ee2d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 19:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016eeff-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 18:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016efd6-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f0a9-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f1c6-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f29c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f36e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f444-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 14:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f513-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f5e6-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f6b8-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f787-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f857-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f92a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016f9f9-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 21:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016facd-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016fbbf-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016fc96-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 09:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016fd6b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 23:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016fe3f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 17:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ff1a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 20:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ffeb-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01700c8-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 18:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f017019e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f017026f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170343-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170416-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01704e6-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
240ab3e5-7ef5-420c-9481-c5c64a085c78	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 23:00:00	40000	f	2024-02-22 14:01:15.129245	\N	2024-02-22 14:01:15.129246	\N
de5e7069-7401-41e0-a7f4-c60279c98e8d	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 20:00:00	40000	f	2024-02-22 14:01:15.12218	\N	2024-02-22 14:01:15.122253	\N
f01705c4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01708a1-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f017098b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 12:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170a9c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 23:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170b98-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 22:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170c6e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 23:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170d3f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170e15-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 10:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170ef4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 11:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0170fca-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f017109b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171170-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f017124e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171330-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f017140b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 22:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01714e1-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01715c5-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01716bb-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171790-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171872-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171954-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171a32-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 18:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171b0a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 09:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171be7-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171cc4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 23:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171da5-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171e9b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0171f71-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f017204c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 18:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0172124-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e8a3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e967-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 23:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ea0a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ead3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006eb5f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ec55-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006edd7-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ee55-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006eeb8-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ef21-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 21:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ef83-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006efe9-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 20:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006f0a0-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006f187-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006f44d-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006f62a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 16:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006f8a9-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fa26-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006faca-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fb56-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fbbc-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fc2e-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fcaf-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 09:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fd37-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fd92-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fe48-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 22:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006fec2-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 16:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ff17-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ff6a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006ffc2-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007001a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007006c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 15:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00700c0-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070113-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007016c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00701c1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 11:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007021a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007026f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00702c6-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 23:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007031c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070370-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 13:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00703c6-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 14:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070437-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 10:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00704df-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070540-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070592-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00705e8-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007063a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070690-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00706e3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070738-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007078a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 23:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00707de-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007082f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00708b1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 18:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070904-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070958-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00709b6-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070a09-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070ada-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070b2b-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070be1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070c3f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070cc7-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 10:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070d38-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 12:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070d8a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070ddc-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070e2f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070e80-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070ed3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0070f25-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0071108-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007115e-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00711b1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0071203-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 22:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0071255-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00712a3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007131d-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007137c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 11:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00713c8-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0071418-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0071465-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00714b3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00714ff-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007154e-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00715cb-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0071622-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007166f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 21:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00716bd-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 23:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007170b-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073411-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007355b-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00735bc-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007361c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 14:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073675-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00736c7-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073716-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 13:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073767-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00737c1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073894-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00738e3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073934-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073987-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 15:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00739e7-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073ad8-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073b85-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 19:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073c0e-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 09:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073d84-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 21:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073e0d-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073e63-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073eb9-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073f09-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073f5b-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-29 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0073fb6-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074008-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074058-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00740ab-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074102-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 17:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074162-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00741bd-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074218-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074349-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007439f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 10:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00743ee-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007443c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007448c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 09:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00744dc-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074532-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 17:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074586-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00745dc-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-29 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007462f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074685-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00746d4-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 19:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074728-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007477c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00747e1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074868-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00748be-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 15:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074919-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0074970-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00749e7-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076308-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007641e-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00764ea-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076555-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 09:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00765a9-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00765fa-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007664c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007669e-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076710-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076762-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 19:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00767c6-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007681a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 18:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007686b-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00768dd-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076932-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076984-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00769f4-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076a45-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076a95-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 09:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076ae4-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076b33-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076b86-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076bd9-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076c29-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076d25-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076d78-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076dc8-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 18:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076e19-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076e6d-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076ec1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 20:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076f10-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076f61-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0076fb1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0077002-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0077054-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00770a8-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00770fb-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0077154-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00771a6-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00771fc-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 21:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00772a1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00772f4-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0077347-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 15:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00773f8-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007747a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007757b-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0077610-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0077674-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 15:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00776c7-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0077722-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 09:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007b77c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007b9e9-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ba5c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007babe-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bc2c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bc84-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bce0-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bd36-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bd94-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007be17-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007be6f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bec3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bf38-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bf92-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007bfeb-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c065-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c0b7-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c10d-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c161-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c1b3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c208-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c289-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c300-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 23:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c352-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 11:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c3a7-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c3fd-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 09:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c450-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c4b3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c510-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 09:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c570-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c5c2-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c615-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c669-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c6bf-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c7c1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c813-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c867-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c8be-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c90f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c963-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 16:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007c9c4-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 14:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ca1e-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ca71-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007cac3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007cb16-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007cb69-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007cbbc-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 13:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007cd2e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 17:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007cd95-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ce08-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ced9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007d024-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 09:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ef44-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f169-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f1cf-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f235-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f293-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 18:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f2f1-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 12:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f34c-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 19:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f3aa-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f409-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f475-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f5c8-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f62d-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f694-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f6fa-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f759-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f7b6-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-29 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f816-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 20:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f878-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f8d2-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f92e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007f9a5-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fa01-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fa64-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fadd-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fb7d-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fc5e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fd10-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fd8b-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 21:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fded-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fe55-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 12:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007feaf-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ff16-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007ff90-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f007fffe-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 22:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008007f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 18:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0080109-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 14:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0080172-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00801ed-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 16:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0080257-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0081ba2-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0081f29-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 15:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0081fa1-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0082008-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0082061-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00820de-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0082177-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00821e1-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 19:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0082235-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008228d-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083a65-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 23:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083bb9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 09:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083d32-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083d9f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083e0a-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 14:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083e71-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083eda-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 14:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083f35-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083f8e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0083fe8-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084042-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008409e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 21:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084119-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 20:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084173-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084207-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008428c-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 10:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084305-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084365-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00843c6-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 14:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008442c-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 14:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084491-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00844ea-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 15:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084547-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 14:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00845a3-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 23:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00845fc-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084655-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 13:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084784-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00847ea-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084842-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084899-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00848ff-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008495f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00849c1-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084a2a-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 19:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084a90-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084aec-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084d72-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084dd7-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084e38-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084e91-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 23:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084ee7-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0084f46-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00864e1-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00865d3-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00867e3-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00868bc-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008692a-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 13:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0086982-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00869dd-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0086a32-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0086a88-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0086ade-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0086b34-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 15:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0086b88-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088556-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00886ac-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008876b-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00887ca-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008882a-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088881-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088936-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00889d4-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088a2d-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088a86-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 09:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088adb-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 21:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088b3a-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088b9f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088bfc-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088c52-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088ca9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088d00-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 23:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088d57-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088db5-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088e0f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088e65-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 11:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088ebc-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 14:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0088f13-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 21:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00890bd-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089122-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008917e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00891d9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 18:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089235-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089286-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00892da-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008934a-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008939f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089408-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 15:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089489-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00895d5-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008963e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 19:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089692-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00896f0-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089744-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089798-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00897eb-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008983e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0089891-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008990a-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008bee1-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c41f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c550-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 21:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c609-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 16:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c689-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c722-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 16:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c7b2-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c818-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c89d-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c935-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008c9c4-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008ca40-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008cac4-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008cb7c-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 10:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008cbee-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 15:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008cc70-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008ccee-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008cd75-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 16:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008cdfc-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008ce81-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d0e0-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d161-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d1bb-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d215-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d268-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d2bc-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 11:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d30e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d362-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d3b9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d431-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d4cf-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d590-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d5eb-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 12:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d642-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d69c-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d6f3-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d748-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d79b-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d7ee-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d85e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d8e1-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 23:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d96f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008d9e3-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008da3b-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 11:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008da9e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008daf5-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008db49-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008dba2-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008dbfd-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008dc53-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 22:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008dccf-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008dd6f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008de3f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 21:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008deb6-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 20:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008df0f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008df68-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 22:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008dfc3-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008e01b-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008e074-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 10:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fa77-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fc08-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fc6e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fcc9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fd1f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fd97-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 13:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fdea-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fe44-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 21:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fe9a-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 18:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008fef0-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008ff43-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 09:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f008ff98-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 13:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090044-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00900fb-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 21:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090156-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00901a9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 19:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00901f9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009024d-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009029e-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 15:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00902ef-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090343-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 22:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009039f-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00903f7-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009044b-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00904a2-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00904f7-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009054c-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00905ad-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 21:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009061c-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 17:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009066d-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00906c4-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009071b-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 12:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090771-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 15:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00907cd-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090828-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 10:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090885-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00908d9-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090933-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-29 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090c17-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090ccf-d14a-11ee-a723-c03eba28a56c	4f296c4d-be10-4161-942d-161e8ceb21fa	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090ddc-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0090ea8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0092cf8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0092fa2-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009304a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00930b0-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 16:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0093115-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 22:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094823-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094aea-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 23:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094b9d-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094c3d-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 14:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094cc6-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094d2f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094da8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094e44-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 18:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094f1f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 20:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0094ff0-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00950b9-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095199-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095295-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009543e-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095501-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 21:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009565a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009570a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00957b8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 23:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00958df-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 13:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095988-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095a10-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095a6b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095adf-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095b6b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095c0a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095ca7-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095d1c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095d80-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 13:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095ddd-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095e39-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 23:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095e98-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 17:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095f1d-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0095fa8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0096009-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0096066-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 16:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00960e2-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0096178-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00961e5-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0096241-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00962c2-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009636c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00963cd-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 14:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009642a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009648a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00988ca-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0098d1f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0098daa-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0098e1b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0098e8f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0098ef4-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0098f58-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0098fc5-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 22:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0099038-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0099097-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00990f0-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 18:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0099147-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009af89-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b0ef-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b168-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b1d1-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 12:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b238-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b29c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b306-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b36a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b3ce-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b431-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 14:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b491-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b4f4-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b55a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b5bc-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b61b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 14:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b67e-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b6de-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b73c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 17:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b79e-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b7ff-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 10:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b861-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b8c2-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b928-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009b98d-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009ba53-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009baad-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bb06-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bb5e-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bbb8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bc10-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 16:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bc67-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bcc2-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 23:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bd19-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bd72-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 11:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bdc9-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009be23-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009beb9-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bf18-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bf74-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009bfcf-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c028-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 23:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c084-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c0de-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c139-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 15:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c194-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c1ec-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c245-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 11:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c29f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c2fa-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c3a2-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c408-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 10:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c46c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c4d0-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c54e-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c5b0-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c614-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c675-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c6d6-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c738-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 14:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c79a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c7fc-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c859-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 19:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c8b8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c919-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c97a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 22:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009c9dd-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009ca42-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009caa7-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cb0a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cbe4-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cc4e-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009ccb8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 10:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cd14-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cd6f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cdc6-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009ce20-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009ce78-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cecf-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cf2c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 09:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cf88-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-29 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009cfe6-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d03f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d09a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 12:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d0f2-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d1ac-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 23:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d20c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 12:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d266-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 15:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d2c0-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d31a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d372-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d3cb-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d426-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d48c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 15:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d4eb-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d55b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d5b9-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d613-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d66b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 20:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d6c6-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d71f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 19:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009d779-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 17:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009f0b7-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 09:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f009f20f-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0684-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 10:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0759-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a07ba-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0814-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a086a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 20:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a08c4-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0916-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 17:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0970-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 21:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a09c3-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0a15-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0a67-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0ab9-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0b0d-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0b5e-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0bb5-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0c09-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0c5c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0cb3-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 22:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0d04-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0d58-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0dab-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 16:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0e00-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0e51-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0ea3-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0ef5-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 11:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0f47-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0f9a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 11:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a0fef-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 22:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a1044-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 09:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a1097-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a10ea-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 09:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a1141-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 14:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a1195-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a11ec-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a1241-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a1296-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a12e8-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a133a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a1390-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 22:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a13e5-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a2b69-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a2c8a-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a2cee-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a2d49-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 23:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a2da2-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4179-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a42be-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4337-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a439b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4435-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 18:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a448b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a44df-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4531-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 19:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4585-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a45d9-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 17:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a462c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 20:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4680-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a46d3-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4724-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 09:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a477c-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a47cf-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4825-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 19:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4877-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a48d1-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4925-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 18:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4975-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a49c7-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4a1d-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4a78-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4ace-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 23:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4b26-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4ba4-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4bfc-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4c56-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 23:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4caa-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4cff-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4d53-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4daa-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4dfc-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 10:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4e4d-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4ea4-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 19:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4ef5-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 17:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4f49-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4f9b-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a4fee-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a5043-d14a-11ee-a723-c03eba28a56c	60093677-5aac-4207-ada4-1a76012fff2f	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a5101-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 11:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a518d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a51fd-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a525a-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a52b9-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-29 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a5315-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-29 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a5372-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a53cf-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a542b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a548c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a54e7-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a5546-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a55a4-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 10:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a5601-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a567e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a56ec-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a5747-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a6ec2-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 15:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a6ffe-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7069-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a70c7-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a712d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 17:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a718a-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 23:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a71e7-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7244-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 16:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a729e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a72fb-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 15:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7356-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a73b5-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7416-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7472-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 18:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a74cc-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7527-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7581-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a75db-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7638-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a768f-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a76e6-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 21:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7739-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 23:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a778c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a77e0-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7831-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7883-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 22:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a78da-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a792e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7981-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a79d3-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7a26-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7b4a-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7b9e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7bf0-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7c42-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 21:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7c95-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 19:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7cec-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 20:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7d3e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 19:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7d90-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7de4-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7e3e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7e91-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7ee9-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7f3d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 10:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7f8e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a7fdf-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8031-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8082-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a80f6-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a814a-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a819d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a81f0-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8243-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8294-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 19:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a82ec-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 09:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a833e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 18:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8394-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a83e7-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 19:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8439-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a848c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a84df-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8531-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8586-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a85d9-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 11:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a862b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 14:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a867e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a86de-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a875e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a87f0-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 11:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8875-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a88fa-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a897e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a89f6-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 23:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8a79-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 15:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8b00-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8b5c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8baf-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8c02-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8c55-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8caa-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 12:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8cfd-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 13:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8d57-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8de0-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8e61-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8ee2-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 19:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a8faf-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 13:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9012-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9069-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a90be-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a910f-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 21:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9161-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a91b4-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9207-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 20:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9258-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a92ab-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9305-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9364-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a93b9-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a940c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9480-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 21:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a94d5-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 23:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a952b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00a9580-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab545-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 22:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab798-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab7f4-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab844-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab895-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 21:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab8ec-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab93b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab98e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ab9da-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00aba27-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00aba76-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 16:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00abacc-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-29 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adac1-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 09:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adbd8-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 17:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adc39-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adc8d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adcde-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00add33-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00add86-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 16:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00addd6-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ade24-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ade76-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adec5-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adf15-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adf64-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00adfb1-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 11:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae000-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae050-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae09e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae0ee-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae140-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae1ef-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae23e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-29 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae28e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae2df-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae34e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae3a9-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 23:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae3fa-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae449-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 19:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae499-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae4e9-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 22:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae538-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ae589-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b038b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0719-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b07ae-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0813-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 09:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0868-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b08bb-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0914-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 19:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0966-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b09bc-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0a0d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0a5d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0aae-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0aff-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0b54-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0ba6-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0bf7-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0c49-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0c9a-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 10:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0cea-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0d3b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 11:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0d90-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0de1-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0e33-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0e83-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0ed6-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 16:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0f2a-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0f7b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b0fcc-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b101c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 14:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b106c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b10bf-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 14:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b110f-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1161-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 11:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b11b2-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1205-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 21:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1257-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b12a8-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b12f7-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b134a-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b139b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 21:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b13ee-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 18:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b143e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b148e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b14df-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1533-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1583-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b15d5-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1626-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 21:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1681-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 11:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b16d1-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1724-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 13:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1779-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b17c8-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 11:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1836-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 20:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1887-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b18da-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b192c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b197b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 09:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b19cc-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 14:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b1a1d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b3bd8-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b3ef9-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b3f5b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b3fb1-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b400c-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4073-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b40d9-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b412b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b417d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b41cd-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b421d-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b426f-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b42bf-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4314-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 18:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b437e-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 18:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b43d0-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 20:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4426-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 10:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4474-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 22:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b44c4-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4513-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4562-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b45b3-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b479b-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 21:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b47ef-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4841-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 10:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4894-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b49a1-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b49fd-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4a54-d14a-11ee-a723-c03eba28a56c	663eb791-e46c-4103-a0f2-75a9101ef83a	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4b01-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4baa-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4c39-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4ca0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4d97-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4e0a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4e74-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4ed2-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b4f37-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b510a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 21:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5184-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b526d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5350-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5406-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5599-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b567d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 09:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b583f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b58d9-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b598f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 20:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5a42-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5af1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5b9e-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5c69-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 21:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5d21-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5d97-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5e21-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5ea6-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 13:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5f24-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b5fa0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b602a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b60a9-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b611f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b6194-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b61ff-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b626b-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b62d5-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b6332-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b6394-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b63fb-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b6458-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b64b7-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b659e-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b65f5-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b6653-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-21 23:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b66c3-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b90a1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9250-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b92ba-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9313-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b936c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9511-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9560-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b95b1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9600-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b964d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b969e-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b97b0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b982e-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 20:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9895-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b98e2-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b992f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 15:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b997f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b99ce-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9a1f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 22:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9a72-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9ae2-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9b31-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9b85-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9bd3-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9c20-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 16:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9c72-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9cc4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9d11-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00b9d5f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 11:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bba33-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbb7c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbbfd-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbc68-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 19:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbcc1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbd19-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbd72-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 09:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbdc7-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-29 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbe27-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 15:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbeac-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bbf8c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 10:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bc06a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bc0cc-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bc120-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bc177-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 17:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bc31f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 12:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bc370-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bc3f4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bc46b-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00beba3-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bed93-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bee3a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bee99-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00beef1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bef46-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00befce-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf028-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 13:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf07e-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf0fa-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf15c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf1ce-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf224-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf3ba-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf406-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf5d1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 19:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf628-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 23:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf7c6-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bf812-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bfa7c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bfad6-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 09:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00bfb4d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1541-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1691-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1729-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 12:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c17c4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 10:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c182c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 16:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c188c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 20:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c18e8-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1943-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c199e-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 23:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c19f8-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1a5c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1ae1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1b77-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1d49-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1d9d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1df2-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c1fd4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 15:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4282-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4458-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4573-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 12:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c45cc-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 10:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4625-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c47e4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4830-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c487c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 22:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4a5a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 11:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4ba1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4d9b-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 18:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4de7-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c4fbf-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 15:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5013-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 22:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5065-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c50ce-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 21:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5130-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5196-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c51ea-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c523d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c528f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c52e6-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 15:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c533d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c539c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 15:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c544c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c54de-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5682-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c56d0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c58b0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5905-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 09:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5959-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5b16-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5b83-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5d57-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5db4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5e06-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 12:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c5e79-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c6030-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c6082-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c60d1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c64db-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c652c-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 09:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c657b-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c65cc-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c68ed-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c88e6-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8b38-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8ba6-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8c03-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8c81-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8d26-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8d8a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8de6-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8e42-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8ea0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8f00-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8f5e-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c8fb9-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c9014-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c906f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 13:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c90dd-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c9153-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c91bd-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c921f-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c9278-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c9325-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00c9382-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 15:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb28d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 11:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb51d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-29 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb582-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb5de-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 10:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb63d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb697-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb6ef-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb743-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb79a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb7f1-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 21:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb84b-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb8a4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb934-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cb9ac-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cba2a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cba86-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbadd-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbb44-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbba4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbbff-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 23:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbc5d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbcbb-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbd13-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 09:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbdf3-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 09:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbeb0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbf1d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbf83-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 23:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cbfe5-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc044-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc0aa-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc108-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 13:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc166-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc1c0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 14:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc219-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc271-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc2ce-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc346-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc3a8-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc414-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc480-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 19:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc506-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc606-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc66b-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc71d-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc777-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc7e4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc849-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc8b0-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cc91a-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf1a6-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf447-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf4c4-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf52b-d14a-11ee-a723-c03eba28a56c	6ec2252e-7940-4298-a6df-c822392a1044	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf5de-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf6ad-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 23:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf71e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf7c1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf820-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf880-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf8e0-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf93f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 20:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf99e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cf9fd-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cfa5c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cfade-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cfbf8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cfc56-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cfcb5-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00cfd26-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d17ac-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1970-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d19de-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1a3f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1aa1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1b01-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1b63-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 09:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1bc2-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 22:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1c21-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1cfb-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 09:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1d5b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d1db7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d36f8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3882-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d38f0-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3956-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d39b6-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3a18-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3a7b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3adc-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3b35-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3ba9-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3c36-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3c9b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 23:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3cf1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3d4f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3da7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3e18-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 22:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3f0c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 22:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d3fdf-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d4037-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d4090-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 09:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d40e7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d413f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d4195-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 18:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d41ec-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 11:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d429d-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d42f6-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d434e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d43a6-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d43fc-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d6134-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d6206-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 22:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d6288-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 13:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d62e9-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d6342-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d63a1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d63fd-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 15:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d6455-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d64ad-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d6506-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d7edd-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d7fe8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d805e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 19:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8119-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d818b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 15:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d81e9-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 16:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8245-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-29 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d82a5-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8303-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d835f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-29 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d83ba-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8415-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d84cd-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 16:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d852a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8582-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 12:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d85dd-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d863a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 12:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8694-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d870a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8775-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-29 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d87d1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 15:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d882b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8887-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d88e1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d893c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8996-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d89f1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8a4b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 16:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8aa6-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 18:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8b01-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 21:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8b5b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 13:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8bb5-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00d8c96-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00da8d1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 23:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00da9d6-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00daa5d-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 21:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00daad4-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dab4a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dabbb-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dac8d-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dad01-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dad8d-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 19:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dae37-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 11:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dae94-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00daef0-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 11:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00daf4a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dafa6-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db002-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 14:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db05c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db0b7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 13:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db112-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db16f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 09:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db1c8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db223-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db27e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 21:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db2d8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db335-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 14:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db38e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 10:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db3e9-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 13:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db443-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db4b7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db51e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db577-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00db5d1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dcda3-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dcfb1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd167-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd1ce-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd227-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd283-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd2dc-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd335-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd38f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd3e7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 16:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd446-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd4a1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd4f6-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd54c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd5a3-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd5fc-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 19:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd653-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 17:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd6a8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd701-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 22:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd758-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd7ae-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd805-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd85c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd8b5-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd917-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd972-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dd9ca-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dda42-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dda9a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ddcbe-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ddd22-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 20:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ddd7f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ddde0-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00dde41-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ddea5-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ddf08-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ddf69-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ddfce-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 13:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00de046-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1535-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e17ed-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e185c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 11:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e191a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e199f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e19f9-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1a56-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 14:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1aad-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1b06-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1b5e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1bb7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1c16-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 15:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1c6d-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1cd1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1d2a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1d8b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 21:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1df3-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 11:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1f40-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1fa3-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e1ff8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2050-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e20d6-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 23:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2144-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e21d7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2262-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 21:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e236d-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e241c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e24fb-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e25a1-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2643-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e26d8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2790-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 11:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e28b8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2964-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 18:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2a1c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 19:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2ab0-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 21:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2c38-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2cc9-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2d2c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2dcd-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-29 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e2e6c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6143-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e625e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 12:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e62cb-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6399-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 09:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e63f4-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e644f-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e64a8-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6503-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6559-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e65b2-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e660b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6664-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e66bc-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6716-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e68f0-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6955-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 23:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e69b3-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6db7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6f9d-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e6ff5-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 21:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e704d-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-29 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e722c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e728c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e9e8c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 13:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00e9f7c-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea068-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea0d7-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea412-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 11:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea491-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea52b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea641-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 15:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea6cb-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 10:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea76e-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 14:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea915-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ea972-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eab5a-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eabb5-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ead5b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eadaf-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eae04-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eae5b-d14a-11ee-a723-c03eba28a56c	76a3f26d-22ee-46b4-8377-ea17757ebd06	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 17:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eaf01-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 13:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb1e5-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb250-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb2d3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb333-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb6d8-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 14:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb737-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 16:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb795-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb7f2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 19:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb852-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 23:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb8b6-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 22:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb913-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eb9f2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eba5d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ebab9-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ebe05-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ebe62-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ebec3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ebf23-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 21:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee3fe-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 22:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee614-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee688-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee6e9-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee74e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee81e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee886-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee8e3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee942-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ee9b1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eeaa8-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eeb06-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eeb67-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eebc1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eec1a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eecb4-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eed5c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eedbd-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 23:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eee26-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 21:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eef04-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 20:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eef93-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eeff5-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef050-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef0ac-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef115-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef1a1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef20a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef268-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef2c3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef31e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 15:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef37d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef3dc-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef437-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef4f3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef56d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-29 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef5f2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef653-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 16:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef6b6-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef7eb-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef84f-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00ef8a8-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00efc04-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00efdc6-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00efe18-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00efe6d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00efebe-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eff11-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00eff65-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00effb7-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f0008-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 14:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f005b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f00af-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f0109-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 17:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f015c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f032d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f038b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f03eb-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f044b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 22:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f04a9-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 22:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f0508-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f056a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f05cc-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f0632-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 10:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f0691-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f06f4-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f0755-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f28f2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f2a83-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f2bc0-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f2c50-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f2ce2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f2e67-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f2efa-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 12:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f2f9a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3020-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 09:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f318b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 19:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3212-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f34d6-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f367b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f36cd-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 09:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f372b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f377e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f37d5-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f382a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f387e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f38f1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3945-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3999-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f39ec-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3a3d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3a94-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3ce3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-29 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3d3d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3ee0-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3f3c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3f99-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f3ff1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4043-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4230-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f42dc-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4338-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f44f7-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 11:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f454b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f459f-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 20:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f45f2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4644-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4696-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4a59-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 21:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4afd-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4b59-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 21:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4bb7-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 21:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4c21-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 13:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4c7e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4f5b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f4fc3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5026-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f507c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 12:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f50ff-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5156-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 21:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f51b1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 13:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f520c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 11:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5264-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f535f-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f53b5-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f540b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5463-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 21:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f54b9-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f550e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f560d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 18:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f56e1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f57b2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5884-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5955-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5a2f-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5aff-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 11:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5bd1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5cae-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5ddb-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5eaf-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f5f83-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6055-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 14:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f612a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 12:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f61f8-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f62cd-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f639f-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 18:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6470-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6546-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 10:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6615-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 09:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f66e7-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f67bb-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6897-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f696a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 22:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6a3b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6b0d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6be1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 23:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6cb5-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 23:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6d85-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6e58-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f6f2b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f7004-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 21:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f70d6-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f71aa-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 22:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f727c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f734d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f742c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 15:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f74ff-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f75d2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 21:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f76a3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f7770-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00f9e6f-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 09:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa07e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa0de-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa12e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa17d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa1cd-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa21a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 22:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa267-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa2b3-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa311-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa362-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa3b0-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa3fd-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa507-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 21:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa559-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 17:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa5aa-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 13:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa5f7-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa647-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa6b5-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa701-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 21:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa750-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 21:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa79e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa7ed-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa846-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa892-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa8de-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa92c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa97a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fa9d6-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-29 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00faa24-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00faa71-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00faac0-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fab0e-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 22:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fab5a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 18:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fabaa-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fc726-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fc9d2-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcaa7-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcb58-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcc45-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 13:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcc97-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcce5-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcd32-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcd81-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcdcf-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fce1d-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fce6b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 20:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fceba-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 18:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcf07-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcf53-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcfa1-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fcffb-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd048-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 10:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd09b-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 10:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd0e9-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd135-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd181-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 14:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd1cc-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd21a-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-29 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd269-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 17:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd2b4-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 09:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd300-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 12:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd34c-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd398-d14a-11ee-a723-c03eba28a56c	88072e16-0264-4498-ab30-ce5a67d5106e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd41f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 23:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd48f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd4ea-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd540-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 18:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd5b2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd608-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd65f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd6b4-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd70a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 19:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd760-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd7b6-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd80b-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 22:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd85f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 18:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd8b6-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 21:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd90f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 15:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd96d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fd9c1-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fda19-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 10:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fda70-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdac6-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 22:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdb1a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 17:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdb70-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdbc4-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdc18-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdc6d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdcc1-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdd15-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdd6e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fddc3-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fde21-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fde76-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdeca-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdf20-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 14:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdf75-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 10:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fdfca-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fe020-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fe197-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 13:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fe22a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00fe2bc-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-29 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100090-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010029c-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 09:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01002f8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 16:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100349-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010039f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 12:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01003ee-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010043c-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010048a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01004d5-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100522-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100572-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01005bf-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010060c-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 18:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100659-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01006a9-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01006f7-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100762-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01007ae-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100803-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 10:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100851-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01008a2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01008ee-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010093a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010098a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01009d6-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100a22-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 14:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100a71-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100abd-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 12:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100b0b-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100b56-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 22:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100ba1-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 15:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100bee-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100c45-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100c91-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100cdc-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100d29-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100d75-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100dc0-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100e0b-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100e5a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 10:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100ea7-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100ef2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100f3d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100f89-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0100fd6-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101022-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101074-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01010c1-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010110c-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101159-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01011a5-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01011f2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101241-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010128d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01012d8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101325-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101371-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 21:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01013be-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010140a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101457-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01014a9-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01014f4-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101540-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010158c-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01015d8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010176d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01017f8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01018a5-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 15:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101930-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01019b8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101a42-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 16:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101acc-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101b55-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 20:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101bdf-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 14:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101c6e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101cf9-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 22:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101d80-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101e09-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101e97-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101f21-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0101fab-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102036-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 10:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01020be-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102148-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01021d0-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-21 23:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102259-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 11:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01022e2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010236c-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01023fb-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 11:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102487-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 22:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010250e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 09:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010259c-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102622-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01026ac-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102736-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 19:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01027c1-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010284a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01028d4-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010295e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01029e8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 13:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102a71-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102afc-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0102b8a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01049ad-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0104bf5-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0104c95-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0104d21-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0104db0-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 13:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0104e3e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0104ec5-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0104f58-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0104fe5-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 19:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105088-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105110-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01052a3-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 12:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01052f1-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 16:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105347-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105395-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105401-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010544e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105499-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01054e5-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105531-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010557f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01055cc-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105618-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105663-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01056ae-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01056f8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 18:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010574d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01057a3-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 20:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01057f1-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105840-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010588e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01058db-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0105928-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 10:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010730a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010759a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010761d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107682-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01076dd-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107739-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107791-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01077e8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 22:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107849-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010789c-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01078f4-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107948-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010799d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01079f2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107a4a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107a9e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107af4-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107b4a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 09:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107ba7-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 11:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107c03-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 16:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107c59-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107cde-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107d86-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107e07-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 15:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0107eb7-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108057-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 11:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01080a5-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01080f2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010813d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010818b-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01081dc-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108230-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01082a6-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 10:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01082f4-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 18:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108343-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 23:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108395-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01083ea-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010843d-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 23:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010848f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01084dd-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 21:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010852e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108580-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01085d2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 12:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108626-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108678-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01086c7-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108714-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108762-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01087b4-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108807-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 19:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108866-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01088ba-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 09:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108907-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010895a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01089ab-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01089fb-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108a47-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108a97-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108aea-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108b3a-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108b89-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 11:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108bd8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 18:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108c29-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108c78-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108cc8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 10:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108d36-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108db8-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0108e33-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01099cf-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010a0c3-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010cfc2-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-21 23:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010d483-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 10:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010d62f-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010d686-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010d6dd-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010d734-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010d91e-d14a-11ee-a723-c03eba28a56c	8e84dbd4-f888-42f8-9232-a4ec7f6753a8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010d9c7-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010db0b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e0c2-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 11:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e123-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 10:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e181-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e1e1-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e260-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e48a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e654-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e6ad-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e709-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e935-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010e9d0-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010eb82-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010ebdd-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010ec48-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010ee15-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 11:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010eea6-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010ef43-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f121-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f17c-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 14:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f1d9-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 18:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f3ba-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f441-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 13:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f4b6-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f66f-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f6c9-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f727-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f915-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 14:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010f9cd-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010fb7b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 13:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010fbdb-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f010fc36-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110049-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01100a5-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 21:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110102-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 09:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110154-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110377-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01103d2-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01105ac-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 14:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110680-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110751-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110823-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 18:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110920-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 17:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110aac-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110c87-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110d8e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110e61-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0110fba-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0111088-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011115a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0111750-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0111929-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01119f9-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0111b30-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0111d45-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0111e47-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0112123-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01122bb-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011238d-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011247b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 15:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0112557-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011263e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011270e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01127fe-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 14:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01129f1-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 22:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0112ac0-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 14:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0112b8f-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0112c60-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0112e7e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0112f76-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113174-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113356-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 13:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011342a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01134f9-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 17:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01135c8-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 12:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113697-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 09:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113768-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113848-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01139f2-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113ac3-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 23:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113b94-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113c77-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 22:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113d54-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 21:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113e23-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 14:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0113fef-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01141a0-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 21:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0114272-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0114348-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0114460-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0114550-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0114621-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01146fc-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0114903-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 19:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01149ec-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0114bdd-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 22:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011883b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0118d40-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 13:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0118e3b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 10:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119009-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119232-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011946e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01194bd-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011950c-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 13:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119743-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119908-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 10:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119957-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01199c7-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119b9a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 22:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119c45-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119cab-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119d13-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 19:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119d79-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119e09-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0119e72-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 22:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a00d-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a073-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a0e1-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 17:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a14e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 18:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a1bb-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a323-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a38b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a415-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a480-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 11:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a4e8-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a559-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011a5cb-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011d681-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011dcb8-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011de08-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011de78-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011dede-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011df99-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 12:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e030-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e091-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 20:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e29c-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 12:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e2eb-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e33a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e389-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 10:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e5d4-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 23:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e62d-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e68b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e6df-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e733-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e791-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 16:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e7e7-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 17:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e83c-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 22:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e894-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e8ec-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 13:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e943-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 16:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e998-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 23:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011e9f0-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 09:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ea4b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 20:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011eaa1-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011eafb-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011eb62-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 12:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ebbc-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 23:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ec15-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ec97-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ecee-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ed43-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ed9a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011edf1-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ee49-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011eeaa-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ef08-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 21:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ef67-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011efc3-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 23:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f01e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f095-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f108-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 23:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f17a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f1e3-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f250-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f2c2-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 13:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f32a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f387-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f3df-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f438-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f490-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f4e9-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f549-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f5ae-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f613-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f671-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f6cd-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f72b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 11:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f789-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f7e7-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f846-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 22:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f8ad-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011f99a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011fa19-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011fa8e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011fc22-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011fdeb-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 18:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011feb0-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f011ff75-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0120037-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0122f86-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01230dd-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 22:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012313a-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012318d-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01231de-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 16:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012322e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012327e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01232cd-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012331c-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 18:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012338b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01233da-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123429-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123485-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01234d7-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123524-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123572-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01235c0-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123610-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012365d-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 16:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01236ab-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01236f8-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123745-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123794-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 10:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01237e1-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012382f-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012387b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01238d0-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012391e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012396e-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 14:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01239ba-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 19:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123a07-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 21:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123a54-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 18:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123aa1-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123aee-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123b3b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123b8b-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 10:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123bd8-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123c24-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123c71-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 16:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123cbe-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123d17-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123d63-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 13:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123db0-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123e01-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123e4d-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123e99-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123ee5-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-29 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123f32-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123f82-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0123fcd-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124019-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124066-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 16:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01240b2-d14a-11ee-a723-c03eba28a56c	a61eafa6-3170-42b5-b1ab-42afaea7cd41	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012414e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 21:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01241cf-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012422b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124283-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01242d7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01244c8-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01245bc-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01246d4-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01247cb-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01248ba-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01249aa-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124a95-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124b7f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124c6e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124d5c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124e54-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0124f3c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012502b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012511c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 19:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012520a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01252f4-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 23:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01253ea-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 18:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01254d9-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 10:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01255c6-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01256b2-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 23:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01257a0-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012588c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0125978-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0125a62-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0125b63-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0125c55-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 19:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0125d42-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0125e7c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-29 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0125f70-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 10:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012605d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012614e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0126222-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012630a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01263e3-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 11:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01264b9-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-28 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012658e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 10:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0126665-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 21:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0126739-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0126817-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 21:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01268e8-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01269c3-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0126aa2-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 19:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0126b75-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-29 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0126c4b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0126d1d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 23:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129946-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129b98-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129bf3-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 15:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129c50-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129ca2-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 20:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129cf4-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129d41-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129d97-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129e01-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129e54-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 09:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129ea2-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 11:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129ef0-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129f3d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129f8b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0129fd6-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a024-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a073-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 16:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a0c0-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 21:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a10b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a158-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a1a4-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a1fb-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a24f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 20:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a29c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 10:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a2e8-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a335-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-29 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a383-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a3d1-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 16:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012a41f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c2af-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c67c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c6e9-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c745-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 10:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c79e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 12:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c7f4-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 14:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c852-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c8a5-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c8f7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c94a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c99d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012c9f0-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012ca42-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 16:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012ca95-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cae9-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cb3b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cb8c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 10:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cbe1-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 16:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cc35-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 22:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cc89-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cce9-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cd3c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 13:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cd8f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cde1-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012ce33-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 10:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012ce84-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 21:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012ced7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cf29-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cf7a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 18:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012cfcb-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d03c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d08f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 18:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d0e0-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 10:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d131-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d18b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 10:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d1dd-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d22e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d280-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d2d3-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 13:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d329-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d379-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d3cc-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d41f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-29 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d474-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d4c6-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d520-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d575-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 09:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d5c8-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d61f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d675-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d6c8-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 13:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d71a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d76b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d80d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d867-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 15:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d8be-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d90d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 23:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d958-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 17:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012d9a4-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 09:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012db87-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 19:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012dc58-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 10:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012dd2a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012de01-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 10:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012ded7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012dfad-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e07e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e14e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e220-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e2f1-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e3c7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 22:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e494-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e567-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e636-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-22 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f012e705-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 21:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0130fc8-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01311b2-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 20:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01312a7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 22:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013148f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 09:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013153d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01315c2-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013169f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131759-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 18:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01318ff-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01319a2-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 16:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131a52-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131b1d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 19:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131bd8-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131d3a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 14:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131de7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131e7f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131f02-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 10:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0131fa3-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132056-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 15:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013210a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01322c3-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 15:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132342-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132444-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01324cf-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013254b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-26 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01325c9-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132648-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 22:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01326c4-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013273f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 21:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01327bd-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132847-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 12:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01328c5-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-25 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132940-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01329c1-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 19:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132a3d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132abc-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132b38-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132bb3-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132c3a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132cb7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132d33-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 09:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132db0-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0132e95-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013309a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013317c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 14:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133250-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 13:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013332b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133403-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01334d1-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01335a4-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133677-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-22 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133746-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133816-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01338e7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01339bd-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-28 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133a91-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 13:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133b63-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133c5c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 18:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133d3d-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 09:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133e10-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133ee9-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0133fbd-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 14:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013408e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134160-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 19:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134232-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134303-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 13:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01343d2-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 21:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01344f6-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-26 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01345cd-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013469f-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-28 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134771-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 12:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013484b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134928-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01349f8-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-21 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134acb-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 10:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134b9a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 11:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134c6e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 18:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134d40-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0134ef7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 21:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135370-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-28 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135464-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-26 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013553a-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013560b-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 12:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01356e0-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01357bb-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 21:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135888-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 19:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135962-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135a37-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-26 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135b0c-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 22:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135bdc-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135cc3-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135d94-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135e64-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 20:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0135f33-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0136002-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01360d7-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01361a9-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0136281-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f013634e-d14a-11ee-a723-c03eba28a56c	abd03ced-dae2-4b75-b57a-35ebd7cd03e8	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01364fb-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 16:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01367cb-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 10:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01368de-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01369dd-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 22:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014a0e3-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014a40d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014a523-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014a61c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014a735-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014a8a8-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 11:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014a9a0-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014aa8f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 22:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014abcf-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014acba-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 17:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014ada9-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014aea4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-23 11:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014af8f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 16:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b077-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b16b-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 18:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b25b-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b343-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b431-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b525-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 19:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b611-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b711-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b7ff-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 21:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b8f4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014b9e4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014bad1-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014bbd8-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014bccb-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014bf35-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 13:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014c045-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-29 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014c143-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 17:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014c23c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014c339-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014f19f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 17:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014f49e-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014f5b4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014f6a8-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014f78e-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 19:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014f874-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 16:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014f9aa-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 12:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014fae0-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014fbc7-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 23:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014fcaa-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014fd8e-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 16:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014fe7b-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 20:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f014ff63-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 23:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150048-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150130-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150219-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150305-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01503ec-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01504d7-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01506c0-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	3db16884-48c4-406d-b873-fa65147f939a	2024-02-24 23:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01507a4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01509f1-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 14:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150b79-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150c5f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150d40-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150e25-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150f07-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0150feb-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01510dd-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01511c8-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 21:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01512ab-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015143c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 18:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0151523-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0151608-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01516ee-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01517e0-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01518bf-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01519a8-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 11:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0151a90-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0151bc2-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0151ca6-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0151d9c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 16:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0151e7e-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0151f62-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152046-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015212e-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152213-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01522f6-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01523d9-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01524cc-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01525b1-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 14:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015269a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 14:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015277a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 09:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015285f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015294a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 18:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152a2d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152b12-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 15:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152bf5-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152cdc-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152dc0-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152ea1-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0152f82-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 17:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153064-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153155-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 10:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153237-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 16:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015331d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 11:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153403-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 20:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01534ee-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 16:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01535d2-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01536b6-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 13:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015379a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01539c0-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 13:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153ab1-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 11:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153bc4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-23 09:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153cac-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 12:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153d93-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153e7a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 18:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0153f73-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01540b5-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01541a4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015428a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154601-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154744-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 09:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015482f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-27 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154916-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 12:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01549ff-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 21:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154ae6-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 13:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154bca-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154cae-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154d8d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 14:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154e77-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0154f93-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155076-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 11:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015515b-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 10:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155242-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155322-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 12:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015555c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015564d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015574a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015581a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01558ef-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 20:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01559c1-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155a98-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155b6c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155c43-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 20:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155d1d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 13:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155df5-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 22:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155eca-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0155fa1-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0156076-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 12:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015614f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0156228-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01562fc-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01563d4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 15:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01564aa-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 21:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015657c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 19:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0156651-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01567d9-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01568c3-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0156c8c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-26 15:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0156eca-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01570f7-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 15:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01573b8-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015755d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01576ae-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 13:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015778c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-25 20:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015789b-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015799f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-24 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0157a7a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-22 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0157c51-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-23 18:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0157dc9-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-27 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0157f18-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	94d6c0ca-125b-43d0-8f65-9f0880b90beb	2024-02-28 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015815c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 15:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01583f8-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 11:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0158526-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0158639-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-24 16:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0158741-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-25 21:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0158893-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 20:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0158b28-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0158c6b-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 15:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0158d5c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0158e63-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-22 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015907b-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-28 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015929c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0159415-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-23 13:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0159582-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	a4ed71b7-2af3-46d4-acff-b7778fb2c91d	2024-02-27 19:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0159677-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 11:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0159911-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0159a9c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 21:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0159c2a-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 17:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0159dac-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0159ffe-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-24 20:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015a1f7-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015a421-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-22 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015aa2e-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 10:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015ac03-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-27 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015ae06-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015aee3-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-23 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b092-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-26 17:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b175-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	b0e45ea2-443f-404f-9412-b97a6001f157	2024-02-28 15:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b253-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b372-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b4f0-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-24 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b679-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 10:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b77e-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b860-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015b9de-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 10:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015bb9f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015bd11-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015be86-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-26 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015bff6-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-23 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015c190-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-25 18:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015c2e2-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015c3dd-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	d1678477-49ce-4417-bc39-a080cad0e9e8	2024-02-27 22:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015c6ae-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015c7ec-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 23:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015c9e4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015cb43-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 16:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015cca0-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 16:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015cdf8-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015cf3f-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015d072-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-25 19:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015d15b-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015d2dc-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015d441-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-24 19:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015d562-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-27 11:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015d640-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-22 21:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015d77c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dac58b9b-f8f7-4f75-8586-2b43fb8824c0	2024-02-23 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015d91e-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 23:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015da6c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 11:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015dbaa-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015dd13-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 16:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015deb9-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015e00d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 18:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015e101-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 11:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015e259-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 21:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015e454-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 16:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015e5b4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-27 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015e714-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-24 11:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015ebf7-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-22 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015edd4-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-25 11:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015ef01-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	dfd9306f-fbc8-4807-a8c6-5e6c3f7ad71c	2024-02-23 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f0e6-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f22c-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 21:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f33d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 11:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f451-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f5e7-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 17:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f73d-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-23 14:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f815-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 16:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f8e7-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015f9fb-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-25 18:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015fb46-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-24 16:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015fcaa-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-22 21:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015fdeb-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-28 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f015ff36-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-29 14:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01600db-d14a-11ee-a723-c03eba28a56c	c474761c-c5cf-41b4-8dea-7a04c244ac4e	ed75f9eb-4f2c-4448-aef8-7804178df564	2024-02-27 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01602bb-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0160496-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 18:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016062b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 13:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0160866-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 15:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0160a03-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 22:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0160b9c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0160d3e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0160ee3-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 19:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01610aa-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016123f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 21:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01613c1-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01615e9-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 10:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0161760-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0161884-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0161984-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-22 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0161b19-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 13:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0161da8-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0161f85-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01621a4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 21:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0162380-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-25 09:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0162510-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 12:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0162697-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-28 12:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016283d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 11:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01629c9-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 13:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0162b50-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0162cd5-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-27 18:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0162eae-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-24 17:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0163042-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	1f0b7d55-9dd6-4c46-bd4d-3b50024d14ec	2024-02-26 13:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01631b8-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 19:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0163335-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 14:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01634b5-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 21:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01636dc-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016382b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 13:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016391d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-23 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0163a73-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-22 19:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0163bef-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 22:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0163d3f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-24 13:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0163e9e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-27 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0163fee-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0164144-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 11:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016433b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-26 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0164462-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3aa17be3-387c-4271-a313-2e5bb069b509	2024-02-25 13:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016453c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-25 13:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0164641-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0164775-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01648bc-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-21 23:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01649fb-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0164b3e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-23 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0164c7d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 15:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0164dc1-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0164f01-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 23:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0165041-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-27 19:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0165188-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 16:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01652e6-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-28 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0165441-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-26 20:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016559d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	3db16884-48c4-406d-b873-fa65147f939a	2024-02-22 22:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01656e4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 17:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016583a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-26 13:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0165992-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 14:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0165b0f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-27 10:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0165c5a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0165f59-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 16:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0166117-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 15:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0166352-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 11:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01664dd-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-24 17:45:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0166670-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 18:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01667d6-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-22 15:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016697c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-28 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0166b19-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-25 18:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0166ddd-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	65966bb8-ec4a-4ef6-bd0d-429deb2b563e	2024-02-23 18:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0167420-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0167651-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 21:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01677d5-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-23 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01679f4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 14:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0167b51-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-22 16:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0167c35-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 19:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0167d59-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 15:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0167eaf-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 21:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01680e7-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-27 15:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016822a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 18:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0168319-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-26 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01683f8-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-28 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016854c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-24 13:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01686bc-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6af5c313-0e3e-4e72-86d6-2e4ed45e7e35	2024-02-25 20:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01687cd-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-25 17:30:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01688d8-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-27 23:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01689c0-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0168aa2-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0168b7c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-26 09:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0168c5d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 19:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0168d42-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 09:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0168e28-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 11:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0168f09-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 12:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0168fea-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-23 20:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01690e5-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-22 20:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169214-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169424-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 13:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01695cf-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	6e476e92-a262-4792-8120-daeb4433c025	2024-02-28 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01697c0-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f01698a9-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 16:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016998b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 22:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169a63-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 13:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169b36-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-25 15:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169c13-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 12:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169cee-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 17:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169dda-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 20:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169eb9-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-24 21:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0169f9f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-28 12:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a08b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a196-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-22 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a274-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-27 21:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a34f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	7d4980ac-eb8f-4bcb-97eb-77cbcd75dba2	2024-02-26 16:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a42a-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 16:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a515-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 09:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a5f7-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-25 16:20:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a6d2-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 23:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a7ac-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 13:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a884-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 15:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016a960-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 09:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016aa35-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-26 17:45:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ab0d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-24 22:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016abe4-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-22 16:00:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016acc6-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-23 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016adaa-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016ae86-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 17:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016af62-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	86fa4c35-8d26-4f60-9cf2-fbaaba0ee25d	2024-02-28 10:05:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b03c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 13:10:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b11f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b201-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-23 23:15:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b2d3-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 09:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b3ad-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-25 11:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b49b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b585-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-22 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b66b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 14:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b746-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-24 14:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b822-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 17:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b8fa-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 19:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016b9cf-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-26 21:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016baae-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-28 14:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016bb83-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8bdac2c9-2cc7-464b-8cff-4bc41403b74f	2024-02-27 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016bc7b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 18:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016bda1-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-27 20:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016be7d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 14:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016bf4e-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 20:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c024-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 14:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c0f8-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 18:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c1cb-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 12:15:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00632a3-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 17:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0063d86-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 12:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f0064383-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 09:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006459a-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 12:25:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f00647a4-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006dcce-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 16:10:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e227-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-27 12:20:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e314-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-22 21:35:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e3f2-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e48c-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-23 17:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e57f-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-28 20:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e62e-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-24 10:00:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e6d1-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 10:30:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f006e79b-d14a-11ee-a723-c03eba28a56c	3c4007ee-a12d-4a0b-b92a-1e40eca0b447	0fdbe392-734d-402b-9399-d22bd37b6cee	2024-02-26 23:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c29c-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 15:05:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c36d-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-23 14:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c43f-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-28 18:25:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c512-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 20:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c5e9-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-26 12:40:00	40000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c6bb-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-25 09:35:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
f016c78b-d14a-11ee-a723-c03eba28a56c	cb4f08f2-0379-4b40-9d1f-b27ae8c7a9a7	8f2c1f5f-d274-4081-9c87-441e13dab3ee	2024-02-24 21:40:00	60000	f	2024-02-22 13:23:46	NULL::character varying	2024-02-22 13:23:46	NULL::character varying
\.


--
-- TOC entry 5004 (class 0 OID 35892)
-- Dependencies: 222
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("Id", "FullName", "Password", "Role", "Avatar", "DeleteFlag", "CreatedDate", "CreatedBy", "ModifiedDate", "ModifiedBy", "UserName", "NormalizedUserName", "Email", "NormalizedEmail", "EmailConfirmed", "PasswordHash", "SecurityStamp", "ConcurrencyStamp", "PhoneNumber", "PhoneNumberConfirmed", "TwoFactorEnabled", "LockoutEnd", "LockoutEnabled", "AccessFailedCount") FROM stdin;
a6d1e91f-ef87-4635-93be-c6fc9fb6e3c6	Admin	000000	Admin	hknbmqu1.jpg	f	2023-12-29 15:16:32.915467	\N	2023-12-29 15:16:32.915467	\N	Admin	ADMIN	kiaisoft.anh.tang@gmail.com	KIAISOFT.ANH.TANG@GMAIL.COM	f	AQAAAAEAACcQAAAAEBlwxq4+Vg2Wa2FAqAkgUE77BX1VakNo84I3/+EJC2U7ZbIUR329fMYtkSH3Aooolw==	4X6CCTXQY77LAAMD3AU6IKXTLAB7DWWE	e5935268-0dfd-479e-9c82-c8104e649274	\N	f	f	\N	t	0
31512bef-a7d1-41b7-b18a-bd189462f8e5	anhtheit2002@gmail.com	anhtheit2002@gmail.com	Customer	v5whr5ub.png	f	2024-02-22 15:39:33.32779	\N	2024-02-22 15:39:53.245816	\N	anhtheit2002@gmail.com	ANHTHEIT2002@GMAIL.COM	anhtheit2002@gmail.com	ANHTHEIT2002@GMAIL.COM	f	\N	XLFWANOAREN6MAUTWDBGOUKHJLFAJFAU	f42e8a0f-cf92-4471-b214-d062e9854798	\N	f	f	\N	t	0
14b86ecb-6a86-4299-b794-963dfbe5a193	Test User	123456	Customer	\N	f	2024-02-22 11:38:14.1877	\N	2024-02-22 11:38:14.1877	\N	testuser	TESTUSER	tangtheanh123456789@gmail.com	TANGTHEANH123456789@GMAIL.COM	f	AQAAAAEAACcQAAAAEPqiR7MFoWUBc/QxhLA8BcC/N2dM5vBZwflEF213GAHtdvaCnhvgzh031Od7s0gj5A==	RQGMUV2N2Q4TLIA63BPSKFTE5QVXFOJ5	60569c1a-9dde-4f02-bbce-a9b6271061c7	\N	f	f	\N	t	0
bde51f66-8ea7-473a-b96c-64eb479ef294	tangtheanh123456789@gmail.com	tangtheanh123456789@gmail.com	Customer	\N	f	2024-02-22 14:02:10.923338	\N	2024-02-22 14:02:10.923338	\N	tangtheanh123456789@gmail.com	TANGTHEANH123456789@GMAIL.COM	tangtheanh123456789@gmail.com	TANGTHEANH123456789@GMAIL.COM	f	\N	HR44WFMNHAQHDN42EJ25FNDLS2EFEPEZ	72b3bd7b-1844-40e9-8a6c-f2dcdbcef749	\N	f	f	\N	t	0
16415794-faab-4b48-a61e-e3a11be4f14d	Thế Anh	123456	Customer	\N	f	2024-02-22 15:36:35.080318	\N	2024-02-22 15:36:35.080318	\N	theanh	THEANH	kiaisoft.anh.tang@gmail.com	KIAISOFT.ANH.TANG@GMAIL.COM	f	AQAAAAEAACcQAAAAEKC/iaYgFemnTkb4Na0dl14YWWCOcUoF3tdrZ4DHG65DQ07MDoOQDYSpvABSUiKQfw==	HBNTTS3K2FHUPXI5Y7AHCRECFGU6JXXZ	780c1ba9-125d-4686-afb2-91279de99db0	\N	f	f	\N	t	0
\.


--
-- TOC entry 5010 (class 0 OID 35956)
-- Dependencies: 228
-- Data for Name: UserClaims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserClaims" ("Id", "UserId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- TOC entry 5011 (class 0 OID 35968)
-- Dependencies: 229
-- Data for Name: UserLogins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserLogins" ("LoginProvider", "ProviderKey", "ProviderDisplayName", "UserId") FROM stdin;
Google	105982558848847467093	Google	bde51f66-8ea7-473a-b96c-64eb479ef294
Google	105847268326525868540	Google	31512bef-a7d1-41b7-b18a-bd189462f8e5
\.


--
-- TOC entry 5012 (class 0 OID 35980)
-- Dependencies: 230
-- Data for Name: UserRoles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRoles" ("UserId", "RoleId") FROM stdin;
a6d1e91f-ef87-4635-93be-c6fc9fb6e3c6	e989c4ca-e1e7-4f7e-9e6c-a014e87e89fc
14b86ecb-6a86-4299-b794-963dfbe5a193	7a6f0e8b-0705-4eaf-9714-14819cef32e8
bde51f66-8ea7-473a-b96c-64eb479ef294	7a6f0e8b-0705-4eaf-9714-14819cef32e8
16415794-faab-4b48-a61e-e3a11be4f14d	7a6f0e8b-0705-4eaf-9714-14819cef32e8
31512bef-a7d1-41b7-b18a-bd189462f8e5	7a6f0e8b-0705-4eaf-9714-14819cef32e8
\.


--
-- TOC entry 5013 (class 0 OID 35997)
-- Dependencies: 231
-- Data for Name: UserTokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserTokens" ("UserId", "LoginProvider", "Name", "Value") FROM stdin;
\.


--
-- TOC entry 4998 (class 0 OID 35841)
-- Dependencies: 216
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20231229081546_Initial	7.0.11
\.


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 225
-- Name: RoleClaims_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."RoleClaims_Id_seq"', 1, false);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 227
-- Name: UserClaims_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserClaims_Id_seq"', 1, false);


--
-- TOC entry 4818 (class 2606 OID 35949)
-- Name: RoleClaims PK_RoleClaims; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RoleClaims"
    ADD CONSTRAINT "PK_RoleClaims" PRIMARY KEY ("Id");


--
-- TOC entry 4804 (class 2606 OID 35882)
-- Name: Roles PK_Roles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Roles"
    ADD CONSTRAINT "PK_Roles" PRIMARY KEY ("Id");


--
-- TOC entry 4821 (class 2606 OID 35962)
-- Name: UserClaims PK_UserClaims; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserClaims"
    ADD CONSTRAINT "PK_UserClaims" PRIMARY KEY ("Id");


--
-- TOC entry 4824 (class 2606 OID 35974)
-- Name: UserLogins PK_UserLogins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLogins"
    ADD CONSTRAINT "PK_UserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey");


--
-- TOC entry 4827 (class 2606 OID 35986)
-- Name: UserRoles PK_UserRoles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "PK_UserRoles" PRIMARY KEY ("UserId", "RoleId");


--
-- TOC entry 4829 (class 2606 OID 36003)
-- Name: UserTokens PK_UserTokens; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserTokens"
    ADD CONSTRAINT "PK_UserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name");


--
-- TOC entry 4795 (class 2606 OID 35845)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 4797 (class 2606 OID 35854)
-- Name: Category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT category_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4799 (class 2606 OID 35863)
-- Name: Cinema cinema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cinema"
    ADD CONSTRAINT cinema_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4813 (class 2606 OID 35911)
-- Name: MovieCategory movie_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MovieCategory"
    ADD CONSTRAINT movie_category_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4802 (class 2606 OID 35875)
-- Name: Movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movie"
    ADD CONSTRAINT movie_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4833 (class 2606 OID 36036)
-- Name: Payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT payment_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4837 (class 2606 OID 52726)
-- Name: ProcessSeat processseat_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProcessSeat"
    ADD CONSTRAINT processseat_pk PRIMARY KEY ("Id");


--
-- TOC entry 4835 (class 2606 OID 36050)
-- Name: ReservationItem reservation_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ReservationItem"
    ADD CONSTRAINT reservation_item_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4831 (class 2606 OID 36017)
-- Name: Reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reservation"
    ADD CONSTRAINT reservation_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4807 (class 2606 OID 35891)
-- Name: Seat seat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT seat_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4815 (class 2606 OID 35931)
-- Name: Showtime showtime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Showtime"
    ADD CONSTRAINT showtime_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4811 (class 2606 OID 35902)
-- Name: User user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pkey PRIMARY KEY ("Id");


--
-- TOC entry 4808 (class 1259 OID 36063)
-- Name: EmailIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "EmailIndex" ON public."User" USING btree ("NormalizedEmail");


--
-- TOC entry 4816 (class 1259 OID 36061)
-- Name: IX_RoleClaims_RoleId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_RoleClaims_RoleId" ON public."RoleClaims" USING btree ("RoleId");


--
-- TOC entry 4819 (class 1259 OID 36065)
-- Name: IX_UserClaims_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_UserClaims_UserId" ON public."UserClaims" USING btree ("UserId");


--
-- TOC entry 4822 (class 1259 OID 36066)
-- Name: IX_UserLogins_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_UserLogins_UserId" ON public."UserLogins" USING btree ("UserId");


--
-- TOC entry 4825 (class 1259 OID 36067)
-- Name: IX_UserRoles_RoleId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_UserRoles_RoleId" ON public."UserRoles" USING btree ("RoleId");


--
-- TOC entry 4805 (class 1259 OID 36062)
-- Name: RoleNameIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "RoleNameIndex" ON public."Roles" USING btree ("NormalizedName");


--
-- TOC entry 4809 (class 1259 OID 36064)
-- Name: UserNameIndex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UserNameIndex" ON public."User" USING btree ("NormalizedUserName");


--
-- TOC entry 4800 (class 1259 OID 36069)
-- Name: movie_moviename_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX movie_moviename_idx ON public."Movie" USING btree ("MovieName");


--
-- TOC entry 4842 (class 2606 OID 35950)
-- Name: RoleClaims FK_RoleClaims_Roles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RoleClaims"
    ADD CONSTRAINT "FK_RoleClaims_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."Roles"("Id") ON DELETE CASCADE;


--
-- TOC entry 4843 (class 2606 OID 35963)
-- Name: UserClaims FK_UserClaims_User_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserClaims"
    ADD CONSTRAINT "FK_UserClaims_User_UserId" FOREIGN KEY ("UserId") REFERENCES public."User"("Id") ON DELETE CASCADE;


--
-- TOC entry 4844 (class 2606 OID 35975)
-- Name: UserLogins FK_UserLogins_User_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserLogins"
    ADD CONSTRAINT "FK_UserLogins_User_UserId" FOREIGN KEY ("UserId") REFERENCES public."User"("Id") ON DELETE CASCADE;


--
-- TOC entry 4845 (class 2606 OID 35987)
-- Name: UserRoles FK_UserRoles_Roles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "FK_UserRoles_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."Roles"("Id") ON DELETE CASCADE;


--
-- TOC entry 4846 (class 2606 OID 35992)
-- Name: UserRoles FK_UserRoles_User_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "FK_UserRoles_User_UserId" FOREIGN KEY ("UserId") REFERENCES public."User"("Id") ON DELETE CASCADE;


--
-- TOC entry 4847 (class 2606 OID 36004)
-- Name: UserTokens FK_UserTokens_User_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserTokens"
    ADD CONSTRAINT "FK_UserTokens_User_UserId" FOREIGN KEY ("UserId") REFERENCES public."User"("Id") ON DELETE CASCADE;


--
-- TOC entry 4838 (class 2606 OID 52492)
-- Name: MovieCategory moviecategory_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MovieCategory"
    ADD CONSTRAINT moviecategory_fk FOREIGN KEY ("MovieId") REFERENCES public."Movie"("Id");


--
-- TOC entry 4839 (class 2606 OID 52497)
-- Name: MovieCategory moviecategory_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MovieCategory"
    ADD CONSTRAINT moviecategory_fk_1 FOREIGN KEY ("CategoryId") REFERENCES public."Category"("Id");


--
-- TOC entry 4850 (class 2606 OID 52502)
-- Name: Payment payment_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT payment_fk FOREIGN KEY ("ReservationId") REFERENCES public."Reservation"("Id");


--
-- TOC entry 4853 (class 2606 OID 52727)
-- Name: ProcessSeat processseat_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProcessSeat"
    ADD CONSTRAINT processseat_fk FOREIGN KEY ("ShowtimeId") REFERENCES public."Showtime"("Id");


--
-- TOC entry 4854 (class 2606 OID 52732)
-- Name: ProcessSeat processseat_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProcessSeat"
    ADD CONSTRAINT processseat_fk_1 FOREIGN KEY ("SeatId") REFERENCES public."Seat"("Id");


--
-- TOC entry 4848 (class 2606 OID 52507)
-- Name: Reservation reservation_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reservation"
    ADD CONSTRAINT reservation_fk FOREIGN KEY ("UserId") REFERENCES public."User"("Id");


--
-- TOC entry 4849 (class 2606 OID 52512)
-- Name: Reservation reservation_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reservation"
    ADD CONSTRAINT reservation_fk_1 FOREIGN KEY ("ShowtimeId") REFERENCES public."Showtime"("Id");


--
-- TOC entry 4851 (class 2606 OID 52517)
-- Name: ReservationItem reservationitem_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ReservationItem"
    ADD CONSTRAINT reservationitem_fk FOREIGN KEY ("ReservationId") REFERENCES public."Reservation"("Id") ON DELETE CASCADE;


--
-- TOC entry 4852 (class 2606 OID 52522)
-- Name: ReservationItem reservationitem_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ReservationItem"
    ADD CONSTRAINT reservationitem_fk_1 FOREIGN KEY ("SeatId") REFERENCES public."Seat"("Id");


--
-- TOC entry 4840 (class 2606 OID 52527)
-- Name: Showtime showtime_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Showtime"
    ADD CONSTRAINT showtime_fk_2 FOREIGN KEY ("MovieId") REFERENCES public."Movie"("Id");


--
-- TOC entry 4841 (class 2606 OID 52532)
-- Name: Showtime showtime_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Showtime"
    ADD CONSTRAINT showtime_fk_3 FOREIGN KEY ("CinemaId") REFERENCES public."Cinema"("Id");


-- Completed on 2024-02-26 10:18:55

--
-- PostgreSQL database dump complete
--

