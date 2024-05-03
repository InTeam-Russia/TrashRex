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

ALTER TABLE IF EXISTS ONLY public.problems DROP CONSTRAINT IF EXISTS problems_users_id_fk2;
ALTER TABLE IF EXISTS ONLY public.problems DROP CONSTRAINT IF EXISTS problems_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.problem_votes DROP CONSTRAINT IF EXISTS problem_votes_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.problem_votes DROP CONSTRAINT IF EXISTS problem_votes_problems_id_fk;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pk;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email;
ALTER TABLE IF EXISTS ONLY public.problems DROP CONSTRAINT IF EXISTS problems_pk;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.problems ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.problems_id_seq;
DROP TABLE IF EXISTS public.problems;
DROP TABLE IF EXISTS public.problem_votes;
DROP TYPE IF EXISTS public.problem_state;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


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
-- Name: problem_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problem_votes (
    user_id integer NOT NULL,
    problem_id integer NOT NULL,
    logo character varying(256) NOT NULL
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
    state character varying(10) DEFAULT 'free'::character varying NOT NULL
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
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
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
    surname character varying(256)
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
-- Name: problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problems ALTER COLUMN id SET DEFAULT nextval('public.problems_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: problem_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_votes (user_id, problem_id, logo) FROM stdin;
\.


--
-- Data for Name: problems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problems (id, description, photo, lat, lon, author_id, solver_id, solution_photo, state) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, is_active, is_superuser, is_verified, telegram, vk, photo, name, surname) FROM stdin;
\.


--
-- Name: problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problems_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: problems problems_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_pk PRIMARY KEY (id);


--
-- Name: users users_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email UNIQUE (email);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: problem_votes problem_votes_problems_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_votes
    ADD CONSTRAINT problem_votes_problems_id_fk FOREIGN KEY (problem_id) REFERENCES public.problems(id);


--
-- Name: problem_votes problem_votes_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_votes
    ADD CONSTRAINT problem_votes_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: problems problems_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_users_id_fk FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: problems problems_users_id_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problems
    ADD CONSTRAINT problems_users_id_fk2 FOREIGN KEY (solver_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

