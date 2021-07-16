--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

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
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50) NOT NULL,
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    "group" integer,
    translations json,
    note text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    "limit" integer
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    filters json,
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    module_list json,
    collection_list json,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid NOT NULL,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(10) DEFAULT '#00C897'::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128) NOT NULL,
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(8) DEFAULT 'en-US'::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255)
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url text,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections text
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: records; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.records (
    id integer NOT NULL,
    country_region character varying(255) NOT NULL,
    date date NOT NULL,
    last_updated date NOT NULL,
    confirmed integer,
    deaths integer,
    recovered integer,
    active integer,
    test boolean DEFAULT false NOT NULL,
    test_2 boolean DEFAULT false NOT NULL
);


ALTER TABLE public.records OWNER TO directus;

--
-- Name: records_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.records_id_seq OWNER TO directus;

--
-- Name: records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.records_id_seq OWNED BY public.records.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: records id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.records ALTER COLUMN id SET DEFAULT nextval('public.records_id_seq'::regclass);


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) FROM stdin;
1	authenticate	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:04:18.278051+00	::ffff:192.168.160.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_users	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	\N
2	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:07:59.207549+00	192.168.160.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	records	5910	\N
3	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:11:32.033202+00	192.168.160.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_collections	records	\N
4	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:11:41.700778+00	192.168.160.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	1	\N
5	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:23:55.422476+00	192.168.176.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	2	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields) FROM stdin;
records	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) FROM stdin;
1	records	test	boolean	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
2	records	test_2	boolean	\N	\N	\N	\N	f	f	\N	full	\N	[{"language":"en-US"}]	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2021-07-16 08:03:47.16828+00
20201029A	Remove System Relations	2021-07-16 08:03:47.189432+00
20201029B	Remove System Collections	2021-07-16 08:03:47.21622+00
20201029C	Remove System Fields	2021-07-16 08:03:47.250114+00
20201105A	Add Cascade System Relations	2021-07-16 08:03:47.85338+00
20201105B	Change Webhook URL Type	2021-07-16 08:03:47.944814+00
20210225A	Add Relations Sort Field	2021-07-16 08:03:47.99183+00
20210304A	Remove Locked Fields	2021-07-16 08:03:48.044747+00
20210312A	Webhooks Collections Text	2021-07-16 08:03:48.127776+00
20210331A	Add Refresh Interval	2021-07-16 08:03:48.173782+00
20210415A	Make Filesize Nullable	2021-07-16 08:03:48.291771+00
20210416A	Add Collections Accountability	2021-07-16 08:03:48.330615+00
20210422A	Remove Files Interface	2021-07-16 08:03:48.359957+00
20210506A	Rename Interfaces	2021-07-16 08:03:48.410415+00
20210510A	Restructure Relations	2021-07-16 08:03:48.782167+00
20210518A	Add Foreign Key Constraints	2021-07-16 08:03:48.807504+00
20210519A	Add System Fk Triggers	2021-07-16 08:03:49.106162+00
20210521A	Add Collections Icon Color	2021-07-16 08:03:49.143738+00
20210608A	Add Deep Clone Config	2021-07-16 08:03:49.189629+00
20210626A	Change Filesize Bigint	2021-07-16 08:03:49.382495+00
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields, "limit") FROM stdin;
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, filters, layout, layout_query, layout_options, refresh_interval) FROM stdin;
2	Default View	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	\N	records	\N	\N	tabular	{"tabular":{"page":237,"fields":["country_region","date","last_updated","confirmed","deaths","recovered","active","test"]}}	{"tabular":{"widths":{"active":108,"test":86}}}	\N
1	\N	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	\N	records	\N	\N	tabular	{"tabular":{"page":237,"fields":["country_region","date","last_updated","confirmed","deaths","recovered","active","test","test_2"]}}	\N	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent) FROM stdin;
1	2	records	5910	{"country_region":"test","date":"2021-07-16","last_updated":"2021-07-16","confirmed":"1","deaths":"1","recovered":"1","active":"1","id":5910}	{"country_region":"test","date":"2021-07-16","last_updated":"2021-07-16","confirmed":"1","deaths":"1","recovered":"1","active":"1","id":5910}	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) FROM stdin;
a8b4bfd5-89c6-4d14-8caa-7b89e0b128bd	Admin	supervised_user_circle	\N	\N	f	\N	\N	t	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent) FROM stdin;
pdD7A1ZWbmTBJeRLY_byScoi_qvit3Ke-Qhd35hN7LzqK9SsZ-qgkntKoayoF04o	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-23 08:23:19.606+00	::ffff:192.168.160.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page) FROM stdin;
5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	\N	\N	admin@example.com	$argon2i$v=19$m=4096,t=3,p=1$PpoxG9cbBVX2YrtJWtSY7g$NAtba08/dP74ABBuK/um0v7Z4zrt8hhO5fZ8UfiNXl4	\N	\N	\N	\N	\N	en-US	auto	\N	active	a8b4bfd5-89c6-4d14-8caa-7b89e0b128bd	\N	2021-07-16 08:23:19.627+00	/collections/records
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections) FROM stdin;
\.


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.records (id, country_region, date, last_updated, confirmed, deaths, recovered, active, test, test_2) FROM stdin;
1	Afghanistan	2020-05-01	2020-05-02	2291	68	310	1957	f	f
2	Afghanistan	2020-05-02	2020-05-03	2470	72	331	2066	f	f
3	Afghanistan	2020-05-03	2020-05-04	2705	85	345	2274	f	f
4	Afghanistan	2020-05-04	2020-05-05	2895	90	397	2407	f	f
5	Afghanistan	2020-05-05	2020-05-06	3225	95	421	2708	f	f
6	Afghanistan	2020-05-06	2020-05-07	3393	104	458	2830	f	f
7	Afghanistan	2020-05-07	2020-05-08	3564	106	468	2989	f	f
8	Afghanistan	2020-05-08	2020-05-09	3781	109	472	3197	f	f
9	Afghanistan	2020-05-09	2020-05-10	4042	115	502	3416	f	f
10	Afghanistan	2020-05-10	2020-05-11	4403	120	558	3724	f	f
11	Afghanistan	2020-05-11	2020-05-12	4687	122	558	4007	f	f
12	Afghanistan	2020-05-12	2020-05-13	4968	127	610	4226	f	f
13	Afghanistan	2020-05-13	2020-05-14	5227	132	648	4446	f	f
14	Afghanistan	2020-05-14	2020-05-15	5640	136	691	4812	f	f
15	Afghanistan	2020-05-15	2020-05-16	6054	153	745	5155	f	f
16	Afghanistan	2020-05-16	2020-05-17	6403	168	745	5489	f	f
17	Afghanistan	2020-05-17	2020-05-18	6665	170	778	5717	f	f
18	Afghanistan	2020-05-18	2020-05-19	7073	173	801	6098	f	f
19	Afghanistan	2020-05-19	2020-05-20	7654	178	850	6625	f	f
20	Afghanistan	2020-05-20	2020-05-21	8146	188	930	7028	f	f
21	Afghanistan	2020-05-21	2020-05-22	8677	194	938	7545	f	f
22	Afghanistan	2020-05-22	2020-05-23	9219	206	996	8015	f	f
23	Afghanistan	2020-05-23	2020-05-24	10001	217	1040	8742	f	f
24	Afghanistan	2020-05-24	2020-05-25	10585	219	1075	9289	f	f
25	Afghanistan	2020-05-25	2020-05-26	11176	220	1097	9857	f	f
26	Afghanistan	2020-05-26	2020-05-27	11834	221	1128	10483	f	f
27	Afghanistan	2020-05-27	2020-05-28	12459	228	1138	11091	f	f
28	Afghanistan	2020-05-28	2020-05-29	13039	236	1209	11592	f	f
29	Afghanistan	2020-05-29	2020-05-30	13662	247	1259	12154	f	f
30	Afghanistan	2020-05-30	2020-05-31	14528	250	1303	12973	f	f
31	Afghanistan	2020-05-31	2020-06-01	15208	258	1328	13620	f	f
32	Albania	2020-05-01	2020-05-02	782	31	488	263	f	f
33	Albania	2020-05-02	2020-05-03	789	31	519	239	f	f
34	Albania	2020-05-03	2020-05-04	795	31	531	233	f	f
35	Albania	2020-05-04	2020-05-05	803	31	543	229	f	f
36	Albania	2020-05-05	2020-05-06	820	31	570	219	f	f
37	Albania	2020-05-06	2020-05-07	832	31	595	206	f	f
38	Albania	2020-05-07	2020-05-08	842	31	605	206	f	f
39	Albania	2020-05-08	2020-05-09	850	31	620	199	f	f
40	Albania	2020-05-09	2020-05-10	856	31	627	198	f	f
41	Albania	2020-05-10	2020-05-11	868	31	650	187	f	f
42	Albania	2020-05-11	2020-05-12	872	31	654	187	f	f
43	Albania	2020-05-12	2020-05-13	876	31	682	163	f	f
44	Albania	2020-05-13	2020-05-14	880	31	688	161	f	f
45	Albania	2020-05-14	2020-05-15	898	31	694	173	f	f
46	Albania	2020-05-15	2020-05-16	916	31	705	180	f	f
47	Albania	2020-05-16	2020-05-17	933	31	714	188	f	f
48	Albania	2020-05-17	2020-05-18	946	31	715	200	f	f
49	Albania	2020-05-18	2020-05-19	948	31	727	190	f	f
50	Albania	2020-05-19	2020-05-20	949	31	742	176	f	f
51	Albania	2020-05-20	2020-05-21	964	31	758	175	f	f
52	Albania	2020-05-21	2020-05-22	969	31	771	167	f	f
53	Albania	2020-05-22	2020-05-23	981	31	777	173	f	f
54	Albania	2020-05-23	2020-05-24	989	31	783	175	f	f
55	Albania	2020-05-24	2020-05-25	998	32	789	177	f	f
56	Albania	2020-05-25	2020-05-26	1004	32	795	177	f	f
57	Albania	2020-05-26	2020-05-27	1029	33	803	193	f	f
58	Albania	2020-05-27	2020-05-28	1050	33	812	205	f	f
59	Albania	2020-05-28	2020-05-29	1076	33	823	220	f	f
60	Albania	2020-05-29	2020-05-30	1099	33	851	215	f	f
61	Albania	2020-05-30	2020-05-31	1122	33	857	232	f	f
62	Albania	2020-05-31	2020-06-01	1137	33	872	232	f	f
63	Algeria	2020-05-01	2020-05-02	4154	453	1821	1880	f	f
64	Algeria	2020-05-02	2020-05-03	4295	459	1872	1964	f	f
65	Algeria	2020-05-03	2020-05-04	4474	463	1936	2075	f	f
66	Algeria	2020-05-04	2020-05-05	4648	465	1998	2185	f	f
67	Algeria	2020-05-05	2020-05-06	4838	470	2067	2301	f	f
68	Algeria	2020-05-06	2020-05-07	4997	476	2197	2324	f	f
69	Algeria	2020-05-07	2020-05-08	5182	483	2323	2376	f	f
70	Algeria	2020-05-08	2020-05-09	5369	488	2467	2414	f	f
71	Algeria	2020-05-09	2020-05-10	5558	494	2546	2518	f	f
72	Algeria	2020-05-10	2020-05-11	5723	502	2678	2543	f	f
73	Algeria	2020-05-11	2020-05-12	5891	507	2841	2543	f	f
74	Algeria	2020-05-12	2020-05-13	6067	515	2998	2554	f	f
75	Algeria	2020-05-13	2020-05-14	6253	522	3058	2673	f	f
76	Algeria	2020-05-14	2020-05-15	6442	529	3158	2755	f	f
77	Algeria	2020-05-15	2020-05-16	6629	536	3271	2822	f	f
78	Algeria	2020-05-16	2020-05-17	6821	542	3409	2870	f	f
79	Algeria	2020-05-17	2020-05-18	7019	548	3507	2964	f	f
80	Algeria	2020-05-18	2020-05-19	7201	555	3625	3021	f	f
81	Algeria	2020-05-19	2020-05-20	7377	561	3746	3070	f	f
82	Algeria	2020-05-20	2020-05-21	7542	568	3968	3006	f	f
83	Algeria	2020-05-21	2020-05-22	7728	575	4062	3091	f	f
84	Algeria	2020-05-22	2020-05-23	7918	582	4256	3080	f	f
85	Algeria	2020-05-23	2020-05-24	8113	592	4426	3095	f	f
86	Algeria	2020-05-24	2020-05-25	8306	600	4784	2922	f	f
87	Algeria	2020-05-25	2020-05-26	8503	609	4747	3147	f	f
88	Algeria	2020-05-26	2020-05-27	8697	617	4918	3162	f	f
89	Algeria	2020-05-27	2020-05-28	8857	623	5129	3105	f	f
90	Algeria	2020-05-28	2020-05-29	8997	630	5277	3090	f	f
91	Algeria	2020-05-29	2020-05-30	9134	638	5422	3074	f	f
92	Algeria	2020-05-30	2020-05-31	9267	646	5549	3072	f	f
93	Algeria	2020-05-31	2020-06-01	9394	653	5748	2993	f	f
94	Andorra	2020-05-01	2020-05-02	745	43	468	234	f	f
95	Andorra	2020-05-02	2020-05-03	747	44	472	231	f	f
96	Andorra	2020-05-03	2020-05-04	748	45	493	210	f	f
97	Andorra	2020-05-04	2020-05-05	750	45	499	206	f	f
98	Andorra	2020-05-05	2020-05-06	751	46	514	191	f	f
99	Andorra	2020-05-06	2020-05-07	751	46	521	184	f	f
100	Andorra	2020-05-07	2020-05-08	752	47	526	179	f	f
101	Andorra	2020-05-08	2020-05-09	752	47	537	168	f	f
102	Andorra	2020-05-09	2020-05-10	754	48	545	161	f	f
103	Andorra	2020-05-10	2020-05-11	755	48	550	157	f	f
104	Andorra	2020-05-11	2020-05-12	755	48	550	157	f	f
105	Andorra	2020-05-12	2020-05-13	758	48	568	142	f	f
106	Andorra	2020-05-13	2020-05-14	760	49	576	135	f	f
107	Andorra	2020-05-14	2020-05-15	761	49	596	116	f	f
108	Andorra	2020-05-15	2020-05-16	761	49	604	108	f	f
109	Andorra	2020-05-16	2020-05-17	761	51	615	95	f	f
110	Andorra	2020-05-17	2020-05-18	761	51	617	93	f	f
111	Andorra	2020-05-18	2020-05-19	761	51	624	86	f	f
112	Andorra	2020-05-19	2020-05-20	761	51	628	82	f	f
113	Andorra	2020-05-20	2020-05-21	762	51	639	72	f	f
114	Andorra	2020-05-21	2020-05-22	762	51	639	72	f	f
115	Andorra	2020-05-22	2020-05-23	762	51	652	59	f	f
116	Andorra	2020-05-23	2020-05-24	762	51	653	58	f	f
117	Andorra	2020-05-24	2020-05-25	762	51	653	58	f	f
118	Andorra	2020-05-25	2020-05-26	763	51	663	49	f	f
119	Andorra	2020-05-26	2020-05-27	763	51	676	36	f	f
120	Andorra	2020-05-27	2020-05-28	763	51	676	36	f	f
121	Andorra	2020-05-28	2020-05-29	763	51	681	31	f	f
122	Andorra	2020-05-29	2020-05-30	764	51	684	29	f	f
123	Andorra	2020-05-30	2020-05-31	764	51	692	21	f	f
124	Andorra	2020-05-31	2020-06-01	764	51	694	19	f	f
125	Angola	2020-05-01	2020-05-02	30	2	11	17	f	f
126	Angola	2020-05-02	2020-05-03	35	2	11	22	f	f
127	Angola	2020-05-03	2020-05-04	35	2	11	22	f	f
128	Angola	2020-05-04	2020-05-05	35	2	11	22	f	f
129	Angola	2020-05-05	2020-05-06	36	2	11	23	f	f
130	Angola	2020-05-06	2020-05-07	36	2	11	23	f	f
131	Angola	2020-05-07	2020-05-08	36	2	11	23	f	f
132	Angola	2020-05-08	2020-05-09	43	2	11	30	f	f
133	Angola	2020-05-09	2020-05-10	43	2	13	28	f	f
134	Angola	2020-05-10	2020-05-11	45	2	13	30	f	f
135	Angola	2020-05-11	2020-05-12	45	2	13	30	f	f
136	Angola	2020-05-12	2020-05-13	45	2	13	30	f	f
137	Angola	2020-05-13	2020-05-14	45	2	14	29	f	f
138	Angola	2020-05-14	2020-05-15	48	2	14	32	f	f
139	Angola	2020-05-15	2020-05-16	48	2	17	29	f	f
140	Angola	2020-05-16	2020-05-17	48	2	17	29	f	f
141	Angola	2020-05-17	2020-05-18	48	2	17	29	f	f
142	Angola	2020-05-18	2020-05-19	50	3	17	30	f	f
143	Angola	2020-05-19	2020-05-20	52	3	17	32	f	f
144	Angola	2020-05-20	2020-05-21	52	3	17	32	f	f
145	Angola	2020-05-21	2020-05-22	58	3	17	38	f	f
146	Angola	2020-05-22	2020-05-23	60	3	17	40	f	f
147	Angola	2020-05-23	2020-05-24	61	4	18	39	f	f
148	Angola	2020-05-24	2020-05-25	69	4	18	47	f	f
149	Angola	2020-05-25	2020-05-26	70	4	18	48	f	f
150	Angola	2020-05-26	2020-05-27	70	4	18	48	f	f
151	Angola	2020-05-27	2020-05-28	71	4	18	49	f	f
152	Angola	2020-05-28	2020-05-29	74	4	18	52	f	f
153	Angola	2020-05-29	2020-05-30	81	4	18	59	f	f
154	Angola	2020-05-30	2020-05-31	84	4	18	62	f	f
155	Angola	2020-05-31	2020-06-01	86	4	18	64	f	f
156	Antigua and Barbuda	2020-05-01	2020-05-02	25	3	15	7	f	f
157	Antigua and Barbuda	2020-05-02	2020-05-03	25	3	15	7	f	f
158	Antigua and Barbuda	2020-05-03	2020-05-04	25	3	15	7	f	f
159	Antigua and Barbuda	2020-05-04	2020-05-05	25	3	15	7	f	f
160	Antigua and Barbuda	2020-05-05	2020-05-06	25	3	16	6	f	f
161	Antigua and Barbuda	2020-05-06	2020-05-07	25	3	16	6	f	f
162	Antigua and Barbuda	2020-05-07	2020-05-08	25	3	16	6	f	f
163	Antigua and Barbuda	2020-05-08	2020-05-09	25	3	16	6	f	f
164	Antigua and Barbuda	2020-05-09	2020-05-10	25	3	19	3	f	f
165	Antigua and Barbuda	2020-05-10	2020-05-11	25	3	19	3	f	f
166	Antigua and Barbuda	2020-05-11	2020-05-12	25	3	19	3	f	f
167	Antigua and Barbuda	2020-05-12	2020-05-13	25	3	19	3	f	f
168	Antigua and Barbuda	2020-05-13	2020-05-14	25	3	19	3	f	f
169	Antigua and Barbuda	2020-05-14	2020-05-15	25	3	19	3	f	f
170	Antigua and Barbuda	2020-05-15	2020-05-16	25	3	19	3	f	f
171	Antigua and Barbuda	2020-05-16	2020-05-17	25	3	19	3	f	f
172	Antigua and Barbuda	2020-05-17	2020-05-18	25	3	19	3	f	f
173	Antigua and Barbuda	2020-05-18	2020-05-19	25	3	19	3	f	f
174	Antigua and Barbuda	2020-05-19	2020-05-20	25	3	19	3	f	f
175	Antigua and Barbuda	2020-05-20	2020-05-21	25	3	19	3	f	f
176	Antigua and Barbuda	2020-05-21	2020-05-22	25	3	19	3	f	f
177	Antigua and Barbuda	2020-05-22	2020-05-23	25	3	19	3	f	f
178	Antigua and Barbuda	2020-05-23	2020-05-24	25	3	19	3	f	f
179	Antigua and Barbuda	2020-05-24	2020-05-25	25	3	19	3	f	f
180	Antigua and Barbuda	2020-05-25	2020-05-26	25	3	19	3	f	f
181	Antigua and Barbuda	2020-05-26	2020-05-27	25	3	19	3	f	f
182	Antigua and Barbuda	2020-05-27	2020-05-28	25	3	19	3	f	f
183	Antigua and Barbuda	2020-05-28	2020-05-29	25	3	19	3	f	f
184	Antigua and Barbuda	2020-05-29	2020-05-30	25	3	19	3	f	f
185	Antigua and Barbuda	2020-05-30	2020-05-31	25	3	19	3	f	f
186	Antigua and Barbuda	2020-05-31	2020-06-01	26	3	19	4	f	f
187	Argentina	2020-05-01	2020-05-02	4532	225	1292	3015	f	f
188	Argentina	2020-05-02	2020-05-03	4681	237	1320	3124	f	f
189	Argentina	2020-05-03	2020-05-04	4783	246	1354	3183	f	f
190	Argentina	2020-05-04	2020-05-05	4887	260	1442	3185	f	f
191	Argentina	2020-05-05	2020-05-06	5020	264	1472	3284	f	f
192	Argentina	2020-05-06	2020-05-07	5208	273	1524	3411	f	f
193	Argentina	2020-05-07	2020-05-08	5371	282	1601	3488	f	f
194	Argentina	2020-05-08	2020-05-09	5611	293	1659	3659	f	f
195	Argentina	2020-05-09	2020-05-10	5776	300	1728	3748	f	f
196	Argentina	2020-05-10	2020-05-11	6034	305	1757	3972	f	f
197	Argentina	2020-05-11	2020-05-12	6278	314	1837	4127	f	f
198	Argentina	2020-05-12	2020-05-13	6563	319	1862	4382	f	f
199	Argentina	2020-05-13	2020-05-14	6879	329	2266	4284	f	f
200	Argentina	2020-05-14	2020-05-15	7134	353	2385	4396	f	f
201	Argentina	2020-05-15	2020-05-16	7479	356	2497	4626	f	f
202	Argentina	2020-05-16	2020-05-17	7805	363	2534	4908	f	f
203	Argentina	2020-05-17	2020-05-18	8068	373	2569	5126	f	f
204	Argentina	2020-05-18	2020-05-19	8371	382	2625	5364	f	f
205	Argentina	2020-05-19	2020-05-20	8809	393	2872	5544	f	f
206	Argentina	2020-05-20	2020-05-21	9283	403	2933	5947	f	f
207	Argentina	2020-05-21	2020-05-22	9931	416	3032	6483	f	f
208	Argentina	2020-05-22	2020-05-23	10649	433	3062	7154	f	f
209	Argentina	2020-05-23	2020-05-24	11353	445	3530	7378	f	f
210	Argentina	2020-05-24	2020-05-25	12076	452	3732	7892	f	f
211	Argentina	2020-05-25	2020-05-26	12628	467	3999	8162	f	f
212	Argentina	2020-05-26	2020-05-27	13228	484	4167	8577	f	f
213	Argentina	2020-05-27	2020-05-28	13933	500	4349	9084	f	f
214	Argentina	2020-05-28	2020-05-29	14702	508	4617	9577	f	f
215	Argentina	2020-05-29	2020-05-30	15419	520	4788	10111	f	f
216	Argentina	2020-05-30	2020-05-31	16214	528	4788	10898	f	f
217	Argentina	2020-05-31	2020-06-01	16851	539	5336	10976	f	f
218	Armenia	2020-05-01	2020-05-02	2148	33	977	1138	f	f
219	Armenia	2020-05-02	2020-05-03	2273	33	1010	1230	f	f
220	Armenia	2020-05-03	2020-05-04	2386	35	1035	1316	f	f
221	Armenia	2020-05-04	2020-05-05	2507	39	1071	1397	f	f
222	Armenia	2020-05-05	2020-05-06	2619	40	1111	1468	f	f
223	Armenia	2020-05-06	2020-05-07	2782	40	1135	1607	f	f
224	Armenia	2020-05-07	2020-05-08	2884	42	1185	1657	f	f
225	Armenia	2020-05-08	2020-05-09	3029	43	1218	1768	f	f
226	Armenia	2020-05-09	2020-05-10	3175	44	1267	1864	f	f
227	Armenia	2020-05-10	2020-05-11	3313	45	1325	1943	f	f
228	Armenia	2020-05-11	2020-05-12	3392	46	1359	1987	f	f
229	Armenia	2020-05-12	2020-05-13	3538	47	1430	2061	f	f
230	Armenia	2020-05-13	2020-05-14	3718	48	1500	2170	f	f
231	Armenia	2020-05-14	2020-05-15	3860	49	1572	2239	f	f
232	Armenia	2020-05-15	2020-05-16	4044	52	1666	2326	f	f
233	Armenia	2020-05-16	2020-05-17	4283	55	1791	2437	f	f
234	Armenia	2020-05-17	2020-05-18	4472	60	1925	2487	f	f
235	Armenia	2020-05-18	2020-05-19	4823	61	2019	2743	f	f
236	Armenia	2020-05-19	2020-05-20	5041	64	2164	2813	f	f
237	Armenia	2020-05-20	2020-05-21	5271	67	2419	2785	f	f
238	Armenia	2020-05-21	2020-05-22	5606	70	2581	2955	f	f
239	Armenia	2020-05-22	2020-05-23	5928	74	2874	2980	f	f
240	Armenia	2020-05-23	2020-05-24	6302	77	2936	3289	f	f
241	Armenia	2020-05-24	2020-05-25	6661	81	3064	3516	f	f
242	Armenia	2020-05-25	2020-05-26	7113	87	3145	3881	f	f
243	Armenia	2020-05-26	2020-05-27	7402	91	3220	4091	f	f
244	Armenia	2020-05-27	2020-05-28	7774	98	3255	4421	f	f
245	Armenia	2020-05-28	2020-05-29	8216	113	3287	4816	f	f
246	Armenia	2020-05-29	2020-05-30	8676	120	3297	5259	f	f
247	Armenia	2020-05-30	2020-05-31	8927	127	3317	5483	f	f
248	Armenia	2020-05-31	2020-06-01	9282	131	3386	5765	f	f
249	Australia	2020-05-01	2020-05-02	6778	93	5775	910	f	f
250	Australia	2020-05-02	2020-05-03	6799	94	5814	891	f	f
251	Australia	2020-05-03	2020-05-04	6822	95	5849	878	f	f
252	Australia	2020-05-04	2020-05-05	6847	96	5887	864	f	f
253	Australia	2020-05-05	2020-05-06	6875	97	5975	803	f	f
254	Australia	2020-05-06	2020-05-07	6894	97	6031	766	f	f
255	Australia	2020-05-07	2020-05-08	6913	97	6078	738	f	f
256	Australia	2020-05-08	2020-05-09	6918	97	6122	699	f	f
257	Australia	2020-05-09	2020-05-10	6939	97	6141	701	f	f
258	Australia	2020-05-10	2020-05-11	6948	97	6167	684	f	f
259	Australia	2020-05-11	2020-05-12	6970	97	6213	660	f	f
260	Australia	2020-05-12	2020-05-13	6980	98	6270	612	f	f
261	Australia	2020-05-13	2020-05-14	6989	98	6297	594	f	f
262	Australia	2020-05-14	2020-05-15	7019	98	6334	587	f	f
263	Australia	2020-05-15	2020-05-16	7035	98	6359	578	f	f
264	Australia	2020-05-16	2020-05-17	7044	98	6364	582	f	f
265	Australia	2020-05-17	2020-05-18	7054	99	6392	563	f	f
266	Australia	2020-05-18	2020-05-19	7068	99	6413	556	f	f
267	Australia	2020-05-19	2020-05-20	7072	100	6431	541	f	f
268	Australia	2020-05-20	2020-05-21	7081	100	6470	511	f	f
269	Australia	2020-05-21	2020-05-22	7095	101	6478	516	f	f
270	Australia	2020-05-22	2020-05-23	7099	101	6485	513	f	f
271	Australia	2020-05-23	2020-05-24	7114	102	6508	504	f	f
272	Australia	2020-05-24	2020-05-25	7114	102	6531	481	f	f
273	Australia	2020-05-25	2020-05-26	7126	102	6552	472	f	f
274	Australia	2020-05-26	2020-05-27	7139	103	6560	476	f	f
275	Australia	2020-05-27	2020-05-28	7150	103	6579	468	f	f
276	Australia	2020-05-28	2020-05-29	7165	103	6576	486	f	f
277	Australia	2020-05-29	2020-05-30	7184	103	6605	476	f	f
278	Australia	2020-05-30	2020-05-31	7192	103	6614	475	f	f
279	Australia	2020-05-31	2020-06-01	7202	103	6618	481	f	f
280	Austria	2020-05-01	2020-05-02	15531	589	13110	1832	f	f
281	Austria	2020-05-02	2020-05-03	15558	596	13180	1782	f	f
282	Austria	2020-05-03	2020-05-04	15597	598	13228	1771	f	f
283	Austria	2020-05-04	2020-05-05	15621	600	13316	1705	f	f
284	Austria	2020-05-05	2020-05-06	15650	606	13462	1582	f	f
285	Austria	2020-05-06	2020-05-07	15684	608	13639	1437	f	f
286	Austria	2020-05-07	2020-05-08	15752	609	13698	1445	f	f
287	Austria	2020-05-08	2020-05-09	15774	614	13836	1324	f	f
288	Austria	2020-05-09	2020-05-10	15833	615	13928	1290	f	f
289	Austria	2020-05-10	2020-05-11	15871	618	13991	1262	f	f
290	Austria	2020-05-11	2020-05-12	15882	620	14061	1201	f	f
291	Austria	2020-05-12	2020-05-13	15961	623	14148	1190	f	f
292	Austria	2020-05-13	2020-05-14	15997	624	14304	1069	f	f
293	Austria	2020-05-14	2020-05-15	16058	626	14405	1027	f	f
294	Austria	2020-05-15	2020-05-16	16109	628	14471	1010	f	f
295	Austria	2020-05-16	2020-05-17	16201	629	14524	1048	f	f
296	Austria	2020-05-17	2020-05-18	16242	629	14563	1050	f	f
297	Austria	2020-05-18	2020-05-19	16269	629	14614	1026	f	f
298	Austria	2020-05-19	2020-05-20	16321	632	14678	1011	f	f
299	Austria	2020-05-20	2020-05-21	16353	633	14882	838	f	f
300	Austria	2020-05-21	2020-05-22	16404	633	14951	820	f	f
301	Austria	2020-05-22	2020-05-23	16436	635	15005	796	f	f
302	Austria	2020-05-23	2020-05-24	16486	639	15037	810	f	f
303	Austria	2020-05-24	2020-05-25	16503	640	15063	800	f	f
304	Austria	2020-05-25	2020-05-26	16539	641	15138	760	f	f
305	Austria	2020-05-26	2020-05-27	16557	643	15182	732	f	f
306	Austria	2020-05-27	2020-05-28	16591	645	15228	718	f	f
307	Austria	2020-05-28	2020-05-29	16628	668	15286	674	f	f
308	Austria	2020-05-29	2020-05-30	16655	668	15347	640	f	f
309	Austria	2020-05-30	2020-05-31	16685	668	15520	497	f	f
310	Austria	2020-05-31	2020-06-01	16731	668	15593	470	f	f
311	Azerbaijan	2020-05-01	2020-05-02	1854	25	1365	464	f	f
312	Azerbaijan	2020-05-02	2020-05-03	1894	25	1411	458	f	f
313	Azerbaijan	2020-05-03	2020-05-04	1932	25	1441	466	f	f
314	Azerbaijan	2020-05-04	2020-05-05	1984	26	1480	478	f	f
315	Azerbaijan	2020-05-05	2020-05-06	2060	26	1508	526	f	f
316	Azerbaijan	2020-05-06	2020-05-07	2127	28	1536	563	f	f
317	Azerbaijan	2020-05-07	2020-05-08	2204	28	1551	625	f	f
318	Azerbaijan	2020-05-08	2020-05-09	2279	28	1576	675	f	f
319	Azerbaijan	2020-05-09	2020-05-10	2422	31	1620	771	f	f
320	Azerbaijan	2020-05-10	2020-05-11	2519	32	1650	837	f	f
321	Azerbaijan	2020-05-11	2020-05-12	2589	32	1680	877	f	f
322	Azerbaijan	2020-05-12	2020-05-13	2693	33	1680	980	f	f
323	Azerbaijan	2020-05-13	2020-05-14	2758	35	1789	934	f	f
324	Azerbaijan	2020-05-14	2020-05-15	2879	35	1833	1011	f	f
325	Azerbaijan	2020-05-15	2020-05-16	2980	36	1886	1058	f	f
326	Azerbaijan	2020-05-16	2020-05-17	3138	36	1944	1158	f	f
327	Azerbaijan	2020-05-17	2020-05-18	3274	39	2015	1220	f	f
328	Azerbaijan	2020-05-18	2020-05-19	3387	40	2055	1292	f	f
329	Azerbaijan	2020-05-19	2020-05-20	3518	41	2198	1279	f	f
330	Azerbaijan	2020-05-20	2020-05-21	3631	43	2253	1335	f	f
331	Azerbaijan	2020-05-21	2020-05-22	3749	44	2340	1365	f	f
332	Azerbaijan	2020-05-22	2020-05-23	3855	46	2399	1410	f	f
333	Azerbaijan	2020-05-23	2020-05-24	3982	49	2506	1427	f	f
334	Azerbaijan	2020-05-24	2020-05-25	4122	49	2607	1466	f	f
335	Azerbaijan	2020-05-25	2020-05-26	4271	51	2741	1479	f	f
336	Azerbaijan	2020-05-26	2020-05-27	4403	52	2819	1532	f	f
337	Azerbaijan	2020-05-27	2020-05-28	4568	54	2897	1617	f	f
338	Azerbaijan	2020-05-28	2020-05-29	4759	56	3022	1681	f	f
339	Azerbaijan	2020-05-29	2020-05-30	4989	58	3125	1806	f	f
340	Azerbaijan	2020-05-30	2020-05-31	5246	61	3327	1858	f	f
341	Azerbaijan	2020-05-31	2020-06-01	5494	63	3428	2003	f	f
342	Bahamas	2020-05-01	2020-05-02	81	11	24	46	f	f
343	Bahamas	2020-05-02	2020-05-03	83	11	24	48	f	f
344	Bahamas	2020-05-03	2020-05-04	83	11	24	48	f	f
345	Bahamas	2020-05-04	2020-05-05	83	11	25	47	f	f
346	Bahamas	2020-05-05	2020-05-06	89	11	26	52	f	f
347	Bahamas	2020-05-06	2020-05-07	92	11	26	55	f	f
348	Bahamas	2020-05-07	2020-05-08	92	11	26	55	f	f
349	Bahamas	2020-05-08	2020-05-09	92	11	31	50	f	f
350	Bahamas	2020-05-09	2020-05-10	92	11	37	44	f	f
351	Bahamas	2020-05-10	2020-05-11	92	11	37	44	f	f
352	Bahamas	2020-05-11	2020-05-12	93	11	39	43	f	f
353	Bahamas	2020-05-12	2020-05-13	93	11	39	43	f	f
354	Bahamas	2020-05-13	2020-05-14	94	11	41	42	f	f
355	Bahamas	2020-05-14	2020-05-15	96	11	41	44	f	f
356	Bahamas	2020-05-15	2020-05-16	96	11	41	44	f	f
357	Bahamas	2020-05-16	2020-05-17	96	11	42	43	f	f
358	Bahamas	2020-05-17	2020-05-18	96	11	42	43	f	f
359	Bahamas	2020-05-18	2020-05-19	96	11	43	42	f	f
360	Bahamas	2020-05-19	2020-05-20	96	11	43	42	f	f
361	Bahamas	2020-05-20	2020-05-21	97	11	43	43	f	f
362	Bahamas	2020-05-21	2020-05-22	97	11	44	42	f	f
363	Bahamas	2020-05-22	2020-05-23	97	11	44	42	f	f
364	Bahamas	2020-05-23	2020-05-24	100	11	45	44	f	f
365	Bahamas	2020-05-24	2020-05-25	100	11	45	44	f	f
366	Bahamas	2020-05-25	2020-05-26	100	11	46	43	f	f
367	Bahamas	2020-05-26	2020-05-27	100	11	46	43	f	f
368	Bahamas	2020-05-27	2020-05-28	100	11	46	43	f	f
369	Bahamas	2020-05-28	2020-05-29	101	11	47	43	f	f
370	Bahamas	2020-05-29	2020-05-30	102	11	48	43	f	f
371	Bahamas	2020-05-30	2020-05-31	102	11	48	43	f	f
372	Bahamas	2020-05-31	2020-06-01	102	11	48	43	f	f
373	Bahrain	2020-05-01	2020-05-02	3170	8	1555	1607	f	f
374	Bahrain	2020-05-02	2020-05-03	3284	8	1568	1708	f	f
375	Bahrain	2020-05-03	2020-05-04	3383	8	1718	1657	f	f
376	Bahrain	2020-05-04	2020-05-05	3533	8	1744	1781	f	f
377	Bahrain	2020-05-05	2020-05-06	3720	8	1762	1950	f	f
378	Bahrain	2020-05-06	2020-05-07	3934	8	1860	2066	f	f
379	Bahrain	2020-05-07	2020-05-08	4199	8	2000	2191	f	f
380	Bahrain	2020-05-08	2020-05-09	4444	8	2028	2408	f	f
381	Bahrain	2020-05-09	2020-05-10	4774	8	2055	2711	f	f
382	Bahrain	2020-05-10	2020-05-11	4941	8	2070	2863	f	f
383	Bahrain	2020-05-11	2020-05-12	5236	8	2152	3076	f	f
384	Bahrain	2020-05-12	2020-05-13	5531	9	2192	3330	f	f
385	Bahrain	2020-05-13	2020-05-14	5816	10	2205	3601	f	f
386	Bahrain	2020-05-14	2020-05-15	6198	10	2353	3835	f	f
387	Bahrain	2020-05-15	2020-05-16	6583	12	2640	3931	f	f
388	Bahrain	2020-05-16	2020-05-17	6747	12	2762	3973	f	f
389	Bahrain	2020-05-17	2020-05-18	6956	12	2910	4034	f	f
390	Bahrain	2020-05-18	2020-05-19	7184	12	2931	4241	f	f
391	Bahrain	2020-05-19	2020-05-20	7532	12	2952	4568	f	f
392	Bahrain	2020-05-20	2020-05-21	7888	12	3568	4308	f	f
393	Bahrain	2020-05-21	2020-05-22	8174	12	3873	4289	f	f
394	Bahrain	2020-05-22	2020-05-23	8414	12	4096	4306	f	f
395	Bahrain	2020-05-23	2020-05-24	8802	13	4465	4324	f	f
396	Bahrain	2020-05-24	2020-05-25	9138	14	4587	4537	f	f
397	Bahrain	2020-05-25	2020-05-26	9171	14	4753	4404	f	f
398	Bahrain	2020-05-26	2020-05-27	9366	14	4938	4414	f	f
399	Bahrain	2020-05-27	2020-05-28	9692	15	5152	4525	f	f
400	Bahrain	2020-05-28	2020-05-29	10052	15	5419	4618	f	f
401	Bahrain	2020-05-29	2020-05-30	10449	15	5700	4734	f	f
402	Bahrain	2020-05-30	2020-05-31	10793	17	5826	4950	f	f
403	Bahrain	2020-05-31	2020-06-01	11398	19	6673	4706	f	f
404	Bangladesh	2020-05-01	2020-05-02	8238	170	174	7894	f	f
405	Bangladesh	2020-05-02	2020-05-03	8790	175	177	8438	f	f
406	Bangladesh	2020-05-03	2020-05-04	9455	177	1063	8215	f	f
407	Bangladesh	2020-05-04	2020-05-05	10143	182	1209	8752	f	f
408	Bangladesh	2020-05-05	2020-05-06	10929	183	1403	9343	f	f
409	Bangladesh	2020-05-06	2020-05-07	11719	186	1403	10130	f	f
410	Bangladesh	2020-05-07	2020-05-08	12425	199	1910	10316	f	f
411	Bangladesh	2020-05-08	2020-05-09	13134	206	2101	10827	f	f
412	Bangladesh	2020-05-09	2020-05-10	13770	214	2414	11142	f	f
413	Bangladesh	2020-05-10	2020-05-11	14657	228	2650	11779	f	f
414	Bangladesh	2020-05-11	2020-05-12	15691	239	2902	12550	f	f
415	Bangladesh	2020-05-12	2020-05-13	16660	250	3147	13263	f	f
416	Bangladesh	2020-05-13	2020-05-14	17822	269	3361	14192	f	f
417	Bangladesh	2020-05-14	2020-05-15	18863	283	3361	15219	f	f
418	Bangladesh	2020-05-15	2020-05-16	20065	298	3882	15885	f	f
419	Bangladesh	2020-05-16	2020-05-17	20995	314	4117	16564	f	f
420	Bangladesh	2020-05-17	2020-05-18	22268	328	4373	17567	f	f
421	Bangladesh	2020-05-18	2020-05-19	23870	349	4585	18936	f	f
422	Bangladesh	2020-05-19	2020-05-20	25121	370	4993	19758	f	f
423	Bangladesh	2020-05-20	2020-05-21	26738	386	5207	21145	f	f
424	Bangladesh	2020-05-21	2020-05-22	28511	408	5602	22501	f	f
425	Bangladesh	2020-05-22	2020-05-23	30205	432	6190	23583	f	f
426	Bangladesh	2020-05-23	2020-05-24	32078	452	6486	25140	f	f
427	Bangladesh	2020-05-24	2020-05-25	33610	480	6901	26229	f	f
428	Bangladesh	2020-05-25	2020-05-26	35585	501	7334	27750	f	f
429	Bangladesh	2020-05-26	2020-05-27	36751	522	7579	28650	f	f
430	Bangladesh	2020-05-27	2020-05-28	38292	544	7925	29823	f	f
431	Bangladesh	2020-05-28	2020-05-29	40321	559	8425	31337	f	f
432	Bangladesh	2020-05-29	2020-05-30	42844	582	9015	33247	f	f
433	Bangladesh	2020-05-30	2020-05-31	44608	610	9375	34623	f	f
434	Bangladesh	2020-05-31	2020-06-01	47153	650	9781	36722	f	f
435	Barbados	2020-05-01	2020-05-02	81	7	39	35	f	f
436	Barbados	2020-05-02	2020-05-03	81	7	44	30	f	f
437	Barbados	2020-05-03	2020-05-04	82	7	44	31	f	f
438	Barbados	2020-05-04	2020-05-05	82	7	46	29	f	f
439	Barbados	2020-05-05	2020-05-06	82	7	47	28	f	f
440	Barbados	2020-05-06	2020-05-07	82	7	47	28	f	f
441	Barbados	2020-05-07	2020-05-08	82	7	53	22	f	f
442	Barbados	2020-05-08	2020-05-09	83	7	53	23	f	f
443	Barbados	2020-05-09	2020-05-10	84	7	57	20	f	f
444	Barbados	2020-05-10	2020-05-11	84	7	57	20	f	f
445	Barbados	2020-05-11	2020-05-12	84	7	57	20	f	f
446	Barbados	2020-05-12	2020-05-13	85	7	57	21	f	f
447	Barbados	2020-05-13	2020-05-14	85	7	65	13	f	f
448	Barbados	2020-05-14	2020-05-15	85	7	65	13	f	f
449	Barbados	2020-05-15	2020-05-16	85	7	65	13	f	f
450	Barbados	2020-05-16	2020-05-17	86	7	67	12	f	f
451	Barbados	2020-05-17	2020-05-18	88	7	68	13	f	f
452	Barbados	2020-05-18	2020-05-19	88	7	68	13	f	f
453	Barbados	2020-05-19	2020-05-20	90	7	68	15	f	f
454	Barbados	2020-05-20	2020-05-21	90	7	70	13	f	f
455	Barbados	2020-05-21	2020-05-22	90	7	70	13	f	f
456	Barbados	2020-05-22	2020-05-23	90	7	70	13	f	f
457	Barbados	2020-05-23	2020-05-24	92	7	70	15	f	f
458	Barbados	2020-05-24	2020-05-25	92	7	70	15	f	f
459	Barbados	2020-05-25	2020-05-26	92	7	71	14	f	f
460	Barbados	2020-05-26	2020-05-27	92	7	71	14	f	f
461	Barbados	2020-05-27	2020-05-28	92	7	76	9	f	f
462	Barbados	2020-05-28	2020-05-29	92	7	76	9	f	f
463	Barbados	2020-05-29	2020-05-30	92	7	76	9	f	f
464	Barbados	2020-05-30	2020-05-31	92	7	76	9	f	f
465	Barbados	2020-05-31	2020-06-01	92	7	76	9	f	f
466	Belarus	2020-05-01	2020-05-02	14917	93	2918	11906	f	f
467	Belarus	2020-05-02	2020-05-03	15828	97	3117	12614	f	f
468	Belarus	2020-05-03	2020-05-04	16705	99	3196	13410	f	f
469	Belarus	2020-05-04	2020-05-05	17489	103	3259	14127	f	f
470	Belarus	2020-05-05	2020-05-06	18350	107	3771	14472	f	f
471	Belarus	2020-05-06	2020-05-07	19255	112	4388	14755	f	f
472	Belarus	2020-05-07	2020-05-08	20168	116	5067	14985	f	f
473	Belarus	2020-05-08	2020-05-09	21101	121	5484	15496	f	f
474	Belarus	2020-05-09	2020-05-10	22052	126	6050	15876	f	f
475	Belarus	2020-05-10	2020-05-11	22973	131	6406	16436	f	f
476	Belarus	2020-05-11	2020-05-12	23906	135	6531	17240	f	f
477	Belarus	2020-05-12	2020-05-13	24873	142	6974	17757	f	f
478	Belarus	2020-05-13	2020-05-14	25825	146	7711	17968	f	f
479	Belarus	2020-05-14	2020-05-15	26772	151	8168	18453	f	f
480	Belarus	2020-05-15	2020-05-16	27730	156	8807	18767	f	f
481	Belarus	2020-05-16	2020-05-17	28681	160	9498	19023	f	f
482	Belarus	2020-05-17	2020-05-18	29650	165	9932	19553	f	f
483	Belarus	2020-05-18	2020-05-19	30572	171	10130	20271	f	f
484	Belarus	2020-05-19	2020-05-20	31508	175	10620	20713	f	f
485	Belarus	2020-05-20	2020-05-21	32426	179	11415	20832	f	f
486	Belarus	2020-05-21	2020-05-22	33371	185	12057	21129	f	f
487	Belarus	2020-05-22	2020-05-23	34303	190	12833	21280	f	f
488	Belarus	2020-05-23	2020-05-24	35244	194	13528	21522	f	f
489	Belarus	2020-05-24	2020-05-25	36198	199	14155	21844	f	f
490	Belarus	2020-05-25	2020-05-26	37144	204	14449	22491	f	f
491	Belarus	2020-05-26	2020-05-27	38059	208	15086	22765	f	f
492	Belarus	2020-05-27	2020-05-28	38956	214	15923	22819	f	f
493	Belarus	2020-05-28	2020-05-29	39858	219	16660	22979	f	f
494	Belarus	2020-05-29	2020-05-30	40764	224	17390	23150	f	f
495	Belarus	2020-05-30	2020-05-31	41658	229	17964	23465	f	f
496	Belarus	2020-05-31	2020-06-01	42556	235	18514	23807	f	f
497	Belgium	2020-05-01	2020-05-02	49032	7703	11892	29437	f	f
498	Belgium	2020-05-02	2020-05-03	49517	7765	12211	29541	f	f
499	Belgium	2020-05-03	2020-05-04	49906	7844	12309	29753	f	f
500	Belgium	2020-05-04	2020-05-05	50267	7924	12378	29965	f	f
501	Belgium	2020-05-05	2020-05-06	50509	8016	12441	30052	f	f
502	Belgium	2020-05-06	2020-05-07	50781	8339	12731	29711	f	f
503	Belgium	2020-05-07	2020-05-08	51420	8415	12980	30025	f	f
504	Belgium	2020-05-08	2020-05-09	52011	8521	13201	30289	f	f
505	Belgium	2020-05-09	2020-05-10	52596	8581	13411	30604	f	f
506	Belgium	2020-05-10	2020-05-11	53081	8656	13642	30783	f	f
507	Belgium	2020-05-11	2020-05-12	53449	8707	13697	31045	f	f
508	Belgium	2020-05-12	2020-05-13	53779	8761	13732	31286	f	f
509	Belgium	2020-05-13	2020-05-14	53981	8843	13937	31201	f	f
510	Belgium	2020-05-14	2020-05-15	54288	8903	14111	31274	f	f
511	Belgium	2020-05-15	2020-05-16	54644	8959	14301	31384	f	f
512	Belgium	2020-05-16	2020-05-17	54989	9005	14460	31524	f	f
513	Belgium	2020-05-17	2020-05-18	55280	9052	14630	31598	f	f
514	Belgium	2020-05-18	2020-05-19	55559	9080	14657	31822	f	f
515	Belgium	2020-05-19	2020-05-20	55791	9108	14687	31996	f	f
516	Belgium	2020-05-20	2020-05-21	55983	9150	14847	31986	f	f
517	Belgium	2020-05-21	2020-05-22	56235	9186	14988	32061	f	f
518	Belgium	2020-05-22	2020-05-23	56511	9212	15123	32176	f	f
519	Belgium	2020-05-23	2020-05-24	56810	9237	15155	32418	f	f
520	Belgium	2020-05-24	2020-05-25	57092	9280	15272	32540	f	f
521	Belgium	2020-05-25	2020-05-26	57342	9312	15297	32733	f	f
522	Belgium	2020-05-26	2020-05-27	57455	9334	15320	32801	f	f
523	Belgium	2020-05-27	2020-05-28	57592	9364	15465	32763	f	f
524	Belgium	2020-05-28	2020-05-29	57849	9388	15572	32889	f	f
525	Belgium	2020-05-29	2020-05-30	58061	9430	15682	32949	f	f
526	Belgium	2020-05-30	2020-05-31	58186	9453	15769	32964	f	f
527	Belgium	2020-05-31	2020-06-01	58381	9467	15887	33027	f	f
528	Belize	2020-05-01	2020-05-02	18	2	13	3	f	f
529	Belize	2020-05-02	2020-05-03	18	2	13	3	f	f
530	Belize	2020-05-03	2020-05-04	18	2	13	3	f	f
531	Belize	2020-05-04	2020-05-05	18	2	14	2	f	f
532	Belize	2020-05-05	2020-05-06	18	2	16	0	f	f
533	Belize	2020-05-06	2020-05-07	18	2	16	0	f	f
534	Belize	2020-05-07	2020-05-08	18	2	16	0	f	f
535	Belize	2020-05-08	2020-05-09	18	2	16	0	f	f
536	Belize	2020-05-09	2020-05-10	18	2	16	0	f	f
537	Belize	2020-05-10	2020-05-11	18	2	16	0	f	f
538	Belize	2020-05-11	2020-05-12	18	2	16	0	f	f
539	Belize	2020-05-12	2020-05-13	18	2	16	0	f	f
540	Belize	2020-05-13	2020-05-14	18	2	16	0	f	f
541	Belize	2020-05-14	2020-05-15	18	2	16	0	f	f
542	Belize	2020-05-15	2020-05-16	18	2	16	0	f	f
543	Belize	2020-05-16	2020-05-17	18	2	16	0	f	f
544	Belize	2020-05-17	2020-05-18	18	2	16	0	f	f
545	Belize	2020-05-18	2020-05-19	18	2	16	0	f	f
546	Belize	2020-05-19	2020-05-20	18	2	16	0	f	f
547	Belize	2020-05-20	2020-05-21	18	2	16	0	f	f
548	Belize	2020-05-21	2020-05-22	18	2	16	0	f	f
549	Belize	2020-05-22	2020-05-23	18	2	16	0	f	f
550	Belize	2020-05-23	2020-05-24	18	2	16	0	f	f
551	Belize	2020-05-24	2020-05-25	18	2	16	0	f	f
552	Belize	2020-05-25	2020-05-26	18	2	16	0	f	f
553	Belize	2020-05-26	2020-05-27	18	2	16	0	f	f
554	Belize	2020-05-27	2020-05-28	18	2	16	0	f	f
555	Belize	2020-05-28	2020-05-29	18	2	16	0	f	f
556	Belize	2020-05-29	2020-05-30	18	2	16	0	f	f
557	Belize	2020-05-30	2020-05-31	18	2	16	0	f	f
558	Belize	2020-05-31	2020-06-01	18	2	16	0	f	f
559	Benin	2020-05-01	2020-05-02	90	2	42	46	f	f
560	Benin	2020-05-02	2020-05-03	90	2	42	46	f	f
561	Benin	2020-05-03	2020-05-04	90	2	42	46	f	f
562	Benin	2020-05-04	2020-05-05	96	2	50	44	f	f
563	Benin	2020-05-05	2020-05-06	96	2	50	44	f	f
564	Benin	2020-05-06	2020-05-07	96	2	50	44	f	f
565	Benin	2020-05-07	2020-05-08	140	2	53	85	f	f
566	Benin	2020-05-08	2020-05-09	242	2	62	178	f	f
567	Benin	2020-05-09	2020-05-10	284	2	62	220	f	f
568	Benin	2020-05-10	2020-05-11	319	2	62	255	f	f
569	Benin	2020-05-11	2020-05-12	319	2	62	255	f	f
570	Benin	2020-05-12	2020-05-13	327	2	76	249	f	f
571	Benin	2020-05-13	2020-05-14	327	2	83	242	f	f
572	Benin	2020-05-14	2020-05-15	339	2	83	254	f	f
573	Benin	2020-05-15	2020-05-16	339	2	83	254	f	f
574	Benin	2020-05-16	2020-05-17	339	2	83	254	f	f
575	Benin	2020-05-17	2020-05-18	339	2	83	254	f	f
576	Benin	2020-05-18	2020-05-19	339	2	83	254	f	f
577	Benin	2020-05-19	2020-05-20	130	2	83	45	f	f
578	Benin	2020-05-20	2020-05-21	130	2	57	71	f	f
579	Benin	2020-05-21	2020-05-22	135	3	61	71	f	f
580	Benin	2020-05-22	2020-05-23	135	3	61	71	f	f
581	Benin	2020-05-23	2020-05-24	135	3	61	71	f	f
582	Benin	2020-05-24	2020-05-25	191	3	82	106	f	f
583	Benin	2020-05-25	2020-05-26	191	3	84	104	f	f
584	Benin	2020-05-26	2020-05-27	208	3	118	87	f	f
585	Benin	2020-05-27	2020-05-28	210	3	134	73	f	f
586	Benin	2020-05-28	2020-05-29	210	3	134	73	f	f
587	Benin	2020-05-29	2020-05-30	224	3	136	85	f	f
588	Benin	2020-05-30	2020-05-31	224	3	136	85	f	f
589	Benin	2020-05-31	2020-06-01	232	3	143	86	f	f
590	Bhutan	2020-05-01	2020-05-02	7	0	5	2	f	f
591	Bhutan	2020-05-02	2020-05-03	7	0	5	2	f	f
592	Bhutan	2020-05-03	2020-05-04	7	0	5	2	f	f
593	Bhutan	2020-05-04	2020-05-05	7	0	5	2	f	f
594	Bhutan	2020-05-05	2020-05-06	7	0	5	2	f	f
595	Bhutan	2020-05-06	2020-05-07	7	0	5	2	f	f
596	Bhutan	2020-05-07	2020-05-08	7	0	5	2	f	f
597	Bhutan	2020-05-08	2020-05-09	7	0	5	2	f	f
598	Bhutan	2020-05-09	2020-05-10	7	0	5	2	f	f
599	Bhutan	2020-05-10	2020-05-11	7	0	5	2	f	f
600	Bhutan	2020-05-11	2020-05-12	11	0	5	6	f	f
601	Bhutan	2020-05-12	2020-05-13	11	0	5	6	f	f
602	Bhutan	2020-05-13	2020-05-14	15	0	5	10	f	f
603	Bhutan	2020-05-14	2020-05-15	20	0	5	15	f	f
604	Bhutan	2020-05-15	2020-05-16	21	0	5	16	f	f
605	Bhutan	2020-05-16	2020-05-17	21	0	5	16	f	f
606	Bhutan	2020-05-17	2020-05-18	21	0	5	16	f	f
607	Bhutan	2020-05-18	2020-05-19	21	0	5	16	f	f
608	Bhutan	2020-05-19	2020-05-20	21	0	5	16	f	f
609	Bhutan	2020-05-20	2020-05-21	21	0	5	16	f	f
610	Bhutan	2020-05-21	2020-05-22	21	0	6	15	f	f
611	Bhutan	2020-05-22	2020-05-23	21	0	6	15	f	f
612	Bhutan	2020-05-23	2020-05-24	24	0	6	18	f	f
613	Bhutan	2020-05-24	2020-05-25	24	0	6	18	f	f
614	Bhutan	2020-05-25	2020-05-26	27	0	6	21	f	f
615	Bhutan	2020-05-26	2020-05-27	27	0	6	21	f	f
616	Bhutan	2020-05-27	2020-05-28	28	0	6	22	f	f
617	Bhutan	2020-05-28	2020-05-29	31	0	6	25	f	f
618	Bhutan	2020-05-29	2020-05-30	31	0	6	25	f	f
619	Bhutan	2020-05-30	2020-05-31	33	0	6	27	f	f
620	Bhutan	2020-05-31	2020-06-01	43	0	6	37	f	f
621	Bolivia	2020-05-01	2020-05-02	1229	66	134	1029	f	f
622	Bolivia	2020-05-02	2020-05-03	1229	66	134	1029	f	f
623	Bolivia	2020-05-03	2020-05-04	1594	76	166	1352	f	f
624	Bolivia	2020-05-04	2020-05-05	1681	82	174	1425	f	f
625	Bolivia	2020-05-05	2020-05-06	1802	86	187	1529	f	f
626	Bolivia	2020-05-06	2020-05-07	1886	91	198	1597	f	f
627	Bolivia	2020-05-07	2020-05-08	2081	102	219	1760	f	f
628	Bolivia	2020-05-08	2020-05-09	2266	106	237	1923	f	f
629	Bolivia	2020-05-09	2020-05-10	2437	114	258	2065	f	f
630	Bolivia	2020-05-10	2020-05-11	2556	118	273	2165	f	f
631	Bolivia	2020-05-11	2020-05-12	2831	122	299	2410	f	f
632	Bolivia	2020-05-12	2020-05-13	2964	128	313	2523	f	f
633	Bolivia	2020-05-13	2020-05-14	3148	142	339	2667	f	f
634	Bolivia	2020-05-14	2020-05-15	3372	152	356	2864	f	f
635	Bolivia	2020-05-15	2020-05-16	3577	164	434	2979	f	f
636	Bolivia	2020-05-16	2020-05-17	3826	165	473	3188	f	f
637	Bolivia	2020-05-17	2020-05-18	4088	169	493	3426	f	f
638	Bolivia	2020-05-18	2020-05-19	4263	174	503	3586	f	f
639	Bolivia	2020-05-19	2020-05-20	4481	189	533	3759	f	f
640	Bolivia	2020-05-20	2020-05-21	4919	199	553	4167	f	f
641	Bolivia	2020-05-21	2020-05-22	5187	215	561	4411	f	f
642	Bolivia	2020-05-22	2020-05-23	5579	230	575	4774	f	f
643	Bolivia	2020-05-23	2020-05-24	5915	240	609	5066	f	f
644	Bolivia	2020-05-24	2020-05-25	6263	250	629	5384	f	f
645	Bolivia	2020-05-25	2020-05-26	6660	261	647	5752	f	f
646	Bolivia	2020-05-26	2020-05-27	7136	274	677	6185	f	f
647	Bolivia	2020-05-27	2020-05-28	7768	280	689	6799	f	f
648	Bolivia	2020-05-28	2020-05-29	8387	293	738	7356	f	f
649	Bolivia	2020-05-29	2020-05-30	8731	300	749	7682	f	f
650	Bolivia	2020-05-30	2020-05-31	9592	310	889	8393	f	f
651	Bolivia	2020-05-31	2020-06-01	9982	313	968	8701	f	f
652	Bosnia and Herzegovina	2020-05-01	2020-05-02	1781	70	755	956	f	f
653	Bosnia and Herzegovina	2020-05-02	2020-05-03	1839	72	779	988	f	f
654	Bosnia and Herzegovina	2020-05-03	2020-05-04	1857	77	825	955	f	f
655	Bosnia and Herzegovina	2020-05-04	2020-05-05	1926	78	855	993	f	f
656	Bosnia and Herzegovina	2020-05-05	2020-05-06	1946	79	911	956	f	f
657	Bosnia and Herzegovina	2020-05-06	2020-05-07	1987	86	928	973	f	f
658	Bosnia and Herzegovina	2020-05-07	2020-05-08	2027	90	954	983	f	f
659	Bosnia and Herzegovina	2020-05-08	2020-05-09	2070	98	960	1012	f	f
660	Bosnia and Herzegovina	2020-05-09	2020-05-10	2090	102	1059	929	f	f
661	Bosnia and Herzegovina	2020-05-10	2020-05-11	2117	107	1106	904	f	f
662	Bosnia and Herzegovina	2020-05-11	2020-05-12	2141	113	1114	914	f	f
663	Bosnia and Herzegovina	2020-05-12	2020-05-13	2158	117	1168	873	f	f
664	Bosnia and Herzegovina	2020-05-13	2020-05-14	2181	120	1228	833	f	f
665	Bosnia and Herzegovina	2020-05-14	2020-05-15	2218	122	1272	824	f	f
666	Bosnia and Herzegovina	2020-05-15	2020-05-16	2236	128	1336	772	f	f
667	Bosnia and Herzegovina	2020-05-16	2020-05-17	2267	129	1355	783	f	f
668	Bosnia and Herzegovina	2020-05-17	2020-05-18	2290	133	1436	721	f	f
669	Bosnia and Herzegovina	2020-05-18	2020-05-19	2304	133	1464	707	f	f
670	Bosnia and Herzegovina	2020-05-19	2020-05-20	2321	134	1522	665	f	f
671	Bosnia and Herzegovina	2020-05-20	2020-05-21	2338	136	1557	645	f	f
672	Bosnia and Herzegovina	2020-05-21	2020-05-22	2350	140	1596	614	f	f
673	Bosnia and Herzegovina	2020-05-22	2020-05-23	2372	141	1614	617	f	f
674	Bosnia and Herzegovina	2020-05-23	2020-05-24	2391	141	1662	588	f	f
675	Bosnia and Herzegovina	2020-05-24	2020-05-25	2401	144	1680	577	f	f
676	Bosnia and Herzegovina	2020-05-25	2020-05-26	2406	146	1696	564	f	f
677	Bosnia and Herzegovina	2020-05-26	2020-05-27	2416	149	1721	546	f	f
678	Bosnia and Herzegovina	2020-05-27	2020-05-28	2435	151	1744	540	f	f
679	Bosnia and Herzegovina	2020-05-28	2020-05-29	2462	153	1781	528	f	f
680	Bosnia and Herzegovina	2020-05-29	2020-05-30	2485	153	1803	529	f	f
681	Bosnia and Herzegovina	2020-05-30	2020-05-31	2494	153	1831	510	f	f
682	Bosnia and Herzegovina	2020-05-31	2020-06-01	2510	153	1862	495	f	f
683	Botswana	2020-05-01	2020-05-02	23	1	8	14	f	f
684	Botswana	2020-05-02	2020-05-03	23	1	8	14	f	f
685	Botswana	2020-05-03	2020-05-04	23	1	8	14	f	f
686	Botswana	2020-05-04	2020-05-05	23	1	8	14	f	f
687	Botswana	2020-05-05	2020-05-06	23	1	8	14	f	f
688	Botswana	2020-05-06	2020-05-07	23	1	8	14	f	f
689	Botswana	2020-05-07	2020-05-08	23	1	9	13	f	f
690	Botswana	2020-05-08	2020-05-09	23	1	9	13	f	f
691	Botswana	2020-05-09	2020-05-10	23	1	12	10	f	f
692	Botswana	2020-05-10	2020-05-11	23	1	12	10	f	f
693	Botswana	2020-05-11	2020-05-12	24	1	12	11	f	f
694	Botswana	2020-05-12	2020-05-13	24	1	17	6	f	f
695	Botswana	2020-05-13	2020-05-14	24	1	17	6	f	f
696	Botswana	2020-05-14	2020-05-15	24	1	17	6	f	f
697	Botswana	2020-05-15	2020-05-16	24	1	17	6	f	f
698	Botswana	2020-05-16	2020-05-17	24	1	17	6	f	f
699	Botswana	2020-05-17	2020-05-18	25	1	17	7	f	f
700	Botswana	2020-05-18	2020-05-19	25	1	17	7	f	f
701	Botswana	2020-05-19	2020-05-20	25	1	17	7	f	f
702	Botswana	2020-05-20	2020-05-21	25	1	17	7	f	f
703	Botswana	2020-05-21	2020-05-22	29	1	19	9	f	f
704	Botswana	2020-05-22	2020-05-23	30	1	19	10	f	f
705	Botswana	2020-05-23	2020-05-24	30	1	19	10	f	f
706	Botswana	2020-05-24	2020-05-25	35	1	19	15	f	f
707	Botswana	2020-05-25	2020-05-26	35	1	19	15	f	f
708	Botswana	2020-05-26	2020-05-27	35	1	20	14	f	f
709	Botswana	2020-05-27	2020-05-28	35	1	20	14	f	f
710	Botswana	2020-05-28	2020-05-29	35	1	20	14	f	f
711	Botswana	2020-05-29	2020-05-30	35	1	20	14	f	f
712	Botswana	2020-05-30	2020-05-31	35	1	20	14	f	f
713	Botswana	2020-05-31	2020-06-01	35	1	20	14	f	f
714	Brazil	2020-05-01	2020-05-02	92202	6412	38039	47751	f	f
715	Brazil	2020-05-02	2020-05-03	97100	6761	40937	49402	f	f
716	Brazil	2020-05-03	2020-05-04	101826	7051	42991	51784	f	f
717	Brazil	2020-05-04	2020-05-05	108620	7367	45815	55438	f	f
718	Brazil	2020-05-05	2020-05-06	115455	7938	48221	59296	f	f
719	Brazil	2020-05-06	2020-05-07	126611	8588	51370	66653	f	f
720	Brazil	2020-05-07	2020-05-08	135773	9190	55350	71233	f	f
721	Brazil	2020-05-08	2020-05-09	146894	10017	59297	77580	f	f
722	Brazil	2020-05-09	2020-05-10	156061	10656	61685	83720	f	f
723	Brazil	2020-05-10	2020-05-11	162699	11123	64957	86619	f	f
724	Brazil	2020-05-11	2020-05-12	169594	11653	67384	90557	f	f
725	Brazil	2020-05-12	2020-05-13	178214	12461	72597	93156	f	f
726	Brazil	2020-05-13	2020-05-14	190137	13240	78424	98473	f	f
727	Brazil	2020-05-14	2020-05-15	203165	13999	79479	109687	f	f
728	Brazil	2020-05-15	2020-05-16	220291	14962	84970	120359	f	f
729	Brazil	2020-05-16	2020-05-17	233511	15662	89672	128177	f	f
730	Brazil	2020-05-17	2020-05-18	241080	16118	94122	130840	f	f
731	Brazil	2020-05-18	2020-05-19	255368	16853	100459	138056	f	f
732	Brazil	2020-05-19	2020-05-20	271885	17983	106794	147108	f	f
733	Brazil	2020-05-20	2020-05-21	291579	18859	116683	156037	f	f
734	Brazil	2020-05-21	2020-05-22	310087	20047	125960	164080	f	f
735	Brazil	2020-05-22	2020-05-23	330890	21048	135430	174412	f	f
736	Brazil	2020-05-23	2020-05-24	347398	22013	142587	182798	f	f
737	Brazil	2020-05-24	2020-05-25	363211	22666	149911	190634	f	f
738	Brazil	2020-05-25	2020-05-26	374898	23473	153833	197592	f	f
739	Brazil	2020-05-26	2020-05-27	391222	24512	158593	208117	f	f
740	Brazil	2020-05-27	2020-05-28	411821	25598	166647	219576	f	f
741	Brazil	2020-05-28	2020-05-29	438238	26754	177604	233880	f	f
742	Brazil	2020-05-29	2020-05-30	465166	27878	189476	247812	f	f
743	Brazil	2020-05-30	2020-05-31	498440	28834	200892	268714	f	f
744	Brazil	2020-05-31	2020-06-01	514849	29314	206555	278980	f	f
745	Brunei	2020-05-01	2020-05-02	138	1	124	13	f	f
746	Brunei	2020-05-02	2020-05-03	138	1	126	11	f	f
747	Brunei	2020-05-03	2020-05-04	138	1	128	9	f	f
748	Brunei	2020-05-04	2020-05-05	138	1	130	7	f	f
749	Brunei	2020-05-05	2020-05-06	138	1	131	6	f	f
750	Brunei	2020-05-06	2020-05-07	139	1	131	7	f	f
751	Brunei	2020-05-07	2020-05-08	141	1	131	9	f	f
752	Brunei	2020-05-08	2020-05-09	141	1	132	8	f	f
753	Brunei	2020-05-09	2020-05-10	141	1	132	8	f	f
754	Brunei	2020-05-10	2020-05-11	141	1	134	6	f	f
755	Brunei	2020-05-11	2020-05-12	141	1	134	6	f	f
756	Brunei	2020-05-12	2020-05-13	141	1	134	6	f	f
757	Brunei	2020-05-13	2020-05-14	141	1	134	6	f	f
758	Brunei	2020-05-14	2020-05-15	141	1	134	6	f	f
759	Brunei	2020-05-15	2020-05-16	141	1	135	5	f	f
760	Brunei	2020-05-16	2020-05-17	141	1	136	4	f	f
761	Brunei	2020-05-17	2020-05-18	141	1	136	4	f	f
762	Brunei	2020-05-18	2020-05-19	141	1	136	4	f	f
763	Brunei	2020-05-19	2020-05-20	141	1	136	4	f	f
764	Brunei	2020-05-20	2020-05-21	141	1	136	4	f	f
765	Brunei	2020-05-21	2020-05-22	141	1	136	4	f	f
766	Brunei	2020-05-22	2020-05-23	141	1	136	4	f	f
767	Brunei	2020-05-23	2020-05-24	141	1	136	4	f	f
768	Brunei	2020-05-24	2020-05-25	141	1	137	3	f	f
769	Brunei	2020-05-25	2020-05-26	141	1	137	3	f	f
770	Brunei	2020-05-26	2020-05-27	141	1	137	3	f	f
771	Brunei	2020-05-27	2020-05-28	141	2	137	2	f	f
772	Brunei	2020-05-28	2020-05-29	141	2	138	1	f	f
773	Brunei	2020-05-29	2020-05-30	141	2	138	1	f	f
774	Brunei	2020-05-30	2020-05-31	141	2	138	1	f	f
775	Brunei	2020-05-31	2020-06-01	141	2	138	1	f	f
776	Bulgaria	2020-05-01	2020-05-02	1555	68	276	1211	f	f
777	Bulgaria	2020-05-02	2020-05-03	1594	72	287	1235	f	f
778	Bulgaria	2020-05-03	2020-05-04	1618	73	308	1237	f	f
779	Bulgaria	2020-05-04	2020-05-05	1652	78	321	1253	f	f
780	Bulgaria	2020-05-05	2020-05-06	1704	80	342	1282	f	f
781	Bulgaria	2020-05-06	2020-05-07	1778	84	360	1334	f	f
782	Bulgaria	2020-05-07	2020-05-08	1829	84	384	1361	f	f
783	Bulgaria	2020-05-08	2020-05-09	1872	86	401	1385	f	f
784	Bulgaria	2020-05-09	2020-05-10	1921	90	422	1409	f	f
785	Bulgaria	2020-05-10	2020-05-11	1965	91	444	1430	f	f
786	Bulgaria	2020-05-11	2020-05-12	1990	93	461	1436	f	f
787	Bulgaria	2020-05-12	2020-05-13	2023	95	476	1452	f	f
788	Bulgaria	2020-05-13	2020-05-14	2069	96	499	1474	f	f
789	Bulgaria	2020-05-14	2020-05-15	2100	99	531	1470	f	f
790	Bulgaria	2020-05-15	2020-05-16	2138	102	545	1491	f	f
791	Bulgaria	2020-05-16	2020-05-17	2175	105	573	1497	f	f
792	Bulgaria	2020-05-17	2020-05-18	2211	108	598	1505	f	f
793	Bulgaria	2020-05-18	2020-05-19	2235	110	612	1513	f	f
794	Bulgaria	2020-05-19	2020-05-20	2259	112	646	1501	f	f
795	Bulgaria	2020-05-20	2020-05-21	2292	116	684	1492	f	f
796	Bulgaria	2020-05-21	2020-05-22	2331	120	727	1484	f	f
797	Bulgaria	2020-05-22	2020-05-23	2372	125	769	1478	f	f
798	Bulgaria	2020-05-23	2020-05-24	2408	126	808	1474	f	f
799	Bulgaria	2020-05-24	2020-05-25	2427	130	840	1457	f	f
800	Bulgaria	2020-05-25	2020-05-26	2433	130	862	1441	f	f
801	Bulgaria	2020-05-26	2020-05-27	2443	130	880	1433	f	f
802	Bulgaria	2020-05-27	2020-05-28	2460	133	912	1415	f	f
803	Bulgaria	2020-05-28	2020-05-29	2477	134	965	1378	f	f
804	Bulgaria	2020-05-29	2020-05-30	2485	136	1016	1333	f	f
805	Bulgaria	2020-05-30	2020-05-31	2499	139	1064	1296	f	f
806	Bulgaria	2020-05-31	2020-06-01	2513	140	1074	1299	f	f
807	Burkina Faso	2020-05-01	2020-05-02	649	44	517	88	f	f
808	Burkina Faso	2020-05-02	2020-05-03	652	44	535	73	f	f
809	Burkina Faso	2020-05-03	2020-05-04	662	45	540	77	f	f
810	Burkina Faso	2020-05-04	2020-05-05	672	46	545	81	f	f
811	Burkina Faso	2020-05-05	2020-05-06	688	48	548	92	f	f
812	Burkina Faso	2020-05-06	2020-05-07	729	48	555	126	f	f
813	Burkina Faso	2020-05-07	2020-05-08	736	48	562	126	f	f
814	Burkina Faso	2020-05-08	2020-05-09	744	48	566	130	f	f
815	Burkina Faso	2020-05-09	2020-05-10	748	48	569	131	f	f
816	Burkina Faso	2020-05-10	2020-05-11	751	49	577	125	f	f
817	Burkina Faso	2020-05-11	2020-05-12	760	50	584	126	f	f
818	Burkina Faso	2020-05-12	2020-05-13	766	51	588	127	f	f
819	Burkina Faso	2020-05-13	2020-05-14	773	51	592	130	f	f
820	Burkina Faso	2020-05-14	2020-05-15	773	51	592	130	f	f
821	Burkina Faso	2020-05-15	2020-05-16	780	51	595	134	f	f
822	Burkina Faso	2020-05-16	2020-05-17	782	51	604	127	f	f
823	Burkina Faso	2020-05-17	2020-05-18	796	51	644	101	f	f
824	Burkina Faso	2020-05-18	2020-05-19	796	51	652	93	f	f
825	Burkina Faso	2020-05-19	2020-05-20	796	51	652	93	f	f
826	Burkina Faso	2020-05-20	2020-05-21	809	52	661	96	f	f
827	Burkina Faso	2020-05-21	2020-05-22	812	52	669	91	f	f
828	Burkina Faso	2020-05-22	2020-05-23	814	52	672	90	f	f
829	Burkina Faso	2020-05-23	2020-05-24	814	52	672	90	f	f
830	Burkina Faso	2020-05-24	2020-05-25	814	52	672	90	f	f
831	Burkina Faso	2020-05-25	2020-05-26	832	52	672	108	f	f
832	Burkina Faso	2020-05-26	2020-05-27	832	52	672	108	f	f
833	Burkina Faso	2020-05-27	2020-05-28	845	53	672	120	f	f
834	Burkina Faso	2020-05-28	2020-05-29	847	53	719	75	f	f
835	Burkina Faso	2020-05-29	2020-05-30	847	53	720	74	f	f
836	Burkina Faso	2020-05-30	2020-05-31	847	53	720	74	f	f
837	Burkina Faso	2020-05-31	2020-06-01	847	53	720	74	f	f
838	Burma	2020-05-01	2020-05-02	151	6	31	114	f	f
839	Burma	2020-05-02	2020-05-03	151	6	37	108	f	f
840	Burma	2020-05-03	2020-05-04	155	6	43	106	f	f
841	Burma	2020-05-04	2020-05-05	161	6	49	106	f	f
842	Burma	2020-05-05	2020-05-06	161	6	49	106	f	f
843	Burma	2020-05-06	2020-05-07	161	6	50	105	f	f
844	Burma	2020-05-07	2020-05-08	176	6	62	108	f	f
845	Burma	2020-05-08	2020-05-09	177	6	67	104	f	f
846	Burma	2020-05-09	2020-05-10	178	6	68	104	f	f
847	Burma	2020-05-10	2020-05-11	180	6	72	102	f	f
848	Burma	2020-05-11	2020-05-12	180	6	74	100	f	f
849	Burma	2020-05-12	2020-05-13	180	6	76	98	f	f
850	Burma	2020-05-13	2020-05-14	181	6	79	96	f	f
851	Burma	2020-05-14	2020-05-15	181	6	84	91	f	f
852	Burma	2020-05-15	2020-05-16	182	6	89	87	f	f
853	Burma	2020-05-16	2020-05-17	182	6	96	80	f	f
854	Burma	2020-05-17	2020-05-18	184	6	97	81	f	f
855	Burma	2020-05-18	2020-05-19	191	6	101	84	f	f
856	Burma	2020-05-19	2020-05-20	193	6	104	83	f	f
857	Burma	2020-05-20	2020-05-21	199	6	108	85	f	f
858	Burma	2020-05-21	2020-05-22	199	6	108	85	f	f
859	Burma	2020-05-22	2020-05-23	199	6	116	77	f	f
860	Burma	2020-05-23	2020-05-24	201	6	120	75	f	f
861	Burma	2020-05-24	2020-05-25	201	6	122	73	f	f
862	Burma	2020-05-25	2020-05-26	203	6	123	74	f	f
863	Burma	2020-05-26	2020-05-27	206	6	124	76	f	f
864	Burma	2020-05-27	2020-05-28	206	6	126	74	f	f
865	Burma	2020-05-28	2020-05-29	206	6	126	74	f	f
866	Burma	2020-05-29	2020-05-30	207	6	130	71	f	f
867	Burma	2020-05-30	2020-05-31	224	6	130	88	f	f
868	Burma	2020-05-31	2020-06-01	224	6	138	80	f	f
869	Burundi	2020-05-01	2020-05-02	11	1	4	6	f	f
870	Burundi	2020-05-02	2020-05-03	15	1	7	7	f	f
871	Burundi	2020-05-03	2020-05-04	15	1	7	7	f	f
872	Burundi	2020-05-04	2020-05-05	15	1	7	7	f	f
873	Burundi	2020-05-05	2020-05-06	15	1	7	7	f	f
874	Burundi	2020-05-06	2020-05-07	15	1	7	7	f	f
875	Burundi	2020-05-07	2020-05-08	15	1	7	7	f	f
876	Burundi	2020-05-08	2020-05-09	15	1	7	7	f	f
877	Burundi	2020-05-09	2020-05-10	15	1	7	7	f	f
878	Burundi	2020-05-10	2020-05-11	15	1	7	7	f	f
879	Burundi	2020-05-11	2020-05-12	15	1	7	7	f	f
880	Burundi	2020-05-12	2020-05-13	15	1	7	7	f	f
881	Burundi	2020-05-13	2020-05-14	15	1	7	7	f	f
882	Burundi	2020-05-14	2020-05-15	15	1	7	7	f	f
883	Burundi	2020-05-15	2020-05-16	15	1	7	7	f	f
884	Burundi	2020-05-16	2020-05-17	15	1	7	7	f	f
885	Burundi	2020-05-17	2020-05-18	23	1	15	7	f	f
886	Burundi	2020-05-18	2020-05-19	42	1	20	21	f	f
887	Burundi	2020-05-19	2020-05-20	42	1	20	21	f	f
888	Burundi	2020-05-20	2020-05-21	42	1	20	21	f	f
889	Burundi	2020-05-21	2020-05-22	42	1	20	21	f	f
890	Burundi	2020-05-22	2020-05-23	42	1	20	21	f	f
891	Burundi	2020-05-23	2020-05-24	42	1	20	21	f	f
892	Burundi	2020-05-24	2020-05-25	42	1	20	21	f	f
893	Burundi	2020-05-25	2020-05-26	42	1	20	21	f	f
894	Burundi	2020-05-26	2020-05-27	42	1	20	21	f	f
895	Burundi	2020-05-27	2020-05-28	42	1	20	21	f	f
896	Burundi	2020-05-28	2020-05-29	42	1	20	21	f	f
897	Burundi	2020-05-29	2020-05-30	42	1	20	21	f	f
898	Burundi	2020-05-30	2020-05-31	63	1	33	29	f	f
899	Burundi	2020-05-31	2020-06-01	63	1	33	29	f	f
900	Cabo Verde	2020-05-01	2020-05-02	122	1	18	103	f	f
901	Cabo Verde	2020-05-02	2020-05-03	152	2	18	132	f	f
902	Cabo Verde	2020-05-03	2020-05-04	165	2	33	130	f	f
903	Cabo Verde	2020-05-04	2020-05-05	175	2	37	136	f	f
904	Cabo Verde	2020-05-05	2020-05-06	186	2	37	147	f	f
905	Cabo Verde	2020-05-06	2020-05-07	191	2	38	151	f	f
906	Cabo Verde	2020-05-07	2020-05-08	218	2	38	178	f	f
907	Cabo Verde	2020-05-08	2020-05-09	230	2	44	184	f	f
908	Cabo Verde	2020-05-09	2020-05-10	236	2	56	178	f	f
909	Cabo Verde	2020-05-10	2020-05-11	246	2	56	188	f	f
910	Cabo Verde	2020-05-11	2020-05-12	260	2	58	200	f	f
911	Cabo Verde	2020-05-12	2020-05-13	267	2	58	207	f	f
912	Cabo Verde	2020-05-13	2020-05-14	289	2	61	226	f	f
913	Cabo Verde	2020-05-14	2020-05-15	315	2	67	246	f	f
914	Cabo Verde	2020-05-15	2020-05-16	326	2	67	257	f	f
915	Cabo Verde	2020-05-16	2020-05-17	328	3	84	241	f	f
916	Cabo Verde	2020-05-17	2020-05-18	328	3	84	241	f	f
917	Cabo Verde	2020-05-18	2020-05-19	328	3	85	240	f	f
918	Cabo Verde	2020-05-19	2020-05-20	335	3	85	247	f	f
919	Cabo Verde	2020-05-20	2020-05-21	349	3	85	261	f	f
920	Cabo Verde	2020-05-21	2020-05-22	356	3	95	258	f	f
921	Cabo Verde	2020-05-22	2020-05-23	362	3	95	264	f	f
922	Cabo Verde	2020-05-23	2020-05-24	371	3	142	226	f	f
923	Cabo Verde	2020-05-24	2020-05-25	380	3	155	222	f	f
924	Cabo Verde	2020-05-25	2020-05-26	390	3	155	232	f	f
925	Cabo Verde	2020-05-26	2020-05-27	390	4	155	231	f	f
926	Cabo Verde	2020-05-27	2020-05-28	390	4	155	231	f	f
927	Cabo Verde	2020-05-28	2020-05-29	390	4	155	231	f	f
928	Cabo Verde	2020-05-29	2020-05-30	405	4	155	246	f	f
929	Cabo Verde	2020-05-30	2020-05-31	421	4	167	250	f	f
930	Cabo Verde	2020-05-31	2020-06-01	435	4	193	238	f	f
931	Cambodia	2020-05-01	2020-05-02	122	0	120	2	f	f
932	Cambodia	2020-05-02	2020-05-03	122	0	120	2	f	f
933	Cambodia	2020-05-03	2020-05-04	122	0	120	2	f	f
934	Cambodia	2020-05-04	2020-05-05	122	0	120	2	f	f
935	Cambodia	2020-05-05	2020-05-06	122	0	120	2	f	f
936	Cambodia	2020-05-06	2020-05-07	122	0	120	2	f	f
937	Cambodia	2020-05-07	2020-05-08	122	0	120	2	f	f
938	Cambodia	2020-05-08	2020-05-09	122	0	120	2	f	f
939	Cambodia	2020-05-09	2020-05-10	122	0	120	2	f	f
940	Cambodia	2020-05-10	2020-05-11	122	0	120	2	f	f
941	Cambodia	2020-05-11	2020-05-12	122	0	121	1	f	f
942	Cambodia	2020-05-12	2020-05-13	122	0	121	1	f	f
943	Cambodia	2020-05-13	2020-05-14	122	0	121	1	f	f
944	Cambodia	2020-05-14	2020-05-15	122	0	121	1	f	f
945	Cambodia	2020-05-15	2020-05-16	122	0	122	0	f	f
946	Cambodia	2020-05-16	2020-05-17	122	0	122	0	f	f
947	Cambodia	2020-05-17	2020-05-18	122	0	122	0	f	f
948	Cambodia	2020-05-18	2020-05-19	122	0	122	0	f	f
949	Cambodia	2020-05-19	2020-05-20	122	0	122	0	f	f
950	Cambodia	2020-05-20	2020-05-21	122	0	122	0	f	f
951	Cambodia	2020-05-21	2020-05-22	123	0	122	1	f	f
952	Cambodia	2020-05-22	2020-05-23	123	0	122	1	f	f
953	Cambodia	2020-05-23	2020-05-24	124	0	122	2	f	f
954	Cambodia	2020-05-24	2020-05-25	124	0	122	2	f	f
955	Cambodia	2020-05-25	2020-05-26	124	0	122	2	f	f
956	Cambodia	2020-05-26	2020-05-27	124	0	122	2	f	f
957	Cambodia	2020-05-27	2020-05-28	124	0	122	2	f	f
958	Cambodia	2020-05-28	2020-05-29	124	0	122	2	f	f
959	Cambodia	2020-05-29	2020-05-30	124	0	122	2	f	f
960	Cambodia	2020-05-30	2020-05-31	125	0	123	2	f	f
961	Cambodia	2020-05-31	2020-06-01	125	0	123	2	f	f
962	Cameroon	2020-05-01	2020-05-02	1832	61	934	837	f	f
963	Cameroon	2020-05-02	2020-05-03	2077	64	953	1060	f	f
964	Cameroon	2020-05-03	2020-05-04	2077	64	953	1060	f	f
965	Cameroon	2020-05-04	2020-05-05	2104	64	953	1087	f	f
966	Cameroon	2020-05-05	2020-05-06	2104	64	953	1087	f	f
967	Cameroon	2020-05-06	2020-05-07	2265	108	1000	1157	f	f
968	Cameroon	2020-05-07	2020-05-08	2267	108	1002	1157	f	f
969	Cameroon	2020-05-08	2020-05-09	2267	108	1002	1157	f	f
970	Cameroon	2020-05-09	2020-05-10	2274	108	1232	934	f	f
971	Cameroon	2020-05-10	2020-05-11	2579	114	1465	1000	f	f
972	Cameroon	2020-05-11	2020-05-12	2689	125	1524	1040	f	f
973	Cameroon	2020-05-12	2020-05-13	2689	125	1524	1040	f	f
974	Cameroon	2020-05-13	2020-05-14	2800	136	1543	1121	f	f
975	Cameroon	2020-05-14	2020-05-15	2954	139	1553	1262	f	f
976	Cameroon	2020-05-15	2020-05-16	3105	140	1567	1398	f	f
977	Cameroon	2020-05-16	2020-05-17	3105	140	1567	1398	f	f
978	Cameroon	2020-05-17	2020-05-18	3105	140	1567	1398	f	f
979	Cameroon	2020-05-18	2020-05-19	3529	140	1567	1822	f	f
980	Cameroon	2020-05-19	2020-05-20	3529	140	1567	1822	f	f
981	Cameroon	2020-05-20	2020-05-21	3733	146	1595	1992	f	f
982	Cameroon	2020-05-21	2020-05-22	4288	156	1808	2324	f	f
983	Cameroon	2020-05-22	2020-05-23	4400	159	1822	2419	f	f
984	Cameroon	2020-05-23	2020-05-24	4400	159	1822	2419	f	f
985	Cameroon	2020-05-24	2020-05-25	4890	165	1865	2860	f	f
986	Cameroon	2020-05-25	2020-05-26	4890	165	1865	2860	f	f
987	Cameroon	2020-05-26	2020-05-27	5436	175	1996	3265	f	f
988	Cameroon	2020-05-27	2020-05-28	5436	175	1996	3265	f	f
989	Cameroon	2020-05-28	2020-05-29	5436	175	1996	3265	f	f
990	Cameroon	2020-05-29	2020-05-30	5436	177	3326	1933	f	f
991	Cameroon	2020-05-30	2020-05-31	5904	191	3568	2145	f	f
992	Cameroon	2020-05-31	2020-06-01	5904	191	3568	2145	f	f
993	Canada	2020-05-01	2020-05-02	56343	4381	22764	30042	f	f
994	Canada	2020-05-02	2020-05-03	57926	4529	23814	30428	f	f
995	Canada	2020-05-03	2020-05-04	60504	4669	24921	31788	f	f
996	Canada	2020-05-04	2020-05-05	61957	4911	26030	31924	f	f
997	Canada	2020-05-05	2020-05-06	63215	5081	27006	32019	f	f
998	Canada	2020-05-06	2020-05-07	64694	5240	28184	32144	f	f
999	Canada	2020-05-07	2020-05-08	66201	5387	29260	32400	f	f
1000	Canada	2020-05-08	2020-05-09	67674	5540	30239	32738	f	f
1001	Canada	2020-05-09	2020-05-10	68918	5704	31262	32833	f	f
1002	Canada	2020-05-10	2020-05-11	70091	5822	32109	32991	f	f
1003	Canada	2020-05-11	2020-05-12	71264	5956	33007	33142	f	f
1004	Canada	2020-05-12	2020-05-13	72419	6107	34055	33064	f	f
1005	Canada	2020-05-13	2020-05-14	73568	6210	35177	32966	f	f
1006	Canada	2020-05-14	2020-05-15	74781	6331	36104	33085	f	f
1007	Canada	2020-05-15	2020-05-16	75959	6452	36908	33372	f	f
1008	Canada	2020-05-16	2020-05-17	77206	6571	37832	33574	f	f
1009	Canada	2020-05-17	2020-05-18	78332	6661	38563	33866	f	f
1010	Canada	2020-05-18	2020-05-19	79411	6753	39251	34200	f	f
1011	Canada	2020-05-19	2020-05-20	80493	6828	40069	34396	f	f
1012	Canada	2020-05-20	2020-05-21	81575	6950	40793	34632	f	f
1013	Canada	2020-05-21	2020-05-22	82742	7046	41731	34744	f	f
1014	Canada	2020-05-22	2020-05-23	83947	7144	42608	34979	f	f
1015	Canada	2020-05-23	2020-05-24	85151	7238	43318	35367	f	f
1016	Canada	2020-05-24	2020-05-25	86106	7326	43998	35574	f	f
1017	Canada	2020-05-25	2020-05-26	87119	7420	44651	35813	f	f
1018	Canada	2020-05-26	2020-05-27	88090	7512	45352	35985	f	f
1019	Canada	2020-05-27	2020-05-28	88989	7606	46248	35865	f	f
1020	Canada	2020-05-28	2020-05-29	89976	7717	46961	36033	f	f
1021	Canada	2020-05-29	2020-05-30	90909	7797	47905	35941	f	f
1022	Canada	2020-05-30	2020-05-31	91681	7857	48517	36005	f	f
1023	Canada	2020-05-31	2020-06-01	92479	7906	49213	35892	f	f
1024	Central African Republic	2020-05-01	2020-05-02	72	0	10	62	f	f
1025	Central African Republic	2020-05-02	2020-05-03	72	0	10	62	f	f
1026	Central African Republic	2020-05-03	2020-05-04	72	0	10	62	f	f
1027	Central African Republic	2020-05-04	2020-05-05	85	0	10	75	f	f
1028	Central African Republic	2020-05-05	2020-05-06	85	0	10	75	f	f
1029	Central African Republic	2020-05-06	2020-05-07	94	0	10	84	f	f
1030	Central African Republic	2020-05-07	2020-05-08	94	0	10	84	f	f
1031	Central African Republic	2020-05-08	2020-05-09	143	0	10	133	f	f
1032	Central African Republic	2020-05-09	2020-05-10	143	0	10	133	f	f
1033	Central African Republic	2020-05-10	2020-05-11	143	0	10	133	f	f
1034	Central African Republic	2020-05-11	2020-05-12	143	0	10	133	f	f
1035	Central African Republic	2020-05-12	2020-05-13	143	0	10	133	f	f
1036	Central African Republic	2020-05-13	2020-05-14	143	0	10	133	f	f
1037	Central African Republic	2020-05-14	2020-05-15	143	0	10	133	f	f
1038	Central African Republic	2020-05-15	2020-05-16	301	0	13	288	f	f
1039	Central African Republic	2020-05-16	2020-05-17	327	0	13	314	f	f
1040	Central African Republic	2020-05-17	2020-05-18	327	0	13	314	f	f
1041	Central African Republic	2020-05-18	2020-05-19	327	0	13	314	f	f
1042	Central African Republic	2020-05-19	2020-05-20	366	0	18	348	f	f
1043	Central African Republic	2020-05-20	2020-05-21	418	0	18	400	f	f
1044	Central African Republic	2020-05-21	2020-05-22	436	0	18	418	f	f
1045	Central African Republic	2020-05-22	2020-05-23	479	0	18	461	f	f
1046	Central African Republic	2020-05-23	2020-05-24	552	1	18	533	f	f
1047	Central African Republic	2020-05-24	2020-05-25	604	1	22	581	f	f
1048	Central African Republic	2020-05-25	2020-05-26	652	1	22	629	f	f
1049	Central African Republic	2020-05-26	2020-05-27	671	1	22	648	f	f
1050	Central African Republic	2020-05-27	2020-05-28	702	1	23	678	f	f
1051	Central African Republic	2020-05-28	2020-05-29	755	1	23	731	f	f
1052	Central African Republic	2020-05-29	2020-05-30	874	1	23	850	f	f
1053	Central African Republic	2020-05-30	2020-05-31	962	1	23	938	f	f
1054	Central African Republic	2020-05-31	2020-06-01	1011	2	23	986	f	f
1055	Chad	2020-05-01	2020-05-02	73	5	33	35	f	f
1056	Chad	2020-05-02	2020-05-03	117	10	39	68	f	f
1057	Chad	2020-05-03	2020-05-04	117	10	39	68	f	f
1058	Chad	2020-05-04	2020-05-05	117	10	39	68	f	f
1059	Chad	2020-05-05	2020-05-06	170	17	43	110	f	f
1060	Chad	2020-05-06	2020-05-07	170	17	43	110	f	f
1061	Chad	2020-05-07	2020-05-08	253	27	50	176	f	f
1062	Chad	2020-05-08	2020-05-09	260	28	50	182	f	f
1063	Chad	2020-05-09	2020-05-10	322	31	53	238	f	f
1064	Chad	2020-05-10	2020-05-11	322	31	53	238	f	f
1065	Chad	2020-05-11	2020-05-12	322	31	53	238	f	f
1066	Chad	2020-05-12	2020-05-13	357	40	76	241	f	f
1067	Chad	2020-05-13	2020-05-14	372	42	78	252	f	f
1068	Chad	2020-05-14	2020-05-15	399	46	83	270	f	f
1069	Chad	2020-05-15	2020-05-16	428	48	88	292	f	f
1070	Chad	2020-05-16	2020-05-17	474	50	111	313	f	f
1071	Chad	2020-05-17	2020-05-18	503	53	117	333	f	f
1072	Chad	2020-05-18	2020-05-19	519	53	117	349	f	f
1073	Chad	2020-05-19	2020-05-20	545	56	139	350	f	f
1074	Chad	2020-05-20	2020-05-21	565	57	177	331	f	f
1075	Chad	2020-05-21	2020-05-22	588	58	186	344	f	f
1076	Chad	2020-05-22	2020-05-23	611	58	196	357	f	f
1077	Chad	2020-05-23	2020-05-24	648	60	204	384	f	f
1078	Chad	2020-05-24	2020-05-25	675	60	215	400	f	f
1079	Chad	2020-05-25	2020-05-26	687	61	244	382	f	f
1080	Chad	2020-05-26	2020-05-27	700	62	303	335	f	f
1081	Chad	2020-05-27	2020-05-28	715	64	359	292	f	f
1082	Chad	2020-05-28	2020-05-29	726	65	413	248	f	f
1083	Chad	2020-05-29	2020-05-30	759	65	444	250	f	f
1084	Chad	2020-05-30	2020-05-31	759	65	470	224	f	f
1085	Chad	2020-05-31	2020-06-01	778	65	491	222	f	f
1086	Chile	2020-05-01	2020-05-02	17008	234	9018	7756	f	f
1087	Chile	2020-05-02	2020-05-03	18435	247	9572	8616	f	f
1088	Chile	2020-05-03	2020-05-04	19663	260	10041	9362	f	f
1089	Chile	2020-05-04	2020-05-05	20643	270	10415	9958	f	f
1090	Chile	2020-05-05	2020-05-06	22016	275	10710	11031	f	f
1091	Chile	2020-05-06	2020-05-07	23048	281	11189	11578	f	f
1092	Chile	2020-05-07	2020-05-08	24581	285	11664	12632	f	f
1093	Chile	2020-05-08	2020-05-09	25972	294	12160	13518	f	f
1094	Chile	2020-05-09	2020-05-10	27219	304	12667	14248	f	f
1095	Chile	2020-05-10	2020-05-11	28866	312	13112	15442	f	f
1096	Chile	2020-05-11	2020-05-12	30063	323	13605	16135	f	f
1097	Chile	2020-05-12	2020-05-13	31721	335	14125	17261	f	f
1098	Chile	2020-05-13	2020-05-14	34381	346	14865	19170	f	f
1099	Chile	2020-05-14	2020-05-15	37040	368	15655	21017	f	f
1100	Chile	2020-05-15	2020-05-16	39542	394	16614	22534	f	f
1101	Chile	2020-05-16	2020-05-17	41428	421	18014	22993	f	f
1102	Chile	2020-05-17	2020-05-18	43781	450	19213	24118	f	f
1103	Chile	2020-05-18	2020-05-19	46059	478	20165	25416	f	f
1104	Chile	2020-05-19	2020-05-20	49579	509	21507	27563	f	f
1105	Chile	2020-05-20	2020-05-21	53617	544	22504	30569	f	f
1106	Chile	2020-05-21	2020-05-22	57581	589	23992	33000	f	f
1107	Chile	2020-05-22	2020-05-23	61857	630	25342	35885	f	f
1108	Chile	2020-05-23	2020-05-24	65393	673	26546	38174	f	f
1109	Chile	2020-05-24	2020-05-25	69102	718	28148	40236	f	f
1110	Chile	2020-05-25	2020-05-26	73997	761	29302	43934	f	f
1111	Chile	2020-05-26	2020-05-27	77961	806	30915	46240	f	f
1112	Chile	2020-05-27	2020-05-28	82289	841	33540	47908	f	f
1113	Chile	2020-05-28	2020-05-29	86943	890	36115	49938	f	f
1114	Chile	2020-05-29	2020-05-30	90638	944	38598	51096	f	f
1115	Chile	2020-05-30	2020-05-31	94858	997	40431	53430	f	f
1116	Chile	2020-05-31	2020-06-01	99688	1054	42727	55907	f	f
1117	China	2020-05-01	2020-05-02	83959	4637	78573	749	f	f
1118	China	2020-05-02	2020-05-03	83959	4637	78586	736	f	f
1119	China	2020-05-03	2020-05-04	83964	4637	78684	643	f	f
1120	China	2020-05-04	2020-05-05	83966	4637	78792	537	f	f
1121	China	2020-05-05	2020-05-06	83968	4637	78870	461	f	f
1122	China	2020-05-06	2020-05-07	83970	4637	78929	404	f	f
1123	China	2020-05-07	2020-05-08	83975	4637	78977	361	f	f
1124	China	2020-05-08	2020-05-09	83976	4637	78993	346	f	f
1125	China	2020-05-09	2020-05-10	83990	4637	79127	226	f	f
1126	China	2020-05-10	2020-05-11	84010	4637	79167	206	f	f
1127	China	2020-05-11	2020-05-12	84011	4637	79198	176	f	f
1128	China	2020-05-12	2020-05-13	84018	4637	79222	159	f	f
1129	China	2020-05-13	2020-05-14	84024	4637	79246	141	f	f
1130	China	2020-05-14	2020-05-15	84029	4637	79261	131	f	f
1131	China	2020-05-15	2020-05-16	84038	4637	79281	120	f	f
1132	China	2020-05-16	2020-05-17	84044	4638	79293	113	f	f
1133	China	2020-05-17	2020-05-18	84054	4638	79306	110	f	f
1134	China	2020-05-18	2020-05-19	84063	4638	79310	115	f	f
1135	China	2020-05-19	2020-05-20	84063	4638	79310	115	f	f
1136	China	2020-05-20	2020-05-21	84063	4638	79310	115	f	f
1137	China	2020-05-21	2020-05-22	84063	4638	79310	115	f	f
1138	China	2020-05-22	2020-05-23	84081	4638	79332	111	f	f
1139	China	2020-05-23	2020-05-24	84084	4638	79335	111	f	f
1140	China	2020-05-24	2020-05-25	84095	4638	79343	114	f	f
1141	China	2020-05-25	2020-05-26	84102	4638	79352	112	f	f
1142	China	2020-05-26	2020-05-27	84103	4638	79358	107	f	f
1143	China	2020-05-27	2020-05-28	84106	4638	79367	101	f	f
1144	China	2020-05-28	2020-05-29	84106	4638	79371	97	f	f
1145	China	2020-05-29	2020-05-30	84123	4638	79382	103	f	f
1146	China	2020-05-30	2020-05-31	84128	4638	79386	104	f	f
1147	China	2020-05-31	2020-06-01	84146	4638	79389	119	f	f
1148	Colombia	2020-05-01	2020-05-02	7006	314	1551	5141	f	f
1149	Colombia	2020-05-02	2020-05-03	7285	324	1666	5295	f	f
1150	Colombia	2020-05-03	2020-05-04	7668	340	1722	5606	f	f
1151	Colombia	2020-05-04	2020-05-05	7973	358	1807	5808	f	f
1152	Colombia	2020-05-05	2020-05-06	8613	378	2013	6222	f	f
1153	Colombia	2020-05-06	2020-05-07	8959	397	2148	6414	f	f
1154	Colombia	2020-05-07	2020-05-08	9456	407	2300	6749	f	f
1155	Colombia	2020-05-08	2020-05-09	10051	428	2424	7199	f	f
1156	Colombia	2020-05-09	2020-05-10	10495	445	2569	7481	f	f
1157	Colombia	2020-05-10	2020-05-11	11063	463	2705	7895	f	f
1158	Colombia	2020-05-11	2020-05-12	11613	479	2825	8309	f	f
1159	Colombia	2020-05-12	2020-05-13	12272	493	2971	8808	f	f
1160	Colombia	2020-05-13	2020-05-14	12930	509	3133	9288	f	f
1161	Colombia	2020-05-14	2020-05-15	13610	525	3358	9727	f	f
1162	Colombia	2020-05-15	2020-05-16	14216	546	3460	10210	f	f
1163	Colombia	2020-05-16	2020-05-17	14939	562	3587	10790	f	f
1164	Colombia	2020-05-17	2020-05-18	15574	574	3751	11249	f	f
1165	Colombia	2020-05-18	2020-05-19	16295	592	3903	11800	f	f
1166	Colombia	2020-05-19	2020-05-20	16935	613	4050	12272	f	f
1167	Colombia	2020-05-20	2020-05-21	17687	630	4256	12801	f	f
1168	Colombia	2020-05-21	2020-05-22	18330	652	4431	13247	f	f
1169	Colombia	2020-05-22	2020-05-23	19131	682	4575	13874	f	f
1170	Colombia	2020-05-23	2020-05-24	20177	705	4718	14754	f	f
1171	Colombia	2020-05-24	2020-05-25	21175	727	5016	15432	f	f
1172	Colombia	2020-05-25	2020-05-26	21981	750	5265	15966	f	f
1173	Colombia	2020-05-26	2020-05-27	23003	776	5511	16716	f	f
1174	Colombia	2020-05-27	2020-05-28	24104	803	6111	17190	f	f
1175	Colombia	2020-05-28	2020-05-29	24141	833	6132	17176	f	f
1176	Colombia	2020-05-29	2020-05-30	25406	855	6687	17864	f	f
1177	Colombia	2020-05-30	2020-05-31	26734	891	6935	18908	f	f
1178	Colombia	2020-05-31	2020-06-01	27219	916	7032	19271	f	f
1179	Comoros	2020-05-01	2020-05-02	1	0	0	1	f	f
1180	Comoros	2020-05-02	2020-05-03	3	0	0	3	f	f
1181	Comoros	2020-05-03	2020-05-04	3	0	0	3	f	f
1182	Comoros	2020-05-04	2020-05-05	3	0	0	3	f	f
1183	Comoros	2020-05-05	2020-05-06	3	0	0	3	f	f
1184	Comoros	2020-05-06	2020-05-07	8	1	0	7	f	f
1185	Comoros	2020-05-07	2020-05-08	8	1	0	7	f	f
1186	Comoros	2020-05-08	2020-05-09	8	1	0	7	f	f
1187	Comoros	2020-05-09	2020-05-10	11	1	0	10	f	f
1188	Comoros	2020-05-10	2020-05-11	11	1	0	10	f	f
1189	Comoros	2020-05-11	2020-05-12	11	1	0	10	f	f
1190	Comoros	2020-05-12	2020-05-13	11	1	0	10	f	f
1191	Comoros	2020-05-13	2020-05-14	11	1	0	10	f	f
1192	Comoros	2020-05-14	2020-05-15	11	1	3	7	f	f
1193	Comoros	2020-05-15	2020-05-16	11	1	3	7	f	f
1194	Comoros	2020-05-16	2020-05-17	11	1	3	7	f	f
1195	Comoros	2020-05-17	2020-05-18	11	1	3	7	f	f
1196	Comoros	2020-05-18	2020-05-19	11	1	3	7	f	f
1197	Comoros	2020-05-19	2020-05-20	11	1	3	7	f	f
1198	Comoros	2020-05-20	2020-05-21	34	1	8	25	f	f
1199	Comoros	2020-05-21	2020-05-22	34	1	8	25	f	f
1200	Comoros	2020-05-22	2020-05-23	78	1	18	59	f	f
1201	Comoros	2020-05-23	2020-05-24	78	1	18	59	f	f
1202	Comoros	2020-05-24	2020-05-25	87	1	21	65	f	f
1203	Comoros	2020-05-25	2020-05-26	87	1	21	65	f	f
1204	Comoros	2020-05-26	2020-05-27	87	1	21	65	f	f
1205	Comoros	2020-05-27	2020-05-28	87	2	24	61	f	f
1206	Comoros	2020-05-28	2020-05-29	87	2	24	61	f	f
1207	Comoros	2020-05-29	2020-05-30	87	2	24	61	f	f
1208	Comoros	2020-05-30	2020-05-31	106	2	26	78	f	f
1209	Comoros	2020-05-31	2020-06-01	106	2	26	78	f	f
1210	Congo (Brazzaville)	2020-05-01	2020-05-02	229	9	25	195	f	f
1211	Congo (Brazzaville)	2020-05-02	2020-05-03	229	9	25	195	f	f
1212	Congo (Brazzaville)	2020-05-03	2020-05-04	229	9	25	195	f	f
1213	Congo (Brazzaville)	2020-05-04	2020-05-05	236	10	26	200	f	f
1214	Congo (Brazzaville)	2020-05-05	2020-05-06	236	10	26	200	f	f
1215	Congo (Brazzaville)	2020-05-06	2020-05-07	264	10	30	224	f	f
1216	Congo (Brazzaville)	2020-05-07	2020-05-08	264	10	30	224	f	f
1217	Congo (Brazzaville)	2020-05-08	2020-05-09	274	10	33	231	f	f
1218	Congo (Brazzaville)	2020-05-09	2020-05-10	274	10	33	231	f	f
1219	Congo (Brazzaville)	2020-05-10	2020-05-11	274	10	33	231	f	f
1220	Congo (Brazzaville)	2020-05-11	2020-05-12	333	11	53	269	f	f
1221	Congo (Brazzaville)	2020-05-12	2020-05-13	333	11	53	269	f	f
1222	Congo (Brazzaville)	2020-05-13	2020-05-14	333	11	53	269	f	f
1223	Congo (Brazzaville)	2020-05-14	2020-05-15	391	15	87	289	f	f
1224	Congo (Brazzaville)	2020-05-15	2020-05-16	391	15	87	289	f	f
1225	Congo (Brazzaville)	2020-05-16	2020-05-17	391	15	87	289	f	f
1226	Congo (Brazzaville)	2020-05-17	2020-05-18	391	15	87	289	f	f
1227	Congo (Brazzaville)	2020-05-18	2020-05-19	412	15	110	287	f	f
1228	Congo (Brazzaville)	2020-05-19	2020-05-20	420	15	132	273	f	f
1229	Congo (Brazzaville)	2020-05-20	2020-05-21	420	15	132	273	f	f
1230	Congo (Brazzaville)	2020-05-21	2020-05-22	469	16	137	316	f	f
1231	Congo (Brazzaville)	2020-05-22	2020-05-23	469	16	137	316	f	f
1232	Congo (Brazzaville)	2020-05-23	2020-05-24	487	16	147	324	f	f
1233	Congo (Brazzaville)	2020-05-24	2020-05-25	487	16	147	324	f	f
1234	Congo (Brazzaville)	2020-05-25	2020-05-26	487	16	147	324	f	f
1235	Congo (Brazzaville)	2020-05-26	2020-05-27	487	16	147	324	f	f
1236	Congo (Brazzaville)	2020-05-27	2020-05-28	571	19	161	391	f	f
1237	Congo (Brazzaville)	2020-05-28	2020-05-29	571	19	161	391	f	f
1238	Congo (Brazzaville)	2020-05-29	2020-05-30	571	19	161	391	f	f
1239	Congo (Brazzaville)	2020-05-30	2020-05-31	571	19	161	391	f	f
1240	Congo (Brazzaville)	2020-05-31	2020-06-01	611	20	179	412	f	f
1241	Congo (Kinshasa)	2020-05-01	2020-05-02	604	32	75	497	f	f
1242	Congo (Kinshasa)	2020-05-02	2020-05-03	674	33	75	566	f	f
1243	Congo (Kinshasa)	2020-05-03	2020-05-04	674	33	75	566	f	f
1244	Congo (Kinshasa)	2020-05-04	2020-05-05	682	34	80	568	f	f
1245	Congo (Kinshasa)	2020-05-05	2020-05-06	705	34	90	581	f	f
1246	Congo (Kinshasa)	2020-05-06	2020-05-07	797	35	92	670	f	f
1247	Congo (Kinshasa)	2020-05-07	2020-05-08	863	36	103	724	f	f
1248	Congo (Kinshasa)	2020-05-08	2020-05-09	937	39	130	768	f	f
1249	Congo (Kinshasa)	2020-05-09	2020-05-10	937	39	130	768	f	f
1250	Congo (Kinshasa)	2020-05-10	2020-05-11	991	41	136	814	f	f
1251	Congo (Kinshasa)	2020-05-11	2020-05-12	1024	41	141	842	f	f
1252	Congo (Kinshasa)	2020-05-12	2020-05-13	1102	44	146	912	f	f
1253	Congo (Kinshasa)	2020-05-13	2020-05-14	1169	50	148	971	f	f
1254	Congo (Kinshasa)	2020-05-14	2020-05-15	1242	50	157	1035	f	f
1255	Congo (Kinshasa)	2020-05-15	2020-05-16	1298	50	212	1036	f	f
1256	Congo (Kinshasa)	2020-05-16	2020-05-17	1455	61	270	1124	f	f
1257	Congo (Kinshasa)	2020-05-17	2020-05-18	1455	61	270	1124	f	f
1258	Congo (Kinshasa)	2020-05-18	2020-05-19	1538	61	272	1205	f	f
1259	Congo (Kinshasa)	2020-05-19	2020-05-20	1629	61	290	1278	f	f
1260	Congo (Kinshasa)	2020-05-20	2020-05-21	1731	61	302	1368	f	f
1261	Congo (Kinshasa)	2020-05-21	2020-05-22	1835	61	303	1471	f	f
1262	Congo (Kinshasa)	2020-05-22	2020-05-23	1945	63	312	1570	f	f
1263	Congo (Kinshasa)	2020-05-23	2020-05-24	2025	63	312	1650	f	f
1264	Congo (Kinshasa)	2020-05-24	2020-05-25	2141	63	317	1761	f	f
1265	Congo (Kinshasa)	2020-05-25	2020-05-26	2297	67	337	1893	f	f
1266	Congo (Kinshasa)	2020-05-26	2020-05-27	2403	68	340	1995	f	f
1267	Congo (Kinshasa)	2020-05-27	2020-05-28	2546	68	365	2113	f	f
1268	Congo (Kinshasa)	2020-05-28	2020-05-29	2660	69	381	2210	f	f
1269	Congo (Kinshasa)	2020-05-29	2020-05-30	2833	69	400	2364	f	f
1270	Congo (Kinshasa)	2020-05-30	2020-05-31	2966	69	428	2469	f	f
1271	Congo (Kinshasa)	2020-05-31	2020-06-01	3070	72	448	2550	f	f
1272	Costa Rica	2020-05-01	2020-05-02	725	6	355	364	f	f
1273	Costa Rica	2020-05-02	2020-05-03	733	6	372	355	f	f
1274	Costa Rica	2020-05-03	2020-05-04	739	6	386	347	f	f
1275	Costa Rica	2020-05-04	2020-05-05	742	6	399	337	f	f
1276	Costa Rica	2020-05-05	2020-05-06	755	6	413	336	f	f
1277	Costa Rica	2020-05-06	2020-05-07	761	6	428	327	f	f
1278	Costa Rica	2020-05-07	2020-05-08	765	6	445	314	f	f
1279	Costa Rica	2020-05-08	2020-05-09	773	6	461	306	f	f
1280	Costa Rica	2020-05-09	2020-05-10	780	6	480	294	f	f
1281	Costa Rica	2020-05-10	2020-05-11	792	7	501	284	f	f
1282	Costa Rica	2020-05-11	2020-05-12	801	7	517	277	f	f
1283	Costa Rica	2020-05-12	2020-05-13	804	7	520	277	f	f
1284	Costa Rica	2020-05-13	2020-05-14	815	8	527	280	f	f
1285	Costa Rica	2020-05-14	2020-05-15	830	8	535	287	f	f
1286	Costa Rica	2020-05-15	2020-05-16	843	9	542	292	f	f
1287	Costa Rica	2020-05-16	2020-05-17	853	10	551	292	f	f
1288	Costa Rica	2020-05-17	2020-05-18	863	10	565	288	f	f
1289	Costa Rica	2020-05-18	2020-05-19	866	10	575	281	f	f
1290	Costa Rica	2020-05-19	2020-05-20	882	10	577	295	f	f
1291	Costa Rica	2020-05-20	2020-05-21	897	10	582	305	f	f
1292	Costa Rica	2020-05-21	2020-05-22	903	10	592	301	f	f
1293	Costa Rica	2020-05-22	2020-05-23	911	10	600	301	f	f
1294	Costa Rica	2020-05-23	2020-05-24	918	10	607	301	f	f
1295	Costa Rica	2020-05-24	2020-05-25	930	10	620	300	f	f
1296	Costa Rica	2020-05-25	2020-05-26	951	10	628	313	f	f
1297	Costa Rica	2020-05-26	2020-05-27	956	10	634	312	f	f
1298	Costa Rica	2020-05-27	2020-05-28	984	10	639	335	f	f
1299	Costa Rica	2020-05-28	2020-05-29	1000	10	646	344	f	f
1300	Costa Rica	2020-05-29	2020-05-30	1022	10	653	359	f	f
1301	Costa Rica	2020-05-30	2020-05-31	1047	10	658	379	f	f
1302	Costa Rica	2020-05-31	2020-06-01	1056	10	669	377	f	f
1303	Cote d'Ivoire	2020-05-01	2020-05-02	1333	15	597	721	f	f
1304	Cote d'Ivoire	2020-05-02	2020-05-03	1362	15	622	725	f	f
1305	Cote d'Ivoire	2020-05-03	2020-05-04	1398	17	653	728	f	f
1306	Cote d'Ivoire	2020-05-04	2020-05-05	1432	17	693	722	f	f
1307	Cote d'Ivoire	2020-05-05	2020-05-06	1464	18	701	745	f	f
1308	Cote d'Ivoire	2020-05-06	2020-05-07	1516	18	721	777	f	f
1309	Cote d'Ivoire	2020-05-07	2020-05-08	1571	20	742	809	f	f
1310	Cote d'Ivoire	2020-05-08	2020-05-09	1602	20	754	828	f	f
1311	Cote d'Ivoire	2020-05-09	2020-05-10	1667	21	769	877	f	f
1312	Cote d'Ivoire	2020-05-10	2020-05-11	1700	21	794	885	f	f
1313	Cote d'Ivoire	2020-05-11	2020-05-12	1730	21	818	891	f	f
1314	Cote d'Ivoire	2020-05-12	2020-05-13	1857	21	820	1016	f	f
1315	Cote d'Ivoire	2020-05-13	2020-05-14	1912	24	902	986	f	f
1316	Cote d'Ivoire	2020-05-14	2020-05-15	1971	24	930	1017	f	f
1317	Cote d'Ivoire	2020-05-15	2020-05-16	2017	24	942	1051	f	f
1318	Cote d'Ivoire	2020-05-16	2020-05-17	2061	25	987	1049	f	f
1319	Cote d'Ivoire	2020-05-17	2020-05-18	2109	27	1004	1078	f	f
1320	Cote d'Ivoire	2020-05-18	2020-05-19	2119	28	1040	1051	f	f
1321	Cote d'Ivoire	2020-05-19	2020-05-20	2153	28	1050	1075	f	f
1322	Cote d'Ivoire	2020-05-20	2020-05-21	2231	29	1083	1119	f	f
1323	Cote d'Ivoire	2020-05-21	2020-05-22	2301	29	1100	1172	f	f
1324	Cote d'Ivoire	2020-05-22	2020-05-23	2341	29	1146	1166	f	f
1325	Cote d'Ivoire	2020-05-23	2020-05-24	2366	30	1188	1148	f	f
1326	Cote d'Ivoire	2020-05-24	2020-05-25	2376	30	1219	1127	f	f
1327	Cote d'Ivoire	2020-05-25	2020-05-26	2423	30	1257	1136	f	f
1328	Cote d'Ivoire	2020-05-26	2020-05-27	2477	30	1286	1161	f	f
1329	Cote d'Ivoire	2020-05-27	2020-05-28	2556	31	1302	1223	f	f
1330	Cote d'Ivoire	2020-05-28	2020-05-29	2641	32	1326	1283	f	f
1331	Cote d'Ivoire	2020-05-29	2020-05-30	2750	32	1370	1348	f	f
1332	Cote d'Ivoire	2020-05-30	2020-05-31	2799	33	1385	1381	f	f
1333	Cote d'Ivoire	2020-05-31	2020-06-01	2833	33	1435	1365	f	f
1334	Croatia	2020-05-01	2020-05-02	2085	75	1421	589	f	f
1335	Croatia	2020-05-02	2020-05-03	2088	77	1463	548	f	f
1336	Croatia	2020-05-03	2020-05-04	2096	79	1489	528	f	f
1337	Croatia	2020-05-04	2020-05-05	2101	80	1522	499	f	f
1338	Croatia	2020-05-05	2020-05-06	2112	83	1560	469	f	f
1339	Croatia	2020-05-06	2020-05-07	2119	85	1601	433	f	f
1340	Croatia	2020-05-07	2020-05-08	2125	86	1641	398	f	f
1341	Croatia	2020-05-08	2020-05-09	2161	86	1689	386	f	f
1342	Croatia	2020-05-09	2020-05-10	2176	87	1726	363	f	f
1343	Croatia	2020-05-10	2020-05-11	2187	90	1764	333	f	f
1344	Croatia	2020-05-11	2020-05-12	2196	91	1784	321	f	f
1345	Croatia	2020-05-12	2020-05-13	2207	91	1808	308	f	f
1346	Croatia	2020-05-13	2020-05-14	2213	94	1834	285	f	f
1347	Croatia	2020-05-14	2020-05-15	2221	94	1850	277	f	f
1348	Croatia	2020-05-15	2020-05-16	2222	95	1869	258	f	f
1349	Croatia	2020-05-16	2020-05-17	2224	95	1913	216	f	f
1350	Croatia	2020-05-17	2020-05-18	2226	95	1936	195	f	f
1351	Croatia	2020-05-18	2020-05-19	2228	95	1946	187	f	f
1352	Croatia	2020-05-19	2020-05-20	2232	96	1967	169	f	f
1353	Croatia	2020-05-20	2020-05-21	2234	96	1978	160	f	f
1354	Croatia	2020-05-21	2020-05-22	2237	97	1978	162	f	f
1355	Croatia	2020-05-22	2020-05-23	2243	99	2011	133	f	f
1356	Croatia	2020-05-23	2020-05-24	2243	99	2023	121	f	f
1357	Croatia	2020-05-24	2020-05-25	2244	99	2027	118	f	f
1358	Croatia	2020-05-25	2020-05-26	2244	100	2035	109	f	f
1359	Croatia	2020-05-26	2020-05-27	2244	101	2046	97	f	f
1360	Croatia	2020-05-27	2020-05-28	2244	101	2047	96	f	f
1361	Croatia	2020-05-28	2020-05-29	2245	102	2051	92	f	f
1362	Croatia	2020-05-29	2020-05-30	2245	103	2059	83	f	f
1363	Croatia	2020-05-30	2020-05-31	2246	103	2063	80	f	f
1364	Croatia	2020-05-31	2020-06-01	2246	103	2072	71	f	f
1365	Cuba	2020-05-01	2020-05-02	1537	64	714	759	f	f
1366	Cuba	2020-05-02	2020-05-03	1611	66	765	780	f	f
1367	Cuba	2020-05-03	2020-05-04	1649	67	827	755	f	f
1368	Cuba	2020-05-04	2020-05-05	1668	69	876	723	f	f
1369	Cuba	2020-05-05	2020-05-06	1685	69	954	662	f	f
1370	Cuba	2020-05-06	2020-05-07	1703	69	1001	633	f	f
1371	Cuba	2020-05-07	2020-05-08	1729	73	1031	625	f	f
1372	Cuba	2020-05-08	2020-05-09	1741	74	1078	589	f	f
1373	Cuba	2020-05-09	2020-05-10	1754	74	1140	540	f	f
1374	Cuba	2020-05-10	2020-05-11	1766	77	1193	496	f	f
1375	Cuba	2020-05-11	2020-05-12	1783	77	1229	477	f	f
1376	Cuba	2020-05-12	2020-05-13	1804	78	1277	449	f	f
1377	Cuba	2020-05-13	2020-05-14	1810	79	1326	405	f	f
1378	Cuba	2020-05-14	2020-05-15	1830	79	1383	368	f	f
1379	Cuba	2020-05-15	2020-05-16	1840	79	1425	336	f	f
1380	Cuba	2020-05-16	2020-05-17	1862	79	1460	323	f	f
1381	Cuba	2020-05-17	2020-05-18	1872	79	1495	298	f	f
1382	Cuba	2020-05-18	2020-05-19	1881	79	1505	297	f	f
1383	Cuba	2020-05-19	2020-05-20	1887	79	1538	270	f	f
1384	Cuba	2020-05-20	2020-05-21	1900	79	1573	248	f	f
1385	Cuba	2020-05-21	2020-05-22	1908	80	1603	225	f	f
1386	Cuba	2020-05-22	2020-05-23	1916	81	1631	204	f	f
1387	Cuba	2020-05-23	2020-05-24	1931	81	1671	179	f	f
1388	Cuba	2020-05-24	2020-05-25	1941	82	1689	170	f	f
1389	Cuba	2020-05-25	2020-05-26	1947	82	1704	161	f	f
1390	Cuba	2020-05-26	2020-05-27	1963	82	1709	172	f	f
1391	Cuba	2020-05-27	2020-05-28	1974	82	1724	168	f	f
1392	Cuba	2020-05-28	2020-05-29	1983	82	1734	167	f	f
1393	Cuba	2020-05-29	2020-05-30	2005	82	1760	163	f	f
1394	Cuba	2020-05-30	2020-05-31	2025	83	1795	147	f	f
1395	Cuba	2020-05-31	2020-06-01	2045	83	1809	153	f	f
1396	Cyprus	2020-05-01	2020-05-02	857	15	296	546	f	f
1397	Cyprus	2020-05-02	2020-05-03	864	15	296	553	f	f
1398	Cyprus	2020-05-03	2020-05-04	872	15	296	561	f	f
1399	Cyprus	2020-05-04	2020-05-05	874	15	296	563	f	f
1400	Cyprus	2020-05-05	2020-05-06	878	15	296	567	f	f
1401	Cyprus	2020-05-06	2020-05-07	883	15	296	572	f	f
1402	Cyprus	2020-05-07	2020-05-08	889	15	400	474	f	f
1403	Cyprus	2020-05-08	2020-05-09	891	15	400	476	f	f
1404	Cyprus	2020-05-09	2020-05-10	892	15	401	476	f	f
1405	Cyprus	2020-05-10	2020-05-11	898	16	401	481	f	f
1406	Cyprus	2020-05-11	2020-05-12	901	16	401	484	f	f
1407	Cyprus	2020-05-12	2020-05-13	903	16	449	438	f	f
1408	Cyprus	2020-05-13	2020-05-14	905	17	449	439	f	f
1409	Cyprus	2020-05-14	2020-05-15	907	17	481	409	f	f
1410	Cyprus	2020-05-15	2020-05-16	910	17	481	412	f	f
1411	Cyprus	2020-05-16	2020-05-17	914	17	515	382	f	f
1412	Cyprus	2020-05-17	2020-05-18	916	17	515	384	f	f
1413	Cyprus	2020-05-18	2020-05-19	917	17	515	385	f	f
1414	Cyprus	2020-05-19	2020-05-20	918	17	515	386	f	f
1415	Cyprus	2020-05-20	2020-05-21	922	17	516	389	f	f
1416	Cyprus	2020-05-21	2020-05-22	923	17	561	345	f	f
1417	Cyprus	2020-05-22	2020-05-23	927	17	561	349	f	f
1418	Cyprus	2020-05-23	2020-05-24	927	17	594	316	f	f
1419	Cyprus	2020-05-24	2020-05-25	935	17	594	324	f	f
1420	Cyprus	2020-05-25	2020-05-26	937	17	594	326	f	f
1421	Cyprus	2020-05-26	2020-05-27	939	17	594	328	f	f
1422	Cyprus	2020-05-27	2020-05-28	939	17	594	328	f	f
1423	Cyprus	2020-05-28	2020-05-29	941	17	784	140	f	f
1424	Cyprus	2020-05-29	2020-05-30	942	17	784	141	f	f
1425	Cyprus	2020-05-30	2020-05-31	944	17	790	137	f	f
1426	Cyprus	2020-05-31	2020-06-01	944	17	790	137	f	f
1427	Czechia	2020-05-01	2020-05-02	7737	240	3372	4125	f	f
1428	Czechia	2020-05-02	2020-05-03	7755	245	3461	4049	f	f
1429	Czechia	2020-05-03	2020-05-04	7781	248	3587	3946	f	f
1430	Czechia	2020-05-04	2020-05-05	7819	252	3807	3760	f	f
1431	Czechia	2020-05-05	2020-05-06	7896	257	4006	3633	f	f
1432	Czechia	2020-05-06	2020-05-07	7974	262	4205	3507	f	f
1433	Czechia	2020-05-07	2020-05-08	8031	270	4371	3390	f	f
1434	Czechia	2020-05-08	2020-05-09	8077	273	4413	3391	f	f
1435	Czechia	2020-05-09	2020-05-10	8095	276	4447	3372	f	f
1436	Czechia	2020-05-10	2020-05-11	8123	280	4474	3369	f	f
1437	Czechia	2020-05-11	2020-05-12	8176	282	4711	3183	f	f
1438	Czechia	2020-05-12	2020-05-13	8221	283	4889	3049	f	f
1439	Czechia	2020-05-13	2020-05-14	8269	290	5047	2932	f	f
1440	Czechia	2020-05-14	2020-05-15	8351	293	5241	2817	f	f
1441	Czechia	2020-05-15	2020-05-16	8406	295	5381	2730	f	f
1442	Czechia	2020-05-16	2020-05-17	8455	296	5422	2737	f	f
1443	Czechia	2020-05-17	2020-05-18	8475	298	5462	2715	f	f
1444	Czechia	2020-05-18	2020-05-19	8586	297	5641	2648	f	f
1445	Czechia	2020-05-19	2020-05-20	8647	302	5726	2619	f	f
1446	Czechia	2020-05-20	2020-05-21	8721	304	5830	2587	f	f
1447	Czechia	2020-05-21	2020-05-22	8754	306	5926	2522	f	f
1448	Czechia	2020-05-22	2020-05-23	8813	312	6025	2476	f	f
1449	Czechia	2020-05-23	2020-05-24	8890	314	6044	2532	f	f
1450	Czechia	2020-05-24	2020-05-25	8955	315	6078	2562	f	f
1451	Czechia	2020-05-25	2020-05-26	9002	317	6182	2503	f	f
1452	Czechia	2020-05-26	2020-05-27	9050	317	6270	2463	f	f
1453	Czechia	2020-05-27	2020-05-28	9086	317	6370	2399	f	f
1454	Czechia	2020-05-28	2020-05-29	9140	319	6460	2361	f	f
1455	Czechia	2020-05-29	2020-05-30	9196	319	6500	2377	f	f
1456	Czechia	2020-05-30	2020-05-31	9230	319	6546	2365	f	f
1457	Czechia	2020-05-31	2020-06-01	9268	320	6558	2390	f	f
1458	Denmark	2020-05-01	2020-05-02	9509	460	6924	2125	f	f
1459	Denmark	2020-05-02	2020-05-03	9605	475	7084	2046	f	f
1460	Denmark	2020-05-03	2020-05-04	9721	484	7183	2054	f	f
1461	Denmark	2020-05-04	2020-05-05	9868	493	7284	2091	f	f
1462	Denmark	2020-05-05	2020-05-06	10019	503	7492	2024	f	f
1463	Denmark	2020-05-06	2020-05-07	10136	506	7689	1941	f	f
1464	Denmark	2020-05-07	2020-05-08	10281	514	7907	1860	f	f
1465	Denmark	2020-05-08	2020-05-09	10416	522	8125	1769	f	f
1466	Denmark	2020-05-09	2020-05-10	10517	526	8291	1700	f	f
1467	Denmark	2020-05-10	2020-05-11	10627	529	8415	1683	f	f
1468	Denmark	2020-05-11	2020-05-12	10711	533	8526	1652	f	f
1469	Denmark	2020-05-12	2020-05-13	10789	527	8778	1484	f	f
1470	Denmark	2020-05-13	2020-05-14	10865	533	8861	1471	f	f
1471	Denmark	2020-05-14	2020-05-15	10911	537	9003	1371	f	f
1472	Denmark	2020-05-15	2020-05-16	10989	537	9157	1295	f	f
1473	Denmark	2020-05-16	2020-05-17	11056	543	9305	1208	f	f
1474	Denmark	2020-05-17	2020-05-18	11125	547	9425	1153	f	f
1475	Denmark	2020-05-18	2020-05-19	11166	548	9499	1119	f	f
1476	Denmark	2020-05-19	2020-05-20	11242	551	9614	1077	f	f
1477	Denmark	2020-05-20	2020-05-21	11315	554	9734	1027	f	f
1478	Denmark	2020-05-21	2020-05-22	11380	561	9841	978	f	f
1479	Denmark	2020-05-22	2020-05-23	11428	561	9962	905	f	f
1480	Denmark	2020-05-23	2020-05-24	11487	561	10034	892	f	f
1481	Denmark	2020-05-24	2020-05-25	11559	562	10098	899	f	f
1482	Denmark	2020-05-25	2020-05-26	11586	563	10162	861	f	f
1483	Denmark	2020-05-26	2020-05-27	11627	563	10242	822	f	f
1484	Denmark	2020-05-27	2020-05-28	11680	565	10304	811	f	f
1485	Denmark	2020-05-28	2020-05-29	11712	568	10378	766	f	f
1486	Denmark	2020-05-29	2020-05-30	11793	568	10438	787	f	f
1487	Denmark	2020-05-30	2020-05-31	11833	571	10525	737	f	f
1488	Denmark	2020-05-31	2020-06-01	11869	574	10560	735	f	f
1489	Diamond Princess	2020-05-01	2020-05-02	712	13	645	54	f	f
1490	Diamond Princess	2020-05-02	2020-05-03	712	13	645	54	f	f
1491	Diamond Princess	2020-05-03	2020-05-04	712	13	645	54	f	f
1492	Diamond Princess	2020-05-04	2020-05-05	712	13	645	54	f	f
1493	Diamond Princess	2020-05-05	2020-05-06	712	13	645	54	f	f
1494	Diamond Princess	2020-05-06	2020-05-07	712	13	645	54	f	f
1495	Diamond Princess	2020-05-07	2020-05-08	712	13	645	54	f	f
1496	Diamond Princess	2020-05-08	2020-05-09	712	13	645	54	f	f
1497	Diamond Princess	2020-05-09	2020-05-10	712	13	645	54	f	f
1498	Diamond Princess	2020-05-10	2020-05-11	712	13	651	48	f	f
1499	Diamond Princess	2020-05-11	2020-05-12	712	13	651	48	f	f
1500	Diamond Princess	2020-05-12	2020-05-13	712	13	651	48	f	f
1501	Diamond Princess	2020-05-13	2020-05-14	712	13	651	48	f	f
1502	Diamond Princess	2020-05-14	2020-05-15	712	13	651	48	f	f
1503	Diamond Princess	2020-05-15	2020-05-16	712	13	651	48	f	f
1504	Diamond Princess	2020-05-16	2020-05-17	712	13	651	48	f	f
1505	Diamond Princess	2020-05-17	2020-05-18	712	13	651	48	f	f
1506	Diamond Princess	2020-05-18	2020-05-19	712	13	651	48	f	f
1507	Diamond Princess	2020-05-19	2020-05-20	712	13	651	48	f	f
1508	Diamond Princess	2020-05-20	2020-05-21	712	13	651	48	f	f
1509	Diamond Princess	2020-05-21	2020-05-22	712	13	651	48	f	f
1510	Diamond Princess	2020-05-22	2020-05-23	712	13	651	48	f	f
1511	Diamond Princess	2020-05-23	2020-05-24	712	13	651	48	f	f
1512	Diamond Princess	2020-05-24	2020-05-25	712	13	651	48	f	f
1513	Diamond Princess	2020-05-25	2020-05-26	712	13	651	48	f	f
1514	Diamond Princess	2020-05-26	2020-05-27	712	13	651	48	f	f
1515	Diamond Princess	2020-05-27	2020-05-28	712	13	651	48	f	f
1516	Diamond Princess	2020-05-28	2020-05-29	712	13	651	48	f	f
1517	Diamond Princess	2020-05-29	2020-05-30	712	13	651	48	f	f
1518	Diamond Princess	2020-05-30	2020-05-31	712	13	651	48	f	f
1519	Diamond Princess	2020-05-31	2020-06-01	712	13	651	48	f	f
1520	Djibouti	2020-05-01	2020-05-02	1097	2	672	423	f	f
1521	Djibouti	2020-05-02	2020-05-03	1112	2	686	424	f	f
1522	Djibouti	2020-05-03	2020-05-04	1112	2	686	424	f	f
1523	Djibouti	2020-05-04	2020-05-05	1116	2	713	401	f	f
1524	Djibouti	2020-05-05	2020-05-06	1120	2	745	373	f	f
1525	Djibouti	2020-05-06	2020-05-07	1124	3	755	366	f	f
1526	Djibouti	2020-05-07	2020-05-08	1133	3	799	331	f	f
1527	Djibouti	2020-05-08	2020-05-09	1135	3	824	308	f	f
1528	Djibouti	2020-05-09	2020-05-10	1189	3	834	352	f	f
1529	Djibouti	2020-05-10	2020-05-11	1210	3	847	360	f	f
1530	Djibouti	2020-05-11	2020-05-12	1227	3	872	352	f	f
1531	Djibouti	2020-05-12	2020-05-13	1256	3	886	367	f	f
1532	Djibouti	2020-05-13	2020-05-14	1268	3	900	365	f	f
1533	Djibouti	2020-05-14	2020-05-15	1284	3	905	376	f	f
1534	Djibouti	2020-05-15	2020-05-16	1309	4	935	370	f	f
1535	Djibouti	2020-05-16	2020-05-17	1331	4	950	377	f	f
1536	Djibouti	2020-05-17	2020-05-18	1401	4	972	425	f	f
1537	Djibouti	2020-05-18	2020-05-19	1518	7	1018	493	f	f
1538	Djibouti	2020-05-19	2020-05-20	1618	7	1033	578	f	f
1539	Djibouti	2020-05-20	2020-05-21	1828	9	1052	767	f	f
1540	Djibouti	2020-05-21	2020-05-22	2047	10	1055	982	f	f
1541	Djibouti	2020-05-22	2020-05-23	2270	10	1064	1196	f	f
1542	Djibouti	2020-05-23	2020-05-24	2270	10	1064	1196	f	f
1543	Djibouti	2020-05-24	2020-05-25	2270	10	1064	1196	f	f
1544	Djibouti	2020-05-25	2020-05-26	2468	14	1079	1375	f	f
1545	Djibouti	2020-05-26	2020-05-27	2468	14	1079	1375	f	f
1546	Djibouti	2020-05-27	2020-05-28	2697	18	1185	1494	f	f
1547	Djibouti	2020-05-28	2020-05-29	2914	20	1241	1653	f	f
1548	Djibouti	2020-05-29	2020-05-30	2914	20	1241	1653	f	f
1549	Djibouti	2020-05-30	2020-05-31	3194	22	1286	1886	f	f
1550	Djibouti	2020-05-31	2020-06-01	3354	24	1504	1826	f	f
1551	Dominica	2020-05-01	2020-05-02	16	0	13	3	f	f
1552	Dominica	2020-05-02	2020-05-03	16	0	13	3	f	f
1553	Dominica	2020-05-03	2020-05-04	16	0	13	3	f	f
1554	Dominica	2020-05-04	2020-05-05	16	0	13	3	f	f
1555	Dominica	2020-05-05	2020-05-06	16	0	14	2	f	f
1556	Dominica	2020-05-06	2020-05-07	16	0	14	2	f	f
1557	Dominica	2020-05-07	2020-05-08	16	0	14	2	f	f
1558	Dominica	2020-05-08	2020-05-09	16	0	14	2	f	f
1559	Dominica	2020-05-09	2020-05-10	16	0	14	2	f	f
1560	Dominica	2020-05-10	2020-05-11	16	0	15	1	f	f
1561	Dominica	2020-05-11	2020-05-12	16	0	15	1	f	f
1562	Dominica	2020-05-12	2020-05-13	16	0	15	1	f	f
1563	Dominica	2020-05-13	2020-05-14	16	0	15	1	f	f
1564	Dominica	2020-05-14	2020-05-15	16	0	15	1	f	f
1565	Dominica	2020-05-15	2020-05-16	16	0	15	1	f	f
1566	Dominica	2020-05-16	2020-05-17	16	0	15	1	f	f
1567	Dominica	2020-05-17	2020-05-18	16	0	16	0	f	f
1568	Dominica	2020-05-18	2020-05-19	16	0	16	0	f	f
1569	Dominica	2020-05-19	2020-05-20	16	0	16	0	f	f
1570	Dominica	2020-05-20	2020-05-21	16	0	16	0	f	f
1571	Dominica	2020-05-21	2020-05-22	16	0	16	0	f	f
1572	Dominica	2020-05-22	2020-05-23	16	0	16	0	f	f
1573	Dominica	2020-05-23	2020-05-24	16	0	16	0	f	f
1574	Dominica	2020-05-24	2020-05-25	16	0	16	0	f	f
1575	Dominica	2020-05-25	2020-05-26	16	0	16	0	f	f
1576	Dominica	2020-05-26	2020-05-27	16	0	16	0	f	f
1577	Dominica	2020-05-27	2020-05-28	16	0	16	0	f	f
1578	Dominica	2020-05-28	2020-05-29	16	0	16	0	f	f
1579	Dominica	2020-05-29	2020-05-30	16	0	16	0	f	f
1580	Dominica	2020-05-30	2020-05-31	16	0	16	0	f	f
1581	Dominica	2020-05-31	2020-06-01	16	0	16	0	f	f
1582	Dominican Republic	2020-05-01	2020-05-02	7288	313	1387	5588	f	f
1583	Dominican Republic	2020-05-02	2020-05-03	7578	326	1481	5771	f	f
1584	Dominican Republic	2020-05-03	2020-05-04	7954	333	1606	6015	f	f
1585	Dominican Republic	2020-05-04	2020-05-05	8235	346	1771	6118	f	f
1586	Dominican Republic	2020-05-05	2020-05-06	8480	354	1905	6221	f	f
1587	Dominican Republic	2020-05-06	2020-05-07	8807	362	1960	6485	f	f
1588	Dominican Republic	2020-05-07	2020-05-08	9095	373	2064	6658	f	f
1589	Dominican Republic	2020-05-08	2020-05-09	9376	380	2286	6710	f	f
1590	Dominican Republic	2020-05-09	2020-05-10	9882	385	2584	6913	f	f
1591	Dominican Republic	2020-05-10	2020-05-11	10347	388	2763	7196	f	f
1592	Dominican Republic	2020-05-11	2020-05-12	10634	393	2870	7371	f	f
1593	Dominican Republic	2020-05-12	2020-05-13	10900	402	3221	7277	f	f
1594	Dominican Republic	2020-05-13	2020-05-14	11196	409	3221	7566	f	f
1595	Dominican Republic	2020-05-14	2020-05-15	11320	422	3351	7547	f	f
1596	Dominican Republic	2020-05-15	2020-05-16	11739	424	3557	7758	f	f
1597	Dominican Republic	2020-05-16	2020-05-17	12110	428	3726	7956	f	f
1598	Dominican Republic	2020-05-17	2020-05-18	12314	428	5847	6039	f	f
1599	Dominican Republic	2020-05-18	2020-05-19	12725	434	6613	5678	f	f
1600	Dominican Republic	2020-05-19	2020-05-20	13223	441	6613	6169	f	f
1601	Dominican Republic	2020-05-20	2020-05-21	13477	446	7142	5889	f	f
1602	Dominican Republic	2020-05-21	2020-05-22	13657	448	7366	5843	f	f
1603	Dominican Republic	2020-05-22	2020-05-23	13989	456	7572	5961	f	f
1604	Dominican Republic	2020-05-23	2020-05-24	14422	458	7854	6110	f	f
1605	Dominican Republic	2020-05-24	2020-05-25	14801	458	8133	6210	f	f
1606	Dominican Republic	2020-05-25	2020-05-26	15073	460	8285	6328	f	f
1607	Dominican Republic	2020-05-26	2020-05-27	15264	468	8534	6262	f	f
1608	Dominican Republic	2020-05-27	2020-05-28	15723	474	8790	6459	f	f
1609	Dominican Republic	2020-05-28	2020-05-29	16068	485	8952	6631	f	f
1610	Dominican Republic	2020-05-29	2020-05-30	16531	488	9266	6777	f	f
1611	Dominican Republic	2020-05-30	2020-05-31	16908	498	9557	6853	f	f
1612	Dominican Republic	2020-05-31	2020-06-01	17285	502	10559	6224	f	f
1613	Ecuador	2020-05-01	2020-05-02	26336	1063	1913	23360	f	f
1614	Ecuador	2020-05-02	2020-05-03	27464	1371	2132	23961	f	f
1615	Ecuador	2020-05-03	2020-05-04	29538	1564	3300	24674	f	f
1616	Ecuador	2020-05-04	2020-05-05	31881	1569	3433	26879	f	f
1617	Ecuador	2020-05-05	2020-05-06	31881	1569	3433	26879	f	f
1618	Ecuador	2020-05-06	2020-05-07	31881	1618	3433	26830	f	f
1619	Ecuador	2020-05-07	2020-05-08	30298	1654	3433	25211	f	f
1620	Ecuador	2020-05-08	2020-05-09	28818	1704	3433	23681	f	f
1621	Ecuador	2020-05-09	2020-05-10	29071	1717	3433	23921	f	f
1622	Ecuador	2020-05-10	2020-05-11	29559	2127	3433	23999	f	f
1623	Ecuador	2020-05-11	2020-05-12	29509	2145	3433	23931	f	f
1624	Ecuador	2020-05-12	2020-05-13	30419	2327	3433	24659	f	f
1625	Ecuador	2020-05-13	2020-05-14	30486	2334	3433	24719	f	f
1626	Ecuador	2020-05-14	2020-05-15	30502	2338	3433	24731	f	f
1627	Ecuador	2020-05-15	2020-05-16	31467	2594	3433	25440	f	f
1628	Ecuador	2020-05-16	2020-05-17	32763	2688	3433	26642	f	f
1629	Ecuador	2020-05-17	2020-05-18	33182	2736	3433	27013	f	f
1630	Ecuador	2020-05-18	2020-05-19	33582	2799	3433	27350	f	f
1631	Ecuador	2020-05-19	2020-05-20	34151	2839	3457	27855	f	f
1632	Ecuador	2020-05-20	2020-05-21	34854	2888	3557	28409	f	f
1633	Ecuador	2020-05-21	2020-05-22	35306	2939	3557	28810	f	f
1634	Ecuador	2020-05-22	2020-05-23	35828	3056	3557	29215	f	f
1635	Ecuador	2020-05-23	2020-05-24	36258	3096	3557	29605	f	f
1636	Ecuador	2020-05-24	2020-05-25	36756	3108	3560	30088	f	f
1637	Ecuador	2020-05-25	2020-05-26	37355	3203	18003	16149	f	f
1638	Ecuador	2020-05-26	2020-05-27	37355	3203	18003	16149	f	f
1639	Ecuador	2020-05-27	2020-05-28	38103	3275	18425	16403	f	f
1640	Ecuador	2020-05-28	2020-05-29	38471	3313	18425	16733	f	f
1641	Ecuador	2020-05-29	2020-05-30	38571	3334	19190	16047	f	f
1642	Ecuador	2020-05-30	2020-05-31	38571	3334	19190	16047	f	f
1643	Ecuador	2020-05-31	2020-06-01	39098	3358	19592	16148	f	f
1644	Egypt	2020-05-01	2020-05-02	5895	406	1460	4029	f	f
1645	Egypt	2020-05-02	2020-05-03	6193	415	1522	4256	f	f
1646	Egypt	2020-05-03	2020-05-04	6465	429	1562	4474	f	f
1647	Egypt	2020-05-04	2020-05-05	6813	436	1632	4745	f	f
1648	Egypt	2020-05-05	2020-05-06	7201	452	1730	5019	f	f
1649	Egypt	2020-05-06	2020-05-07	7588	469	1815	5304	f	f
1650	Egypt	2020-05-07	2020-05-08	7981	482	1887	5612	f	f
1651	Egypt	2020-05-08	2020-05-09	8476	503	1945	6028	f	f
1652	Egypt	2020-05-09	2020-05-10	8964	514	2002	6448	f	f
1653	Egypt	2020-05-10	2020-05-11	9400	525	2075	6800	f	f
1654	Egypt	2020-05-11	2020-05-12	9746	533	2172	7041	f	f
1655	Egypt	2020-05-12	2020-05-13	10093	544	2326	7223	f	f
1656	Egypt	2020-05-13	2020-05-14	10431	556	2486	7389	f	f
1657	Egypt	2020-05-14	2020-05-15	10829	571	2626	7632	f	f
1658	Egypt	2020-05-15	2020-05-16	11228	592	2799	7837	f	f
1659	Egypt	2020-05-16	2020-05-17	11719	612	2950	8157	f	f
1660	Egypt	2020-05-17	2020-05-18	12229	630	3172	8427	f	f
1661	Egypt	2020-05-18	2020-05-19	12764	645	3440	8679	f	f
1662	Egypt	2020-05-19	2020-05-20	13484	659	3742	9083	f	f
1663	Egypt	2020-05-20	2020-05-21	14229	680	3994	9555	f	f
1664	Egypt	2020-05-21	2020-05-22	15003	696	4217	10090	f	f
1665	Egypt	2020-05-22	2020-05-23	15786	707	4374	10705	f	f
1666	Egypt	2020-05-23	2020-05-24	16513	735	4628	11150	f	f
1667	Egypt	2020-05-24	2020-05-25	17265	764	4807	11694	f	f
1668	Egypt	2020-05-25	2020-05-26	17967	783	4900	12284	f	f
1669	Egypt	2020-05-26	2020-05-27	18756	797	5027	12932	f	f
1670	Egypt	2020-05-27	2020-05-28	19666	816	5205	13645	f	f
1671	Egypt	2020-05-28	2020-05-29	20793	845	5359	14589	f	f
1672	Egypt	2020-05-29	2020-05-30	22082	879	5511	15692	f	f
1673	Egypt	2020-05-30	2020-05-31	23449	913	5693	16843	f	f
1674	Egypt	2020-05-31	2020-06-01	24985	959	6037	17989	f	f
1675	El Salvador	2020-05-01	2020-05-02	424	10	124	290	f	f
1676	El Salvador	2020-05-02	2020-05-03	446	11	141	294	f	f
1677	El Salvador	2020-05-03	2020-05-04	490	11	154	325	f	f
1678	El Salvador	2020-05-04	2020-05-05	555	13	180	362	f	f
1679	El Salvador	2020-05-05	2020-05-06	587	14	205	368	f	f
1680	El Salvador	2020-05-06	2020-05-07	633	15	219	399	f	f
1681	El Salvador	2020-05-07	2020-05-08	695	15	252	428	f	f
1682	El Salvador	2020-05-08	2020-05-09	742	16	257	469	f	f
1683	El Salvador	2020-05-09	2020-05-10	784	17	276	491	f	f
1684	El Salvador	2020-05-10	2020-05-11	889	17	293	579	f	f
1685	El Salvador	2020-05-11	2020-05-12	958	18	325	615	f	f
1686	El Salvador	2020-05-12	2020-05-13	998	20	349	629	f	f
1687	El Salvador	2020-05-13	2020-05-14	1037	20	374	643	f	f
1688	El Salvador	2020-05-14	2020-05-15	1112	23	405	684	f	f
1689	El Salvador	2020-05-15	2020-05-16	1210	25	417	768	f	f
1690	El Salvador	2020-05-16	2020-05-17	1265	26	441	798	f	f
1691	El Salvador	2020-05-17	2020-05-18	1338	30	464	844	f	f
1692	El Salvador	2020-05-18	2020-05-19	1413	30	474	909	f	f
1693	El Salvador	2020-05-19	2020-05-20	1498	30	502	966	f	f
1694	El Salvador	2020-05-20	2020-05-21	1571	31	537	1003	f	f
1695	El Salvador	2020-05-21	2020-05-22	1640	33	544	1063	f	f
1696	El Salvador	2020-05-22	2020-05-23	1725	33	570	1122	f	f
1697	El Salvador	2020-05-23	2020-05-24	1819	33	570	1216	f	f
1698	El Salvador	2020-05-24	2020-05-25	1915	35	633	1247	f	f
1699	El Salvador	2020-05-25	2020-05-26	1983	35	772	1176	f	f
1700	El Salvador	2020-05-26	2020-05-27	2042	36	787	1219	f	f
1701	El Salvador	2020-05-27	2020-05-28	2109	39	891	1179	f	f
1702	El Salvador	2020-05-28	2020-05-29	2194	39	1002	1153	f	f
1703	El Salvador	2020-05-29	2020-05-30	2278	42	1015	1221	f	f
1704	El Salvador	2020-05-30	2020-05-31	2395	46	1031	1318	f	f
1705	El Salvador	2020-05-31	2020-06-01	2517	46	1040	1431	f	f
1706	Equatorial Guinea	2020-05-01	2020-05-02	315	1	9	305	f	f
1707	Equatorial Guinea	2020-05-02	2020-05-03	315	1	9	305	f	f
1708	Equatorial Guinea	2020-05-03	2020-05-04	315	1	9	305	f	f
1709	Equatorial Guinea	2020-05-04	2020-05-05	315	3	13	299	f	f
1710	Equatorial Guinea	2020-05-05	2020-05-06	315	3	13	299	f	f
1711	Equatorial Guinea	2020-05-06	2020-05-07	439	4	13	422	f	f
1712	Equatorial Guinea	2020-05-07	2020-05-08	439	4	13	422	f	f
1713	Equatorial Guinea	2020-05-08	2020-05-09	439	4	13	422	f	f
1714	Equatorial Guinea	2020-05-09	2020-05-10	439	4	13	422	f	f
1715	Equatorial Guinea	2020-05-10	2020-05-11	439	4	13	422	f	f
1716	Equatorial Guinea	2020-05-11	2020-05-12	439	4	13	422	f	f
1717	Equatorial Guinea	2020-05-12	2020-05-13	439	4	13	422	f	f
1718	Equatorial Guinea	2020-05-13	2020-05-14	522	6	13	503	f	f
1719	Equatorial Guinea	2020-05-14	2020-05-15	583	7	13	563	f	f
1720	Equatorial Guinea	2020-05-15	2020-05-16	594	7	22	565	f	f
1721	Equatorial Guinea	2020-05-16	2020-05-17	594	7	22	565	f	f
1722	Equatorial Guinea	2020-05-17	2020-05-18	594	7	22	565	f	f
1723	Equatorial Guinea	2020-05-18	2020-05-19	719	7	22	690	f	f
1724	Equatorial Guinea	2020-05-19	2020-05-20	825	7	22	796	f	f
1725	Equatorial Guinea	2020-05-20	2020-05-21	890	7	22	861	f	f
1726	Equatorial Guinea	2020-05-21	2020-05-22	903	10	22	871	f	f
1727	Equatorial Guinea	2020-05-22	2020-05-23	960	11	165	784	f	f
1728	Equatorial Guinea	2020-05-23	2020-05-24	960	11	165	784	f	f
1729	Equatorial Guinea	2020-05-24	2020-05-25	960	11	165	784	f	f
1730	Equatorial Guinea	2020-05-25	2020-05-26	1043	12	165	866	f	f
1731	Equatorial Guinea	2020-05-26	2020-05-27	1043	12	165	866	f	f
1732	Equatorial Guinea	2020-05-27	2020-05-28	1043	12	165	866	f	f
1733	Equatorial Guinea	2020-05-28	2020-05-29	1043	12	165	866	f	f
1734	Equatorial Guinea	2020-05-29	2020-05-30	1306	12	200	1094	f	f
1735	Equatorial Guinea	2020-05-30	2020-05-31	1306	12	200	1094	f	f
1736	Equatorial Guinea	2020-05-31	2020-06-01	1306	12	200	1094	f	f
1737	Eritrea	2020-05-01	2020-05-02	39	0	26	13	f	f
1738	Eritrea	2020-05-02	2020-05-03	39	0	26	13	f	f
1739	Eritrea	2020-05-03	2020-05-04	39	0	26	13	f	f
1740	Eritrea	2020-05-04	2020-05-05	39	0	26	13	f	f
1741	Eritrea	2020-05-05	2020-05-06	39	0	30	9	f	f
1742	Eritrea	2020-05-06	2020-05-07	39	0	30	9	f	f
1743	Eritrea	2020-05-07	2020-05-08	39	0	30	9	f	f
1744	Eritrea	2020-05-08	2020-05-09	39	0	37	2	f	f
1745	Eritrea	2020-05-09	2020-05-10	39	0	37	2	f	f
1746	Eritrea	2020-05-10	2020-05-11	39	0	37	2	f	f
1747	Eritrea	2020-05-11	2020-05-12	39	0	38	1	f	f
1748	Eritrea	2020-05-12	2020-05-13	39	0	38	1	f	f
1749	Eritrea	2020-05-13	2020-05-14	39	0	38	1	f	f
1750	Eritrea	2020-05-14	2020-05-15	39	0	38	1	f	f
1751	Eritrea	2020-05-15	2020-05-16	39	0	39	0	f	f
1752	Eritrea	2020-05-16	2020-05-17	39	0	39	0	f	f
1753	Eritrea	2020-05-17	2020-05-18	39	0	39	0	f	f
1754	Eritrea	2020-05-18	2020-05-19	39	0	39	0	f	f
1755	Eritrea	2020-05-19	2020-05-20	39	0	39	0	f	f
1756	Eritrea	2020-05-20	2020-05-21	39	0	39	0	f	f
1757	Eritrea	2020-05-21	2020-05-22	39	0	39	0	f	f
1758	Eritrea	2020-05-22	2020-05-23	39	0	39	0	f	f
1759	Eritrea	2020-05-23	2020-05-24	39	0	39	0	f	f
1760	Eritrea	2020-05-24	2020-05-25	39	0	39	0	f	f
1761	Eritrea	2020-05-25	2020-05-26	39	0	39	0	f	f
1762	Eritrea	2020-05-26	2020-05-27	39	0	39	0	f	f
1763	Eritrea	2020-05-27	2020-05-28	39	0	39	0	f	f
1764	Eritrea	2020-05-28	2020-05-29	39	0	39	0	f	f
1765	Eritrea	2020-05-29	2020-05-30	39	0	39	0	f	f
1766	Eritrea	2020-05-30	2020-05-31	39	0	39	0	f	f
1767	Eritrea	2020-05-31	2020-06-01	39	0	39	0	f	f
1768	Estonia	2020-05-01	2020-05-02	1694	52	253	1389	f	f
1769	Estonia	2020-05-02	2020-05-03	1699	53	256	1390	f	f
1770	Estonia	2020-05-03	2020-05-04	1700	55	259	1386	f	f
1771	Estonia	2020-05-04	2020-05-05	1703	55	259	1389	f	f
1772	Estonia	2020-05-05	2020-05-06	1711	55	261	1395	f	f
1773	Estonia	2020-05-06	2020-05-07	1713	55	264	1394	f	f
1774	Estonia	2020-05-07	2020-05-08	1720	56	273	1391	f	f
1775	Estonia	2020-05-08	2020-05-09	1725	56	704	965	f	f
1776	Estonia	2020-05-09	2020-05-10	1733	60	747	926	f	f
1777	Estonia	2020-05-10	2020-05-11	1739	60	750	929	f	f
1778	Estonia	2020-05-11	2020-05-12	1741	61	751	929	f	f
1779	Estonia	2020-05-12	2020-05-13	1746	61	777	908	f	f
1780	Estonia	2020-05-13	2020-05-14	1751	61	777	913	f	f
1781	Estonia	2020-05-14	2020-05-15	1758	62	909	787	f	f
1782	Estonia	2020-05-15	2020-05-16	1766	63	923	780	f	f
1783	Estonia	2020-05-16	2020-05-17	1770	63	934	773	f	f
1784	Estonia	2020-05-17	2020-05-18	1774	63	938	773	f	f
1785	Estonia	2020-05-18	2020-05-19	1784	64	938	782	f	f
1786	Estonia	2020-05-19	2020-05-20	1791	64	938	789	f	f
1787	Estonia	2020-05-20	2020-05-21	1794	64	956	774	f	f
1788	Estonia	2020-05-21	2020-05-22	1800	64	1488	248	f	f
1789	Estonia	2020-05-22	2020-05-23	1807	64	1508	235	f	f
1790	Estonia	2020-05-23	2020-05-24	1821	64	1526	231	f	f
1791	Estonia	2020-05-24	2020-05-25	1823	64	1532	227	f	f
1792	Estonia	2020-05-25	2020-05-26	1824	65	1538	221	f	f
1793	Estonia	2020-05-26	2020-05-27	1834	65	1552	217	f	f
1794	Estonia	2020-05-27	2020-05-28	1840	66	1561	213	f	f
1795	Estonia	2020-05-28	2020-05-29	1851	66	1574	211	f	f
1796	Estonia	2020-05-29	2020-05-30	1859	67	1610	182	f	f
1797	Estonia	2020-05-30	2020-05-31	1865	67	1622	176	f	f
1798	Estonia	2020-05-31	2020-06-01	1869	68	1624	177	f	f
1799	Eswatini	2020-05-01	2020-05-02	106	1	12	93	f	f
1800	Eswatini	2020-05-02	2020-05-03	108	1	12	95	f	f
1801	Eswatini	2020-05-03	2020-05-04	112	1	12	99	f	f
1802	Eswatini	2020-05-04	2020-05-05	116	1	12	103	f	f
1803	Eswatini	2020-05-05	2020-05-06	119	1	12	106	f	f
1804	Eswatini	2020-05-06	2020-05-07	123	2	12	109	f	f
1805	Eswatini	2020-05-07	2020-05-08	153	2	12	139	f	f
1806	Eswatini	2020-05-08	2020-05-09	159	2	12	145	f	f
1807	Eswatini	2020-05-09	2020-05-10	163	2	14	147	f	f
1808	Eswatini	2020-05-10	2020-05-11	172	2	27	143	f	f
1809	Eswatini	2020-05-11	2020-05-12	175	2	28	145	f	f
1810	Eswatini	2020-05-12	2020-05-13	184	2	28	154	f	f
1811	Eswatini	2020-05-13	2020-05-14	187	2	48	137	f	f
1812	Eswatini	2020-05-14	2020-05-15	187	2	51	134	f	f
1813	Eswatini	2020-05-15	2020-05-16	190	2	66	122	f	f
1814	Eswatini	2020-05-16	2020-05-17	202	2	72	128	f	f
1815	Eswatini	2020-05-17	2020-05-18	203	2	73	128	f	f
1816	Eswatini	2020-05-18	2020-05-19	205	2	78	125	f	f
1817	Eswatini	2020-05-19	2020-05-20	208	2	87	119	f	f
1818	Eswatini	2020-05-20	2020-05-21	217	2	97	118	f	f
1819	Eswatini	2020-05-21	2020-05-22	220	2	112	106	f	f
1820	Eswatini	2020-05-22	2020-05-23	225	2	119	104	f	f
1821	Eswatini	2020-05-23	2020-05-24	238	2	119	117	f	f
1822	Eswatini	2020-05-24	2020-05-25	250	2	156	92	f	f
1823	Eswatini	2020-05-25	2020-05-26	256	2	158	96	f	f
1824	Eswatini	2020-05-26	2020-05-27	261	2	164	95	f	f
1825	Eswatini	2020-05-27	2020-05-28	272	2	168	102	f	f
1826	Eswatini	2020-05-28	2020-05-29	279	2	168	109	f	f
1827	Eswatini	2020-05-29	2020-05-30	279	2	168	109	f	f
1828	Eswatini	2020-05-30	2020-05-31	283	2	168	113	f	f
1829	Eswatini	2020-05-31	2020-06-01	285	2	189	94	f	f
1830	Ethiopia	2020-05-01	2020-05-02	133	3	66	64	f	f
1831	Ethiopia	2020-05-02	2020-05-03	133	3	69	61	f	f
1832	Ethiopia	2020-05-03	2020-05-04	135	3	75	57	f	f
1833	Ethiopia	2020-05-04	2020-05-05	140	3	75	62	f	f
1834	Ethiopia	2020-05-05	2020-05-06	145	4	91	50	f	f
1835	Ethiopia	2020-05-06	2020-05-07	162	4	93	65	f	f
1836	Ethiopia	2020-05-07	2020-05-08	191	4	93	94	f	f
1837	Ethiopia	2020-05-08	2020-05-09	194	4	95	95	f	f
1838	Ethiopia	2020-05-09	2020-05-10	210	5	97	108	f	f
1839	Ethiopia	2020-05-10	2020-05-11	239	5	99	135	f	f
1840	Ethiopia	2020-05-11	2020-05-12	250	5	105	140	f	f
1841	Ethiopia	2020-05-12	2020-05-13	261	5	106	150	f	f
1842	Ethiopia	2020-05-13	2020-05-14	263	5	108	150	f	f
1843	Ethiopia	2020-05-14	2020-05-15	272	5	108	159	f	f
1844	Ethiopia	2020-05-15	2020-05-16	287	5	112	170	f	f
1845	Ethiopia	2020-05-16	2020-05-17	306	5	113	188	f	f
1846	Ethiopia	2020-05-17	2020-05-18	317	5	113	199	f	f
1847	Ethiopia	2020-05-18	2020-05-19	352	5	116	231	f	f
1848	Ethiopia	2020-05-19	2020-05-20	365	5	120	240	f	f
1849	Ethiopia	2020-05-20	2020-05-21	389	5	122	262	f	f
1850	Ethiopia	2020-05-21	2020-05-22	399	5	123	271	f	f
1851	Ethiopia	2020-05-22	2020-05-23	433	5	128	300	f	f
1852	Ethiopia	2020-05-23	2020-05-24	494	5	151	338	f	f
1853	Ethiopia	2020-05-24	2020-05-25	582	5	152	425	f	f
1854	Ethiopia	2020-05-25	2020-05-26	655	5	159	491	f	f
1855	Ethiopia	2020-05-26	2020-05-27	701	6	167	528	f	f
1856	Ethiopia	2020-05-27	2020-05-28	731	6	181	544	f	f
1857	Ethiopia	2020-05-28	2020-05-29	831	7	191	633	f	f
1858	Ethiopia	2020-05-29	2020-05-30	968	8	197	763	f	f
1859	Ethiopia	2020-05-30	2020-05-31	1063	8	208	847	f	f
1860	Ethiopia	2020-05-31	2020-06-01	1172	11	209	952	f	f
1861	Fiji	2020-05-01	2020-05-02	18	0	12	6	f	f
1862	Fiji	2020-05-02	2020-05-03	18	0	14	4	f	f
1863	Fiji	2020-05-03	2020-05-04	18	0	14	4	f	f
1864	Fiji	2020-05-04	2020-05-05	18	0	14	4	f	f
1865	Fiji	2020-05-05	2020-05-06	18	0	14	4	f	f
1866	Fiji	2020-05-06	2020-05-07	18	0	14	4	f	f
1867	Fiji	2020-05-07	2020-05-08	18	0	14	4	f	f
1868	Fiji	2020-05-08	2020-05-09	18	0	14	4	f	f
1869	Fiji	2020-05-09	2020-05-10	18	0	14	4	f	f
1870	Fiji	2020-05-10	2020-05-11	18	0	14	4	f	f
1871	Fiji	2020-05-11	2020-05-12	18	0	14	4	f	f
1872	Fiji	2020-05-12	2020-05-13	18	0	14	4	f	f
1873	Fiji	2020-05-13	2020-05-14	18	0	14	4	f	f
1874	Fiji	2020-05-14	2020-05-15	18	0	14	4	f	f
1875	Fiji	2020-05-15	2020-05-16	18	0	15	3	f	f
1876	Fiji	2020-05-16	2020-05-17	18	0	15	3	f	f
1877	Fiji	2020-05-17	2020-05-18	18	0	15	3	f	f
1878	Fiji	2020-05-18	2020-05-19	18	0	15	3	f	f
1879	Fiji	2020-05-19	2020-05-20	18	0	15	3	f	f
1880	Fiji	2020-05-20	2020-05-21	18	0	15	3	f	f
1881	Fiji	2020-05-21	2020-05-22	18	0	15	3	f	f
1882	Fiji	2020-05-22	2020-05-23	18	0	15	3	f	f
1883	Fiji	2020-05-23	2020-05-24	18	0	15	3	f	f
1884	Fiji	2020-05-24	2020-05-25	18	0	15	3	f	f
1885	Fiji	2020-05-25	2020-05-26	18	0	15	3	f	f
1886	Fiji	2020-05-26	2020-05-27	18	0	15	3	f	f
1887	Fiji	2020-05-27	2020-05-28	18	0	15	3	f	f
1888	Fiji	2020-05-28	2020-05-29	18	0	15	3	f	f
1889	Fiji	2020-05-29	2020-05-30	18	0	15	3	f	f
1890	Fiji	2020-05-30	2020-05-31	18	0	15	3	f	f
1891	Fiji	2020-05-31	2020-06-01	18	0	15	3	f	f
1892	Finland	2020-05-01	2020-05-02	5051	218	3000	1833	f	f
1893	Finland	2020-05-02	2020-05-03	5176	220	3000	1956	f	f
1894	Finland	2020-05-03	2020-05-04	5254	230	3000	2024	f	f
1895	Finland	2020-05-04	2020-05-05	5327	240	3500	1587	f	f
1896	Finland	2020-05-05	2020-05-06	5412	246	3500	1666	f	f
1897	Finland	2020-05-06	2020-05-07	5573	252	3500	1821	f	f
1898	Finland	2020-05-07	2020-05-08	5673	255	3500	1918	f	f
1899	Finland	2020-05-08	2020-05-09	5738	260	4000	1478	f	f
1900	Finland	2020-05-09	2020-05-10	5880	265	4000	1615	f	f
1901	Finland	2020-05-10	2020-05-11	5962	267	4000	1695	f	f
1902	Finland	2020-05-11	2020-05-12	5984	271	4000	1713	f	f
1903	Finland	2020-05-12	2020-05-13	6003	275	4300	1428	f	f
1904	Finland	2020-05-13	2020-05-14	6054	284	4300	1470	f	f
1905	Finland	2020-05-14	2020-05-15	6145	287	4300	1558	f	f
1906	Finland	2020-05-15	2020-05-16	6228	293	5000	935	f	f
1907	Finland	2020-05-16	2020-05-17	6286	297	5000	989	f	f
1908	Finland	2020-05-17	2020-05-18	6347	298	5000	1049	f	f
1909	Finland	2020-05-18	2020-05-19	6380	300	5000	1080	f	f
1910	Finland	2020-05-19	2020-05-20	6399	301	5000	1098	f	f
1911	Finland	2020-05-20	2020-05-21	6443	304	4800	1339	f	f
1912	Finland	2020-05-21	2020-05-22	6493	306	4800	1387	f	f
1913	Finland	2020-05-22	2020-05-23	6537	306	4800	1431	f	f
1914	Finland	2020-05-23	2020-05-24	6568	306	4800	1462	f	f
1915	Finland	2020-05-24	2020-05-25	6579	307	4800	1472	f	f
1916	Finland	2020-05-25	2020-05-26	6599	308	5100	1191	f	f
1917	Finland	2020-05-26	2020-05-27	6628	312	5100	1216	f	f
1918	Finland	2020-05-27	2020-05-28	6692	313	5100	1279	f	f
1919	Finland	2020-05-28	2020-05-29	6743	313	5500	930	f	f
1920	Finland	2020-05-29	2020-05-30	6776	314	5500	962	f	f
1921	Finland	2020-05-30	2020-05-31	6826	316	5500	1010	f	f
1922	Finland	2020-05-31	2020-06-01	6859	320	5500	1039	f	f
1923	France	2020-05-01	2020-05-02	169387	24597	51124	91553	f	f
1924	France	2020-05-02	2020-05-03	170179	24763	50663	93092	f	f
1925	France	2020-05-03	2020-05-04	170540	24898	50885	93140	f	f
1926	France	2020-05-04	2020-05-05	171102	25204	51476	92903	f	f
1927	France	2020-05-05	2020-05-06	172219	25537	52842	92308	f	f
1928	France	2020-05-06	2020-05-07	176355	25812	54079	94333	f	f
1929	France	2020-05-07	2020-05-08	177096	25991	55191	93737	f	f
1930	France	2020-05-08	2020-05-09	177627	26233	55892	94077	f	f
1931	France	2020-05-09	2020-05-10	178156	26313	56148	94321	f	f
1932	France	2020-05-10	2020-05-11	178405	26383	56327	94384	f	f
1933	France	2020-05-11	2020-05-12	178719	26646	56835	94066	f	f
1934	France	2020-05-12	2020-05-13	179472	26994	57898	93457	f	f
1935	France	2020-05-13	2020-05-14	179993	27079	58786	92321	f	f
1936	France	2020-05-14	2020-05-15	180635	27430	59719	91847	f	f
1937	France	2020-05-15	2020-05-16	181148	27532	60562	91536	f	f
1938	France	2020-05-16	2020-05-17	181563	27630	60562	91536	f	f
1939	France	2020-05-17	2020-05-18	181703	28113	61327	90255	f	f
1940	France	2020-05-18	2020-05-19	182147	28242	61843	89966	f	f
1941	France	2020-05-19	2020-05-20	182648	28025	62678	90230	f	f
1942	France	2020-05-20	2020-05-21	183130	28136	63472	90093	f	f
1943	France	2020-05-21	2020-05-22	183397	28218	63976	89757	f	f
1944	France	2020-05-22	2020-05-23	183814	28292	63986	89811	f	f
1945	France	2020-05-23	2020-05-24	184041	28335	63988	89830	f	f
1946	France	2020-05-24	2020-05-25	184260	28372	64735	89604	f	f
1947	France	2020-05-25	2020-05-26	184585	28461	65317	89290	f	f
1948	France	2020-05-26	2020-05-27	184840	28598	65997	88317	f	f
1949	France	2020-05-27	2020-05-28	185012	28599	66702	87737	f	f
1950	France	2020-05-28	2020-05-29	188355	28666	67309	90390	f	f
1951	France	2020-05-29	2020-05-30	188949	28717	67921	90285	f	f
1952	France	2020-05-30	2020-05-31	190744	28774	68386	91592	f	f
1953	France	2020-05-31	2020-06-01	190975	28805	68473	91731	f	f
1954	Gabon	2020-05-01	2020-05-02	276	3	67	206	f	f
1955	Gabon	2020-05-02	2020-05-03	335	5	85	245	f	f
1956	Gabon	2020-05-03	2020-05-04	335	5	85	245	f	f
1957	Gabon	2020-05-04	2020-05-05	367	6	93	268	f	f
1958	Gabon	2020-05-05	2020-05-06	397	6	93	298	f	f
1959	Gabon	2020-05-06	2020-05-07	397	6	93	298	f	f
1960	Gabon	2020-05-07	2020-05-08	504	8	110	386	f	f
1961	Gabon	2020-05-08	2020-05-09	620	8	110	502	f	f
1962	Gabon	2020-05-09	2020-05-10	661	8	110	543	f	f
1963	Gabon	2020-05-10	2020-05-11	661	8	110	543	f	f
1964	Gabon	2020-05-11	2020-05-12	802	9	127	666	f	f
1965	Gabon	2020-05-12	2020-05-13	863	9	137	717	f	f
1966	Gabon	2020-05-13	2020-05-14	1004	9	152	843	f	f
1967	Gabon	2020-05-14	2020-05-15	1104	10	182	912	f	f
1968	Gabon	2020-05-15	2020-05-16	1209	10	219	980	f	f
1969	Gabon	2020-05-16	2020-05-17	1320	11	244	1065	f	f
1970	Gabon	2020-05-17	2020-05-18	1320	11	244	1065	f	f
1971	Gabon	2020-05-18	2020-05-19	1432	11	301	1120	f	f
1972	Gabon	2020-05-19	2020-05-20	1502	12	318	1172	f	f
1973	Gabon	2020-05-20	2020-05-21	1567	12	365	1190	f	f
1974	Gabon	2020-05-21	2020-05-22	1567	12	365	1190	f	f
1975	Gabon	2020-05-22	2020-05-23	1728	12	402	1314	f	f
1976	Gabon	2020-05-23	2020-05-24	1934	12	459	1463	f	f
1977	Gabon	2020-05-24	2020-05-25	1934	12	459	1463	f	f
1978	Gabon	2020-05-25	2020-05-26	2135	14	562	1559	f	f
1979	Gabon	2020-05-26	2020-05-27	2238	14	593	1631	f	f
1980	Gabon	2020-05-27	2020-05-28	2319	14	631	1674	f	f
1981	Gabon	2020-05-28	2020-05-29	2431	14	668	1749	f	f
1982	Gabon	2020-05-29	2020-05-30	2613	15	709	1889	f	f
1983	Gabon	2020-05-30	2020-05-31	2655	17	722	1916	f	f
1984	Gabon	2020-05-31	2020-06-01	2655	17	722	1916	f	f
1985	Gambia	2020-05-01	2020-05-02	12	1	8	3	f	f
1986	Gambia	2020-05-02	2020-05-03	17	1	9	7	f	f
1987	Gambia	2020-05-03	2020-05-04	17	1	9	7	f	f
1988	Gambia	2020-05-04	2020-05-05	17	1	9	7	f	f
1989	Gambia	2020-05-05	2020-05-06	17	1	9	7	f	f
1990	Gambia	2020-05-06	2020-05-07	17	1	9	7	f	f
1991	Gambia	2020-05-07	2020-05-08	18	1	9	8	f	f
1992	Gambia	2020-05-08	2020-05-09	20	1	9	10	f	f
1993	Gambia	2020-05-09	2020-05-10	20	1	9	10	f	f
1994	Gambia	2020-05-10	2020-05-11	20	1	9	10	f	f
1995	Gambia	2020-05-11	2020-05-12	22	1	10	11	f	f
1996	Gambia	2020-05-12	2020-05-13	22	1	10	11	f	f
1997	Gambia	2020-05-13	2020-05-14	23	1	10	12	f	f
1998	Gambia	2020-05-14	2020-05-15	23	1	10	12	f	f
1999	Gambia	2020-05-15	2020-05-16	23	1	10	12	f	f
2000	Gambia	2020-05-16	2020-05-17	23	1	12	10	f	f
2001	Gambia	2020-05-17	2020-05-18	23	1	12	10	f	f
2002	Gambia	2020-05-18	2020-05-19	24	1	13	10	f	f
2003	Gambia	2020-05-19	2020-05-20	24	1	13	10	f	f
2004	Gambia	2020-05-20	2020-05-21	24	1	13	10	f	f
2005	Gambia	2020-05-21	2020-05-22	24	1	13	10	f	f
2006	Gambia	2020-05-22	2020-05-23	25	1	13	11	f	f
2007	Gambia	2020-05-23	2020-05-24	25	1	13	11	f	f
2008	Gambia	2020-05-24	2020-05-25	25	1	13	11	f	f
2009	Gambia	2020-05-25	2020-05-26	25	1	17	7	f	f
2010	Gambia	2020-05-26	2020-05-27	25	1	18	6	f	f
2011	Gambia	2020-05-27	2020-05-28	25	1	19	5	f	f
2012	Gambia	2020-05-28	2020-05-29	25	1	19	5	f	f
2013	Gambia	2020-05-29	2020-05-30	25	1	20	4	f	f
2014	Gambia	2020-05-30	2020-05-31	25	1	20	4	f	f
2015	Gambia	2020-05-31	2020-06-01	25	1	20	4	f	f
2016	Georgia	2020-05-01	2020-05-02	566	7	207	352	f	f
2017	Georgia	2020-05-02	2020-05-03	582	8	207	367	f	f
2018	Georgia	2020-05-03	2020-05-04	589	9	223	357	f	f
2019	Georgia	2020-05-04	2020-05-05	593	9	223	361	f	f
2020	Georgia	2020-05-05	2020-05-06	604	9	240	355	f	f
2021	Georgia	2020-05-06	2020-05-07	610	9	269	332	f	f
2022	Georgia	2020-05-07	2020-05-08	615	9	275	331	f	f
2023	Georgia	2020-05-08	2020-05-09	623	10	288	325	f	f
2024	Georgia	2020-05-09	2020-05-10	626	10	297	319	f	f
2025	Georgia	2020-05-10	2020-05-11	635	10	309	316	f	f
2026	Georgia	2020-05-11	2020-05-12	638	11	317	310	f	f
2027	Georgia	2020-05-12	2020-05-13	642	11	349	282	f	f
2028	Georgia	2020-05-13	2020-05-14	647	11	372	264	f	f
2029	Georgia	2020-05-14	2020-05-15	667	12	383	272	f	f
2030	Georgia	2020-05-15	2020-05-16	671	12	393	266	f	f
2031	Georgia	2020-05-16	2020-05-17	683	12	419	252	f	f
2032	Georgia	2020-05-17	2020-05-18	695	12	425	258	f	f
2033	Georgia	2020-05-18	2020-05-19	701	12	432	257	f	f
2034	Georgia	2020-05-19	2020-05-20	707	12	456	239	f	f
2035	Georgia	2020-05-20	2020-05-21	713	12	475	226	f	f
2036	Georgia	2020-05-21	2020-05-22	721	12	485	224	f	f
2037	Georgia	2020-05-22	2020-05-23	723	12	495	216	f	f
2038	Georgia	2020-05-23	2020-05-24	728	12	509	207	f	f
2039	Georgia	2020-05-24	2020-05-25	730	12	522	196	f	f
2040	Georgia	2020-05-25	2020-05-26	731	12	526	193	f	f
2041	Georgia	2020-05-26	2020-05-27	732	12	537	183	f	f
2042	Georgia	2020-05-27	2020-05-28	735	12	557	166	f	f
2043	Georgia	2020-05-28	2020-05-29	738	12	573	153	f	f
2044	Georgia	2020-05-29	2020-05-30	746	12	576	158	f	f
2045	Georgia	2020-05-30	2020-05-31	757	12	600	145	f	f
2046	Georgia	2020-05-31	2020-06-01	783	12	605	166	f	f
2047	Germany	2020-05-01	2020-05-02	164077	6736	126900	30441	f	f
2048	Germany	2020-05-02	2020-05-03	164967	6812	129000	29155	f	f
2049	Germany	2020-05-03	2020-05-04	165664	6866	130600	28198	f	f
2050	Germany	2020-05-04	2020-05-05	166152	6993	132700	26459	f	f
2051	Germany	2020-05-05	2020-05-06	167007	6993	135100	24914	f	f
2052	Germany	2020-05-06	2020-05-07	168162	7275	139900	20987	f	f
2053	Germany	2020-05-07	2020-05-08	169430	7392	141700	20338	f	f
2054	Germany	2020-05-08	2020-05-09	170588	7510	141700	21378	f	f
2055	Germany	2020-05-09	2020-05-10	171324	7549	143300	20475	f	f
2056	Germany	2020-05-10	2020-05-11	171879	7569	144400	19910	f	f
2057	Germany	2020-05-11	2020-05-12	172576	7661	145617	19298	f	f
2058	Germany	2020-05-12	2020-05-13	173171	7738	147200	18233	f	f
2059	Germany	2020-05-13	2020-05-14	174098	7861	148700	17537	f	f
2060	Germany	2020-05-14	2020-05-15	174478	7884	150300	16294	f	f
2061	Germany	2020-05-15	2020-05-16	175233	7897	151597	15739	f	f
2062	Germany	2020-05-16	2020-05-17	175752	7938	152600	15214	f	f
2063	Germany	2020-05-17	2020-05-18	176369	7962	154011	14396	f	f
2064	Germany	2020-05-18	2020-05-19	176551	8003	155041	13507	f	f
2065	Germany	2020-05-19	2020-05-20	177778	8081	155681	14016	f	f
2066	Germany	2020-05-20	2020-05-21	178473	8144	156966	13363	f	f
2067	Germany	2020-05-21	2020-05-22	179021	8203	158087	12731	f	f
2068	Germany	2020-05-22	2020-05-23	179710	8228	159064	12418	f	f
2069	Germany	2020-05-23	2020-05-24	179986	8261	159716	12009	f	f
2070	Germany	2020-05-24	2020-05-25	180328	8283	160281	11764	f	f
2071	Germany	2020-05-25	2020-05-26	180600	8309	161199	11092	f	f
2072	Germany	2020-05-26	2020-05-27	181200	8372	161967	10861	f	f
2073	Germany	2020-05-27	2020-05-28	181524	8428	162820	10276	f	f
2074	Germany	2020-05-28	2020-05-29	182196	8470	163360	10366	f	f
2075	Germany	2020-05-29	2020-05-30	182922	8504	164245	10173	f	f
2076	Germany	2020-05-30	2020-05-31	183189	8530	164908	9751	f	f
2077	Germany	2020-05-31	2020-06-01	183410	8540	165352	9518	f	f
2078	Ghana	2020-05-01	2020-05-02	2074	17	212	1845	f	f
2079	Ghana	2020-05-02	2020-05-03	2169	18	229	1922	f	f
2080	Ghana	2020-05-03	2020-05-04	2169	18	229	1922	f	f
2081	Ghana	2020-05-04	2020-05-05	2719	18	294	2407	f	f
2082	Ghana	2020-05-05	2020-05-06	2719	18	294	2407	f	f
2083	Ghana	2020-05-06	2020-05-07	3091	18	294	2779	f	f
2084	Ghana	2020-05-07	2020-05-08	3091	18	303	2770	f	f
2085	Ghana	2020-05-08	2020-05-09	4012	18	323	3671	f	f
2086	Ghana	2020-05-09	2020-05-10	4263	22	378	3863	f	f
2087	Ghana	2020-05-10	2020-05-11	4263	22	378	3863	f	f
2088	Ghana	2020-05-11	2020-05-12	4700	22	494	4184	f	f
2089	Ghana	2020-05-12	2020-05-13	5127	22	494	4611	f	f
2090	Ghana	2020-05-13	2020-05-14	5408	24	514	4870	f	f
2091	Ghana	2020-05-14	2020-05-15	5530	24	674	4832	f	f
2092	Ghana	2020-05-15	2020-05-16	5638	28	1460	4150	f	f
2093	Ghana	2020-05-16	2020-05-17	5735	29	1754	3952	f	f
2094	Ghana	2020-05-17	2020-05-18	5735	29	1754	3952	f	f
2095	Ghana	2020-05-18	2020-05-19	5735	29	1754	3952	f	f
2096	Ghana	2020-05-19	2020-05-20	6096	31	1773	4292	f	f
2097	Ghana	2020-05-20	2020-05-21	6269	31	1898	4340	f	f
2098	Ghana	2020-05-21	2020-05-22	6269	31	1898	4340	f	f
2099	Ghana	2020-05-22	2020-05-23	6486	31	1951	4504	f	f
2100	Ghana	2020-05-23	2020-05-24	6617	31	1978	4608	f	f
2101	Ghana	2020-05-24	2020-05-25	6683	32	1998	4653	f	f
2102	Ghana	2020-05-25	2020-05-26	6808	32	2070	4706	f	f
2103	Ghana	2020-05-26	2020-05-27	7117	34	2317	4766	f	f
2104	Ghana	2020-05-27	2020-05-28	7303	34	2412	4857	f	f
2105	Ghana	2020-05-28	2020-05-29	7303	34	2412	4857	f	f
2106	Ghana	2020-05-29	2020-05-30	7616	34	2421	5161	f	f
2107	Ghana	2020-05-30	2020-05-31	7768	35	2540	5193	f	f
2108	Ghana	2020-05-31	2020-06-01	8070	36	2947	5087	f	f
2109	Greece	2020-05-01	2020-05-02	2612	140	1374	1098	f	f
2110	Greece	2020-05-02	2020-05-03	2620	143	1374	1103	f	f
2111	Greece	2020-05-03	2020-05-04	2626	144	1374	1108	f	f
2112	Greece	2020-05-04	2020-05-05	2632	146	1374	1112	f	f
2113	Greece	2020-05-05	2020-05-06	2642	146	1374	1122	f	f
2114	Greece	2020-05-06	2020-05-07	2663	147	1374	1142	f	f
2115	Greece	2020-05-07	2020-05-08	2678	148	1374	1156	f	f
2116	Greece	2020-05-08	2020-05-09	2691	150	1374	1167	f	f
2117	Greece	2020-05-09	2020-05-10	2710	151	1374	1185	f	f
2118	Greece	2020-05-10	2020-05-11	2716	151	1374	1191	f	f
2119	Greece	2020-05-11	2020-05-12	2726	151	1374	1201	f	f
2120	Greece	2020-05-12	2020-05-13	2744	152	1374	1218	f	f
2121	Greece	2020-05-13	2020-05-14	2760	155	1374	1231	f	f
2122	Greece	2020-05-14	2020-05-15	2770	156	1374	1240	f	f
2123	Greece	2020-05-15	2020-05-16	2810	160	1374	1276	f	f
2124	Greece	2020-05-16	2020-05-17	2819	162	1374	1283	f	f
2125	Greece	2020-05-17	2020-05-18	2834	163	1374	1297	f	f
2126	Greece	2020-05-18	2020-05-19	2836	165	1374	1297	f	f
2127	Greece	2020-05-19	2020-05-20	2840	165	1374	1301	f	f
2128	Greece	2020-05-20	2020-05-21	2850	166	1374	1310	f	f
2129	Greece	2020-05-21	2020-05-22	2853	168	1374	1311	f	f
2130	Greece	2020-05-22	2020-05-23	2874	169	1374	1331	f	f
2131	Greece	2020-05-23	2020-05-24	2876	171	1374	1331	f	f
2132	Greece	2020-05-24	2020-05-25	2878	171	1374	1333	f	f
2133	Greece	2020-05-25	2020-05-26	2882	172	1374	1336	f	f
2134	Greece	2020-05-26	2020-05-27	2892	173	1374	1345	f	f
2135	Greece	2020-05-27	2020-05-28	2903	173	1374	1356	f	f
2136	Greece	2020-05-28	2020-05-29	2906	175	1374	1357	f	f
2137	Greece	2020-05-29	2020-05-30	2909	175	1374	1360	f	f
2138	Greece	2020-05-30	2020-05-31	2915	175	1374	1366	f	f
2139	Greece	2020-05-31	2020-06-01	2917	175	1374	1368	f	f
2140	Grenada	2020-05-01	2020-05-02	20	0	13	7	f	f
2141	Grenada	2020-05-02	2020-05-03	21	0	13	8	f	f
2142	Grenada	2020-05-03	2020-05-04	21	0	13	8	f	f
2143	Grenada	2020-05-04	2020-05-05	21	0	13	8	f	f
2144	Grenada	2020-05-05	2020-05-06	21	0	13	8	f	f
2145	Grenada	2020-05-06	2020-05-07	21	0	13	8	f	f
2146	Grenada	2020-05-07	2020-05-08	21	0	13	8	f	f
2147	Grenada	2020-05-08	2020-05-09	21	0	13	8	f	f
2148	Grenada	2020-05-09	2020-05-10	21	0	13	8	f	f
2149	Grenada	2020-05-10	2020-05-11	21	0	13	8	f	f
2150	Grenada	2020-05-11	2020-05-12	21	0	13	8	f	f
2151	Grenada	2020-05-12	2020-05-13	21	0	13	8	f	f
2152	Grenada	2020-05-13	2020-05-14	21	0	13	8	f	f
2153	Grenada	2020-05-14	2020-05-15	21	0	14	7	f	f
2154	Grenada	2020-05-15	2020-05-16	22	0	14	8	f	f
2155	Grenada	2020-05-16	2020-05-17	22	0	14	8	f	f
2156	Grenada	2020-05-17	2020-05-18	22	0	14	8	f	f
2157	Grenada	2020-05-18	2020-05-19	22	0	14	8	f	f
2158	Grenada	2020-05-19	2020-05-20	22	0	14	8	f	f
2159	Grenada	2020-05-20	2020-05-21	22	0	17	5	f	f
2160	Grenada	2020-05-21	2020-05-22	22	0	17	5	f	f
2161	Grenada	2020-05-22	2020-05-23	22	0	17	5	f	f
2162	Grenada	2020-05-23	2020-05-24	22	0	17	5	f	f
2163	Grenada	2020-05-24	2020-05-25	22	0	17	5	f	f
2164	Grenada	2020-05-25	2020-05-26	23	0	18	5	f	f
2165	Grenada	2020-05-26	2020-05-27	23	0	18	5	f	f
2166	Grenada	2020-05-27	2020-05-28	23	0	18	5	f	f
2167	Grenada	2020-05-28	2020-05-29	23	0	18	5	f	f
2168	Grenada	2020-05-29	2020-05-30	23	0	18	5	f	f
2169	Grenada	2020-05-30	2020-05-31	23	0	18	5	f	f
2170	Grenada	2020-05-31	2020-06-01	23	0	18	5	f	f
2171	Guatemala	2020-05-01	2020-05-02	644	16	72	556	f	f
2172	Guatemala	2020-05-02	2020-05-03	688	17	72	599	f	f
2173	Guatemala	2020-05-03	2020-05-04	703	17	72	614	f	f
2174	Guatemala	2020-05-04	2020-05-05	730	19	79	632	f	f
2175	Guatemala	2020-05-05	2020-05-06	763	19	79	665	f	f
2176	Guatemala	2020-05-06	2020-05-07	798	21	86	691	f	f
2177	Guatemala	2020-05-07	2020-05-08	832	23	90	719	f	f
2178	Guatemala	2020-05-08	2020-05-09	900	24	101	775	f	f
2179	Guatemala	2020-05-09	2020-05-10	967	24	104	839	f	f
2180	Guatemala	2020-05-10	2020-05-11	1052	26	110	916	f	f
2181	Guatemala	2020-05-11	2020-05-12	1114	26	111	977	f	f
2182	Guatemala	2020-05-12	2020-05-13	1199	27	120	1052	f	f
2183	Guatemala	2020-05-13	2020-05-14	1342	29	121	1192	f	f
2184	Guatemala	2020-05-14	2020-05-15	1518	29	129	1360	f	f
2185	Guatemala	2020-05-15	2020-05-16	1643	30	135	1478	f	f
2186	Guatemala	2020-05-16	2020-05-17	1763	33	138	1592	f	f
2187	Guatemala	2020-05-17	2020-05-18	1763	33	138	1592	f	f
2188	Guatemala	2020-05-18	2020-05-19	1912	35	138	1739	f	f
2189	Guatemala	2020-05-19	2020-05-20	2133	43	155	1935	f	f
2190	Guatemala	2020-05-20	2020-05-21	2265	45	159	2061	f	f
2191	Guatemala	2020-05-21	2020-05-22	2512	48	222	2242	f	f
2192	Guatemala	2020-05-22	2020-05-23	2743	51	222	2470	f	f
2193	Guatemala	2020-05-23	2020-05-24	3054	55	244	2755	f	f
2194	Guatemala	2020-05-24	2020-05-25	3424	58	258	3108	f	f
2195	Guatemala	2020-05-25	2020-05-26	3760	59	274	3427	f	f
2196	Guatemala	2020-05-26	2020-05-27	3954	63	289	3602	f	f
2197	Guatemala	2020-05-27	2020-05-28	4145	68	493	3584	f	f
2198	Guatemala	2020-05-28	2020-05-29	4348	80	565	3703	f	f
2199	Guatemala	2020-05-29	2020-05-30	4607	90	648	3869	f	f
2200	Guatemala	2020-05-30	2020-05-31	4739	102	706	3931	f	f
2201	Guatemala	2020-05-31	2020-06-01	5087	108	735	4244	f	f
2202	Guinea	2020-05-01	2020-05-02	1537	7	342	1188	f	f
2203	Guinea	2020-05-02	2020-05-03	1586	7	405	1174	f	f
2204	Guinea	2020-05-03	2020-05-04	1586	7	405	1174	f	f
2205	Guinea	2020-05-04	2020-05-05	1710	9	450	1251	f	f
2206	Guinea	2020-05-05	2020-05-06	1811	10	498	1303	f	f
2207	Guinea	2020-05-06	2020-05-07	1856	11	597	1248	f	f
2208	Guinea	2020-05-07	2020-05-08	1927	11	629	1287	f	f
2209	Guinea	2020-05-08	2020-05-09	2009	11	663	1335	f	f
2210	Guinea	2020-05-09	2020-05-10	2042	11	698	1333	f	f
2211	Guinea	2020-05-10	2020-05-11	2146	11	714	1421	f	f
2212	Guinea	2020-05-11	2020-05-12	2146	11	714	1421	f	f
2213	Guinea	2020-05-12	2020-05-13	2298	11	816	1471	f	f
2214	Guinea	2020-05-13	2020-05-14	2374	14	856	1504	f	f
2215	Guinea	2020-05-14	2020-05-15	2473	15	895	1563	f	f
2216	Guinea	2020-05-15	2020-05-16	2473	15	895	1563	f	f
2217	Guinea	2020-05-16	2020-05-17	2658	16	1133	1509	f	f
2218	Guinea	2020-05-17	2020-05-18	2658	16	1133	1509	f	f
2219	Guinea	2020-05-18	2020-05-19	2796	16	1263	1517	f	f
2220	Guinea	2020-05-19	2020-05-20	2863	18	1525	1320	f	f
2221	Guinea	2020-05-20	2020-05-21	2863	18	1525	1320	f	f
2222	Guinea	2020-05-21	2020-05-22	3067	18	1575	1474	f	f
2223	Guinea	2020-05-22	2020-05-23	3067	19	1575	1473	f	f
2224	Guinea	2020-05-23	2020-05-24	3176	20	1631	1525	f	f
2225	Guinea	2020-05-24	2020-05-25	3275	20	1673	1582	f	f
2226	Guinea	2020-05-25	2020-05-26	3275	20	1673	1582	f	f
2227	Guinea	2020-05-26	2020-05-27	3275	20	1673	1582	f	f
2228	Guinea	2020-05-27	2020-05-28	3275	20	1673	1582	f	f
2229	Guinea	2020-05-28	2020-05-29	3553	22	1950	1581	f	f
2230	Guinea	2020-05-29	2020-05-30	3656	22	2000	1634	f	f
2231	Guinea	2020-05-30	2020-05-31	3706	23	2030	1653	f	f
2232	Guinea	2020-05-31	2020-06-01	3706	23	2030	1653	f	f
2233	Guinea-Bissau	2020-05-01	2020-05-02	257	1	19	237	f	f
2234	Guinea-Bissau	2020-05-02	2020-05-03	257	1	19	237	f	f
2235	Guinea-Bissau	2020-05-03	2020-05-04	257	1	19	237	f	f
2236	Guinea-Bissau	2020-05-04	2020-05-05	413	1	19	393	f	f
2237	Guinea-Bissau	2020-05-05	2020-05-06	413	1	19	393	f	f
2238	Guinea-Bissau	2020-05-06	2020-05-07	475	2	24	449	f	f
2239	Guinea-Bissau	2020-05-07	2020-05-08	564	2	25	537	f	f
2240	Guinea-Bissau	2020-05-08	2020-05-09	594	2	25	567	f	f
2241	Guinea-Bissau	2020-05-09	2020-05-10	641	3	25	613	f	f
2242	Guinea-Bissau	2020-05-10	2020-05-11	726	3	26	697	f	f
2243	Guinea-Bissau	2020-05-11	2020-05-12	761	3	26	732	f	f
2244	Guinea-Bissau	2020-05-12	2020-05-13	820	3	26	791	f	f
2245	Guinea-Bissau	2020-05-13	2020-05-14	836	3	26	807	f	f
2246	Guinea-Bissau	2020-05-14	2020-05-15	913	3	26	884	f	f
2247	Guinea-Bissau	2020-05-15	2020-05-16	913	3	26	884	f	f
2248	Guinea-Bissau	2020-05-16	2020-05-17	969	4	26	939	f	f
2249	Guinea-Bissau	2020-05-17	2020-05-18	990	4	26	960	f	f
2250	Guinea-Bissau	2020-05-18	2020-05-19	1032	4	38	990	f	f
2251	Guinea-Bissau	2020-05-19	2020-05-20	1038	6	42	990	f	f
2252	Guinea-Bissau	2020-05-20	2020-05-21	1089	6	42	1041	f	f
2253	Guinea-Bissau	2020-05-21	2020-05-22	1109	6	42	1061	f	f
2601	Ireland	2020-05-28	2020-05-29	24841	1639	22089	1113	f	f
2254	Guinea-Bissau	2020-05-22	2020-05-23	1114	6	42	1066	f	f
2255	Guinea-Bissau	2020-05-23	2020-05-24	1114	6	42	1066	f	f
2256	Guinea-Bissau	2020-05-24	2020-05-25	1114	6	42	1066	f	f
2257	Guinea-Bissau	2020-05-25	2020-05-26	1178	7	42	1129	f	f
2258	Guinea-Bissau	2020-05-26	2020-05-27	1178	7	42	1129	f	f
2259	Guinea-Bissau	2020-05-27	2020-05-28	1195	7	42	1146	f	f
2260	Guinea-Bissau	2020-05-28	2020-05-29	1195	8	42	1145	f	f
2261	Guinea-Bissau	2020-05-29	2020-05-30	1256	8	42	1206	f	f
2262	Guinea-Bissau	2020-05-30	2020-05-31	1256	8	42	1206	f	f
2263	Guinea-Bissau	2020-05-31	2020-06-01	1256	8	42	1206	f	f
2264	Guyana	2020-05-01	2020-05-02	82	9	22	51	f	f
2265	Guyana	2020-05-02	2020-05-03	82	9	22	51	f	f
2266	Guyana	2020-05-03	2020-05-04	82	9	22	51	f	f
2267	Guyana	2020-05-04	2020-05-05	92	9	27	56	f	f
2268	Guyana	2020-05-05	2020-05-06	93	10	27	56	f	f
2269	Guyana	2020-05-06	2020-05-07	93	10	27	56	f	f
2270	Guyana	2020-05-07	2020-05-08	93	10	27	56	f	f
2271	Guyana	2020-05-08	2020-05-09	94	10	35	49	f	f
2272	Guyana	2020-05-09	2020-05-10	94	10	35	49	f	f
2273	Guyana	2020-05-10	2020-05-11	104	10	35	59	f	f
2274	Guyana	2020-05-11	2020-05-12	109	10	36	63	f	f
2275	Guyana	2020-05-12	2020-05-13	113	10	36	67	f	f
2276	Guyana	2020-05-13	2020-05-14	113	10	41	62	f	f
2277	Guyana	2020-05-14	2020-05-15	113	10	42	61	f	f
2278	Guyana	2020-05-15	2020-05-16	116	10	43	63	f	f
2279	Guyana	2020-05-16	2020-05-17	117	10	43	64	f	f
2280	Guyana	2020-05-17	2020-05-18	117	10	43	64	f	f
2281	Guyana	2020-05-18	2020-05-19	124	10	44	70	f	f
2282	Guyana	2020-05-19	2020-05-20	125	10	46	69	f	f
2283	Guyana	2020-05-20	2020-05-21	125	10	47	68	f	f
2284	Guyana	2020-05-21	2020-05-22	127	10	57	60	f	f
2285	Guyana	2020-05-22	2020-05-23	127	10	57	60	f	f
2286	Guyana	2020-05-23	2020-05-24	127	10	58	59	f	f
2287	Guyana	2020-05-24	2020-05-25	135	10	62	63	f	f
2288	Guyana	2020-05-25	2020-05-26	137	11	62	64	f	f
2289	Guyana	2020-05-26	2020-05-27	139	11	62	66	f	f
2290	Guyana	2020-05-27	2020-05-28	139	11	67	61	f	f
2291	Guyana	2020-05-28	2020-05-29	150	11	67	72	f	f
2292	Guyana	2020-05-29	2020-05-30	150	11	67	72	f	f
2293	Guyana	2020-05-30	2020-05-31	152	12	67	73	f	f
2294	Guyana	2020-05-31	2020-06-01	153	12	70	71	f	f
2295	Haiti	2020-05-01	2020-05-02	76	7	10	67	f	f
2296	Haiti	2020-05-02	2020-05-03	81	8	10	67	f	f
2297	Haiti	2020-05-03	2020-05-04	85	8	10	69	f	f
2298	Haiti	2020-05-04	2020-05-05	85	8	10	79	f	f
2299	Haiti	2020-05-05	2020-05-06	88	9	10	79	f	f
2300	Haiti	2020-05-06	2020-05-07	100	11	10	79	f	f
2301	Haiti	2020-05-07	2020-05-08	101	12	16	101	f	f
2302	Haiti	2020-05-08	2020-05-09	108	12	17	117	f	f
2303	Haiti	2020-05-09	2020-05-10	129	12	17	122	f	f
2304	Haiti	2020-05-10	2020-05-11	146	12	17	150	f	f
2305	Haiti	2020-05-11	2020-05-12	151	12	17	176	f	f
2306	Haiti	2020-05-12	2020-05-13	182	15	17	184	f	f
2307	Haiti	2020-05-13	2020-05-14	209	16	17	199	f	f
2308	Haiti	2020-05-14	2020-05-15	219	18	18	235	f	f
2309	Haiti	2020-05-15	2020-05-16	234	18	29	261	f	f
2310	Haiti	2020-05-16	2020-05-17	273	20	29	309	f	f
2311	Haiti	2020-05-17	2020-05-18	310	20	21	415	f	f
2312	Haiti	2020-05-18	2020-05-19	358	20	21	491	f	f
2313	Haiti	2020-05-19	2020-05-20	456	20	21	491	f	f
2314	Haiti	2020-05-20	2020-05-21	533	21	21	553	f	f
2315	Haiti	2020-05-21	2020-05-22	596	22	21	688	f	f
2316	Haiti	2020-05-22	2020-05-23	663	22	22	765	f	f
2317	Haiti	2020-05-23	2020-05-24	734	25	22	817	f	f
2318	Haiti	2020-05-24	2020-05-25	812	25	22	817	f	f
2319	Haiti	2020-05-25	2020-05-26	865	26	22	909	f	f
2320	Haiti	2020-05-26	2020-05-27	958	27	22	1119	f	f
2321	Haiti	2020-05-27	2020-05-28	1063	31	22	1264	f	f
2322	Haiti	2020-05-28	2020-05-29	1174	33	22	1264	f	f
2323	Haiti	2020-05-29	2020-05-30	1320	34	22	1527	f	f
2324	Haiti	2020-05-30	2020-05-31	1443	35	24	1800	f	f
2325	Haiti	2020-05-31	2020-06-01	1584	35	24	2056	f	f
2326	Holy See	2020-05-01	2020-05-02	11	0	2	9	f	f
2327	Holy See	2020-05-02	2020-05-03	11	0	2	9	f	f
2328	Holy See	2020-05-03	2020-05-04	11	0	2	9	f	f
2329	Holy See	2020-05-04	2020-05-05	11	0	2	9	f	f
2330	Holy See	2020-05-05	2020-05-06	11	0	2	9	f	f
2331	Holy See	2020-05-06	2020-05-07	12	0	2	10	f	f
2332	Holy See	2020-05-07	2020-05-08	12	0	2	10	f	f
2333	Holy See	2020-05-08	2020-05-09	12	0	2	10	f	f
2334	Holy See	2020-05-09	2020-05-10	12	0	2	10	f	f
2335	Holy See	2020-05-10	2020-05-11	12	0	2	10	f	f
2336	Holy See	2020-05-11	2020-05-12	12	0	2	10	f	f
2337	Holy See	2020-05-12	2020-05-13	12	0	2	10	f	f
2338	Holy See	2020-05-13	2020-05-14	12	0	2	10	f	f
2339	Holy See	2020-05-14	2020-05-15	12	0	2	10	f	f
2340	Holy See	2020-05-15	2020-05-16	12	0	2	10	f	f
2341	Holy See	2020-05-16	2020-05-17	12	0	2	10	f	f
2342	Holy See	2020-05-17	2020-05-18	12	0	2	10	f	f
2343	Holy See	2020-05-18	2020-05-19	12	0	2	10	f	f
2344	Holy See	2020-05-19	2020-05-20	12	0	2	10	f	f
2345	Holy See	2020-05-20	2020-05-21	12	0	2	10	f	f
2346	Holy See	2020-05-21	2020-05-22	12	0	2	10	f	f
2347	Holy See	2020-05-22	2020-05-23	12	0	2	10	f	f
2348	Holy See	2020-05-23	2020-05-24	12	0	2	10	f	f
2349	Holy See	2020-05-24	2020-05-25	12	0	2	10	f	f
2350	Holy See	2020-05-25	2020-05-26	12	0	2	10	f	f
2351	Holy See	2020-05-26	2020-05-27	12	0	2	10	f	f
2352	Holy See	2020-05-27	2020-05-28	12	0	2	10	f	f
2353	Holy See	2020-05-28	2020-05-29	12	0	2	10	f	f
2354	Holy See	2020-05-29	2020-05-30	12	0	2	10	f	f
2355	Holy See	2020-05-30	2020-05-31	12	0	2	10	f	f
2356	Holy See	2020-05-31	2020-06-01	12	0	2	10	f	f
2357	Honduras	2020-05-01	2020-05-02	804	75	112	617	f	f
2358	Honduras	2020-05-02	2020-05-03	1010	76	116	818	f	f
2359	Honduras	2020-05-03	2020-05-04	1055	82	118	855	f	f
2360	Honduras	2020-05-04	2020-05-05	1178	83	122	973	f	f
2361	Honduras	2020-05-05	2020-05-06	1270	93	122	1055	f	f
2362	Honduras	2020-05-06	2020-05-07	1461	99	132	1230	f	f
2363	Honduras	2020-05-07	2020-05-08	1685	105	154	1426	f	f
2364	Honduras	2020-05-08	2020-05-09	1771	107	192	1472	f	f
2365	Honduras	2020-05-09	2020-05-10	1830	108	195	1527	f	f
2366	Honduras	2020-05-10	2020-05-11	1972	108	203	1661	f	f
2367	Honduras	2020-05-11	2020-05-12	2100	116	206	1778	f	f
2368	Honduras	2020-05-12	2020-05-13	2080	121	211	1748	f	f
2369	Honduras	2020-05-13	2020-05-14	2255	123	237	1895	f	f
2370	Honduras	2020-05-14	2020-05-15	2318	133	253	1932	f	f
2371	Honduras	2020-05-15	2020-05-16	2460	134	264	2062	f	f
2372	Honduras	2020-05-16	2020-05-17	2565	138	278	2149	f	f
2373	Honduras	2020-05-17	2020-05-18	2646	142	319	2185	f	f
2374	Honduras	2020-05-18	2020-05-19	2798	146	340	2312	f	f
2375	Honduras	2020-05-19	2020-05-20	2955	147	349	2459	f	f
2376	Honduras	2020-05-20	2020-05-21	2955	147	349	2459	f	f
2377	Honduras	2020-05-21	2020-05-22	3204	156	397	2651	f	f
2378	Honduras	2020-05-22	2020-05-23	3477	167	439	2871	f	f
2379	Honduras	2020-05-23	2020-05-24	3477	167	439	2871	f	f
2380	Honduras	2020-05-24	2020-05-25	3950	180	468	3302	f	f
2381	Honduras	2020-05-25	2020-05-26	4189	182	473	3534	f	f
2382	Honduras	2020-05-26	2020-05-27	4401	188	493	3720	f	f
2383	Honduras	2020-05-27	2020-05-28	4640	194	506	3940	f	f
2384	Honduras	2020-05-28	2020-05-29	4752	196	519	4037	f	f
2385	Honduras	2020-05-29	2020-05-30	4752	196	519	4037	f	f
2386	Honduras	2020-05-30	2020-05-31	5094	201	536	4357	f	f
2387	Honduras	2020-05-31	2020-06-01	5202	212	537	4453	f	f
2388	Hungary	2020-05-01	2020-05-02	2863	323	609	1931	f	f
2389	Hungary	2020-05-02	2020-05-03	2942	335	625	1982	f	f
2390	Hungary	2020-05-03	2020-05-04	2998	340	629	2029	f	f
2391	Hungary	2020-05-04	2020-05-05	3035	351	630	2054	f	f
2392	Hungary	2020-05-05	2020-05-06	3065	363	709	1993	f	f
2393	Hungary	2020-05-06	2020-05-07	3111	373	759	1979	f	f
2394	Hungary	2020-05-07	2020-05-08	3150	383	801	1966	f	f
2395	Hungary	2020-05-08	2020-05-09	3178	392	865	1921	f	f
2396	Hungary	2020-05-09	2020-05-10	3213	405	904	1904	f	f
2397	Hungary	2020-05-10	2020-05-11	3263	413	933	1917	f	f
2398	Hungary	2020-05-11	2020-05-12	3284	421	958	1905	f	f
2399	Hungary	2020-05-12	2020-05-13	3313	425	1007	1881	f	f
2400	Hungary	2020-05-13	2020-05-14	3341	430	1102	1809	f	f
2401	Hungary	2020-05-14	2020-05-15	3380	436	1169	1775	f	f
2402	Hungary	2020-05-15	2020-05-16	3417	442	1287	1688	f	f
2403	Hungary	2020-05-16	2020-05-17	3473	448	1371	1654	f	f
2404	Hungary	2020-05-17	2020-05-18	3509	451	1396	1662	f	f
2405	Hungary	2020-05-18	2020-05-19	3535	462	1400	1673	f	f
2406	Hungary	2020-05-19	2020-05-20	3556	467	1412	1677	f	f
2407	Hungary	2020-05-20	2020-05-21	3598	470	1454	1674	f	f
2408	Hungary	2020-05-21	2020-05-22	3641	473	1509	1659	f	f
2409	Hungary	2020-05-22	2020-05-23	3678	476	1587	1615	f	f
2410	Hungary	2020-05-23	2020-05-24	3713	482	1655	1576	f	f
2411	Hungary	2020-05-24	2020-05-25	3741	486	1690	1565	f	f
2412	Hungary	2020-05-25	2020-05-26	3756	491	1711	1554	f	f
2413	Hungary	2020-05-26	2020-05-27	3771	499	1836	1436	f	f
2414	Hungary	2020-05-27	2020-05-28	3793	505	1856	1432	f	f
2415	Hungary	2020-05-28	2020-05-29	3816	509	1996	1311	f	f
2416	Hungary	2020-05-29	2020-05-30	3841	517	2024	1300	f	f
2417	Hungary	2020-05-30	2020-05-31	3867	524	2142	1201	f	f
2418	Hungary	2020-05-31	2020-06-01	3876	526	2147	1203	f	f
2419	Iceland	2020-05-01	2020-05-02	1798	10	1689	99	f	f
2420	Iceland	2020-05-02	2020-05-03	1798	10	1706	82	f	f
2421	Iceland	2020-05-03	2020-05-04	1799	10	1717	72	f	f
2422	Iceland	2020-05-04	2020-05-05	1799	10	1723	66	f	f
2423	Iceland	2020-05-05	2020-05-06	1799	10	1733	56	f	f
2424	Iceland	2020-05-06	2020-05-07	1799	10	1750	39	f	f
2425	Iceland	2020-05-07	2020-05-08	1801	10	1755	36	f	f
2426	Iceland	2020-05-08	2020-05-09	1801	10	1765	26	f	f
2427	Iceland	2020-05-09	2020-05-10	1801	10	1773	18	f	f
2428	Iceland	2020-05-10	2020-05-11	1801	10	1773	18	f	f
2429	Iceland	2020-05-11	2020-05-12	1801	10	1773	18	f	f
2430	Iceland	2020-05-12	2020-05-13	1801	10	1776	15	f	f
2431	Iceland	2020-05-13	2020-05-14	1802	10	1780	12	f	f
2432	Iceland	2020-05-14	2020-05-15	1802	10	1780	12	f	f
2433	Iceland	2020-05-15	2020-05-16	1802	10	1782	10	f	f
2434	Iceland	2020-05-16	2020-05-17	1802	10	1786	6	f	f
2435	Iceland	2020-05-17	2020-05-18	1802	10	1786	6	f	f
2436	Iceland	2020-05-18	2020-05-19	1802	10	1786	6	f	f
2437	Iceland	2020-05-19	2020-05-20	1802	10	1789	3	f	f
2438	Iceland	2020-05-20	2020-05-21	1803	10	1789	4	f	f
2439	Iceland	2020-05-21	2020-05-22	1803	10	1790	3	f	f
2440	Iceland	2020-05-22	2020-05-23	1803	10	1791	2	f	f
2441	Iceland	2020-05-23	2020-05-24	1804	10	1791	3	f	f
2442	Iceland	2020-05-24	2020-05-25	1804	10	1791	3	f	f
2443	Iceland	2020-05-25	2020-05-26	1804	10	1791	3	f	f
2444	Iceland	2020-05-26	2020-05-27	1804	10	1792	2	f	f
2445	Iceland	2020-05-27	2020-05-28	1805	10	1792	3	f	f
2446	Iceland	2020-05-28	2020-05-29	1805	10	1792	3	f	f
2447	Iceland	2020-05-29	2020-05-30	1805	10	1794	1	f	f
2448	Iceland	2020-05-30	2020-05-31	1806	10	1794	2	f	f
2449	Iceland	2020-05-31	2020-06-01	1806	10	1794	2	f	f
2450	India	2020-05-01	2020-05-02	37257	1223	10007	26027	f	f
2451	India	2020-05-02	2020-05-03	39699	1323	10819	27557	f	f
2452	India	2020-05-03	2020-05-04	42505	1391	11775	29339	f	f
2453	India	2020-05-04	2020-05-05	46437	1566	12847	32024	f	f
2454	India	2020-05-05	2020-05-06	49400	1693	14142	33565	f	f
2455	India	2020-05-06	2020-05-07	52987	1785	15331	35871	f	f
2456	India	2020-05-07	2020-05-08	56351	1889	16776	37686	f	f
2457	India	2020-05-08	2020-05-09	59695	1985	17887	39823	f	f
2458	India	2020-05-09	2020-05-10	62808	2101	19301	41406	f	f
2459	India	2020-05-10	2020-05-11	67161	2212	20969	43980	f	f
2460	India	2020-05-11	2020-05-12	70768	2294	22549	45925	f	f
2461	India	2020-05-12	2020-05-13	74292	2415	24420	47457	f	f
2462	India	2020-05-13	2020-05-14	78055	2551	26400	49104	f	f
2463	India	2020-05-14	2020-05-15	81997	2649	27969	51379	f	f
2464	India	2020-05-15	2020-05-16	85784	2753	30258	52773	f	f
2465	India	2020-05-16	2020-05-17	90648	2871	34224	53553	f	f
2466	India	2020-05-17	2020-05-18	95698	3025	36795	55878	f	f
2467	India	2020-05-18	2020-05-19	100328	3156	39233	57939	f	f
2468	India	2020-05-19	2020-05-20	106475	3302	42309	60864	f	f
2469	India	2020-05-20	2020-05-21	112028	3434	45422	63172	f	f
2470	India	2020-05-21	2020-05-22	118226	3584	48553	66089	f	f
2471	India	2020-05-22	2020-05-23	124794	3726	51824	69244	f	f
2472	India	2020-05-23	2020-05-24	131423	3868	54385	73170	f	f
2473	India	2020-05-24	2020-05-25	138536	4024	57692	76820	f	f
2474	India	2020-05-25	2020-05-26	144950	4172	60706	80072	f	f
2475	India	2020-05-26	2020-05-27	150793	4344	64277	82172	f	f
2476	India	2020-05-27	2020-05-28	158086	4534	67749	85803	f	f
2477	India	2020-05-28	2020-05-29	165386	4711	70920	89755	f	f
2478	India	2020-05-29	2020-05-30	173491	4980	82627	85884	f	f
2479	India	2020-05-30	2020-05-31	181827	5185	86936	89706	f	f
2480	India	2020-05-31	2020-06-01	190609	5408	91852	93349	f	f
2481	Indonesia	2020-05-01	2020-05-02	10551	800	1591	8160	f	f
2482	Indonesia	2020-05-02	2020-05-03	10843	831	1665	8347	f	f
2483	Indonesia	2020-05-03	2020-05-04	11192	845	1876	8471	f	f
2484	Indonesia	2020-05-04	2020-05-05	11587	864	1954	8769	f	f
2485	Indonesia	2020-05-05	2020-05-06	12071	872	2197	9002	f	f
2486	Indonesia	2020-05-06	2020-05-07	12438	895	2317	9226	f	f
2487	Indonesia	2020-05-07	2020-05-08	12776	930	2381	9465	f	f
2488	Indonesia	2020-05-08	2020-05-09	13112	943	2494	9675	f	f
2489	Indonesia	2020-05-09	2020-05-10	13645	959	2607	10079	f	f
2490	Indonesia	2020-05-10	2020-05-11	14032	973	2698	10361	f	f
2491	Indonesia	2020-05-11	2020-05-12	14265	991	2881	10393	f	f
2492	Indonesia	2020-05-12	2020-05-13	14749	1007	3063	10679	f	f
2493	Indonesia	2020-05-13	2020-05-14	15438	1028	3287	11123	f	f
2494	Indonesia	2020-05-14	2020-05-15	16006	1043	3518	11445	f	f
2495	Indonesia	2020-05-15	2020-05-16	16496	1076	3803	11617	f	f
2496	Indonesia	2020-05-16	2020-05-17	17025	1089	3911	12025	f	f
2497	Indonesia	2020-05-17	2020-05-18	17514	1148	4129	12237	f	f
2498	Indonesia	2020-05-18	2020-05-19	18010	1191	4324	12495	f	f
2499	Indonesia	2020-05-19	2020-05-20	18496	1221	4467	12808	f	f
2500	Indonesia	2020-05-20	2020-05-21	19189	1242	4575	13372	f	f
2501	Indonesia	2020-05-21	2020-05-22	20162	1278	4838	14046	f	f
2502	Indonesia	2020-05-22	2020-05-23	20796	1326	5057	14413	f	f
2503	Indonesia	2020-05-23	2020-05-24	21745	1351	5249	15145	f	f
2504	Indonesia	2020-05-24	2020-05-25	22271	1372	5402	15497	f	f
2505	Indonesia	2020-05-25	2020-05-26	22750	1391	5642	15717	f	f
2506	Indonesia	2020-05-26	2020-05-27	23165	1418	5877	15870	f	f
2507	Indonesia	2020-05-27	2020-05-28	23851	1473	6057	16321	f	f
2508	Indonesia	2020-05-28	2020-05-29	24538	1496	6240	16802	f	f
2509	Indonesia	2020-05-29	2020-05-30	25216	1520	6492	17204	f	f
2510	Indonesia	2020-05-30	2020-05-31	25773	1573	7015	17185	f	f
2511	Indonesia	2020-05-31	2020-06-01	26473	1613	7308	17552	f	f
2512	Iran	2020-05-01	2020-05-02	95646	6091	76318	13237	f	f
2513	Iran	2020-05-02	2020-05-03	96448	6156	77350	12942	f	f
2514	Iran	2020-05-03	2020-05-04	97424	6203	78422	12799	f	f
2515	Iran	2020-05-04	2020-05-05	98647	6277	79379	12991	f	f
2516	Iran	2020-05-05	2020-05-06	99970	6340	80475	13155	f	f
2517	Iran	2020-05-06	2020-05-07	101650	6418	81587	13645	f	f
2518	Iran	2020-05-07	2020-05-08	103135	6486	82744	13905	f	f
2519	Iran	2020-05-08	2020-05-09	104691	6541	83837	14313	f	f
2520	Iran	2020-05-09	2020-05-10	106220	6589	85064	14567	f	f
2521	Iran	2020-05-10	2020-05-11	107603	6640	86143	14820	f	f
2522	Iran	2020-05-11	2020-05-12	109286	6685	87422	15179	f	f
2523	Iran	2020-05-12	2020-05-13	110767	6733	88357	15677	f	f
2524	Iran	2020-05-13	2020-05-14	112725	6783	89428	16514	f	f
2525	Iran	2020-05-14	2020-05-15	114533	6854	90539	17140	f	f
2526	Iran	2020-05-15	2020-05-16	116635	6902	91836	17897	f	f
2527	Iran	2020-05-16	2020-05-17	118392	6937	93147	18308	f	f
2528	Iran	2020-05-17	2020-05-18	120198	6988	94464	18746	f	f
2529	Iran	2020-05-18	2020-05-19	122492	7057	95661	19774	f	f
2530	Iran	2020-05-19	2020-05-20	124603	7119	97173	20311	f	f
2531	Iran	2020-05-20	2020-05-21	126949	7183	98808	20958	f	f
2532	Iran	2020-05-21	2020-05-22	129341	7249	100564	21528	f	f
2533	Iran	2020-05-22	2020-05-23	131652	7300	102276	22076	f	f
2534	Iran	2020-05-23	2020-05-24	133521	7359	104072	22090	f	f
2535	Iran	2020-05-24	2020-05-25	135701	7417	105801	22483	f	f
2536	Iran	2020-05-25	2020-05-26	137724	7451	107713	22560	f	f
2537	Iran	2020-05-26	2020-05-27	139511	7508	109437	22566	f	f
2538	Iran	2020-05-27	2020-05-28	141591	7564	111176	22851	f	f
2539	Iran	2020-05-28	2020-05-29	143849	7627	112988	23234	f	f
2540	Iran	2020-05-29	2020-05-30	146668	7677	114931	24060	f	f
2541	Iran	2020-05-30	2020-05-31	148950	7734	116827	24389	f	f
2542	Iran	2020-05-31	2020-06-01	151466	7797	118848	24821	f	f
2543	Iraq	2020-05-01	2020-05-02	2153	94	1414	645	f	f
2544	Iraq	2020-05-02	2020-05-03	2219	95	1473	651	f	f
2545	Iraq	2020-05-03	2020-05-04	2296	97	1490	709	f	f
2546	Iraq	2020-05-04	2020-05-05	2346	98	1544	704	f	f
2547	Iraq	2020-05-05	2020-05-06	2431	102	1571	758	f	f
2548	Iraq	2020-05-06	2020-05-07	2480	102	1602	776	f	f
2549	Iraq	2020-05-07	2020-05-08	2543	102	1626	815	f	f
2550	Iraq	2020-05-08	2020-05-09	2603	104	1661	838	f	f
2551	Iraq	2020-05-09	2020-05-10	2679	107	1702	870	f	f
2552	Iraq	2020-05-10	2020-05-11	2767	109	1734	924	f	f
2553	Iraq	2020-05-11	2020-05-12	2818	110	1790	918	f	f
2554	Iraq	2020-05-12	2020-05-13	2913	112	1903	898	f	f
2555	Iraq	2020-05-13	2020-05-14	3032	115	1966	951	f	f
2556	Iraq	2020-05-14	2020-05-15	3143	115	2028	1000	f	f
2557	Iraq	2020-05-15	2020-05-16	3193	117	2089	987	f	f
2558	Iraq	2020-05-16	2020-05-17	3260	121	2126	1013	f	f
2559	Iraq	2020-05-17	2020-05-18	3404	123	2218	1063	f	f
2560	Iraq	2020-05-18	2020-05-19	3554	127	2310	1117	f	f
2561	Iraq	2020-05-19	2020-05-20	3611	131	2366	1114	f	f
2562	Iraq	2020-05-20	2020-05-21	3724	134	2438	1152	f	f
2563	Iraq	2020-05-21	2020-05-22	3877	140	2483	1254	f	f
2564	Iraq	2020-05-22	2020-05-23	3964	147	2532	1285	f	f
2565	Iraq	2020-05-23	2020-05-24	4272	152	2585	1535	f	f
2566	Iraq	2020-05-24	2020-05-25	4469	160	2738	1571	f	f
2567	Iraq	2020-05-25	2020-05-26	4632	163	2811	1658	f	f
2568	Iraq	2020-05-26	2020-05-27	4848	169	2852	1827	f	f
2569	Iraq	2020-05-27	2020-05-28	5135	175	2904	2056	f	f
2570	Iraq	2020-05-28	2020-05-29	5457	179	2971	2307	f	f
2571	Iraq	2020-05-29	2020-05-30	5873	185	3044	2644	f	f
2572	Iraq	2020-05-30	2020-05-31	6179	195	3110	2874	f	f
2573	Iraq	2020-05-31	2020-06-01	6439	205	3156	3078	f	f
2574	Ireland	2020-05-01	2020-05-02	20833	1265	13386	6182	f	f
2575	Ireland	2020-05-02	2020-05-03	21176	1286	13386	6504	f	f
2576	Ireland	2020-05-03	2020-05-04	21506	1303	13386	6817	f	f
2577	Ireland	2020-05-04	2020-05-05	21772	1319	13386	7067	f	f
2578	Ireland	2020-05-05	2020-05-06	21983	1339	13386	7258	f	f
2579	Ireland	2020-05-06	2020-05-07	22248	1375	17110	3763	f	f
2580	Ireland	2020-05-07	2020-05-08	22385	1403	17110	3872	f	f
2581	Ireland	2020-05-08	2020-05-09	22541	1429	17110	4002	f	f
2582	Ireland	2020-05-09	2020-05-10	22760	1446	17110	4204	f	f
2583	Ireland	2020-05-10	2020-05-11	22996	1458	17110	4428	f	f
2584	Ireland	2020-05-11	2020-05-12	23135	1467	17110	4558	f	f
2585	Ireland	2020-05-12	2020-05-13	23242	1488	17110	4644	f	f
2586	Ireland	2020-05-13	2020-05-14	23401	1497	19470	2434	f	f
2587	Ireland	2020-05-14	2020-05-15	23827	1506	19470	2851	f	f
2588	Ireland	2020-05-15	2020-05-16	23956	1518	19470	2968	f	f
2589	Ireland	2020-05-16	2020-05-17	24048	1533	19470	3045	f	f
2590	Ireland	2020-05-17	2020-05-18	24112	1543	19470	3099	f	f
2591	Ireland	2020-05-18	2020-05-19	24200	1547	19470	3183	f	f
2592	Ireland	2020-05-19	2020-05-20	24251	1561	19470	3220	f	f
2593	Ireland	2020-05-20	2020-05-21	24315	1571	21060	1684	f	f
2594	Ireland	2020-05-21	2020-05-22	24391	1583	21060	1748	f	f
2595	Ireland	2020-05-22	2020-05-23	24506	1592	21060	1854	f	f
2596	Ireland	2020-05-23	2020-05-24	24582	1604	21060	1918	f	f
2597	Ireland	2020-05-24	2020-05-25	24639	1608	21060	1971	f	f
2598	Ireland	2020-05-25	2020-05-26	24698	1606	21060	2032	f	f
2599	Ireland	2020-05-26	2020-05-27	24735	1615	21060	2060	f	f
2600	Ireland	2020-05-27	2020-05-28	24803	1631	22089	1083	f	f
2602	Ireland	2020-05-29	2020-05-30	24876	1645	22089	1142	f	f
2603	Ireland	2020-05-30	2020-05-31	24929	1651	22089	1189	f	f
2604	Ireland	2020-05-31	2020-06-01	24990	1652	22089	1249	f	f
2605	Israel	2020-05-01	2020-05-02	16012	229	9393	6720	f	f
2606	Israel	2020-05-02	2020-05-03	16069	232	9611	6363	f	f
2607	Israel	2020-05-03	2020-05-04	16096	235	9945	6227	f	f
2608	Israel	2020-05-04	2020-05-05	16149	238	10233	5947	f	f
2609	Israel	2020-05-05	2020-05-06	16181	240	10561	5586	f	f
2610	Israel	2020-05-06	2020-05-07	16246	241	10843	5434	f	f
2611	Israel	2020-05-07	2020-05-08	16307	242	11103	5268	f	f
2612	Israel	2020-05-08	2020-05-09	16340	248	11318	4962	f	f
2613	Israel	2020-05-09	2020-05-10	16359	251	11402	4831	f	f
2614	Israel	2020-05-10	2020-05-11	16388	255	11649	4795	f	f
2615	Israel	2020-05-11	2020-05-12	16427	260	11940	4405	f	f
2616	Israel	2020-05-12	2020-05-13	16450	263	12195	4186	f	f
2617	Israel	2020-05-13	2020-05-14	16489	266	12398	4052	f	f
2618	Israel	2020-05-14	2020-05-15	16511	268	12648	3793	f	f
2619	Israel	2020-05-15	2020-05-16	16523	268	12793	3736	f	f
2620	Israel	2020-05-16	2020-05-17	16528	271	12880	3485	f	f
2621	Israel	2020-05-17	2020-05-18	16543	275	13062	3403	f	f
2622	Israel	2020-05-18	2020-05-19	16570	278	13346	3114	f	f
2623	Israel	2020-05-19	2020-05-20	16592	280	13485	2946	f	f
2624	Israel	2020-05-20	2020-05-21	16607	281	13613	2884	f	f
2625	Israel	2020-05-21	2020-05-22	16624	281	13780	2680	f	f
2626	Israel	2020-05-22	2020-05-23	16643	281	13925	2496	f	f
2627	Israel	2020-05-23	2020-05-24	16648	281	13976	2343	f	f
2628	Israel	2020-05-24	2020-05-25	16661	282	14121	2285	f	f
2629	Israel	2020-05-25	2020-05-26	16683	284	14252	2146	f	f
2630	Israel	2020-05-26	2020-05-27	16733	284	14352	2019	f	f
2631	Israel	2020-05-27	2020-05-28	16773	286	14414	1942	f	f
2632	Israel	2020-05-28	2020-05-29	16850	287	14532	1909	f	f
2633	Israel	2020-05-29	2020-05-30	16963	287	14568	1927	f	f
2634	Israel	2020-05-30	2020-05-31	16992	287	14608	1917	f	f
2635	Israel	2020-05-31	2020-06-01	17079	287	14675	1974	f	f
2636	Italy	2020-05-01	2020-05-02	207428	28236	78249	100943	f	f
2637	Italy	2020-05-02	2020-05-03	209328	28710	79914	100704	f	f
2638	Italy	2020-05-03	2020-05-04	210717	28884	81654	100179	f	f
2639	Italy	2020-05-04	2020-05-05	211938	29079	82879	99980	f	f
2640	Italy	2020-05-05	2020-05-06	213013	29315	85231	98467	f	f
2641	Italy	2020-05-06	2020-05-07	214457	29684	93245	91528	f	f
2642	Italy	2020-05-07	2020-05-08	215858	29958	96276	89624	f	f
2643	Italy	2020-05-08	2020-05-09	217185	30201	99023	87961	f	f
2644	Italy	2020-05-09	2020-05-10	218268	30395	103031	84842	f	f
2645	Italy	2020-05-10	2020-05-11	219070	30560	105186	83324	f	f
2646	Italy	2020-05-11	2020-05-12	219814	30739	106587	82488	f	f
2647	Italy	2020-05-12	2020-05-13	221216	30911	109039	81266	f	f
2648	Italy	2020-05-13	2020-05-14	222104	31106	112541	78457	f	f
2649	Italy	2020-05-14	2020-05-15	223096	31368	115288	76440	f	f
2650	Italy	2020-05-15	2020-05-16	223885	31610	120205	72070	f	f
2651	Italy	2020-05-16	2020-05-17	224760	31763	122810	70187	f	f
2652	Italy	2020-05-17	2020-05-18	225435	31908	125176	68351	f	f
2653	Italy	2020-05-18	2020-05-19	225886	32007	127326	66553	f	f
2654	Italy	2020-05-19	2020-05-20	226699	32169	129401	65129	f	f
2655	Italy	2020-05-20	2020-05-21	227364	32330	132282	62752	f	f
2656	Italy	2020-05-21	2020-05-22	228006	32486	134560	60960	f	f
2657	Italy	2020-05-22	2020-05-23	228658	32616	136720	59322	f	f
2658	Italy	2020-05-23	2020-05-24	229327	32735	138840	57752	f	f
2659	Italy	2020-05-24	2020-05-25	229858	32785	140479	56594	f	f
2660	Italy	2020-05-25	2020-05-26	230158	32877	141981	55300	f	f
2661	Italy	2020-05-26	2020-05-27	230555	32955	144658	52942	f	f
2662	Italy	2020-05-27	2020-05-28	231139	33072	147101	50966	f	f
2663	Italy	2020-05-28	2020-05-29	231732	33142	150604	47986	f	f
2664	Italy	2020-05-29	2020-05-30	232248	33229	152844	46175	f	f
2665	Italy	2020-05-30	2020-05-31	232664	33340	155633	43691	f	f
2666	Italy	2020-05-31	2020-06-01	232997	33415	157507	42075	f	f
2667	Jamaica	2020-05-01	2020-05-02	432	8	31	393	f	f
2668	Jamaica	2020-05-02	2020-05-03	463	8	33	422	f	f
2669	Jamaica	2020-05-03	2020-05-04	469	9	38	422	f	f
2670	Jamaica	2020-05-04	2020-05-05	471	9	38	424	f	f
2671	Jamaica	2020-05-05	2020-05-06	473	9	56	408	f	f
2672	Jamaica	2020-05-06	2020-05-07	478	9	57	412	f	f
2673	Jamaica	2020-05-07	2020-05-08	488	9	58	421	f	f
2674	Jamaica	2020-05-08	2020-05-09	490	9	62	419	f	f
2675	Jamaica	2020-05-09	2020-05-10	490	9	62	419	f	f
2676	Jamaica	2020-05-10	2020-05-11	502	9	90	403	f	f
2677	Jamaica	2020-05-11	2020-05-12	505	9	90	406	f	f
2678	Jamaica	2020-05-12	2020-05-13	507	9	100	398	f	f
2679	Jamaica	2020-05-13	2020-05-14	509	9	113	387	f	f
2680	Jamaica	2020-05-14	2020-05-15	509	9	118	382	f	f
2681	Jamaica	2020-05-15	2020-05-16	511	9	121	381	f	f
2682	Jamaica	2020-05-16	2020-05-17	517	9	121	387	f	f
2683	Jamaica	2020-05-17	2020-05-18	520	9	127	384	f	f
2684	Jamaica	2020-05-18	2020-05-19	520	9	131	380	f	f
2685	Jamaica	2020-05-19	2020-05-20	520	9	145	366	f	f
2686	Jamaica	2020-05-20	2020-05-21	529	9	171	349	f	f
2687	Jamaica	2020-05-21	2020-05-22	534	9	181	344	f	f
2688	Jamaica	2020-05-22	2020-05-23	544	9	191	344	f	f
2689	Jamaica	2020-05-23	2020-05-24	550	9	200	341	f	f
2690	Jamaica	2020-05-24	2020-05-25	552	9	211	332	f	f
2691	Jamaica	2020-05-25	2020-05-26	556	9	238	309	f	f
2692	Jamaica	2020-05-26	2020-05-27	564	9	267	288	f	f
2693	Jamaica	2020-05-27	2020-05-28	569	9	279	281	f	f
2694	Jamaica	2020-05-28	2020-05-29	569	9	284	276	f	f
2695	Jamaica	2020-05-29	2020-05-30	575	9	289	277	f	f
2696	Jamaica	2020-05-30	2020-05-31	581	9	290	282	f	f
2697	Jamaica	2020-05-31	2020-06-01	586	9	311	266	f	f
2698	Japan	2020-05-01	2020-05-02	14305	455	2975	10875	f	f
2699	Japan	2020-05-02	2020-05-03	14571	474	3205	10892	f	f
2700	Japan	2020-05-03	2020-05-04	14877	487	3981	10409	f	f
2701	Japan	2020-05-04	2020-05-05	15078	536	4156	10386	f	f
2702	Japan	2020-05-05	2020-05-06	15253	556	4496	10201	f	f
2703	Japan	2020-05-06	2020-05-07	15253	556	4496	10201	f	f
2704	Japan	2020-05-07	2020-05-08	15477	577	4918	9982	f	f
2705	Japan	2020-05-08	2020-05-09	15575	590	5146	9839	f	f
2706	Japan	2020-05-09	2020-05-10	15663	607	5906	9150	f	f
2707	Japan	2020-05-10	2020-05-11	15777	624	8127	7026	f	f
2708	Japan	2020-05-11	2020-05-12	15847	633	8293	6921	f	f
2709	Japan	2020-05-12	2020-05-13	15968	657	8531	6780	f	f
2710	Japan	2020-05-13	2020-05-14	16049	678	8920	6451	f	f
2711	Japan	2020-05-14	2020-05-15	16120	697	9868	5555	f	f
2712	Japan	2020-05-15	2020-05-16	16203	713	10338	5152	f	f
2713	Japan	2020-05-16	2020-05-17	16237	725	10338	5174	f	f
2714	Japan	2020-05-17	2020-05-18	16285	744	11153	4388	f	f
2715	Japan	2020-05-18	2020-05-19	16305	749	11564	3992	f	f
2716	Japan	2020-05-19	2020-05-20	16367	768	11564	4035	f	f
2717	Japan	2020-05-20	2020-05-21	16367	768	11564	4035	f	f
2718	Japan	2020-05-21	2020-05-22	16424	777	12672	2975	f	f
2719	Japan	2020-05-22	2020-05-23	16513	796	13005	2712	f	f
2720	Japan	2020-05-23	2020-05-24	16536	808	13244	2484	f	f
2721	Japan	2020-05-24	2020-05-25	16550	820	13413	2317	f	f
2722	Japan	2020-05-25	2020-05-26	16581	830	13612	2139	f	f
2723	Japan	2020-05-26	2020-05-27	16623	846	13810	1967	f	f
2724	Japan	2020-05-27	2020-05-28	16651	858	13973	1820	f	f
2725	Japan	2020-05-28	2020-05-29	16598	881	14096	1621	f	f
2726	Japan	2020-05-29	2020-05-30	16673	887	14213	1573	f	f
2727	Japan	2020-05-30	2020-05-31	16716	894	14267	1555	f	f
2728	Japan	2020-05-31	2020-06-01	16751	898	14342	1511	f	f
2729	Jordan	2020-05-01	2020-05-02	459	8	364	87	f	f
2730	Jordan	2020-05-02	2020-05-03	460	9	367	84	f	f
2731	Jordan	2020-05-03	2020-05-04	461	9	367	85	f	f
2732	Jordan	2020-05-04	2020-05-05	465	9	370	86	f	f
2733	Jordan	2020-05-05	2020-05-06	471	9	375	87	f	f
2734	Jordan	2020-05-06	2020-05-07	473	9	377	87	f	f
2735	Jordan	2020-05-07	2020-05-08	494	9	381	104	f	f
2736	Jordan	2020-05-08	2020-05-09	508	9	385	114	f	f
2737	Jordan	2020-05-09	2020-05-10	522	9	387	126	f	f
2738	Jordan	2020-05-10	2020-05-11	540	9	389	142	f	f
2739	Jordan	2020-05-11	2020-05-12	562	9	390	163	f	f
2740	Jordan	2020-05-12	2020-05-13	576	9	390	177	f	f
2741	Jordan	2020-05-13	2020-05-14	582	9	392	181	f	f
2742	Jordan	2020-05-14	2020-05-15	586	9	393	184	f	f
2743	Jordan	2020-05-15	2020-05-16	596	9	401	186	f	f
2744	Jordan	2020-05-16	2020-05-17	607	9	404	194	f	f
2745	Jordan	2020-05-17	2020-05-18	613	9	408	196	f	f
2746	Jordan	2020-05-18	2020-05-19	629	9	413	207	f	f
2747	Jordan	2020-05-19	2020-05-20	649	9	417	223	f	f
2748	Jordan	2020-05-20	2020-05-21	672	9	446	217	f	f
2749	Jordan	2020-05-21	2020-05-22	684	9	457	218	f	f
2750	Jordan	2020-05-22	2020-05-23	700	9	461	230	f	f
2751	Jordan	2020-05-23	2020-05-24	704	9	470	225	f	f
2752	Jordan	2020-05-24	2020-05-25	708	9	471	228	f	f
2753	Jordan	2020-05-25	2020-05-26	711	9	479	223	f	f
2754	Jordan	2020-05-26	2020-05-27	718	9	586	123	f	f
2755	Jordan	2020-05-27	2020-05-28	720	9	586	125	f	f
2756	Jordan	2020-05-28	2020-05-29	728	9	497	222	f	f
2757	Jordan	2020-05-29	2020-05-30	730	9	507	214	f	f
2758	Jordan	2020-05-30	2020-05-31	734	9	507	218	f	f
2759	Jordan	2020-05-31	2020-06-01	739	9	522	208	f	f
2760	Kazakhstan	2020-05-01	2020-05-02	3597	25	922	2650	f	f
2761	Kazakhstan	2020-05-02	2020-05-03	3857	25	985	2847	f	f
2762	Kazakhstan	2020-05-03	2020-05-04	3920	27	1084	2809	f	f
2763	Kazakhstan	2020-05-04	2020-05-05	4049	29	1173	2847	f	f
2764	Kazakhstan	2020-05-05	2020-05-06	4205	29	1279	2897	f	f
2765	Kazakhstan	2020-05-06	2020-05-07	4422	30	1408	2984	f	f
2766	Kazakhstan	2020-05-07	2020-05-08	4578	30	1518	3030	f	f
2767	Kazakhstan	2020-05-08	2020-05-09	4834	31	1631	3172	f	f
2768	Kazakhstan	2020-05-09	2020-05-10	4975	31	1776	3168	f	f
2769	Kazakhstan	2020-05-10	2020-05-11	5090	31	1941	3118	f	f
2770	Kazakhstan	2020-05-11	2020-05-12	5207	32	2074	3101	f	f
2771	Kazakhstan	2020-05-12	2020-05-13	5279	32	2223	3024	f	f
2772	Kazakhstan	2020-05-13	2020-05-14	5417	32	2408	2977	f	f
2773	Kazakhstan	2020-05-14	2020-05-15	5571	32	2531	3008	f	f
2774	Kazakhstan	2020-05-15	2020-05-16	5689	34	2707	2948	f	f
2775	Kazakhstan	2020-05-16	2020-05-17	5850	34	2980	2836	f	f
2776	Kazakhstan	2020-05-17	2020-05-18	6157	34	3256	2867	f	f
2777	Kazakhstan	2020-05-18	2020-05-19	6751	35	3469	3247	f	f
2778	Kazakhstan	2020-05-19	2020-05-20	6751	35	3598	3118	f	f
2779	Kazakhstan	2020-05-20	2020-05-21	6969	35	3734	3200	f	f
2780	Kazakhstan	2020-05-21	2020-05-22	7234	35	3843	3356	f	f
2781	Kazakhstan	2020-05-22	2020-05-23	7919	35	4096	3788	f	f
2782	Kazakhstan	2020-05-23	2020-05-24	7919	35	4214	3670	f	f
2783	Kazakhstan	2020-05-24	2020-05-25	8531	35	4352	4144	f	f
2784	Kazakhstan	2020-05-25	2020-05-26	8969	35	4515	4419	f	f
2785	Kazakhstan	2020-05-26	2020-05-27	8969	37	4613	4319	f	f
2786	Kazakhstan	2020-05-27	2020-05-28	9304	37	4768	4499	f	f
2787	Kazakhstan	2020-05-28	2020-05-29	9576	37	4900	4639	f	f
2788	Kazakhstan	2020-05-29	2020-05-30	9932	37	5057	4838	f	f
2789	Kazakhstan	2020-05-30	2020-05-31	10382	38	5220	5124	f	f
2790	Kazakhstan	2020-05-31	2020-06-01	10858	40	5404	5414	f	f
2791	Kenya	2020-05-01	2020-05-02	411	21	150	240	f	f
2792	Kenya	2020-05-02	2020-05-03	435	22	152	261	f	f
2793	Kenya	2020-05-03	2020-05-04	465	24	167	274	f	f
2794	Kenya	2020-05-04	2020-05-05	490	24	173	293	f	f
2795	Kenya	2020-05-05	2020-05-06	535	24	182	329	f	f
2796	Kenya	2020-05-06	2020-05-07	582	26	190	366	f	f
2797	Kenya	2020-05-07	2020-05-08	607	29	197	381	f	f
2798	Kenya	2020-05-08	2020-05-09	621	29	202	390	f	f
2799	Kenya	2020-05-09	2020-05-10	649	30	207	412	f	f
2800	Kenya	2020-05-10	2020-05-11	672	32	239	401	f	f
2801	Kenya	2020-05-11	2020-05-12	700	33	251	416	f	f
2802	Kenya	2020-05-12	2020-05-13	715	36	259	420	f	f
2803	Kenya	2020-05-13	2020-05-14	737	40	281	416	f	f
2804	Kenya	2020-05-14	2020-05-15	758	42	284	432	f	f
2805	Kenya	2020-05-15	2020-05-16	781	45	284	452	f	f
2806	Kenya	2020-05-16	2020-05-17	830	50	301	479	f	f
2807	Kenya	2020-05-17	2020-05-18	887	50	313	524	f	f
2808	Kenya	2020-05-18	2020-05-19	912	50	336	526	f	f
2809	Kenya	2020-05-19	2020-05-20	963	50	358	555	f	f
2810	Kenya	2020-05-20	2020-05-21	1029	50	366	613	f	f
2811	Kenya	2020-05-21	2020-05-22	1109	50	375	684	f	f
2812	Kenya	2020-05-22	2020-05-23	1161	50	380	731	f	f
2813	Kenya	2020-05-23	2020-05-24	1192	50	380	762	f	f
2814	Kenya	2020-05-24	2020-05-25	1214	51	383	780	f	f
2815	Kenya	2020-05-25	2020-05-26	1286	52	402	832	f	f
2816	Kenya	2020-05-26	2020-05-27	1348	52	405	891	f	f
2817	Kenya	2020-05-27	2020-05-28	1471	55	408	1008	f	f
2818	Kenya	2020-05-28	2020-05-29	1618	58	421	1139	f	f
2819	Kenya	2020-05-29	2020-05-30	1745	62	438	1245	f	f
2820	Kenya	2020-05-30	2020-05-31	1888	63	464	1361	f	f
2821	Kenya	2020-05-31	2020-06-01	1962	64	478	1420	f	f
2822	Kiribati	2020-05-01	2020-05-02	0	0	0	0	f	f
2823	Kiribati	2020-05-02	2020-05-03	0	0	0	0	f	f
2824	Kiribati	2020-05-03	2020-05-04	0	0	0	0	f	f
2825	Kiribati	2020-05-04	2020-05-05	0	0	0	0	f	f
2826	Kiribati	2020-05-05	2020-05-06	0	0	0	0	f	f
2827	Kiribati	2020-05-06	2020-05-07	0	0	0	0	f	f
2828	Kiribati	2020-05-07	2020-05-08	0	0	0	0	f	f
2829	Kiribati	2020-05-08	2020-05-09	0	0	0	0	f	f
2830	Kiribati	2020-05-09	2020-05-10	0	0	0	0	f	f
2831	Kiribati	2020-05-10	2020-05-11	0	0	0	0	f	f
2832	Kiribati	2020-05-11	2020-05-12	0	0	0	0	f	f
2833	Kiribati	2020-05-12	2020-05-13	0	0	0	0	f	f
2834	Kiribati	2020-05-13	2020-05-14	0	0	0	0	f	f
2835	Kiribati	2020-05-14	2020-05-15	0	0	0	0	f	f
2836	Kiribati	2020-05-15	2020-05-16	0	0	0	0	f	f
2837	Kiribati	2020-05-16	2020-05-17	0	0	0	0	f	f
2838	Kiribati	2020-05-17	2020-05-18	0	0	0	0	f	f
2839	Kiribati	2020-05-18	2020-05-19	0	0	0	0	f	f
2840	Kiribati	2020-05-19	2020-05-20	0	0	0	0	f	f
2841	Kiribati	2020-05-20	2020-05-21	0	0	0	0	f	f
2842	Kiribati	2020-05-21	2020-05-22	0	0	0	0	f	f
2843	Kiribati	2020-05-22	2020-05-23	0	0	0	0	f	f
2844	Kiribati	2020-05-23	2020-05-24	0	0	0	0	f	f
2845	Kiribati	2020-05-24	2020-05-25	0	0	0	0	f	f
2846	Kiribati	2020-05-25	2020-05-26	0	0	0	0	f	f
2847	Kiribati	2020-05-26	2020-05-27	0	0	0	0	f	f
2848	Kiribati	2020-05-27	2020-05-28	0	0	0	0	f	f
2849	Kiribati	2020-05-28	2020-05-29	0	0	0	0	f	f
2850	Kiribati	2020-05-29	2020-05-30	0	0	0	0	f	f
2851	Kiribati	2020-05-30	2020-05-31	0	0	0	0	f	f
2852	Kiribati	2020-05-31	2020-06-01	0	0	0	0	f	f
2853	Korea, South	2020-05-01	2020-05-02	10780	250	9123	1407	f	f
2854	Korea, South	2020-05-02	2020-05-03	10793	250	9183	1360	f	f
2855	Korea, South	2020-05-03	2020-05-04	10801	252	9217	1332	f	f
2856	Korea, South	2020-05-04	2020-05-05	10804	254	9283	1267	f	f
2857	Korea, South	2020-05-05	2020-05-06	10806	255	9333	1218	f	f
2858	Korea, South	2020-05-06	2020-05-07	10810	256	9419	1135	f	f
2859	Korea, South	2020-05-07	2020-05-08	10822	256	9484	1082	f	f
2860	Korea, South	2020-05-08	2020-05-09	10840	256	9568	1016	f	f
2861	Korea, South	2020-05-09	2020-05-10	10874	256	9610	1008	f	f
2862	Korea, South	2020-05-10	2020-05-11	10909	256	9632	1021	f	f
2863	Korea, South	2020-05-11	2020-05-12	10936	258	9670	1008	f	f
2864	Korea, South	2020-05-12	2020-05-13	10962	259	9695	1008	f	f
2865	Korea, South	2020-05-13	2020-05-14	10991	260	9762	969	f	f
2866	Korea, South	2020-05-14	2020-05-15	11018	260	9821	937	f	f
2867	Korea, South	2020-05-15	2020-05-16	11037	262	9851	924	f	f
2868	Korea, South	2020-05-16	2020-05-17	11050	262	9888	900	f	f
2869	Korea, South	2020-05-17	2020-05-18	11065	263	9904	898	f	f
2870	Korea, South	2020-05-18	2020-05-19	11078	263	9938	877	f	f
2871	Korea, South	2020-05-19	2020-05-20	11110	263	10066	781	f	f
2872	Korea, South	2020-05-20	2020-05-21	11122	264	10135	723	f	f
2873	Korea, South	2020-05-21	2020-05-22	11142	264	10162	716	f	f
2874	Korea, South	2020-05-22	2020-05-23	11165	266	10194	705	f	f
2875	Korea, South	2020-05-23	2020-05-24	11190	266	10213	711	f	f
2876	Korea, South	2020-05-24	2020-05-25	11206	267	10226	713	f	f
2877	Korea, South	2020-05-25	2020-05-26	11225	269	10275	681	f	f
2878	Korea, South	2020-05-26	2020-05-27	11265	269	10295	701	f	f
2879	Korea, South	2020-05-27	2020-05-28	11344	269	10340	735	f	f
2880	Korea, South	2020-05-28	2020-05-29	11402	269	10363	770	f	f
2881	Korea, South	2020-05-29	2020-05-30	11441	269	10398	774	f	f
2882	Korea, South	2020-05-30	2020-05-31	11468	270	10405	793	f	f
2883	Korea, South	2020-05-31	2020-06-01	11503	271	10422	810	f	f
2884	Kosovo	2020-05-01	2020-05-02	806	22	271	513	f	f
2885	Kosovo	2020-05-02	2020-05-03	823	22	336	465	f	f
2886	Kosovo	2020-05-03	2020-05-04	851	22	381	448	f	f
2887	Kosovo	2020-05-04	2020-05-05	855	26	403	426	f	f
2888	Kosovo	2020-05-05	2020-05-06	856	26	490	340	f	f
2889	Kosovo	2020-05-06	2020-05-07	856	26	490	340	f	f
2890	Kosovo	2020-05-07	2020-05-08	861	27	562	272	f	f
2891	Kosovo	2020-05-08	2020-05-09	861	27	562	272	f	f
2892	Kosovo	2020-05-09	2020-05-10	862	28	622	212	f	f
2893	Kosovo	2020-05-10	2020-05-11	870	28	653	189	f	f
2894	Kosovo	2020-05-11	2020-05-12	884	28	655	201	f	f
2895	Kosovo	2020-05-12	2020-05-13	919	29	671	219	f	f
2896	Kosovo	2020-05-13	2020-05-14	919	29	671	219	f	f
2897	Kosovo	2020-05-14	2020-05-15	944	29	690	225	f	f
2898	Kosovo	2020-05-15	2020-05-16	944	29	690	225	f	f
2899	Kosovo	2020-05-16	2020-05-17	944	29	690	225	f	f
2900	Kosovo	2020-05-17	2020-05-18	955	29	691	235	f	f
2901	Kosovo	2020-05-18	2020-05-19	955	29	691	235	f	f
2902	Kosovo	2020-05-19	2020-05-20	989	29	769	191	f	f
2903	Kosovo	2020-05-20	2020-05-21	989	29	769	191	f	f
2904	Kosovo	2020-05-21	2020-05-22	1003	29	772	202	f	f
2905	Kosovo	2020-05-22	2020-05-23	1004	29	772	203	f	f
2906	Kosovo	2020-05-23	2020-05-24	1025	29	782	214	f	f
2907	Kosovo	2020-05-24	2020-05-25	1032	29	785	218	f	f
2908	Kosovo	2020-05-25	2020-05-26	1038	30	791	217	f	f
2909	Kosovo	2020-05-26	2020-05-27	1038	30	791	217	f	f
2910	Kosovo	2020-05-27	2020-05-28	1047	30	794	223	f	f
2911	Kosovo	2020-05-28	2020-05-29	1048	30	801	217	f	f
2912	Kosovo	2020-05-29	2020-05-30	1048	30	801	217	f	f
2913	Kosovo	2020-05-30	2020-05-31	1064	30	829	205	f	f
2914	Kosovo	2020-05-31	2020-06-01	1064	30	829	205	f	f
2915	Kuwait	2020-05-01	2020-05-02	4377	30	1602	2745	f	f
2916	Kuwait	2020-05-02	2020-05-03	4619	33	1703	2883	f	f
2917	Kuwait	2020-05-03	2020-05-04	4983	38	1776	3169	f	f
2918	Kuwait	2020-05-04	2020-05-05	5278	40	1947	3291	f	f
2919	Kuwait	2020-05-05	2020-05-06	5804	40	2032	3732	f	f
2920	Kuwait	2020-05-06	2020-05-07	6289	42	2219	4028	f	f
2921	Kuwait	2020-05-07	2020-05-08	6567	44	2381	4142	f	f
2922	Kuwait	2020-05-08	2020-05-09	7208	47	2466	4695	f	f
2923	Kuwait	2020-05-09	2020-05-10	7623	49	2622	4952	f	f
2924	Kuwait	2020-05-10	2020-05-11	8688	58	2729	5901	f	f
2925	Kuwait	2020-05-11	2020-05-12	9286	65	2907	6314	f	f
2926	Kuwait	2020-05-12	2020-05-13	10277	75	3101	7101	f	f
2927	Kuwait	2020-05-13	2020-05-14	11028	82	3263	7683	f	f
2928	Kuwait	2020-05-14	2020-05-15	11975	88	3451	8436	f	f
2929	Kuwait	2020-05-15	2020-05-16	12860	96	3640	9124	f	f
2930	Kuwait	2020-05-16	2020-05-17	13802	107	3843	9852	f	f
2931	Kuwait	2020-05-17	2020-05-18	14850	112	4093	10645	f	f
2932	Kuwait	2020-05-18	2020-05-19	15691	118	4339	11234	f	f
2933	Kuwait	2020-05-19	2020-05-20	16764	121	4681	11962	f	f
2934	Kuwait	2020-05-20	2020-05-21	17568	124	4885	12559	f	f
2935	Kuwait	2020-05-21	2020-05-22	18609	129	5205	13275	f	f
2936	Kuwait	2020-05-22	2020-05-23	19564	138	5515	13911	f	f
2937	Kuwait	2020-05-23	2020-05-24	20464	148	5747	14569	f	f
2938	Kuwait	2020-05-24	2020-05-25	21302	156	6117	15029	f	f
2939	Kuwait	2020-05-25	2020-05-26	21967	165	6621	15181	f	f
2940	Kuwait	2020-05-26	2020-05-27	22575	172	7306	15097	f	f
2941	Kuwait	2020-05-27	2020-05-28	23267	175	7946	15146	f	f
2942	Kuwait	2020-05-28	2020-05-29	24112	185	8698	15229	f	f
2943	Kuwait	2020-05-29	2020-05-30	25184	194	9273	15717	f	f
2944	Kuwait	2020-05-30	2020-05-31	26192	205	10156	15831	f	f
2945	Kuwait	2020-05-31	2020-06-01	27043	212	11386	15445	f	f
2946	Kyrgyzstan	2020-05-01	2020-05-02	756	8	504	244	f	f
2947	Kyrgyzstan	2020-05-02	2020-05-03	769	8	527	234	f	f
2948	Kyrgyzstan	2020-05-03	2020-05-04	795	10	564	221	f	f
2949	Kyrgyzstan	2020-05-04	2020-05-05	830	10	575	245	f	f
2950	Kyrgyzstan	2020-05-05	2020-05-06	843	11	600	232	f	f
2951	Kyrgyzstan	2020-05-06	2020-05-07	871	12	614	245	f	f
2952	Kyrgyzstan	2020-05-07	2020-05-08	895	12	637	246	f	f
2953	Kyrgyzstan	2020-05-08	2020-05-09	906	12	650	244	f	f
2954	Kyrgyzstan	2020-05-09	2020-05-10	931	12	658	261	f	f
2955	Kyrgyzstan	2020-05-10	2020-05-11	1002	12	675	315	f	f
2956	Kyrgyzstan	2020-05-11	2020-05-12	1016	12	688	316	f	f
2957	Kyrgyzstan	2020-05-12	2020-05-13	1037	12	709	316	f	f
2958	Kyrgyzstan	2020-05-13	2020-05-14	1044	12	726	306	f	f
2959	Kyrgyzstan	2020-05-14	2020-05-15	1082	12	735	335	f	f
2960	Kyrgyzstan	2020-05-15	2020-05-16	1111	14	745	352	f	f
2961	Kyrgyzstan	2020-05-16	2020-05-17	1117	14	783	320	f	f
2962	Kyrgyzstan	2020-05-17	2020-05-18	1138	14	804	320	f	f
2963	Kyrgyzstan	2020-05-18	2020-05-19	1216	14	827	375	f	f
2964	Kyrgyzstan	2020-05-19	2020-05-20	1243	14	898	331	f	f
2965	Kyrgyzstan	2020-05-20	2020-05-21	1270	14	910	346	f	f
2966	Kyrgyzstan	2020-05-21	2020-05-22	1313	14	923	376	f	f
2967	Kyrgyzstan	2020-05-22	2020-05-23	1350	14	939	397	f	f
2968	Kyrgyzstan	2020-05-23	2020-05-24	1365	14	957	394	f	f
2969	Kyrgyzstan	2020-05-24	2020-05-25	1403	14	980	409	f	f
2970	Kyrgyzstan	2020-05-25	2020-05-26	1433	16	992	425	f	f
2971	Kyrgyzstan	2020-05-26	2020-05-27	1468	16	1015	437	f	f
2972	Kyrgyzstan	2020-05-27	2020-05-28	1520	16	1043	461	f	f
2973	Kyrgyzstan	2020-05-28	2020-05-29	1594	16	1066	512	f	f
2974	Kyrgyzstan	2020-05-29	2020-05-30	1662	16	1088	558	f	f
2975	Kyrgyzstan	2020-05-30	2020-05-31	1722	16	1113	593	f	f
2976	Kyrgyzstan	2020-05-31	2020-06-01	1748	16	1170	562	f	f
2977	Laos	2020-05-01	2020-05-02	19	0	8	11	f	f
2978	Laos	2020-05-02	2020-05-03	19	0	9	10	f	f
2979	Laos	2020-05-03	2020-05-04	19	0	9	10	f	f
2980	Laos	2020-05-04	2020-05-05	19	0	9	10	f	f
2981	Laos	2020-05-05	2020-05-06	19	0	9	10	f	f
2982	Laos	2020-05-06	2020-05-07	19	0	10	9	f	f
2983	Laos	2020-05-07	2020-05-08	19	0	9	10	f	f
2984	Laos	2020-05-08	2020-05-09	19	0	9	10	f	f
2985	Laos	2020-05-09	2020-05-10	19	0	13	6	f	f
2986	Laos	2020-05-10	2020-05-11	19	0	13	6	f	f
2987	Laos	2020-05-11	2020-05-12	19	0	13	6	f	f
2988	Laos	2020-05-12	2020-05-13	19	0	13	6	f	f
2989	Laos	2020-05-13	2020-05-14	19	0	14	5	f	f
2990	Laos	2020-05-14	2020-05-15	19	0	14	5	f	f
2991	Laos	2020-05-15	2020-05-16	19	0	14	5	f	f
2992	Laos	2020-05-16	2020-05-17	19	0	14	5	f	f
2993	Laos	2020-05-17	2020-05-18	19	0	14	5	f	f
2994	Laos	2020-05-18	2020-05-19	19	0	14	5	f	f
2995	Laos	2020-05-19	2020-05-20	19	0	14	5	f	f
2996	Laos	2020-05-20	2020-05-21	19	0	14	5	f	f
2997	Laos	2020-05-21	2020-05-22	19	0	14	5	f	f
2998	Laos	2020-05-22	2020-05-23	19	0	14	5	f	f
2999	Laos	2020-05-23	2020-05-24	19	0	14	5	f	f
3000	Laos	2020-05-24	2020-05-25	19	0	14	5	f	f
3001	Laos	2020-05-25	2020-05-26	19	0	14	5	f	f
3002	Laos	2020-05-26	2020-05-27	19	0	14	5	f	f
3003	Laos	2020-05-27	2020-05-28	19	0	16	3	f	f
3004	Laos	2020-05-28	2020-05-29	19	0	16	3	f	f
3005	Laos	2020-05-29	2020-05-30	19	0	16	3	f	f
3006	Laos	2020-05-30	2020-05-31	19	0	16	3	f	f
3007	Laos	2020-05-31	2020-06-01	19	0	16	3	f	f
3008	Latvia	2020-05-01	2020-05-02	870	16	348	506	f	f
3009	Latvia	2020-05-02	2020-05-03	871	16	348	507	f	f
3010	Latvia	2020-05-03	2020-05-04	879	16	348	515	f	f
3011	Latvia	2020-05-04	2020-05-05	896	16	348	532	f	f
3012	Latvia	2020-05-05	2020-05-06	896	17	348	531	f	f
3013	Latvia	2020-05-06	2020-05-07	900	17	464	419	f	f
3014	Latvia	2020-05-07	2020-05-08	909	18	464	427	f	f
3015	Latvia	2020-05-08	2020-05-09	928	18	464	446	f	f
3016	Latvia	2020-05-09	2020-05-10	930	18	464	448	f	f
3017	Latvia	2020-05-10	2020-05-11	939	18	464	457	f	f
3018	Latvia	2020-05-11	2020-05-12	946	18	464	464	f	f
3019	Latvia	2020-05-12	2020-05-13	950	18	627	305	f	f
3020	Latvia	2020-05-13	2020-05-14	951	19	627	305	f	f
3021	Latvia	2020-05-14	2020-05-15	962	19	627	316	f	f
3022	Latvia	2020-05-15	2020-05-16	970	19	662	289	f	f
3023	Latvia	2020-05-16	2020-05-17	997	19	662	316	f	f
3024	Latvia	2020-05-17	2020-05-18	1008	19	662	327	f	f
3025	Latvia	2020-05-18	2020-05-19	1009	19	662	328	f	f
3026	Latvia	2020-05-19	2020-05-20	1012	21	694	297	f	f
3027	Latvia	2020-05-20	2020-05-21	1016	21	694	301	f	f
3028	Latvia	2020-05-21	2020-05-22	1025	22	694	309	f	f
3029	Latvia	2020-05-22	2020-05-23	1030	22	712	296	f	f
3030	Latvia	2020-05-23	2020-05-24	1046	22	712	312	f	f
3031	Latvia	2020-05-24	2020-05-25	1047	22	712	313	f	f
3032	Latvia	2020-05-25	2020-05-26	1049	22	712	315	f	f
3033	Latvia	2020-05-26	2020-05-27	1053	22	741	290	f	f
3034	Latvia	2020-05-27	2020-05-28	1057	23	741	293	f	f
3035	Latvia	2020-05-28	2020-05-29	1061	24	741	296	f	f
3036	Latvia	2020-05-29	2020-05-30	1064	24	745	295	f	f
3037	Latvia	2020-05-30	2020-05-31	1065	24	745	296	f	f
3038	Latvia	2020-05-31	2020-06-01	1066	24	745	297	f	f
3039	Lebanon	2020-05-01	2020-05-02	729	24	192	513	f	f
3040	Lebanon	2020-05-02	2020-05-03	733	25	197	511	f	f
3041	Lebanon	2020-05-03	2020-05-04	737	25	200	512	f	f
3042	Lebanon	2020-05-04	2020-05-05	740	25	200	515	f	f
3043	Lebanon	2020-05-05	2020-05-06	741	25	206	510	f	f
3044	Lebanon	2020-05-06	2020-05-07	750	25	206	519	f	f
3045	Lebanon	2020-05-07	2020-05-08	784	25	220	539	f	f
3046	Lebanon	2020-05-08	2020-05-09	796	26	223	547	f	f
3047	Lebanon	2020-05-09	2020-05-10	809	26	234	549	f	f
3048	Lebanon	2020-05-10	2020-05-11	845	26	234	585	f	f
3049	Lebanon	2020-05-11	2020-05-12	859	26	234	599	f	f
3050	Lebanon	2020-05-12	2020-05-13	870	26	234	610	f	f
3051	Lebanon	2020-05-13	2020-05-14	878	26	236	616	f	f
3052	Lebanon	2020-05-14	2020-05-15	886	26	236	624	f	f
3053	Lebanon	2020-05-15	2020-05-16	891	26	246	619	f	f
3054	Lebanon	2020-05-16	2020-05-17	902	26	247	629	f	f
3055	Lebanon	2020-05-17	2020-05-18	911	26	247	638	f	f
3056	Lebanon	2020-05-18	2020-05-19	931	26	251	654	f	f
3057	Lebanon	2020-05-19	2020-05-20	954	26	251	677	f	f
3058	Lebanon	2020-05-20	2020-05-21	961	26	251	684	f	f
3059	Lebanon	2020-05-21	2020-05-22	1024	26	663	335	f	f
3060	Lebanon	2020-05-22	2020-05-23	1086	26	663	397	f	f
3061	Lebanon	2020-05-23	2020-05-24	1097	26	667	404	f	f
3062	Lebanon	2020-05-24	2020-05-25	1114	26	688	400	f	f
3063	Lebanon	2020-05-25	2020-05-26	1119	26	688	405	f	f
3064	Lebanon	2020-05-26	2020-05-27	1140	26	689	425	f	f
3065	Lebanon	2020-05-27	2020-05-28	1161	26	692	443	f	f
3066	Lebanon	2020-05-28	2020-05-29	1168	26	699	443	f	f
3067	Lebanon	2020-05-29	2020-05-30	1172	26	705	441	f	f
3068	Lebanon	2020-05-30	2020-05-31	1191	26	708	457	f	f
3069	Lebanon	2020-05-31	2020-06-01	1220	27	712	481	f	f
3070	Lesotho	2020-05-13	2020-05-14	1	0	0	1	f	f
3071	Lesotho	2020-05-14	2020-05-15	1	0	0	1	f	f
3072	Lesotho	2020-05-15	2020-05-16	1	0	0	1	f	f
3073	Lesotho	2020-05-16	2020-05-17	1	0	0	1	f	f
3074	Lesotho	2020-05-17	2020-05-18	1	0	0	1	f	f
3075	Lesotho	2020-05-18	2020-05-19	1	0	0	1	f	f
3076	Lesotho	2020-05-19	2020-05-20	1	0	0	1	f	f
3077	Lesotho	2020-05-20	2020-05-21	1	0	0	1	f	f
3078	Lesotho	2020-05-21	2020-05-22	1	0	0	1	f	f
3079	Lesotho	2020-05-22	2020-05-23	2	0	0	2	f	f
3080	Lesotho	2020-05-23	2020-05-24	2	0	0	2	f	f
3081	Lesotho	2020-05-24	2020-05-25	2	0	0	2	f	f
3082	Lesotho	2020-05-25	2020-05-26	2	0	0	2	f	f
3083	Lesotho	2020-05-26	2020-05-27	2	0	0	2	f	f
3084	Lesotho	2020-05-27	2020-05-28	2	0	0	2	f	f
3085	Lesotho	2020-05-28	2020-05-29	2	0	1	1	f	f
3086	Lesotho	2020-05-29	2020-05-30	2	0	1	1	f	f
3087	Lesotho	2020-05-30	2020-05-31	2	0	1	1	f	f
3088	Lesotho	2020-05-31	2020-06-01	2	0	1	1	f	f
3089	Liberia	2020-05-01	2020-05-02	152	18	45	89	f	f
3090	Liberia	2020-05-02	2020-05-03	154	18	48	88	f	f
3091	Liberia	2020-05-03	2020-05-04	158	18	58	82	f	f
3092	Liberia	2020-05-04	2020-05-05	166	18	58	90	f	f
3093	Liberia	2020-05-05	2020-05-06	170	20	58	92	f	f
3094	Liberia	2020-05-06	2020-05-07	178	20	75	83	f	f
3095	Liberia	2020-05-07	2020-05-08	189	20	79	90	f	f
3096	Liberia	2020-05-08	2020-05-09	199	20	79	100	f	f
3097	Liberia	2020-05-09	2020-05-10	199	20	79	100	f	f
3098	Liberia	2020-05-10	2020-05-11	199	20	79	100	f	f
3099	Liberia	2020-05-11	2020-05-12	211	20	85	106	f	f
3100	Liberia	2020-05-12	2020-05-13	211	20	85	106	f	f
3101	Liberia	2020-05-13	2020-05-14	213	20	101	92	f	f
3102	Liberia	2020-05-14	2020-05-15	215	20	105	90	f	f
3103	Liberia	2020-05-15	2020-05-16	219	20	108	91	f	f
3104	Liberia	2020-05-16	2020-05-17	223	20	116	87	f	f
3105	Liberia	2020-05-17	2020-05-18	226	21	120	85	f	f
3106	Liberia	2020-05-18	2020-05-19	229	22	123	84	f	f
3107	Liberia	2020-05-19	2020-05-20	233	23	125	85	f	f
3108	Liberia	2020-05-20	2020-05-21	238	23	128	87	f	f
3109	Liberia	2020-05-21	2020-05-22	240	23	131	86	f	f
3110	Liberia	2020-05-22	2020-05-23	249	24	136	89	f	f
3111	Liberia	2020-05-23	2020-05-24	255	26	136	93	f	f
3112	Liberia	2020-05-24	2020-05-25	265	26	139	100	f	f
3113	Liberia	2020-05-25	2020-05-26	265	26	141	98	f	f
3114	Liberia	2020-05-26	2020-05-27	266	26	144	96	f	f
3115	Liberia	2020-05-27	2020-05-28	266	27	144	95	f	f
3116	Liberia	2020-05-28	2020-05-29	269	27	144	98	f	f
3117	Liberia	2020-05-29	2020-05-30	273	27	146	100	f	f
3118	Liberia	2020-05-30	2020-05-31	280	27	148	105	f	f
3119	Liberia	2020-05-31	2020-06-01	288	27	157	104	f	f
3120	Libya	2020-05-01	2020-05-02	63	3	18	42	f	f
3121	Libya	2020-05-02	2020-05-03	63	3	22	38	f	f
3122	Libya	2020-05-03	2020-05-04	63	3	22	38	f	f
3123	Libya	2020-05-04	2020-05-05	63	3	23	37	f	f
3124	Libya	2020-05-05	2020-05-06	63	3	23	37	f	f
3125	Libya	2020-05-06	2020-05-07	64	3	24	37	f	f
3126	Libya	2020-05-07	2020-05-08	64	3	24	37	f	f
3127	Libya	2020-05-08	2020-05-09	64	3	24	37	f	f
3128	Libya	2020-05-09	2020-05-10	64	3	24	37	f	f
3129	Libya	2020-05-10	2020-05-11	64	3	24	37	f	f
3130	Libya	2020-05-11	2020-05-12	64	3	28	33	f	f
3131	Libya	2020-05-12	2020-05-13	64	3	28	33	f	f
3132	Libya	2020-05-13	2020-05-14	64	3	28	33	f	f
3133	Libya	2020-05-14	2020-05-15	64	3	28	33	f	f
3134	Libya	2020-05-15	2020-05-16	64	3	28	33	f	f
3135	Libya	2020-05-16	2020-05-17	65	3	28	34	f	f
3136	Libya	2020-05-17	2020-05-18	65	3	35	27	f	f
3137	Libya	2020-05-18	2020-05-19	65	3	35	27	f	f
3138	Libya	2020-05-19	2020-05-20	68	3	35	30	f	f
3139	Libya	2020-05-20	2020-05-21	69	3	35	31	f	f
3140	Libya	2020-05-21	2020-05-22	71	3	35	33	f	f
3141	Libya	2020-05-22	2020-05-23	72	3	38	31	f	f
3142	Libya	2020-05-23	2020-05-24	75	3	39	33	f	f
3143	Libya	2020-05-24	2020-05-25	75	3	39	33	f	f
3144	Libya	2020-05-25	2020-05-26	75	3	40	32	f	f
3145	Libya	2020-05-26	2020-05-27	77	3	40	34	f	f
3146	Libya	2020-05-27	2020-05-28	99	4	40	55	f	f
3147	Libya	2020-05-28	2020-05-29	105	5	41	59	f	f
3148	Libya	2020-05-29	2020-05-30	118	5	41	72	f	f
3149	Libya	2020-05-30	2020-05-31	130	5	50	75	f	f
3150	Libya	2020-05-31	2020-06-01	156	5	52	99	f	f
3151	Liechtenstein	2020-05-01	2020-05-02	82	1	55	26	f	f
3152	Liechtenstein	2020-05-02	2020-05-03	82	1	55	26	f	f
3153	Liechtenstein	2020-05-03	2020-05-04	82	1	55	26	f	f
3154	Liechtenstein	2020-05-04	2020-05-05	82	1	55	26	f	f
3155	Liechtenstein	2020-05-05	2020-05-06	82	1	55	26	f	f
3156	Liechtenstein	2020-05-06	2020-05-07	82	1	55	26	f	f
3157	Liechtenstein	2020-05-07	2020-05-08	82	1	55	26	f	f
3158	Liechtenstein	2020-05-08	2020-05-09	82	1	55	26	f	f
3159	Liechtenstein	2020-05-09	2020-05-10	82	1	55	26	f	f
3160	Liechtenstein	2020-05-10	2020-05-11	82	1	55	26	f	f
3161	Liechtenstein	2020-05-11	2020-05-12	82	1	55	26	f	f
3162	Liechtenstein	2020-05-12	2020-05-13	82	1	55	26	f	f
3163	Liechtenstein	2020-05-13	2020-05-14	82	1	55	26	f	f
3164	Liechtenstein	2020-05-14	2020-05-15	82	1	55	26	f	f
3165	Liechtenstein	2020-05-15	2020-05-16	82	1	55	26	f	f
3166	Liechtenstein	2020-05-16	2020-05-17	82	1	55	26	f	f
3167	Liechtenstein	2020-05-17	2020-05-18	82	1	55	26	f	f
3168	Liechtenstein	2020-05-18	2020-05-19	82	1	55	26	f	f
3169	Liechtenstein	2020-05-19	2020-05-20	82	1	55	26	f	f
3170	Liechtenstein	2020-05-20	2020-05-21	82	1	55	26	f	f
3171	Liechtenstein	2020-05-21	2020-05-22	82	1	55	26	f	f
3172	Liechtenstein	2020-05-22	2020-05-23	82	1	55	26	f	f
3173	Liechtenstein	2020-05-23	2020-05-24	82	1	55	26	f	f
3174	Liechtenstein	2020-05-24	2020-05-25	82	1	55	26	f	f
3175	Liechtenstein	2020-05-25	2020-05-26	82	1	55	26	f	f
3176	Liechtenstein	2020-05-26	2020-05-27	82	1	55	26	f	f
3177	Liechtenstein	2020-05-27	2020-05-28	82	1	55	26	f	f
3178	Liechtenstein	2020-05-28	2020-05-29	82	1	55	26	f	f
3179	Liechtenstein	2020-05-29	2020-05-30	82	1	55	26	f	f
3180	Liechtenstein	2020-05-30	2020-05-31	82	1	55	26	f	f
3181	Liechtenstein	2020-05-31	2020-06-01	82	1	55	26	f	f
3182	Lithuania	2020-05-01	2020-05-02	1389	32	615	760	f	f
3183	Lithuania	2020-05-02	2020-05-03	1394	33	644	728	f	f
3184	Lithuania	2020-05-03	2020-05-04	1399	33	686	729	f	f
3185	Lithuania	2020-05-04	2020-05-05	1407	33	715	735	f	f
3186	Lithuania	2020-05-05	2020-05-06	1410	33	761	699	f	f
3187	Lithuania	2020-05-06	2020-05-07	1416	34	804	662	f	f
3188	Lithuania	2020-05-07	2020-05-08	1421	35	858	645	f	f
3189	Lithuania	2020-05-08	2020-05-09	1430	35	888	622	f	f
3190	Lithuania	2020-05-09	2020-05-10	1459	35	905	567	f	f
3191	Lithuania	2020-05-10	2020-05-11	1471	36	927	601	f	f
3192	Lithuania	2020-05-11	2020-05-12	1479	36	946	602	f	f
3193	Lithuania	2020-05-12	2020-05-13	1488	39	969	591	f	f
3194	Lithuania	2020-05-13	2020-05-14	1502	39	989	543	f	f
3195	Lithuania	2020-05-14	2020-05-15	1511	39	1049	523	f	f
3196	Lithuania	2020-05-15	2020-05-16	1521	41	1096	504	f	f
3197	Lithuania	2020-05-16	2020-05-17	1536	42	1119	491	f	f
3198	Lithuania	2020-05-17	2020-05-18	1545	43	1134	488	f	f
3199	Lithuania	2020-05-18	2020-05-19	1551	45	1156	491	f	f
3200	Lithuania	2020-05-19	2020-05-20	1559	45	1174	477	f	f
3201	Lithuania	2020-05-20	2020-05-21	1580	46	1181	468	f	f
3202	Lithuania	2020-05-21	2020-05-22	1592	46	1189	483	f	f
3203	Lithuania	2020-05-22	2020-05-23	1598	46	1198	432	f	f
3204	Lithuania	2020-05-23	2020-05-24	1612	47	1209	418	f	f
3205	Lithuania	2020-05-24	2020-05-25	1618	48	1212	422	f	f
3206	Lithuania	2020-05-25	2020-05-26	1628	49	1241	434	f	f
3207	Lithuania	2020-05-26	2020-05-27	1632	51	1256	409	f	f
3208	Lithuania	2020-05-27	2020-05-28	1640	51	1260	397	f	f
3209	Lithuania	2020-05-28	2020-05-29	1649	52	1266	395	f	f
3210	Lithuania	2020-05-29	2020-05-30	1654	52	1269	378	f	f
3211	Lithuania	2020-05-30	2020-05-31	1662	54	1274	371	f	f
3212	Lithuania	2020-05-31	2020-06-01	1667	54	1279	369	f	f
3213	Luxembourg	2020-05-01	2020-05-02	3802	92	3213	497	f	f
3214	Luxembourg	2020-05-02	2020-05-03	3812	92	3318	402	f	f
3215	Luxembourg	2020-05-03	2020-05-04	3824	96	3379	349	f	f
3216	Luxembourg	2020-05-04	2020-05-05	3828	96	3405	327	f	f
3217	Luxembourg	2020-05-05	2020-05-06	3840	96	3412	332	f	f
3218	Luxembourg	2020-05-06	2020-05-07	3851	98	3452	301	f	f
3219	Luxembourg	2020-05-07	2020-05-08	3859	100	3505	254	f	f
3220	Luxembourg	2020-05-08	2020-05-09	3871	100	3526	245	f	f
3221	Luxembourg	2020-05-09	2020-05-10	3877	101	3550	226	f	f
3222	Luxembourg	2020-05-10	2020-05-11	3886	101	3586	199	f	f
3223	Luxembourg	2020-05-11	2020-05-12	3888	101	3602	185	f	f
3224	Luxembourg	2020-05-12	2020-05-13	3894	102	3610	182	f	f
3225	Luxembourg	2020-05-13	2020-05-14	3904	103	3629	172	f	f
3226	Luxembourg	2020-05-14	2020-05-15	3915	103	3665	147	f	f
3227	Luxembourg	2020-05-15	2020-05-16	3923	104	3682	137	f	f
3228	Luxembourg	2020-05-16	2020-05-17	3930	104	3699	127	f	f
3229	Luxembourg	2020-05-17	2020-05-18	3945	107	3702	136	f	f
3230	Luxembourg	2020-05-18	2020-05-19	3947	107	3715	125	f	f
3231	Luxembourg	2020-05-19	2020-05-20	3958	109	3718	131	f	f
3232	Luxembourg	2020-05-20	2020-05-21	3971	109	3728	134	f	f
3233	Luxembourg	2020-05-21	2020-05-22	3980	109	3741	130	f	f
3234	Luxembourg	2020-05-22	2020-05-23	3981	109	3748	124	f	f
3235	Luxembourg	2020-05-23	2020-05-24	3990	109	3758	123	f	f
3236	Luxembourg	2020-05-24	2020-05-25	3992	110	3767	115	f	f
3237	Luxembourg	2020-05-25	2020-05-26	3993	110	3781	102	f	f
3238	Luxembourg	2020-05-26	2020-05-27	3995	110	3783	102	f	f
3239	Luxembourg	2020-05-27	2020-05-28	4001	110	3791	100	f	f
3240	Luxembourg	2020-05-28	2020-05-29	4008	110	3803	95	f	f
3241	Luxembourg	2020-05-29	2020-05-30	4012	110	3815	87	f	f
3242	Luxembourg	2020-05-30	2020-05-31	4016	110	3815	91	f	f
3243	Luxembourg	2020-05-31	2020-06-01	4018	110	3833	75	f	f
3244	MS Zaandam	2020-05-01	2020-05-02	9	2	0	7	f	f
3245	MS Zaandam	2020-05-02	2020-05-03	9	2	0	7	f	f
3246	MS Zaandam	2020-05-03	2020-05-04	9	2	0	7	f	f
3247	MS Zaandam	2020-05-04	2020-05-05	9	2	0	7	f	f
3248	MS Zaandam	2020-05-05	2020-05-06	9	2	0	7	f	f
3249	MS Zaandam	2020-05-06	2020-05-07	9	2	0	7	f	f
3250	MS Zaandam	2020-05-07	2020-05-08	9	2	0	7	f	f
3251	MS Zaandam	2020-05-08	2020-05-09	9	2	0	7	f	f
3252	MS Zaandam	2020-05-09	2020-05-10	9	2	0	7	f	f
3253	MS Zaandam	2020-05-10	2020-05-11	9	2	0	7	f	f
3254	MS Zaandam	2020-05-11	2020-05-12	9	2	0	7	f	f
3255	MS Zaandam	2020-05-12	2020-05-13	9	2	0	7	f	f
3256	MS Zaandam	2020-05-13	2020-05-14	9	2	0	7	f	f
3257	MS Zaandam	2020-05-14	2020-05-15	9	2	0	7	f	f
3258	MS Zaandam	2020-05-15	2020-05-16	9	2	0	7	f	f
3259	MS Zaandam	2020-05-16	2020-05-17	9	2	0	7	f	f
3260	MS Zaandam	2020-05-17	2020-05-18	9	2	0	7	f	f
3261	MS Zaandam	2020-05-18	2020-05-19	9	2	0	7	f	f
3262	MS Zaandam	2020-05-19	2020-05-20	9	2	0	7	f	f
3263	MS Zaandam	2020-05-20	2020-05-21	9	2	0	7	f	f
3264	MS Zaandam	2020-05-21	2020-05-22	9	2	0	7	f	f
3265	MS Zaandam	2020-05-22	2020-05-23	9	2	0	7	f	f
3266	MS Zaandam	2020-05-23	2020-05-24	9	2	0	7	f	f
3267	MS Zaandam	2020-05-24	2020-05-25	9	2	0	7	f	f
3268	MS Zaandam	2020-05-25	2020-05-26	9	2	0	7	f	f
3269	MS Zaandam	2020-05-26	2020-05-27	9	2	0	7	f	f
3270	MS Zaandam	2020-05-27	2020-05-28	9	2	0	7	f	f
3271	MS Zaandam	2020-05-28	2020-05-29	9	2	0	7	f	f
3272	MS Zaandam	2020-05-29	2020-05-30	9	2	0	7	f	f
3273	MS Zaandam	2020-05-30	2020-05-31	9	2	0	7	f	f
3274	MS Zaandam	2020-05-31	2020-06-01	9	2	0	7	f	f
3275	Madagascar	2020-05-01	2020-05-02	132	0	94	38	f	f
3276	Madagascar	2020-05-02	2020-05-03	135	0	97	38	f	f
3277	Madagascar	2020-05-03	2020-05-04	149	0	98	51	f	f
3278	Madagascar	2020-05-04	2020-05-05	149	0	99	50	f	f
3279	Madagascar	2020-05-05	2020-05-06	151	0	101	50	f	f
3280	Madagascar	2020-05-06	2020-05-07	158	0	101	57	f	f
3281	Madagascar	2020-05-07	2020-05-08	193	0	101	92	f	f
3282	Madagascar	2020-05-08	2020-05-09	193	0	101	92	f	f
3283	Madagascar	2020-05-09	2020-05-10	193	0	101	92	f	f
3284	Madagascar	2020-05-10	2020-05-11	193	0	101	92	f	f
3285	Madagascar	2020-05-11	2020-05-12	186	0	101	85	f	f
3286	Madagascar	2020-05-12	2020-05-13	186	0	101	85	f	f
3287	Madagascar	2020-05-13	2020-05-14	212	0	107	105	f	f
3288	Madagascar	2020-05-14	2020-05-15	230	0	108	122	f	f
3289	Madagascar	2020-05-15	2020-05-16	238	0	112	126	f	f
3290	Madagascar	2020-05-16	2020-05-17	283	0	114	169	f	f
3291	Madagascar	2020-05-17	2020-05-18	304	1	114	189	f	f
3292	Madagascar	2020-05-18	2020-05-19	322	1	119	202	f	f
3293	Madagascar	2020-05-19	2020-05-20	326	2	119	205	f	f
3294	Madagascar	2020-05-20	2020-05-21	371	2	131	238	f	f
3295	Madagascar	2020-05-21	2020-05-22	405	2	131	272	f	f
3296	Madagascar	2020-05-22	2020-05-23	448	2	135	311	f	f
3297	Madagascar	2020-05-23	2020-05-24	488	2	138	348	f	f
3298	Madagascar	2020-05-24	2020-05-25	527	2	142	383	f	f
3299	Madagascar	2020-05-25	2020-05-26	542	2	147	393	f	f
3300	Madagascar	2020-05-26	2020-05-27	586	2	147	437	f	f
3301	Madagascar	2020-05-27	2020-05-28	612	2	151	459	f	f
3302	Madagascar	2020-05-28	2020-05-29	656	2	154	500	f	f
3303	Madagascar	2020-05-29	2020-05-30	698	5	164	529	f	f
3304	Madagascar	2020-05-30	2020-05-31	758	6	165	587	f	f
3305	Madagascar	2020-05-31	2020-06-01	771	6	168	597	f	f
3306	Malawi	2020-05-01	2020-05-02	37	3	9	25	f	f
3307	Malawi	2020-05-02	2020-05-03	38	3	9	26	f	f
3308	Malawi	2020-05-03	2020-05-04	39	3	9	27	f	f
3309	Malawi	2020-05-04	2020-05-05	41	3	9	29	f	f
3310	Malawi	2020-05-05	2020-05-06	41	3	9	29	f	f
3311	Malawi	2020-05-06	2020-05-07	43	3	9	31	f	f
3312	Malawi	2020-05-07	2020-05-08	43	3	14	26	f	f
3313	Malawi	2020-05-08	2020-05-09	43	3	14	26	f	f
3314	Malawi	2020-05-09	2020-05-10	56	3	14	39	f	f
3315	Malawi	2020-05-10	2020-05-11	56	3	14	39	f	f
3316	Malawi	2020-05-11	2020-05-12	57	3	24	30	f	f
3317	Malawi	2020-05-12	2020-05-13	57	3	24	30	f	f
3318	Malawi	2020-05-13	2020-05-14	63	3	24	36	f	f
3319	Malawi	2020-05-14	2020-05-15	63	3	24	36	f	f
3320	Malawi	2020-05-15	2020-05-16	63	3	24	36	f	f
3321	Malawi	2020-05-16	2020-05-17	65	3	24	38	f	f
3322	Malawi	2020-05-17	2020-05-18	70	3	27	40	f	f
3323	Malawi	2020-05-18	2020-05-19	70	3	27	40	f	f
3324	Malawi	2020-05-19	2020-05-20	70	3	27	40	f	f
3325	Malawi	2020-05-20	2020-05-21	71	3	27	41	f	f
3326	Malawi	2020-05-21	2020-05-22	72	3	27	42	f	f
3327	Malawi	2020-05-22	2020-05-23	82	3	28	51	f	f
3328	Malawi	2020-05-23	2020-05-24	82	3	28	51	f	f
3329	Malawi	2020-05-24	2020-05-25	83	4	33	46	f	f
3330	Malawi	2020-05-25	2020-05-26	101	4	33	64	f	f
3331	Malawi	2020-05-26	2020-05-27	101	4	37	60	f	f
3332	Malawi	2020-05-27	2020-05-28	101	4	37	60	f	f
3333	Malawi	2020-05-28	2020-05-29	203	4	37	162	f	f
3334	Malawi	2020-05-29	2020-05-30	273	4	42	227	f	f
3335	Malawi	2020-05-30	2020-05-31	279	4	42	233	f	f
3336	Malawi	2020-05-31	2020-06-01	284	4	42	238	f	f
3337	Malaysia	2020-05-01	2020-05-02	6071	103	4210	1758	f	f
3338	Malaysia	2020-05-02	2020-05-03	6176	103	4326	1747	f	f
3339	Malaysia	2020-05-03	2020-05-04	6298	105	4413	1780	f	f
3340	Malaysia	2020-05-04	2020-05-05	6353	105	4484	1764	f	f
3341	Malaysia	2020-05-05	2020-05-06	6383	106	4567	1710	f	f
3342	Malaysia	2020-05-06	2020-05-07	6428	107	4702	1619	f	f
3343	Malaysia	2020-05-07	2020-05-08	6467	107	4776	1584	f	f
3344	Malaysia	2020-05-08	2020-05-09	6535	107	4864	1564	f	f
3345	Malaysia	2020-05-09	2020-05-10	6589	108	4929	1552	f	f
3346	Malaysia	2020-05-10	2020-05-11	6656	108	5025	1523	f	f
3347	Malaysia	2020-05-11	2020-05-12	6726	109	5113	1504	f	f
3348	Malaysia	2020-05-12	2020-05-13	6742	109	5223	1410	f	f
3349	Malaysia	2020-05-13	2020-05-14	6779	111	5281	1387	f	f
3350	Malaysia	2020-05-14	2020-05-15	6819	112	5351	1356	f	f
3351	Malaysia	2020-05-15	2020-05-16	6855	112	5439	1304	f	f
3352	Malaysia	2020-05-16	2020-05-17	6872	113	5512	1247	f	f
3353	Malaysia	2020-05-17	2020-05-18	6894	113	5571	1210	f	f
3354	Malaysia	2020-05-18	2020-05-19	6941	113	5615	1213	f	f
3355	Malaysia	2020-05-19	2020-05-20	6978	114	5646	1218	f	f
3356	Malaysia	2020-05-20	2020-05-21	7009	114	5706	1189	f	f
3357	Malaysia	2020-05-21	2020-05-22	7059	114	5796	1149	f	f
3358	Malaysia	2020-05-22	2020-05-23	7137	115	5859	1163	f	f
3359	Malaysia	2020-05-23	2020-05-24	7185	115	5912	1158	f	f
3360	Malaysia	2020-05-24	2020-05-25	7245	115	5945	1185	f	f
3361	Malaysia	2020-05-25	2020-05-26	7417	115	5979	1323	f	f
3362	Malaysia	2020-05-26	2020-05-27	7604	115	6041	1448	f	f
3363	Malaysia	2020-05-27	2020-05-28	7619	115	6083	1421	f	f
3364	Malaysia	2020-05-28	2020-05-29	7629	115	6169	1345	f	f
3365	Malaysia	2020-05-29	2020-05-30	7732	115	6235	1382	f	f
3366	Malaysia	2020-05-30	2020-05-31	7762	115	6330	1317	f	f
3367	Malaysia	2020-05-31	2020-06-01	7819	115	6353	1351	f	f
3368	Maldives	2020-05-01	2020-05-02	491	1	17	473	f	f
3369	Maldives	2020-05-02	2020-05-03	519	1	18	500	f	f
3370	Maldives	2020-05-03	2020-05-04	527	1	18	508	f	f
3371	Maldives	2020-05-04	2020-05-05	541	1	18	522	f	f
3372	Maldives	2020-05-05	2020-05-06	573	2	20	551	f	f
3373	Maldives	2020-05-06	2020-05-07	617	2	20	595	f	f
3374	Maldives	2020-05-07	2020-05-08	648	3	20	625	f	f
3375	Maldives	2020-05-08	2020-05-09	744	3	20	721	f	f
3376	Maldives	2020-05-09	2020-05-10	790	3	29	758	f	f
3377	Maldives	2020-05-10	2020-05-11	835	3	29	803	f	f
3378	Maldives	2020-05-11	2020-05-12	897	3	29	865	f	f
3379	Maldives	2020-05-12	2020-05-13	904	3	29	872	f	f
3380	Maldives	2020-05-13	2020-05-14	955	4	40	911	f	f
3381	Maldives	2020-05-14	2020-05-15	982	4	45	933	f	f
3382	Maldives	2020-05-15	2020-05-16	1031	4	49	978	f	f
3383	Maldives	2020-05-16	2020-05-17	1078	4	58	1016	f	f
3384	Maldives	2020-05-17	2020-05-18	1094	4	58	1032	f	f
3385	Maldives	2020-05-18	2020-05-19	1106	4	58	1044	f	f
3386	Maldives	2020-05-19	2020-05-20	1143	4	91	1048	f	f
3387	Maldives	2020-05-20	2020-05-21	1186	4	91	1091	f	f
3388	Maldives	2020-05-21	2020-05-22	1216	4	91	1121	f	f
3389	Maldives	2020-05-22	2020-05-23	1274	4	109	1161	f	f
3390	Maldives	2020-05-23	2020-05-24	1313	4	128	1181	f	f
3391	Maldives	2020-05-24	2020-05-25	1371	4	144	1223	f	f
3392	Maldives	2020-05-25	2020-05-26	1395	4	155	1236	f	f
3393	Maldives	2020-05-26	2020-05-27	1438	5	197	1236	f	f
3394	Maldives	2020-05-27	2020-05-28	1457	5	197	1255	f	f
3395	Maldives	2020-05-28	2020-05-29	1513	5	197	1311	f	f
3396	Maldives	2020-05-29	2020-05-30	1591	5	197	1389	f	f
3397	Maldives	2020-05-30	2020-05-31	1672	5	406	1261	f	f
3398	Maldives	2020-05-31	2020-06-01	1773	5	453	1315	f	f
3399	Mali	2020-05-01	2020-05-02	508	26	196	286	f	f
3400	Mali	2020-05-02	2020-05-03	544	26	206	312	f	f
3401	Mali	2020-05-03	2020-05-04	563	27	213	323	f	f
3402	Mali	2020-05-04	2020-05-05	580	29	223	328	f	f
3403	Mali	2020-05-05	2020-05-06	612	32	228	352	f	f
3404	Mali	2020-05-06	2020-05-07	631	32	261	338	f	f
3405	Mali	2020-05-07	2020-05-08	650	32	271	347	f	f
3406	Mali	2020-05-08	2020-05-09	668	35	285	348	f	f
3407	Mali	2020-05-09	2020-05-10	692	37	298	357	f	f
3408	Mali	2020-05-10	2020-05-11	704	38	351	315	f	f
3409	Mali	2020-05-11	2020-05-12	712	39	377	296	f	f
3410	Mali	2020-05-12	2020-05-13	730	40	398	292	f	f
3411	Mali	2020-05-13	2020-05-14	758	44	412	302	f	f
3412	Mali	2020-05-14	2020-05-15	779	46	436	297	f	f
3413	Mali	2020-05-15	2020-05-16	806	46	455	305	f	f
3414	Mali	2020-05-16	2020-05-17	835	48	479	308	f	f
3415	Mali	2020-05-17	2020-05-18	860	52	494	314	f	f
3416	Mali	2020-05-18	2020-05-19	874	52	512	310	f	f
3417	Mali	2020-05-19	2020-05-20	901	53	529	319	f	f
3418	Mali	2020-05-20	2020-05-21	931	55	543	333	f	f
3419	Mali	2020-05-21	2020-05-22	947	60	558	329	f	f
3420	Mali	2020-05-22	2020-05-23	969	62	560	347	f	f
3421	Mali	2020-05-23	2020-05-24	1015	63	574	378	f	f
3422	Mali	2020-05-24	2020-05-25	1030	65	597	368	f	f
3423	Mali	2020-05-25	2020-05-26	1059	67	604	388	f	f
3424	Mali	2020-05-26	2020-05-27	1077	70	617	390	f	f
3425	Mali	2020-05-27	2020-05-28	1116	70	632	414	f	f
3426	Mali	2020-05-28	2020-05-29	1194	72	652	470	f	f
3427	Mali	2020-05-29	2020-05-30	1226	73	669	484	f	f
3428	Mali	2020-05-30	2020-05-31	1250	76	696	478	f	f
3429	Mali	2020-05-31	2020-06-01	1265	77	716	472	f	f
3430	Malta	2020-05-01	2020-05-02	467	4	383	80	f	f
3431	Malta	2020-05-02	2020-05-03	468	4	379	85	f	f
3432	Malta	2020-05-03	2020-05-04	477	4	392	81	f	f
3433	Malta	2020-05-04	2020-05-05	480	4	399	77	f	f
3434	Malta	2020-05-05	2020-05-06	482	5	403	74	f	f
3435	Malta	2020-05-06	2020-05-07	484	5	407	72	f	f
3436	Malta	2020-05-07	2020-05-08	486	5	413	68	f	f
3437	Malta	2020-05-08	2020-05-09	489	5	419	65	f	f
3438	Malta	2020-05-09	2020-05-10	490	5	427	58	f	f
3439	Malta	2020-05-10	2020-05-11	496	5	433	58	f	f
3440	Malta	2020-05-11	2020-05-12	503	5	434	64	f	f
3441	Malta	2020-05-12	2020-05-13	506	5	434	67	f	f
3442	Malta	2020-05-13	2020-05-14	508	6	436	66	f	f
3443	Malta	2020-05-14	2020-05-15	522	6	443	73	f	f
3444	Malta	2020-05-15	2020-05-16	532	6	458	68	f	f
3445	Malta	2020-05-16	2020-05-17	546	6	450	90	f	f
3446	Malta	2020-05-17	2020-05-18	553	6	454	93	f	f
3447	Malta	2020-05-18	2020-05-19	558	6	456	96	f	f
3448	Malta	2020-05-19	2020-05-20	569	6	460	103	f	f
3449	Malta	2020-05-20	2020-05-21	584	6	465	113	f	f
3450	Malta	2020-05-21	2020-05-22	599	6	468	125	f	f
3451	Malta	2020-05-22	2020-05-23	600	6	469	125	f	f
3452	Malta	2020-05-23	2020-05-24	609	6	473	130	f	f
3453	Malta	2020-05-24	2020-05-25	610	6	476	128	f	f
3454	Malta	2020-05-25	2020-05-26	611	6	485	120	f	f
3455	Malta	2020-05-26	2020-05-27	611	6	485	120	f	f
3456	Malta	2020-05-27	2020-05-28	612	7	491	114	f	f
3457	Malta	2020-05-28	2020-05-29	616	7	501	108	f	f
3458	Malta	2020-05-29	2020-05-30	616	9	514	93	f	f
3459	Malta	2020-05-30	2020-05-31	618	9	525	84	f	f
3460	Malta	2020-05-31	2020-06-01	618	9	534	75	f	f
3461	Mauritania	2020-05-01	2020-05-02	8	1	6	1	f	f
3462	Mauritania	2020-05-02	2020-05-03	8	1	6	1	f	f
3463	Mauritania	2020-05-03	2020-05-04	8	1	6	1	f	f
3464	Mauritania	2020-05-04	2020-05-05	8	1	6	1	f	f
3465	Mauritania	2020-05-05	2020-05-06	8	1	6	1	f	f
3466	Mauritania	2020-05-06	2020-05-07	8	1	6	1	f	f
3467	Mauritania	2020-05-07	2020-05-08	8	1	6	1	f	f
3468	Mauritania	2020-05-08	2020-05-09	8	1	6	1	f	f
3469	Mauritania	2020-05-09	2020-05-10	8	1	6	1	f	f
3470	Mauritania	2020-05-10	2020-05-11	8	1	6	1	f	f
3471	Mauritania	2020-05-11	2020-05-12	8	1	6	1	f	f
3472	Mauritania	2020-05-12	2020-05-13	9	1	6	2	f	f
3473	Mauritania	2020-05-13	2020-05-14	15	2	6	7	f	f
3474	Mauritania	2020-05-14	2020-05-15	20	2	7	11	f	f
3475	Mauritania	2020-05-15	2020-05-16	29	3	7	19	f	f
3476	Mauritania	2020-05-16	2020-05-17	40	4	7	29	f	f
3477	Mauritania	2020-05-17	2020-05-18	62	4	7	51	f	f
3478	Mauritania	2020-05-18	2020-05-19	81	4	7	70	f	f
3479	Mauritania	2020-05-19	2020-05-20	131	4	7	120	f	f
3480	Mauritania	2020-05-20	2020-05-21	141	4	7	130	f	f
3481	Mauritania	2020-05-21	2020-05-22	173	5	7	161	f	f
3482	Mauritania	2020-05-22	2020-05-23	200	6	7	187	f	f
3483	Mauritania	2020-05-23	2020-05-24	227	6	7	214	f	f
3484	Mauritania	2020-05-24	2020-05-25	237	6	15	216	f	f
3485	Mauritania	2020-05-25	2020-05-26	262	9	15	238	f	f
3486	Mauritania	2020-05-26	2020-05-27	268	13	15	240	f	f
3487	Mauritania	2020-05-27	2020-05-28	292	16	15	261	f	f
3488	Mauritania	2020-05-28	2020-05-29	346	19	15	312	f	f
3489	Mauritania	2020-05-29	2020-05-30	423	20	21	382	f	f
3490	Mauritania	2020-05-30	2020-05-31	483	20	21	442	f	f
3491	Mauritania	2020-05-31	2020-06-01	530	23	27	480	f	f
3492	Mauritius	2020-05-01	2020-05-02	332	10	312	10	f	f
3493	Mauritius	2020-05-02	2020-05-03	332	10	314	8	f	f
3494	Mauritius	2020-05-03	2020-05-04	332	10	315	7	f	f
3495	Mauritius	2020-05-04	2020-05-05	332	10	316	6	f	f
3496	Mauritius	2020-05-05	2020-05-06	332	10	319	3	f	f
3497	Mauritius	2020-05-06	2020-05-07	332	10	320	2	f	f
3498	Mauritius	2020-05-07	2020-05-08	332	10	320	2	f	f
3499	Mauritius	2020-05-08	2020-05-09	332	10	320	2	f	f
3500	Mauritius	2020-05-09	2020-05-10	332	10	320	2	f	f
3501	Mauritius	2020-05-10	2020-05-11	332	10	320	2	f	f
3502	Mauritius	2020-05-11	2020-05-12	332	10	322	0	f	f
3503	Mauritius	2020-05-12	2020-05-13	332	10	322	0	f	f
3504	Mauritius	2020-05-13	2020-05-14	332	10	322	0	f	f
3505	Mauritius	2020-05-14	2020-05-15	332	10	322	0	f	f
3506	Mauritius	2020-05-15	2020-05-16	332	10	322	0	f	f
3507	Mauritius	2020-05-16	2020-05-17	332	10	322	0	f	f
3508	Mauritius	2020-05-17	2020-05-18	332	10	322	0	f	f
3509	Mauritius	2020-05-18	2020-05-19	332	10	322	0	f	f
3510	Mauritius	2020-05-19	2020-05-20	332	10	322	0	f	f
3511	Mauritius	2020-05-20	2020-05-21	332	10	322	0	f	f
3512	Mauritius	2020-05-21	2020-05-22	332	10	322	0	f	f
3513	Mauritius	2020-05-22	2020-05-23	332	10	322	0	f	f
3514	Mauritius	2020-05-23	2020-05-24	332	10	322	0	f	f
3515	Mauritius	2020-05-24	2020-05-25	334	10	322	2	f	f
3516	Mauritius	2020-05-25	2020-05-26	334	10	322	2	f	f
3517	Mauritius	2020-05-26	2020-05-27	334	10	322	2	f	f
3518	Mauritius	2020-05-27	2020-05-28	334	10	322	2	f	f
3519	Mauritius	2020-05-28	2020-05-29	334	10	322	2	f	f
3520	Mauritius	2020-05-29	2020-05-30	335	10	322	3	f	f
3521	Mauritius	2020-05-30	2020-05-31	335	10	322	3	f	f
3522	Mauritius	2020-05-31	2020-06-01	335	10	322	3	f	f
3523	Mexico	2020-05-01	2020-05-02	20739	1972	12377	6390	f	f
3524	Mexico	2020-05-02	2020-05-03	22088	2061	12377	7650	f	f
3525	Mexico	2020-05-03	2020-05-04	23471	2154	13447	7870	f	f
3526	Mexico	2020-05-04	2020-05-05	24905	2271	13447	9187	f	f
3527	Mexico	2020-05-05	2020-05-06	26025	2507	16810	6708	f	f
3528	Mexico	2020-05-06	2020-05-07	27634	2704	17781	7149	f	f
3529	Mexico	2020-05-07	2020-05-08	29616	2961	17781	8874	f	f
3530	Mexico	2020-05-08	2020-05-09	31522	3160	20314	8048	f	f
3531	Mexico	2020-05-09	2020-05-10	33460	3353	21824	8283	f	f
3532	Mexico	2020-05-10	2020-05-11	35022	3465	21824	9733	f	f
3533	Mexico	2020-05-11	2020-05-12	36327	3573	23100	9654	f	f
3534	Mexico	2020-05-12	2020-05-13	38324	3926	25935	8463	f	f
3535	Mexico	2020-05-13	2020-05-14	40186	4220	26990	8976	f	f
3536	Mexico	2020-05-14	2020-05-15	42595	4477	28475	9643	f	f
3537	Mexico	2020-05-15	2020-05-16	45032	4767	30451	9814	f	f
3538	Mexico	2020-05-16	2020-05-17	47144	5045	31848	10251	f	f
3539	Mexico	2020-05-17	2020-05-18	49219	5177	33329	10713	f	f
3540	Mexico	2020-05-18	2020-05-19	51633	5332	35388	10913	f	f
3541	Mexico	2020-05-19	2020-05-20	54346	5666	37325	11355	f	f
3542	Mexico	2020-05-20	2020-05-21	56594	6090	38419	12085	f	f
3543	Mexico	2020-05-21	2020-05-22	59567	6510	40152	12905	f	f
3544	Mexico	2020-05-22	2020-05-23	62527	6989	42191	13347	f	f
3545	Mexico	2020-05-23	2020-05-24	65856	7179	44424	14253	f	f
3546	Mexico	2020-05-24	2020-05-25	68620	7394	46979	14247	f	f
3547	Mexico	2020-05-25	2020-05-26	71105	7633	49452	14020	f	f
3548	Mexico	2020-05-26	2020-05-27	74560	8134	51708	14718	f	f
3549	Mexico	2020-05-27	2020-05-28	78023	8597	53834	15592	f	f
3550	Mexico	2020-05-28	2020-05-29	81400	9044	56041	16315	f	f
3551	Mexico	2020-05-29	2020-05-30	84627	9415	59003	16209	f	f
3552	Mexico	2020-05-30	2020-05-31	87512	9779	61247	16486	f	f
3553	Mexico	2020-05-31	2020-06-01	90664	9930	63772	16962	f	f
3554	Moldova	2020-05-01	2020-05-02	3980	122	1272	2586	f	f
3555	Moldova	2020-05-02	2020-05-03	4052	124	1334	2594	f	f
3556	Moldova	2020-05-03	2020-05-04	4121	125	1382	2614	f	f
3557	Moldova	2020-05-04	2020-05-05	4248	132	1423	2693	f	f
3558	Moldova	2020-05-05	2020-05-06	4363	136	1544	2683	f	f
3559	Moldova	2020-05-06	2020-05-07	4476	143	1658	2675	f	f
3560	Moldova	2020-05-07	2020-05-08	4605	145	1747	2713	f	f
3561	Moldova	2020-05-08	2020-05-09	4728	150	1826	2752	f	f
3562	Moldova	2020-05-09	2020-05-10	4867	161	1925	2781	f	f
3563	Moldova	2020-05-10	2020-05-11	4927	169	1958	2800	f	f
3564	Moldova	2020-05-11	2020-05-12	4995	175	1980	2840	f	f
3565	Moldova	2020-05-12	2020-05-13	5154	182	2069	2903	f	f
3566	Moldova	2020-05-13	2020-05-14	5406	185	2176	3045	f	f
3567	Moldova	2020-05-14	2020-05-15	5553	194	2228	3131	f	f
3568	Moldova	2020-05-15	2020-05-16	5745	202	2228	3315	f	f
3569	Moldova	2020-05-16	2020-05-17	5934	207	2344	3383	f	f
3570	Moldova	2020-05-17	2020-05-18	6060	211	2344	3505	f	f
3571	Moldova	2020-05-18	2020-05-19	6138	217	2425	3496	f	f
3572	Moldova	2020-05-19	2020-05-20	6340	221	2508	3611	f	f
3573	Moldova	2020-05-20	2020-05-21	6553	228	2953	3372	f	f
3574	Moldova	2020-05-21	2020-05-22	6704	233	2953	3518	f	f
3575	Moldova	2020-05-22	2020-05-23	6847	237	3369	3241	f	f
3576	Moldova	2020-05-23	2020-05-24	6994	242	3452	3300	f	f
3577	Moldova	2020-05-24	2020-05-25	7093	250	3713	3130	f	f
3578	Moldova	2020-05-25	2020-05-26	7147	261	3802	3084	f	f
3579	Moldova	2020-05-26	2020-05-27	7305	267	3884	3154	f	f
3580	Moldova	2020-05-27	2020-05-28	7537	274	3884	3379	f	f
3581	Moldova	2020-05-28	2020-05-29	7725	282	4123	3320	f	f
3582	Moldova	2020-05-29	2020-05-30	7896	288	4278	3330	f	f
3583	Moldova	2020-05-30	2020-05-31	8098	291	4455	3352	f	f
3584	Moldova	2020-05-31	2020-06-01	8251	295	4581	3375	f	f
3585	Monaco	2020-05-01	2020-05-02	95	4	73	18	f	f
3586	Monaco	2020-05-02	2020-05-03	95	4	78	13	f	f
3587	Monaco	2020-05-03	2020-05-04	95	4	78	13	f	f
3588	Monaco	2020-05-04	2020-05-05	95	4	78	13	f	f
3589	Monaco	2020-05-05	2020-05-06	95	4	81	10	f	f
3590	Monaco	2020-05-06	2020-05-07	95	4	82	9	f	f
3591	Monaco	2020-05-07	2020-05-08	95	4	82	9	f	f
3592	Monaco	2020-05-08	2020-05-09	95	4	82	9	f	f
3593	Monaco	2020-05-09	2020-05-10	96	4	82	10	f	f
3594	Monaco	2020-05-10	2020-05-11	96	4	82	10	f	f
3595	Monaco	2020-05-11	2020-05-12	96	4	85	7	f	f
3596	Monaco	2020-05-12	2020-05-13	96	4	85	7	f	f
3597	Monaco	2020-05-13	2020-05-14	96	4	87	5	f	f
3598	Monaco	2020-05-14	2020-05-15	96	4	87	5	f	f
3599	Monaco	2020-05-15	2020-05-16	96	4	87	5	f	f
3600	Monaco	2020-05-16	2020-05-17	96	4	87	5	f	f
3601	Monaco	2020-05-17	2020-05-18	96	4	87	5	f	f
3602	Monaco	2020-05-18	2020-05-19	97	4	87	6	f	f
3603	Monaco	2020-05-19	2020-05-20	97	4	87	6	f	f
3604	Monaco	2020-05-20	2020-05-21	97	4	90	3	f	f
3605	Monaco	2020-05-21	2020-05-22	97	4	90	3	f	f
3606	Monaco	2020-05-22	2020-05-23	97	4	90	3	f	f
3607	Monaco	2020-05-23	2020-05-24	98	4	90	4	f	f
3608	Monaco	2020-05-24	2020-05-25	98	4	90	4	f	f
3609	Monaco	2020-05-25	2020-05-26	98	4	90	4	f	f
3610	Monaco	2020-05-26	2020-05-27	98	4	90	4	f	f
3611	Monaco	2020-05-27	2020-05-28	98	4	90	4	f	f
3612	Monaco	2020-05-28	2020-05-29	98	4	90	4	f	f
3613	Monaco	2020-05-29	2020-05-30	98	4	90	4	f	f
3614	Monaco	2020-05-30	2020-05-31	99	4	90	5	f	f
3615	Monaco	2020-05-31	2020-06-01	99	4	90	5	f	f
3616	Mongolia	2020-05-01	2020-05-02	38	0	10	28	f	f
3617	Mongolia	2020-05-02	2020-05-03	39	0	10	29	f	f
3618	Mongolia	2020-05-03	2020-05-04	39	0	10	29	f	f
3619	Mongolia	2020-05-04	2020-05-05	40	0	12	28	f	f
3620	Mongolia	2020-05-05	2020-05-06	41	0	13	28	f	f
3621	Mongolia	2020-05-06	2020-05-07	41	0	13	28	f	f
3622	Mongolia	2020-05-07	2020-05-08	41	0	13	28	f	f
3623	Mongolia	2020-05-08	2020-05-09	42	0	13	29	f	f
3624	Mongolia	2020-05-09	2020-05-10	42	0	14	28	f	f
3625	Mongolia	2020-05-10	2020-05-11	42	0	14	28	f	f
3626	Mongolia	2020-05-11	2020-05-12	42	0	14	28	f	f
3627	Mongolia	2020-05-12	2020-05-13	42	0	15	27	f	f
3628	Mongolia	2020-05-13	2020-05-14	42	0	15	27	f	f
3629	Mongolia	2020-05-14	2020-05-15	98	0	15	83	f	f
3630	Mongolia	2020-05-15	2020-05-16	98	0	20	78	f	f
3631	Mongolia	2020-05-16	2020-05-17	135	0	20	115	f	f
3632	Mongolia	2020-05-17	2020-05-18	136	0	21	115	f	f
3633	Mongolia	2020-05-18	2020-05-19	140	0	24	116	f	f
3634	Mongolia	2020-05-19	2020-05-20	140	0	26	114	f	f
3635	Mongolia	2020-05-20	2020-05-21	140	0	26	114	f	f
3636	Mongolia	2020-05-21	2020-05-22	140	0	26	114	f	f
3637	Mongolia	2020-05-22	2020-05-23	141	0	28	113	f	f
3638	Mongolia	2020-05-23	2020-05-24	141	0	30	111	f	f
3639	Mongolia	2020-05-24	2020-05-25	141	0	32	109	f	f
3640	Mongolia	2020-05-25	2020-05-26	141	0	33	108	f	f
3641	Mongolia	2020-05-26	2020-05-27	141	0	37	104	f	f
3642	Mongolia	2020-05-27	2020-05-28	148	0	43	105	f	f
3643	Mongolia	2020-05-28	2020-05-29	161	0	43	118	f	f
3644	Mongolia	2020-05-29	2020-05-30	179	0	43	136	f	f
3645	Mongolia	2020-05-30	2020-05-31	179	0	44	135	f	f
3646	Mongolia	2020-05-31	2020-06-01	179	0	44	135	f	f
3647	Montenegro	2020-05-01	2020-05-02	322	7	233	82	f	f
3648	Montenegro	2020-05-02	2020-05-03	322	8	245	69	f	f
3649	Montenegro	2020-05-03	2020-05-04	322	8	249	65	f	f
3650	Montenegro	2020-05-04	2020-05-05	323	8	253	62	f	f
3651	Montenegro	2020-05-05	2020-05-06	324	8	253	63	f	f
3652	Montenegro	2020-05-06	2020-05-07	324	8	261	55	f	f
3653	Montenegro	2020-05-07	2020-05-08	324	8	265	51	f	f
3654	Montenegro	2020-05-08	2020-05-09	324	8	267	49	f	f
3655	Montenegro	2020-05-09	2020-05-10	324	8	274	42	f	f
3656	Montenegro	2020-05-10	2020-05-11	324	9	290	25	f	f
3657	Montenegro	2020-05-11	2020-05-12	324	9	294	21	f	f
3658	Montenegro	2020-05-12	2020-05-13	324	9	298	17	f	f
3659	Montenegro	2020-05-13	2020-05-14	324	9	307	8	f	f
3660	Montenegro	2020-05-14	2020-05-15	324	9	309	6	f	f
3661	Montenegro	2020-05-15	2020-05-16	324	9	311	4	f	f
3662	Montenegro	2020-05-16	2020-05-17	324	9	311	4	f	f
3663	Montenegro	2020-05-17	2020-05-18	324	9	311	4	f	f
3664	Montenegro	2020-05-18	2020-05-19	324	9	311	4	f	f
3665	Montenegro	2020-05-19	2020-05-20	324	9	312	3	f	f
3666	Montenegro	2020-05-20	2020-05-21	324	9	312	3	f	f
3667	Montenegro	2020-05-21	2020-05-22	324	9	314	1	f	f
3668	Montenegro	2020-05-22	2020-05-23	324	9	314	1	f	f
3669	Montenegro	2020-05-23	2020-05-24	324	9	314	1	f	f
3670	Montenegro	2020-05-24	2020-05-25	324	9	315	0	f	f
3671	Montenegro	2020-05-25	2020-05-26	324	9	315	0	f	f
3672	Montenegro	2020-05-26	2020-05-27	324	9	315	0	f	f
3673	Montenegro	2020-05-27	2020-05-28	324	9	315	0	f	f
3674	Montenegro	2020-05-28	2020-05-29	324	9	315	0	f	f
3675	Montenegro	2020-05-29	2020-05-30	324	9	315	0	f	f
3676	Montenegro	2020-05-30	2020-05-31	324	9	315	0	f	f
3677	Montenegro	2020-05-31	2020-06-01	324	9	315	0	f	f
3678	Morocco	2020-05-01	2020-05-02	4569	171	1083	3315	f	f
3679	Morocco	2020-05-02	2020-05-03	4729	173	1256	3300	f	f
3680	Morocco	2020-05-03	2020-05-04	4903	174	1438	3291	f	f
3681	Morocco	2020-05-04	2020-05-05	5053	179	1653	3221	f	f
3682	Morocco	2020-05-05	2020-05-06	5219	181	1838	3200	f	f
3683	Morocco	2020-05-06	2020-05-07	5408	183	2017	3208	f	f
3684	Morocco	2020-05-07	2020-05-08	5548	183	2179	3186	f	f
3685	Morocco	2020-05-08	2020-05-09	5711	186	2324	3201	f	f
3686	Morocco	2020-05-09	2020-05-10	5910	186	2461	3263	f	f
3687	Morocco	2020-05-10	2020-05-11	6063	188	2554	3321	f	f
3688	Morocco	2020-05-11	2020-05-12	6281	188	2811	3282	f	f
3689	Morocco	2020-05-12	2020-05-13	6418	188	2991	3239	f	f
3690	Morocco	2020-05-13	2020-05-14	6512	188	3131	3193	f	f
3691	Morocco	2020-05-14	2020-05-15	6607	190	3310	3107	f	f
3692	Morocco	2020-05-15	2020-05-16	6652	190	3400	3062	f	f
3693	Morocco	2020-05-16	2020-05-17	6741	192	3487	3062	f	f
3694	Morocco	2020-05-17	2020-05-18	6870	192	3660	3018	f	f
3695	Morocco	2020-05-18	2020-05-19	6952	192	3758	3002	f	f
3696	Morocco	2020-05-19	2020-05-20	7023	193	3901	2929	f	f
3697	Morocco	2020-05-20	2020-05-21	7133	194	4098	2841	f	f
3698	Morocco	2020-05-21	2020-05-22	7211	196	4280	2735	f	f
3699	Morocco	2020-05-22	2020-05-23	7332	197	4377	2758	f	f
3700	Morocco	2020-05-23	2020-05-24	7406	198	4638	2570	f	f
3701	Morocco	2020-05-24	2020-05-25	7433	199	4703	2531	f	f
3702	Morocco	2020-05-25	2020-05-26	7532	200	4774	2558	f	f
3703	Morocco	2020-05-26	2020-05-27	7577	202	4881	2494	f	f
3704	Morocco	2020-05-27	2020-05-28	7601	202	4978	2421	f	f
3705	Morocco	2020-05-28	2020-05-29	7643	202	5195	2246	f	f
3706	Morocco	2020-05-29	2020-05-30	7714	202	5271	2241	f	f
3707	Morocco	2020-05-30	2020-05-31	7780	204	5401	2175	f	f
3708	Morocco	2020-05-31	2020-06-01	7807	205	5459	2143	f	f
3709	Mozambique	2020-05-01	2020-05-02	79	0	12	67	f	f
3710	Mozambique	2020-05-02	2020-05-03	79	0	18	61	f	f
3711	Mozambique	2020-05-03	2020-05-04	80	0	19	61	f	f
3712	Mozambique	2020-05-04	2020-05-05	80	0	19	61	f	f
3713	Mozambique	2020-05-05	2020-05-06	81	0	19	62	f	f
3714	Mozambique	2020-05-06	2020-05-07	81	0	21	60	f	f
3715	Mozambique	2020-05-07	2020-05-08	81	0	24	57	f	f
3716	Mozambique	2020-05-08	2020-05-09	82	0	27	55	f	f
3717	Mozambique	2020-05-09	2020-05-10	87	0	34	53	f	f
3718	Mozambique	2020-05-10	2020-05-11	91	0	34	57	f	f
3719	Mozambique	2020-05-11	2020-05-12	103	0	34	69	f	f
3720	Mozambique	2020-05-12	2020-05-13	104	0	34	70	f	f
3721	Mozambique	2020-05-13	2020-05-14	104	0	34	70	f	f
3722	Mozambique	2020-05-14	2020-05-15	115	0	35	80	f	f
3723	Mozambique	2020-05-15	2020-05-16	119	0	42	77	f	f
3724	Mozambique	2020-05-16	2020-05-17	129	0	43	86	f	f
3725	Mozambique	2020-05-17	2020-05-18	137	0	44	93	f	f
3726	Mozambique	2020-05-18	2020-05-19	145	0	44	101	f	f
3727	Mozambique	2020-05-19	2020-05-20	146	0	44	102	f	f
3728	Mozambique	2020-05-20	2020-05-21	156	0	48	108	f	f
3729	Mozambique	2020-05-21	2020-05-22	162	0	48	114	f	f
3730	Mozambique	2020-05-22	2020-05-23	164	0	48	116	f	f
3731	Mozambique	2020-05-23	2020-05-24	168	0	48	120	f	f
3732	Mozambique	2020-05-24	2020-05-25	194	0	51	143	f	f
3733	Mozambique	2020-05-25	2020-05-26	209	1	71	137	f	f
3734	Mozambique	2020-05-26	2020-05-27	213	1	71	141	f	f
3735	Mozambique	2020-05-27	2020-05-28	227	1	71	155	f	f
3736	Mozambique	2020-05-28	2020-05-29	233	2	82	149	f	f
3737	Mozambique	2020-05-29	2020-05-30	234	2	84	148	f	f
3738	Mozambique	2020-05-30	2020-05-31	244	2	90	152	f	f
3739	Mozambique	2020-05-31	2020-06-01	254	2	91	161	f	f
3740	Namibia	2020-05-01	2020-05-02	16	0	8	8	f	f
3741	Namibia	2020-05-02	2020-05-03	16	0	8	8	f	f
3742	Namibia	2020-05-03	2020-05-04	16	0	8	8	f	f
3743	Namibia	2020-05-04	2020-05-05	16	0	8	8	f	f
3744	Namibia	2020-05-05	2020-05-06	16	0	8	8	f	f
3745	Namibia	2020-05-06	2020-05-07	16	0	8	8	f	f
3746	Namibia	2020-05-07	2020-05-08	16	0	9	7	f	f
3747	Namibia	2020-05-08	2020-05-09	16	0	9	7	f	f
3748	Namibia	2020-05-09	2020-05-10	16	0	10	6	f	f
3749	Namibia	2020-05-10	2020-05-11	16	0	11	5	f	f
3750	Namibia	2020-05-11	2020-05-12	16	0	11	5	f	f
3751	Namibia	2020-05-12	2020-05-13	16	0	11	5	f	f
3752	Namibia	2020-05-13	2020-05-14	16	0	11	5	f	f
3753	Namibia	2020-05-14	2020-05-15	16	0	12	4	f	f
3754	Namibia	2020-05-15	2020-05-16	16	0	13	3	f	f
3755	Namibia	2020-05-16	2020-05-17	16	0	13	3	f	f
3756	Namibia	2020-05-17	2020-05-18	16	0	13	3	f	f
3757	Namibia	2020-05-18	2020-05-19	16	0	13	3	f	f
3758	Namibia	2020-05-19	2020-05-20	16	0	13	3	f	f
3759	Namibia	2020-05-20	2020-05-21	16	0	14	2	f	f
3760	Namibia	2020-05-21	2020-05-22	18	0	14	4	f	f
3761	Namibia	2020-05-22	2020-05-23	19	0	14	5	f	f
3762	Namibia	2020-05-23	2020-05-24	20	0	14	6	f	f
3763	Namibia	2020-05-24	2020-05-25	21	0	14	7	f	f
3764	Namibia	2020-05-25	2020-05-26	21	0	14	7	f	f
3765	Namibia	2020-05-26	2020-05-27	21	0	14	7	f	f
3766	Namibia	2020-05-27	2020-05-28	22	0	14	8	f	f
3767	Namibia	2020-05-28	2020-05-29	22	0	14	8	f	f
3768	Namibia	2020-05-29	2020-05-30	23	0	14	9	f	f
3769	Namibia	2020-05-30	2020-05-31	23	0	14	9	f	f
3770	Namibia	2020-05-31	2020-06-01	24	0	14	10	f	f
3771	Nepal	2020-05-01	2020-05-02	59	0	16	43	f	f
3772	Nepal	2020-05-02	2020-05-03	59	0	16	43	f	f
3773	Nepal	2020-05-03	2020-05-04	75	0	16	59	f	f
3774	Nepal	2020-05-04	2020-05-05	75	0	16	59	f	f
3775	Nepal	2020-05-05	2020-05-06	82	0	16	66	f	f
3776	Nepal	2020-05-06	2020-05-07	99	0	22	77	f	f
3777	Nepal	2020-05-07	2020-05-08	101	0	22	79	f	f
3778	Nepal	2020-05-08	2020-05-09	102	0	31	71	f	f
3779	Nepal	2020-05-09	2020-05-10	110	0	31	79	f	f
3780	Nepal	2020-05-10	2020-05-11	110	0	31	79	f	f
3781	Nepal	2020-05-11	2020-05-12	134	0	33	101	f	f
3782	Nepal	2020-05-12	2020-05-13	217	0	33	184	f	f
3783	Nepal	2020-05-13	2020-05-14	250	0	35	215	f	f
3784	Nepal	2020-05-14	2020-05-15	249	0	35	214	f	f
3785	Nepal	2020-05-15	2020-05-16	267	0	36	231	f	f
3786	Nepal	2020-05-16	2020-05-17	291	1	36	254	f	f
3787	Nepal	2020-05-17	2020-05-18	295	2	36	257	f	f
3788	Nepal	2020-05-18	2020-05-19	375	2	36	337	f	f
3789	Nepal	2020-05-19	2020-05-20	402	2	37	363	f	f
3790	Nepal	2020-05-20	2020-05-21	427	2	45	380	f	f
3791	Nepal	2020-05-21	2020-05-22	457	3	49	405	f	f
3792	Nepal	2020-05-22	2020-05-23	516	3	70	443	f	f
3793	Nepal	2020-05-23	2020-05-24	584	3	70	511	f	f
3794	Nepal	2020-05-24	2020-05-25	603	3	87	513	f	f
3795	Nepal	2020-05-25	2020-05-26	682	4	112	566	f	f
3796	Nepal	2020-05-26	2020-05-27	772	4	155	613	f	f
3797	Nepal	2020-05-27	2020-05-28	886	4	183	699	f	f
3798	Nepal	2020-05-28	2020-05-29	1042	5	187	850	f	f
3799	Nepal	2020-05-29	2020-05-30	1212	6	206	1000	f	f
3800	Nepal	2020-05-30	2020-05-31	1401	6	219	1176	f	f
3801	Nepal	2020-05-31	2020-06-01	1572	8	220	1344	f	f
3802	Netherlands	2020-05-01	2020-05-02	39989	4909	138	34942	f	f
3803	Netherlands	2020-05-02	2020-05-03	40434	5003	138	35293	f	f
3804	Netherlands	2020-05-03	2020-05-04	40769	5072	138	35559	f	f
3805	Netherlands	2020-05-04	2020-05-05	40968	5098	138	35732	f	f
3806	Netherlands	2020-05-05	2020-05-06	41286	5185	139	35962	f	f
3807	Netherlands	2020-05-06	2020-05-07	41518	5221	146	36151	f	f
3808	Netherlands	2020-05-07	2020-05-08	41973	5306	147	36520	f	f
3809	Netherlands	2020-05-08	2020-05-09	42292	5377	147	36768	f	f
3810	Netherlands	2020-05-09	2020-05-10	42581	5441	149	36991	f	f
3811	Netherlands	2020-05-10	2020-05-11	42826	5459	149	37218	f	f
3812	Netherlands	2020-05-11	2020-05-12	42987	5475	149	37363	f	f
3813	Netherlands	2020-05-12	2020-05-13	43183	5529	149	37505	f	f
3814	Netherlands	2020-05-13	2020-05-14	43410	5581	157	37672	f	f
3815	Netherlands	2020-05-14	2020-05-15	43680	5609	159	37912	f	f
3816	Netherlands	2020-05-15	2020-05-16	43880	5662	159	38059	f	f
3817	Netherlands	2020-05-16	2020-05-17	44070	5689	167	38214	f	f
3818	Netherlands	2020-05-17	2020-05-18	44195	5699	167	38329	f	f
3819	Netherlands	2020-05-18	2020-05-19	44341	5713	167	38461	f	f
3820	Netherlands	2020-05-19	2020-05-20	44449	5734	167	38548	f	f
3821	Netherlands	2020-05-20	2020-05-21	44647	5767	169	38711	f	f
3822	Netherlands	2020-05-21	2020-05-22	44900	5794	169	38937	f	f
3823	Netherlands	2020-05-22	2020-05-23	45088	5807	174	39107	f	f
3824	Netherlands	2020-05-23	2020-05-24	45265	5830	174	39261	f	f
3825	Netherlands	2020-05-24	2020-05-25	45437	5841	174	39422	f	f
3826	Netherlands	2020-05-25	2020-05-26	45647	5849	174	39624	f	f
3827	Netherlands	2020-05-26	2020-05-27	45780	5875	174	39731	f	f
3828	Netherlands	2020-05-27	2020-05-28	45970	5890	177	39903	f	f
3829	Netherlands	2020-05-28	2020-05-29	46152	5922	178	40052	f	f
3830	Netherlands	2020-05-29	2020-05-30	46328	5950	178	40200	f	f
3831	Netherlands	2020-05-30	2020-05-31	46460	5970	178	40312	f	f
3832	Netherlands	2020-05-31	2020-06-01	46645	5975	178	40492	f	f
3833	New Zealand	2020-05-01	2020-05-02	1485	20	1263	202	f	f
3834	New Zealand	2020-05-02	2020-05-03	1487	20	1266	201	f	f
3835	New Zealand	2020-05-03	2020-05-04	1487	20	1276	191	f	f
3836	New Zealand	2020-05-04	2020-05-05	1486	20	1302	164	f	f
3837	New Zealand	2020-05-05	2020-05-06	1488	21	1316	151	f	f
3838	New Zealand	2020-05-06	2020-05-07	1489	21	1332	136	f	f
3839	New Zealand	2020-05-07	2020-05-08	1490	21	1347	122	f	f
3840	New Zealand	2020-05-08	2020-05-09	1492	21	1368	103	f	f
3841	New Zealand	2020-05-09	2020-05-10	1494	21	1371	102	f	f
3842	New Zealand	2020-05-10	2020-05-11	1497	21	1386	90	f	f
3843	New Zealand	2020-05-11	2020-05-12	1497	21	1398	78	f	f
3844	New Zealand	2020-05-12	2020-05-13	1497	21	1402	74	f	f
3845	New Zealand	2020-05-13	2020-05-14	1497	21	1411	65	f	f
3846	New Zealand	2020-05-14	2020-05-15	1498	21	1421	56	f	f
3847	New Zealand	2020-05-15	2020-05-16	1498	21	1428	49	f	f
3848	New Zealand	2020-05-16	2020-05-17	1499	21	1433	45	f	f
3849	New Zealand	2020-05-17	2020-05-18	1499	21	1433	45	f	f
3850	New Zealand	2020-05-18	2020-05-19	1499	21	1433	45	f	f
3851	New Zealand	2020-05-19	2020-05-20	1503	21	1447	35	f	f
3852	New Zealand	2020-05-20	2020-05-21	1503	21	1452	30	f	f
3853	New Zealand	2020-05-21	2020-05-22	1504	21	1455	28	f	f
3854	New Zealand	2020-05-22	2020-05-23	1504	21	1455	28	f	f
3855	New Zealand	2020-05-23	2020-05-24	1504	21	1456	27	f	f
3856	New Zealand	2020-05-24	2020-05-25	1504	21	1456	27	f	f
3857	New Zealand	2020-05-25	2020-05-26	1504	21	1461	22	f	f
3858	New Zealand	2020-05-26	2020-05-27	1504	21	1462	21	f	f
3859	New Zealand	2020-05-27	2020-05-28	1504	22	1474	8	f	f
3860	New Zealand	2020-05-28	2020-05-29	1504	22	1481	1	f	f
3861	New Zealand	2020-05-29	2020-05-30	1504	22	1481	1	f	f
3862	New Zealand	2020-05-30	2020-05-31	1504	22	1481	1	f	f
3863	New Zealand	2020-05-31	2020-06-01	1504	22	1481	1	f	f
3864	Nicaragua	2020-05-01	2020-05-02	14	3	7	4	f	f
3865	Nicaragua	2020-05-02	2020-05-03	14	3	7	4	f	f
3866	Nicaragua	2020-05-03	2020-05-04	15	5	7	3	f	f
3867	Nicaragua	2020-05-04	2020-05-05	15	5	7	3	f	f
3868	Nicaragua	2020-05-05	2020-05-06	16	5	7	4	f	f
3869	Nicaragua	2020-05-06	2020-05-07	16	5	7	4	f	f
3870	Nicaragua	2020-05-07	2020-05-08	16	5	7	4	f	f
3871	Nicaragua	2020-05-08	2020-05-09	16	5	7	4	f	f
3872	Nicaragua	2020-05-09	2020-05-10	16	5	7	4	f	f
3873	Nicaragua	2020-05-10	2020-05-11	16	5	7	4	f	f
3874	Nicaragua	2020-05-11	2020-05-12	16	5	7	4	f	f
3875	Nicaragua	2020-05-12	2020-05-13	25	8	7	10	f	f
3876	Nicaragua	2020-05-13	2020-05-14	25	8	7	10	f	f
3877	Nicaragua	2020-05-14	2020-05-15	25	8	7	10	f	f
3878	Nicaragua	2020-05-15	2020-05-16	25	8	7	10	f	f
3879	Nicaragua	2020-05-16	2020-05-17	25	8	7	10	f	f
3880	Nicaragua	2020-05-17	2020-05-18	25	8	7	10	f	f
3881	Nicaragua	2020-05-18	2020-05-19	25	8	7	10	f	f
3882	Nicaragua	2020-05-19	2020-05-20	254	17	199	38	f	f
3883	Nicaragua	2020-05-20	2020-05-21	254	17	199	38	f	f
3884	Nicaragua	2020-05-21	2020-05-22	279	17	199	63	f	f
3885	Nicaragua	2020-05-22	2020-05-23	279	17	199	63	f	f
3886	Nicaragua	2020-05-23	2020-05-24	279	17	199	63	f	f
3887	Nicaragua	2020-05-24	2020-05-25	279	17	199	63	f	f
3888	Nicaragua	2020-05-25	2020-05-26	279	17	199	63	f	f
3889	Nicaragua	2020-05-26	2020-05-27	759	35	370	354	f	f
3890	Nicaragua	2020-05-27	2020-05-28	759	35	370	354	f	f
3891	Nicaragua	2020-05-28	2020-05-29	759	35	370	354	f	f
3892	Nicaragua	2020-05-29	2020-05-30	759	35	370	354	f	f
3893	Nicaragua	2020-05-30	2020-05-31	759	35	370	354	f	f
3894	Nicaragua	2020-05-31	2020-06-01	759	35	370	354	f	f
3895	Niger	2020-05-01	2020-05-02	728	33	478	217	f	f
3896	Niger	2020-05-02	2020-05-03	736	35	507	194	f	f
3897	Niger	2020-05-03	2020-05-04	750	36	518	196	f	f
3898	Niger	2020-05-04	2020-05-05	755	37	534	184	f	f
3899	Niger	2020-05-05	2020-05-06	763	38	543	182	f	f
3900	Niger	2020-05-06	2020-05-07	770	38	561	171	f	f
3901	Niger	2020-05-07	2020-05-08	781	42	586	153	f	f
3902	Niger	2020-05-08	2020-05-09	795	44	600	151	f	f
3903	Niger	2020-05-09	2020-05-10	815	45	617	153	f	f
3904	Niger	2020-05-10	2020-05-11	821	46	624	151	f	f
3905	Niger	2020-05-11	2020-05-12	832	46	637	149	f	f
3906	Niger	2020-05-12	2020-05-13	854	47	648	159	f	f
3907	Niger	2020-05-13	2020-05-14	860	49	658	153	f	f
3908	Niger	2020-05-14	2020-05-15	876	50	677	149	f	f
3909	Niger	2020-05-15	2020-05-16	885	51	684	150	f	f
3910	Niger	2020-05-16	2020-05-17	889	51	689	149	f	f
3911	Niger	2020-05-17	2020-05-18	904	54	698	152	f	f
3912	Niger	2020-05-18	2020-05-19	909	55	714	140	f	f
3913	Niger	2020-05-19	2020-05-20	914	55	734	125	f	f
3914	Niger	2020-05-20	2020-05-21	920	58	738	124	f	f
3915	Niger	2020-05-21	2020-05-22	924	60	753	111	f	f
3916	Niger	2020-05-22	2020-05-23	937	60	764	113	f	f
3917	Niger	2020-05-23	2020-05-24	943	61	775	107	f	f
3918	Niger	2020-05-24	2020-05-25	945	61	783	101	f	f
3919	Niger	2020-05-25	2020-05-26	951	62	786	103	f	f
3920	Niger	2020-05-26	2020-05-27	952	63	796	93	f	f
3921	Niger	2020-05-27	2020-05-28	952	63	796	93	f	f
3922	Niger	2020-05-28	2020-05-29	955	64	803	88	f	f
3923	Niger	2020-05-29	2020-05-30	955	64	813	78	f	f
3924	Niger	2020-05-30	2020-05-31	956	64	818	74	f	f
3925	Niger	2020-05-31	2020-06-01	958	64	839	55	f	f
3926	Nigeria	2020-05-01	2020-05-02	2170	68	351	1751	f	f
3927	Nigeria	2020-05-02	2020-05-03	2388	85	351	1952	f	f
3928	Nigeria	2020-05-03	2020-05-04	2558	87	400	2071	f	f
3929	Nigeria	2020-05-04	2020-05-05	2802	93	417	2292	f	f
3930	Nigeria	2020-05-05	2020-05-06	2950	98	481	2371	f	f
3931	Nigeria	2020-05-06	2020-05-07	3145	103	534	2508	f	f
3932	Nigeria	2020-05-07	2020-05-08	3526	107	601	2818	f	f
3933	Nigeria	2020-05-08	2020-05-09	3912	117	679	3116	f	f
3934	Nigeria	2020-05-09	2020-05-10	4151	128	745	3278	f	f
3935	Nigeria	2020-05-10	2020-05-11	4399	143	778	3478	f	f
3936	Nigeria	2020-05-11	2020-05-12	4641	150	902	3589	f	f
3937	Nigeria	2020-05-12	2020-05-13	4787	158	959	3670	f	f
3938	Nigeria	2020-05-13	2020-05-14	4971	164	1070	3737	f	f
3939	Nigeria	2020-05-14	2020-05-15	5162	167	1180	3815	f	f
3940	Nigeria	2020-05-15	2020-05-16	5450	171	1320	3959	f	f
3941	Nigeria	2020-05-16	2020-05-17	5621	176	1472	3973	f	f
3942	Nigeria	2020-05-17	2020-05-18	5959	182	1594	4183	f	f
3943	Nigeria	2020-05-18	2020-05-19	6175	191	1644	4340	f	f
3944	Nigeria	2020-05-19	2020-05-20	6401	192	1734	4475	f	f
3945	Nigeria	2020-05-20	2020-05-21	6677	200	1840	4637	f	f
3946	Nigeria	2020-05-21	2020-05-22	7016	211	1907	4898	f	f
3947	Nigeria	2020-05-22	2020-05-23	7261	221	2007	5033	f	f
3948	Nigeria	2020-05-23	2020-05-24	7526	221	2174	5131	f	f
3949	Nigeria	2020-05-24	2020-05-25	7839	226	2263	5350	f	f
3950	Nigeria	2020-05-25	2020-05-26	8068	233	2311	5524	f	f
3951	Nigeria	2020-05-26	2020-05-27	8344	249	2385	5710	f	f
3952	Nigeria	2020-05-27	2020-05-28	8733	254	2501	5978	f	f
3953	Nigeria	2020-05-28	2020-05-29	8915	259	2592	6064	f	f
3954	Nigeria	2020-05-29	2020-05-30	9302	261	2697	6344	f	f
3955	Nigeria	2020-05-30	2020-05-31	9855	273	2856	6726	f	f
3956	Nigeria	2020-05-31	2020-06-01	10162	287	3007	6868	f	f
3957	North Macedonia	2020-05-01	2020-05-02	1494	81	807	606	f	f
3958	North Macedonia	2020-05-02	2020-05-03	1506	82	852	572	f	f
3959	North Macedonia	2020-05-03	2020-05-04	1511	84	945	482	f	f
3960	North Macedonia	2020-05-04	2020-05-05	1518	85	992	441	f	f
3961	North Macedonia	2020-05-05	2020-05-06	1526	86	1013	427	f	f
3962	North Macedonia	2020-05-06	2020-05-07	1539	88	1057	394	f	f
3963	North Macedonia	2020-05-07	2020-05-08	1572	89	1079	404	f	f
3964	North Macedonia	2020-05-08	2020-05-09	1586	90	1099	397	f	f
3965	North Macedonia	2020-05-09	2020-05-10	1622	91	1112	419	f	f
3966	North Macedonia	2020-05-10	2020-05-11	1642	91	1136	415	f	f
3967	North Macedonia	2020-05-11	2020-05-12	1664	91	1200	373	f	f
3968	North Macedonia	2020-05-12	2020-05-13	1674	92	1205	377	f	f
3969	North Macedonia	2020-05-13	2020-05-14	1694	95	1229	370	f	f
3970	North Macedonia	2020-05-14	2020-05-15	1723	95	1235	393	f	f
3971	North Macedonia	2020-05-15	2020-05-16	1740	97	1251	392	f	f
3972	North Macedonia	2020-05-16	2020-05-17	1762	98	1267	397	f	f
3973	North Macedonia	2020-05-17	2020-05-18	1792	101	1293	398	f	f
3974	North Macedonia	2020-05-18	2020-05-19	1817	104	1301	412	f	f
3975	North Macedonia	2020-05-19	2020-05-20	1839	106	1351	382	f	f
3976	North Macedonia	2020-05-20	2020-05-21	1858	110	1367	381	f	f
3977	North Macedonia	2020-05-21	2020-05-22	1898	111	1378	409	f	f
3978	North Macedonia	2020-05-22	2020-05-23	1921	112	1387	422	f	f
3979	North Macedonia	2020-05-23	2020-05-24	1941	113	1411	417	f	f
3980	North Macedonia	2020-05-24	2020-05-25	1978	113	1422	443	f	f
3981	North Macedonia	2020-05-25	2020-05-26	1999	113	1439	447	f	f
3982	North Macedonia	2020-05-26	2020-05-27	2014	116	1453	445	f	f
3983	North Macedonia	2020-05-27	2020-05-28	2039	119	1470	450	f	f
3984	North Macedonia	2020-05-28	2020-05-29	2077	121	1486	470	f	f
3985	North Macedonia	2020-05-29	2020-05-30	2129	126	1516	487	f	f
3986	North Macedonia	2020-05-30	2020-05-31	2164	131	1535	498	f	f
3987	North Macedonia	2020-05-31	2020-06-01	2226	133	1552	541	f	f
3988	Norway	2020-05-01	2020-05-02	7783	210	32	7541	f	f
3989	Norway	2020-05-02	2020-05-03	7809	211	32	7566	f	f
3990	Norway	2020-05-03	2020-05-04	7847	211	32	7604	f	f
3991	Norway	2020-05-04	2020-05-05	7904	214	32	7658	f	f
3992	Norway	2020-05-05	2020-05-06	7955	215	32	7708	f	f
3993	Norway	2020-05-06	2020-05-07	7996	216	32	7748	f	f
3994	Norway	2020-05-07	2020-05-08	8034	217	32	7785	f	f
3995	Norway	2020-05-08	2020-05-09	8070	218	32	7820	f	f
3996	Norway	2020-05-09	2020-05-10	8099	219	32	7848	f	f
3997	Norway	2020-05-10	2020-05-11	8105	219	32	7854	f	f
3998	Norway	2020-05-11	2020-05-12	8132	224	32	7876	f	f
3999	Norway	2020-05-12	2020-05-13	8157	228	32	7897	f	f
4000	Norway	2020-05-13	2020-05-14	8175	229	32	7914	f	f
4001	Norway	2020-05-14	2020-05-15	8196	232	32	7932	f	f
4002	Norway	2020-05-15	2020-05-16	8219	232	32	7955	f	f
4003	Norway	2020-05-16	2020-05-17	8237	232	32	7973	f	f
4004	Norway	2020-05-17	2020-05-18	8249	232	32	7985	f	f
4005	Norway	2020-05-18	2020-05-19	8257	233	32	7992	f	f
4006	Norway	2020-05-19	2020-05-20	8267	233	32	8002	f	f
4007	Norway	2020-05-20	2020-05-21	8281	234	32	8015	f	f
4008	Norway	2020-05-21	2020-05-22	8309	235	32	8042	f	f
4009	Norway	2020-05-22	2020-05-23	8332	235	7727	370	f	f
4010	Norway	2020-05-23	2020-05-24	8346	235	7727	384	f	f
4011	Norway	2020-05-24	2020-05-25	8352	235	7727	390	f	f
4012	Norway	2020-05-25	2020-05-26	8364	235	7727	402	f	f
4013	Norway	2020-05-26	2020-05-27	8383	235	7727	421	f	f
4014	Norway	2020-05-27	2020-05-28	8401	235	7727	439	f	f
4015	Norway	2020-05-28	2020-05-29	8411	236	7727	448	f	f
4016	Norway	2020-05-29	2020-05-30	8422	236	7727	459	f	f
4017	Norway	2020-05-30	2020-05-31	8437	236	7727	474	f	f
4018	Norway	2020-05-31	2020-06-01	8440	236	7727	477	f	f
4019	Oman	2020-05-01	2020-05-02	2447	11	495	1941	f	f
4020	Oman	2020-05-02	2020-05-03	2483	12	750	1721	f	f
4021	Oman	2020-05-03	2020-05-04	2568	12	750	1806	f	f
4022	Oman	2020-05-04	2020-05-05	2637	12	816	1809	f	f
4023	Oman	2020-05-05	2020-05-06	2735	13	858	1864	f	f
4024	Oman	2020-05-06	2020-05-07	2903	13	888	2002	f	f
4025	Oman	2020-05-07	2020-05-08	2958	15	980	1963	f	f
4026	Oman	2020-05-08	2020-05-09	3112	16	1025	2071	f	f
4027	Oman	2020-05-09	2020-05-10	3224	17	1068	2139	f	f
4028	Oman	2020-05-10	2020-05-11	3399	17	1117	2265	f	f
4029	Oman	2020-05-11	2020-05-12	3573	17	1250	2306	f	f
4030	Oman	2020-05-12	2020-05-13	3721	17	1250	2454	f	f
4031	Oman	2020-05-13	2020-05-14	4019	17	1289	2713	f	f
4032	Oman	2020-05-14	2020-05-15	4341	18	1303	3020	f	f
4033	Oman	2020-05-15	2020-05-16	4625	20	1350	3255	f	f
4034	Oman	2020-05-16	2020-05-17	5029	21	1436	3572	f	f
4035	Oman	2020-05-17	2020-05-18	5186	22	1465	3699	f	f
4036	Oman	2020-05-18	2020-05-19	5379	25	1496	3858	f	f
4037	Oman	2020-05-19	2020-05-20	5671	27	1574	4070	f	f
4038	Oman	2020-05-20	2020-05-21	6043	30	1661	4352	f	f
4039	Oman	2020-05-21	2020-05-22	6370	31	1821	4518	f	f
4040	Oman	2020-05-22	2020-05-23	6794	34	1821	4939	f	f
4041	Oman	2020-05-23	2020-05-24	7257	36	1848	5373	f	f
4042	Oman	2020-05-24	2020-05-25	7770	37	1933	5800	f	f
4043	Oman	2020-05-25	2020-05-26	7770	37	1933	5800	f	f
4044	Oman	2020-05-26	2020-05-27	8118	37	2067	6014	f	f
4045	Oman	2020-05-27	2020-05-28	8373	39	2177	6157	f	f
4046	Oman	2020-05-28	2020-05-29	9009	40	2177	6792	f	f
4047	Oman	2020-05-29	2020-05-30	9820	40	2396	7384	f	f
4048	Oman	2020-05-30	2020-05-31	10423	42	2396	7985	f	f
4049	Oman	2020-05-31	2020-06-01	11437	49	2682	8706	f	f
4050	Pakistan	2020-05-01	2020-05-02	18114	417	4715	12982	f	f
4051	Pakistan	2020-05-02	2020-05-03	19103	440	4817	13846	f	f
4052	Pakistan	2020-05-03	2020-05-04	20084	457	5114	14513	f	f
4053	Pakistan	2020-05-04	2020-05-05	20941	476	5635	14830	f	f
4054	Pakistan	2020-05-05	2020-05-06	22049	514	5801	15734	f	f
4055	Pakistan	2020-05-06	2020-05-07	24073	564	6464	17045	f	f
4056	Pakistan	2020-05-07	2020-05-08	24644	585	6464	17595	f	f
4057	Pakistan	2020-05-08	2020-05-09	26435	599	7530	18306	f	f
4058	Pakistan	2020-05-09	2020-05-10	28736	636	7809	20291	f	f
4059	Pakistan	2020-05-10	2020-05-11	30334	659	8063	21612	f	f
4060	Pakistan	2020-05-11	2020-05-12	32081	706	8555	22820	f	f
4061	Pakistan	2020-05-12	2020-05-13	34336	737	8812	24787	f	f
4062	Pakistan	2020-05-13	2020-05-14	35298	761	8899	25638	f	f
4063	Pakistan	2020-05-14	2020-05-15	35788	770	9695	25323	f	f
4064	Pakistan	2020-05-15	2020-05-16	38799	834	10880	27085	f	f
4065	Pakistan	2020-05-16	2020-05-17	38799	834	10880	27085	f	f
4066	Pakistan	2020-05-17	2020-05-18	40151	873	11341	27937	f	f
4067	Pakistan	2020-05-18	2020-05-19	42125	903	11922	29300	f	f
4068	Pakistan	2020-05-19	2020-05-20	43966	939	12489	30538	f	f
4069	Pakistan	2020-05-20	2020-05-21	45898	985	13101	31812	f	f
4070	Pakistan	2020-05-21	2020-05-22	48091	1017	14155	32919	f	f
4071	Pakistan	2020-05-22	2020-05-23	50694	1067	15201	34426	f	f
4072	Pakistan	2020-05-23	2020-05-24	52437	1101	16653	34683	f	f
4073	Pakistan	2020-05-24	2020-05-25	54601	1133	17198	36270	f	f
4074	Pakistan	2020-05-25	2020-05-26	56349	1167	17482	37700	f	f
4075	Pakistan	2020-05-26	2020-05-27	57705	1197	18314	38194	f	f
4076	Pakistan	2020-05-27	2020-05-28	59151	1225	19142	38784	f	f
4077	Pakistan	2020-05-28	2020-05-29	61227	1260	20231	39736	f	f
4078	Pakistan	2020-05-29	2020-05-30	64028	1317	22305	40406	f	f
4079	Pakistan	2020-05-30	2020-05-31	66457	1395	24131	40931	f	f
4080	Pakistan	2020-05-31	2020-06-01	69496	1483	25271	42742	f	f
4081	Palau	2020-05-01	2020-05-02	0	0	0	0	f	f
4082	Palau	2020-05-02	2020-05-03	0	0	0	0	f	f
4083	Palau	2020-05-03	2020-05-04	0	0	0	0	f	f
4084	Palau	2020-05-04	2020-05-05	0	0	0	0	f	f
4085	Palau	2020-05-05	2020-05-06	0	0	0	0	f	f
4086	Palau	2020-05-06	2020-05-07	0	0	0	0	f	f
4087	Palau	2020-05-07	2020-05-08	0	0	0	0	f	f
4088	Palau	2020-05-08	2020-05-09	0	0	0	0	f	f
4089	Palau	2020-05-09	2020-05-10	0	0	0	0	f	f
4090	Palau	2020-05-10	2020-05-11	0	0	0	0	f	f
4091	Palau	2020-05-11	2020-05-12	0	0	0	0	f	f
4092	Palau	2020-05-12	2020-05-13	0	0	0	0	f	f
4093	Palau	2020-05-13	2020-05-14	0	0	0	0	f	f
4094	Palau	2020-05-14	2020-05-15	0	0	0	0	f	f
4095	Palau	2020-05-15	2020-05-16	0	0	0	0	f	f
4096	Palau	2020-05-16	2020-05-17	0	0	0	0	f	f
4097	Palau	2020-05-17	2020-05-18	0	0	0	0	f	f
4098	Palau	2020-05-18	2020-05-19	0	0	0	0	f	f
4099	Palau	2020-05-19	2020-05-20	0	0	0	0	f	f
4100	Palau	2020-05-20	2020-05-21	0	0	0	0	f	f
4101	Palau	2020-05-21	2020-05-22	0	0	0	0	f	f
4102	Palau	2020-05-22	2020-05-23	0	0	0	0	f	f
4103	Palau	2020-05-23	2020-05-24	0	0	0	0	f	f
4104	Palau	2020-05-24	2020-05-25	0	0	0	0	f	f
4105	Palau	2020-05-25	2020-05-26	0	0	0	0	f	f
4106	Palau	2020-05-26	2020-05-27	0	0	0	0	f	f
4107	Palau	2020-05-27	2020-05-28	0	0	0	0	f	f
4108	Palau	2020-05-28	2020-05-29	0	0	0	0	f	f
4109	Palau	2020-05-29	2020-05-30	0	0	0	0	f	f
4110	Palau	2020-05-30	2020-05-31	0	0	0	0	f	f
4111	Palau	2020-05-31	2020-06-01	0	0	0	0	f	f
4112	Panama	2020-05-01	2020-05-02	6720	192	622	5906	f	f
4113	Panama	2020-05-02	2020-05-03	7090	197	641	6252	f	f
4114	Panama	2020-05-03	2020-05-04	7090	197	641	6252	f	f
4115	Panama	2020-05-04	2020-05-05	7197	200	641	6356	f	f
4116	Panama	2020-05-05	2020-05-06	7523	210	823	6490	f	f
4117	Panama	2020-05-06	2020-05-07	7731	218	859	6654	f	f
4118	Panama	2020-05-07	2020-05-08	7868	225	886	6757	f	f
4119	Panama	2020-05-08	2020-05-09	8070	231	886	6953	f	f
4120	Panama	2020-05-09	2020-05-10	8282	237	4501	3544	f	f
4121	Panama	2020-05-10	2020-05-11	8448	244	4687	3517	f	f
4122	Panama	2020-05-11	2020-05-12	8616	249	4687	3680	f	f
4123	Panama	2020-05-12	2020-05-13	8783	252	6021	2510	f	f
4124	Panama	2020-05-13	2020-05-14	8944	256	6067	2621	f	f
4125	Panama	2020-05-14	2020-05-15	9118	260	6080	2778	f	f
4126	Panama	2020-05-15	2020-05-16	9268	266	6080	2922	f	f
4127	Panama	2020-05-16	2020-05-17	9449	269	6080	3100	f	f
4128	Panama	2020-05-17	2020-05-18	9606	275	6081	3250	f	f
4129	Panama	2020-05-18	2020-05-19	9726	279	6081	3366	f	f
4130	Panama	2020-05-19	2020-05-20	9867	281	6194	3392	f	f
4131	Panama	2020-05-20	2020-05-21	9977	287	6194	3496	f	f
4132	Panama	2020-05-21	2020-05-22	10116	291	6245	3580	f	f
4133	Panama	2020-05-22	2020-05-23	10267	295	6275	3697	f	f
4134	Panama	2020-05-23	2020-05-24	10577	299	6279	3999	f	f
4135	Panama	2020-05-24	2020-05-25	10926	306	6279	4341	f	f
4136	Panama	2020-05-25	2020-05-26	11183	310	6279	4594	f	f
4137	Panama	2020-05-26	2020-05-27	11447	313	6379	4755	f	f
4138	Panama	2020-05-27	2020-05-28	11728	315	7379	4034	f	f
4139	Panama	2020-05-28	2020-05-29	12131	320	7379	4432	f	f
4140	Panama	2020-05-29	2020-05-30	12531	326	7540	4665	f	f
4141	Panama	2020-05-30	2020-05-31	13018	330	9414	3274	f	f
4142	Panama	2020-05-31	2020-06-01	13463	336	9514	3613	f	f
4143	Papua New Guinea	2020-05-01	2020-05-02	8	0	0	8	f	f
4144	Papua New Guinea	2020-05-02	2020-05-03	8	0	0	8	f	f
4145	Papua New Guinea	2020-05-03	2020-05-04	8	0	0	8	f	f
4146	Papua New Guinea	2020-05-04	2020-05-05	8	0	8	0	f	f
4147	Papua New Guinea	2020-05-05	2020-05-06	8	0	8	0	f	f
4148	Papua New Guinea	2020-05-06	2020-05-07	8	0	8	0	f	f
4149	Papua New Guinea	2020-05-07	2020-05-08	8	0	8	0	f	f
4150	Papua New Guinea	2020-05-08	2020-05-09	8	0	8	0	f	f
4151	Papua New Guinea	2020-05-09	2020-05-10	8	0	8	0	f	f
4152	Papua New Guinea	2020-05-10	2020-05-11	8	0	8	0	f	f
4153	Papua New Guinea	2020-05-11	2020-05-12	8	0	8	0	f	f
4154	Papua New Guinea	2020-05-12	2020-05-13	8	0	8	0	f	f
4155	Papua New Guinea	2020-05-13	2020-05-14	8	0	8	0	f	f
4156	Papua New Guinea	2020-05-14	2020-05-15	8	0	8	0	f	f
4157	Papua New Guinea	2020-05-15	2020-05-16	8	0	8	0	f	f
4158	Papua New Guinea	2020-05-16	2020-05-17	8	0	8	0	f	f
4159	Papua New Guinea	2020-05-17	2020-05-18	8	0	8	0	f	f
4160	Papua New Guinea	2020-05-18	2020-05-19	8	0	8	0	f	f
4161	Papua New Guinea	2020-05-19	2020-05-20	8	0	8	0	f	f
4162	Papua New Guinea	2020-05-20	2020-05-21	8	0	8	0	f	f
4163	Papua New Guinea	2020-05-21	2020-05-22	8	0	8	0	f	f
4164	Papua New Guinea	2020-05-22	2020-05-23	8	0	8	0	f	f
4165	Papua New Guinea	2020-05-23	2020-05-24	8	0	8	0	f	f
4166	Papua New Guinea	2020-05-24	2020-05-25	8	0	8	0	f	f
4167	Papua New Guinea	2020-05-25	2020-05-26	8	0	8	0	f	f
4168	Papua New Guinea	2020-05-26	2020-05-27	8	0	8	0	f	f
4169	Papua New Guinea	2020-05-27	2020-05-28	8	0	8	0	f	f
4170	Papua New Guinea	2020-05-28	2020-05-29	8	0	8	0	f	f
4171	Papua New Guinea	2020-05-29	2020-05-30	8	0	8	0	f	f
4172	Papua New Guinea	2020-05-30	2020-05-31	8	0	8	0	f	f
4173	Papua New Guinea	2020-05-31	2020-06-01	8	0	8	0	f	f
4174	Paraguay	2020-05-01	2020-05-02	333	10	115	208	f	f
4175	Paraguay	2020-05-02	2020-05-03	370	10	119	241	f	f
4176	Paraguay	2020-05-03	2020-05-04	396	10	126	260	f	f
4177	Paraguay	2020-05-04	2020-05-05	415	10	130	275	f	f
4178	Paraguay	2020-05-05	2020-05-06	431	10	135	286	f	f
4179	Paraguay	2020-05-06	2020-05-07	440	10	142	288	f	f
4180	Paraguay	2020-05-07	2020-05-08	462	10	148	304	f	f
4181	Paraguay	2020-05-08	2020-05-09	563	10	152	401	f	f
4182	Paraguay	2020-05-09	2020-05-10	689	10	155	524	f	f
4183	Paraguay	2020-05-10	2020-05-11	713	10	165	538	f	f
4184	Paraguay	2020-05-11	2020-05-12	724	10	170	544	f	f
4185	Paraguay	2020-05-12	2020-05-13	737	10	173	554	f	f
4186	Paraguay	2020-05-13	2020-05-14	740	11	182	547	f	f
4187	Paraguay	2020-05-14	2020-05-15	754	11	184	559	f	f
4188	Paraguay	2020-05-15	2020-05-16	759	11	193	555	f	f
4189	Paraguay	2020-05-16	2020-05-17	778	11	198	569	f	f
4190	Paraguay	2020-05-17	2020-05-18	786	11	202	573	f	f
4191	Paraguay	2020-05-18	2020-05-19	788	11	219	558	f	f
4192	Paraguay	2020-05-19	2020-05-20	829	11	230	588	f	f
4193	Paraguay	2020-05-20	2020-05-21	833	11	242	580	f	f
4194	Paraguay	2020-05-21	2020-05-22	836	11	256	569	f	f
4195	Paraguay	2020-05-22	2020-05-23	838	11	264	563	f	f
4196	Paraguay	2020-05-23	2020-05-24	850	11	298	541	f	f
4197	Paraguay	2020-05-24	2020-05-25	862	11	307	544	f	f
4198	Paraguay	2020-05-25	2020-05-26	865	11	344	510	f	f
4199	Paraguay	2020-05-26	2020-05-27	877	11	382	484	f	f
4200	Paraguay	2020-05-27	2020-05-28	884	11	392	481	f	f
4201	Paraguay	2020-05-28	2020-05-29	900	11	402	487	f	f
4202	Paraguay	2020-05-29	2020-05-30	917	11	413	493	f	f
4203	Paraguay	2020-05-30	2020-05-31	964	11	466	487	f	f
4204	Paraguay	2020-05-31	2020-06-01	986	11	477	498	f	f
4205	Peru	2020-05-01	2020-05-02	40459	5181	11129	28206	f	f
4206	Peru	2020-05-02	2020-05-03	42534	5589	12434	28900	f	f
4207	Peru	2020-05-03	2020-05-04	45928	6004	13550	31092	f	f
4208	Peru	2020-05-04	2020-05-05	47372	6442	14427	31601	f	f
4209	Peru	2020-05-05	2020-05-06	51189	6871	15413	34332	f	f
4210	Peru	2020-05-06	2020-05-07	54817	7328	17527	35757	f	f
4211	Peru	2020-05-07	2020-05-08	58526	7809	18388	38511	f	f
4212	Peru	2020-05-08	2020-05-09	61847	8263	19012	41121	f	f
4213	Peru	2020-05-09	2020-05-10	65015	8740	20246	42955	f	f
4214	Peru	2020-05-10	2020-05-11	67307	9258	21349	44069	f	f
4215	Peru	2020-05-11	2020-05-12	68822	9778	22406	44455	f	f
4216	Peru	2020-05-12	2020-05-13	72059	10294	23324	46678	f	f
4217	Peru	2020-05-13	2020-05-14	76306	10760	24324	49813	f	f
4218	Peru	2020-05-14	2020-05-15	80604	11277	25151	53186	f	f
4219	Peru	2020-05-15	2020-05-16	84495	11824	27147	54956	f	f
4220	Peru	2020-05-16	2020-05-17	88541	12333	28272	57746	f	f
4221	Peru	2020-05-17	2020-05-18	92273	12835	28621	61004	f	f
4222	Peru	2020-05-18	2020-05-19	94933	13369	30306	61838	f	f
4223	Peru	2020-05-19	2020-05-20	99483	13984	36524	60045	f	f
4224	Peru	2020-05-20	2020-05-21	104020	14512	41968	59028	f	f
4225	Peru	2020-05-21	2020-05-22	108769	15056	43587	62034	f	f
4226	Peru	2020-05-22	2020-05-23	111698	15583	44848	63606	f	f
4227	Peru	2020-05-23	2020-05-24	115754	16101	47915	64466	f	f
4228	Peru	2020-05-24	2020-05-25	119959	16644	49795	66708	f	f
4229	Peru	2020-05-25	2020-05-26	123979	17216	50949	69401	f	f
4230	Peru	2020-05-26	2020-05-27	129751	17796	52906	73057	f	f
4231	Peru	2020-05-27	2020-05-28	135905	18340	56169	75753	f	f
4232	Peru	2020-05-28	2020-05-29	141779	18924	59442	78238	f	f
4233	Peru	2020-05-29	2020-05-30	141779	19478	62791	74889	f	f
4234	Peru	2020-05-30	2020-05-31	155671	20111	66447	84853	f	f
4235	Peru	2020-05-31	2020-06-01	164476	20710	67208	92762	f	f
4236	Philippines	2020-05-01	2020-05-02	8772	579	1084	7109	f	f
4237	Philippines	2020-05-02	2020-05-03	8928	603	1124	7201	f	f
4238	Philippines	2020-05-03	2020-05-04	9223	607	1214	7402	f	f
4239	Philippines	2020-05-04	2020-05-05	9485	623	1315	7547	f	f
4240	Philippines	2020-05-05	2020-05-06	9684	637	1408	7639	f	f
4241	Philippines	2020-05-06	2020-05-07	10004	658	1506	7840	f	f
4242	Philippines	2020-05-07	2020-05-08	10343	685	1618	8040	f	f
4243	Philippines	2020-05-08	2020-05-09	10463	696	1734	8033	f	f
4244	Philippines	2020-05-09	2020-05-10	10610	704	1842	8064	f	f
4245	Philippines	2020-05-10	2020-05-11	10794	719	1924	8151	f	f
4246	Philippines	2020-05-11	2020-05-12	11086	726	1999	8361	f	f
4247	Philippines	2020-05-12	2020-05-13	11350	751	2106	8493	f	f
4248	Philippines	2020-05-13	2020-05-14	11618	772	2251	8595	f	f
4249	Philippines	2020-05-14	2020-05-15	11876	790	2337	8749	f	f
4250	Philippines	2020-05-15	2020-05-16	12091	806	2460	8825	f	f
4251	Philippines	2020-05-16	2020-05-17	12305	817	2561	8927	f	f
4252	Philippines	2020-05-17	2020-05-18	12513	824	2635	9054	f	f
4253	Philippines	2020-05-18	2020-05-19	12718	831	2729	9158	f	f
4254	Philippines	2020-05-19	2020-05-20	12942	837	2843	9262	f	f
4255	Philippines	2020-05-20	2020-05-21	13221	842	2932	9447	f	f
4256	Philippines	2020-05-21	2020-05-22	13434	846	3000	9588	f	f
4257	Philippines	2020-05-22	2020-05-23	13597	857	3092	9648	f	f
4258	Philippines	2020-05-23	2020-05-24	13777	863	3177	9737	f	f
4259	Philippines	2020-05-24	2020-05-25	14035	868	3249	9918	f	f
4260	Philippines	2020-05-25	2020-05-26	14319	873	3323	10123	f	f
4261	Philippines	2020-05-26	2020-05-27	14669	886	3412	10371	f	f
4262	Philippines	2020-05-27	2020-05-28	15049	904	3506	10639	f	f
4263	Philippines	2020-05-28	2020-05-29	15588	921	3598	11069	f	f
4264	Philippines	2020-05-29	2020-05-30	16634	942	3720	11972	f	f
4265	Philippines	2020-05-30	2020-05-31	17224	950	3808	12466	f	f
4266	Philippines	2020-05-31	2020-06-01	18086	957	3909	13220	f	f
4267	Poland	2020-05-01	2020-05-02	13105	651	3491	8963	f	f
4268	Poland	2020-05-02	2020-05-03	13375	664	3762	8949	f	f
4269	Poland	2020-05-03	2020-05-04	13693	678	3945	9070	f	f
4270	Poland	2020-05-04	2020-05-05	14006	698	4095	9213	f	f
4271	Poland	2020-05-05	2020-05-06	14431	716	4280	9435	f	f
4272	Poland	2020-05-06	2020-05-07	14740	733	4655	9352	f	f
4273	Poland	2020-05-07	2020-05-08	15047	755	4862	9430	f	f
4274	Poland	2020-05-08	2020-05-09	15366	776	5184	9406	f	f
4275	Poland	2020-05-09	2020-05-10	15651	785	5437	9429	f	f
4276	Poland	2020-05-10	2020-05-11	15996	800	5698	9498	f	f
4277	Poland	2020-05-11	2020-05-12	16326	811	5816	9699	f	f
4278	Poland	2020-05-12	2020-05-13	16921	839	6131	9951	f	f
4279	Poland	2020-05-13	2020-05-14	17204	861	6410	9933	f	f
4280	Poland	2020-05-14	2020-05-15	17615	883	6696	10036	f	f
4281	Poland	2020-05-15	2020-05-16	18016	907	6918	10191	f	f
4282	Poland	2020-05-16	2020-05-17	18257	915	7175	10167	f	f
4283	Poland	2020-05-17	2020-05-18	18529	925	7451	10153	f	f
4284	Poland	2020-05-18	2020-05-19	18885	936	7628	10321	f	f
4285	Poland	2020-05-19	2020-05-20	19268	948	7903	10417	f	f
4286	Poland	2020-05-20	2020-05-21	19739	962	8183	10594	f	f
4287	Poland	2020-05-21	2020-05-22	20143	972	8452	10719	f	f
4288	Poland	2020-05-22	2020-05-23	20619	982	8731	10906	f	f
4289	Poland	2020-05-23	2020-05-24	20931	993	8977	10961	f	f
4290	Poland	2020-05-24	2020-05-25	21326	996	9194	11136	f	f
4291	Poland	2020-05-25	2020-05-26	21631	1007	9276	11348	f	f
4292	Poland	2020-05-26	2020-05-27	22074	1024	10020	11030	f	f
4293	Poland	2020-05-27	2020-05-28	22473	1028	10330	11115	f	f
4294	Poland	2020-05-28	2020-05-29	22825	1038	10560	11227	f	f
4295	Poland	2020-05-29	2020-05-30	23155	1051	10692	11412	f	f
4296	Poland	2020-05-30	2020-05-31	23571	1061	11016	11494	f	f
4297	Poland	2020-05-31	2020-06-01	23786	1064	11271	11451	f	f
4298	Portugal	2020-05-01	2020-05-02	25351	1007	1647	22697	f	f
4299	Portugal	2020-05-02	2020-05-03	25190	1023	1671	22496	f	f
4300	Portugal	2020-05-03	2020-05-04	25282	1043	1689	22550	f	f
4301	Portugal	2020-05-04	2020-05-05	25524	1063	1712	22749	f	f
4302	Portugal	2020-05-05	2020-05-06	25702	1074	1743	22885	f	f
4303	Portugal	2020-05-06	2020-05-07	26182	1089	2076	23017	f	f
4304	Portugal	2020-05-07	2020-05-08	26715	1105	2258	23352	f	f
4305	Portugal	2020-05-08	2020-05-09	27268	1114	2422	23732	f	f
4306	Portugal	2020-05-09	2020-05-10	27406	1126	2499	23781	f	f
4307	Portugal	2020-05-10	2020-05-11	27581	1135	2549	23897	f	f
4308	Portugal	2020-05-11	2020-05-12	27679	1144	2549	23986	f	f
4309	Portugal	2020-05-12	2020-05-13	27913	1163	3013	23737	f	f
4310	Portugal	2020-05-13	2020-05-14	28132	1175	3182	23775	f	f
4311	Portugal	2020-05-14	2020-05-15	28319	1184	3198	23937	f	f
4312	Portugal	2020-05-15	2020-05-16	28583	1190	3328	24065	f	f
4313	Portugal	2020-05-16	2020-05-17	28810	1203	3822	23785	f	f
4314	Portugal	2020-05-17	2020-05-18	29036	1218	4636	23182	f	f
4315	Portugal	2020-05-18	2020-05-19	29209	1231	6430	21548	f	f
4316	Portugal	2020-05-19	2020-05-20	29432	1247	6431	21754	f	f
4317	Portugal	2020-05-20	2020-05-21	29660	1263	6452	21945	f	f
4318	Portugal	2020-05-21	2020-05-22	29912	1277	6452	22183	f	f
4319	Portugal	2020-05-22	2020-05-23	30200	1289	7590	21321	f	f
4320	Portugal	2020-05-23	2020-05-24	30471	1302	7705	21464	f	f
4321	Portugal	2020-05-24	2020-05-25	30623	1316	17549	11758	f	f
4322	Portugal	2020-05-25	2020-05-26	30788	1330	17822	11636	f	f
4323	Portugal	2020-05-26	2020-05-27	31007	1342	18096	11569	f	f
4324	Portugal	2020-05-27	2020-05-28	31292	1356	18349	11587	f	f
4325	Portugal	2020-05-28	2020-05-29	31596	1369	18637	11590	f	f
4326	Portugal	2020-05-29	2020-05-30	31946	1383	18911	11652	f	f
4327	Portugal	2020-05-30	2020-05-31	32203	1396	19186	11621	f	f
4328	Portugal	2020-05-31	2020-06-01	32500	1410	19409	11681	f	f
4329	Qatar	2020-05-01	2020-05-02	14096	12	1436	12648	f	f
4330	Qatar	2020-05-02	2020-05-03	14872	12	1534	13326	f	f
4331	Qatar	2020-05-03	2020-05-04	15551	12	1664	13875	f	f
4332	Qatar	2020-05-04	2020-05-05	16191	12	1810	14369	f	f
4333	Qatar	2020-05-05	2020-05-06	17142	12	1924	15206	f	f
4334	Qatar	2020-05-06	2020-05-07	17972	12	2070	15890	f	f
4335	Qatar	2020-05-07	2020-05-08	18890	12	2286	16592	f	f
4336	Qatar	2020-05-08	2020-05-09	20201	12	2370	17819	f	f
4337	Qatar	2020-05-09	2020-05-10	21331	13	2449	18869	f	f
4338	Qatar	2020-05-10	2020-05-11	22520	14	2753	19753	f	f
4339	Qatar	2020-05-11	2020-05-12	23623	14	2840	20769	f	f
4340	Qatar	2020-05-12	2020-05-13	25149	14	3019	22116	f	f
4341	Qatar	2020-05-13	2020-05-14	26539	14	3143	23382	f	f
4342	Qatar	2020-05-14	2020-05-15	28272	14	3356	24902	f	f
4343	Qatar	2020-05-15	2020-05-16	29425	14	3546	25865	f	f
4344	Qatar	2020-05-16	2020-05-17	30972	15	3788	27169	f	f
4345	Qatar	2020-05-17	2020-05-18	32604	15	4370	28219	f	f
4346	Qatar	2020-05-18	2020-05-19	33969	15	4899	29055	f	f
4347	Qatar	2020-05-19	2020-05-20	35606	15	5634	29957	f	f
4348	Qatar	2020-05-20	2020-05-21	37097	16	6600	30481	f	f
4349	Qatar	2020-05-21	2020-05-22	38651	17	7288	31346	f	f
4350	Qatar	2020-05-22	2020-05-23	40481	19	7893	32569	f	f
4351	Qatar	2020-05-23	2020-05-24	42213	21	8513	33679	f	f
4352	Qatar	2020-05-24	2020-05-25	43714	23	9170	34521	f	f
4353	Qatar	2020-05-25	2020-05-26	45465	26	10363	35076	f	f
4354	Qatar	2020-05-26	2020-05-27	47207	28	11844	35335	f	f
4355	Qatar	2020-05-27	2020-05-28	48947	30	13283	35634	f	f
4356	Qatar	2020-05-28	2020-05-29	50914	33	15399	35482	f	f
4357	Qatar	2020-05-29	2020-05-30	52907	36	20604	32267	f	f
4358	Qatar	2020-05-30	2020-05-31	55262	36	25839	29387	f	f
4359	Qatar	2020-05-31	2020-06-01	56910	38	30290	26582	f	f
4360	Romania	2020-05-01	2020-05-02	12567	744	4328	7495	f	f
4361	Romania	2020-05-02	2020-05-03	12732	771	4547	7414	f	f
4362	Romania	2020-05-03	2020-05-04	13163	790	4869	7504	f	f
4363	Romania	2020-05-04	2020-05-05	13512	818	5269	7425	f	f
4364	Romania	2020-05-05	2020-05-06	13837	841	5454	7542	f	f
4365	Romania	2020-05-06	2020-05-07	14107	864	5788	7455	f	f
4366	Romania	2020-05-07	2020-05-08	14499	888	6144	7467	f	f
4367	Romania	2020-05-08	2020-05-09	14811	923	6423	7465	f	f
4368	Romania	2020-05-09	2020-05-10	15131	939	6912	7280	f	f
4369	Romania	2020-05-10	2020-05-11	15362	961	7051	7350	f	f
4370	Romania	2020-05-11	2020-05-12	15588	982	7245	7361	f	f
4371	Romania	2020-05-12	2020-05-13	15778	1002	7685	7091	f	f
4372	Romania	2020-05-13	2020-05-14	16002	1036	7961	7005	f	f
4373	Romania	2020-05-14	2020-05-15	16247	1053	9053	6141	f	f
4374	Romania	2020-05-15	2020-05-16	16437	1070	9370	5997	f	f
4375	Romania	2020-05-16	2020-05-17	16704	1094	9574	6036	f	f
4376	Romania	2020-05-17	2020-05-18	16871	1107	9890	5874	f	f
4377	Romania	2020-05-18	2020-05-19	17036	1120	9930	5986	f	f
4378	Romania	2020-05-19	2020-05-20	17191	1137	10166	5888	f	f
4379	Romania	2020-05-20	2020-05-21	17387	1147	10356	5884	f	f
4380	Romania	2020-05-21	2020-05-22	17585	1156	10581	5848	f	f
4381	Romania	2020-05-22	2020-05-23	17712	1166	10777	5769	f	f
4382	Romania	2020-05-23	2020-05-24	17857	1176	11187	5494	f	f
4383	Romania	2020-05-24	2020-05-25	18070	1185	11399	5486	f	f
4384	Romania	2020-05-25	2020-05-26	18283	1205	11630	5448	f	f
4385	Romania	2020-05-26	2020-05-27	18429	1216	11874	5339	f	f
4386	Romania	2020-05-27	2020-05-28	18594	1227	12162	5205	f	f
4387	Romania	2020-05-28	2020-05-29	18791	1235	12629	4927	f	f
4388	Romania	2020-05-29	2020-05-30	18982	1248	12829	4905	f	f
4389	Romania	2020-05-30	2020-05-31	19133	1259	13046	4828	f	f
4390	Romania	2020-05-31	2020-06-01	19257	1266	13256	4735	f	f
4391	Russia	2020-05-01	2020-05-02	114431	1169	13220	100042	f	f
4392	Russia	2020-05-02	2020-05-03	124054	1222	15013	107819	f	f
4393	Russia	2020-05-03	2020-05-04	134687	1280	16639	116768	f	f
4394	Russia	2020-05-04	2020-05-05	145268	1356	18095	125817	f	f
4395	Russia	2020-05-05	2020-05-06	155370	1451	19865	134054	f	f
4396	Russia	2020-05-06	2020-05-07	165929	1537	21327	143065	f	f
4397	Russia	2020-05-07	2020-05-08	177160	1625	23803	151732	f	f
4398	Russia	2020-05-08	2020-05-09	187859	1723	26608	159528	f	f
4399	Russia	2020-05-09	2020-05-10	198676	1827	31916	164933	f	f
4400	Russia	2020-05-10	2020-05-11	209688	1915	34306	173467	f	f
4401	Russia	2020-05-11	2020-05-12	221344	2009	39801	179534	f	f
4402	Russia	2020-05-12	2020-05-13	232243	2116	43512	186615	f	f
4403	Russia	2020-05-13	2020-05-14	242271	2212	48003	192056	f	f
4404	Russia	2020-05-14	2020-05-15	252245	2305	53530	196410	f	f
4405	Russia	2020-05-15	2020-05-16	262843	2418	58226	202199	f	f
4406	Russia	2020-05-16	2020-05-17	272043	2537	63166	206340	f	f
4407	Russia	2020-05-17	2020-05-18	281752	2631	67373	211748	f	f
4408	Russia	2020-05-18	2020-05-19	290678	2722	70209	217747	f	f
4409	Russia	2020-05-19	2020-05-20	299941	2837	76130	220974	f	f
4410	Russia	2020-05-20	2020-05-21	308705	2972	85392	220341	f	f
4411	Russia	2020-05-21	2020-05-22	317554	3099	92681	221774	f	f
4412	Russia	2020-05-22	2020-05-23	326448	3249	99825	223374	f	f
4413	Russia	2020-05-23	2020-05-24	335882	3388	107936	224558	f	f
4414	Russia	2020-05-24	2020-05-25	344481	3541	113299	227641	f	f
4415	Russia	2020-05-25	2020-05-26	353427	3633	118798	230996	f	f
4416	Russia	2020-05-26	2020-05-27	362342	3807	131129	227406	f	f
4417	Russia	2020-05-27	2020-05-28	370680	3968	142208	224504	f	f
4418	Russia	2020-05-28	2020-05-29	379051	4142	150993	223916	f	f
4419	Russia	2020-05-29	2020-05-30	387623	4374	159257	223992	f	f
4420	Russia	2020-05-30	2020-05-31	396575	4555	167469	224551	f	f
4421	Russia	2020-05-31	2020-06-01	405843	4693	171883	229267	f	f
4422	Rwanda	2020-05-01	2020-05-02	249	0	109	140	f	f
4423	Rwanda	2020-05-02	2020-05-03	255	0	120	135	f	f
4424	Rwanda	2020-05-03	2020-05-04	259	0	124	135	f	f
4425	Rwanda	2020-05-04	2020-05-05	261	0	128	133	f	f
4426	Rwanda	2020-05-05	2020-05-06	261	0	129	132	f	f
4427	Rwanda	2020-05-06	2020-05-07	268	0	130	138	f	f
4428	Rwanda	2020-05-07	2020-05-08	271	0	133	138	f	f
4429	Rwanda	2020-05-08	2020-05-09	273	0	136	137	f	f
4430	Rwanda	2020-05-09	2020-05-10	280	0	140	140	f	f
4431	Rwanda	2020-05-10	2020-05-11	284	0	140	144	f	f
4432	Rwanda	2020-05-11	2020-05-12	285	0	150	135	f	f
4433	Rwanda	2020-05-12	2020-05-13	286	0	153	133	f	f
4434	Rwanda	2020-05-13	2020-05-14	287	0	164	123	f	f
4435	Rwanda	2020-05-14	2020-05-15	287	0	168	119	f	f
4436	Rwanda	2020-05-15	2020-05-16	287	0	177	110	f	f
4437	Rwanda	2020-05-16	2020-05-17	289	0	178	111	f	f
4438	Rwanda	2020-05-17	2020-05-18	292	0	197	95	f	f
4439	Rwanda	2020-05-18	2020-05-19	297	0	203	94	f	f
4440	Rwanda	2020-05-19	2020-05-20	308	0	209	99	f	f
4441	Rwanda	2020-05-20	2020-05-21	314	0	216	98	f	f
4442	Rwanda	2020-05-21	2020-05-22	320	0	217	103	f	f
4443	Rwanda	2020-05-22	2020-05-23	321	0	222	99	f	f
4444	Rwanda	2020-05-23	2020-05-24	325	0	227	98	f	f
4445	Rwanda	2020-05-24	2020-05-25	327	0	237	90	f	f
4446	Rwanda	2020-05-25	2020-05-26	336	0	238	98	f	f
4447	Rwanda	2020-05-26	2020-05-27	339	0	244	95	f	f
4448	Rwanda	2020-05-27	2020-05-28	346	0	245	101	f	f
4449	Rwanda	2020-05-28	2020-05-29	349	0	245	104	f	f
4450	Rwanda	2020-05-29	2020-05-30	355	0	247	108	f	f
4451	Rwanda	2020-05-30	2020-05-31	359	1	250	108	f	f
4452	Rwanda	2020-05-31	2020-06-01	370	1	256	113	f	f
4453	Saint Kitts and Nevis	2020-05-01	2020-05-02	15	0	8	7	f	f
4454	Saint Kitts and Nevis	2020-05-02	2020-05-03	15	0	8	7	f	f
4455	Saint Kitts and Nevis	2020-05-03	2020-05-04	15	0	8	7	f	f
4456	Saint Kitts and Nevis	2020-05-04	2020-05-05	15	0	8	7	f	f
4457	Saint Kitts and Nevis	2020-05-05	2020-05-06	15	0	12	3	f	f
4458	Saint Kitts and Nevis	2020-05-06	2020-05-07	15	0	12	3	f	f
4459	Saint Kitts and Nevis	2020-05-07	2020-05-08	15	0	12	3	f	f
4460	Saint Kitts and Nevis	2020-05-08	2020-05-09	15	0	13	2	f	f
4461	Saint Kitts and Nevis	2020-05-09	2020-05-10	15	0	14	1	f	f
4462	Saint Kitts and Nevis	2020-05-10	2020-05-11	15	0	14	1	f	f
4463	Saint Kitts and Nevis	2020-05-11	2020-05-12	15	0	14	1	f	f
4464	Saint Kitts and Nevis	2020-05-12	2020-05-13	15	0	14	1	f	f
4465	Saint Kitts and Nevis	2020-05-13	2020-05-14	15	0	14	1	f	f
4466	Saint Kitts and Nevis	2020-05-14	2020-05-15	15	0	14	1	f	f
4467	Saint Kitts and Nevis	2020-05-15	2020-05-16	15	0	14	1	f	f
4468	Saint Kitts and Nevis	2020-05-16	2020-05-17	15	0	14	1	f	f
4469	Saint Kitts and Nevis	2020-05-17	2020-05-18	15	0	14	1	f	f
4470	Saint Kitts and Nevis	2020-05-18	2020-05-19	15	0	14	1	f	f
4471	Saint Kitts and Nevis	2020-05-19	2020-05-20	15	0	15	0	f	f
4472	Saint Kitts and Nevis	2020-05-20	2020-05-21	15	0	15	0	f	f
4473	Saint Kitts and Nevis	2020-05-21	2020-05-22	15	0	15	0	f	f
4474	Saint Kitts and Nevis	2020-05-22	2020-05-23	15	0	15	0	f	f
4475	Saint Kitts and Nevis	2020-05-23	2020-05-24	15	0	15	0	f	f
4476	Saint Kitts and Nevis	2020-05-24	2020-05-25	15	0	15	0	f	f
4477	Saint Kitts and Nevis	2020-05-25	2020-05-26	15	0	15	0	f	f
4478	Saint Kitts and Nevis	2020-05-26	2020-05-27	15	0	15	0	f	f
4479	Saint Kitts and Nevis	2020-05-27	2020-05-28	15	0	15	0	f	f
4480	Saint Kitts and Nevis	2020-05-28	2020-05-29	15	0	15	0	f	f
4481	Saint Kitts and Nevis	2020-05-29	2020-05-30	15	0	15	0	f	f
4482	Saint Kitts and Nevis	2020-05-30	2020-05-31	15	0	15	0	f	f
4591	San Marino	2020-05-15	2020-05-16	652	41	189	422	f	f
4483	Saint Kitts and Nevis	2020-05-31	2020-06-01	15	0	15	0	f	f
4484	Saint Lucia	2020-05-01	2020-05-02	17	0	15	2	f	f
4485	Saint Lucia	2020-05-02	2020-05-03	17	0	15	2	f	f
4486	Saint Lucia	2020-05-03	2020-05-04	18	0	15	3	f	f
4487	Saint Lucia	2020-05-04	2020-05-05	18	0	15	3	f	f
4488	Saint Lucia	2020-05-05	2020-05-06	18	0	15	3	f	f
4489	Saint Lucia	2020-05-06	2020-05-07	18	0	15	3	f	f
4490	Saint Lucia	2020-05-07	2020-05-08	18	0	17	1	f	f
4491	Saint Lucia	2020-05-08	2020-05-09	18	0	17	1	f	f
4492	Saint Lucia	2020-05-09	2020-05-10	18	0	17	1	f	f
4493	Saint Lucia	2020-05-10	2020-05-11	18	0	17	1	f	f
4494	Saint Lucia	2020-05-11	2020-05-12	18	0	17	1	f	f
4495	Saint Lucia	2020-05-12	2020-05-13	18	0	17	1	f	f
4496	Saint Lucia	2020-05-13	2020-05-14	18	0	18	0	f	f
4497	Saint Lucia	2020-05-14	2020-05-15	18	0	18	0	f	f
4498	Saint Lucia	2020-05-15	2020-05-16	18	0	18	0	f	f
4499	Saint Lucia	2020-05-16	2020-05-17	18	0	18	0	f	f
4500	Saint Lucia	2020-05-17	2020-05-18	18	0	18	0	f	f
4501	Saint Lucia	2020-05-18	2020-05-19	18	0	18	0	f	f
4502	Saint Lucia	2020-05-19	2020-05-20	18	0	18	0	f	f
4503	Saint Lucia	2020-05-20	2020-05-21	18	0	18	0	f	f
4504	Saint Lucia	2020-05-21	2020-05-22	18	0	18	0	f	f
4505	Saint Lucia	2020-05-22	2020-05-23	18	0	18	0	f	f
4506	Saint Lucia	2020-05-23	2020-05-24	18	0	18	0	f	f
4507	Saint Lucia	2020-05-24	2020-05-25	18	0	18	0	f	f
4508	Saint Lucia	2020-05-25	2020-05-26	18	0	18	0	f	f
4509	Saint Lucia	2020-05-26	2020-05-27	18	0	18	0	f	f
4510	Saint Lucia	2020-05-27	2020-05-28	18	0	18	0	f	f
4511	Saint Lucia	2020-05-28	2020-05-29	18	0	18	0	f	f
4512	Saint Lucia	2020-05-29	2020-05-30	18	0	18	0	f	f
4513	Saint Lucia	2020-05-30	2020-05-31	18	0	18	0	f	f
4514	Saint Lucia	2020-05-31	2020-06-01	18	0	18	0	f	f
4515	Saint Vincent and the Grenadines	2020-05-01	2020-05-02	16	0	8	8	f	f
4516	Saint Vincent and the Grenadines	2020-05-02	2020-05-03	16	0	8	8	f	f
4517	Saint Vincent and the Grenadines	2020-05-03	2020-05-04	16	0	8	8	f	f
4518	Saint Vincent and the Grenadines	2020-05-04	2020-05-05	17	0	9	8	f	f
4519	Saint Vincent and the Grenadines	2020-05-05	2020-05-06	17	0	9	8	f	f
4520	Saint Vincent and the Grenadines	2020-05-06	2020-05-07	17	0	9	8	f	f
4521	Saint Vincent and the Grenadines	2020-05-07	2020-05-08	17	0	9	8	f	f
4522	Saint Vincent and the Grenadines	2020-05-08	2020-05-09	17	0	9	8	f	f
4523	Saint Vincent and the Grenadines	2020-05-09	2020-05-10	17	0	9	8	f	f
4524	Saint Vincent and the Grenadines	2020-05-10	2020-05-11	17	0	9	8	f	f
5070	Sudan	2020-05-29	2020-05-30	4346	233	816	3472	f	f
4525	Saint Vincent and the Grenadines	2020-05-11	2020-05-12	17	0	9	8	f	f
4526	Saint Vincent and the Grenadines	2020-05-12	2020-05-13	17	0	12	5	f	f
4527	Saint Vincent and the Grenadines	2020-05-13	2020-05-14	17	0	12	5	f	f
4528	Saint Vincent and the Grenadines	2020-05-14	2020-05-15	17	0	12	5	f	f
4529	Saint Vincent and the Grenadines	2020-05-15	2020-05-16	17	0	14	3	f	f
4530	Saint Vincent and the Grenadines	2020-05-16	2020-05-17	17	0	14	3	f	f
4531	Saint Vincent and the Grenadines	2020-05-17	2020-05-18	17	0	14	3	f	f
4532	Saint Vincent and the Grenadines	2020-05-18	2020-05-19	17	0	14	3	f	f
4533	Saint Vincent and the Grenadines	2020-05-19	2020-05-20	17	0	14	3	f	f
4534	Saint Vincent and the Grenadines	2020-05-20	2020-05-21	18	0	14	4	f	f
4535	Saint Vincent and the Grenadines	2020-05-21	2020-05-22	18	0	14	4	f	f
4536	Saint Vincent and the Grenadines	2020-05-22	2020-05-23	18	0	14	4	f	f
4537	Saint Vincent and the Grenadines	2020-05-23	2020-05-24	18	0	14	4	f	f
4538	Saint Vincent and the Grenadines	2020-05-24	2020-05-25	18	0	14	4	f	f
4539	Saint Vincent and the Grenadines	2020-05-25	2020-05-26	18	0	14	4	f	f
4540	Saint Vincent and the Grenadines	2020-05-26	2020-05-27	18	0	14	4	f	f
4541	Saint Vincent and the Grenadines	2020-05-27	2020-05-28	18	0	14	4	f	f
4542	Saint Vincent and the Grenadines	2020-05-28	2020-05-29	25	0	14	11	f	f
4543	Saint Vincent and the Grenadines	2020-05-29	2020-05-30	26	0	14	12	f	f
4544	Saint Vincent and the Grenadines	2020-05-30	2020-05-31	26	0	15	11	f	f
4545	Saint Vincent and the Grenadines	2020-05-31	2020-06-01	26	0	15	11	f	f
4546	Samoa	2020-05-01	2020-05-02	0	0	0	0	f	f
4547	Samoa	2020-05-02	2020-05-03	0	0	0	0	f	f
4548	Samoa	2020-05-03	2020-05-04	0	0	0	0	f	f
4549	Samoa	2020-05-04	2020-05-05	0	0	0	0	f	f
4550	Samoa	2020-05-05	2020-05-06	0	0	0	0	f	f
4551	Samoa	2020-05-06	2020-05-07	0	0	0	0	f	f
4552	Samoa	2020-05-07	2020-05-08	0	0	0	0	f	f
4553	Samoa	2020-05-08	2020-05-09	0	0	0	0	f	f
4554	Samoa	2020-05-09	2020-05-10	0	0	0	0	f	f
4555	Samoa	2020-05-10	2020-05-11	0	0	0	0	f	f
4556	Samoa	2020-05-11	2020-05-12	0	0	0	0	f	f
4557	Samoa	2020-05-12	2020-05-13	0	0	0	0	f	f
4558	Samoa	2020-05-13	2020-05-14	0	0	0	0	f	f
4559	Samoa	2020-05-14	2020-05-15	0	0	0	0	f	f
4560	Samoa	2020-05-15	2020-05-16	0	0	0	0	f	f
4561	Samoa	2020-05-16	2020-05-17	0	0	0	0	f	f
4562	Samoa	2020-05-17	2020-05-18	0	0	0	0	f	f
4563	Samoa	2020-05-18	2020-05-19	0	0	0	0	f	f
4564	Samoa	2020-05-19	2020-05-20	0	0	0	0	f	f
4565	Samoa	2020-05-20	2020-05-21	0	0	0	0	f	f
4566	Samoa	2020-05-21	2020-05-22	0	0	0	0	f	f
4567	Samoa	2020-05-22	2020-05-23	0	0	0	0	f	f
4568	Samoa	2020-05-23	2020-05-24	0	0	0	0	f	f
4569	Samoa	2020-05-24	2020-05-25	0	0	0	0	f	f
4570	Samoa	2020-05-25	2020-05-26	0	0	0	0	f	f
4571	Samoa	2020-05-26	2020-05-27	0	0	0	0	f	f
4572	Samoa	2020-05-27	2020-05-28	0	0	0	0	f	f
4573	Samoa	2020-05-28	2020-05-29	0	0	0	0	f	f
4574	Samoa	2020-05-29	2020-05-30	0	0	0	0	f	f
4575	Samoa	2020-05-30	2020-05-31	0	0	0	0	f	f
4576	Samoa	2020-05-31	2020-06-01	0	0	0	0	f	f
4577	San Marino	2020-05-01	2020-05-02	580	41	82	457	f	f
4578	San Marino	2020-05-02	2020-05-03	580	41	83	456	f	f
4579	San Marino	2020-05-03	2020-05-04	582	41	86	455	f	f
4580	San Marino	2020-05-04	2020-05-05	582	41	86	455	f	f
4581	San Marino	2020-05-05	2020-05-06	589	41	92	456	f	f
4582	San Marino	2020-05-06	2020-05-07	608	41	97	470	f	f
4583	San Marino	2020-05-07	2020-05-08	622	41	106	475	f	f
4584	San Marino	2020-05-08	2020-05-09	623	41	114	468	f	f
4585	San Marino	2020-05-09	2020-05-10	637	41	126	470	f	f
4586	San Marino	2020-05-10	2020-05-11	628	41	126	461	f	f
4587	San Marino	2020-05-11	2020-05-12	628	41	130	457	f	f
4588	San Marino	2020-05-12	2020-05-13	638	41	161	436	f	f
4589	San Marino	2020-05-13	2020-05-14	643	41	161	441	f	f
4590	San Marino	2020-05-14	2020-05-15	648	41	172	435	f	f
4592	San Marino	2020-05-16	2020-05-17	653	41	198	414	f	f
4593	San Marino	2020-05-17	2020-05-18	654	41	201	412	f	f
4594	San Marino	2020-05-18	2020-05-19	654	41	203	410	f	f
4595	San Marino	2020-05-19	2020-05-20	655	41	211	403	f	f
4596	San Marino	2020-05-20	2020-05-21	656	41	220	395	f	f
4597	San Marino	2020-05-21	2020-05-22	658	41	235	382	f	f
4598	San Marino	2020-05-22	2020-05-23	661	41	254	366	f	f
4599	San Marino	2020-05-23	2020-05-24	665	42	266	357	f	f
4600	San Marino	2020-05-24	2020-05-25	665	42	266	357	f	f
4601	San Marino	2020-05-25	2020-05-26	666	42	270	354	f	f
4602	San Marino	2020-05-26	2020-05-27	666	42	275	349	f	f
4603	San Marino	2020-05-27	2020-05-28	667	42	294	331	f	f
4604	San Marino	2020-05-28	2020-05-29	670	42	322	306	f	f
4605	San Marino	2020-05-29	2020-05-30	671	42	344	285	f	f
4606	San Marino	2020-05-30	2020-05-31	671	42	357	272	f	f
4607	San Marino	2020-05-31	2020-06-01	671	42	357	272	f	f
4608	Sao Tome and Principe	2020-05-01	2020-05-02	16	1	4	11	f	f
4609	Sao Tome and Principe	2020-05-02	2020-05-03	16	1	4	11	f	f
4610	Sao Tome and Principe	2020-05-03	2020-05-04	16	1	4	11	f	f
4611	Sao Tome and Principe	2020-05-04	2020-05-05	23	3	4	16	f	f
4612	Sao Tome and Principe	2020-05-05	2020-05-06	174	3	4	167	f	f
4613	Sao Tome and Principe	2020-05-06	2020-05-07	174	3	4	167	f	f
4614	Sao Tome and Principe	2020-05-07	2020-05-08	187	4	4	179	f	f
4615	Sao Tome and Principe	2020-05-08	2020-05-09	208	5	4	199	f	f
4616	Sao Tome and Principe	2020-05-09	2020-05-10	208	5	4	199	f	f
4617	Sao Tome and Principe	2020-05-10	2020-05-11	208	5	4	199	f	f
4618	Sao Tome and Principe	2020-05-11	2020-05-12	208	5	4	199	f	f
4619	Sao Tome and Principe	2020-05-12	2020-05-13	208	5	4	199	f	f
4620	Sao Tome and Principe	2020-05-13	2020-05-14	220	6	4	210	f	f
4621	Sao Tome and Principe	2020-05-14	2020-05-15	235	7	4	224	f	f
4622	Sao Tome and Principe	2020-05-15	2020-05-16	235	7	4	224	f	f
4623	Sao Tome and Principe	2020-05-16	2020-05-17	235	7	4	224	f	f
4624	Sao Tome and Principe	2020-05-17	2020-05-18	235	7	4	224	f	f
4625	Sao Tome and Principe	2020-05-18	2020-05-19	246	7	4	235	f	f
4626	Sao Tome and Principe	2020-05-19	2020-05-20	251	8	4	239	f	f
4627	Sao Tome and Principe	2020-05-20	2020-05-21	251	8	4	239	f	f
4628	Sao Tome and Principe	2020-05-21	2020-05-22	251	8	4	239	f	f
4629	Sao Tome and Principe	2020-05-22	2020-05-23	251	8	4	239	f	f
4630	Sao Tome and Principe	2020-05-23	2020-05-24	251	8	4	239	f	f
4631	Sao Tome and Principe	2020-05-24	2020-05-25	251	8	4	239	f	f
4632	Sao Tome and Principe	2020-05-25	2020-05-26	299	11	4	284	f	f
4633	Sao Tome and Principe	2020-05-26	2020-05-27	441	12	68	361	f	f
4634	Sao Tome and Principe	2020-05-27	2020-05-28	443	12	68	363	f	f
4635	Sao Tome and Principe	2020-05-28	2020-05-29	458	12	68	378	f	f
4636	Sao Tome and Principe	2020-05-29	2020-05-30	463	12	68	383	f	f
4637	Sao Tome and Principe	2020-05-30	2020-05-31	479	12	68	399	f	f
4638	Sao Tome and Principe	2020-05-31	2020-06-01	483	12	68	403	f	f
4639	Saudi Arabia	2020-05-01	2020-05-02	24097	169	3555	20373	f	f
4640	Saudi Arabia	2020-05-02	2020-05-03	25459	176	3765	21518	f	f
4641	Saudi Arabia	2020-05-03	2020-05-04	27011	184	4134	22693	f	f
4642	Saudi Arabia	2020-05-04	2020-05-05	28656	191	4476	23989	f	f
4643	Saudi Arabia	2020-05-05	2020-05-06	30251	200	5431	24620	f	f
4644	Saudi Arabia	2020-05-06	2020-05-07	31938	209	6783	24946	f	f
4645	Saudi Arabia	2020-05-07	2020-05-08	33731	219	7798	25714	f	f
4646	Saudi Arabia	2020-05-08	2020-05-09	35432	229	9120	26083	f	f
4647	Saudi Arabia	2020-05-09	2020-05-10	37136	239	10144	26753	f	f
4648	Saudi Arabia	2020-05-10	2020-05-11	39048	246	11457	27345	f	f
4649	Saudi Arabia	2020-05-11	2020-05-12	41014	255	12737	28022	f	f
4650	Saudi Arabia	2020-05-12	2020-05-13	42925	264	15257	27404	f	f
4651	Saudi Arabia	2020-05-13	2020-05-14	44830	273	17622	26935	f	f
4652	Saudi Arabia	2020-05-14	2020-05-15	46869	283	19051	27535	f	f
4653	Saudi Arabia	2020-05-15	2020-05-16	49176	292	21869	27015	f	f
4654	Saudi Arabia	2020-05-16	2020-05-17	52016	302	23666	28048	f	f
4655	Saudi Arabia	2020-05-17	2020-05-18	54752	312	25722	28718	f	f
4656	Saudi Arabia	2020-05-18	2020-05-19	57345	320	28748	28277	f	f
4657	Saudi Arabia	2020-05-19	2020-05-20	59854	329	31634	27891	f	f
4658	Saudi Arabia	2020-05-20	2020-05-21	62545	339	33478	28728	f	f
4659	Saudi Arabia	2020-05-21	2020-05-22	65077	351	36040	28686	f	f
4660	Saudi Arabia	2020-05-22	2020-05-23	67719	364	39003	28352	f	f
4661	Saudi Arabia	2020-05-23	2020-05-24	70161	379	41236	28546	f	f
4662	Saudi Arabia	2020-05-24	2020-05-25	72560	390	43520	28650	f	f
4663	Saudi Arabia	2020-05-25	2020-05-26	74795	399	45668	28728	f	f
4664	Saudi Arabia	2020-05-26	2020-05-27	76726	411	48450	27865	f	f
4665	Saudi Arabia	2020-05-27	2020-05-28	78541	425	51022	27094	f	f
4666	Saudi Arabia	2020-05-28	2020-05-29	80185	441	54553	25191	f	f
4667	Saudi Arabia	2020-05-29	2020-05-30	81766	458	57013	24295	f	f
4668	Saudi Arabia	2020-05-30	2020-05-31	83384	480	58883	24021	f	f
4669	Saudi Arabia	2020-05-31	2020-06-01	85261	503	62442	22316	f	f
4670	Senegal	2020-05-01	2020-05-02	1024	9	356	659	f	f
4671	Senegal	2020-05-02	2020-05-03	1115	9	368	738	f	f
4672	Senegal	2020-05-03	2020-05-04	1182	9	372	801	f	f
4673	Senegal	2020-05-04	2020-05-05	1271	10	415	846	f	f
4674	Senegal	2020-05-05	2020-05-06	1329	11	470	848	f	f
4675	Senegal	2020-05-06	2020-05-07	1433	12	493	928	f	f
4676	Senegal	2020-05-07	2020-05-08	1492	13	562	917	f	f
4677	Senegal	2020-05-08	2020-05-09	1551	13	611	927	f	f
4678	Senegal	2020-05-09	2020-05-10	1634	17	643	974	f	f
4679	Senegal	2020-05-10	2020-05-11	1709	19	650	1040	f	f
4680	Senegal	2020-05-11	2020-05-12	1886	19	715	1152	f	f
4681	Senegal	2020-05-12	2020-05-13	1995	19	742	1234	f	f
4682	Senegal	2020-05-13	2020-05-14	2105	21	782	1302	f	f
4683	Senegal	2020-05-14	2020-05-15	2189	23	842	1324	f	f
4684	Senegal	2020-05-15	2020-05-16	2310	25	890	1395	f	f
4685	Senegal	2020-05-16	2020-05-17	2429	25	949	1455	f	f
4686	Senegal	2020-05-17	2020-05-18	2480	25	973	1482	f	f
4687	Senegal	2020-05-18	2020-05-19	2544	26	1076	1442	f	f
4688	Senegal	2020-05-19	2020-05-20	2617	30	1133	1454	f	f
4689	Senegal	2020-05-20	2020-05-21	2714	30	1186	1498	f	f
4690	Senegal	2020-05-21	2020-05-22	2812	33	1251	1528	f	f
4691	Senegal	2020-05-22	2020-05-23	2909	33	1311	1565	f	f
4692	Senegal	2020-05-23	2020-05-24	2976	34	1416	1526	f	f
4693	Senegal	2020-05-24	2020-05-25	3047	35	1456	1556	f	f
4694	Senegal	2020-05-25	2020-05-26	3130	35	1515	1580	f	f
4695	Senegal	2020-05-26	2020-05-27	3161	36	1565	1560	f	f
4696	Senegal	2020-05-27	2020-05-28	3253	38	1586	1629	f	f
4697	Senegal	2020-05-28	2020-05-29	3348	39	1686	1623	f	f
4698	Senegal	2020-05-29	2020-05-30	3429	41	1738	1650	f	f
4699	Senegal	2020-05-30	2020-05-31	3535	42	1761	1732	f	f
4700	Senegal	2020-05-31	2020-06-01	3645	42	1801	1802	f	f
4701	Serbia	2020-05-01	2020-05-02	9009	179	1343	7487	f	f
4702	Serbia	2020-05-02	2020-05-03	9362	189	1426	7747	f	f
4703	Serbia	2020-05-03	2020-05-04	9464	193	1551	7720	f	f
4704	Serbia	2020-05-04	2020-05-05	9557	197	1574	7786	f	f
4705	Serbia	2020-05-05	2020-05-06	9677	200	1723	7754	f	f
4706	Serbia	2020-05-06	2020-05-07	9791	203	1971	7617	f	f
4707	Serbia	2020-05-07	2020-05-08	9848	206	2160	7482	f	f
4708	Serbia	2020-05-08	2020-05-09	9943	209	2453	7281	f	f
4709	Serbia	2020-05-09	2020-05-10	10032	215	2732	7085	f	f
4710	Serbia	2020-05-10	2020-05-11	10032	215	2732	7085	f	f
4711	Serbia	2020-05-11	2020-05-12	10176	218	3290	6668	f	f
4712	Serbia	2020-05-12	2020-05-13	10243	220	3600	6423	f	f
4713	Serbia	2020-05-13	2020-05-14	10295	222	3824	6249	f	f
4714	Serbia	2020-05-14	2020-05-15	10374	224	4084	6066	f	f
4715	Serbia	2020-05-15	2020-05-16	10438	225	4301	5912	f	f
4716	Serbia	2020-05-16	2020-05-17	10496	228	4479	5789	f	f
4717	Serbia	2020-05-17	2020-05-18	10610	230	4713	5667	f	f
4718	Serbia	2020-05-18	2020-05-19	10699	231	4799	5669	f	f
4719	Serbia	2020-05-19	2020-05-20	10733	234	4904	5595	f	f
4720	Serbia	2020-05-20	2020-05-21	10833	235	5067	5531	f	f
4721	Serbia	2020-05-21	2020-05-22	10919	237	5370	5312	f	f
4722	Serbia	2020-05-22	2020-05-23	11024	237	5541	5246	f	f
4723	Serbia	2020-05-23	2020-05-24	11092	238	5699	5155	f	f
4724	Serbia	2020-05-24	2020-05-25	11159	238	5857	5064	f	f
4725	Serbia	2020-05-25	2020-05-26	11193	239	5920	5034	f	f
4726	Serbia	2020-05-26	2020-05-27	11227	239	6067	4921	f	f
4727	Serbia	2020-05-27	2020-05-28	11275	240	6277	4758	f	f
4728	Serbia	2020-05-28	2020-05-29	11300	241	6438	4621	f	f
4729	Serbia	2020-05-29	2020-05-30	11354	242	6524	4588	f	f
4730	Serbia	2020-05-30	2020-05-31	11381	242	6606	4533	f	f
4731	Serbia	2020-05-31	2020-06-01	11412	243	6698	4471	f	f
4732	Seychelles	2020-05-01	2020-05-02	11	0	6	5	f	f
4733	Seychelles	2020-05-02	2020-05-03	11	0	6	5	f	f
4734	Seychelles	2020-05-03	2020-05-04	11	0	6	5	f	f
4735	Seychelles	2020-05-04	2020-05-05	11	0	6	5	f	f
4736	Seychelles	2020-05-05	2020-05-06	11	0	8	3	f	f
4737	Seychelles	2020-05-06	2020-05-07	11	0	8	3	f	f
4738	Seychelles	2020-05-07	2020-05-08	11	0	8	3	f	f
4739	Seychelles	2020-05-08	2020-05-09	11	0	8	3	f	f
4740	Seychelles	2020-05-09	2020-05-10	11	0	8	3	f	f
4741	Seychelles	2020-05-10	2020-05-11	11	0	10	1	f	f
4742	Seychelles	2020-05-11	2020-05-12	11	0	10	1	f	f
4743	Seychelles	2020-05-12	2020-05-13	11	0	10	1	f	f
4744	Seychelles	2020-05-13	2020-05-14	11	0	10	1	f	f
4745	Seychelles	2020-05-14	2020-05-15	11	0	10	1	f	f
4746	Seychelles	2020-05-15	2020-05-16	11	0	10	1	f	f
4747	Seychelles	2020-05-16	2020-05-17	11	0	10	1	f	f
4748	Seychelles	2020-05-17	2020-05-18	11	0	10	1	f	f
4749	Seychelles	2020-05-18	2020-05-19	11	0	11	0	f	f
4750	Seychelles	2020-05-19	2020-05-20	11	0	11	0	f	f
4751	Seychelles	2020-05-20	2020-05-21	11	0	11	0	f	f
4752	Seychelles	2020-05-21	2020-05-22	11	0	11	0	f	f
4753	Seychelles	2020-05-22	2020-05-23	11	0	11	0	f	f
4754	Seychelles	2020-05-23	2020-05-24	11	0	11	0	f	f
4755	Seychelles	2020-05-24	2020-05-25	11	0	11	0	f	f
4756	Seychelles	2020-05-25	2020-05-26	11	0	11	0	f	f
4757	Seychelles	2020-05-26	2020-05-27	11	0	11	0	f	f
4758	Seychelles	2020-05-27	2020-05-28	11	0	11	0	f	f
4759	Seychelles	2020-05-28	2020-05-29	11	0	11	0	f	f
4760	Seychelles	2020-05-29	2020-05-30	11	0	11	0	f	f
4761	Seychelles	2020-05-30	2020-05-31	11	0	11	0	f	f
4762	Seychelles	2020-05-31	2020-06-01	11	0	11	0	f	f
4763	Sierra Leone	2020-05-01	2020-05-02	136	7	21	108	f	f
4764	Sierra Leone	2020-05-02	2020-05-03	155	8	21	126	f	f
4765	Sierra Leone	2020-05-03	2020-05-04	166	8	29	129	f	f
4766	Sierra Leone	2020-05-04	2020-05-05	178	9	37	132	f	f
4767	Sierra Leone	2020-05-05	2020-05-06	199	11	43	145	f	f
4768	Sierra Leone	2020-05-06	2020-05-07	225	14	54	157	f	f
4769	Sierra Leone	2020-05-07	2020-05-08	231	16	54	161	f	f
4770	Sierra Leone	2020-05-08	2020-05-09	257	17	54	186	f	f
4771	Sierra Leone	2020-05-09	2020-05-10	291	18	58	215	f	f
4772	Sierra Leone	2020-05-10	2020-05-11	307	18	67	222	f	f
4773	Sierra Leone	2020-05-11	2020-05-12	338	19	72	247	f	f
4774	Sierra Leone	2020-05-12	2020-05-13	338	19	72	247	f	f
4775	Sierra Leone	2020-05-13	2020-05-14	387	26	97	264	f	f
4776	Sierra Leone	2020-05-14	2020-05-15	408	26	97	285	f	f
4777	Sierra Leone	2020-05-15	2020-05-16	447	27	97	323	f	f
4778	Sierra Leone	2020-05-16	2020-05-17	462	29	106	327	f	f
4779	Sierra Leone	2020-05-17	2020-05-18	505	32	141	332	f	f
4780	Sierra Leone	2020-05-18	2020-05-19	519	33	148	338	f	f
4781	Sierra Leone	2020-05-19	2020-05-20	534	33	167	334	f	f
4782	Sierra Leone	2020-05-20	2020-05-21	570	34	205	331	f	f
4783	Sierra Leone	2020-05-21	2020-05-22	585	35	205	345	f	f
4784	Sierra Leone	2020-05-22	2020-05-23	606	38	230	338	f	f
4785	Sierra Leone	2020-05-23	2020-05-24	621	39	241	341	f	f
4786	Sierra Leone	2020-05-24	2020-05-25	707	40	241	426	f	f
4787	Sierra Leone	2020-05-25	2020-05-26	735	42	293	400	f	f
4788	Sierra Leone	2020-05-26	2020-05-27	754	44	297	413	f	f
4789	Sierra Leone	2020-05-27	2020-05-28	782	45	297	440	f	f
4790	Sierra Leone	2020-05-28	2020-05-29	812	45	361	406	f	f
4791	Sierra Leone	2020-05-29	2020-05-30	829	45	386	398	f	f
4792	Sierra Leone	2020-05-30	2020-05-31	852	46	415	391	f	f
4793	Sierra Leone	2020-05-31	2020-06-01	861	46	454	361	f	f
4794	Singapore	2020-05-01	2020-05-02	17101	16	1268	15817	f	f
4795	Singapore	2020-05-02	2020-05-03	17548	17	1347	16184	f	f
4796	Singapore	2020-05-03	2020-05-04	18205	18	1408	16779	f	f
4797	Singapore	2020-05-04	2020-05-05	18778	18	1457	17303	f	f
4798	Singapore	2020-05-05	2020-05-06	19410	18	1519	17873	f	f
4799	Singapore	2020-05-06	2020-05-07	20198	20	1634	18544	f	f
4800	Singapore	2020-05-07	2020-05-08	20939	20	1712	19207	f	f
4801	Singapore	2020-05-08	2020-05-09	21707	20	2040	19647	f	f
4802	Singapore	2020-05-09	2020-05-10	22460	20	2296	20144	f	f
4803	Singapore	2020-05-10	2020-05-11	23336	20	2721	20595	f	f
4804	Singapore	2020-05-11	2020-05-12	23822	21	3225	20576	f	f
4805	Singapore	2020-05-12	2020-05-13	24671	21	3851	20799	f	f
4806	Singapore	2020-05-13	2020-05-14	25346	21	4809	20516	f	f
4807	Singapore	2020-05-14	2020-05-15	26098	21	5973	20104	f	f
4808	Singapore	2020-05-15	2020-05-16	26891	21	7248	19622	f	f
4809	Singapore	2020-05-16	2020-05-17	27356	22	8342	18992	f	f
4810	Singapore	2020-05-17	2020-05-18	28038	22	9340	18676	f	f
4811	Singapore	2020-05-18	2020-05-19	28343	22	9835	18486	f	f
4812	Singapore	2020-05-19	2020-05-20	28794	22	10365	18407	f	f
4813	Singapore	2020-05-20	2020-05-21	29364	22	11207	18135	f	f
4814	Singapore	2020-05-21	2020-05-22	29812	23	12117	17672	f	f
4815	Singapore	2020-05-22	2020-05-23	30426	23	12995	17408	f	f
4816	Singapore	2020-05-23	2020-05-24	31068	23	13882	17163	f	f
4817	Singapore	2020-05-24	2020-05-25	31616	23	14876	16717	f	f
4818	Singapore	2020-05-25	2020-05-26	31960	23	15738	16199	f	f
4819	Singapore	2020-05-26	2020-05-27	32343	23	16444	15876	f	f
4820	Singapore	2020-05-27	2020-05-28	32876	23	17276	15577	f	f
4821	Singapore	2020-05-28	2020-05-29	33249	23	18294	14932	f	f
4822	Singapore	2020-05-29	2020-05-30	33860	23	19631	14206	f	f
4823	Singapore	2020-05-30	2020-05-31	34366	23	20727	13616	f	f
4824	Singapore	2020-05-31	2020-06-01	34884	23	21699	13162	f	f
4825	Slovakia	2020-05-01	2020-05-02	1403	23	558	822	f	f
4826	Slovakia	2020-05-02	2020-05-03	1407	24	608	775	f	f
4827	Slovakia	2020-05-03	2020-05-04	1408	24	619	765	f	f
4828	Slovakia	2020-05-04	2020-05-05	1413	25	643	745	f	f
4829	Slovakia	2020-05-05	2020-05-06	1421	25	741	655	f	f
4830	Slovakia	2020-05-06	2020-05-07	1429	25	762	642	f	f
4831	Slovakia	2020-05-07	2020-05-08	1445	26	806	613	f	f
4832	Slovakia	2020-05-08	2020-05-09	1455	26	905	524	f	f
4833	Slovakia	2020-05-09	2020-05-10	1455	26	919	510	f	f
4834	Slovakia	2020-05-10	2020-05-11	1457	26	941	490	f	f
4835	Slovakia	2020-05-11	2020-05-12	1457	26	959	472	f	f
4836	Slovakia	2020-05-12	2020-05-13	1465	27	983	455	f	f
4837	Slovakia	2020-05-13	2020-05-14	1469	27	1060	382	f	f
4838	Slovakia	2020-05-14	2020-05-15	1477	27	1112	338	f	f
4839	Slovakia	2020-05-15	2020-05-16	1480	27	1131	322	f	f
4840	Slovakia	2020-05-16	2020-05-17	1493	28	1151	314	f	f
4841	Slovakia	2020-05-17	2020-05-18	1494	28	1163	303	f	f
4842	Slovakia	2020-05-18	2020-05-19	1495	28	1185	282	f	f
4843	Slovakia	2020-05-19	2020-05-20	1495	28	1192	275	f	f
4844	Slovakia	2020-05-20	2020-05-21	1496	28	1231	237	f	f
4845	Slovakia	2020-05-21	2020-05-22	1502	28	1245	229	f	f
4846	Slovakia	2020-05-22	2020-05-23	1503	28	1256	219	f	f
4847	Slovakia	2020-05-23	2020-05-24	1504	28	1280	196	f	f
4848	Slovakia	2020-05-24	2020-05-25	1509	28	1301	180	f	f
4849	Slovakia	2020-05-25	2020-05-26	1511	28	1307	176	f	f
4850	Slovakia	2020-05-26	2020-05-27	1513	28	1322	163	f	f
4851	Slovakia	2020-05-27	2020-05-28	1515	28	1327	160	f	f
4852	Slovakia	2020-05-28	2020-05-29	1520	28	1332	160	f	f
4853	Slovakia	2020-05-29	2020-05-30	1520	28	1338	154	f	f
4854	Slovakia	2020-05-30	2020-05-31	1521	28	1356	137	f	f
4855	Slovakia	2020-05-31	2020-06-01	1521	28	1366	127	f	f
4856	Slovenia	2020-05-01	2020-05-02	1434	92	233	1109	f	f
4857	Slovenia	2020-05-02	2020-05-03	1439	94	239	1106	f	f
4858	Slovenia	2020-05-03	2020-05-04	1439	96	241	1102	f	f
4859	Slovenia	2020-05-04	2020-05-05	1439	97	241	1101	f	f
4860	Slovenia	2020-05-05	2020-05-06	1445	98	244	1103	f	f
4861	Slovenia	2020-05-06	2020-05-07	1448	99	246	1103	f	f
4862	Slovenia	2020-05-07	2020-05-08	1449	99	247	1103	f	f
4863	Slovenia	2020-05-08	2020-05-09	1450	100	252	1098	f	f
4864	Slovenia	2020-05-09	2020-05-10	1454	101	255	1098	f	f
4865	Slovenia	2020-05-10	2020-05-11	1457	102	256	1099	f	f
4866	Slovenia	2020-05-11	2020-05-12	1460	102	256	1102	f	f
4867	Slovenia	2020-05-12	2020-05-13	1461	102	259	1100	f	f
4868	Slovenia	2020-05-13	2020-05-14	1463	103	260	1100	f	f
4869	Slovenia	2020-05-14	2020-05-15	1464	103	267	1094	f	f
4870	Slovenia	2020-05-15	2020-05-16	1465	103	270	1092	f	f
4871	Slovenia	2020-05-16	2020-05-17	1465	103	272	1090	f	f
4872	Slovenia	2020-05-17	2020-05-18	1466	104	273	1089	f	f
4873	Slovenia	2020-05-18	2020-05-19	1466	104	1335	27	f	f
4874	Slovenia	2020-05-19	2020-05-20	1467	104	1338	25	f	f
4875	Slovenia	2020-05-20	2020-05-21	1468	105	1340	23	f	f
4876	Slovenia	2020-05-21	2020-05-22	1468	106	1340	22	f	f
4877	Slovenia	2020-05-22	2020-05-23	1468	106	1340	22	f	f
4878	Slovenia	2020-05-23	2020-05-24	1468	106	1340	22	f	f
4879	Slovenia	2020-05-24	2020-05-25	1468	107	1340	21	f	f
4880	Slovenia	2020-05-25	2020-05-26	1469	107	1346	16	f	f
4881	Slovenia	2020-05-26	2020-05-27	1469	108	1346	15	f	f
4882	Slovenia	2020-05-27	2020-05-28	1471	108	1354	9	f	f
4883	Slovenia	2020-05-28	2020-05-29	1473	108	1356	9	f	f
4884	Slovenia	2020-05-29	2020-05-30	1473	108	1357	8	f	f
4885	Slovenia	2020-05-30	2020-05-31	1473	108	1357	8	f	f
4886	Slovenia	2020-05-31	2020-06-01	1473	108	1358	7	f	f
4887	Somalia	2020-05-01	2020-05-02	601	28	31	542	f	f
4888	Somalia	2020-05-02	2020-05-03	671	31	34	606	f	f
4889	Somalia	2020-05-03	2020-05-04	722	32	44	646	f	f
4890	Somalia	2020-05-04	2020-05-05	756	35	61	660	f	f
4891	Somalia	2020-05-05	2020-05-06	835	38	75	722	f	f
4892	Somalia	2020-05-06	2020-05-07	873	39	87	747	f	f
4893	Somalia	2020-05-07	2020-05-08	928	44	106	778	f	f
4894	Somalia	2020-05-08	2020-05-09	928	44	106	778	f	f
4895	Somalia	2020-05-09	2020-05-10	997	48	110	839	f	f
4896	Somalia	2020-05-10	2020-05-11	1054	51	118	885	f	f
4897	Somalia	2020-05-11	2020-05-12	1089	52	121	916	f	f
4898	Somalia	2020-05-12	2020-05-13	1170	52	126	992	f	f
4899	Somalia	2020-05-13	2020-05-14	1219	52	130	1037	f	f
4900	Somalia	2020-05-14	2020-05-15	1284	53	135	1096	f	f
4901	Somalia	2020-05-15	2020-05-16	1284	53	135	1096	f	f
4902	Somalia	2020-05-16	2020-05-17	1357	55	148	1154	f	f
4903	Somalia	2020-05-17	2020-05-18	1421	56	152	1213	f	f
4904	Somalia	2020-05-18	2020-05-19	1455	57	163	1235	f	f
4905	Somalia	2020-05-19	2020-05-20	1502	59	178	1265	f	f
4906	Somalia	2020-05-20	2020-05-21	1573	61	188	1324	f	f
4907	Somalia	2020-05-21	2020-05-22	1594	61	204	1329	f	f
4908	Somalia	2020-05-22	2020-05-23	1594	61	204	1329	f	f
4909	Somalia	2020-05-23	2020-05-24	1594	61	204	1329	f	f
4910	Somalia	2020-05-24	2020-05-25	1594	61	204	1329	f	f
4911	Somalia	2020-05-25	2020-05-26	1689	66	235	1388	f	f
4912	Somalia	2020-05-26	2020-05-27	1711	67	253	1391	f	f
4913	Somalia	2020-05-27	2020-05-28	1731	67	265	1399	f	f
4914	Somalia	2020-05-28	2020-05-29	1828	72	310	1446	f	f
4915	Somalia	2020-05-29	2020-05-30	1828	72	310	1446	f	f
4916	Somalia	2020-05-30	2020-05-31	1916	73	327	1516	f	f
4917	Somalia	2020-05-31	2020-06-01	1976	78	348	1550	f	f
4918	South Africa	2020-05-01	2020-05-02	5951	116	2382	3453	f	f
4919	South Africa	2020-05-02	2020-05-03	6336	123	2549	3664	f	f
4920	South Africa	2020-05-03	2020-05-04	6783	131	2549	4103	f	f
4921	South Africa	2020-05-04	2020-05-05	7220	138	2746	4336	f	f
4922	South Africa	2020-05-05	2020-05-06	7572	148	2746	4678	f	f
4923	South Africa	2020-05-06	2020-05-07	7808	153	3153	4502	f	f
4924	South Africa	2020-05-07	2020-05-08	8232	161	3153	4918	f	f
4925	South Africa	2020-05-08	2020-05-09	8895	178	3153	5564	f	f
4926	South Africa	2020-05-09	2020-05-10	9420	186	3983	5251	f	f
4927	South Africa	2020-05-10	2020-05-11	10015	194	4173	5648	f	f
4928	South Africa	2020-05-11	2020-05-12	10652	206	4357	6089	f	f
4929	South Africa	2020-05-12	2020-05-13	11350	206	4357	6787	f	f
4930	South Africa	2020-05-13	2020-05-14	12074	219	4745	7110	f	f
4931	South Africa	2020-05-14	2020-05-15	12739	238	5676	6825	f	f
4932	South Africa	2020-05-15	2020-05-16	13524	247	6083	7194	f	f
4933	South Africa	2020-05-16	2020-05-17	14355	261	6478	7616	f	f
4934	South Africa	2020-05-17	2020-05-18	15515	264	7006	8245	f	f
4935	South Africa	2020-05-18	2020-05-19	16433	286	7298	8849	f	f
4936	South Africa	2020-05-19	2020-05-20	17200	312	7960	8928	f	f
4937	South Africa	2020-05-20	2020-05-21	18003	339	8950	8714	f	f
4938	South Africa	2020-05-21	2020-05-22	19137	369	8950	9818	f	f
4939	South Africa	2020-05-22	2020-05-23	20125	397	10104	9624	f	f
4940	South Africa	2020-05-23	2020-05-24	21343	407	10104	10832	f	f
4941	South Africa	2020-05-24	2020-05-25	22583	429	11100	11054	f	f
4942	South Africa	2020-05-25	2020-05-26	23615	481	11917	11217	f	f
4943	South Africa	2020-05-26	2020-05-27	24264	524	12741	10999	f	f
4944	South Africa	2020-05-27	2020-05-28	25937	552	13451	11934	f	f
4945	South Africa	2020-05-28	2020-05-29	27403	577	14370	12456	f	f
4946	South Africa	2020-05-29	2020-05-30	29240	611	15093	13536	f	f
4947	South Africa	2020-05-30	2020-05-31	30967	643	16116	14208	f	f
4948	South Africa	2020-05-31	2020-06-01	32683	683	16809	15191	f	f
4949	South Sudan	2020-05-01	2020-05-02	45	0	0	45	f	f
4950	South Sudan	2020-05-02	2020-05-03	45	0	0	45	f	f
4951	South Sudan	2020-05-03	2020-05-04	46	0	0	46	f	f
4952	South Sudan	2020-05-04	2020-05-05	46	0	0	46	f	f
4953	South Sudan	2020-05-05	2020-05-06	52	0	0	52	f	f
4954	South Sudan	2020-05-06	2020-05-07	58	0	0	58	f	f
4955	South Sudan	2020-05-07	2020-05-08	74	0	0	74	f	f
4956	South Sudan	2020-05-08	2020-05-09	120	0	2	118	f	f
4957	South Sudan	2020-05-09	2020-05-10	120	0	2	118	f	f
4958	South Sudan	2020-05-10	2020-05-11	120	0	2	118	f	f
4959	South Sudan	2020-05-11	2020-05-12	156	0	2	154	f	f
4960	South Sudan	2020-05-12	2020-05-13	194	0	2	192	f	f
4961	South Sudan	2020-05-13	2020-05-14	203	0	2	201	f	f
4962	South Sudan	2020-05-14	2020-05-15	203	0	3	200	f	f
4963	South Sudan	2020-05-15	2020-05-16	236	4	4	228	f	f
4964	South Sudan	2020-05-16	2020-05-17	236	4	4	228	f	f
4965	South Sudan	2020-05-17	2020-05-18	290	4	4	282	f	f
4966	South Sudan	2020-05-18	2020-05-19	290	4	4	282	f	f
4967	South Sudan	2020-05-19	2020-05-20	290	4	4	282	f	f
4968	South Sudan	2020-05-20	2020-05-21	290	4	4	282	f	f
4969	South Sudan	2020-05-21	2020-05-22	481	4	4	473	f	f
4970	South Sudan	2020-05-22	2020-05-23	563	6	6	551	f	f
4971	South Sudan	2020-05-23	2020-05-24	655	8	6	641	f	f
4972	South Sudan	2020-05-24	2020-05-25	655	8	6	641	f	f
4973	South Sudan	2020-05-25	2020-05-26	806	8	6	792	f	f
4974	South Sudan	2020-05-26	2020-05-27	806	8	6	792	f	f
4975	South Sudan	2020-05-27	2020-05-28	994	10	6	978	f	f
4976	South Sudan	2020-05-28	2020-05-29	994	10	6	978	f	f
4977	South Sudan	2020-05-29	2020-05-30	994	10	6	978	f	f
4978	South Sudan	2020-05-30	2020-05-31	994	10	6	978	f	f
4979	South Sudan	2020-05-31	2020-06-01	994	10	6	978	f	f
4980	Spain	2020-05-01	2020-05-02	213435	24543	112050	76842	f	f
4981	Spain	2020-05-02	2020-05-03	216582	25100	117248	74234	f	f
4982	Spain	2020-05-03	2020-05-04	217466	25264	118902	73300	f	f
4983	Spain	2020-05-04	2020-05-05	218011	25428	121343	71240	f	f
4984	Spain	2020-05-05	2020-05-06	219329	25613	123486	70230	f	f
4985	Spain	2020-05-06	2020-05-07	220325	25857	126002	68466	f	f
4986	Spain	2020-05-07	2020-05-08	221447	26070	128511	66866	f	f
4987	Spain	2020-05-08	2020-05-09	222857	26299	131148	65410	f	f
4988	Spain	2020-05-09	2020-05-10	223578	26478	133952	63148	f	f
4989	Spain	2020-05-10	2020-05-11	224350	26621	136166	61563	f	f
4990	Spain	2020-05-11	2020-05-12	227436	26744	137139	63553	f	f
4991	Spain	2020-05-12	2020-05-13	228030	26920	138980	62130	f	f
4992	Spain	2020-05-13	2020-05-14	228691	27104	140823	60764	f	f
4993	Spain	2020-05-14	2020-05-15	229540	27321	143374	58845	f	f
4994	Spain	2020-05-15	2020-05-16	230183	27459	144783	57941	f	f
4995	Spain	2020-05-16	2020-05-17	230698	27563	146446	56689	f	f
4996	Spain	2020-05-17	2020-05-18	230698	27563	146446	56689	f	f
4997	Spain	2020-05-18	2020-05-19	231606	27709	150376	53521	f	f
4998	Spain	2020-05-19	2020-05-20	232037	27778	150376	53883	f	f
4999	Spain	2020-05-20	2020-05-21	232555	27888	150376	54291	f	f
5000	Spain	2020-05-21	2020-05-22	233037	27940	150376	54721	f	f
5001	Spain	2020-05-22	2020-05-23	234824	28628	150376	55820	f	f
5002	Spain	2020-05-23	2020-05-24	235290	28678	150376	56236	f	f
5003	Spain	2020-05-24	2020-05-25	235772	28752	150376	56644	f	f
5004	Spain	2020-05-25	2020-05-26	235400	26834	150376	58190	f	f
5005	Spain	2020-05-26	2020-05-27	236259	27117	150376	58766	f	f
5006	Spain	2020-05-27	2020-05-28	236259	27117	150376	58766	f	f
5007	Spain	2020-05-28	2020-05-29	237906	27119	150376	60411	f	f
5008	Spain	2020-05-29	2020-05-30	238564	27121	150376	61067	f	f
5009	Spain	2020-05-30	2020-05-31	239228	27125	150376	61727	f	f
5010	Spain	2020-05-31	2020-06-01	239479	27127	150376	61976	f	f
5011	Sri Lanka	2020-05-01	2020-05-02	690	7	162	521	f	f
5012	Sri Lanka	2020-05-02	2020-05-03	705	7	172	526	f	f
5013	Sri Lanka	2020-05-03	2020-05-04	718	7	184	527	f	f
5014	Sri Lanka	2020-05-04	2020-05-05	751	8	194	549	f	f
5015	Sri Lanka	2020-05-05	2020-05-06	771	9	213	549	f	f
5016	Sri Lanka	2020-05-06	2020-05-07	797	9	215	573	f	f
5017	Sri Lanka	2020-05-07	2020-05-08	824	9	232	583	f	f
5018	Sri Lanka	2020-05-08	2020-05-09	835	9	240	586	f	f
5019	Sri Lanka	2020-05-09	2020-05-10	847	9	260	578	f	f
5020	Sri Lanka	2020-05-10	2020-05-11	863	9	321	533	f	f
5021	Sri Lanka	2020-05-11	2020-05-12	869	9	343	517	f	f
5022	Sri Lanka	2020-05-12	2020-05-13	889	9	366	514	f	f
5023	Sri Lanka	2020-05-13	2020-05-14	915	9	382	524	f	f
5024	Sri Lanka	2020-05-14	2020-05-15	925	9	445	471	f	f
5025	Sri Lanka	2020-05-15	2020-05-16	935	9	477	449	f	f
5026	Sri Lanka	2020-05-16	2020-05-17	960	9	520	431	f	f
5027	Sri Lanka	2020-05-17	2020-05-18	981	9	538	434	f	f
5028	Sri Lanka	2020-05-18	2020-05-19	992	9	559	424	f	f
5029	Sri Lanka	2020-05-19	2020-05-20	1027	9	569	449	f	f
5030	Sri Lanka	2020-05-20	2020-05-21	1028	9	584	435	f	f
5031	Sri Lanka	2020-05-21	2020-05-22	1055	9	604	442	f	f
5032	Sri Lanka	2020-05-22	2020-05-23	1068	9	620	439	f	f
5033	Sri Lanka	2020-05-23	2020-05-24	1089	9	660	420	f	f
5034	Sri Lanka	2020-05-24	2020-05-25	1141	9	674	458	f	f
5035	Sri Lanka	2020-05-25	2020-05-26	1182	10	695	477	f	f
5036	Sri Lanka	2020-05-26	2020-05-27	1319	10	712	597	f	f
5037	Sri Lanka	2020-05-27	2020-05-28	1469	10	732	727	f	f
5038	Sri Lanka	2020-05-28	2020-05-29	1530	10	745	775	f	f
5039	Sri Lanka	2020-05-29	2020-05-30	1558	10	754	794	f	f
5040	Sri Lanka	2020-05-30	2020-05-31	1620	10	781	829	f	f
5041	Sri Lanka	2020-05-31	2020-06-01	1633	10	801	822	f	f
5042	Sudan	2020-05-01	2020-05-02	442	36	46	451	f	f
5043	Sudan	2020-05-02	2020-05-03	533	41	52	499	f	f
5044	Sudan	2020-05-03	2020-05-04	592	41	52	499	f	f
5045	Sudan	2020-05-04	2020-05-05	678	41	61	576	f	f
5046	Sudan	2020-05-05	2020-05-06	778	45	70	663	f	f
5047	Sudan	2020-05-06	2020-05-07	852	49	80	723	f	f
5048	Sudan	2020-05-07	2020-05-08	930	52	92	786	f	f
5049	Sudan	2020-05-08	2020-05-09	930	59	102	950	f	f
5050	Sudan	2020-05-09	2020-05-10	1111	64	119	981	f	f
5051	Sudan	2020-05-10	2020-05-11	1164	70	149	1146	f	f
5052	Sudan	2020-05-11	2020-05-12	1365	74	162	1290	f	f
5053	Sudan	2020-05-12	2020-05-13	1526	80	173	1408	f	f
5054	Sudan	2020-05-13	2020-05-14	1660	90	198	1530	f	f
5055	Sudan	2020-05-14	2020-05-15	1818	90	198	1530	f	f
5056	Sudan	2020-05-15	2020-05-16	1964	91	205	1668	f	f
5057	Sudan	2020-05-16	2020-05-17	1964	97	222	1970	f	f
5058	Sudan	2020-05-17	2020-05-18	2289	97	222	1970	f	f
5059	Sudan	2020-05-18	2020-05-19	2591	105	247	2239	f	f
5060	Sudan	2020-05-19	2020-05-20	2591	111	286	2331	f	f
5061	Sudan	2020-05-20	2020-05-21	2728	111	286	2331	f	f
5062	Sudan	2020-05-21	2020-05-22	3138	121	309	2708	f	f
5063	Sudan	2020-05-22	2020-05-23	3138	137	372	2869	f	f
5064	Sudan	2020-05-23	2020-05-24	3378	146	424	3058	f	f
5065	Sudan	2020-05-24	2020-05-25	3634	165	458	3197	f	f
5066	Sudan	2020-05-25	2020-05-26	3826	170	503	3303	f	f
5067	Sudan	2020-05-26	2020-05-27	3976	170	503	3303	f	f
5068	Sudan	2020-05-27	2020-05-28	4146	195	749	3402	f	f
5069	Sudan	2020-05-28	2020-05-29	4346	195	749	3402	f	f
5071	Sudan	2020-05-30	2020-05-31	4521	262	1272	3266	f	f
5072	Sudan	2020-05-31	2020-06-01	4800	286	1423	3317	f	f
5073	Summer Olympics 2020	2020-05-01	2020-05-02	0	0	0	0	f	f
5074	Summer Olympics 2020	2020-05-02	2020-05-03	0	0	0	0	f	f
5075	Summer Olympics 2020	2020-05-03	2020-05-04	0	0	0	0	f	f
5076	Summer Olympics 2020	2020-05-04	2020-05-05	0	0	0	0	f	f
5077	Summer Olympics 2020	2020-05-05	2020-05-06	0	0	0	0	f	f
5078	Summer Olympics 2020	2020-05-06	2020-05-07	0	0	0	0	f	f
5079	Summer Olympics 2020	2020-05-07	2020-05-08	0	0	0	0	f	f
5080	Summer Olympics 2020	2020-05-08	2020-05-09	0	0	0	0	f	f
5081	Summer Olympics 2020	2020-05-09	2020-05-10	0	0	0	0	f	f
5082	Summer Olympics 2020	2020-05-10	2020-05-11	0	0	0	0	f	f
5083	Summer Olympics 2020	2020-05-11	2020-05-12	0	0	0	0	f	f
5084	Summer Olympics 2020	2020-05-12	2020-05-13	0	0	0	0	f	f
5085	Summer Olympics 2020	2020-05-13	2020-05-14	0	0	0	0	f	f
5086	Summer Olympics 2020	2020-05-14	2020-05-15	0	0	0	0	f	f
5087	Summer Olympics 2020	2020-05-15	2020-05-16	0	0	0	0	f	f
5088	Summer Olympics 2020	2020-05-16	2020-05-17	0	0	0	0	f	f
5089	Summer Olympics 2020	2020-05-17	2020-05-18	0	0	0	0	f	f
5090	Summer Olympics 2020	2020-05-18	2020-05-19	0	0	0	0	f	f
5091	Summer Olympics 2020	2020-05-19	2020-05-20	0	0	0	0	f	f
5092	Summer Olympics 2020	2020-05-20	2020-05-21	0	0	0	0	f	f
5093	Summer Olympics 2020	2020-05-21	2020-05-22	0	0	0	0	f	f
5094	Summer Olympics 2020	2020-05-22	2020-05-23	0	0	0	0	f	f
5095	Summer Olympics 2020	2020-05-23	2020-05-24	0	0	0	0	f	f
5096	Summer Olympics 2020	2020-05-24	2020-05-25	0	0	0	0	f	f
5097	Summer Olympics 2020	2020-05-25	2020-05-26	0	0	0	0	f	f
5098	Summer Olympics 2020	2020-05-26	2020-05-27	0	0	0	0	f	f
5099	Summer Olympics 2020	2020-05-27	2020-05-28	0	0	0	0	f	f
5100	Summer Olympics 2020	2020-05-28	2020-05-29	0	0	0	0	f	f
5101	Summer Olympics 2020	2020-05-29	2020-05-30	0	0	0	0	f	f
5102	Summer Olympics 2020	2020-05-30	2020-05-31	0	0	0	0	f	f
5103	Summer Olympics 2020	2020-05-31	2020-06-01	0	0	0	0	f	f
5104	Suriname	2020-05-01	2020-05-02	10	1	8	1	f	f
5105	Suriname	2020-05-02	2020-05-03	10	1	8	1	f	f
5106	Suriname	2020-05-03	2020-05-04	10	1	9	0	f	f
5107	Suriname	2020-05-04	2020-05-05	10	1	9	0	f	f
5108	Suriname	2020-05-05	2020-05-06	10	1	9	0	f	f
5109	Suriname	2020-05-06	2020-05-07	10	1	9	0	f	f
5110	Suriname	2020-05-07	2020-05-08	10	1	9	0	f	f
5111	Suriname	2020-05-08	2020-05-09	10	1	9	0	f	f
5112	Suriname	2020-05-09	2020-05-10	10	1	9	0	f	f
5113	Suriname	2020-05-10	2020-05-11	10	1	9	0	f	f
5114	Suriname	2020-05-11	2020-05-12	10	1	9	0	f	f
5115	Suriname	2020-05-12	2020-05-13	10	1	9	0	f	f
5116	Suriname	2020-05-13	2020-05-14	10	1	9	0	f	f
5117	Suriname	2020-05-14	2020-05-15	10	1	9	0	f	f
5118	Suriname	2020-05-15	2020-05-16	10	1	9	0	f	f
5119	Suriname	2020-05-16	2020-05-17	10	1	9	0	f	f
5120	Suriname	2020-05-17	2020-05-18	10	1	9	0	f	f
5121	Suriname	2020-05-18	2020-05-19	11	1	9	1	f	f
5122	Suriname	2020-05-19	2020-05-20	11	1	9	1	f	f
5123	Suriname	2020-05-20	2020-05-21	11	1	9	1	f	f
5124	Suriname	2020-05-21	2020-05-22	11	1	9	1	f	f
5125	Suriname	2020-05-22	2020-05-23	11	1	9	1	f	f
5126	Suriname	2020-05-23	2020-05-24	11	1	9	1	f	f
5127	Suriname	2020-05-24	2020-05-25	11	1	9	1	f	f
5128	Suriname	2020-05-25	2020-05-26	11	1	9	1	f	f
5129	Suriname	2020-05-26	2020-05-27	11	1	9	1	f	f
5130	Suriname	2020-05-27	2020-05-28	12	1	9	2	f	f
5131	Suriname	2020-05-28	2020-05-29	12	1	9	2	f	f
5132	Suriname	2020-05-29	2020-05-30	12	1	9	2	f	f
5133	Suriname	2020-05-30	2020-05-31	14	1	9	4	f	f
5134	Suriname	2020-05-31	2020-06-01	23	1	9	13	f	f
5135	Sweden	2020-05-01	2020-05-02	21520	2653	1005	17862	f	f
5136	Sweden	2020-05-02	2020-05-03	22082	2669	1005	18408	f	f
5137	Sweden	2020-05-03	2020-05-04	22317	2679	1005	18633	f	f
5138	Sweden	2020-05-04	2020-05-05	22721	2769	4074	15878	f	f
5139	Sweden	2020-05-05	2020-05-06	23216	2854	4074	16288	f	f
5140	Sweden	2020-05-06	2020-05-07	23918	2941	4074	16903	f	f
5141	Sweden	2020-05-07	2020-05-08	24623	3040	4971	16612	f	f
5142	Sweden	2020-05-08	2020-05-09	25265	3175	4971	17119	f	f
5143	Sweden	2020-05-09	2020-05-10	25921	3220	4971	17730	f	f
5144	Sweden	2020-05-10	2020-05-11	26322	3225	4971	18126	f	f
5145	Sweden	2020-05-11	2020-05-12	26670	3256	4971	18443	f	f
5146	Sweden	2020-05-12	2020-05-13	27272	3313	4971	18988	f	f
5147	Sweden	2020-05-13	2020-05-14	27909	3460	4971	19478	f	f
5148	Sweden	2020-05-14	2020-05-15	28582	3529	4971	20082	f	f
5149	Sweden	2020-05-15	2020-05-16	29207	3646	4971	20590	f	f
5150	Sweden	2020-05-16	2020-05-17	29677	3674	4971	21032	f	f
5151	Sweden	2020-05-17	2020-05-18	30143	3679	4971	21493	f	f
5152	Sweden	2020-05-18	2020-05-19	30377	3698	4971	21708	f	f
5153	Sweden	2020-05-19	2020-05-20	30799	3743	4971	22085	f	f
5154	Sweden	2020-05-20	2020-05-21	31523	3831	4971	22721	f	f
5155	Sweden	2020-05-21	2020-05-22	32172	3871	4971	23330	f	f
5156	Sweden	2020-05-22	2020-05-23	32809	3925	4971	23913	f	f
5157	Sweden	2020-05-23	2020-05-24	33188	3992	4971	24225	f	f
5158	Sweden	2020-05-24	2020-05-25	33459	3998	4971	24490	f	f
5159	Sweden	2020-05-25	2020-05-26	33843	4029	4971	24843	f	f
5160	Sweden	2020-05-26	2020-05-27	34440	4125	4971	25344	f	f
5161	Sweden	2020-05-27	2020-05-28	35088	4220	4971	25897	f	f
5162	Sweden	2020-05-28	2020-05-29	35727	4266	4971	26490	f	f
5163	Sweden	2020-05-29	2020-05-30	36476	4350	4971	27155	f	f
5164	Sweden	2020-05-30	2020-05-31	37113	4395	4971	27747	f	f
5165	Sweden	2020-05-31	2020-06-01	37542	4395	4971	28176	f	f
5166	Switzerland	2020-05-01	2020-05-02	29705	1754	23900	4051	f	f
5167	Switzerland	2020-05-02	2020-05-03	29817	1762	24200	3855	f	f
5168	Switzerland	2020-05-03	2020-05-04	29905	1762	24500	3643	f	f
5169	Switzerland	2020-05-04	2020-05-05	29981	1784	25200	2997	f	f
5170	Switzerland	2020-05-05	2020-05-06	30009	1795	25400	2814	f	f
5171	Switzerland	2020-05-06	2020-05-07	30060	1805	25700	2555	f	f
5172	Switzerland	2020-05-07	2020-05-08	30126	1810	25900	2416	f	f
5173	Switzerland	2020-05-08	2020-05-09	30207	1823	26100	2284	f	f
5174	Switzerland	2020-05-09	2020-05-10	30251	1830	26400	2021	f	f
5175	Switzerland	2020-05-10	2020-05-11	30305	1833	26600	1872	f	f
5176	Switzerland	2020-05-11	2020-05-12	30344	1845	26800	1699	f	f
5177	Switzerland	2020-05-12	2020-05-13	30380	1867	26800	1713	f	f
5178	Switzerland	2020-05-13	2020-05-14	30413	1870	27100	1443	f	f
5179	Switzerland	2020-05-14	2020-05-15	30463	1872	27100	1491	f	f
5180	Switzerland	2020-05-15	2020-05-16	30514	1878	27100	1536	f	f
5181	Switzerland	2020-05-16	2020-05-17	30572	1879	27400	1293	f	f
5182	Switzerland	2020-05-17	2020-05-18	30587	1881	27500	1206	f	f
5183	Switzerland	2020-05-18	2020-05-19	30597	1886	27600	1111	f	f
5184	Switzerland	2020-05-19	2020-05-20	30618	1891	27700	1027	f	f
5185	Switzerland	2020-05-20	2020-05-21	30658	1892	27800	966	f	f
5186	Switzerland	2020-05-21	2020-05-22	30694	1898	27900	896	f	f
5187	Switzerland	2020-05-22	2020-05-23	30707	1903	27900	904	f	f
5188	Switzerland	2020-05-23	2020-05-24	30725	1905	28000	820	f	f
5189	Switzerland	2020-05-24	2020-05-25	30736	1906	28100	730	f	f
5190	Switzerland	2020-05-25	2020-05-26	30746	1913	28200	633	f	f
5191	Switzerland	2020-05-26	2020-05-27	30761	1915	28200	646	f	f
5192	Switzerland	2020-05-27	2020-05-28	30776	1917	28300	559	f	f
5193	Switzerland	2020-05-28	2020-05-29	30796	1919	28300	577	f	f
5194	Switzerland	2020-05-29	2020-05-30	30828	1919	28300	609	f	f
5195	Switzerland	2020-05-30	2020-05-31	30845	1919	28400	526	f	f
5196	Switzerland	2020-05-31	2020-06-01	30862	1920	28500	442	f	f
5197	Syria	2020-05-01	2020-05-02	44	3	27	14	f	f
5198	Syria	2020-05-02	2020-05-03	44	3	27	14	f	f
5199	Syria	2020-05-03	2020-05-04	44	3	27	14	f	f
5200	Syria	2020-05-04	2020-05-05	44	3	27	14	f	f
5201	Syria	2020-05-05	2020-05-06	44	3	27	14	f	f
5202	Syria	2020-05-06	2020-05-07	45	3	27	15	f	f
5203	Syria	2020-05-07	2020-05-08	45	3	27	15	f	f
5204	Syria	2020-05-08	2020-05-09	47	3	29	15	f	f
5205	Syria	2020-05-09	2020-05-10	47	3	29	15	f	f
5206	Syria	2020-05-10	2020-05-11	47	3	29	15	f	f
5207	Syria	2020-05-11	2020-05-12	47	3	29	15	f	f
5208	Syria	2020-05-12	2020-05-13	47	3	29	15	f	f
5209	Syria	2020-05-13	2020-05-14	48	3	29	16	f	f
5210	Syria	2020-05-14	2020-05-15	48	3	29	16	f	f
5211	Syria	2020-05-15	2020-05-16	50	3	36	11	f	f
5212	Syria	2020-05-16	2020-05-17	51	3	36	12	f	f
5213	Syria	2020-05-17	2020-05-18	58	3	36	19	f	f
5214	Syria	2020-05-18	2020-05-19	58	3	36	19	f	f
5215	Syria	2020-05-19	2020-05-20	58	3	36	19	f	f
5216	Syria	2020-05-20	2020-05-21	58	3	36	19	f	f
5217	Syria	2020-05-21	2020-05-22	58	3	36	19	f	f
5218	Syria	2020-05-22	2020-05-23	59	4	37	18	f	f
5219	Syria	2020-05-23	2020-05-24	70	4	37	29	f	f
5220	Syria	2020-05-24	2020-05-25	86	4	41	41	f	f
5221	Syria	2020-05-25	2020-05-26	106	4	41	61	f	f
5222	Syria	2020-05-26	2020-05-27	121	4	41	76	f	f
5223	Syria	2020-05-27	2020-05-28	121	4	43	74	f	f
5224	Syria	2020-05-28	2020-05-29	122	4	43	75	f	f
5225	Syria	2020-05-29	2020-05-30	122	4	43	75	f	f
5226	Syria	2020-05-30	2020-05-31	122	4	43	75	f	f
5227	Syria	2020-05-31	2020-06-01	122	5	46	71	f	f
5228	Taiwan*	2020-05-01	2020-05-02	429	6	324	99	f	f
5229	Taiwan*	2020-05-02	2020-05-03	432	6	324	102	f	f
5230	Taiwan*	2020-05-03	2020-05-04	436	6	332	98	f	f
5231	Taiwan*	2020-05-04	2020-05-05	438	6	334	98	f	f
5232	Taiwan*	2020-05-05	2020-05-06	438	6	334	98	f	f
5233	Taiwan*	2020-05-06	2020-05-07	439	6	339	94	f	f
5234	Taiwan*	2020-05-07	2020-05-08	440	6	347	87	f	f
5235	Taiwan*	2020-05-08	2020-05-09	440	6	355	79	f	f
5236	Taiwan*	2020-05-09	2020-05-10	440	6	361	73	f	f
5237	Taiwan*	2020-05-10	2020-05-11	440	6	366	68	f	f
5238	Taiwan*	2020-05-11	2020-05-12	440	7	368	65	f	f
5239	Taiwan*	2020-05-12	2020-05-13	440	7	372	61	f	f
5240	Taiwan*	2020-05-13	2020-05-14	440	7	375	58	f	f
5241	Taiwan*	2020-05-14	2020-05-15	440	7	383	50	f	f
5242	Taiwan*	2020-05-15	2020-05-16	440	7	387	46	f	f
5243	Taiwan*	2020-05-16	2020-05-17	440	7	389	44	f	f
5244	Taiwan*	2020-05-17	2020-05-18	440	7	395	38	f	f
5245	Taiwan*	2020-05-18	2020-05-19	440	7	398	35	f	f
5246	Taiwan*	2020-05-19	2020-05-20	440	7	398	35	f	f
5247	Taiwan*	2020-05-20	2020-05-21	440	7	398	35	f	f
5248	Taiwan*	2020-05-21	2020-05-22	440	7	398	35	f	f
5249	Taiwan*	2020-05-22	2020-05-23	441	7	408	26	f	f
5250	Taiwan*	2020-05-23	2020-05-24	441	7	411	23	f	f
5251	Taiwan*	2020-05-24	2020-05-25	441	7	414	20	f	f
5252	Taiwan*	2020-05-25	2020-05-26	441	7	415	19	f	f
5253	Taiwan*	2020-05-26	2020-05-27	441	7	416	18	f	f
5254	Taiwan*	2020-05-27	2020-05-28	441	7	419	15	f	f
5255	Taiwan*	2020-05-28	2020-05-29	441	7	420	14	f	f
5256	Taiwan*	2020-05-29	2020-05-30	442	7	420	15	f	f
5257	Taiwan*	2020-05-30	2020-05-31	442	7	421	14	f	f
5258	Taiwan*	2020-05-31	2020-06-01	442	7	423	12	f	f
5259	Tajikistan	2020-05-01	2020-05-02	15	0	0	15	f	f
5260	Tajikistan	2020-05-02	2020-05-03	76	2	0	74	f	f
5261	Tajikistan	2020-05-03	2020-05-04	128	2	0	126	f	f
5262	Tajikistan	2020-05-04	2020-05-05	230	3	0	227	f	f
5263	Tajikistan	2020-05-05	2020-05-06	293	5	0	288	f	f
5264	Tajikistan	2020-05-06	2020-05-07	379	8	0	371	f	f
5265	Tajikistan	2020-05-07	2020-05-08	461	12	0	449	f	f
5266	Tajikistan	2020-05-08	2020-05-09	522	12	0	510	f	f
5267	Tajikistan	2020-05-09	2020-05-10	612	20	0	592	f	f
5268	Tajikistan	2020-05-10	2020-05-11	612	20	0	592	f	f
5269	Tajikistan	2020-05-11	2020-05-12	661	21	0	640	f	f
5270	Tajikistan	2020-05-12	2020-05-13	729	21	0	708	f	f
5271	Tajikistan	2020-05-13	2020-05-14	801	23	0	778	f	f
5272	Tajikistan	2020-05-14	2020-05-15	907	29	0	878	f	f
5273	Tajikistan	2020-05-15	2020-05-16	1118	33	0	1085	f	f
5274	Tajikistan	2020-05-16	2020-05-17	1322	36	0	1286	f	f
5275	Tajikistan	2020-05-17	2020-05-18	1524	39	0	1485	f	f
5276	Tajikistan	2020-05-18	2020-05-19	1729	41	0	1688	f	f
5277	Tajikistan	2020-05-19	2020-05-20	1936	41	641	1254	f	f
5278	Tajikistan	2020-05-20	2020-05-21	2140	41	470	1629	f	f
5279	Tajikistan	2020-05-21	2020-05-22	2350	44	470	1836	f	f
5280	Tajikistan	2020-05-22	2020-05-23	2551	44	1089	1418	f	f
5281	Tajikistan	2020-05-23	2020-05-24	2738	44	1223	1471	f	f
5282	Tajikistan	2020-05-24	2020-05-25	2929	46	1301	1582	f	f
5283	Tajikistan	2020-05-25	2020-05-26	3100	46	1395	1659	f	f
5284	Tajikistan	2020-05-26	2020-05-27	3266	47	1417	1802	f	f
5285	Tajikistan	2020-05-27	2020-05-28	3424	47	1575	1802	f	f
5286	Tajikistan	2020-05-28	2020-05-29	3563	47	1674	1842	f	f
5287	Tajikistan	2020-05-29	2020-05-30	3686	47	1769	1870	f	f
5288	Tajikistan	2020-05-30	2020-05-31	3807	47	1865	1895	f	f
5289	Tajikistan	2020-05-31	2020-06-01	3930	47	2004	1879	f	f
5290	Tanzania	2020-05-01	2020-05-02	480	16	167	297	f	f
5291	Tanzania	2020-05-02	2020-05-03	480	16	167	297	f	f
5292	Tanzania	2020-05-03	2020-05-04	480	16	167	297	f	f
5293	Tanzania	2020-05-04	2020-05-05	480	16	167	297	f	f
5294	Tanzania	2020-05-05	2020-05-06	480	16	167	297	f	f
5295	Tanzania	2020-05-06	2020-05-07	480	16	167	297	f	f
5296	Tanzania	2020-05-07	2020-05-08	480	16	167	297	f	f
5297	Tanzania	2020-05-08	2020-05-09	509	21	183	305	f	f
5298	Tanzania	2020-05-09	2020-05-10	509	21	183	305	f	f
5299	Tanzania	2020-05-10	2020-05-11	509	21	183	305	f	f
5300	Tanzania	2020-05-11	2020-05-12	509	21	183	305	f	f
5301	Tanzania	2020-05-12	2020-05-13	509	21	183	305	f	f
5302	Tanzania	2020-05-13	2020-05-14	509	21	183	305	f	f
5303	Tanzania	2020-05-14	2020-05-15	509	21	183	305	f	f
5304	Tanzania	2020-05-15	2020-05-16	509	21	183	305	f	f
5305	Tanzania	2020-05-16	2020-05-17	509	21	183	305	f	f
5306	Tanzania	2020-05-17	2020-05-18	509	21	183	305	f	f
5307	Tanzania	2020-05-18	2020-05-19	509	21	183	305	f	f
5308	Tanzania	2020-05-19	2020-05-20	509	21	183	305	f	f
5309	Tanzania	2020-05-20	2020-05-21	509	21	183	305	f	f
5310	Tanzania	2020-05-21	2020-05-22	509	21	183	305	f	f
5311	Tanzania	2020-05-22	2020-05-23	509	21	183	305	f	f
5312	Tanzania	2020-05-23	2020-05-24	509	21	183	305	f	f
5313	Tanzania	2020-05-24	2020-05-25	509	21	183	305	f	f
5314	Tanzania	2020-05-25	2020-05-26	509	21	183	305	f	f
5315	Tanzania	2020-05-26	2020-05-27	509	21	183	305	f	f
5316	Tanzania	2020-05-27	2020-05-28	509	21	183	305	f	f
5317	Tanzania	2020-05-28	2020-05-29	509	21	183	305	f	f
5318	Tanzania	2020-05-29	2020-05-30	509	21	183	305	f	f
5319	Tanzania	2020-05-30	2020-05-31	509	21	183	305	f	f
5320	Tanzania	2020-05-31	2020-06-01	509	21	183	305	f	f
5321	Thailand	2020-05-01	2020-05-02	2960	54	2719	187	f	f
5322	Thailand	2020-05-02	2020-05-03	2966	54	2732	180	f	f
5323	Thailand	2020-05-03	2020-05-04	2969	54	2739	176	f	f
5324	Thailand	2020-05-04	2020-05-05	2987	54	2740	193	f	f
5325	Thailand	2020-05-05	2020-05-06	2988	54	2747	187	f	f
5326	Thailand	2020-05-06	2020-05-07	2989	55	2761	173	f	f
5327	Thailand	2020-05-07	2020-05-08	2992	55	2772	165	f	f
5328	Thailand	2020-05-08	2020-05-09	3000	55	2784	161	f	f
5329	Thailand	2020-05-09	2020-05-10	3004	56	2787	161	f	f
5330	Thailand	2020-05-10	2020-05-11	3009	56	2794	159	f	f
5331	Thailand	2020-05-11	2020-05-12	3015	56	2796	163	f	f
5332	Thailand	2020-05-12	2020-05-13	3017	56	2798	163	f	f
5333	Thailand	2020-05-13	2020-05-14	3017	56	2844	117	f	f
5334	Thailand	2020-05-14	2020-05-15	3018	56	2850	112	f	f
5335	Thailand	2020-05-15	2020-05-16	3025	56	2854	115	f	f
5336	Thailand	2020-05-16	2020-05-17	3025	56	2855	114	f	f
5337	Thailand	2020-05-17	2020-05-18	3028	56	2856	116	f	f
5338	Thailand	2020-05-18	2020-05-19	3031	56	2857	118	f	f
5339	Thailand	2020-05-19	2020-05-20	3033	56	2857	120	f	f
5340	Thailand	2020-05-20	2020-05-21	3034	56	2888	90	f	f
5341	Thailand	2020-05-21	2020-05-22	3037	56	2897	84	f	f
5342	Thailand	2020-05-22	2020-05-23	3037	56	2910	71	f	f
5343	Thailand	2020-05-23	2020-05-24	3040	56	2916	68	f	f
5344	Thailand	2020-05-24	2020-05-25	3040	56	2921	63	f	f
5345	Thailand	2020-05-25	2020-05-26	3042	57	2928	57	f	f
5346	Thailand	2020-05-26	2020-05-27	3045	57	2929	59	f	f
5347	Thailand	2020-05-27	2020-05-28	3054	57	2931	66	f	f
5348	Thailand	2020-05-28	2020-05-29	3065	57	2945	63	f	f
5349	Thailand	2020-05-29	2020-05-30	3076	57	2945	74	f	f
5350	Thailand	2020-05-30	2020-05-31	3077	57	2961	59	f	f
5351	Thailand	2020-05-31	2020-06-01	3081	57	2963	61	f	f
5352	Timor-Leste	2020-05-01	2020-05-02	24	0	16	8	f	f
5353	Timor-Leste	2020-05-02	2020-05-03	24	0	16	8	f	f
5354	Timor-Leste	2020-05-03	2020-05-04	24	0	16	8	f	f
5355	Timor-Leste	2020-05-04	2020-05-05	24	0	20	4	f	f
5356	Timor-Leste	2020-05-05	2020-05-06	24	0	20	4	f	f
5357	Timor-Leste	2020-05-06	2020-05-07	24	0	20	4	f	f
5358	Timor-Leste	2020-05-07	2020-05-08	24	0	21	3	f	f
5359	Timor-Leste	2020-05-08	2020-05-09	24	0	21	3	f	f
5360	Timor-Leste	2020-05-09	2020-05-10	24	0	21	3	f	f
5361	Timor-Leste	2020-05-10	2020-05-11	24	0	21	3	f	f
5362	Timor-Leste	2020-05-11	2020-05-12	24	0	21	3	f	f
5363	Timor-Leste	2020-05-12	2020-05-13	24	0	21	3	f	f
5364	Timor-Leste	2020-05-13	2020-05-14	24	0	21	3	f	f
5365	Timor-Leste	2020-05-14	2020-05-15	24	0	21	3	f	f
5366	Timor-Leste	2020-05-15	2020-05-16	24	0	24	0	f	f
5367	Timor-Leste	2020-05-16	2020-05-17	24	0	24	0	f	f
5368	Timor-Leste	2020-05-17	2020-05-18	24	0	24	0	f	f
5369	Timor-Leste	2020-05-18	2020-05-19	24	0	24	0	f	f
5370	Timor-Leste	2020-05-19	2020-05-20	24	0	24	0	f	f
5371	Timor-Leste	2020-05-20	2020-05-21	24	0	24	0	f	f
5372	Timor-Leste	2020-05-21	2020-05-22	24	0	24	0	f	f
5373	Timor-Leste	2020-05-22	2020-05-23	24	0	24	0	f	f
5374	Timor-Leste	2020-05-23	2020-05-24	24	0	24	0	f	f
5375	Timor-Leste	2020-05-24	2020-05-25	24	0	24	0	f	f
5376	Timor-Leste	2020-05-25	2020-05-26	24	0	24	0	f	f
5377	Timor-Leste	2020-05-26	2020-05-27	24	0	24	0	f	f
5378	Timor-Leste	2020-05-27	2020-05-28	24	0	24	0	f	f
5379	Timor-Leste	2020-05-28	2020-05-29	24	0	24	0	f	f
5380	Timor-Leste	2020-05-29	2020-05-30	24	0	24	0	f	f
5381	Timor-Leste	2020-05-30	2020-05-31	24	0	24	0	f	f
5382	Timor-Leste	2020-05-31	2020-06-01	24	0	24	0	f	f
5383	Togo	2020-05-01	2020-05-02	123	9	66	48	f	f
5384	Togo	2020-05-02	2020-05-03	123	9	66	48	f	f
5385	Togo	2020-05-03	2020-05-04	124	9	67	48	f	f
5386	Togo	2020-05-04	2020-05-05	126	9	74	43	f	f
5387	Togo	2020-05-05	2020-05-06	128	9	74	45	f	f
5388	Togo	2020-05-06	2020-05-07	128	9	77	42	f	f
5389	Togo	2020-05-07	2020-05-08	135	9	85	41	f	f
5390	Togo	2020-05-08	2020-05-09	145	10	85	50	f	f
5391	Togo	2020-05-09	2020-05-10	153	10	87	56	f	f
5392	Togo	2020-05-10	2020-05-11	174	11	89	74	f	f
5393	Togo	2020-05-11	2020-05-12	181	11	89	81	f	f
5394	Togo	2020-05-12	2020-05-13	199	11	92	96	f	f
5395	Togo	2020-05-13	2020-05-14	219	11	96	112	f	f
5396	Togo	2020-05-14	2020-05-15	238	11	96	131	f	f
5397	Togo	2020-05-15	2020-05-16	263	11	96	156	f	f
5398	Togo	2020-05-16	2020-05-17	298	11	99	188	f	f
5399	Togo	2020-05-17	2020-05-18	301	11	104	186	f	f
5400	Togo	2020-05-18	2020-05-19	330	12	106	212	f	f
5401	Togo	2020-05-19	2020-05-20	338	12	107	219	f	f
5402	Togo	2020-05-20	2020-05-21	340	12	110	218	f	f
5403	Togo	2020-05-21	2020-05-22	354	12	118	224	f	f
5404	Togo	2020-05-22	2020-05-23	363	12	121	230	f	f
5405	Togo	2020-05-23	2020-05-24	373	12	133	228	f	f
5406	Togo	2020-05-24	2020-05-25	381	12	141	228	f	f
5407	Togo	2020-05-25	2020-05-26	386	13	161	212	f	f
5408	Togo	2020-05-26	2020-05-27	391	13	177	201	f	f
5409	Togo	2020-05-27	2020-05-28	395	13	183	199	f	f
5410	Togo	2020-05-28	2020-05-29	422	13	197	212	f	f
5411	Togo	2020-05-29	2020-05-30	428	13	202	213	f	f
5412	Togo	2020-05-30	2020-05-31	433	13	206	214	f	f
5413	Togo	2020-05-31	2020-06-01	442	13	211	218	f	f
5414	Trinidad and Tobago	2020-05-01	2020-05-02	116	8	83	25	f	f
5415	Trinidad and Tobago	2020-05-02	2020-05-03	116	8	88	20	f	f
5416	Trinidad and Tobago	2020-05-03	2020-05-04	116	8	93	15	f	f
5417	Trinidad and Tobago	2020-05-04	2020-05-05	116	8	99	9	f	f
5418	Trinidad and Tobago	2020-05-05	2020-05-06	116	8	103	5	f	f
5419	Trinidad and Tobago	2020-05-06	2020-05-07	116	8	103	5	f	f
5420	Trinidad and Tobago	2020-05-07	2020-05-08	116	8	103	5	f	f
5421	Trinidad and Tobago	2020-05-08	2020-05-09	116	8	103	5	f	f
5422	Trinidad and Tobago	2020-05-09	2020-05-10	116	8	104	4	f	f
5423	Trinidad and Tobago	2020-05-10	2020-05-11	116	8	107	1	f	f
5424	Trinidad and Tobago	2020-05-11	2020-05-12	116	8	107	1	f	f
5425	Trinidad and Tobago	2020-05-12	2020-05-13	116	8	107	1	f	f
5426	Trinidad and Tobago	2020-05-13	2020-05-14	116	8	107	1	f	f
5427	Trinidad and Tobago	2020-05-14	2020-05-15	116	8	107	1	f	f
5428	Trinidad and Tobago	2020-05-15	2020-05-16	116	8	107	1	f	f
5429	Trinidad and Tobago	2020-05-16	2020-05-17	116	8	107	1	f	f
5430	Trinidad and Tobago	2020-05-17	2020-05-18	116	8	107	1	f	f
5431	Trinidad and Tobago	2020-05-18	2020-05-19	116	8	107	1	f	f
5432	Trinidad and Tobago	2020-05-19	2020-05-20	116	8	107	1	f	f
5433	Trinidad and Tobago	2020-05-20	2020-05-21	116	8	107	1	f	f
5434	Trinidad and Tobago	2020-05-21	2020-05-22	116	8	108	0	f	f
5435	Trinidad and Tobago	2020-05-22	2020-05-23	116	8	108	0	f	f
5436	Trinidad and Tobago	2020-05-23	2020-05-24	116	8	108	0	f	f
5437	Trinidad and Tobago	2020-05-24	2020-05-25	116	8	108	0	f	f
5438	Trinidad and Tobago	2020-05-25	2020-05-26	116	8	108	0	f	f
5439	Trinidad and Tobago	2020-05-26	2020-05-27	116	8	108	0	f	f
5440	Trinidad and Tobago	2020-05-27	2020-05-28	116	8	108	0	f	f
5441	Trinidad and Tobago	2020-05-28	2020-05-29	116	8	108	0	f	f
5442	Trinidad and Tobago	2020-05-29	2020-05-30	116	8	108	0	f	f
5443	Trinidad and Tobago	2020-05-30	2020-05-31	117	8	108	1	f	f
5444	Trinidad and Tobago	2020-05-31	2020-06-01	117	8	108	1	f	f
5445	Tunisia	2020-05-01	2020-05-02	998	41	316	641	f	f
5446	Tunisia	2020-05-02	2020-05-03	1009	42	323	644	f	f
5447	Tunisia	2020-05-03	2020-05-04	1013	42	328	643	f	f
5448	Tunisia	2020-05-04	2020-05-05	1018	43	406	569	f	f
5449	Tunisia	2020-05-05	2020-05-06	1022	43	482	497	f	f
5450	Tunisia	2020-05-06	2020-05-07	1025	43	591	391	f	f
5451	Tunisia	2020-05-07	2020-05-08	1026	44	600	382	f	f
5452	Tunisia	2020-05-08	2020-05-09	1030	45	638	347	f	f
5453	Tunisia	2020-05-09	2020-05-10	1032	45	660	327	f	f
5454	Tunisia	2020-05-10	2020-05-11	1032	45	700	287	f	f
5455	Tunisia	2020-05-11	2020-05-12	1032	45	727	260	f	f
5456	Tunisia	2020-05-12	2020-05-13	1032	45	740	247	f	f
5457	Tunisia	2020-05-13	2020-05-14	1032	45	759	228	f	f
5458	Tunisia	2020-05-14	2020-05-15	1032	45	770	217	f	f
5459	Tunisia	2020-05-15	2020-05-16	1035	45	802	188	f	f
5460	Tunisia	2020-05-16	2020-05-17	1037	45	807	185	f	f
5461	Tunisia	2020-05-17	2020-05-18	1037	45	816	176	f	f
5462	Tunisia	2020-05-18	2020-05-19	1043	46	819	178	f	f
5463	Tunisia	2020-05-19	2020-05-20	1044	47	826	171	f	f
5464	Tunisia	2020-05-20	2020-05-21	1045	47	862	136	f	f
5465	Tunisia	2020-05-21	2020-05-22	1046	47	883	116	f	f
5466	Tunisia	2020-05-22	2020-05-23	1048	47	903	98	f	f
5467	Tunisia	2020-05-23	2020-05-24	1048	48	914	86	f	f
5468	Tunisia	2020-05-24	2020-05-25	1051	48	917	86	f	f
5469	Tunisia	2020-05-25	2020-05-26	1051	48	919	84	f	f
5470	Tunisia	2020-05-26	2020-05-27	1051	48	929	74	f	f
5471	Tunisia	2020-05-27	2020-05-28	1051	48	929	74	f	f
5472	Tunisia	2020-05-28	2020-05-29	1068	48	938	82	f	f
5473	Tunisia	2020-05-29	2020-05-30	1071	48	946	77	f	f
5474	Tunisia	2020-05-30	2020-05-31	1076	48	950	78	f	f
5475	Tunisia	2020-05-31	2020-06-01	1077	48	960	69	f	f
5476	Turkey	2020-05-01	2020-05-02	122392	3258	53808	65326	f	f
5477	Turkey	2020-05-02	2020-05-03	124375	3336	58259	62780	f	f
5478	Turkey	2020-05-03	2020-05-04	126045	3397	63151	59497	f	f
5479	Turkey	2020-05-04	2020-05-05	127659	3461	68166	56032	f	f
5480	Turkey	2020-05-05	2020-05-06	129491	3520	73285	52686	f	f
5481	Turkey	2020-05-06	2020-05-07	131744	3584	78202	49958	f	f
5482	Turkey	2020-05-07	2020-05-08	133721	3641	82984	47096	f	f
5483	Turkey	2020-05-08	2020-05-09	135569	3689	86396	45484	f	f
5484	Turkey	2020-05-09	2020-05-10	137115	3739	89480	43896	f	f
5485	Turkey	2020-05-10	2020-05-11	138657	3786	92691	42180	f	f
5486	Turkey	2020-05-11	2020-05-12	139771	3841	95780	40150	f	f
5487	Turkey	2020-05-12	2020-05-13	141475	3894	98889	38692	f	f
5488	Turkey	2020-05-13	2020-05-14	143114	3952	101715	37447	f	f
5489	Turkey	2020-05-14	2020-05-15	144749	4007	104030	36712	f	f
5490	Turkey	2020-05-15	2020-05-16	146457	4055	106133	36269	f	f
5491	Turkey	2020-05-16	2020-05-17	148067	4096	108137	35834	f	f
5492	Turkey	2020-05-17	2020-05-18	149435	4140	109962	35333	f	f
5493	Turkey	2020-05-18	2020-05-19	150593	4171	111577	34845	f	f
5494	Turkey	2020-05-19	2020-05-20	151615	4199	112895	34521	f	f
5495	Turkey	2020-05-20	2020-05-21	152587	4222	113987	34378	f	f
5496	Turkey	2020-05-21	2020-05-22	153548	4249	114990	34309	f	f
5497	Turkey	2020-05-22	2020-05-23	154500	4276	116111	34113	f	f
5498	Turkey	2020-05-23	2020-05-24	155686	4308	117602	33776	f	f
5499	Turkey	2020-05-24	2020-05-25	156827	4340	118694	33793	f	f
5500	Turkey	2020-05-25	2020-05-26	157814	4369	120015	33430	f	f
5501	Turkey	2020-05-26	2020-05-27	158762	4397	121507	32858	f	f
5502	Turkey	2020-05-27	2020-05-28	159797	4431	122793	32573	f	f
5503	Turkey	2020-05-28	2020-05-29	160979	4461	124369	32149	f	f
5504	Turkey	2020-05-29	2020-05-30	162120	4489	125963	31668	f	f
5505	Turkey	2020-05-30	2020-05-31	163103	4515	126984	31604	f	f
5506	Turkey	2020-05-31	2020-06-01	163942	4540	127973	31429	f	f
5507	US	2020-05-01	2020-05-02	1104691	65386	164015	903178	f	f
5508	US	2020-05-02	2020-05-03	1133576	66966	175382	917894	f	f
5509	US	2020-05-03	2020-05-04	1158859	68350	180152	939851	f	f
5510	US	2020-05-04	2020-05-05	1181277	69641	187180	954281	f	f
5511	US	2020-05-05	2020-05-06	1205428	71687	189791	972526	f	f
5512	US	2020-05-06	2021-04-02	1229809	73887	189910	987827	f	f
5513	US	2020-05-07	2021-04-02	1258204	76112	195036	1011058	f	f
5514	US	2020-05-08	2021-04-02	1285206	77636	198993	1027704	f	f
5515	US	2020-05-09	2021-04-02	1311126	79233	212534	1033324	f	f
5516	US	2020-05-10	2021-04-02	1330677	80046	216169	1043141	f	f
5517	US	2020-05-11	2021-04-02	1349027	81238	232733	1051488	f	f
5518	US	2020-05-12	2021-04-02	1371262	82906	230287	1057473	f	f
5519	US	2020-05-13	2021-04-02	1392010	84605	243430	1067859	f	f
5520	US	2020-05-14	2021-04-02	1419022	86384	246414	1085191	f	f
5521	US	2020-05-15	2021-04-02	1444125	88008	250747	1102212	f	f
5522	US	2020-05-16	2021-04-02	1469160	89219	268376	1111939	f	f
5523	US	2020-05-17	2021-04-02	1488256	90086	272265	1122366	f	f
5524	US	2020-05-18	2021-04-02	1509949	90923	283178	1135016	f	f
5525	US	2020-05-19	2021-04-02	1530327	92404	289392	1144851	f	f
5526	US	2020-05-20	2021-04-02	1553435	93901	294312	1162407	f	f
5527	US	2020-05-21	2021-04-02	1578909	95123	298418	1180548	f	f
5528	US	2020-05-22	2021-04-02	1602815	96378	350135	1195014	f	f
5529	US	2020-05-23	2021-04-02	1624155	97460	361239	1197128	f	f
5530	US	2020-05-24	2021-04-02	1644622	98106	366736	1210704	f	f
5531	US	2020-05-25	2021-04-02	1663640	98645	379157	1218472	f	f
5532	US	2020-05-26	2021-04-02	1682562	99341	384902	1228728	f	f
5533	US	2020-05-27	2021-04-02	1701037	100798	391508	1234641	f	f
5534	US	2020-05-28	2021-04-02	1723667	101905	399991	1249340	f	f
5535	US	2020-05-29	2021-04-02	1748095	103074	406446	1267758	f	f
5536	US	2020-05-30	2021-04-02	1772316	104045	416461	1284150	f	f
5537	US	2020-05-31	2021-04-02	1791873	104681	444758	1295795	f	f
5538	Uganda	2020-05-01	2020-05-02	85	0	52	33	f	f
5539	Uganda	2020-05-02	2020-05-03	88	0	52	36	f	f
5540	Uganda	2020-05-03	2020-05-04	89	0	52	37	f	f
5541	Uganda	2020-05-04	2020-05-05	97	0	55	42	f	f
5542	Uganda	2020-05-05	2020-05-06	98	0	55	43	f	f
5543	Uganda	2020-05-06	2020-05-07	100	0	55	45	f	f
5544	Uganda	2020-05-07	2020-05-08	101	0	55	46	f	f
5545	Uganda	2020-05-08	2020-05-09	101	0	55	46	f	f
5546	Uganda	2020-05-09	2020-05-10	116	0	55	61	f	f
5547	Uganda	2020-05-10	2020-05-11	121	0	55	66	f	f
5548	Uganda	2020-05-11	2020-05-12	121	0	55	66	f	f
5549	Uganda	2020-05-12	2020-05-13	129	0	55	74	f	f
5550	Uganda	2020-05-13	2020-05-14	139	0	55	84	f	f
5551	Uganda	2020-05-14	2020-05-15	160	0	63	97	f	f
5552	Uganda	2020-05-15	2020-05-16	203	0	63	140	f	f
5553	Uganda	2020-05-16	2020-05-17	227	0	63	164	f	f
5554	Uganda	2020-05-17	2020-05-18	227	0	63	164	f	f
5555	Uganda	2020-05-18	2020-05-19	248	0	63	185	f	f
5556	Uganda	2020-05-19	2020-05-20	260	0	63	197	f	f
5557	Uganda	2020-05-20	2020-05-21	264	0	65	199	f	f
5558	Uganda	2020-05-21	2020-05-22	160	0	66	94	f	f
5559	Uganda	2020-05-22	2020-05-23	175	0	68	107	f	f
5560	Uganda	2020-05-23	2020-05-24	198	0	68	130	f	f
5561	Uganda	2020-05-24	2020-05-25	198	0	68	130	f	f
5562	Uganda	2020-05-25	2020-05-26	222	0	69	153	f	f
5563	Uganda	2020-05-26	2020-05-27	253	0	69	184	f	f
5564	Uganda	2020-05-27	2020-05-28	281	0	69	212	f	f
5565	Uganda	2020-05-28	2020-05-29	317	0	69	248	f	f
5566	Uganda	2020-05-29	2020-05-30	329	0	72	257	f	f
5567	Uganda	2020-05-30	2020-05-31	413	0	72	341	f	f
5568	Uganda	2020-05-31	2020-06-01	417	0	72	345	f	f
5569	Ukraine	2020-05-01	2020-05-02	10861	272	1413	9176	f	f
5570	Ukraine	2020-05-02	2020-05-03	11411	279	1498	9634	f	f
5571	Ukraine	2020-05-03	2020-05-04	11913	288	1548	10077	f	f
5572	Ukraine	2020-05-04	2020-05-05	12331	303	1619	10409	f	f
5573	Ukraine	2020-05-05	2020-05-06	12697	316	1875	10506	f	f
5574	Ukraine	2020-05-06	2020-05-07	13184	327	2097	10760	f	f
5575	Ukraine	2020-05-07	2020-05-08	13691	340	2396	10955	f	f
5576	Ukraine	2020-05-08	2020-05-09	14195	361	2706	11128	f	f
5577	Ukraine	2020-05-09	2020-05-10	14710	376	2909	11425	f	f
5578	Ukraine	2020-05-10	2020-05-11	15232	391	3060	11781	f	f
5579	Ukraine	2020-05-11	2020-05-12	15648	408	3288	11952	f	f
5580	Ukraine	2020-05-12	2020-05-13	16023	425	3373	12225	f	f
5581	Ukraine	2020-05-13	2020-05-14	16425	439	3716	12270	f	f
5582	Ukraine	2020-05-14	2020-05-15	16847	456	4143	12248	f	f
5583	Ukraine	2020-05-15	2020-05-16	17330	476	4473	12381	f	f
5584	Ukraine	2020-05-16	2020-05-17	17858	497	4906	12455	f	f
5585	Ukraine	2020-05-17	2020-05-18	18291	514	5116	12661	f	f
5586	Ukraine	2020-05-18	2020-05-19	18616	535	5276	12805	f	f
5587	Ukraine	2020-05-19	2020-05-20	18876	548	5632	12696	f	f
5588	Ukraine	2020-05-20	2020-05-21	19230	564	5955	12711	f	f
5589	Ukraine	2020-05-21	2020-05-22	19706	579	6227	12900	f	f
5590	Ukraine	2020-05-22	2020-05-23	20148	588	6585	12975	f	f
5591	Ukraine	2020-05-23	2020-05-24	20580	605	6929	13046	f	f
5592	Ukraine	2020-05-24	2020-05-25	20986	617	7108	13261	f	f
5593	Ukraine	2020-05-25	2020-05-26	21245	623	7234	13388	f	f
5594	Ukraine	2020-05-26	2020-05-27	21584	644	7575	13365	f	f
5595	Ukraine	2020-05-27	2020-05-28	21905	658	7995	13252	f	f
5596	Ukraine	2020-05-28	2020-05-29	22382	669	8439	13274	f	f
5597	Ukraine	2020-05-29	2020-05-30	22811	679	8934	13198	f	f
5598	Ukraine	2020-05-30	2020-05-31	23204	696	9311	13197	f	f
5599	Ukraine	2020-05-31	2020-06-01	23672	708	9538	13426	f	f
5600	United Arab Emirates	2020-05-01	2020-05-02	13038	111	2543	10384	f	f
5601	United Arab Emirates	2020-05-02	2020-05-03	13599	119	2664	10816	f	f
5602	United Arab Emirates	2020-05-03	2020-05-04	14163	126	2763	11274	f	f
5603	United Arab Emirates	2020-05-04	2020-05-05	14730	137	2966	11627	f	f
5604	United Arab Emirates	2020-05-05	2020-05-06	15192	146	3153	11893	f	f
5605	United Arab Emirates	2020-05-06	2020-05-07	15738	157	3359	12222	f	f
5606	United Arab Emirates	2020-05-07	2020-05-08	16240	165	3572	12503	f	f
5607	United Arab Emirates	2020-05-08	2020-05-09	16793	174	3837	12782	f	f
5608	United Arab Emirates	2020-05-09	2020-05-10	17417	185	4295	12937	f	f
5609	United Arab Emirates	2020-05-10	2020-05-11	18198	198	4804	13196	f	f
5610	United Arab Emirates	2020-05-11	2020-05-12	18878	201	5381	13296	f	f
5611	United Arab Emirates	2020-05-12	2020-05-13	19661	203	6012	13446	f	f
5612	United Arab Emirates	2020-05-13	2020-05-14	20386	206	6523	13657	f	f
5613	United Arab Emirates	2020-05-14	2020-05-15	21084	208	6930	13946	f	f
5614	United Arab Emirates	2020-05-15	2020-05-16	21831	210	7328	14293	f	f
5615	United Arab Emirates	2020-05-16	2020-05-17	22627	214	7931	14482	f	f
5616	United Arab Emirates	2020-05-17	2020-05-18	23358	220	8512	14626	f	f
5617	United Arab Emirates	2020-05-18	2020-05-19	24190	224	9577	14389	f	f
5618	United Arab Emirates	2020-05-19	2020-05-20	25063	227	10791	14045	f	f
5619	United Arab Emirates	2020-05-20	2020-05-21	26004	233	11809	13962	f	f
5620	United Arab Emirates	2020-05-21	2020-05-22	26898	237	12755	13906	f	f
5621	United Arab Emirates	2020-05-22	2020-05-23	27892	241	13798	13853	f	f
5622	United Arab Emirates	2020-05-23	2020-05-24	28704	244	14495	13965	f	f
5623	United Arab Emirates	2020-05-24	2020-05-25	29485	245	15056	14184	f	f
5624	United Arab Emirates	2020-05-25	2020-05-26	30307	248	15657	14402	f	f
5625	United Arab Emirates	2020-05-26	2020-05-27	31086	253	15982	14851	f	f
5846	Yemen	2020-05-30	2020-05-31	310	77	13	220	f	f
5626	United Arab Emirates	2020-05-27	2020-05-28	31969	255	16371	15343	f	f
5627	United Arab Emirates	2020-05-28	2020-05-29	32532	258	16685	15589	f	f
5628	United Arab Emirates	2020-05-29	2020-05-30	33170	260	17097	15813	f	f
5629	United Arab Emirates	2020-05-30	2020-05-31	33896	262	17546	16088	f	f
5630	United Arab Emirates	2020-05-31	2020-06-01	34557	264	17932	16361	f	f
5631	United Kingdom	2020-05-01	2020-05-02	178685	27583	892	150210	f	f
5632	United Kingdom	2020-05-02	2020-05-03	183500	28205	896	154399	f	f
5633	United Kingdom	2020-05-03	2020-05-04	187842	28520	901	158421	f	f
5634	United Kingdom	2020-05-04	2020-05-05	191832	28809	910	162113	f	f
5635	United Kingdom	2020-05-05	2020-05-06	196243	29501	926	165816	f	f
5753	Venezuela	2020-05-30	2020-05-31	1459	14	302	1143	f	f
5636	United Kingdom	2020-05-06	2020-05-07	202359	30150	934	171275	f	f
5637	United Kingdom	2020-05-07	2020-05-08	207977	30689	970	176318	f	f
5638	United Kingdom	2020-05-08	2020-05-09	212629	31316	997	180316	f	f
5639	United Kingdom	2020-05-09	2020-05-10	216525	31662	1001	183862	f	f
5640	United Kingdom	2020-05-10	2020-05-11	220449	31930	1002	187517	f	f
5641	United Kingdom	2020-05-11	2020-05-12	224332	32141	1015	191176	f	f
5642	United Kingdom	2020-05-12	2020-05-13	227741	32769	1023	193949	f	f
5643	United Kingdom	2020-05-13	2020-05-14	230985	33264	1032	196689	f	f
5644	United Kingdom	2020-05-14	2020-05-15	234440	33693	1043	199704	f	f
5645	United Kingdom	2020-05-15	2020-05-16	238004	34078	1047	202879	f	f
5646	United Kingdom	2020-05-16	2020-05-17	241461	34546	1058	205857	f	f
5647	United Kingdom	2020-05-17	2020-05-18	244995	34716	1058	209221	f	f
5648	United Kingdom	2020-05-18	2020-05-19	247709	34876	1090	211743	f	f
5649	United Kingdom	2020-05-19	2020-05-20	250138	35422	1099	213617	f	f
5650	United Kingdom	2020-05-20	2020-05-21	249619	35786	1116	212717	f	f
5651	United Kingdom	2020-05-21	2020-05-22	252246	36124	1134	214988	f	f
5652	United Kingdom	2020-05-22	2020-05-23	255544	36475	1142	217927	f	f
5653	United Kingdom	2020-05-23	2020-05-24	258504	36757	1149	220598	f	f
5654	United Kingdom	2020-05-24	2020-05-25	260916	36875	1151	222890	f	f
5655	United Kingdom	2020-05-25	2020-05-26	262547	36996	1161	224390	f	f
5656	United Kingdom	2020-05-26	2020-05-27	266599	37130	1161	228308	f	f
5657	United Kingdom	2020-05-27	2020-05-28	268619	37542	1166	229911	f	f
5658	United Kingdom	2020-05-28	2020-05-29	270508	37919	1167	231422	f	f
5659	United Kingdom	2020-05-29	2020-05-30	272607	38243	1172	233192	f	f
5660	United Kingdom	2020-05-30	2020-05-31	274219	38458	1187	234574	f	f
5661	United Kingdom	2020-05-31	2020-06-01	276156	38571	1190	236395	f	f
5662	Uruguay	2020-05-01	2020-05-02	648	17	435	196	f	f
5663	Uruguay	2020-05-02	2020-05-03	652	17	440	195	f	f
5664	Uruguay	2020-05-03	2020-05-04	655	17	442	196	f	f
5665	Uruguay	2020-05-04	2020-05-05	657	17	447	193	f	f
5666	Uruguay	2020-05-05	2020-05-06	670	17	468	185	f	f
5667	Uruguay	2020-05-06	2020-05-07	673	17	486	170	f	f
5668	Uruguay	2020-05-07	2020-05-08	684	17	492	175	f	f
5669	Uruguay	2020-05-08	2020-05-09	694	18	506	170	f	f
5670	Uruguay	2020-05-09	2020-05-10	702	18	513	171	f	f
5671	Uruguay	2020-05-10	2020-05-11	707	19	517	171	f	f
5672	Uruguay	2020-05-11	2020-05-12	711	19	523	169	f	f
5673	Uruguay	2020-05-12	2020-05-13	717	19	532	166	f	f
5674	Uruguay	2020-05-13	2020-05-14	719	19	545	155	f	f
5675	Uruguay	2020-05-14	2020-05-15	724	19	547	158	f	f
5676	Uruguay	2020-05-15	2020-05-16	732	19	553	160	f	f
5677	Uruguay	2020-05-16	2020-05-17	733	19	558	156	f	f
5678	Uruguay	2020-05-17	2020-05-18	734	20	564	150	f	f
5679	Uruguay	2020-05-18	2020-05-19	737	20	569	148	f	f
5680	Uruguay	2020-05-19	2020-05-20	738	20	579	139	f	f
5681	Uruguay	2020-05-20	2020-05-21	746	20	588	138	f	f
5682	Uruguay	2020-05-21	2020-05-22	749	20	594	135	f	f
5683	Uruguay	2020-05-22	2020-05-23	753	20	603	130	f	f
5684	Uruguay	2020-05-23	2020-05-24	764	22	616	126	f	f
5685	Uruguay	2020-05-24	2020-05-25	769	22	618	129	f	f
5686	Uruguay	2020-05-25	2020-05-26	787	22	629	136	f	f
5687	Uruguay	2020-05-26	2020-05-27	789	22	638	129	f	f
5688	Uruguay	2020-05-27	2020-05-28	803	22	650	131	f	f
5689	Uruguay	2020-05-28	2020-05-29	811	22	654	135	f	f
5690	Uruguay	2020-05-29	2020-05-30	816	22	680	114	f	f
5691	Uruguay	2020-05-30	2020-05-31	821	22	682	117	f	f
5692	Uruguay	2020-05-31	2020-06-01	823	22	685	116	f	f
5693	Uzbekistan	2020-05-01	2020-05-02	2086	9	1212	865	f	f
5694	Uzbekistan	2020-05-02	2020-05-03	2118	9	1271	838	f	f
5695	Uzbekistan	2020-05-03	2020-05-04	2149	10	1319	820	f	f
5696	Uzbekistan	2020-05-04	2020-05-05	2189	10	1405	774	f	f
5697	Uzbekistan	2020-05-05	2020-05-06	2207	10	1501	696	f	f
5698	Uzbekistan	2020-05-06	2020-05-07	2233	10	1577	646	f	f
5699	Uzbekistan	2020-05-07	2020-05-08	2298	10	1656	632	f	f
5700	Uzbekistan	2020-05-08	2020-05-09	2325	10	1775	540	f	f
5701	Uzbekistan	2020-05-09	2020-05-10	2349	10	1846	493	f	f
5702	Uzbekistan	2020-05-10	2020-05-11	2418	10	1881	527	f	f
5703	Uzbekistan	2020-05-11	2020-05-12	2486	10	1988	488	f	f
5704	Uzbekistan	2020-05-12	2020-05-13	2519	10	2010	499	f	f
5705	Uzbekistan	2020-05-13	2020-05-14	2612	11	2076	525	f	f
5706	Uzbekistan	2020-05-14	2020-05-15	2645	11	2136	498	f	f
5707	Uzbekistan	2020-05-15	2020-05-16	2686	11	2158	517	f	f
5708	Uzbekistan	2020-05-16	2020-05-17	2738	11	2213	514	f	f
5709	Uzbekistan	2020-05-17	2020-05-18	2753	12	2247	494	f	f
5710	Uzbekistan	2020-05-18	2020-05-19	2791	13	2314	464	f	f
5711	Uzbekistan	2020-05-19	2020-05-20	2855	13	2338	504	f	f
5712	Uzbekistan	2020-05-20	2020-05-21	2939	13	2372	554	f	f
5713	Uzbekistan	2020-05-21	2020-05-22	2964	13	2407	544	f	f
5714	Uzbekistan	2020-05-22	2020-05-23	3028	13	2492	523	f	f
5715	Uzbekistan	2020-05-23	2020-05-24	3115	13	2532	570	f	f
5716	Uzbekistan	2020-05-24	2020-05-25	3164	13	2565	586	f	f
5717	Uzbekistan	2020-05-25	2020-05-26	3189	13	2607	569	f	f
5718	Uzbekistan	2020-05-26	2020-05-27	3290	14	2636	640	f	f
5719	Uzbekistan	2020-05-27	2020-05-28	3369	14	2668	687	f	f
5720	Uzbekistan	2020-05-28	2020-05-29	3444	14	2694	736	f	f
5721	Uzbekistan	2020-05-29	2020-05-30	3468	14	2728	726	f	f
5722	Uzbekistan	2020-05-30	2020-05-31	3546	14	2783	749	f	f
5723	Uzbekistan	2020-05-31	2020-06-01	3623	15	2837	771	f	f
5724	Venezuela	2020-05-01	2020-05-02	335	10	148	177	f	f
5725	Venezuela	2020-05-02	2020-05-03	345	10	148	187	f	f
5726	Venezuela	2020-05-03	2020-05-04	357	10	158	189	f	f
5727	Venezuela	2020-05-04	2020-05-05	357	10	158	189	f	f
5728	Venezuela	2020-05-05	2020-05-06	361	10	158	193	f	f
5729	Venezuela	2020-05-06	2020-05-07	379	10	176	193	f	f
5730	Venezuela	2020-05-07	2020-05-08	381	10	185	186	f	f
5731	Venezuela	2020-05-08	2020-05-09	388	10	190	188	f	f
5732	Venezuela	2020-05-09	2020-05-10	402	10	190	202	f	f
5733	Venezuela	2020-05-10	2020-05-11	414	10	193	211	f	f
5734	Venezuela	2020-05-11	2020-05-12	422	10	205	207	f	f
5735	Venezuela	2020-05-12	2020-05-13	423	10	220	193	f	f
5736	Venezuela	2020-05-13	2020-05-14	423	10	220	193	f	f
5737	Venezuela	2020-05-14	2020-05-15	455	10	220	225	f	f
5738	Venezuela	2020-05-15	2020-05-16	459	10	229	220	f	f
5739	Venezuela	2020-05-16	2020-05-17	504	10	241	253	f	f
5740	Venezuela	2020-05-17	2020-05-18	541	10	241	290	f	f
5741	Venezuela	2020-05-18	2020-05-19	618	10	253	355	f	f
5742	Venezuela	2020-05-19	2020-05-20	749	10	253	486	f	f
5743	Venezuela	2020-05-20	2020-05-21	824	10	262	552	f	f
5744	Venezuela	2020-05-21	2020-05-22	882	10	262	610	f	f
5745	Venezuela	2020-05-22	2020-05-23	944	10	262	672	f	f
5746	Venezuela	2020-05-23	2020-05-24	1010	10	262	738	f	f
5747	Venezuela	2020-05-24	2020-05-25	1121	10	262	849	f	f
5748	Venezuela	2020-05-25	2020-05-26	1177	10	302	865	f	f
5749	Venezuela	2020-05-26	2020-05-27	1211	11	302	898	f	f
5750	Venezuela	2020-05-27	2020-05-28	1245	11	302	932	f	f
5751	Venezuela	2020-05-28	2020-05-29	1325	11	302	1012	f	f
5752	Venezuela	2020-05-29	2020-05-30	1370	14	302	1054	f	f
5754	Venezuela	2020-05-31	2020-06-01	1510	14	302	1194	f	f
5755	Vietnam	2020-05-01	2020-05-02	270	0	219	51	f	f
5756	Vietnam	2020-05-02	2020-05-03	270	0	219	51	f	f
5757	Vietnam	2020-05-03	2020-05-04	271	0	219	52	f	f
5758	Vietnam	2020-05-04	2020-05-05	271	0	219	52	f	f
5759	Vietnam	2020-05-05	2020-05-06	271	0	232	39	f	f
5760	Vietnam	2020-05-06	2020-05-07	271	0	232	39	f	f
5761	Vietnam	2020-05-07	2020-05-08	288	0	233	55	f	f
5762	Vietnam	2020-05-08	2020-05-09	288	0	241	47	f	f
5763	Vietnam	2020-05-09	2020-05-10	288	0	241	47	f	f
5764	Vietnam	2020-05-10	2020-05-11	288	0	241	47	f	f
5765	Vietnam	2020-05-11	2020-05-12	288	0	249	39	f	f
5766	Vietnam	2020-05-12	2020-05-13	288	0	252	36	f	f
5767	Vietnam	2020-05-13	2020-05-14	288	0	252	36	f	f
5768	Vietnam	2020-05-14	2020-05-15	312	0	260	52	f	f
5769	Vietnam	2020-05-15	2020-05-16	314	0	260	54	f	f
5770	Vietnam	2020-05-16	2020-05-17	318	0	260	58	f	f
5771	Vietnam	2020-05-17	2020-05-18	320	0	260	60	f	f
5772	Vietnam	2020-05-18	2020-05-19	324	0	263	61	f	f
5773	Vietnam	2020-05-19	2020-05-20	324	0	263	61	f	f
5774	Vietnam	2020-05-20	2020-05-21	324	0	263	61	f	f
5775	Vietnam	2020-05-21	2020-05-22	324	0	266	58	f	f
5776	Vietnam	2020-05-22	2020-05-23	324	0	267	57	f	f
5777	Vietnam	2020-05-23	2020-05-24	325	0	267	58	f	f
5778	Vietnam	2020-05-24	2020-05-25	325	0	267	58	f	f
5779	Vietnam	2020-05-25	2020-05-26	326	0	272	54	f	f
5780	Vietnam	2020-05-26	2020-05-27	327	0	272	55	f	f
5781	Vietnam	2020-05-27	2020-05-28	327	0	278	49	f	f
5782	Vietnam	2020-05-28	2020-05-29	327	0	278	49	f	f
5783	Vietnam	2020-05-29	2020-05-30	328	0	279	49	f	f
5784	Vietnam	2020-05-30	2020-05-31	328	0	279	49	f	f
5785	Vietnam	2020-05-31	2020-06-01	328	0	279	49	f	f
5786	West Bank and Gaza	2020-05-01	2020-05-02	353	2	76	275	f	f
5787	West Bank and Gaza	2020-05-02	2020-05-03	353	2	76	275	f	f
5788	West Bank and Gaza	2020-05-03	2020-05-04	353	2	77	274	f	f
5789	West Bank and Gaza	2020-05-04	2020-05-05	362	2	102	258	f	f
5790	West Bank and Gaza	2020-05-05	2020-05-06	371	2	127	242	f	f
5791	West Bank and Gaza	2020-05-06	2020-05-07	374	2	174	198	f	f
5792	West Bank and Gaza	2020-05-07	2020-05-08	375	2	176	197	f	f
5793	West Bank and Gaza	2020-05-08	2020-05-09	375	2	228	145	f	f
5794	West Bank and Gaza	2020-05-09	2020-05-10	375	2	228	145	f	f
5795	West Bank and Gaza	2020-05-10	2020-05-11	375	2	263	110	f	f
5796	West Bank and Gaza	2020-05-11	2020-05-12	375	2	301	72	f	f
5797	West Bank and Gaza	2020-05-12	2020-05-13	375	2	308	65	f	f
5798	West Bank and Gaza	2020-05-13	2020-05-14	375	2	310	63	f	f
5799	West Bank and Gaza	2020-05-14	2020-05-15	375	2	310	63	f	f
5800	West Bank and Gaza	2020-05-15	2020-05-16	375	2	315	58	f	f
5801	West Bank and Gaza	2020-05-16	2020-05-17	376	2	329	45	f	f
5802	West Bank and Gaza	2020-05-17	2020-05-18	381	2	335	44	f	f
5803	West Bank and Gaza	2020-05-18	2020-05-19	388	2	337	49	f	f
5804	West Bank and Gaza	2020-05-19	2020-05-20	391	2	346	43	f	f
5805	West Bank and Gaza	2020-05-20	2020-05-21	398	2	346	50	f	f
5806	West Bank and Gaza	2020-05-21	2020-05-22	423	2	346	75	f	f
5807	West Bank and Gaza	2020-05-22	2020-05-23	423	2	346	75	f	f
5808	West Bank and Gaza	2020-05-23	2020-05-24	423	3	348	72	f	f
5809	West Bank and Gaza	2020-05-24	2020-05-25	423	3	357	63	f	f
5810	West Bank and Gaza	2020-05-25	2020-05-26	423	3	357	63	f	f
5811	West Bank and Gaza	2020-05-26	2020-05-27	429	3	365	61	f	f
5812	West Bank and Gaza	2020-05-27	2020-05-28	434	3	365	66	f	f
5813	West Bank and Gaza	2020-05-28	2020-05-29	446	3	368	75	f	f
5814	West Bank and Gaza	2020-05-29	2020-05-30	446	3	368	75	f	f
5815	West Bank and Gaza	2020-05-30	2020-05-31	447	3	368	76	f	f
5816	West Bank and Gaza	2020-05-31	2020-06-01	448	3	372	73	f	f
5817	Yemen	2020-05-01	2020-05-02	7	2	1	4	f	f
5818	Yemen	2020-05-02	2020-05-03	10	2	1	7	f	f
5819	Yemen	2020-05-03	2020-05-04	10	2	1	7	f	f
5820	Yemen	2020-05-04	2020-05-05	12	2	1	9	f	f
5821	Yemen	2020-05-05	2020-05-06	21	3	1	17	f	f
5822	Yemen	2020-05-06	2020-05-07	25	5	1	19	f	f
5823	Yemen	2020-05-07	2020-05-08	25	5	1	19	f	f
5824	Yemen	2020-05-08	2020-05-09	34	5	1	26	f	f
5825	Yemen	2020-05-09	2020-05-10	34	7	1	26	f	f
5826	Yemen	2020-05-10	2020-05-11	51	8	1	42	f	f
5827	Yemen	2020-05-11	2020-05-12	56	9	1	46	f	f
5828	Yemen	2020-05-12	2020-05-13	65	10	1	54	f	f
5829	Yemen	2020-05-13	2020-05-14	70	12	1	57	f	f
5830	Yemen	2020-05-14	2020-05-15	85	12	1	72	f	f
5831	Yemen	2020-05-15	2020-05-16	106	15	1	90	f	f
5832	Yemen	2020-05-16	2020-05-17	122	18	1	103	f	f
5833	Yemen	2020-05-17	2020-05-18	128	20	1	107	f	f
5834	Yemen	2020-05-18	2020-05-19	130	20	1	109	f	f
5835	Yemen	2020-05-19	2020-05-20	167	28	5	134	f	f
5836	Yemen	2020-05-20	2020-05-21	180	29	5	149	f	f
5837	Yemen	2020-05-21	2020-05-22	193	33	5	159	f	f
5838	Yemen	2020-05-22	2020-05-23	205	33	6	165	f	f
5839	Yemen	2020-05-23	2020-05-24	212	39	6	162	f	f
5840	Yemen	2020-05-24	2020-05-25	222	42	10	170	f	f
5841	Yemen	2020-05-25	2020-05-26	233	44	10	179	f	f
5842	Yemen	2020-05-26	2020-05-27	249	49	10	190	f	f
5843	Yemen	2020-05-27	2020-05-28	255	53	10	193	f	f
5844	Yemen	2020-05-28	2020-05-29	278	57	11	210	f	f
5845	Yemen	2020-05-29	2020-05-30	283	65	11	207	f	f
5847	Yemen	2020-05-31	2020-06-01	323	80	14	229	f	f
5848	Zambia	2020-05-01	2020-05-02	109	3	74	32	f	f
5849	Zambia	2020-05-02	2020-05-03	119	3	75	41	f	f
5850	Zambia	2020-05-03	2020-05-04	124	3	78	43	f	f
5851	Zambia	2020-05-04	2020-05-05	137	3	78	56	f	f
5852	Zambia	2020-05-05	2020-05-06	138	3	92	43	f	f
5853	Zambia	2020-05-06	2020-05-07	146	4	101	41	f	f
5854	Zambia	2020-05-07	2020-05-08	153	4	103	46	f	f
5855	Zambia	2020-05-08	2020-05-09	167	4	111	52	f	f
5856	Zambia	2020-05-09	2020-05-10	252	7	112	133	f	f
5857	Zambia	2020-05-10	2020-05-11	267	7	117	143	f	f
5858	Zambia	2020-05-11	2020-05-12	267	7	117	143	f	f
5859	Zambia	2020-05-12	2020-05-13	441	7	117	317	f	f
5860	Zambia	2020-05-13	2020-05-14	446	7	124	315	f	f
5861	Zambia	2020-05-14	2020-05-15	654	7	124	523	f	f
5862	Zambia	2020-05-15	2020-05-16	654	7	124	523	f	f
5863	Zambia	2020-05-16	2020-05-17	679	7	183	489	f	f
5864	Zambia	2020-05-17	2020-05-18	753	7	188	558	f	f
5865	Zambia	2020-05-18	2020-05-19	761	7	192	562	f	f
5866	Zambia	2020-05-19	2020-05-20	772	7	192	573	f	f
5867	Zambia	2020-05-20	2020-05-21	832	7	197	628	f	f
5868	Zambia	2020-05-21	2020-05-22	866	7	302	557	f	f
5869	Zambia	2020-05-22	2020-05-23	920	7	336	577	f	f
5870	Zambia	2020-05-23	2020-05-24	920	7	336	577	f	f
5871	Zambia	2020-05-24	2020-05-25	920	7	336	577	f	f
5872	Zambia	2020-05-25	2020-05-26	920	7	336	577	f	f
5873	Zambia	2020-05-26	2020-05-27	920	7	336	577	f	f
5874	Zambia	2020-05-27	2020-05-28	1057	7	779	271	f	f
5875	Zambia	2020-05-28	2020-05-29	1057	7	779	271	f	f
5876	Zambia	2020-05-29	2020-05-30	1057	7	779	271	f	f
5877	Zambia	2020-05-30	2020-05-31	1057	7	779	271	f	f
5878	Zambia	2020-05-31	2020-06-01	1057	7	779	271	f	f
5879	Zimbabwe	2020-05-01	2020-05-02	40	4	5	31	f	f
5880	Zimbabwe	2020-05-02	2020-05-03	34	4	5	25	f	f
5881	Zimbabwe	2020-05-03	2020-05-04	34	4	5	25	f	f
5882	Zimbabwe	2020-05-04	2020-05-05	34	4	5	25	f	f
5883	Zimbabwe	2020-05-05	2020-05-06	34	4	5	25	f	f
5884	Zimbabwe	2020-05-06	2020-05-07	34	4	5	25	f	f
5885	Zimbabwe	2020-05-07	2020-05-08	34	4	5	25	f	f
5886	Zimbabwe	2020-05-08	2020-05-09	34	4	9	21	f	f
5887	Zimbabwe	2020-05-09	2020-05-10	35	4	9	22	f	f
5888	Zimbabwe	2020-05-10	2020-05-11	36	4	9	23	f	f
5889	Zimbabwe	2020-05-11	2020-05-12	36	4	9	23	f	f
5890	Zimbabwe	2020-05-12	2020-05-13	36	4	9	23	f	f
5891	Zimbabwe	2020-05-13	2020-05-14	37	4	12	21	f	f
5892	Zimbabwe	2020-05-14	2020-05-15	37	4	13	20	f	f
5893	Zimbabwe	2020-05-15	2020-05-16	42	4	13	25	f	f
5894	Zimbabwe	2020-05-16	2020-05-17	42	4	13	25	f	f
5895	Zimbabwe	2020-05-17	2020-05-18	44	4	17	23	f	f
5896	Zimbabwe	2020-05-18	2020-05-19	46	4	18	24	f	f
5897	Zimbabwe	2020-05-19	2020-05-20	46	4	18	24	f	f
5898	Zimbabwe	2020-05-20	2020-05-21	48	4	18	26	f	f
5899	Zimbabwe	2020-05-21	2020-05-22	51	4	18	29	f	f
5900	Zimbabwe	2020-05-22	2020-05-23	51	4	18	29	f	f
5901	Zimbabwe	2020-05-23	2020-05-24	56	4	18	34	f	f
5902	Zimbabwe	2020-05-24	2020-05-25	56	4	25	27	f	f
5903	Zimbabwe	2020-05-25	2020-05-26	56	4	25	27	f	f
5904	Zimbabwe	2020-05-26	2020-05-27	56	4	25	27	f	f
5905	Zimbabwe	2020-05-27	2020-05-28	132	4	25	103	f	f
5906	Zimbabwe	2020-05-28	2020-05-29	149	4	28	117	f	f
5907	Zimbabwe	2020-05-29	2020-05-30	149	4	28	117	f	f
5908	Zimbabwe	2020-05-30	2020-05-31	174	4	29	141	f	f
5909	Zimbabwe	2020-05-31	2020-06-01	178	4	29	145	f	f
5910	test	2021-07-16	2021-07-16	1	1	1	1	f	f
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 5, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 2, true);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 2, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, false);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 1, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.records_id_seq', 5910, true);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: records records_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT records_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_fields(id);


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

