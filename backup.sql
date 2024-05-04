--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Ubuntu 16.2-1ubuntu4)

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

ALTER TABLE IF EXISTS ONLY public.user_achivements DROP CONSTRAINT IF EXISTS user_achivements_user_id_fk;
ALTER TABLE IF EXISTS ONLY public.user_achivements DROP CONSTRAINT IF EXISTS user_achivements_achivements_id_fk;
ALTER TABLE IF EXISTS ONLY public.problems DROP CONSTRAINT IF EXISTS problems_users_id_fk2;
ALTER TABLE IF EXISTS ONLY public.problems DROP CONSTRAINT IF EXISTS problems_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.problem_votes DROP CONSTRAINT IF EXISTS problem_votes_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.problem_votes DROP CONSTRAINT IF EXISTS problem_votes_problems_id_fk;
ALTER TABLE IF EXISTS ONLY public.events DROP CONSTRAINT IF EXISTS events_user_id_fk;
ALTER TABLE IF EXISTS ONLY public.event_members DROP CONSTRAINT IF EXISTS event_members_user_id_fk;
ALTER TABLE IF EXISTS ONLY public.event_members DROP CONSTRAINT IF EXISTS event_members_events_id_fk;
ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS users_pk;
ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS users_email;
ALTER TABLE IF EXISTS ONLY public.problems DROP CONSTRAINT IF EXISTS problems_pk;
ALTER TABLE IF EXISTS ONLY public.events DROP CONSTRAINT IF EXISTS events_pk;
ALTER TABLE IF EXISTS ONLY public.achivements DROP CONSTRAINT IF EXISTS achivements_pk;
ALTER TABLE IF EXISTS public."user" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.problems ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.achivements ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.user_achivements;
DROP TABLE IF EXISTS public."user";
DROP SEQUENCE IF EXISTS public.problems_id_seq;
DROP TABLE IF EXISTS public.problems;
DROP TABLE IF EXISTS public.problem_votes;
DROP SEQUENCE IF EXISTS public.events_id_seq;
DROP TABLE IF EXISTS public.events;
DROP TABLE IF EXISTS public.event_members;
DROP SEQUENCE IF EXISTS public.achivements_id_seq;
DROP TABLE IF EXISTS public.achivements;
DROP TYPE IF EXISTS public.problem_state;
--
-- Name: problem_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.problem_state AS ENUM (
    'free',
    'in_progress',
    'on_verification',
    'on_voting',
    'completed'
);


ALTER TYPE public.problem_state OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achivements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achivements (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    description character varying(1024) NOT NULL,
    logo character varying(256) NOT NULL
);


ALTER TABLE public.achivements OWNER TO postgres;

--
-- Name: achivements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.achivements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.achivements_id_seq OWNER TO postgres;

--
-- Name: achivements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.achivements_id_seq OWNED BY public.achivements.id;


--
-- Name: event_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_members (
    event_id integer,
    user_id integer,
    is_member_good boolean
);


ALTER TABLE public.event_members OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    description text NOT NULL,
    leader_id integer NOT NULL,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    status character varying(64)
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: problem_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problem_votes (
    user_id integer NOT NULL,
    problem_id integer NOT NULL,
    vote integer NOT NULL
);


ALTER TABLE public.problem_votes OWNER TO postgres;

--
-- Name: problems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problems (
    id integer NOT NULL,
    description character varying(200),
    photo character varying(512),
    lat double precision,
    lon double precision,
    author_id integer,
    solver_id integer,
    solution_photo character varying(512),
    state character varying(64) DEFAULT 'free'::character varying NOT NULL
);


ALTER TABLE public.problems OWNER TO postgres;

--
-- Name: problems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.problems_id_seq OWNER TO postgres;

--
-- Name: problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problems_id_seq OWNED BY public.problems.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(320) NOT NULL,
    hashed_password character varying(512) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    is_superuser boolean DEFAULT false NOT NULL,
    is_verified boolean DEFAULT false NOT NULL,
    telegram character varying(256),
    vk character varying(256),
    photo character varying(512),
    name character varying(256),
    surname character varying(256),
    problems_added integer DEFAULT 0 NOT NULL,
    problems_solved integer DEFAULT 0 NOT NULL,
    events_added integer DEFAULT 0 NOT NULL,
    events_visited integer DEFAULT 0 NOT NULL,
    exp integer DEFAULT 0 NOT NULL,
    level integer DEFAULT 1
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_achivements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_achivements (
    user_id integer NOT NULL,
    achivement_id integer NOT NULL
);


ALTER TABLE public.user_achivements OWNER TO postgres;

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

ALTER SEQUENCE public.users_id_seq OWNED BY public."user".id;


--
-- Name: achivements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achivements ALTER COLUMN id SET DEFAULT nextval('public.achivements_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problems ALTER COLUMN id SET DEFAULT nextval('public.problems_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: achivements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achivements (id, name, description, logo) FROM stdin;
\.


--
-- Data for Name: event_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_members (event_id, user_id, is_member_good) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, name, description, leader_id, lat, lon, status) FROM stdin;
\.


--
-- Data for Name: problem_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_votes (user_id, problem_id, vote) FROM stdin;
\.


--
-- Data for Name: problems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problems (id, description, photo, lat, lon, author_id, solver_id, solution_photo, state) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, hashed_password, is_active, is_superuser, is_verified, telegram, vk, photo, name, surname, problems_added, problems_solved, events_added, events_visited, exp, level) FROM stdin;
1	danila.sar@yandex.ru	$argon2id$v=19$m=65536,t=3,p=4$de/7hscFq6KZrqpChYRIRQ$vL2ht1DmTWZZDAI89o5M41DArddR1QixJOsNtUSnYBs	t	f	f	string	string	\N	string	string	0	0	0	0	0	1
2	danilasar@yandex.ru	$argon2id$v=19$m=65536,t=3,p=4$mud8bmiHnV7EYwJu0+dE8A$cmVvL2ZvTVjOb5qwCHEryK21VRqz7sstrx6U7c+TJYU	t	f	f	https://t.me/eblan	https://vk.com/eblan	\N	Данила	Григорьев	0	0	0	0	0	1
\.


--
-- Data for Name: user_achivements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_achivements (user_id, achivement_id) FROM stdin;
\.


--
-- Name: achivements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.achivements_id_seq', 1, false);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 1, false);


--
-- Name: problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problems_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: achivements achivements_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achivements
    ADD CONSTRAINT achivements_pk PRIMARY KEY (id);


--
-- Name: events events_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pk PRIMARY KEY (id);


--
-- Name: problems problems_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_pk PRIMARY KEY (id);


--
-- Name: user users_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT users_email UNIQUE (email);


--
-- Name: user users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: event_members event_members_events_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_members
    ADD CONSTRAINT event_members_events_id_fk FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- Name: event_members event_members_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_members
    ADD CONSTRAINT event_members_user_id_fk FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: events events_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_user_id_fk FOREIGN KEY (leader_id) REFERENCES public."user"(id);


--
-- Name: problem_votes problem_votes_problems_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_votes
    ADD CONSTRAINT problem_votes_problems_id_fk FOREIGN KEY (problem_id) REFERENCES public.problems(id);


--
-- Name: problem_votes problem_votes_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_votes
    ADD CONSTRAINT problem_votes_users_id_fk FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: problems problems_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_users_id_fk FOREIGN KEY (author_id) REFERENCES public."user"(id);


--
-- Name: problems problems_users_id_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_users_id_fk2 FOREIGN KEY (solver_id) REFERENCES public."user"(id);


--
-- Name: user_achivements user_achivements_achivements_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_achivements
    ADD CONSTRAINT user_achivements_achivements_id_fk FOREIGN KEY (achivement_id) REFERENCES public.achivements(id);


--
-- Name: user_achivements user_achivements_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_achivements
    ADD CONSTRAINT user_achivements_user_id_fk FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

