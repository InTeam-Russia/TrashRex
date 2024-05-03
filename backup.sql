--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.1

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
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    client_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer NOT NULL
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    icon boolean NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    arms character varying(512)
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: COLUMN cities.arms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cities.arms IS 'Герб';


--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    surname character varying(128),
    photo character varying(512) NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    logo character varying(255)
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback (
    id integer NOT NULL,
    client_id integer NOT NULL,
    product_id integer NOT NULL,
    rate integer NOT NULL,
    description text NOT NULL,
    photos boolean NOT NULL
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedback_id_seq OWNER TO postgres;

--
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- Name: infrastructure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infrastructure (
    company_id integer NOT NULL,
    city integer NOT NULL,
    storage boolean NOT NULL,
    dp boolean NOT NULL
);


ALTER TABLE public.infrastructure OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    company_id integer NOT NULL,
    client_id integer NOT NULL,
    order_type integer NOT NULL,
    product_id integer NOT NULL,
    price double precision NOT NULL,
    amount integer NOT NULL,
    sum double precision NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    "from" integer NOT NULL,
    "to" integer NOT NULL,
    stage_edge integer,
    stage_type integer NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: TABLE orders; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.orders IS 'Заказы';


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: path_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.path_types (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.path_types OWNER TO postgres;

--
-- Name: TABLE path_types; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.path_types IS 'Типы путей сообщения';


--
-- Name: path_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.path_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.path_types_id_seq OWNER TO postgres;

--
-- Name: path_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.path_types_id_seq OWNED BY public.path_types.id;


--
-- Name: paths; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paths (
    id integer NOT NULL,
    company_id integer NOT NULL,
    departure integer NOT NULL,
    destination integer NOT NULL,
    is_dest_transit boolean NOT NULL,
    type integer NOT NULL,
    duration double precision NOT NULL,
    distance double precision NOT NULL,
    price double precision NOT NULL
);


ALTER TABLE public.paths OWNER TO postgres;

--
-- Name: paths_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paths_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paths_id_seq OWNER TO postgres;

--
-- Name: paths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paths_id_seq OWNED BY public.paths.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    company_id integer NOT NULL,
    category integer,
    name character varying(255) NOT NULL,
    img character varying,
    size character varying(32),
    price double precision NOT NULL,
    amount integer NOT NULL,
    rating double precision,
    hidden boolean DEFAULT true NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: route; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.route (
    id integer NOT NULL,
    order_id integer NOT NULL,
    edge integer NOT NULL,
    prev_stage integer,
    next_stage integer,
    stage_num integer NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE public.route OWNER TO postgres;

--
-- Name: TABLE route; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.route IS 'Маршрутный лист товара';


--
-- Name: route_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.route_id_seq OWNER TO postgres;

--
-- Name: route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.route_id_seq OWNED BY public.route.id;


--
-- Name: storage_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.storage_products (
    company_id integer NOT NULL,
    city_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer NOT NULL
);


ALTER TABLE public.storage_products OWNER TO postgres;

--
-- Name: TABLE storage_products; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.storage_products IS 'Распределение продукции по складам';


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(320) NOT NULL,
    hashed_password character varying(1024) NOT NULL,
    role integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    is_superuser boolean DEFAULT false NOT NULL,
    is_verified boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: path_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.path_types ALTER COLUMN id SET DEFAULT nextval('public.path_types_id_seq'::regclass);


--
-- Name: paths id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paths ALTER COLUMN id SET DEFAULT nextval('public.paths_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: route id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route ALTER COLUMN id SET DEFAULT nextval('public.route_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (client_id, product_id, amount) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, icon) FROM stdin;
1	Разное	f
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (id, name, arms) FROM stdin;
1	Абаза	/public/cities/25px-Coat_of_Arms_of_Abaza_%28Khakassia%29.webp
2	Абакан	/public/cities/25px-Coat_of_Arms_of_Abakan_%28Khakassia%29.webp
3	Абдулино	/public/cities/25px-Abdulino_Rayon_Coat_of_Arms.webp
4	Абинск	/public/cities/25px-Coat_of_Arms_of_Abinsk_%28Krasnodar_krai%2C_2009%29.webp
5	Агидель	/public/cities/25px-Coat_of_Arms_of_Agidel_%28Bashkortostan%29.webp
6	Агрыз	/public/cities/25px-Coat_of_Arms_of_Agryz_rayon_%28Tatarstan%29.webp
7	Адыгейск	/public/cities/25px-Coat_of_arms_of_Adygeysk.webp
8	Азнакаево	/public/cities/25px-Aznakeevskii_rayon_gerb.webp
9	Азов	/public/cities/25px-Coat_of_Arms_of_Azov.svg.webp
10	Ак-Довурак	/public/cities/25px-Akdovurak_coat_of_arms.webp
11	Аксай	/public/cities/25px-Coat_of_Arms_of_Aksai_%28Rostov_oblast%29.webp
12	Алагир	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
13	Алапаевск	/public/cities/25px-Coat_of_Arms_of_Alapaevsk_%28Sverdlovsk_oblast%29.webp
14	Алатырь	/public/cities/25px-Coat_of_arms_of_Alatyr_%28Chuvashia%29.svg.webp
15	Алдан	/public/cities/25px-Coat_of_Arms_of_Aldan_rayon_%28Yakutia%29.webp
16	Алейск	/public/cities/25px-RUS_%D0%90%D0%BB%D0%B5%D0%B9%D1%81%D0%BA_COA.webp
17	Александров	/public/cities/25px-Coat_of_arms_of_Alexandrov_%282016%29.webp
18	Александровск (Пермский край)	/public/cities/25px-Coat_of_Arms_of_Aleksandrovsky_rayon_%28Perm_krai%29.webp
19	Александровск (ЛНР)	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
20	Александровск-Сахалинский	/public/cities/25px-Aleksandrovsk.webp
21	Алексеевка	/public/cities/25px-Coat_of_Arms_of_Alekseevka_%28Belgorod_oblast%29.svg.webp
22	Алексин	/public/cities/25px-Coat_of_Arms_of_Aleksin_%28Tula_oblast%29.webp
23	Алзамай	/public/cities/25px-Coat_of_Arms_of_Alzamayskoe_%28Irkutsk_oblast%29.webp
24	Алмазная	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
25	Алупка	/public/cities/25px-COA_Alupka%2C_Yaltynska%2C_Crimea.svg.webp
26	Алушта	/public/cities/25px-Coat_of_Arms_of_Alushta.webp
27	Алчевск	/public/cities/230px-ГербАЛЧ.webp
28	Альметьевск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%90%D0%BB%D1%8C%D0%BC%D0%B5%D1%82%D1%8C%D0%B5%D0%B2%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D0%BC%D1%83%D0%BD%D0%B8%D1%86%D0%B8%D0%BF%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B3%D0%BE_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD%D0%B0.webp
29	Амурск	/public/cities/25px-Coat_of_Arms_of_Amursk_%28Khabarovsk_krai%29_2011.webp
30	Анадырь	/public/cities/25px-Coat_of_Arms_of_Anadyr_%28Chukotka%29.webp
31	Анапа	/public/cities/25px-Coat_of_Arms_of_Anapa_%28Krasnodar_krai%29.svg.webp
32	Ангарск	/public/cities/25px-Coat_of_Arms_of_Angarsk.svg.webp
33	Андреаполь	/public/cities/25px-Coat_of_Arms_of_Andreapol_%28Tver_oblast%29.webp
34	Анжеро-Судженск	/public/cities/25px-Coat_of_Arms_of_Anzhero-Sudzhensk_%28Kemerovo_oblast%29.webp
35	Анива	/public/cities/25px-Aniva_COA_%282011%29.webp
36	Антрацит	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
37	Апатиты	/public/cities/25px-Apatity_COA_%282013%29.webp
38	Апрелевка	/public/cities/25px-Gerb_Aprelevka.webp
39	Апшеронск	/public/cities/25px-Coat_of_Arms_of_Apsheronsk_%282012%29.webp
40	Арамиль	/public/cities/25px-Coat_of_Arms_of_Aramil_%28Sverdlovsk_oblast%29.webp
41	Аргун	/public/cities/25px-Coat_of_Arms_of_Argun_%28Chechnya%29.svg.webp
42	Ардатов	/public/cities/25px-Coat_of_Arms_of_Ardatov_%282011%29.webp
43	Ардон	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
44	Арзамас	/public/cities/25px-Arzamas_COA_%281993%29.svg.webp
45	Аркадак	/public/cities/25px-Coat_of_Arms_of_Arkadak_%28Saratov_oblast%29.webp
46	Армавир	/public/cities/25px-Coat_of_Arms_of_Armavir_%28Krasnodar_krai%29.webp
47	Армянск	/public/cities/25px-COA_Armiansk%2C_Krym.svg.webp
48	Арсеньев	/public/cities/25px-Coat_of_Arms_of_Arseniev_%28Primorsky_kray%29.webp
49	Арск	/public/cities/25px-Coat_of_Arms_of_Arsk_%28Tatarstan%29.webp
50	Артём	/public/cities/25px-Coat_of_Arms_of_Artyom_%28Primorsky_kray%29.webp
51	Артёмовск (Красноярский край)	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
52	Артёмовск (ЛНР)	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
53	Артёмовский	/public/cities/25px-Coat_of_Arms_of_Artyomovsky_%28Sverdlovsk_oblast%29.webp
54	Архангельск	/public/cities/25px-Coat_of_Arms_of_Arkhangelsk.svg.webp
55	Асбест	/public/cities/25px-Coat_of_Arms_of_Asbest_%28Sverdlovsk_oblast%29.webp
56	Асино	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
57	Астрахань	/public/cities/25px-Coat_of_Arms_of_Astrakhan.webp
58	Аткарск	/public/cities/25px-Coat_of_Arms_of_Atkarsk_%28Saratov_oblast%29.webp
59	Ахтубинск	/public/cities/25px-Gerb-Akhtubinsk-new.webp
60	Ачинск	/public/cities/25px-Coat_of_arms_of_Achinsk_%282006%29.webp
61	Ачхой-Мартан	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
62	Аша	/public/cities/25px-Asha_COA_%282007%29.webp
63	Бабаево	/public/cities/25px-Coat_of_Arms_of_Babayevo_%28town%29%2C_Vologda_Oblast_%28from_2011-03-28%29.webp
64	Бабушкин	/public/cities/25px-Coat_of_Arms_of_Babushkin_%28Buryatia%29.webp
65	Бавлы	/public/cities/25px-Coat_of_Arms_of_Bavly_%28Tatarstan%29.webp
66	Багратионовск	/public/cities/25px-Coat_of_Arms_of_Bagrationovsk_%28Kaliningrad_oblast%29.webp
67	Байкальск	/public/cities/25px-Baykalsk_COA_%282011%29.webp
68	Баймак	/public/cities/25px-Coat_of_Arms_of_Baimak_rayon_%28Bashkortostan%29.webp
69	Бакал	/public/cities/25px-Coat_of_Arms_of_Bakal_%28Chelyabinsk_oblast%29.webp
70	Баксан	/public/cities/25px-Gerb-Baksan-1968.webp
71	Балабаново	/public/cities/25px-Coat_of_Arms_of_Balabanovo_%28Kaluga_oblast%29.webp
72	Балаково	/public/cities/25px-Coat_of_Arms_of_Balakovsky_District_%28Saratov_oblast%29.webp
73	Балахна	/public/cities/25px-Balakhna_COA_%28Nizhny_Novgorod_Governorate%29_%281781%29.webp
74	Балашиха	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%B0_%D0%91%D0%B0%D0%BB%D0%B0%D1%88%D0%B8%D1%85%D0%B8.webp
75	Балашов	/public/cities/25px-Coat_of_Arms_of_Balashov_%28Saratov_oblast%29.webp
76	Балей	/public/cities/25px-Coat_of_arm_baley.webp
77	Балтийск	/public/cities/25px-Coat_of_Arms_of_Baltiysk_%28Kaliningrad_oblast%29.webp
78	Барабинск	/public/cities/25px-Barabinsk_COA_%282009%29.webp
79	Барнаул	/public/cities/25px-Coat_of_arms_of_Barnaul_%282016%29.webp
80	Барыш	/public/cities/25px-Coat_of_arms_of_Barysh.webp
81	Батайск	/public/cities/25px-Coat_of_Arms_of_Bataisk_%28Rostov_oblast%29_%282003%29.webp
82	Бахчисарай	/public/cities/25px-COA_Bakhchysarai.svg.webp
83	Бежецк	/public/cities/25px-Coat_of_Arms_of_Bezhetsk_%28Tver_oblast%29_2006.webp
84	Белая Калитва	/public/cities/25px-Coat_of_Arms_of_Belaya_Kalitva_%28Rostov_oblast%29.webp
85	Белая Холуница	/public/cities/25px-Coat_of_Arms_of_Belaya_Holunitsa.webp
86	Белгород	/public/cities/25px-Coat_of_Arms_of_Belgorod.svg.webp
87	Белебей	/public/cities/25px-Coat_of_Arms_of_Belebei_%28Bashkortostan%29.webp
88	Белёв	/public/cities/25px-Coat_of_Arms_of_Belyov_%28Tula_oblast%29.webp
89	Белинский	/public/cities/25px-Coat_of_Arms_of_Belinsky_%28Penza_oblast%29.webp
90	Белово	/public/cities/25px-Coat_of_Arms_of_Belovo_%28Kemerovo_oblast%29.webp
91	Белогорск (Амурская область)	/public/cities/25px-Coat_of_Arms_of_Belogorsk_%28Amur_oblast%29.webp
92	Белогорск (Крым)	/public/cities/25px-COA_Bilohirsk%2C_Krym.svg.webp
93	Белозерск	/public/cities/25px-Coat_of_arms_of_Belozersky_District%2C_Vologda_Oblast.webp
94	Белокуриха	/public/cities/25px-Coat_of_Arms_of_Belokurikha.svg.webp
95	Беломорск	/public/cities/25px-Belomorsk_COA_%282019%29.webp
96	Белоозёрский	/public/cities/25px-Coat_of_Arms_of_Beloozyorsky_%28Moscow_oblast%29.webp
97	Белорецк	/public/cities/25px-Coat_of_Arms_of_Beloretsk_%28Bashkortostan%29.webp
98	Белореченск	/public/cities/25px-Belorechensk_%28Krasnodar_krai%29%2C_coat_of_arms.webp
99	Белоусово	/public/cities/25px-Coat_of_Arms_of_Belousovo_%28Kaluga_oblast%29.webp
100	Белоярский	/public/cities/25px-Coat_of_Arms_of_Beloyarsky_%28Khanty-Mansia%29.webp
101	Белый	/public/cities/25px-Bely_COA_%28Smolensk_Governorate%29_%281780%29.webp
102	Бердск	/public/cities/25px-Coat_of_Arms_of_Berdsk_%28Novosibirsk_oblast%29.webp
103	Бердянск	/public/cities/berdyansk.webp
104	Березники	/public/cities/25px-Coat_of_Arms_of_Berezniki_%28Perm_krai%29_%281981%29.webp
105	Берёзовский (Кемеровская область)	/public/cities/25px-Beryozovsky_COA_%282019%29.webp
106	Берёзовский (Свердловская область)	/public/cities/25px-Coat_of_Arms_of_Berezovsky_%28Sverdlovsk_oblast%29.svg.webp
107	Берислав	/public/cities/kherson_obl.webp
108	Беслан	/public/cities/25px-Beslan_coat.webp
109	Бийск	/public/cities/25px-Biysk_COA_%281804%29.webp
110	Бикин	/public/cities/25px-Coat_of_arms_of_Bikinsky_raion.webp
111	Билибино	/public/cities/25px-Coat_of_Arms_of_Bilibino_%28Chukotka%29.webp
112	Биробиджан	/public/cities/25px-Coat_of_arms_of_Birobidzhan.svg.webp
113	Бирск	/public/cities/25px-Coat_of_Arms_of_Birsk_%28Bashkortostan%29.webp
114	Бирюсинск	/public/cities/25px-Biryusinsk_COA_%282012%29.webp
115	Бирюч	/public/cities/25px-Coat_of_Arms_of_Biryuch.svg.webp
116	Благовещенск (Башкортостан)	/public/cities/25px-Coat_of_Arms_of_Blagoveschensk_%28Bashkortostan%29.webp
117	Благовещенск (Амурская область)	/public/cities/25px-Coat_of_Arms_of_Blagoveshchensk_%28Amur_oblat%29.webp
118	Благодарный	/public/cities/25px-Coat_of_Arms_of_Blagodarny.webp
119	Бобров	/public/cities/25px-Coat_of_Arms_of_Bobrov_%28Voronezh_oblast%29.webp
120	Богданович	/public/cities/25px-Coat_of_Arms_of_Bogdanovich_%28Sverdlovsk_oblast%29.webp
121	Богородицк	/public/cities/25px-Coat_of_Arms_of_Bogoroditsk_%28Tula_oblast%29.webp
122	Богородск	/public/cities/25px-Coats_of_arms_of_Bogorodsk.webp
123	Боготол	/public/cities/25px-Bogotol_city_gerb.webp
124	Богучар	/public/cities/25px-Coat_of_Arms_of_Boguchar_%28Voronezh_oblast%29.webp
125	Бодайбо	/public/cities/25px-Coat_of_Arms_of_Bodaibo_%28Irkutsk_oblast%29.svg.webp
126	Бокситогорск	/public/cities/25px-Coat_of_arms_of_Boksitogorsk_%282014%29.webp
127	Болгар	/public/cities/25px-Spassk_COA_%28Kazan_Governorate%29_%281781%29.webp
128	Бологое	/public/cities/25px-Coat_of_Arms_of_Bologoe_%28Tver_oblast%29.webp
129	Болотное	/public/cities/25px-Coat_of_Arms_of_Bolotnoe_%28Novosibirsk_oblast%29.webp
130	Болохово	/public/cities/25px-Bolohovo_city_coa.webp
131	Болхов	/public/cities/25px-Bolkhov_COA_%28Oryol_Governorate%29_%281781%29.webp
132	Большой Камень	/public/cities/25px-Coat_of_Arms_of_Bolshoy_Kamen_%28Primorsky_kray%29.webp
133	Бор	/public/cities/25px-Coat_of_Arms_of_Bor_%28Nizhny_Novgorod_oblast%29.webp
134	Борзя	/public/cities/25px-Coat_of_Arms_of_Borzya_%28Chita_oblast%29.webp
135	Борисоглебск	/public/cities/25px-Borisoglebsk_COA_%28Tambov_Governorate%29_%281781%29.webp
136	Боровичи	/public/cities/25px-Borovichi_COA_%282012%29.webp
137	Боровск	/public/cities/25px-Borovsk_COA_%282006%29.webp
138	Бородино	/public/cities/25px-Coat_of_Arms_of_Borodino_%28Krasnoyarsk_krai%29_%282006%29.webp
139	Братск	/public/cities/25px-Coat_of_Arms_of_Bratsk_%28Irkutsk_oblast%29.webp
140	Бронницы	/public/cities/25px-Coat_of_Arms_of_Bronnitsy_%28Moscow_oblast%29_%282005%29.webp
141	Брянка	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
142	Брянск	/public/cities/25px-Bryansk_COA_%282016%29.webp
143	Бугульма	/public/cities/25px-Coat_of_Arms_of_Bugulminsky_rayon_%28Tatarstan%29.webp
144	Бугуруслан	/public/cities/25px-Buguruslan_coat_of_arms.webp
145	Будённовск	/public/cities/25px-Coat_of_Arms_of_Budyonnovsk_%28Stavropol_krai%29.webp
146	Бузулук	/public/cities/25px-Buzuluk_COA_%281998%29.webp
147	Буинск	/public/cities/25px-Buinsk_COA_%28Simbirsk_Governorate%29_%281780%29.webp
148	Буй	/public/cities/25px-Coat_of_Arms_of_Buy_%28Kostroma_oblast%29.svg.webp
149	Буйнакск	/public/cities/25px-Coat_of_arms_of_Dagestan_Oblast_1878.svg.webp
150	Бутурлиновка	/public/cities/25px-Coat_of_Arms_of_Buturlinovka_%28Voronezh_oblast%29.webp
151	Валдай	/public/cities/25px-Valday_COA.webp
152	Валуйки	/public/cities/25px-Coat_of_arms_of_Valuyki_%28Belgorod_oblast%29.webp
153	Васильевка	/public/cities/vasilevka.webp
154	Вахрушево	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
155	Велиж	/public/cities/25px-Velizh_COA_%28Vitebsk_Governorate%29_%281781%29.webp
156	Великие Луки	/public/cities/25px-Velikie_Luki_COA_%28Pskov_Governorate%29.webp
157	Великий Новгород	/public/cities/25px-%D0%A1oat_of_Arms_of_Veliky_Novgorod.svg.webp
158	Великий Устюг	/public/cities/25px-Coat_of_Arms_of_Velikiy_Ustyug_%28Vologda_oblast%29_%282000%29.webp
159	Вельск	/public/cities/25px-Velsk_%28Vologda_Governorate%29_%281780%29.webp
160	Венёв	/public/cities/25px-Coat_of_Arms_of_Venyov_%28Tula_oblast%29.webp
161	Верещагино	/public/cities/25px-Vereshchagino_COA_%282006%29.webp
162	Верея	/public/cities/25px-Coat_of_Arms_of_Vereya_%28Moscow_oblast%29.webp
163	Верхнеуральск	/public/cities/25px-Verkhneuralsk_COA.webp
164	Верхний Тагил	/public/cities/25px-Coat_of_Arms_of_Verkhniy_Tagil_%28Sverdlovsk_oblast%29.webp
165	Верхний Уфалей	/public/cities/25px-Coat_of_Arms_of_Verkhny_Ufaley_%28Chelyabinsk_oblast%29.webp
166	Верхняя Пышма	/public/cities/25px-Coat_of_Arms_of_Verkhnyaya_Pyshma_%28Sverdlovsk_oblast%29.webp
167	Верхняя Салда	/public/cities/25px-Coat_of_Arms_of_Verkhnyaya_Salda_%28Sverdlovsk_oblast%29.webp
168	Верхняя Тура	/public/cities/25px-Coat_of_Arms_of_Verkhnyaya_Tura_%28Sverdlovsk_oblast%29.webp
169	Верхотурье	/public/cities/25px-Coat_of_Arms_of_Verkhotursky_District_%28Sverdlovsk_oblast%29.webp
170	Верхоянск	/public/cities/25px-Coat_of_Arms_of_Verkhoyansk_%28Yakutia%29_soviet.webp
171	Весьегонск	/public/cities/25px-Coat_of_Arms_of_Vesegonsk_%28Tver_oblast%29.webp
172	Ветлуга	/public/cities/25px-Vetluga_COA_%28Kostroma_Governorate%29_%281779%29.webp
173	Видное	/public/cities/25px-Vidnoe_COA_%282008%29.webp
174	Вилюйск	/public/cities/25px-Coat_of_Arms_of_Viluysk_%28Yakutia%29.webp
175	Вилючинск	/public/cities/25px-Coats_of_Arms_of_Viluchinsk.svg.webp
176	Вихоревка	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
177	Вичуга	/public/cities/25px-Coat_of_Arms_of_Vichuga.webp
178	Владивосток	/public/cities/25px-Coat_of_Arms_of_Vladivostok.svg.webp
179	Владикавказ	/public/cities/25px-Coat_of_arms_of_Vladikavkaz.webp
180	Владимир	/public/cities/25px-Vladimir_COA.webp
181	Волгоград	/public/cities/25px-Coat_of_arms_of_Volgograd_city.svg.webp
182	Волгодонск	/public/cities/25px-Coat_of_Arms_of_Volgodonsk_%28Rostov_oblast%29.webp
183	Волгореченск	/public/cities/25px-Coat_of_Arms_of_Volgorechensk_%28Kostroma_oblast%29.webp
184	Волжск	/public/cities/25px-Volzhsk_COA_%282002%29.webp
185	Волжский	/public/cities/25px-Coat_of_Arms_of_Volzhsky_%28Volgograd_oblast%29.webp
186	Вологда	/public/cities/25px-Vologda_COA_%282003%29.webp
187	Володарск	/public/cities/25px-Volodarsk_%28Seyma%29_COA_%282011%29.webp
188	Волоколамск	/public/cities/25px-Coat_of_Arms_of_Volokolamsk_%28Moscow_oblast%29.webp
189	Волосово	/public/cities/25px-Coat_of_Arms_of_Volosovo_%28Leningrad_oblast%29.webp
190	Волхов	/public/cities/25px-Coat_of_Arms_of_Volkhov_%28Leningrad_oblast%29.webp
191	Волчанск	/public/cities/25px-Coat_of_Arms_of_Volchansk_%28Sverdlovsk_oblast%29.webp
192	Вольнянск	/public/cities/zaporozhskaya_oblast.webp
193	Вольск	/public/cities/25px-Coat_of_Arms_of_Volsk_%28Saratov_oblast%29.webp
194	Воркута	/public/cities/25px-Coat_of_Arms_of_Vorkuta.svg.webp
195	Воронеж	/public/cities/25px-Small_Coat_of_Arms_of_Voronezh.webp
196	Ворсма	/public/cities/25px-Coat-of-arms-Vorsma.webp
197	Воскресенск	/public/cities/25px-Coat_of_arms_of_Voskresensk.webp
198	Воткинск	/public/cities/25px-Coat_of_Arms_of_Votkinsk_%28Udmurtia%29.webp
199	Всеволожск	/public/cities/25px-Vsevolozhsk_COA.webp
200	Вуктыл	/public/cities/25px-Coat_of_Arms_of_Vuktyl.webp
201	Выборг	/public/cities/25px-Coat_of_arms_of_Vyborg.svg.webp
202	Выкса	/public/cities/25px-Vyksa_COA_%282017%29.webp
930	Скадовск	/public/cities/kherson_obl.webp
203	Высоковск	/public/cities/25px-Coat_of_Arms_of_Vysokovsk_%28Moscow_oblast%29_%281997%29.webp
204	Высоцк	/public/cities/25px-Coat_of_Arms_of_Vysotskoe_GP.webp
205	Вытегра	/public/cities/25px-Coat_of_arms_of_Vytegra_%282007%29.webp
206	Вышний Волочёк	/public/cities/25px-Coat_of_Arms_of_Vyshny_Volochek_%28Tver_oblast%29.webp
207	Вяземский	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
208	Вязники	/public/cities/25px-Vyazniki_COA_%28Vladimir_Governorate%29_%281781%29.webp
209	Вязьма	/public/cities/25px-Coat_of_arms_of_Vyazma.webp
210	Вятские Поляны	/public/cities/25px-Coat_of_Arms_of_Vyatskie_Polyany_%28Kirov_oblast%29.webp
211	Гаврилов Посад	/public/cities/25px-Coat_of_arms_of_Gavrilov_Posad.webp
212	Гаврилов-Ям	/public/cities/25px-Coat_of_arms_of_Gavrilov-Yam_%282008%29.webp
213	Гагарин	/public/cities/25px-Coat_of_Arms_of_Gagarin_city.webp
214	Гаджиево	/public/cities/25px-Coat_of_Arms_of_Gadzhievo.webp
215	Гай	/public/cities/25px-Gay_Coat_of_Arms.webp
216	Галич	/public/cities/25px-Coat_of_Arms_of_Galich_%28Kostroma_oblast%29.webp
217	Гатчина	/public/cities/25px-Gatchina_COA.webp
218	Гвардейск	/public/cities/25px-Coat_of_Arms_of_Gvardeisk_%28Kaliningrad_oblast%29.webp
219	Гдов	/public/cities/25px-Coat_of_Arms_of_Gdov_%28Pskov_oblast%29.webp
220	Геленджик	/public/cities/25px-Gelendzhik.svg.webp
221	Геническ	/public/cities/kherson_obl.webp
222	Георгиевск	/public/cities/25px-Coat_of_Arms_of_Georgievsk_%28Stavropol_krai%29_%282009%29.webp
223	Глазов	/public/cities/25px-Coat_of_Arms_of_Glazov_%28Udmurtia%29.webp
224	Голая Пристань	/public/cities/kherson_obl.webp
225	Голицыно	/public/cities/25px-Coat_of_Arms_of_Golitsyno_%28Moscow_oblast%29.webp
226	Горбатов	/public/cities/25px-Gorbatov_COA_%28Nizhny_Novgorod_Governorate%29_%281781%29.webp
227	Горловка	/public/cities/Novyy_proekt.webp
228	Горно-Алтайск	/public/cities/25px-Coat_of_Arms_of_Gornoaltaysk_%28Altai_Republic%29.webp
229	Горнозаводск	/public/cities/25px-Coat_of_Arms_of_Gornozavodsky_rayon_%28Perm_krai%29_%282008%29.webp
230	Горняк	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%B0_%D0%93%D0%BE%D1%80%D0%BD%D1%8F%D0%BA.svg.webp
231	Городец	/public/cities/25px-Coat_of_Arms_of_Gorodets_%28Nizhny_Novgorod%29.webp
232	Городище	/public/cities/25px-Coat_of_Arms_of_Gorodishe_%28Penza_oblast%29.webp
233	Городовиковск	/public/cities/25px-Coat_of_arms_of_Gorodovikovsk.webp
234	Гороховец	/public/cities/25px-Coat_of_Arms_of_Gorokhovets_%28Vladimirskaya_oblast%29.webp
235	Горское	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
236	Горячий Ключ	/public/cities/25px-Coat_of_Arms_of_Goryachy_Klyuch_%28Krasnodar_krai%29.webp
237	Грайворон	/public/cities/25px-Coat_of_Arms_of_Grayvoron_%28Belgorod_oblast%29.svg.webp
238	Гремячинск	/public/cities/25px-Gremyachinsk_COA_%282010%29.webp
239	Грозный	/public/cities/25px-Coat_of_Arms_of_Grozny_%28Chechnya%29.svg.webp
240	Грязи	/public/cities/25px-Coat_of_arms_of_Gryazi_%282008%29.webp
241	Грязовец	/public/cities/25px-Coat_of_arms_of_Gryazovets_%282001%29.webp
242	Губаха	/public/cities/25px-Coat_of_Arms_of_Gubahinsky_rayon_%282010%29.webp
243	Губкин	/public/cities/25px-Coat_of_Arms_of_Gubkin_%28Belgorod_oblast%29.svg.webp
244	Губкинский	/public/cities/25px-Coat_of_Arms_of_Gubkinsky_%28Yamal_Nenetsia%29.webp
245	Гудермес	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
246	Гуково	/public/cities/25px-Gukovo_gerb.webp
247	Гулькевичи	/public/cities/25px-Coat_of_Arms_of_Gulkevichi_%28Krasnodar_kray%29.webp
248	Гуляйполе	/public/cities/zaporozhskaya_oblast.webp
249	Гурьевск (Калининградская область)	/public/cities/25px-Guryevsk_COA_%281997%29.webp
250	Гурьевск (Кемеровская область)	/public/cities/25px-Guryevsk_COA_%282006%29.webp
251	Гусев	/public/cities/25px-Coat_of_Arms_of_Gusev_%28Kaliningrad_oblast%29.webp
252	Гусиноозёрск	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
253	Гусь-Хрустальный	/public/cities/25px-Coat_of_Arms_of_Gus-Khrustalny_%28Vladimir_oblast%29.webp
254	Давлеканово	/public/cities/25px-Coat_of_Arms_of_Davlekanovo_rayon_%28Bashkortostan%29.webp
255	Дагестанские Огни	/public/cities/25px-Coat_of_Arms_of_Dagestanskie_Ogni.webp
256	Далматово	/public/cities/25px-Coat_of_Arms_of_Dalmatovo_%282006%29.webp
257	Дальнегорск	/public/cities/25px-Coat_of_Arms_of_Dalnegorsk_%28Primorsky_kray%29.webp
258	Дальнереченск	/public/cities/25px-Coat_of_Arms_of_Dalnerechensk_%28Primorsky_kray%29.webp
259	Данилов	/public/cities/25px-Coat_of_Arms_of_Danilov_%28Yaroslavl_oblast%29_%282007%29.webp
260	Данков	/public/cities/25px-Coat_of_Arms_of_Dankov_rayon_%28Lipetsk_oblast%29.webp
261	Дебальцево	/public/cities/debalcevo.webp
262	Дегтярск	/public/cities/25px-Coat_of_Arms_of_Degtyarsk_%28Sverdlovsk_oblast%29.webp
263	Дедовск	/public/cities/25px-Coat_of_arms_of_Dedovsk.webp
264	Демидов	/public/cities/25px-Coat_of_arms_of_Demidov_rayon_%282005%29.webp
265	Дербент	/public/cities/25px-Coat_of_Arms_of_Derbent_%28Dagestan%29_%281843%29.webp
266	Десногорск	/public/cities/25px-Coat_of_arms_of_Desnogorsk.webp
267	Джанкой	/public/cities/25px-Dzhankoy-arms.webp
268	Дзержинск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%94%D0%B7%D0%B5%D1%80%D0%B6%D0%B8%D0%BD%D1%81%D0%BA%D0%B0_%28%D0%9D%D0%B8%D0%B6%D0%B5%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D1%81%D0%BA%D0%B0%D1%8F_%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C%29.svg.webp
269	Дзержинский	/public/cities/25px-Coat_of_Arms_of_Dzerzhinsky_%28Moscow_oblast%29.webp
270	Дивногорск	/public/cities/25px-Divnogorsk_COA.svg.webp
271	Дигора	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
272	Димитровград	/public/cities/25px-Coat_of_Arms_of_Dimitrovgrad.webp
273	Дмитриев	/public/cities/25px-Dmitriev_COA_%28Kursk_Governorate%29_%281780%29.webp
274	Дмитров	/public/cities/25px-Coat_of_Arms_Dmitrov.webp
275	Дмитровск	/public/cities/25px-Coat_of_Arms_of_Dmitrovsk-Olgovsky_%28Oryol_oblast%29.webp
276	Днепрорудное	/public/cities/zaporozhskaya_oblast.webp
277	Дно	/public/cities/25px-Coat_of_Arms_of_Dno_%28Pskov_oblast%29.webp
278	Добрянка	/public/cities/25px-Dobryanka_City_Coat_%28Perm_Krai%2C_2006%29.webp
279	Докучаевск	/public/cities/Coat_of_arms_of_Dokuchaievsk.webp
280	Долгопрудный	/public/cities/25px-Coat_of_Arms_of_Dolgoprudny_%28Moscow_oblast%29_%282003%29.webp
281	Долинск	/public/cities/25px-Coat_of_Arms_of_Dolinsky_rayon_%28Sakhalin_oblast%29.webp
282	Домодедово	/public/cities/25px-Coat_of_Arms_of_Domodedovo_%28Moscow_oblast%29.webp
283	Донецк (Ростовская область)	/public/cities/25px-Coat_of_Arms_of_Donetsk_%28Rostov_Oblast%29.webp
284	Донецк (ДНР)	/public/cities/donetsk.webp
285	Донской	/public/cities/25px-Donskoy_gerb.svg.webp
286	Дорогобуж	/public/cities/25px-Dorogobuzh_COA_%282000%29.webp
287	Дрезна	/public/cities/25px-Coat_of_Arms_of_Drezna_%28Moscow_oblast%29.webp
288	Дубна	/public/cities/25px-Dubna_COA_%282003%29.webp
289	Дубовка	/public/cities/25px-Dubovka_coat_of_arms_%28Volgograd_region%29.webp
290	Дудинка	/public/cities/25px-Coat_of_Arms_of_Dudinka_%28Taimyria%29.webp
291	Духовщина	/public/cities/25px-Dukhovshchina_COA_%28Smolensk_Governorate%29_%281780%29.webp
292	Дюртюли	/public/cities/25px-Durtuli.webp
293	Дятьково	/public/cities/25px-Dyatkovsky_rayon_COA_%282019%29.webp
294	Евпатория	/public/cities/25px-COA_of_Evpatoria.svg.webp
295	Егорьевск	/public/cities/25px-Yegorievsk_COA_%282015%29.webp
296	Ейск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%B0_%D0%95%D0%B9%D1%81%D0%BA%D0%B0.webp
297	Екатеринбург	/public/cities/25px-Coat_of_Arms_of_Yekaterinburg_%28Sverdlovsk_oblast%29.svg.webp
298	Елабуга	/public/cities/25px-Coat_of_Arms_of_Elabuga_%28Tatarstan%29_%282006%29.webp
299	Елец	/public/cities/25px-Coat_of_arms_of_Elets_%282004%29.webp
300	Елизово	/public/cities/25px-Coat_of_Arms_of_Elizovo_%282009%29_%28Kamchatka_krai%29.webp
301	Ельня	/public/cities/25px-Coat_of_arms_of_Elnya.webp
302	Еманжелинск	/public/cities/25px-Coat_of_Arms_of_Emanzhelinsk_%28Chelyabinsk_oblast%29.webp
303	Емва	/public/cities/25px-Coat_of_Arms_of_Knjazhpogostskiy_rayon_%28Komi%29.webp
304	Енакиево	/public/cities/enakievo.webp
305	Енисейск	/public/cities/25px-Coat_of_arms_of_Yeniseysk.svg.webp
306	Ермолино	/public/cities/25px-Coat_of_Arms_of_Ermolino_%28Kaluga_oblast%29.webp
307	Ершов	/public/cities/25px-Coat_of_arms_of_Ershov.webp
308	Ессентуки	/public/cities/25px-Coat_of_Arms_of_Essentuki_%28Stavropol_krai%29.webp
309	Ефремов	/public/cities/25px-Coat_of_Arms_of_Efremov_%28Tula_oblast%29.webp
310	Ждановка	/public/cities/Zhdanovka_0.webp
311	Железноводск	/public/cities/25px-Coat_of_Arms_of_Zheleznovodsk_%28Stavropol_kray%29.webp
312	Железногорск (Красноярский край)	/public/cities/25px-Coat_of_Arms_of_Zheleznogorsk.svg.webp
313	Железногорск (Курская область)	/public/cities/25px-Coat_of_Arms_of_Zheleznogorsk_%28Kursk_oblast%29.webp
314	Железногорск-Илимский	/public/cities/25px-Zheleznogorsk-Ilimsky_COA_%282012%29.webp
315	Жердевка	/public/cities/25px-Coat_of_Arms_of_Zherdevka_%28Tambov_oblast%29.webp
316	Жигулёвск	/public/cities/25px-Coat_of_Arms_of_Zhigulyovsk_%28Samara_oblast%29.webp
317	Жиздра	/public/cities/25px-Coat_of_Arms_of_Zhizdra_%28Kaluga_oblast%29.webp
318	Жирновск	/public/cities/25px-%D0%93_%D0%96%D0%B8%D1%80%D0%BD%D0%BE%D0%B2%D1%81%D0%BA_%D0%B3%D0%B5%D1%80%D0%B1.webp
319	Жуков	/public/cities/25px-Coat_of_Arms_of_Zhukov_%28Kaluga_oblast%29.webp
320	Жуковка	/public/cities/25px-Coat_of_arms_Zhukovka.webp
321	Жуковский	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%96%D1%83%D0%BA%D0%BE%D0%B2%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%28%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%B0_%D0%9C%D0%BE%D1%81%D0%BA%D0%BE%D0%B2%D1%81%D0%BA%D0%BE%D0%B9_%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D0%B8%29.svg.webp
322	Завитинск	/public/cities/25px-Coat_of_Arms_of_Zavitinskii_rayon_%28Amur_oblast%29.webp
323	Заводоуковск	/public/cities/25px-Coat_of_Arms_of_Zavodoukovsk_%28Tyumen_oblast%29.webp
324	Заволжск	/public/cities/25px-Coat_of_Arms_of_Zavolzhsk.webp
325	Заволжье	/public/cities/25px-Zavolzh.webp
326	Задонск	/public/cities/25px-Zadonsk_COA_%282008%29.webp
327	Заинск	/public/cities/25px-Coat_of_Arms_of_Zainsky_rayon_%28Tatarstan%29.webp
328	Закаменск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%97%D0%B0%D0%BA%D0%B0%D0%BC%D0%B5%D0%BD%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD%D0%B0.webp
329	Заозёрный	/public/cities/25px-Coat_of_Arms_of_Zaozyorny_%28Krasnoyarsk_krai%29.webp
330	Заозёрск	/public/cities/25px-Coat_of_arms_of_Zaozersk_%282001%29.webp
331	Западная Двина	/public/cities/25px-Coat_of_Arms_of_Zapadnodvinsky_rayon_%28Tver_oblast%29.webp
332	Заполярный	/public/cities/25px-Coat_of_Arms_of_Zapolyarny_%28Murmansk_oblast%29.webp
333	Запорожье	/public/cities/zaporozhskaya_oblast.webp
400	Камызяк	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9A%D0%B0%D0%BC%D1%8B%D0%B7%D1%8F%D0%BA.svg.webp
334	Зарайск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D0%BF%D0%BE%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D1%8F_%D0%97%D0%B0%D1%80%D0%B0%D0%B9%D1%81%D0%BA.webp
335	Заречный (Пензенская область)	/public/cities/25px-Coat_of_Arms_of_Zarechny_%28Penza_oblast%29.webp
336	Заречный (Свердловская область)	/public/cities/25px-Coat_of_Arms_of_Zarechny_%28Sverdlovsk_oblast%29.webp
337	Заринск	/public/cities/25px-Zarinsk_coat_of_arms.svg.webp
338	Звенигово	/public/cities/25px-Gerb-Zvenigovsky-region.webp
339	Звенигород	/public/cities/25px-Coat_of_Arms_of_Zvenigorod_%28Moscow_oblast%29.webp
340	Зверево	/public/cities/25px-Coat_of_Arms_of_Zverevo_%28Rostov_oblast%29.webp
341	Зеленогорск	/public/cities/25px-Coat_of_Arms_of_Zelenogorsk_%28Krasnoyarsk_krai%29.webp
342	Зеленоградск	/public/cities/25px-Zelenogradsk_COA_%282015%29.webp
343	Зеленодольск	/public/cities/25px-Coat_of_Arms_of_Zelenodolsk_%28Tatarstan%29.webp
344	Зеленокумск	/public/cities/25px-Coat_of_Arms_of_Zelenokumsk.webp
345	Зерноград	/public/cities/25px-Zernograd_COA_%282011%29.webp
346	Зея	/public/cities/25px-Coat_of_Arms_of_Zeya_%28Amur_oblast%29.webp
347	Зима	/public/cities/25px-Zima_g.webp
348	Зимогорье	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
349	Златоуст	/public/cities/25px-Zlatoust_COA_%282000%29.webp
350	Злынка	/public/cities/25px-Zlynka_rayon_COA_%282019%29.webp
351	Змеиногорск	/public/cities/25px-Zmeinogorsk_COA_%282012%29.webp
352	Знаменск	/public/cities/25px-RUS_%D0%97%D0%BD%D0%B0%D0%BC%D0%B5%D0%BD%D1%81%D0%BA_COA.webp
353	Золотое	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
354	Зоринск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
355	Зубцов	/public/cities/25px-Coat_of_Arms_of_Zubtsov_%28Tver_oblast%29.webp
356	Зугрэс	/public/cities/Coat_of_Arms_of_the_Donetsk_People's_Republic.svg.webp
357	Зуевка	/public/cities/25px-Coat_of_Arms_of_Zuevka_%28Kirov_region%29.webp
358	Ивангород	/public/cities/25px-Coat_of_Arms_of_Ivangorod_%28Leningrad_oblast%29.webp
359	Иваново	/public/cities/25px-Coat-of-Arms-of-Ivanovo-%28Ivanovskaya_oblast%29.svg.webp
360	Ивантеевка	/public/cities/25px-Coat_of_Arms_of_Ivanteevka_%28Moscow_oblast%29.webp
361	Ивдель	/public/cities/25px-Ivdel_COA_%282007%29.webp
362	Игарка	/public/cities/25px-Coat_of_Arms_of_Igarka.svg.webp
363	Ижевск	/public/cities/25px-Coat_of_Arms_of_Izhevsk_%28Udmurtia%29.svg.webp
364	Избербаш	/public/cities/25px-Coat_of_Arms_of_Izberbash.webp
365	Изобильный	/public/cities/25px-Coat_of_arms_of_Izobilnensky_rayon.svg.webp
366	Иланский	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
367	Иловайск	/public/cities/Ilovaysk_Gerb.webp
368	Инза	/public/cities/25px-Inza_COA_%282006%29.webp
369	Иннополис	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
370	Инсар	/public/cities/25px-Insar_COA_%28Penza_Governorate%29_%281781%29.webp
371	Инта	/public/cities/25px-Coat_of_Arms_of_Inta_%28Komi%29_%281982%29.svg.webp
372	Ипатово	/public/cities/25px-Coat_of_arms_of_Ipatovsky_rayon_%28Stavropol_krai%29.svg.webp
373	Ирбит	/public/cities/25px-Coat_of_Arms_of_Irbit_%28Sverdlovsk_oblast%29.webp
374	Иркутск	/public/cities/25px-Coat_of_Arms_of_Irkutsk.webp
375	Ирмино	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
376	Исилькуль	/public/cities/25px-Isilkul_COA_%282008%29.webp
377	Искитим	/public/cities/25px-Coat_of_arms_of_Iskitim.webp
378	Истра	/public/cities/25px-Coat_of_Arms_of_Istra_%282008%29.webp
379	Ишим	/public/cities/25px-Coat_of_Arms_of_Ishim_%28Tyumen_oblast%29.webp
380	Ишимбай	/public/cities/25px-Coat_of_Arms_of_Ishimbai_%28Bashkortostan%29.webp
381	Йошкар-Ола	/public/cities/25px-Coat_of_Arms_of_Yoshkar-Ola_%28Mariy-El%29.webp
382	Кадников	/public/cities/25px-Kadnikov_%28Vologda_Governorate%29_%281781%29.webp
383	Казань	/public/cities/25px-Coat_of_Arms_of_Kazan_%28Tatarstan%29_%282004%29.webp
384	Калач	/public/cities/25px-Coat_of_Arms_of_Kalach.webp
385	Калач-на-Дону	/public/cities/25px-Kalach-na-Donu_COA_%282013%29.webp
386	Калачинск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%B0_%D0%9A%D0%B0%D0%BB%D0%B0%D1%87%D0%B8%D0%BD%D1%81%D0%BA.webp
387	Калининград	/public/cities/25px-Coat_of_arms_of_Kaliningrad.svg.webp
388	Калининск	/public/cities/25px-Coat_of_Arms_of_Kalininsk_%28Saratov_oblast%29.webp
389	Калтан	/public/cities/25px-Coat_of_Arms_of_Kaltan_%28Kemerovo_oblast%29.webp
390	Калуга	/public/cities/25px-Kaluga_COA_%282000%29.webp
391	Калязин	/public/cities/25px-Coat_of_Arms_of_Kalyazin_%28Tver_oblast%29.webp
392	Камбарка	/public/cities/25px-Coat_of_Arms_of_Kambarka_rayon_%28Udmurtia%29.svg.webp
393	Каменка	/public/cities/25px-Coat_of_Arms_of_Kamenka_%28Penza_oblast%29.webp
394	Каменка-Днепровская	/public/cities/zaporozhskaya_oblast.webp
395	Каменногорск	/public/cities/25px-Coat_of_Arms_of_Kamennogorskoe_GP.webp
396	Каменск-Уральский	/public/cities/25px-Coat_of_Arms_of_Kamensk-Uralsky_%28Sverdlovsk_oblast%29.webp
397	Каменск-Шахтинский	/public/cities/25px-Coat_of_Arms_of_Kamensk-Shakhtinsky_%28Rostov_oblast%29.webp
398	Камень-на-Оби	/public/cities/25px-Coat_of_Arms_of_Kamen-na-Obi_%28Altai_kray%29.webp
399	Камешково	/public/cities/25px-Coat_of_Arms_of_Kamechkovo_%28Vladimir_oblast%29.webp
401	Камышин	/public/cities/25px-Coat_of_Arms_of_Kamyshin_%28Volgograd_oblast%29.webp
402	Камышлов	/public/cities/25px-Kamyshlov_city_coa.webp
403	Канаш	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9A%D0%B0%D0%BD%D0%B0%D1%88%D0%B0_2017.webp
404	Кандалакша	/public/cities/25px-Kandalaksha_COA_1_%282008%29.webp
405	Канск	/public/cities/25px-Kansk_COA_%282010%29.webp
406	Карабаново	/public/cities/25px-Coat_of_Arms_of_Karabanovo.webp
407	Карабаш	/public/cities/25px-Coat_of_Arms_of_Karabash_%28Chelyabinsk_oblast%29.webp
408	Карабулак	/public/cities/25px-Coat_of_arms_of_Karabulak.webp
409	Карасук	/public/cities/25px-Karasuk_COA_%281998%29.webp
410	Карачаевск	/public/cities/25px-1779_bi.webp
411	Карачев	/public/cities/25px-Karachev_COA_%28Oryol_Governorate%29_%281781%29.webp
412	Каргат	/public/cities/25px-Coat_of_Arms_of_Kargat_%28Novosibirsk_oblast%29.webp
413	Каргополь	/public/cities/25px-Kargopol_coat_of_arms.webp
414	Карпинск	/public/cities/25px-Karpinsk_COA_%282004%29.webp
415	Карталы	/public/cities/25px-Kartaly_COA_%282007%29.webp
416	Касимов	/public/cities/25px-Kasimov_COA_%281998%29.webp
417	Касли	/public/cities/25px-Kasli_COA_%282011%29.webp
418	Каспийск	/public/cities/25px-Gerb_kaspiska.webp
419	Катав-Ивановск	/public/cities/25px-Coat_of_Arms_of_Katav-Ivanovsk_%28Chelyabinsk_oblast%29.webp
420	Катайск	/public/cities/25px-Coat_of_Arms_of_Kataysk_%28Kurgan_oblast%29.webp
421	Каховка	/public/cities/kherson_obl.webp
422	Качканар	/public/cities/25px-Coat_of_Arms_of_Kachkanar_%28Sverdlovsk_oblast%29.webp
423	Кашин	/public/cities/25px-Coat_of_Arms_of_Kashin_%28Tver_oblast%29.webp
424	Кашира	/public/cities/25px-Coat_of_Arms_of_Kashira_%28Moscow_oblast%29_%281998%29.webp
425	Кедровый	/public/cities/25px-Coat_of_arms_of_Kedrovy_%28Tomsk_oblast%29.webp
426	Кемерово	/public/cities/25px-Coat_of_arms_of_Kemerovo_%282019%29.svg.webp
427	Кемь	/public/cities/25px-Kem_COA_%28Arkhangelsk_Governorate%29_%281788%29.webp
428	Керчь	/public/cities/25px-Kerch_coat.svg.webp
429	Кизел	/public/cities/25px-Coat_of_Arms_of_Kizel_%28Perm_krai%29.webp
430	Кизилюрт	/public/cities/25px-Coat_of_Arms_of_Kiziljurt.webp
431	Кизляр	/public/cities/25px-Coat_of_Arms_of_Kizlyar_%28Dagestan%29_%281842%29.webp
432	Кимовск	/public/cities/25px-Kimovsk_gerb.webp
433	Кимры	/public/cities/25px-Coat_of_Arms_of_Kimry_%28Tver_Oblast%29.webp
434	Кингисепп	/public/cities/25px-Coat_of_Arms_of_Kingisepp_%28Leningrad_oblast%29.webp
435	Кинель	/public/cities/25px-Coat_of_Arms_of_Kinel_%28Samara_oblast%29.webp
436	Кинешма	/public/cities/25px-Coat_of_Arms_of_Kineshma_%282004%29.webp
437	Киреевск	/public/cities/25px-Coat_of_Arms_of_Kireevsk_%28Tula_oblast%29_%281990%29.webp
438	Киренск	/public/cities/25px-Coat_of_Arms_of_Kirensk_%28Irkutsk_oblast%29_%281790%29.webp
439	Киржач	/public/cities/25px-Coat_of_Arms_of_Kirzhach_%28Vladimirskaya_oblast%29.webp
440	Кириллов	/public/cities/25px-Kirillov_COA_%281996%29.webp
441	Кириши	/public/cities/25px-Coat_of_Arms_of_Kirishi_%28Leningrad_oblast%29.webp
442	Киров (Калужская область)	/public/cities/25px-Coat_of_Arms_of_Kirov_%28Kaluga_oblast%29.webp
443	Киров (Кировская область)	/public/cities/25px-Coat_of_arms_of_Kirov.svg.webp
444	Кировград	/public/cities/25px-Coat_of_Arms_of_Kirovgrad_%28Sverdlovsk_oblast%29.webp
445	Кирово-Чепецк	/public/cities/25px-Coat_of_Arms_of_Kirovo-Chepetsk_%282004%29.webp
446	Кировск (Ленинградская область)	/public/cities/25px-Coat_of_Arms_of_Kirovsk_rayon_%28Leningrad_oblast%29.webp
447	Кировск (Мурманская область)	/public/cities/25px-Kirovsk_coa.webp
448	Кировск (ЛНР)	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
449	Кировское	/public/cities/kirovskoe.webp
450	Кирс	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
451	Кирсанов	/public/cities/25px-Coat_of_arms_of_Kirsanov_%282018%29.webp
452	Киселёвск	/public/cities/25px-Coat_of_Arms_of_Kiselyovsk_%28Kemerovo_oblast%29.webp
453	Кисловодск	/public/cities/25px-Kislovodsk_COA_%282013%29.webp
454	Клин	/public/cities/25px-Coat_of_Arms_of_Gorodskoe_poselenie_Klin_%28Moscow_oblast%29.webp
455	Клинцы	/public/cities/25px-Coat_of_Arms_of_Klintsy.svg.webp
456	Княгинино	/public/cities/25px-Knyaginin_COA_%28Nizhny_Novgorod_Governorate%29_%281781%29.webp
457	Ковдор	/public/cities/25px-Coat_of_Arms_of_Kovdor_%28Murmansk_oblast%29.webp
458	Ковров	/public/cities/25px-Kovrov_COA_%282012%29.webp
459	Ковылкино	/public/cities/25px-Coat_of_Arms_of_Kovylkino_%28Mordovia%29.webp
460	Когалым	/public/cities/25px-Coat_of_Arms_of_Kogalym.webp
461	Кодинск	/public/cities/25px-Kodinsk_city.webp
462	Козельск	/public/cities/25px-Kozelsk_COA_%28Kaluga_Governorate%29_%281777%29.webp
463	Козловка	/public/cities/25px-Kozlovka_COA_%282020%29.webp
464	Козьмодемьянск	/public/cities/25px-Coat_of_Arms_of_Kozmodemiansk_%28Mariy_El%29_%282005%29.webp
465	Кола	/public/cities/25px-Coat_of_Arms_of_Kola_%28Murmansk_oblast%29_%282016%29.webp
466	Кологрив	/public/cities/25px-Coat_of_Arms_of_Kologriv_%28Kostroma_oblast%29.webp
467	Коломна	/public/cities/25px-Coat_of_Arms_of_Kolomna_%28Moscow_oblast%29.webp
468	Колпашево	/public/cities/25px-Coat_of_Arms_of_Kolpashevsky_district_%28Tomsk_oblast%29.webp
469	Колтуши	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
470	Кольчугино	/public/cities/25px-Kolchuginkskiy_rayon_COA_%282002%29.webp
471	Коммунар	/public/cities/25px-Coat_of_Arms_of_Kommunar_%28Leningrad_oblast%29.webp
472	Комсомольск	/public/cities/25px-Coat_of_Arms_of_Komsomolsky_rayon_%28Ivanovo_oblast%29.webp
473	Комсомольск-на-Амуре	/public/cities/25px-Coat_of_Arms_of_Komsomolsk-na-Amure_%28Khabarovsk_kray%29_%281999%29.webp
474	Конаково	/public/cities/25px-Coat_of_arms_Konakovo_%28Tver_oblast%29_Russia_2007.webp
475	Кондопога	/public/cities/25px-Kondopoga_rayon_COA_%282019%29.webp
476	Кондрово	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9A%D0%BE%D0%BD%D0%B4%D1%80%D0%BE%D0%B2%D0%BE.webp
477	Константиновск	/public/cities/25px-Konstantinovsk_COA_%282018%29.webp
478	Копейск	/public/cities/25px-Coat_of_Arms_of_Kopeysk_%28Chelyabinsk_oblast%29_%282002%29.webp
479	Кораблино	/public/cities/25px-Korablino_COA_%282015%29.webp
480	Кореновск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9A%D0%BE%D1%80%D0%B5%D0%BD%D0%BE%D0%B2%D1%81%D0%BA%D0%B0.webp
481	Коркино	/public/cities/25px-Coat_of_Arms_of_Korkino_%28Chelyabinsk_oblast%29.webp
482	Королёв	/public/cities/25px-Coat_of_Arms_of_Korolyov_%28Moscow_Oblast%29.svg.webp
483	Короча	/public/cities/25px-Coat_of_Arms_of_Korocha_%28Belgorod_oblast%29.svg.webp
484	Корсаков	/public/cities/25px-Coat_of_Arms_of_Korsakov_%28Sakhalin_oblast%29.webp
485	Коряжма	/public/cities/25px-Coat_of_Arms_of_Koryazhma_%28Arkhangelsk_oblast%29.webp
486	Костерёво	/public/cities/25px-Coat_of_Arms_of_Kosteryovo.webp
487	Костомукша	/public/cities/25px-Coat_of_Arms_of_Kostomuksha_%282013%29.webp
488	Кострома	/public/cities/25px-Coat_of_Arms_of_Kostroma.svg.webp
489	Котельники	/public/cities/25px-Coat_of_Arms_of_Kotelniki_%28Moscow_oblast%29.webp
490	Котельниково	/public/cities/25px-Kotelnikovo_COA_%282008%29.webp
491	Котельнич	/public/cities/25px-Coat_of_Arms_of_Kotelnich_%28Kirov_oblast%29.webp
492	Котлас	/public/cities/25px-Coat_of_Arms_of_Kotlas_%28Arkhangelsk_oblast%29_2007.webp
493	Котово	/public/cities/25px-Kotovo_COA_%282007%29.webp
494	Котовск	/public/cities/25px-Kotovsk.webp
495	Кохма	/public/cities/25px-Coat_of_Arms_of_Kokhma_%28Ivanovo_oblast%29.webp
496	Красавино	/public/cities/25px-Krasavino_COA.webp
497	Красноармейск (Московская область)	/public/cities/25px-Coat_of_Arms_of_Krasnoarmeisk_%28Moscow_oblast%29.webp
498	Красноармейск (Саратовская область)	/public/cities/25px-Coat_of_Arms_of_Krasnoarmeysk_%28Saratov_oblast%29.webp
499	Красновишерск	/public/cities/25px-Krasnovishersk_COA_%282000%29.webp
500	Красногорск	/public/cities/25px-Coat_of_arms_of_Krasnogorsky_rayon_%28Moscow_oblast%29.webp
501	Краснодар	/public/cities/25px-Coat_of_Arms_of_Krasnodar_%28Krasnodar_krai%29.webp
502	Краснодон	/public/krasnodon.webp
503	Краснозаводск	/public/cities/25px-Coat_of_Arms_of_Krasnozavodsk_%28Moscow_oblast%29.webp
504	Краснознаменск (Калининградская область)	/public/cities/25px-Coat_of_Arms_of_Krasnoznamensk_%28Kaliningrad_oblast%29.webp
505	Краснознаменск (Московская область)	/public/cities/25px-Coat_of_Arms_of_Krasnoznamensk_%28Moscow_oblast%29.webp
506	Краснокаменск	/public/cities/25px-Coat_of_Arms_of_Krasnokamensk_%28Chita_oblast%29.webp
507	Краснокамск	/public/cities/25px-Krasnokamsk_COA_%282008%29.webp
508	Красноперекопск	/public/cities/25px-Gerb_of_Krasnoperekopsk.webp
509	Краснослободск (Волгоградская область)	/public/cities/25px-Coat_of_arms_of_Krasnoslobodsk%2C_Volgograd_Oblast_%282010%29.webp
510	Краснослободск (Мордовия)	/public/cities/25px-Coat_of_arms_of_Krasnoslobodsk_%282012%29.webp
511	Краснотурьинск	/public/cities/25px-Coat_of_Arms_of_Krasnoturinsk_%28Sverdlovsk_oblast%29.webp
512	Красноуральск	/public/cities/25px-Coat_of_Arms_of_Krasnouralsk_%28Sverdlovsk_oblast%29.webp
513	Красноуфимск	/public/cities/25px-Coat_of_Arms_of_Krasnoufimsk_%28Sverdlovsk_oblast%29.webp
514	Красноярск	/public/cities/25px-Coat_of_Arms_of_Krasnoyarsk_%28Krasnoyarsk_krai%29.svg.webp
515	Красный Кут	/public/cities/25px-Coat_of_Arms_of_Krasnokutsky_rayon_%28Saratov_oblast%29.webp
516	Красный Луч	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
517	Красный Сулин	/public/cities/25px-Coat_of_Arms_of_Krasny_Sulin.webp
518	Красный Холм	/public/cities/25px-Coat_of_Arms_of_Krasny_Kholm_%28Tver_oblast%29.webp
519	Кремёнки	/public/cities/25px-Coat_of_Arms_of_Kremenki_%28Kaluga_oblast%29.webp
520	Кременная	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
521	Кропоткин	/public/cities/25px-Coat_of_Arms_of_Kropotkin_%28Krasnodar_krai%29.webp
522	Крымск	/public/cities/25px-Coat_of_Arms_of_Krymsk_%28Krasnodar_krai%2C_2007%29.webp
523	Кстово	/public/cities/25px-Coat_of_Arms_of_Kstovo_%28Nizhny_Novgorod_oblast%29.webp
524	Кубинка	/public/cities/25px-Coat_of_Arms_of_Kubinka.webp
525	Кувандык	/public/cities/25px-Coat_of_Arms_of_Kuvandyk_%28Orenburg_oblast%29.webp
526	Кувшиново	/public/cities/25px-Coat_of_Arms_of_Kuvshinovo_%28Tver_oblast%29.webp
527	Кудрово	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
528	Кудымкар	/public/cities/25px-Kudymkar_COA_%282008%29.webp
529	Кузнецк	/public/cities/25px-Coat_of_Arms_of_Kuznetsk_%28Penza_oblast%29.webp
530	Куйбышев	/public/cities/25px-RUS_%D0%9A%D1%83%D0%B9%D0%B1%D1%8B%D1%88%D0%B5%D0%B2_COA.webp
531	Кукмор	/public/cities/25px-Gerb-Kukmorsky-region.webp
532	Кулебаки	/public/cities/25px-Coat_of_Arms_of_Kulebaki_1997_%28Nizhny_Novgorod_oblast%29.webp
667	Назрань	/public/cities/25px-Coat_of_Arms_of_Nazran.svg.webp
533	Кумертау	/public/cities/25px-Coat_of_Arms_of_Kumertau_%28Bashkortostan%29.webp
534	Кунгур	/public/cities/25px-Kungur_COA_%281994%29.webp
535	Купино	/public/cities/25px-Kupino_COA_%282011%29.webp
536	Курган	/public/cities/25px-Kurgan_coat_of_arms.webp
537	Курганинск	/public/cities/25px-Coat_of_Arms_of_Kurganinsk_%28Krasnodar_krai%29.webp
538	Курильск	/public/cities/25px-Coat_of_Arms_of_Kurilsk_%28Sakhalin_oblast%29.webp
539	Курлово	/public/cities/25px-Coat_of_Arms_of_Kurlovo_%28Vladimir_oblast%29.webp
540	Куровское	/public/cities/25px-Coat_of_Arms_of_Kurovskoye_%28Moscow_oblast%29.webp
541	Курск	/public/cities/25px-Coat_of_Arms_of_Kursk.webp
542	Куртамыш	/public/cities/25px-COA_of_Kurtamysh.webp
543	Курчалой	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
544	Курчатов	/public/cities/25px-Coat_of_Arms_of_Kurchatov_%28Kursk_oblast%29.webp
545	Куса	/public/cities/25px-Coat_of_Arms_of_Kusa_%28Chelyabinsk_oblast%29.webp
546	Кушва	/public/cities/25px-Coat_of_Arms_of_Kushva_%28Sverdlovsk_oblast%29.webp
547	Кызыл	/public/cities/25px-Kyzyl_COA_%282016%29.webp
548	Кыштым	/public/cities/25px-Coat_of_Arms_of_Kyshtym_%28Chelyabinsk_oblast%29.webp
549	Кяхта	/public/cities/25px-Coat_of_Arms_of_Kyakhta_%28Buryatia%29_%281861%29.webp
550	Лабинск	/public/cities/25px-Coat_of_Labinsk.webp
551	Лабытнанги	/public/cities/25px-Coat_of_Arms_of_Labytnangi_%28Yamal_Nenetsia%29.webp
552	Лагань	/public/cities/25px-Lagan.webp
553	Ладушкин	/public/cities/25px-Coat_of_Arms_of_Ladushkin_%28Kaliningrad_oblast%29.webp
554	Лаишево	/public/cities/25px-Laishev_COA_%28Kazan_Governorate%29_%281781%29.webp
555	Лакинск	/public/cities/25px-Coat_of_Arms_of_Lakinsk_%28Vladimir_oblast%29.webp
556	Лангепас	/public/cities/25px-Coat_of_Arms_of_Langepas.svg.webp
557	Лахденпохья	/public/cities/25px-Coat_of_Arms_of_Lakhdenpokhsky_District.svg.webp
558	Лебедянь	/public/cities/25px-Coat_of_Arms_of_Lebedyan_%28Lipetsk_oblast%29.webp
559	Лениногорск	/public/cities/25px-Coat_of_Arms_of_Leninogorsk_%28Tatarstan%29.webp
560	Ленинск	/public/cities/25px-Coat_of_arms_of_Leninsk.webp
561	Ленинск-Кузнецкий	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1%D0%9B%D0%B5%D0%BD%D0%B8%D0%BD%D1%81%D0%BA-%D0%9A%D1%83%D0%B7%D0%BD%D0%B5%D1%86%D0%BA%D0%B8%D0%B9.webp
562	Ленск	/public/cities/25px-Coat_of_Arms_of_Lensk_%28Yakutia%29.webp
563	Лермонтов	/public/cities/25px-Coat_of_Arms_of_Lermontov.webp
564	Лесной	/public/cities/25px-Coat_of_Arms_of_Lesnoy_%28Sverdlovsk_oblast%29.webp
565	Лесозаводск	/public/cities/25px-Coat_of_Arms_of_Lesozavodsk_%28Primorsky_kray%29_%282006%29.webp
566	Лесосибирск	/public/cities/25px-Coat_of_Arms_of_Lesosibirsk_%28Krasnoyarsk_krai%29.webp
567	Ливны	/public/cities/25px-Coat_of_arms_of_Livny.webp
568	Ликино-Дулёво	/public/cities/25px-Coat_of_Arms_of_Orekhovo-Zuevo_rayon_%28Moscow_oblast%29.webp
569	Липецк	/public/cities/25px-Gerb_lip.webp
570	Липки	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
571	Лисичанск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
572	Лиски	/public/cities/25px-Coat_of_arms_of_Liski_%281997%29.webp
573	Лихославль	/public/cities/25px-Coat_of_Arms_of_Likhoslavl_%28Tver_oblast%29.webp
574	Лобня	/public/cities/25px-Coat_of_Arms_of_Lobnya_%28Moscow_oblast%29.webp
575	Лодейное Поле	/public/cities/25px-Coat_of_Arms_of_Lodeinoe_Pole_%28Leningrad_oblast%29.webp
576	Лосино-Петровский	/public/cities/25px-Coat_of_Arms_of_Losino-Petrovsky_%28Moscow_oblast%29.webp
577	Луга	/public/cities/25px-Coat_of_Arms_of_Luga_%28Leningrad_oblast%29.webp
578	Луганск	/public/cities/
579	Луза	/public/cities/25px-Coat_of_Arms_of_Luzsky_district.webp
580	Лукоянов	/public/cities/25px-Lukoyanov_COA_%28Nizhny_Novgorod_Governorate%29_%281781%29.webp
581	Лутугино	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
582	Луховицы	/public/cities/25px-Coat_of_Arms_of_Lukhovitsy_%28Moscow_oblast%29.webp
583	Лысково	/public/cities/25px-Lyskovo_COA_%282006%29.webp
584	Лысьва	/public/cities/25px-Coat_of_Arms_of_Lysva_%28Perm_krai%29.webp
585	Лыткарино	/public/cities/25px-Coat_of_Arms_of_Lytkarino_%28Moscow_oblast%29.webp
586	Льгов	/public/cities/25px-Lgov_COA_%28Kursk_Governorate%29_%281780%29.webp
587	Любань	/public/cities/25px-Coat_of_arms_of_Luban.webp
588	Люберцы	/public/cities/25px-Coat_of_arms_of_Lyubertsy_district.webp
589	Любим	/public/cities/25px-Coat_of_arms_of_Lyubim_%282005%29.webp
590	Людиново	/public/cities/25px-Coat_of_Arms_of_Lyudinovo_town_%28Kaluga_oblast%29.webp
591	Лянтор	/public/cities/25px-Lyantor_COA_%282006%29.webp
592	Магадан	/public/cities/25px-COA_Magadan%2C_Russian_Federation.svg.webp
593	Магас	/public/cities/25px-Coat_of_arms_of_Magas_%28Ingushetia%29.webp
594	Магнитогорск	/public/cities/25px-Coat_of_Arms_of_Magnitogorsk_%28Chelyabinsk_oblast%29.webp
595	Майкоп	/public/cities/25px-Coat_of_arms_of_Maykop.svg.webp
596	Майский	/public/cities/25px-Coats_of_arms_of_Mayskiy_%28Kabardino-Balkaria%29.webp
597	Макаров	/public/cities/25px-Coat_of_Arms_of_Makarov_%28Sakhalinskaya_oblast%29_2013.webp
598	Макарьев	/public/cities/25px-Coat_of_Arms_of_Makariev_%28Kostroma_oblast%29.webp
599	Макеевка	/public/cities/makeevka.webp
600	Макушино	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9C%D0%B0%D0%BA%D1%83%D1%88%D0%B8%D0%BD%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD%D0%B0.webp
601	Малая Вишера	/public/cities/25px-Coat_of_arms_of_Malaya_Vishera.svg.webp
602	Малгобек	/public/cities/25px-Coat_of_Arms_of_Malgobek.webp
603	Малмыж	/public/cities/25px-Coat_of_Arms_of_Malmyzh.webp
604	Малоархангельск	/public/cities/25px-Maloarkhangelsk_COA_%28Oryol_Governorate%29_%281781%29.webp
605	Малоярославец	/public/cities/25px-Coat_of_Arms_of_Maloyaroslavets_%28Kaluga_region%29.svg.webp
606	Мамадыш	/public/cities/25px-Mamadysh_COA_%28Kazan_Governorate%29_%281781%29.webp
607	Мамоново	/public/cities/25px-Coat_of_Arms_of_Mamonovo_%28Kaliningrad_oblast%29.webp
608	Мантурово	/public/cities/25px-Coat_of_Arms_of_Manturovo_%28Kostroma_oblast%29_coat_fof_arms.webp
609	Мариинск	/public/cities/25px-Mariinsk-herb.webp
610	Мариинский Посад	/public/cities/25px-Coat_of_Arms_of_Mariinsky_Posad_%28Chuvashia%29.webp
611	Мариуполь	/public/cities/mariupol.webp
612	Маркс	/public/cities/25px-Coat_of_Arms_of_Marks_%28Saratov_oblast%29.webp
613	Махачкала	/public/cities/25px-Coat_of_Arms_of_Makhachkala.webp
614	Мглин	/public/cities/25px-Mglin_COA_%28Chernigov_Governorate%29_%281782%29.webp
615	Мегион	/public/cities/25px-Coat_of_Arms_of_Megion.svg.webp
616	Медвежьегорск	/public/cities/25px-Coat_of_Arms_of_Medvezhyegorsky_District.svg.webp
617	Медногорск	/public/cities/25px-Mednogorsk_COA_%282008%29.webp
618	Медынь	/public/cities/25px-Medyn_COA_%282006%29.webp
619	Межгорье	/public/cities/25px-Coat_of_Arms_of_Mezhgorie_%28Bashkortostan%29.webp
620	Междуреченск	/public/cities/25px-Coat_of_Arms_of_Mezhdurechensk_%28Kemerovo_oblast%29.webp
621	Мезень	/public/cities/25px-Mezen_COA_%28Vologda_Governorate%29_%281780%29.webp
622	Меленки	/public/cities/25px-Coat_of_Arms_of_Melenki.webp
623	Мелеуз	/public/cities/25px-Meleuz.webp
624	Мелитополь	/public/cities/melitopol.webp
625	Менделеевск	/public/cities/25px-Coat_of_Arms_of_Mendeleyevsk_%28Tatarstan%29.webp
626	Мензелинск	/public/cities/25px-Coat_of_Arms_of_Menzelinsk_%28Tatarstan%29.webp
627	Мещовск	/public/cities/25px-Coat_of_Arms_of_Meshchovsk_%28Kaluga_oblast%29.webp
628	Миасс	/public/cities/25px-Coat_of_Arms_of_Miass_%28Chelyabinsk_oblast%29_%282002%29.webp
629	Микунь	/public/cities/25px-%D0%95%D0%BC%D0%B4%D1%96%D0%BD_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD_%D0%BF%D0%B0%D1%81.webp
630	Миллерово	/public/cities/25px-COA_of_Millerovsky_rayon_%28Rostov_oblast%29.webp
631	Минеральные Воды	/public/cities/25px-Coat_of_Arms_of_Caucasian_Mineral_Waters_region_%28Stavropol_Kray%29.webp
632	Минусинск	/public/cities/25px-Coat_of_Arms_of_Minusinsk_%281854%29.webp
633	Миньяр	/public/cities/25px-Coat_of_Arms_of_Minyar_%28Chelyabinsk_oblast%29.webp
634	Мирный (Якутия)	/public/cities/25px-Coat_of_Arms_of_Mirny_%28Yakutia%29_%282004%29.webp
635	Мирный (Архангельская область)	/public/cities/25px-Coat_of_Arms_of_Mirny_%28Arkhangelsk_oblast%29.webp
636	Миусинск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
637	Михайлов	/public/cities/25px-Coat_of_Arms_of_Mikhailovo_rayon_%28Ryazan_oblast%29.webp
638	Михайловка	/public/cities/25px-Coat_of_Arms_of_Mikhaylovka_%28Volgograd_Oblast%29_2009.webp
639	Михайловск (Свердловская область)	/public/cities/25px-Coat_of_Arms_of_Mikhailovsk_%28Sverdlovsk_oblast%29.webp
640	Михайловск (Ставропольский край)	/public/cities/25px-Coat_of_Arms_of_Mihaylovsk_%28SK%29.webp
641	Мичуринск	/public/cities/25px-Coat_of_Arms_of_Michurinsk_%28Tambov_oblast%29.webp
642	Могоча	/public/cities/25px-Mogochinsky_rayon_COA_%282015%29.webp
643	Можайск	/public/cities/25px-Mozhaysk_COA_%282007%29.webp
644	Можга	/public/cities/25px-Coat_of_Arms_of_Mozhga_%28Udmurtia%29_%281980%29.webp
645	Моздок	/public/cities/25px-Coat_of_Arms_of_Mozdok_%28North_Ossetia%29.webp
646	Молодогвардейск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
647	Молочанск	/public/cities/zaporozhskaya_oblast.webp
648	Мончегорск	/public/cities/25px-Coat_of_Arms_of_Monchegorsk_%28Murmansk_oblast%29.webp
649	Морозовск	/public/cities/25px-Coat_of_Arms_of_Morozovsk_%28Rostov_oblast%29.webp
650	Моршанск	/public/cities/25px-Coat_of_Arms_of_Morshansk_%28Tambov_oblast%29_%282012%29.webp
651	Мосальск	/public/cities/25px-Coat_of_Arms_of_Mosalsk_%28Kaluga_oblast%29.webp
652	Москва	/public/cities/25px-Coat_of_arms_of_Moscow.svg.webp
653	Муравленко	/public/cities/25px-Coat_of_Arms_of_Muravlenko_%28Yamal_Nenetsia%29.webp
654	Мураши	/public/cities/25px-Coat_of_Arms_of_Murashinsky_district_%28Kirov_oblast%29.webp
655	Мурино	/public/cities/25px-Murino_gerb.webp
656	Мурманск	/public/cities/25px-RUS_Murmansk_COA.svg.webp
657	Муром	/public/cities/25px-Murom_COA_%28Vladimir_Governorate%29_%281781%29.webp
658	Мценск	/public/cities/25px-Coat_of_Arms_of_Mtsensk_%282011%29.webp
659	Мыски	/public/cities/25px-Myski_COA_%282012%29.webp
660	Мытищи	/public/cities/25px-Coat_of_Arms_of_Mytishchi_rural_settlement_%28Moscow_Oblast%29.webp
661	Мышкин	/public/cities/25px-Myshkin_COA_%28Yaroslavl_Governorate%29_%281778%29.webp
662	Набережные Челны	/public/cities/25px-Coat_of_Arms_of_Naberezhnye_Chelny_%28Tatarstan%29.svg.webp
663	Навашино	/public/cities/25px-Navashino_COA_%282020%29.webp
664	Наволоки	/public/cities/25px-Coat_of_Arms_of_Navoloki_%28Ivanovo_oblast%29.webp
665	Надым	/public/cities/25px-Coat_of_Arms_of_Nadym_and_Nadymsky_rayon_%28Yamal_Nenetsia%29.webp
666	Назарово	/public/cities/25px-Coat_of_Arms_of_Nazarovo_%28Krasnoyarsk_krai%29.webp
668	Называевск	/public/cities/25px-%D0%9D%D0%B0%D0%B7%D1%8B%D0%B2%D0%B0%D0%B5%D0%B2%D1%81%D0%BA%D0%B8%D0%B9_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD_2.webp
669	Нальчик	/public/cities/25px-Coat_of_Arms_of_Nalchik_since_2011.webp
670	Нариманов	/public/cities/25px-Narimanov_rayon_COA.webp
671	Наро-Фоминск	/public/cities/25px-Naro-Fominsk_COA_%282018%29.webp
672	Нарткала	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
673	Нарьян-Мар	/public/cities/25px-Coat_of_Arms_of_Naryan-Mar.webp
674	Находка	/public/cities/25px-Coat_of_Arms_of_Nakhodka_%28Primorsky_kray%29.webp
675	Невель	/public/cities/25px-Coat_of_Arms_of_Nevel_%28Pskov_oblast%29.webp
676	Невельск	/public/cities/25px-Coat_of_Arms_of_Nevelsk_%28Sakhalin_oblast%29.webp
677	Невинномысск	/public/cities/25px-Coat_of_Arms_of_Nevinnomysk_%28Stavropol_kray%29.webp
678	Невьянск	/public/cities/25px-Coat_of_Arms_of_Nevyansk_%28Sverdlovsk_oblast%29.webp
679	Нелидово	/public/cities/25px-Coat_of_Arms_of_Nelidovo_%28Tver_oblast%29.webp
680	Неман	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1-%D0%9D%D0%B5%D0%BC%D0%B0%D0%BD%D0%B0.svg.webp
681	Нерехта	/public/cities/25px-Coat_of_Arms_of_Nerekhta_%28Kostroma_oblast%29.webp
682	Нерчинск	/public/cities/25px-Coat_of_Arms_of_Nerchinsk_%28Chita_oblast%29_%281790%29.webp
683	Нерюнгри	/public/cities/25px-Coat_of_Arms_of_Neryungri_%28Yakutia%29.webp
684	Нестеров	/public/cities/25px-Gerb_nesterov.webp
685	Нефтегорск	/public/cities/25px-63neftegorsk_g.webp
686	Нефтекамск	/public/cities/25px-Coat_of_Arms_of_Neftekamsk_%28Bashkortostan%29.webp
687	Нефтекумск	/public/cities/25px-Coat_of_arms_of_Neftekumsky_district_%282006%29.webp
688	Нефтеюганск	/public/cities/25px-Coat_of_Arms_of_Nefteyugansk.webp
689	Нея	/public/cities/25px-Coat_of_Arms_of_Neya_%28Kostroma_oblast%29.webp
690	Нижневартовск	/public/cities/25px-Coat_of_Arms_of_Nizhnevartovsk.svg.webp
691	Нижнекамск	/public/cities/25px-Coat_of_Arms_of_Nizhnekamsk_rayon_%28Tatarstan%29.webp
692	Нижнеудинск	/public/cities/25px-Nizhneudinsk_COA_%282019%29.webp
693	Нижние Серги	/public/cities/25px-Coat_of_Arms_of_Nizhnie_Sergi_%28Sverdlovsk_oblast%29.webp
694	Нижний Ломов	/public/cities/25px-Coat_of_Arms_of_Nizhny_Lomov_%28Penza_oblast%29.webp
695	Нижний Новгород	/public/cities/25px-Small_Coat_of_arms_Nizhny_Novgorod.svg.webp
696	Нижний Тагил	/public/cities/25px-Coat_of_Arms_of_Nizhny_Tagil_%28Sverdlovsk_oblast%29.webp
697	Нижняя Салда	/public/cities/25px-Coat_of_Arms_of_Nizhnyaya_Salda_%28Sverdlovsk_oblast%29.webp
698	Нижняя Тура	/public/cities/25px-Coat_of_Arms_of_Nizhnyaya_Tura_%28Sverdlovsk_oblast%29.webp
699	Николаевск	/public/cities/25px-Coat_of_arms_of_Nikolayevsky_district_2007_02.webp
700	Николаевск-на-Амуре	/public/cities/25px-Coat_of_Arms_of_Nikolaevsk-na-Amure_%28Khabarovsk_kray%29_%282002%29.webp
701	Никольск (Вологодская область)	/public/cities/25px-Coat_of_Arms_of_Nikolsk_%28Vologda_oblast%29.webp
702	Никольск (Пензенская область)	/public/cities/25px-Coat_of_Arms_of_Nikolsk_%28Penza_oblast%29.webp
703	Никольское	/public/cities/25px-Coat_of_arms_of_Nikolskoe_%28Tosno%29.webp
704	Новая Каховка	/public/cities/kherson_obl.webp
705	Новая Ладога	/public/cities/25px-Coat_of_Arms_of_Novaya_Ladoga_%28Leningrad_oblast%29_-_2.webp
706	Новая Ляля	/public/cities/25px-Novolyalinsky_GO_COA.webp
707	Новоалександровск	/public/cities/25px-Coat_of_Arms_of_Novoaleksandrovsk_%28Stavropol_kray%29.webp
708	Новоалтайск	/public/cities/25px-Novoaltaisk_Coat_of_Arms.webp
709	Новоаннинский	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
710	Нововоронеж	/public/cities/25px-Coat_of_Arms_of_Novovoronezh_%28Voronezh_oblast%29.webp
711	Новодвинск	/public/cities/25px-Coat_of_arms_of_Novodvinsk.webp
712	Новодружеск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
713	Новозыбков	/public/cities/25px-Coat_of_Arms_of_Novozybkov.webp
714	Новокубанск	/public/cities/25px-Coat_of_Arms_of_Novokubansk_%28Krasnodar_krai%29.webp
715	Новокузнецк	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9D%D0%BE%D0%B2%D0%BE%D0%BA%D1%83%D0%B7%D0%BD%D0%B5%D1%86%D0%BA%D0%B0_2018.webp
716	Новокуйбышевск	/public/cities/25px-Coat_of_arms_of_Novokuybyshevsk.webp
717	Новомичуринск	/public/cities/25px-Coat_of_arms_of_Novomichurinsk_%28Ryazan_oblast%29.webp
718	Новомосковск	/public/cities/25px-Coat_of_Arms_of_Novomoskovsk_%28Tula_oblast%29.webp
719	Новопавловск	/public/cities/25px-Coat_of_Arms_of_Novopavlovsk.webp
720	Новоржев	/public/cities/25px-Novorzhev_COA_%282001%29.webp
721	Новороссийск	/public/cities/25px-Coat_of_Arms_of_Novorossiysk_%28Krasnodar_kray%29_%282006%29.webp
722	Новосибирск	/public/cities/25px-Coat_of_Arms_of_Novosibirsk.svg.webp
723	Новосиль	/public/cities/25px-Coat_of_arms_of_Novosil_%282010%29.webp
724	Новосокольники	/public/cities/25px-Coat_of_Arms_of_Novosokolniki_%28Pskov_oblast%29.webp
725	Новотроицк	/public/cities/25px-Coat_of_Arms_of_Novotroitsk_%28Orenburg_oblast%29.webp
726	Новоузенск	/public/cities/25px-Coat_of_Arms_of_Novouzensk_%28Saratov_oblast%29.webp
727	Новоульяновск	/public/cities/25px-Coat_of_arms_of_Novoulyanovsk.webp
728	Новоуральск	/public/cities/25px-Novouralsk_COA_%282010%29.webp
729	Новохопёрск	/public/cities/25px-Coat_of_arms_of_Novohopersk_%282008%29.webp
730	Новочебоксарск	/public/cities/25px-Coat_of_Arms_of_Novocheboksarsk_%28Chuvashia%29.svg.webp
731	Новочеркасск	/public/cities/25px-Novocherkassk_COA_%282008%29.webp
732	Новошахтинск	/public/cities/25px-Coat_of_Arms_of_Novoshakhtinsk_%28Rostov_oblast%29.webp
733	Новый Оскол	/public/cities/25px-Coat_of_Arms_of_Novy_Oskol_%28Belgorod_oblsat%29.webp
734	Новый Уренгой	/public/cities/25px-Coat_of_Arms_of_Novy_Urengoy_%28Yamal_Nenetsia%29.webp
735	Ногинск	/public/cities/25px-Coat_of_Arms_of_Noginsky_rayon_%28Moscow_oblast%29.svg.webp
736	Нолинск	/public/cities/25px-Nolinsk_COA_%282018%29.webp
737	Норильск	/public/cities/25px-Coat_of_arms_of_Norilsk%2C_Krasnoyarsk_Krai.svg.webp
738	Ноябрьск	/public/cities/25px-Coat_of_Arms_of_Noyabrsk_%28Yamal_Nenetsia%29.webp
739	Нурлат	/public/cities/25px-NurlatCoa2006.webp
740	Нытва	/public/cities/25px-Nytva_COA_%282007%29.webp
741	Нюрба	/public/cities/25px-Nyurba_COA_%282016%29.webp
742	Нягань	/public/cities/25px-Nyagan_COA_%282009%29.webp
743	Нязепетровск	/public/cities/25px-Coat_of_Arms_of_Nyazepetrovsk_%28Chelyabinsk_oblast%29.webp
744	Няндома	/public/cities/25px-Coat_of_Arms_of_Nyandoma_city_%28Arkhangelsk_oblast%29.webp
745	Облучье	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9E%D0%B1%D0%BB%D1%83%D1%87%D0%B5%D0%BD%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD%D0%B0.webp
746	Обнинск	/public/cities/25px-Coat_of_Arms_of_Obninsk_%28Kaluga_oblast%29_proposal_%282003_N2%29.webp
747	Обоянь	/public/cities/25px-Oboyan_COA_%282020%29.webp
748	Обь	/public/cities/25px-Ob_COA_%282004%29.webp
749	Одинцово	/public/cities/25px-Odintsovo_COA_%282019%29.webp
750	Озёрск (Калининградская область)	/public/cities/25px-Coat_of_Arms_of_Ozyorsk_%28Kaliningrad_oblast%29.webp
751	Озёрск (Челябинская область)	/public/cities/25px-Coat_of_Arms_of_Ozyorsk_%28Chelyabinsk_oblast%29.svg.webp
752	Озёры	/public/cities/25px-Coat_of_Arms_of_Ozyory_rayon_%28Moscow_oblast%29.webp
753	Октябрьск	/public/cities/25px-Coat_of_Arms_of_Oktyabrsk_%28Samara_oblast%29.webp
754	Октябрьский	/public/cities/25px-Coat_of_Arms_of_Oktyabrsky_%28Bashkortostan%29.webp
755	Окуловка	/public/cities/25px-Okulov.webp
756	Олёкминск	/public/cities/25px-Olyokminsk_city_coa.webp
757	Оленегорск	/public/cities/25px-Coat_of_Arms_of_Olenegorsk_%28Murmansk_oblast%29.webp
758	Олонец	/public/cities/25px-Olonets_COA_%28Olonets_Governorate%29_%281781%29.webp
759	Омск	/public/cities/25px-Omsk_coat_of_arms_2014.webp
760	Омутнинск	/public/cities/25px-Coat_of_Arms_of_Omutninsk.webp
761	Онега	/public/cities/25px-Coat_of_Arms_of_Onega_%28Arkhangelsk_oblast%29_%281998%29.webp
762	Опочка	/public/cities/25px-Opochka_city_coa_n7839.webp
763	Орёл	/public/cities/25px-Coat_of_arms_of_Oryol.svg.webp
764	Оренбург	/public/cities/25px-Coat_of_Arms_of_Orenburg.webp
765	Орехов	/public/cities/zaporozhskaya_oblast.webp
766	Орехово-Зуево	/public/cities/25px-Coat_of_Arms_of_Orekhovo-Zuevo_%28Moscow_oblast%29.webp
767	Орлов	/public/cities/25px-Orlov_COA_%28Vyatka_Governorate%29_%281781%29.webp
768	Орск	/public/cities/25px-Orsk_COA_%282008%29.webp
769	Оса	/public/cities/25px-Osa_COA_%282008%29.webp
770	Осинники	/public/cities/25px-Osinniki_COA_%282019%29.webp
771	Осташков	/public/cities/25px-Ostashkov_COA.webp
772	Остров	/public/cities/25px-Coat_of_Arms_of_Ostrov_%28Pskov_oblast%29.webp
773	Островной	/public/cities/25px-Ostrovnoj_gerb.webp
774	Острогожск	/public/cities/25px-Coat_of_Arms_of_Ostrogozhsk_%28Voronezh_oblast%29.webp
775	Отрадное	/public/cities/25px-Coat_of_Arms_of_Otradnoe_%28Leningrad_oblast%29.webp
776	Отрадный	/public/cities/25px-Blason_Otradny.webp
777	Оха	/public/cities/25px-Coat_of_Arms_of_Okha_%28Sakhalin_oblast%29.webp
778	Оханск	/public/cities/25px-Coat_of_Arms_of_Okhansk_%28Perm_krai%29_%282009%29.webp
779	Очёр	/public/cities/25px-Ochyor_COA_%282011%29.webp
780	Павлово	/public/cities/25px-Coat_of_Arms_of_Pavlovo_%28Nizhny_Novgorod_oblast%29.webp
781	Павловск	/public/cities/25px-Coat_of_Arms_of_Pavlovsk_%28Voronezh_oblast%29.webp
782	Павловский Посад	/public/cities/25px-Coat_of_Arms_of_Pavlovsky_Posad_%28Moscow_oblast%29_%282002%29.webp
783	Палласовка	/public/cities/25px-Coat_of_arms_of_Pallasovka_2008_%28official%29.webp
784	Партизанск	/public/cities/25px-Partizansk_COA_%282008%29.webp
785	Певек	/public/cities/25px-Pevek_COA_%282002%29.webp
786	Пенза	/public/cities/25px-Coat_of_Arms_of_Penza_%28Penza_oblast%29_%282001%29.webp
787	Первомайск (Нижегородская область)	/public/cities/25px-Pervomaysk_%28Tashino%29_COA_%282016%29.webp
788	Первомайск (ЛНР)	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
789	Первоуральск	/public/cities/25px-Coat_of_Arms_of_Pervouralsk_%28Sverdlovsk_oblast%29.webp
790	Перевальск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
791	Перевоз	/public/cities/25px-Perevoz_COA_%282019%29.webp
792	Пересвет	/public/cities/25px-Coat_of_Arms_of_Peresvet_%28Moscow_oblast%29.svg.webp
793	Переславль-Залесский	/public/cities/25px-Coat_of_Arms_of_Pereslavl-Zalessky_%28Yaroslavl_oblast%29.webp
794	Пермь	/public/cities/25px-Coat_of_Arms_of_Perm.svg.webp
795	Пестово	/public/cities/25px-%D0%9F%D0%B5%D1%81%D1%82%D0%BE%D0%B2%D0%BE%2C_%D0%9D%D0%BE%D0%B2%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D1%81%D0%BA%D0%B0%D1%8F_%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C.webp
796	Петров Вал	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
797	Петровск	/public/cities/25px-Coat_of_Arms_of_Petrovsk_%28Saratov_oblast%29.webp
929	Симферополь	/public/cities/25px-COA_Simferopol.svg.webp
798	Петровск-Забайкальский	/public/cities/25px-Coat_of_Arms_of_Petrovsk-Zabaikalsky_%28Chita_oblast%29_%281984%29.webp
799	Петровское	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
800	Петрозаводск	/public/cities/25px-Coat_of_Arms_of_Petrozavodsk_%28Karelia%29.webp
801	Петропавловск-Камчатский	/public/cities/25px-Gerb_Petropavlovsk-Kamchatsky.webp
802	Петухово	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9F%D0%B5%D1%82%D1%83%D1%85%D0%BE%D0%B2%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD%D0%B0.webp
803	Петушки	/public/cities/25px-Coat_of_Arms_of_Petushki_%28Vladimir_oblast%29.webp
804	Печора	/public/cities/25px-Coat_of_Arms_of_Pechora_%28Komia%29_%281983%29.webp
805	Печоры	/public/cities/25px-Coat_of_Arms_of_Pechory_%28Pskov_oblast%29.webp
806	Пикалёво	/public/cities/25px-Coat_of_Arms_of_Pikalyovo_%28Leningrad_oblast%29.webp
807	Пионерский	/public/cities/25px-Pionersky_COA_%282016%29.webp
808	Питкяранта	/public/cities/25px-Coat_of_arms_of_Pitkyaranta_%282016%29.webp
809	Плавск	/public/cities/25px-Gerb-Plavsky-region.webp
810	Пласт	/public/cities/25px-Coat_of_Arms_of_Plast_%28Chelyabinsk_oblast%29.webp
811	Плёс	/public/cities/25px-Coat_of_Arms_of_Plyos_%28Ivanovo_oblast%29_%281779%29.webp
812	Поворино	/public/cities/25px-Coat_of_Arms_of_Povorino_%28Voronezh_oblast%29.webp
813	Подольск	/public/cities/25px-Coat_of_Arms_of_Podolsk_%28Moscow_oblast%29.svg.webp
814	Подпорожье	/public/cities/25px-Podporozhie_COA_%282010%29.webp
815	Покачи	/public/cities/25px-Pokachi_COA_%282013%29.webp
816	Покров	/public/cities/25px-Pokrov_COA_%28Vladimir_Governorate%29_%281781%29.webp
817	Покровск	/public/cities/25px-Coat_of_Arms_of_Pokrovsk_%28Yakutia%29.webp
818	Полевской	/public/cities/25px-Coat_of_Arms_of_Polevskoy.svg.webp
819	Полесск	/public/cities/25px-Polessk_COA_%282008%29.webp
820	Пологи	/public/cities/zaporozhskaya_oblast.webp
821	Полысаево	/public/cities/25px-Coat_of_Arms_of_Polysaevo_%28Kemerovo_oblast%29.webp
822	Полярные Зори	/public/cities/25px-Coat_of_Arms_of_Polyarnye_Zori_%28Murmansk_oblast%29_%281995%29.webp
823	Полярный	/public/cities/25px-Coat_of_Arms_of_Polyarny_%28Murmansk_oblast%29.webp
824	Попасная	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
825	Поронайск	/public/cities/25px-Coat_of_Arms_of_Poronaysk_%28Sakhalinskaya_oblast%29.webp
826	Порхов	/public/cities/25px-Porkhov_COA_%28Pskov_Governorate%29_%281781%29.webp
827	Похвистнево	/public/cities/25px-Coat_of_Arms_of_Pokhvistnevo_%28Samara_oblast%29.webp
828	Почеп	/public/cities/25px-Coat_of_arms_of_Pochep_%281984%29.webp
829	Починок	/public/cities/25px-Pochinkovskiy_rayon_COA_%282010%29.webp
830	Пошехонье	/public/cities/25px-Poshekhonye_COA_%28Yaroslavl_Governorate%29_%281778%29.webp
831	Правдинск	/public/cities/25px-Pravdinsk_COA_%282007%29.webp
832	Приволжск	/public/cities/25px-Coat_of_Arms_of_Privolzsk_%282011%29.webp
833	Приволье	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
834	Приморск (Калининградская область)	/public/cities/25px-Primorsk_COA.webp
835	Приморск (Ленинградская область)	/public/cities/25px-Coat_of_Arms_of_Primorsk_%28Leningrad_oblast%29_%282007%29.webp
836	Приморск (Запорожская область)	/public/cities/zaporozhskaya_oblast.webp
837	Приморско-Ахтарск	/public/cities/25px-Coat_of_Arms_of_Primorsko-Akhtarsk_%28Krasnodar_krai%29.webp
838	Приозерск	/public/cities/25px-Coat_of_Arms_of_Priozersk_%28Kexholm%29_%28Vyborg_Governorate%29_%281788%29.webp
839	Прокопьевск	/public/cities/25px-Prokopievsk_COA_2020.webp
840	Пролетарск	/public/cities/25px-Coat_of_Arms_of_Proletarsk_rayon_%28Rostov_oblast%29.webp
841	Протвино	/public/cities/25px-Coat_of_Arms_of_Protvino_%28Moscow_oblast%29.webp
842	Прохладный	/public/cities/25px-Coats_of_arms_of_Prokhladny_%28Kabardino-Balkaria%29.webp
843	Псков	/public/cities/25px-Pskovgfull.svg.webp
844	Пугачёв	/public/cities/25px-Coat_of_Arms_of_Pugachyov_%28Saratov_oblast%29.webp
845	Пудож	/public/cities/25px-Coat_of_arms_of_Pudozh_%282016%29.webp
846	Пустошка	/public/cities/25px-Coat_of_arms_of_Pustoshkinsky_District.svg.webp
847	Пучеж	/public/cities/25px-Coat_of_Arms_of_Puchezh_%28Ivanovo_oblast%29.webp
848	Пушкино	/public/cities/25px-Pushkino_COA_%282010%29.webp
849	Пущино	/public/cities/25px-Coat_of_Arms_of_Pushchino_%28Moscow_oblast%29.webp
850	Пыталово	/public/cities/25px-Pytalovskiy_rayon_COA_%282004%29.webp
851	Пыть-Ях	/public/cities/25px-Coat_of_Arms_of_Pyt-Yakh.webp
852	Пятигорск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%9F%D1%8F%D1%82%D0%B8%D0%B3%D0%BE%D1%80%D1%81%D0%BA%D0%B0.svg.webp
853	Радужный (Владимирская область)	/public/cities/25px-Coat_of_Arms_of_Raduzhny_%28Vladimir_oblast%29.webp
854	Радужный (Ханты-Мансийский АО)	/public/cities/25px-Raduzhnyj_gerb.webp
855	Райчихинск	/public/cities/25px-Coat_of_Arms_of_Raychikhinsk_%28Amur_oblast%29.webp
856	Раменское	/public/cities/25px-Ramenskoye_COA_%281995%29.webp
857	Рассказово	/public/cities/25px-Coat_of_Arms_of_Rasskazovo_%28Tambov_oblast%29.webp
858	Ревда	/public/cities/25px-Revda_and_revdinski_rayon_coa.webp
859	Реж	/public/cities/25px-Coat_of_Arms_of_Rezh_%28Sverdlovsk_oblast%29.webp
860	Реутов	/public/cities/25px-Coat_of_Arms_of_Reutov_%28Moscow_oblast%29.webp
861	Ржев	/public/cities/25px-Rzhev_COA.webp
862	Ровеньки	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
863	Родники	/public/cities/25px-Coat_of_Arms_of_Rodnikovsky_rayon_%28Ivanovo_oblast%29.webp
864	Рославль	/public/cities/25px-Coat_of_arms_of_Roslavlskiy_rayon.webp
865	Россошь	/public/cities/25px-Coat_of_Arms_of_Rossosh_%28Voronezh_oblast%29.webp
866	Ростов	/public/cities/25px-Coat_of_Arms_of_Rostov.webp
867	Ростов-на-Дону	/public/cities/25px-Coat_of_Arms_of_Rostov-on-Don.svg.webp
868	Рошаль	/public/cities/25px-Coat_of_Arms_of_Roshal_%28Moscow_oblast%29.webp
869	Ртищево	/public/cities/25px-Coat_of_Arms_of_Rtishchevo_%28Saratov_oblast%29.webp
870	Рубежное	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
871	Рубцовск	/public/cities/25px-Rubtsovsk_coat_of_arms.webp
872	Рудня	/public/cities/25px-Coat_of_Arms_of_Rudnya_rayon_%28Smolensk_oblast%29.webp
873	Руза	/public/cities/25px-Coat_of_Arms_of_Ruza_%28Moscow_oblast%29.webp
874	Рузаевка	/public/cities/25px-Ruzaevka_COA_%282020%29.webp
875	Рыбинск	/public/cities/25px-Coat_of_arms_of_Rybinsk_%282001%29.webp
876	Рыбное	/public/cities/25px-Coat_of_Arms_of_Rybnoye_%28Ryazan_obl%29.webp
877	Рыльск	/public/cities/25px-Rylsk_COA_%28Kursk_Governorate%29_%281893%29.webp
878	Ряжск	/public/cities/25px-Coat_of_Arms_of_Ryazhsk_rayon_%28Ryazan_oblast%29.webp
879	Рязань	/public/cities/25px-Coat_of_Arms_of_Ryazan_large.webp
880	Саки	/public/cities/25px-COA_Saky%2C_Crimea%2C_Ukraine.svg.webp
881	Салават	/public/cities/25px-Coat_of_Arms_of_Salavat.webp
882	Салаир	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
883	Салехард	/public/cities/25px-Coat_of_Arms_of_Salekhard_%28Yamal_Nenetsia%29.webp
884	Сальск	/public/cities/25px-Coat_of_arms_of_Salsk_%282020%29.webp
885	Самара	/public/cities/25px-Coat_of_Arms_of_Samara_%28Samara_oblast%29.webp
886	Санкт-Петербург	/public/cities/25px-Coat_of_Arms_of_Saint_Petersburg_%282003%29.svg.webp
887	Саранск	/public/cities/25px-Coat_of_Arms_of_Saransk.svg.webp
888	Сарапул	/public/cities/25px-Sarapul_COA_%28Vyatka_Governorate%29_%281781%29.webp
889	Саратов	/public/cities/25px-Coat_of_Arms_of_Saratov.webp
890	Саров	/public/cities/25px-Sarov_COA_%282004%29.webp
891	Сасово	/public/cities/25px-Coat_of_Arms_of_Sasovo_%28Ryazan_oblast%29.webp
892	Сатка	/public/cities/25px-Coat_of_Arms_of_Satka_%28Chelyabinsk_oblast%29.webp
893	Сафоново	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%A1%D0%B0%D1%84%D0%BE%D0%BD%D0%BE%D0%B2%D0%BE.webp
894	Саяногорск	/public/cities/25px-Sayanogorsk_COA_%282008%29.webp
895	Саянск	/public/cities/25px-Coat_of_Arms_of_Sayansk_%28Irkutsk_oblast%29.webp
896	Сватово	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
897	Свердловск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
898	Светлогорск	/public/cities/25px-Coat_of_Arms_of_Svetlogorsk_%28Kaliningrad_oblast%29.webp
899	Светлоград	/public/cities/25px-Coat_of_Arms_of_Svetlograd_%28Stavropol_krai%29.webp
900	Светлый	/public/cities/25px-Coat_of_Arms_of_Svetly_%28Kaliningrad_oblast%29.webp
901	Светогорск	/public/cities/25px-Coat_of_Arms_of_Svetogorsk_%28Leningrad_oblast%29.webp
902	Свирск	/public/cities/25px-Svirsk_g.webp
903	Свободный	/public/cities/25px-Coat_of_Arms_of_Svobodny_%28Amur_oblast%29.webp
904	Себеж	/public/cities/25px-Sebezh_COA_%281781%29.webp
905	Севастополь	/public/cities/25px-COA_of_Sevastopol.svg.webp
906	Северо-Курильск	/public/cities/25px-Coat_of_Arms_of_Severo-Kurilsk_rayon_%28Sakhalin_oblast%29.webp
907	Северобайкальск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%A1%D0%B5%D0%B2%D0%B5%D1%80%D0%BE%D0%B1%D0%B0%D0%B9%D0%BA%D0%B0%D0%BB%D1%8C%D1%81%D0%BA%D0%B0.webp
908	Северодвинск	/public/cities/25px-Coat_of_Arms_of_Severodvinsk.svg.webp
909	Северодонецк	/public/severodonetsk.webp
910	Североморск	/public/cities/25px-Coat_of_Arms_of_Severomorsk_%28Murmansk_oblast%29.webp
911	Североуральск	/public/cities/25px-%D0%A1oat_of_Arms_Severouralsk_municipality_%28Sverdlovsk_oblast%29.webp
912	Северск	/public/cities/25px-Coat_of_Arms_of_Seversk.svg.webp
913	Севск	/public/cities/25px-Sevsk_COA_%28Oryol_Governorate%29_%281781%29.webp
914	Сегежа	/public/cities/25px-Coat_of_arms_of_Segezha_%282013%29.webp
915	Сельцо	/public/cities/25px-Coat_of_arms_of_Seltco_%28Bryansk_oblast%29.webp
916	Семёнов	/public/cities/25px-Semyonov_COA_%28Nizhny_Novgorod_Governorate%29_%281781%29.webp
917	Семикаракорск	/public/cities/25px-Coat_of_Arms_of_Semikarakorsk_2016.webp
918	Семилуки	/public/cities/25px-Coat_of_arms_of_Semiluki_%282008%29.webp
919	Сенгилей	/public/cities/25px-Coat_of_arms_of_Sengiley_urban_settlement.webp
920	Серафимович	/public/cities/25px-Serafimovich_COA_%282008%29.webp
921	Сергач	/public/cities/25px-Coat_of_arms_of_Sergach_rayon.webp
922	Сергиев Посад	/public/cities/25px-Coat_of_Arms_of_Sergiev_Posad_%28Moscow_oblast%29.webp
923	Сердобск	/public/cities/25px-Coat_of_Arms_of_Serdobsk_%28Penza_oblast%29.webp
924	Серов	/public/cities/25px-Coat_of_Arms_of_Serov_%28Sverdlovsk_oblast%29.webp
925	Серпухов	/public/cities/25px-Vector_coat_of_arms_Serpukhov.svg.webp
926	Сертолово	/public/cities/25px-Coat_of_Arms_of_Sertolovo_%28Leningrad_oblast%29.webp
927	Сибай	/public/cities/25px-Coat_of_Arms_of_Sibai_%28Bashkortostan%29.webp
928	Сим	/public/cities/25px-Coat_of_Arms_of_Sim_%28Chelyabinsk_oblast%29.webp
931	Сковородино	/public/cities/25px-RUS_%D0%A1%D0%BA%D0%BE%D0%B2%D0%BE%D1%80%D0%BE%D0%B4%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD_COA.webp
932	Скопин	/public/cities/25px-Coat_of_Arms_of_Skopin_%28Ryazan_oblast%29.webp
933	Славгород	/public/cities/25px-Coat_of_Arms_of_Slavgorod_%28Altai_krai%29.webp
934	Славск	/public/cities/25px-Coat_of_Arms_of_Slavsk_%28Kaliningrad_oblast%29.webp
935	Славянск-на-Кубани	/public/cities/25px-Coat_of_Arms_of_Slavyansk-na-Kubani_%28Krasnodar_krai%29_%2812-2006%29.webp
936	Сланцы	/public/cities/25px-Coat_of_Arms_of_Slantsevo_%28Leningrad_oblast%29.webp
937	Слободской	/public/cities/25px-Coat_of_Arms_of_Slobodskoy_%28town%29.webp
938	Слюдянка	/public/cities/25px-The_coat_of_arms_of_the_city_of_Slyudyanka.webp
939	Смоленск	/public/cities/25px-Coat_of_Arms_of_Smolensk_%28Smolensk_oblast%29_%282001%29.webp
940	Снежинск	/public/cities/25px-Gerb_Snezhinsk.svg.webp
941	Снежногорск	/public/cities/25px-Coat_of_Arms_of_Snezhnogorsk_%28Murmansk_oblast%29.webp
942	Снежное	/public/cities/greb_Snezhnoe.webp
943	Собинка	/public/cities/25px-Coat_of_Arms_of_Sobinka.webp
944	Советск (Калининградская область)	/public/cities/25px-Gerb_Sovetsk.webp
945	Советск (Кировская область)	/public/cities/25px-Coat_of_Arms_of_Sovetsk_%28Kirov_oblast%29.webp
946	Советск (Тульская область)	/public/cities/25px-Sovetsk_COA_%282014%29.webp
947	Советская Гавань	/public/cities/25px-Coat_of_Arms_of_Sovietskaya_Gavan_%28Khabarovsk_krai%29.webp
948	Советский	/public/cities/25px-Coat_of_Arms_of_Sovetsky_%28Khanty-Mansyisky_AO%29.webp
949	Сокол	/public/cities/25px-35_sokol.webp
950	Солигалич	/public/cities/25px-Soligalich_COA_%28Kostroma_Governorate%29_%281779%29.webp
951	Соликамск	/public/cities/25px-Solikamsk_COA_%281999%29.webp
952	Солнечногорск	/public/cities/25px-Coat_of_Arms_of_Solnechnogorsk.svg.webp
953	Соль-Илецк	/public/cities/25px-Coat_of_arms_of_Sol-Iletsk.svg.webp
954	Сольвычегодск	/public/cities/25px-Solvychegodsk_%28Vologda_Governorate%29_%281780%29.webp
955	Сольцы	/public/cities/25px-Coat_of_Arms_of_Soltsy.webp
956	Сорочинск	/public/cities/25px-Coat_of_Arms_of_Sorochinsk_%28Orenburg_oblast%29.webp
957	Сорск	/public/cities/25px-Coat_of_Arms_of_Sorsk_%28Khakassia%29.webp
958	Сортавала	/public/cities/25px-Sortavala_COA_%282020%29.webp
959	Сосенский	/public/cities/25px-Coat_of_Arms_of_Sosensky_%28Kaluga_oblast%29.webp
960	Сосновка	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
961	Сосновоборск	/public/cities/25px-Sosnovoborsk_COA_%282019%29.webp
962	Сосновый Бор	/public/cities/25px-Coat_of_Arms_of_Sosnovy_Bor_%28Leningrad_oblast%29.webp
963	Сосногорск	/public/cities/25px-Coat_of_Arms_of_Sosnogorsk_%28Komia%29.webp
964	Сочи	/public/cities/25px-Coat_of_Arms_of_Sochi_%28Krasnodar_krai%29.svg.webp
965	Спас-Деменск	/public/cities/25px-Coat_of_Arms_of_Spas-Demensk_%28Kaluga_oblast%29_%282008%29.webp
966	Спас-Клепики	/public/cities/25px-Spas-Klepiki_COA_%282013%29.webp
967	Спасск	/public/cities/25px-Coat_of_Arms_of_Bednodemianovsk_%28Penza_oblast%29_%282001%29.webp
968	Спасск-Дальний	/public/cities/25px-Blason_de_Spassk_2003_%28Primorsky_kray%29.webp
969	Спасск-Рязанский	/public/cities/25px-Coat_of_Arms_of_Spassk_rayon_%28Ryazan_oblast%29.webp
970	Среднеколымск	/public/cities/25px-Coat_of_Arms_of_Srednekolymsk_%28Yakutia%29.webp
971	Среднеуральск	/public/cities/25px-Coat_of_Arms_of_Sredneuralsk_%28Sverdlovsk_oblast%29.webp
972	Сретенск	/public/cities/25px-Coat_of_Arms_of_Sretenskoe_%28Zabaykalskiy_kray%29_%282011%29.webp
973	Ставрополь	/public/cities/25px-Coat_of_Arms_of_Stavropol_%281994%29.webp
974	Старая Купавна	/public/cities/25px-Staraya_Kupavna_COA_%282016%29.webp
975	Старая Русса	/public/cities/25px-Coat_of_Arms_of_Staraya_Russa.svg.webp
976	Старица	/public/cities/25px-Staritsa_COA_%28Tver_Governorate%29_%281780%29.webp
977	Старобельск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
978	Стародуб	/public/cities/25px-Starodub_COA_%28Chernigov_Governorate%29_%281782%29.webp
979	Старый Крым	/public/cities/25px-COA_Staryi_Krym%2C_Krym.svg.webp
980	Старый Оскол	/public/cities/25px-Coat_of_Arms_of_Stary_Oskol_%28Belgorod_oblast%292008.svg.webp
981	Стаханов	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
982	Стерлитамак	/public/cities/25px-Coat_of_Arms_of_Sterlitamak_%28Bashkortostan%29.webp
983	Стрежевой	/public/cities/25px-Strezhevoy_coat_of_arms.webp
984	Строитель	/public/cities/25px-Coat_of_Arms_Yakovlevo.svg.webp
985	Струнино	/public/cities/25px-Coat_of_Arms_of_Strunino_city.webp
986	Ступино	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%A1%D1%82%D1%83%D0%BF%D0%B8%D0%BD%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD%D0%B0.webp
987	Суворов	/public/cities/25px-Coat_of_arms_of_Suvorov_%282014%29.webp
988	Судак	/public/cities/25px-Russian_COA_of_Sudak_%282015%29.webp
989	Суджа	/public/cities/25px-Sudzha_COA_%28Kursk_Governorate%29_%281780%29.webp
990	Судогда	/public/cities/25px-Sudogda_COA_%28Vladimir_Governorate%29_%281781%29.webp
991	Суздаль	/public/cities/25px-Coat_of_Arms_of_Suzdal.webp
992	Сунжа	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
993	Суоярви	/public/cities/25px-Coat_of_arms_of_Suoyarvi_%282017%29.webp
994	Сураж	/public/cities/25px-Surazh_COA_%28Chernigov_Governorate%29_%281782%29.webp
995	Сургут	/public/cities/25px-Coat_of_Arms_of_Surgut.webp
996	Суровикино	/public/cities/25px-Coat_of_arms_of_Surovikino_without_a_crown_%282008%29.webp
997	Сурск	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
998	Сусуман	/public/cities/25px-Gerb-Susumansky-region.webp
999	Сухиничи	/public/cities/25px-RUS_Sukhinichi_COA_%282019%29.webp
1000	Суходольск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
1001	Сухой Лог	/public/cities/25px-Coat_of_Arms_of_Sukhoi_Log_%28Sverdlovsk_oblast%29.webp
1002	Счастье	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
1003	Сызрань	/public/cities/25px-Syzran_coa.webp
1004	Сыктывкар	/public/cities/25px-Coat_of_Arms_of_Syktyvkar_%28Komi%29_%282005%29.webp
1005	Сысерть	/public/cities/25px-Coat_of_Arms_of_Sysert_%28Sverdlovsk_oblast%29.webp
1006	Сычёвка	/public/cities/25px-Coat_of_arms_Sychevka_%282001%29.webp
1007	Сясьстрой	/public/cities/25px-Sjasstroy_city_coa.webp
1008	Тавда	/public/cities/25px-Coat_of_Arms_of_Tavda_%28Sverdlovsk_oblast%29.webp
1009	Таврийск	/public/cities/kherson_obl.webp
1010	Таганрог	/public/cities/25px-Taganrog.webp
1011	Тайга	/public/cities/25px-Taiga_COA_%282020%29.webp
1012	Тайшет	/public/cities/25px-Coat_of_arms_of_tayshet.webp
1013	Талдом	/public/cities/25px-Coat_of_Arms_of_Taldomsky_rayon_%28Moscow_oblast%29.webp
1014	Талица	/public/cities/25px-Coat_of_Arms_of_Talitsa_%28Sverdlovsk_oblast%29.webp
1015	Тамбов	/public/cities/25px-Coat_of_Arms_of_Tambov_%282008%29.svg.webp
1016	Тара	/public/cities/25px-Tara_COA_%282009%29.webp
1017	Тарко-Сале	/public/cities/25px-Coat_of_Arms_of_Tarko-Sale_%28Yamalo-Nenetsky_AO%29.webp
1018	Таруса	/public/cities/25px-Tarusa_COA_%282020%29.webp
1019	Татарск	/public/cities/25px-Tatarsk_COA_%282010%29.webp
1020	Таштагол	/public/cities/25px-Tashtagol_COA_%281998%29.webp
1021	Тверь	/public/cities/25px-Coat_of_Arms_of_Tver_%28Tver_oblast%29.webp
1022	Теберда	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1023	Тейково	/public/cities/25px-Teykovo_COA.webp
1024	Темников	/public/cities/25px-Temnikov_COA_%28Tambov_Governorate%29_%281781%29.webp
1025	Темрюк	/public/cities/25px-Coat_of_Arms_of_Temryuk_%28Krasnodar_krai%29.webp
1026	Терек	/public/cities/25px-Gerb-Terek.webp
1027	Тетюши	/public/cities/25px-Coat_of_Arms_of_Tetiushi_%28Tatarstan%29_%281781%29.webp
1028	Тимашёвск	/public/cities/25px-Coat_of_Timashevsk.webp
1029	Тихвин	/public/cities/25px-Coat_of_Arms_of_Tikhvin_%28Leningrad_oblast%29.webp
1030	Тихорецк	/public/cities/25px-Coat_of_Arms_of_Tikhoretsk_%28Krasnodar_krai%29.webp
1031	Тобольск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%A2%D0%BE%D0%B1%D0%BE%D0%BB%D1%8C%D1%81%D0%BA%D0%B0.svg.webp
1032	Тогучин	/public/cities/25px-Coat_of_Arms_of_Toguchin_%28Novosibirsk_oblast%29.webp
1033	Токмак	/public/cities/zaporozhskaya_oblast.webp
1034	Тольятти	/public/cities/25px-Coat_of_Arms_of_Togliatti_%28Samara_oblast%29_ceremonial.webp
1035	Томари	/public/cities/25px-Coat_of_Arms_of_Tomarinsky_rayon_%28Sakhalin_oblast%29.webp
1036	Томмот	/public/cities/25px-Tommot_city_coa.webp
1037	Томск	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%A2%D0%BE%D0%BC%D1%81%D0%BA%D0%B0_2019.webp
1038	Топки	/public/cities/25px-Topki_coat_of_arms.webp
1039	Торез	/public/cities/torez.webp
1040	Торжок	/public/cities/25px-Coat_of_Arms_of_Torzhok_%28Tver_oblast%29.webp
1041	Торопец	/public/cities/25px-Coat_of_Arms_of_Toropets_%28Tver_oblast%29.webp
1042	Тосно	/public/cities/25px-Coat_of_Arms_of_Tosno.webp
1043	Тотьма	/public/cities/25px-Coat_of_Arms_of_Totma_%28Vologda_oblast%29.webp
1044	Трёхгорный	/public/cities/25px-Coat_of_Arms_of_Tryokhgorny_%28Chelyabinsk_oblast%29.webp
1045	Троицк	/public/cities/25px-Coat_of_Arms_of_Troitsk_%28Chelyabinsk_oblast%29.webp
1046	Трубчевск	/public/cities/25px-Trubchevsk_COA_%28Oryol_Governorate%29_%281781%29.webp
1047	Туапсе	/public/cities/25px-Coat_of_Arms_of_Tuapse_%28Krasnodar_krai%29.webp
1048	Туймазы	/public/cities/25px-Coat_of_Arms_of_Tuimazy_rayon_%28Bashkortostan%29.webp
1049	Тула	/public/cities/25px-Coat_of_Arms_of_Tula.webp
1050	Тулун	/public/cities/25px-Coat_of_Arms_of_Tulun.webp
1051	Туран	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1052	Туринск	/public/cities/25px-Coat_of_Arms_of_Turinsk_%28Sverdlovsk_oblast%29.webp
1053	Тутаев	/public/cities/25px-Tutaev_gerb_vector.svg.webp
1054	Тында	/public/cities/25px-Coat_of_Arms_of_Tynda_%28Amur_oblast%29_%282006%29.webp
1055	Тырныауз	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1056	Тюкалинск	/public/cities/25px-Coat_of_Arms_of_Tyukalinsk.webp
1057	Тюмень	/public/cities/25px-Coat_of_Arms_of_Tyumen_%28Tyumen_oblast%29_%282005%29.webp
1058	Уварово	/public/cities/25px-Coat_of_Arms_of_Uvarovo_%28Tambov_oblast%29_2012.webp
1059	Углегорск (Сахалинская область)	/public/cities/25px-Coat_of_Arms_of_Uglegorski_%28Sakhalin_oblast%29.webp
1060	Углегорск (ДНР)	/public/cities/Coat_of_Arms_of_the_Donetsk_People's_Republic.svg.webp
1061	Углич	/public/cities/25px-Coat_of_Arms_of_Uglich_%28Yaroslavl_oblast%29.webp
1062	Удачный	/public/cities/25px-Udachny_coat_of_arms_%282009%29.webp
1063	Удомля	/public/cities/25px-Coat_of_Arms_of_Udomlya_%28Tver_oblast%29.webp
1064	Ужур	/public/cities/25px-Coat_of_arms_of_Uzhur_%282010%29.webp
1065	Узловая	/public/cities/25px-Coat_of_Arms_of_Uzlovaya_%28Tula_oblast%29.webp
1066	Улан-Удэ	/public/cities/25px-Ulan-Ude_COA_%282005%29.webp
1067	Ульяновск	/public/cities/25px-Coat_of_arms_of_Ulyanovsk.webp
1068	Унеча	/public/cities/25px-Coat_of_arms_of_Unecha_%281986%29.webp
1069	Урай	/public/cities/25px-Coat_of_Arms_of_Uray.svg.webp
1070	Урень	/public/cities/25px-Uren_rayon_COA_%282019%29.webp
1071	Уржум	/public/cities/25px-Coat_of_Arms_of_Urzhum.webp
1072	Урус-Мартан	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1073	Урюпинск	/public/cities/25px-Uryupinsk_COA_%282020%29.webp
1074	Усинск	/public/cities/25px-Coat_of_Arms_of_Usinsk_%28Komia%29.webp
1075	Усмань	/public/cities/25px-Coat_of_arms_of_Usman_%282012%29.webp
1076	Усолье	/public/cities/25px-Usolye_COA_%282009%29.webp
1077	Усолье-Сибирское	/public/cities/25px-Usolye-Sibirskoe_COA_%282014%29.webp
1078	Уссурийск	/public/cities/25px-Coat_of_Arms_of_Ussuriysk_%28Primorsky_kray%29.webp
1079	Усть-Джегута	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1080	Усть-Илимск	/public/cities/25px-Coat_of_Arms_of_Ust-Ilimsk_%28Irkutsk_oblast%29.webp
1081	Усть-Катав	/public/cities/25px-Coat_of_Arms_of_Ust-Katav_%28Chelyabinsk_oblast%29.webp
1082	Усть-Кут	/public/cities/25px-Coat_of_Arms_of_Ust-Kut_2009.webp
1083	Усть-Лабинск	/public/cities/25px-Ust_labinsk_city_coa_2010.webp
1084	Устюжна	/public/cities/25px-Coat_of_arms_of_Ustyuzhna_and_Ustugnovsky_District_%28Vologda_Region%29.webp
1085	Уфа	/public/cities/25px-Coat_of_arms_of_Ufa.svg.webp
1086	Ухта	/public/cities/25px-Coat_of_Arms_of_Ukhta_%28Komia%29_%281979%29.webp
1087	Учалы	/public/cities/25px-Uchaly_COA_%282013%29.webp
1088	Уяр	/public/cities/25px-Coat_of_arms_of_Uyar_%28Uyarsky_District%2C_2011%29.webp
1089	Фатеж	/public/cities/25px-Fatezh_COA_%28Kursk_Governorate%29_%281780%29.webp
1090	Феодосия	/public/cities/25px-Feodosiya_coat_of_arms.svg.webp
1091	Фокино (Брянская область)	/public/cities/25px-Fokino_COA_%282019%29.webp
1092	Фокино (Приморский край)	/public/cities/25px-Coat_of_Arms_of_Fokino_%28Primorsky_kray%29.webp
1093	Фролово	/public/cities/25px-Coat_of_Arms_of_Frolovo_02.webp
1094	Фрязино	/public/cities/25px-Coat_of_Arms_of_Fryazino_%28Moscow_oblast%29.svg.webp
1095	Фурманов	/public/cities/25px-Coat_of_Arms_of_Furmanov_%28Ivanovo_oblast%29.webp
1096	Хабаровск	/public/cities/25px-Khabarovsk_Coat_of_Arms.webp
1097	Хадыженск	/public/cities/25px-Coat_of_Arms_of_Khadyzhensk_%282012%29.webp
1098	Ханты-Мансийск	/public/cities/25px-Coat_of_Arms_of_Khanty-Mansiysk.svg.webp
1099	Харабали	/public/cities/25px-Coat_of_Arms_of_Kharabali_%28Astrakhan_oblast%29.webp
1100	Харовск	/public/cities/25px-Kharovskiy_rayon_COA.webp
1101	Харцызск	/public/cities/khartsyzsk.webp
1102	Хасавюрт	/public/cities/25px-Coat_of_Arms_of_Khasavyurt_%282017%29.webp
1103	Хвалынск	/public/cities/25px-Coat_of_Arms_of_Khvalynsk_%28Saratov_oblast%29.webp
1104	Херсон	/public/cities/kherson_obl.webp
1105	Хилок	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%B3._%D0%A5%D0%B8%D0%BB%D0%BE%D0%BA.webp
1106	Химки	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%A5%D0%B8%D0%BC%D0%BE%D0%BA.svg.webp
1107	Холм	/public/cities/25px-Kholm_COA_%28Pskov_Governorate%29_%281781%29.webp
1108	Холмск	/public/cities/25px-Coat_of_Arms_of_Kholmsk_%28Sakhalin_oblast%29_coat_fof_arms.webp
1109	Хотьково	/public/cities/25px-Coat_of_Arms_of_Hotkovo.webp
1110	Цивильск	/public/cities/25px-Coat_of_Arms_of_Civilsk_%28Chuvashia%29.svg.webp
1111	Цимлянск	/public/cities/25px-Cimlyansk_COA_%282020%29.webp
1112	Циолковский	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%A6%D0%B8%D0%BE%D0%BB%D0%BA%D0%BE%D0%B2%D1%81%D0%BA%D0%BE%D0%B3%D0%BE.webp
1113	Цюрупинск	/public/cities/kherson_obl.webp
1114	Чадан	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1115	Чайковский	/public/cities/25px-Coat_of_Arms_of_Chaykovsky_%282000%29.webp
1116	Чапаевск	/public/cities/25px-Coat_of_Arms_of_Chapaevsk_%28Samara_oblast%29.webp
1117	Чаплыгин	/public/cities/25px-Coat_of_Arms_of_Chaplygin_%28Lipetsk_oblast%29_%282005%29.webp
1118	Чебаркуль	/public/cities/25px-Coat_of_Arms_of_Chebarkul_%28Chelyabinsk_oblast%29.webp
1119	Чебоксары	/public/cities/25px-Coat_of_Arms_of_Cheboksary_%28Chuvashia%29.svg.webp
1120	Чегем	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1121	Чекалин	/public/cities/25px-Coat_of_Arms_of_Likhvin_%28Tula_oblast%29.webp
1122	Челябинск	/public/cities/25px-CoA_of_Chelyabinsk_%282000%29.svg.webp
1123	Червонопартизанск	/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp
1124	Чердынь	/public/cities/25px-Cherdyn_COA_%282009%29.webp
1125	Черемхово	/public/cities/25px-Coat_of_Arms_of_Cheremkhovo_%28Irkutsk_oblast%29.webp
1126	Черепаново	/public/cities/25px-Coat_of_Arms_of_Cherepanovo_%28Novosibirsk_oblast%29.webp
1127	Череповец	/public/cities/25px-Cherepovets_COA_%28Novgorod_Governorate%29_%281811%29.webp
1128	Черкесск	/public/cities/25px-Coat_of_Arms_of_Cherkessk_%28Karachay-Cherkessia%29.webp
1129	Чёрмоз	/public/cities/25px-Chermoz_COA_%282009%29.webp
1130	Черноголовка	/public/cities/25px-Coat_of_Arms_of_Chernogolovka_%28Moscow_oblast%29_%282001%29.webp
1131	Черногорск	/public/cities/25px-Coat_of_Arms_of_Chernogorsk_%28Khakassia%29.webp
1132	Чернушка	/public/cities/25px-Chernushka_COA_%282011%29.webp
1133	Черняховск	/public/cities/25px-RUS_Chernyakhovsk_COA_%28achievement%29.svg.webp
1134	Чехов	/public/cities/25px-RUS_%D0%A7%D0%B5%D1%85%D0%BE%D0%B2%D1%81%D0%BA%D0%B8%D0%B9_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD_COA.webp
1135	Чистополь	/public/cities/25px-Chistopol_COA_%28Kazan_Governorate%29_%281781%29.webp
1136	Чита	/public/cities/25px-Coat_of_Arms_of_Chita_%28Chita_oblast%29.webp
1137	Чкаловск	/public/cities/25px-Chkalovsk_%28Vasilyovo%29_COA_%282013%29.webp
1138	Чудово	/public/cities/25px-Coat_of_Arms_of_Chudovsky_district.webp
1139	Чулым	/public/cities/25px-Coat_of_Arms_of_Chulym_rayon_%28Novosibirsk_oblast%29.webp
1140	Чусовой	/public/cities/25px-Chusovoy_COA_%282007%29.webp
1141	Чухлома	/public/cities/25px-Coat_of_Arms_of_Chukhloma_%28Kostroma_oblast%29.webp
1142	Шагонар	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1143	Шадринск	/public/cities/25px-Coat_of_Arms_of_Shadrinsk_%28Kurgan_oblast%29.webp
1144	Шали	/public/cities/25px-FR_Coats-of-arms-of-None.svg.webp
1145	Шарыпово	/public/cities/25px-SHR00-GERB.webp
1146	Шарья	/public/cities/25px-Coat_of_Arms_of_Sharya_%28Kostroma_oblast%29.webp
1147	Шатура	/public/cities/25px-Shatura_city_coa.webp
1148	Шахтёрск	/public/cities/shahtersk.webp
1149	Шахты	/public/cities/25px-Coat_of_arms_of_Shakhty.webp
1150	Шахунья	/public/cities/25px-Shakhunya_COA_%282013%29.webp
1151	Шацк	/public/cities/25px-Gerb-Shatski-region.webp
1152	Шебекино	/public/cities/25px-Lob_Coats_of_arms_Shebekino.svg.webp
1153	Шелехов	/public/cities/25px-Coat_of_Arms_of_Shelehov_%28Irkutsk_oblast%29.webp
1154	Шенкурск	/public/cities/25px-Shenkursk_COA_%28Arkhangelsk_Governorate%29_%281780%29.webp
1155	Шилка	/public/cities/25px-Coat_of_Arms_of_Shilka_%28Chita_oblast%29.webp
1156	Шимановск	/public/cities/25px-Coat_of_arms_of_Shimanovsk_%282017%29.webp
1157	Шиханы	/public/cities/25px-Coat_of_Arms_of_Shikhany_%28Saratov_oblast%29.svg.webp
1158	Шлиссельбург	/public/cities/25px-Coat_of_Arms_of_Shlisselburg_%28Leningrad_oblast%29.webp
1159	Шумерля	/public/cities/25px-Shumerlya_COA_%282019%29.webp
1160	Шумиха	/public/cities/25px-Coat_of_arms_of_Shumikha_%282005%29.webp
1161	Шуя	/public/cities/25px-Coat_of_arms_of_Shuya_%28Ivanovo_oblast%29.svg.webp
1162	Щёкино	/public/cities/25px-Coat_of_Arms_of_Schyokino_%28Tula_oblast%29.webp
1163	Щёлкино	/public/cities/25px-COA_Shcholkine.svg.webp
1164	Щёлково	/public/cities/25px-Coat_of_Arms_of_Shchelkovo_%28Moscow_oblast%29_%282001%29.webp
1165	Щигры	/public/cities/25px-Shchigry_COA_%28Kursk_Governorate%29_%281780%29.webp
1166	Щучье	/public/cities/25px-Coat_of_Arms_of_Schuche_%282013%29.webp
1167	Электрогорск	/public/cities/25px-Coat_of_Arms_of_Elektrogorsk_%28Moscow_oblast%29.webp
1168	Электросталь	/public/cities/25px-Coat_of_Arms_of_Elektrostal_%28Moscow_oblast%29.svg.webp
1169	Электроугли	/public/cities/25px-Coat_of_Arms_of_Elektrougli_%28Moscow_oblast%29.webp
1170	Элиста	/public/cities/25px-Coat_of_Arms_of_Elista_%28Kalmykia%29_%282004%29.webp
1171	Энгельс	/public/cities/25px-Coat_of_Arms_of_Engels_%28Saratov_oblast%29.webp
1172	Энергодар	/public/cities/energodar.webp
1173	Эртиль	/public/cities/25px-Coat_of_Arms_of_Ertil.webp
1174	Югорск	/public/cities/25px-Yugorsk_COA_%282004%29.webp
1175	Южа	/public/cities/25px-Coat_of_Arms_of_Yuzhsky_rayon_%28Ivanovo_oblast%29.webp
1176	Южно-Сахалинск	/public/cities/25px-Coat_of_Arms_of_Yuzhno-Sakhalinsk.webp
1177	Южно-Сухокумск	/public/cities/25px-Coat_of_Arms_of_Jujno-Sukhokumsk.webp
1178	Южноуральск	/public/cities/25px-Coat_of_Arms_of_Yuzhnouralsk_%28Chelyabinsk_oblast%29.webp
1179	Юрга	/public/cities/25px-Coat_of_Arms_of_Yurga_%28Kemerovo_oblast%29.webp
1180	Юрьев-Польский	/public/cities/25px-Yuriev-Polskiy_COA_%282019%29.webp
1181	Юрьевец	/public/cities/25px-Coat_of_Arms_of_Yurievets_%28Ivanovo_oblast%29.webp
1182	Юрюзань	/public/cities/25px-Yuryuzan_COA.webp
1183	Юхнов	/public/cities/25px-Yukhnov_COA_%28Smolensk_Governorate%29_%281780%29.webp
1184	Ядрин	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%AF%D0%B4%D1%80%D0%B8%D0%BD%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D0%BC%D1%83%D0%BD%D0%B8%D1%86%D0%B8%D0%BF%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B3%D0%BE_%D0%BE%D0%BA%D1%80%D1%83%D0%B3%D0%B0.webp
1185	Якутск	/public/cities/25px-Coat_of_Arms_of_Yakuts_%28Yakutia%29_2012_2.webp
1186	Ялта	/public/cities/25px-Coat_of_arms_of_Yalta.svg.webp
1187	Ялуторовск	/public/cities/25px-Yalutorovsk_COA_%282010%29.webp
1188	Янаул	/public/cities/25px-Coat_of_Arms_of_Yanaul_rayon_%28Bashkortostan%29.webp
1189	Яранск	/public/cities/25px-Coat_of_Arms_of_Yaransk.webp
1190	Яровое	/public/cities/25px-Coat_of_Arms_of_Yarovoe_%28Altai_krai%29.webp
1191	Ярославль	/public/cities/25px-Coat_of_Arms_of_Yaroslavl_%281995%29.webp
1192	Ярцево	/public/cities/25px-Coat_of_Arms_of_Yartsevo_%28Smolensk_oblast%29.webp
1193	Ясиноватая	/public/cities/Gerb_Yasinovatoy_600h800.webp
1194	Ясногорск	/public/cities/25px-Coat_of_Arms_of_Yasnogorsk_%28Tula_oblast%29_%281987%29.webp
1195	Ясный	/public/cities/25px-Coat_of_Arms_of_Yasnyi_Rayon.webp
1196	Яхрома	/public/cities/25px-%D0%93%D0%B5%D1%80%D0%B1_%D0%AF%D1%85%D1%80%D0%BE%D0%BC%D1%8B.webp
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, name, surname, photo) FROM stdin;
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, description, logo) FROM stdin;
1	ООО "ИнТим"	Легендарная команда из Саратовской области	https://avatars.githubusercontent.com/u/166201722?s=48&v=4
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback (id, client_id, product_id, rate, description, photos) FROM stdin;
\.


--
-- Data for Name: infrastructure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infrastructure (company_id, city, storage, dp) FROM stdin;
1	889	f	f
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, company_id, client_id, order_type, product_id, price, amount, sum, start_time, end_time, "from", "to", stage_edge, stage_type, active) FROM stdin;
\.


--
-- Data for Name: path_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.path_types (id, name, description) FROM stdin;
\.


--
-- Data for Name: paths; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paths (id, company_id, departure, destination, is_dest_transit, type, duration, distance, price) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, company_id, category, name, img, size, price, amount, rating, hidden) FROM stdin;
1	1	1	Интим	\N	69 см x 300 см x 1488 см	300000	0	\N	t
\.


--
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.route (id, order_id, edge, prev_stage, next_stage, stage_num, end_time) FROM stdin;
\.


--
-- Data for Name: storage_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.storage_products (company_id, city_id, product_id, amount) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, role, is_active, is_superuser, is_verified) FROM stdin;
1	gremlin@kremlin.ru	wagner	0	t	f	f
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 1, false);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 1, false);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, false);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: path_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.path_types_id_seq', 1, false);


--
-- Name: paths_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paths_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, true);


--
-- Name: route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.route_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: cart client_product; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT client_product PRIMARY KEY (client_id, product_id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: infrastructure company_in_city; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infrastructure
    ADD CONSTRAINT company_in_city PRIMARY KEY (company_id, city);


--
-- Name: CONSTRAINT company_in_city ON infrastructure; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT company_in_city ON public.infrastructure IS 'Строка есть представление об инфраструктуре заданной компании в заданном городе';


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: storage_products item; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storage_products
    ADD CONSTRAINT item PRIMARY KEY (company_id, product_id, city_id);


--
-- Name: CONSTRAINT item ON storage_products; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT item ON public.storage_products IS 'Информация о наименовании товара на складе';


--
-- Name: infrastructure one_per_city; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infrastructure
    ADD CONSTRAINT one_per_city UNIQUE (company_id, city);


--
-- Name: CONSTRAINT one_per_city ON infrastructure; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT one_per_city ON public.infrastructure IS 'Информация о наличии инфраструктуры заданной компании в заданном поселении представляется единственной уникальной строкой';


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: paths paths_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paths
    ADD CONSTRAINT paths_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: route route_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: infrastructure city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infrastructure
    ADD CONSTRAINT city FOREIGN KEY (city) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedback client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT client FOREIGN KEY (client_id) REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT client FOREIGN KEY (client_id) REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT client FOREIGN KEY (client_id) REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: paths company; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paths
    ADD CONSTRAINT company FOREIGN KEY (company_id) REFERENCES public.companies(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: infrastructure company; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infrastructure
    ADD CONSTRAINT company FOREIGN KEY (company_id) REFERENCES public.companies(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders company; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT company FOREIGN KEY (company_id) REFERENCES public.companies(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT company_id FOREIGN KEY (company_id) REFERENCES public.companies(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: paths departure; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paths
    ADD CONSTRAINT departure FOREIGN KEY (departure) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: paths destination; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paths
    ADD CONSTRAINT destination FOREIGN KEY (destination) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders from; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "from" FOREIGN KEY ("from", company_id) REFERENCES public.infrastructure(city, company_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: clients id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: companies id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: route next_stage; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT next_stage FOREIGN KEY (next_stage) REFERENCES public.route(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: route order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT "order" FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CONSTRAINT "order" ON route; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "order" ON public.route IS 'Заказ, к которому относится пункт маршрутного листа';


--
-- Name: route prev_stage; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT prev_stage FOREIGN KEY (prev_stage) REFERENCES public.route(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedback product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT product FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: storage_products product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storage_products
    ADD CONSTRAINT product FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT product FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT product FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products product_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT product_category FOREIGN KEY (category) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: storage_products storage; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storage_products
    ADD CONSTRAINT storage FOREIGN KEY (company_id, city_id) REFERENCES public.infrastructure(company_id, city) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders to; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "to" FOREIGN KEY (company_id, "to") REFERENCES public.infrastructure(company_id, city) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

