--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
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
-- Name: hdb_catalog; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hdb_catalog;


ALTER SCHEMA hdb_catalog OWNER TO postgres;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: gen_hasura_uuid(); Type: FUNCTION; Schema: hdb_catalog; Owner: postgres
--

CREATE FUNCTION hdb_catalog.gen_hasura_uuid() RETURNS uuid
    LANGUAGE sql
    AS $$select gen_random_uuid()$$;


ALTER FUNCTION hdb_catalog.gen_hasura_uuid() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: hdb_action_log; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_action_log (
    id uuid DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    action_name text,
    input_payload jsonb NOT NULL,
    request_headers jsonb NOT NULL,
    session_variables jsonb NOT NULL,
    response_payload jsonb,
    errors jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    response_received_at timestamp with time zone,
    status text NOT NULL,
    CONSTRAINT hdb_action_log_status_check CHECK ((status = ANY (ARRAY['created'::text, 'processing'::text, 'completed'::text, 'error'::text])))
);


ALTER TABLE hdb_catalog.hdb_action_log OWNER TO postgres;

--
-- Name: hdb_cron_event_invocation_logs; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_cron_event_invocation_logs (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    event_id text,
    status integer,
    request json,
    response json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE hdb_catalog.hdb_cron_event_invocation_logs OWNER TO postgres;

--
-- Name: hdb_cron_events; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_cron_events (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    trigger_name text NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    status text DEFAULT 'scheduled'::text NOT NULL,
    tries integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    next_retry_at timestamp with time zone,
    CONSTRAINT valid_status CHECK ((status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text])))
);


ALTER TABLE hdb_catalog.hdb_cron_events OWNER TO postgres;

--
-- Name: hdb_metadata; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_metadata (
    id integer NOT NULL,
    metadata json NOT NULL,
    resource_version integer DEFAULT 1 NOT NULL
);


ALTER TABLE hdb_catalog.hdb_metadata OWNER TO postgres;

--
-- Name: hdb_scheduled_event_invocation_logs; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_scheduled_event_invocation_logs (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    event_id text,
    status integer,
    request json,
    response json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE hdb_catalog.hdb_scheduled_event_invocation_logs OWNER TO postgres;

--
-- Name: hdb_scheduled_events; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_scheduled_events (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    webhook_conf json NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    retry_conf json,
    payload json,
    header_conf json,
    status text DEFAULT 'scheduled'::text NOT NULL,
    tries integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    next_retry_at timestamp with time zone,
    comment text,
    CONSTRAINT valid_status CHECK ((status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text])))
);


ALTER TABLE hdb_catalog.hdb_scheduled_events OWNER TO postgres;

--
-- Name: hdb_schema_notifications; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_schema_notifications (
    id integer NOT NULL,
    notification json NOT NULL,
    resource_version integer DEFAULT 1 NOT NULL,
    instance_id uuid NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hdb_schema_notifications_id_check CHECK ((id = 1))
);


ALTER TABLE hdb_catalog.hdb_schema_notifications OWNER TO postgres;

--
-- Name: hdb_version; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_version (
    hasura_uuid uuid DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    version text NOT NULL,
    upgraded_on timestamp with time zone NOT NULL,
    cli_state jsonb DEFAULT '{}'::jsonb NOT NULL,
    console_state jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE hdb_catalog.hdb_version OWNER TO postgres;

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
-- Data for Name: hdb_action_log; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_action_log (id, action_name, input_payload, request_headers, session_variables, response_payload, errors, created_at, response_received_at, status) FROM stdin;
\.


--
-- Data for Name: hdb_cron_event_invocation_logs; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_cron_event_invocation_logs (id, event_id, status, request, response, created_at) FROM stdin;
\.


--
-- Data for Name: hdb_cron_events; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_cron_events (id, trigger_name, scheduled_time, status, tries, created_at, next_retry_at) FROM stdin;
\.


--
-- Data for Name: hdb_metadata; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_metadata (id, metadata, resource_version) FROM stdin;
1	{"actions":[{"definition":{"arguments":[{"name":"username","type":"String!"},{"name":"password","type":"String!"},{"name":"token","type":"String!"},{"name":"email","type":"String"},{"name":"firstname","type":"String"},{"name":"lastname","type":"String"},{"name":"loggedinduration","type":"Int!"}],"handler":"http://authentication-service:9876/api/v1/createUser","kind":"synchronous","output_type":"CreateUserOutput","timeout":60,"type":"mutation"},"name":"createUser","permissions":[{"role":"readonly"}]},{"definition":{"arguments":[{"name":"token","type":"String!"},{"name":"username","type":"String!"}],"handler":"http://authentication-service:9876/api/v1/deleteUser","kind":"synchronous","output_type":"DeleteUserOutput","timeout":60,"type":"mutation"},"name":"deleteUser","permissions":[{"role":"readonly"}]},{"comment":"login action","definition":{"arguments":[{"name":"username","type":"String!"},{"name":"password","type":"String!"}],"handler":"http://authentication-service:9876/api/v1/login","kind":"synchronous","output_type":"LoginOutput","timeout":60,"type":"mutation"},"name":"login","permissions":[{"role":"readonly"}]},{"definition":{"arguments":[{"name":"token","type":"String!"}],"handler":"http://authentication-service:9876/api/v1/logout","kind":"synchronous","output_type":"LogoutOutput","timeout":60,"type":"mutation"},"name":"logout","permissions":[{"role":"readonly"}]},{"definition":{"arguments":[{"name":"token","type":"String!"}],"handler":"http://authentication-service:9876/api/v1/refreshToken","kind":"synchronous","output_type":"RefreshTokenOutput","timeout":60,"type":"mutation"},"name":"refreshToken","permissions":[{"role":"readonly"}]},{"comment":"updatePassword","definition":{"arguments":[{"name":"username","type":"String!"},{"name":"password","type":"String!"},{"name":"token","type":"String!"}],"handler":"http://authentication-service:9876/api/v1/updatePassword","kind":"synchronous","output_type":"UpdatePasswordOutput","timeout":60,"type":"mutation"},"name":"updatePassword","permissions":[{"role":"readonly"}]},{"definition":{"arguments":[{"name":"token","type":"String!"}],"handler":"http://authentication-service:9876/api/v1/validateToken","output_type":"ValidateOutput","timeout":60,"type":"query"},"name":"validateToken","permissions":[{"role":"readonly"}]}],"custom_types":{"input_objects":[{"fields":[{"name":"username","type":"String!"},{"name":"password","type":"String!"}],"name":"UsernamePasswordInput"},{"fields":[{"name":"token","type":"String!"}],"name":"LogoutInput"}],"objects":[{"fields":[{"name":"token","type":"String"},{"name":"expirationTime","type":"String"}],"name":"LoginOutput"},{"fields":[{"name":"isLoggedOut","type":"Boolean!"},{"name":"isSessionFound","type":"Boolean!"}],"name":"LogoutOutput"},{"fields":[{"name":"isValid","type":"Boolean!"}],"name":"ValidateOutput"},{"fields":[{"name":"isUserAdded","type":"Boolean!"},{"name":"isUserAlreadyExists","type":"Boolean!"},{"name":"isAuthorized","type":"Boolean!"}],"name":"CreateUserOutput"},{"fields":[{"name":"token","type":"String"},{"name":"expirationTime","type":"String"}],"name":"RefreshTokenOutput"},{"fields":[{"name":"isAuthorized","type":"Boolean!"},{"name":"isUserDeleted","type":"Boolean!"},{"name":"isUserFound","type":"Boolean!"}],"name":"DeleteUserOutput"},{"fields":[{"name":"isUpdated","type":"Boolean!"},{"name":"isUserFound","type":"Boolean!"}],"name":"UpdatePasswordOutput"}]},"sources":[{"configuration":{"connection_info":{"database_url":"postgres://postgres:c1XZQpk9dbxT2r5wS2271CSfM@authentication-service-postgresql:5432/postgres","isolation_level":"read-committed","use_prepared_statements":false}},"customization":{"naming_convention":"hasura-default"},"kind":"postgres","name":"k8s postgres","tables":[{"object_relationships":[{"name":"User","using":{"foreign_key_constraint_on":"userid"}}],"table":{"name":"UserSessions","schema":"public"}},{"array_relationships":[{"name":"UserSessions","using":{"foreign_key_constraint_on":{"column":"userid","table":{"name":"UserSessions","schema":"public"}}}}],"table":{"name":"Users","schema":"public"}}]}],"version":3}	54
\.


--
-- Data for Name: hdb_scheduled_event_invocation_logs; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_scheduled_event_invocation_logs (id, event_id, status, request, response, created_at) FROM stdin;
\.


--
-- Data for Name: hdb_scheduled_events; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_scheduled_events (id, webhook_conf, scheduled_time, retry_conf, payload, header_conf, status, tries, created_at, next_retry_at, comment) FROM stdin;
\.


--
-- Data for Name: hdb_schema_notifications; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_schema_notifications (id, notification, resource_version, instance_id, updated_at) FROM stdin;
1	{"metadata":false,"remote_schemas":[],"sources":[]}	54	db19727f-7b13-4efa-977f-b49d7f489d6a	2022-09-26 22:20:23.953823+00
\.


--
-- Data for Name: hdb_version; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_version (hasura_uuid, version, upgraded_on, cli_state, console_state) FROM stdin;
21b74d3e-96c4-4a50-a557-dfbdc1593b7b	47	2022-09-26 21:45:20.405852+00	{}	{"console_notifications": {"admin": {"date": "2022-10-06T18:25:07.679Z", "read": "default", "showBadge": false}}, "telemetryNotificationShown": true}
\.


--
-- Data for Name: UserSessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserSessions" (id, userid, sessiontoken, logintime, logouttime, expirationtime, ipaddress, isloggedout, createdat, updatedat) FROM stdin;
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

SELECT pg_catalog.setval('public."UserSessions_id_seq"', 28, true);


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 10, true);


--
-- Name: hdb_action_log hdb_action_log_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_action_log
    ADD CONSTRAINT hdb_action_log_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_event_invocation_logs hdb_cron_event_invocation_logs_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_event_invocation_logs
    ADD CONSTRAINT hdb_cron_event_invocation_logs_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_events hdb_cron_events_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_events
    ADD CONSTRAINT hdb_cron_events_pkey PRIMARY KEY (id);


--
-- Name: hdb_metadata hdb_metadata_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_metadata
    ADD CONSTRAINT hdb_metadata_pkey PRIMARY KEY (id);


--
-- Name: hdb_metadata hdb_metadata_resource_version_key; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_metadata
    ADD CONSTRAINT hdb_metadata_resource_version_key UNIQUE (resource_version);


--
-- Name: hdb_scheduled_event_invocation_logs hdb_scheduled_event_invocation_logs_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_event_invocation_logs
    ADD CONSTRAINT hdb_scheduled_event_invocation_logs_pkey PRIMARY KEY (id);


--
-- Name: hdb_scheduled_events hdb_scheduled_events_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_events
    ADD CONSTRAINT hdb_scheduled_events_pkey PRIMARY KEY (id);


--
-- Name: hdb_schema_notifications hdb_schema_notifications_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_schema_notifications
    ADD CONSTRAINT hdb_schema_notifications_pkey PRIMARY KEY (id);


--
-- Name: hdb_version hdb_version_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_version
    ADD CONSTRAINT hdb_version_pkey PRIMARY KEY (hasura_uuid);


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
-- Name: hdb_cron_event_invocation_event_id; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE INDEX hdb_cron_event_invocation_event_id ON hdb_catalog.hdb_cron_event_invocation_logs USING btree (event_id);


--
-- Name: hdb_cron_event_status; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE INDEX hdb_cron_event_status ON hdb_catalog.hdb_cron_events USING btree (status);


--
-- Name: hdb_cron_events_unique_scheduled; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE UNIQUE INDEX hdb_cron_events_unique_scheduled ON hdb_catalog.hdb_cron_events USING btree (trigger_name, scheduled_time) WHERE (status = 'scheduled'::text);


--
-- Name: hdb_scheduled_event_status; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE INDEX hdb_scheduled_event_status ON hdb_catalog.hdb_scheduled_events USING btree (status);


--
-- Name: hdb_version_one_row; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE UNIQUE INDEX hdb_version_one_row ON hdb_catalog.hdb_version USING btree (((version IS NOT NULL)));


--
-- Name: users_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_username_idx ON public."Users" USING btree (username);


--
-- Name: usersessions_sessiontoken_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usersessions_sessiontoken_idx ON public."UserSessions" USING btree (sessiontoken);


--
-- Name: hdb_cron_event_invocation_logs hdb_cron_event_invocation_logs_event_id_fkey; Type: FK CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_event_invocation_logs
    ADD CONSTRAINT hdb_cron_event_invocation_logs_event_id_fkey FOREIGN KEY (event_id) REFERENCES hdb_catalog.hdb_cron_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdb_scheduled_event_invocation_logs hdb_scheduled_event_invocation_logs_event_id_fkey; Type: FK CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_event_invocation_logs
    ADD CONSTRAINT hdb_scheduled_event_invocation_logs_event_id_fkey FOREIGN KEY (event_id) REFERENCES hdb_catalog.hdb_scheduled_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserSessions UserSessions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSessions"
    ADD CONSTRAINT "UserSessions_userid_fkey" FOREIGN KEY (userid) REFERENCES public."Users"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

