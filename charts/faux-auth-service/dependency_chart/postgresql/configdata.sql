--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-2.pgdg110+2)
-- Dumped by pg_dump version 14.5 (Homebrew)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: UserSessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserSessions" (
    id integer NOT NULL,
    userid integer NOT NULL,
    sessiontoken text NOT NULL,
    logintime timestamp with time zone NOT NULL,
    logouttime timestamp with time zone,
    expirationtime timestamp with time zone NOT NULL,
    ipaddress text NOT NULL,
    isloggedout boolean NOT NULL,
    createdat timestamp with time zone NOT NULL,
    updatedat timestamp with time zone
);


ALTER TABLE public."UserSessions" OWNER TO postgres;

--
-- Name: UserSessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."UserSessions" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."UserSessions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    salt text NOT NULL,
    email text,
    firstname text,
    lastname text,
    loggedinduration integer NOT NULL,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Users" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: UserSessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserSessions" (id, userid, sessiontoken, logintime, logouttime, expirationtime, ipaddress, isloggedout, createdat, updatedat) FROM stdin;
29	9	MTk1ZjcxNzMtNThhMC00MWRhLWI2NzAtZTMyY2I2OWQxOTYw	2022-10-27 01:43:12.008+00	2022-10-27 02:43:22.225+00	2022-10-27 02:43:12.008+00	::ffff:5.0.0.37	t	2022-10-27 01:43:12.008+00	2022-10-27 02:43:22.225+00
30	9	OTYwMjQ5ZTQtZWRiOS00MTQ2LWJjNjYtZTdlZDFjY2QxMGFm	2022-10-27 02:02:04.113+00	2022-10-27 03:02:23.143+00	2022-10-27 03:02:04.113+00	::ffff:5.0.0.37	t	2022-10-27 02:02:04.113+00	2022-10-27 03:02:23.143+00
31	9	NDJlYTViMTQtMjljMS00N2RiLWI0YjEtMDBiMWViYWM0ZDAw	2022-10-27 16:57:43.516+00	\N	2022-10-27 17:57:43.516+00	::ffff:5.0.0.37	f	2022-10-27 16:57:43.516+00	\N
32	9	ZDA2Y2NmZDMtODA1Ni00ZDY5LTkxNDMtNWE4NTdiOTg2YWU2	2022-10-27 16:57:44.569+00	\N	2022-10-27 17:57:44.569+00	::ffff:5.0.0.37	f	2022-10-27 16:57:44.569+00	\N
33	9	MzZmMGZhM2EtODc2YS00ODIyLWJkMmEtMmZkMzBjMDY0ZWY1	2022-10-27 17:29:26.717+00	\N	2022-10-27 18:29:26.717+00	::ffff:5.0.0.37	f	2022-10-27 17:29:26.717+00	\N
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (id, username, password, salt, email, firstname, lastname, loggedinduration, createdat, updatedat) FROM stdin;
9	admin@mycompany.com	bfb3e9dff980407f65b66a7bc5434d7b6b4c06f0e61da4b982050318828087fe9dcc67f1dec0e38952ae7cb6283cc07aecbf882c8517297411adb87451185d99	931ab45cb098f46a107f96435585cc19	\N	\N	\N	60	2022-10-05 22:06:05.400293+00	\N
10	viewer@mycompany.com	bfb3e9dff980407f65b66a7bc5434d7b6b4c06f0e61da4b982050318828087fe9dcc67f1dec0e38952ae7cb6283cc07aecbf882c8517297411adb87451185d99	931ab45cb098f46a107f96435585cc19	\N	\N	\N	60	2022-10-05 22:06:05.400293+00	\N
\.


--
-- Name: UserSessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserSessions_id_seq"', 33, true);


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 10, true);


--
-- Name: UserSessions UserSessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSessions"
    ADD CONSTRAINT "UserSessions_pkey" PRIMARY KEY (id);


--
-- Name: UserSessions UserSessions_sessiontoken_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSessions"
    ADD CONSTRAINT "UserSessions_sessiontoken_key" UNIQUE (sessiontoken);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: Users username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- Name: users_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_username_idx ON public."Users" USING btree (username);


--
-- Name: usersessions_sessiontoken_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usersessions_sessiontoken_idx ON public."UserSessions" USING btree (sessiontoken);


--
-- Name: UserSessions UserSessions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSessions"
    ADD CONSTRAINT "UserSessions_userid_fkey" FOREIGN KEY (userid) REFERENCES public."Users"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

