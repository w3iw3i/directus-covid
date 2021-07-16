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
    status character varying(255) DEFAULT 'draft'::character varying
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
6	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:27.490229+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	3	\N
7	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:37.887283+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	4	\N
8	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:37.932953+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	5	\N
9	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:37.959786+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	6	\N
10	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:37.986199+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	7	\N
11	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:38.013441+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	8	\N
12	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:38.040359+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	9	\N
13	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:38.067906+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	3	\N
14	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:38.094416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	10	\N
15	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:38.223682+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	11	\N
16	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.240845+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	4	\N
17	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.351863+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	5	\N
18	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.378847+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	6	\N
19	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.405734+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	7	\N
20	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.432738+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	8	\N
21	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.459498+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	9	\N
22	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.486959+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	10	\N
23	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.514134+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	11	\N
24	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:55:42.540794+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	3	\N
25	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:57:02.400751+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	records	1	\N
26	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:57:17.179525+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	records	6	\N
27	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:57:41.903214+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	3	\N
28	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:57:56.969757+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	records	1	\N
29	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 08:59:00.540237+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	records	2	\N
30	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:01:10.595384+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_fields	12	\N
31	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.212233+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	\N
32	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	1	\N
33	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	2	\N
34	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	3	\N
35	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	4	\N
36	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	5	\N
37	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	6	\N
38	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	7	\N
39	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	8	\N
40	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	9	\N
41	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	10	\N
42	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:03:13.246416+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	11	\N
43	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:02.908226+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	\N
44	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.279592+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	c9e5f866-5c9e-4c18-89bb-ed0797269088	\N
45	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	12	\N
46	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	13	\N
47	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	14	\N
48	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	15	\N
49	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	16	\N
50	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	17	\N
51	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	18	\N
52	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	19	\N
53	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	20	\N
54	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	21	\N
55	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:11.401266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	22	\N
56	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:04:49.78897+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	c9e5f866-5c9e-4c18-89bb-ed0797269088	\N
57	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:05:04.506404+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	\N
58	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:05:17.922612+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	c9e5f866-5c9e-4c18-89bb-ed0797269088	\N
59	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:07:09.979716+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_users	3edde707-490b-407f-8591-acef8c4fd843	\N
60	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:07:09.979716+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	\N
61	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:08:02.233426+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_users	b2235a4e-93db-468e-bdc4-1082f2e6d3a0	\N
62	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:08:02.233426+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	c9e5f866-5c9e-4c18-89bb-ed0797269088	\N
63	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:08:16.079985+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_users	3edde707-490b-407f-8591-acef8c4fd843	\N
64	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:08:16.079985+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_roles	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	\N
65	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:09:00.18605+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	23	\N
66	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:09:05.807203+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	24	\N
67	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:09:11.504496+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	25	\N
68	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:09:32.525387+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	26	\N
69	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:09:33.420864+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	27	\N
70	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:09:34.439299+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	28	\N
71	create	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:09:35.324757+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	29	\N
72	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:10:04.718002+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	23	\N
73	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:10:17.547024+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	23	\N
74	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:10:31.681441+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	24	\N
75	update	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-16 09:10:57.319398+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36	directus_permissions	25	\N
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
4	records	id	\N	\N	\N	\N	\N	f	f	1	full	\N	\N	\N
5	records	country_region	\N	\N	\N	\N	\N	f	f	2	full	\N	\N	\N
6	records	date	\N	\N	\N	\N	\N	f	f	3	full	\N	\N	\N
7	records	last_updated	\N	\N	\N	\N	\N	f	f	4	full	\N	\N	\N
8	records	confirmed	\N	\N	\N	\N	\N	f	f	5	full	\N	\N	\N
9	records	deaths	\N	\N	\N	\N	\N	f	f	6	full	\N	\N	\N
10	records	recovered	\N	\N	\N	\N	\N	f	f	7	full	\N	\N	\N
11	records	active	\N	\N	\N	\N	\N	f	f	8	full	\N	\N	\N
12	records	status	\N	select-dropdown	{"choices":[{"text":"draft","value":"draft"},{"text":"published","value":"published"},{"text":"delete","value":"delete"}]}	\N	\N	f	f	\N	full	\N	\N	\N
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
1	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_files	create	{}	\N	\N	*	\N
2	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_files	read	{}	\N	\N	*	\N
3	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_files	update	{}	\N	\N	*	\N
4	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_files	delete	{}	\N	\N	*	\N
5	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_folders	create	{}	\N	\N	*	\N
6	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_folders	read	{}	\N	\N	*	\N
7	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_folders	update	{}	\N	\N	*	\N
8	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_folders	delete	{}	\N	\N	\N	\N
9	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_users	read	{}	\N	\N	*	\N
10	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_users	update	{"id":{"_eq":"$CURRENT_USER"}}	\N	\N	first_name,last_name,email,password,location,title,description,avatar,language,theme	\N
11	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	directus_roles	read	{}	\N	\N	*	\N
12	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_files	create	{}	\N	\N	*	\N
13	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_files	read	{}	\N	\N	*	\N
14	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_files	update	{}	\N	\N	*	\N
15	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_files	delete	{}	\N	\N	*	\N
16	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_folders	create	{}	\N	\N	*	\N
17	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_folders	read	{}	\N	\N	*	\N
18	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_folders	update	{}	\N	\N	*	\N
19	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_folders	delete	{}	\N	\N	\N	\N
20	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_users	read	{}	\N	\N	*	\N
21	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_users	update	{"id":{"_eq":"$CURRENT_USER"}}	\N	\N	first_name,last_name,email,password,location,title,description,avatar,language,theme	\N
22	c9e5f866-5c9e-4c18-89bb-ed0797269088	directus_roles	read	{}	\N	\N	*	\N
26	c9e5f866-5c9e-4c18-89bb-ed0797269088	records	create	\N	\N	\N	*	\N
27	c9e5f866-5c9e-4c18-89bb-ed0797269088	records	read	\N	\N	\N	*	\N
28	c9e5f866-5c9e-4c18-89bb-ed0797269088	records	update	\N	\N	\N	*	\N
29	c9e5f866-5c9e-4c18-89bb-ed0797269088	records	delete	\N	\N	\N	*	\N
23	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	records	create	\N	\N	\N	id,country_region,date,last_updated,confirmed,deaths,recovered,active	\N
24	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	records	read	\N	\N	\N	*	\N
25	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	records	update	\N	\N	\N	country_region,date,last_updated,confirmed,deaths,recovered,active	\N
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, filters, layout, layout_query, layout_options, refresh_interval) FROM stdin;
2	Default View	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	\N	records	\N	\N	tabular	{"tabular":{"page":237,"fields":["country_region","date","last_updated","confirmed","deaths","recovered","active","test"]}}	{"tabular":{"widths":{"active":108,"test":86}}}	\N
1	\N	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	\N	records	\N	\N	tabular	{"tabular":{"fields":["country_region","date","id","last_updated","confirmed","deaths","recovered","active","status"]}}	\N	\N
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
2	25	records	1	{"id":1,"country_region":"Afghanistan","date":"2020-05-01","last_updated":"2020-05-02","confirmed":2291,"deaths":68,"recovered":310,"active":1957,"status":"draft"}	{}	\N
3	26	records	6	{"id":6,"country_region":"Afghanistan","date":"2020-05-06","last_updated":"2020-05-07","confirmed":3393,"deaths":104,"recovered":458,"active":2830,"status":"draft"}	{}	\N
4	28	records	1	{"id":1,"country_region":"Afghanistan","date":"2020-05-01","last_updated":"2020-05-02","confirmed":2291,"deaths":68,"recovered":310,"active":1957,"status":"draft"}	{}	\N
5	29	records	2	{"id":2,"country_region":"Afghanistan","date":"2020-05-02","last_updated":"2020-05-03","confirmed":2470,"deaths":72,"recovered":331,"active":2066,"status":"draft"}	{}	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) FROM stdin;
a8b4bfd5-89c6-4d14-8caa-7b89e0b128bd	Admin	supervised_user_circle	\N	\N	f	\N	\N	t	t
3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	Data Custodian	supervised_user_circle	User with access to read, create and edit records	\N	f	\N	\N	f	t
c9e5f866-5c9e-4c18-89bb-ed0797269088	Data Owner	supervised_user_circle	User with read, create, edit and delete access to records.	\N	f	\N	\N	f	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent) FROM stdin;
kfrP26_Zn5b8q4raseqdUkh16HFvgUdMo3gumSMrsDdIFbhi-PJRd5YbJakqFduL	5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	2021-07-23 09:11:54.409+00	::ffff:192.168.160.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36
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
b2235a4e-93db-468e-bdc4-1082f2e6d3a0	Amy	Tan	amy.tan@test.com	$argon2i$v=19$m=4096,t=3,p=1$6n6ioCnK73YYeh2Ge4ZaPA$4gYfaJTAlkn+Fro2o7suXHCoQkHjLidmPR3gN2tpiZM	\N	\N	\N	\N	\N	en-US	auto	\N	active	c9e5f866-5c9e-4c18-89bb-ed0797269088	\N	\N	\N
3edde707-490b-407f-8591-acef8c4fd843	John	Doe	john.doe@test.com	$argon2i$v=19$m=4096,t=3,p=1$KvQHoBaekq3WvpZEUu19uQ$UI5JF1jCngQPUBv6dgKHw76fXLlpxVmL8eHJTDdhk+w	\N	\N	\N	\N	\N	en-US	auto	\N	active	3d0c01f7-3105-45b2-b4a9-f1f4e2d8c396	\N	\N	\N
5cf1bfcf-b71f-4d80-9e55-cda1858f5e11	\N	\N	admin@example.com	$argon2i$v=19$m=4096,t=3,p=1$PpoxG9cbBVX2YrtJWtSY7g$NAtba08/dP74ABBuK/um0v7Z4zrt8hhO5fZ8UfiNXl4	\N	\N	\N	\N	\N	en-US	auto	\N	active	a8b4bfd5-89c6-4d14-8caa-7b89e0b128bd	\N	2021-07-16 09:11:54.439+00	/settings/data-model
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections) FROM stdin;
\.


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.records (id, country_region, date, last_updated, confirmed, deaths, recovered, active, status) FROM stdin;
1	Afghanistan	2020-05-01	2020-05-02	2291	68	310	1957	draft
2	Afghanistan	2020-05-02	2020-05-03	2470	72	331	2066	draft
3	Afghanistan	2020-05-03	2020-05-04	2705	85	345	2274	draft
4	Afghanistan	2020-05-04	2020-05-05	2895	90	397	2407	draft
5	Afghanistan	2020-05-05	2020-05-06	3225	95	421	2708	draft
6	Afghanistan	2020-05-06	2020-05-07	3393	104	458	2830	draft
7	Afghanistan	2020-05-07	2020-05-08	3564	106	468	2989	draft
8	Afghanistan	2020-05-08	2020-05-09	3781	109	472	3197	draft
9	Afghanistan	2020-05-09	2020-05-10	4042	115	502	3416	draft
10	Afghanistan	2020-05-10	2020-05-11	4403	120	558	3724	draft
11	Afghanistan	2020-05-11	2020-05-12	4687	122	558	4007	draft
12	Afghanistan	2020-05-12	2020-05-13	4968	127	610	4226	draft
13	Afghanistan	2020-05-13	2020-05-14	5227	132	648	4446	draft
14	Afghanistan	2020-05-14	2020-05-15	5640	136	691	4812	draft
15	Afghanistan	2020-05-15	2020-05-16	6054	153	745	5155	draft
16	Afghanistan	2020-05-16	2020-05-17	6403	168	745	5489	draft
17	Afghanistan	2020-05-17	2020-05-18	6665	170	778	5717	draft
18	Afghanistan	2020-05-18	2020-05-19	7073	173	801	6098	draft
19	Afghanistan	2020-05-19	2020-05-20	7654	178	850	6625	draft
20	Afghanistan	2020-05-20	2020-05-21	8146	188	930	7028	draft
21	Afghanistan	2020-05-21	2020-05-22	8677	194	938	7545	draft
22	Afghanistan	2020-05-22	2020-05-23	9219	206	996	8015	draft
23	Afghanistan	2020-05-23	2020-05-24	10001	217	1040	8742	draft
24	Afghanistan	2020-05-24	2020-05-25	10585	219	1075	9289	draft
25	Afghanistan	2020-05-25	2020-05-26	11176	220	1097	9857	draft
26	Afghanistan	2020-05-26	2020-05-27	11834	221	1128	10483	draft
27	Afghanistan	2020-05-27	2020-05-28	12459	228	1138	11091	draft
28	Afghanistan	2020-05-28	2020-05-29	13039	236	1209	11592	draft
29	Afghanistan	2020-05-29	2020-05-30	13662	247	1259	12154	draft
30	Afghanistan	2020-05-30	2020-05-31	14528	250	1303	12973	draft
31	Afghanistan	2020-05-31	2020-06-01	15208	258	1328	13620	draft
32	Albania	2020-05-01	2020-05-02	782	31	488	263	draft
33	Albania	2020-05-02	2020-05-03	789	31	519	239	draft
34	Albania	2020-05-03	2020-05-04	795	31	531	233	draft
35	Albania	2020-05-04	2020-05-05	803	31	543	229	draft
36	Albania	2020-05-05	2020-05-06	820	31	570	219	draft
37	Albania	2020-05-06	2020-05-07	832	31	595	206	draft
38	Albania	2020-05-07	2020-05-08	842	31	605	206	draft
39	Albania	2020-05-08	2020-05-09	850	31	620	199	draft
40	Albania	2020-05-09	2020-05-10	856	31	627	198	draft
41	Albania	2020-05-10	2020-05-11	868	31	650	187	draft
42	Albania	2020-05-11	2020-05-12	872	31	654	187	draft
43	Albania	2020-05-12	2020-05-13	876	31	682	163	draft
44	Albania	2020-05-13	2020-05-14	880	31	688	161	draft
45	Albania	2020-05-14	2020-05-15	898	31	694	173	draft
46	Albania	2020-05-15	2020-05-16	916	31	705	180	draft
47	Albania	2020-05-16	2020-05-17	933	31	714	188	draft
48	Albania	2020-05-17	2020-05-18	946	31	715	200	draft
49	Albania	2020-05-18	2020-05-19	948	31	727	190	draft
50	Albania	2020-05-19	2020-05-20	949	31	742	176	draft
51	Albania	2020-05-20	2020-05-21	964	31	758	175	draft
52	Albania	2020-05-21	2020-05-22	969	31	771	167	draft
53	Albania	2020-05-22	2020-05-23	981	31	777	173	draft
54	Albania	2020-05-23	2020-05-24	989	31	783	175	draft
55	Albania	2020-05-24	2020-05-25	998	32	789	177	draft
56	Albania	2020-05-25	2020-05-26	1004	32	795	177	draft
57	Albania	2020-05-26	2020-05-27	1029	33	803	193	draft
58	Albania	2020-05-27	2020-05-28	1050	33	812	205	draft
59	Albania	2020-05-28	2020-05-29	1076	33	823	220	draft
60	Albania	2020-05-29	2020-05-30	1099	33	851	215	draft
61	Albania	2020-05-30	2020-05-31	1122	33	857	232	draft
62	Albania	2020-05-31	2020-06-01	1137	33	872	232	draft
63	Algeria	2020-05-01	2020-05-02	4154	453	1821	1880	draft
64	Algeria	2020-05-02	2020-05-03	4295	459	1872	1964	draft
65	Algeria	2020-05-03	2020-05-04	4474	463	1936	2075	draft
66	Algeria	2020-05-04	2020-05-05	4648	465	1998	2185	draft
67	Algeria	2020-05-05	2020-05-06	4838	470	2067	2301	draft
68	Algeria	2020-05-06	2020-05-07	4997	476	2197	2324	draft
69	Algeria	2020-05-07	2020-05-08	5182	483	2323	2376	draft
70	Algeria	2020-05-08	2020-05-09	5369	488	2467	2414	draft
71	Algeria	2020-05-09	2020-05-10	5558	494	2546	2518	draft
72	Algeria	2020-05-10	2020-05-11	5723	502	2678	2543	draft
73	Algeria	2020-05-11	2020-05-12	5891	507	2841	2543	draft
74	Algeria	2020-05-12	2020-05-13	6067	515	2998	2554	draft
75	Algeria	2020-05-13	2020-05-14	6253	522	3058	2673	draft
76	Algeria	2020-05-14	2020-05-15	6442	529	3158	2755	draft
77	Algeria	2020-05-15	2020-05-16	6629	536	3271	2822	draft
78	Algeria	2020-05-16	2020-05-17	6821	542	3409	2870	draft
79	Algeria	2020-05-17	2020-05-18	7019	548	3507	2964	draft
80	Algeria	2020-05-18	2020-05-19	7201	555	3625	3021	draft
81	Algeria	2020-05-19	2020-05-20	7377	561	3746	3070	draft
82	Algeria	2020-05-20	2020-05-21	7542	568	3968	3006	draft
83	Algeria	2020-05-21	2020-05-22	7728	575	4062	3091	draft
84	Algeria	2020-05-22	2020-05-23	7918	582	4256	3080	draft
85	Algeria	2020-05-23	2020-05-24	8113	592	4426	3095	draft
86	Algeria	2020-05-24	2020-05-25	8306	600	4784	2922	draft
87	Algeria	2020-05-25	2020-05-26	8503	609	4747	3147	draft
88	Algeria	2020-05-26	2020-05-27	8697	617	4918	3162	draft
89	Algeria	2020-05-27	2020-05-28	8857	623	5129	3105	draft
90	Algeria	2020-05-28	2020-05-29	8997	630	5277	3090	draft
91	Algeria	2020-05-29	2020-05-30	9134	638	5422	3074	draft
92	Algeria	2020-05-30	2020-05-31	9267	646	5549	3072	draft
93	Algeria	2020-05-31	2020-06-01	9394	653	5748	2993	draft
94	Andorra	2020-05-01	2020-05-02	745	43	468	234	draft
95	Andorra	2020-05-02	2020-05-03	747	44	472	231	draft
96	Andorra	2020-05-03	2020-05-04	748	45	493	210	draft
97	Andorra	2020-05-04	2020-05-05	750	45	499	206	draft
98	Andorra	2020-05-05	2020-05-06	751	46	514	191	draft
99	Andorra	2020-05-06	2020-05-07	751	46	521	184	draft
100	Andorra	2020-05-07	2020-05-08	752	47	526	179	draft
101	Andorra	2020-05-08	2020-05-09	752	47	537	168	draft
102	Andorra	2020-05-09	2020-05-10	754	48	545	161	draft
103	Andorra	2020-05-10	2020-05-11	755	48	550	157	draft
104	Andorra	2020-05-11	2020-05-12	755	48	550	157	draft
105	Andorra	2020-05-12	2020-05-13	758	48	568	142	draft
106	Andorra	2020-05-13	2020-05-14	760	49	576	135	draft
107	Andorra	2020-05-14	2020-05-15	761	49	596	116	draft
108	Andorra	2020-05-15	2020-05-16	761	49	604	108	draft
109	Andorra	2020-05-16	2020-05-17	761	51	615	95	draft
110	Andorra	2020-05-17	2020-05-18	761	51	617	93	draft
111	Andorra	2020-05-18	2020-05-19	761	51	624	86	draft
112	Andorra	2020-05-19	2020-05-20	761	51	628	82	draft
113	Andorra	2020-05-20	2020-05-21	762	51	639	72	draft
114	Andorra	2020-05-21	2020-05-22	762	51	639	72	draft
115	Andorra	2020-05-22	2020-05-23	762	51	652	59	draft
116	Andorra	2020-05-23	2020-05-24	762	51	653	58	draft
117	Andorra	2020-05-24	2020-05-25	762	51	653	58	draft
118	Andorra	2020-05-25	2020-05-26	763	51	663	49	draft
119	Andorra	2020-05-26	2020-05-27	763	51	676	36	draft
120	Andorra	2020-05-27	2020-05-28	763	51	676	36	draft
121	Andorra	2020-05-28	2020-05-29	763	51	681	31	draft
122	Andorra	2020-05-29	2020-05-30	764	51	684	29	draft
123	Andorra	2020-05-30	2020-05-31	764	51	692	21	draft
124	Andorra	2020-05-31	2020-06-01	764	51	694	19	draft
125	Angola	2020-05-01	2020-05-02	30	2	11	17	draft
126	Angola	2020-05-02	2020-05-03	35	2	11	22	draft
127	Angola	2020-05-03	2020-05-04	35	2	11	22	draft
128	Angola	2020-05-04	2020-05-05	35	2	11	22	draft
129	Angola	2020-05-05	2020-05-06	36	2	11	23	draft
130	Angola	2020-05-06	2020-05-07	36	2	11	23	draft
131	Angola	2020-05-07	2020-05-08	36	2	11	23	draft
132	Angola	2020-05-08	2020-05-09	43	2	11	30	draft
133	Angola	2020-05-09	2020-05-10	43	2	13	28	draft
134	Angola	2020-05-10	2020-05-11	45	2	13	30	draft
135	Angola	2020-05-11	2020-05-12	45	2	13	30	draft
136	Angola	2020-05-12	2020-05-13	45	2	13	30	draft
137	Angola	2020-05-13	2020-05-14	45	2	14	29	draft
138	Angola	2020-05-14	2020-05-15	48	2	14	32	draft
139	Angola	2020-05-15	2020-05-16	48	2	17	29	draft
140	Angola	2020-05-16	2020-05-17	48	2	17	29	draft
141	Angola	2020-05-17	2020-05-18	48	2	17	29	draft
142	Angola	2020-05-18	2020-05-19	50	3	17	30	draft
143	Angola	2020-05-19	2020-05-20	52	3	17	32	draft
144	Angola	2020-05-20	2020-05-21	52	3	17	32	draft
145	Angola	2020-05-21	2020-05-22	58	3	17	38	draft
146	Angola	2020-05-22	2020-05-23	60	3	17	40	draft
147	Angola	2020-05-23	2020-05-24	61	4	18	39	draft
148	Angola	2020-05-24	2020-05-25	69	4	18	47	draft
149	Angola	2020-05-25	2020-05-26	70	4	18	48	draft
150	Angola	2020-05-26	2020-05-27	70	4	18	48	draft
151	Angola	2020-05-27	2020-05-28	71	4	18	49	draft
152	Angola	2020-05-28	2020-05-29	74	4	18	52	draft
153	Angola	2020-05-29	2020-05-30	81	4	18	59	draft
154	Angola	2020-05-30	2020-05-31	84	4	18	62	draft
155	Angola	2020-05-31	2020-06-01	86	4	18	64	draft
156	Antigua and Barbuda	2020-05-01	2020-05-02	25	3	15	7	draft
157	Antigua and Barbuda	2020-05-02	2020-05-03	25	3	15	7	draft
158	Antigua and Barbuda	2020-05-03	2020-05-04	25	3	15	7	draft
159	Antigua and Barbuda	2020-05-04	2020-05-05	25	3	15	7	draft
160	Antigua and Barbuda	2020-05-05	2020-05-06	25	3	16	6	draft
161	Antigua and Barbuda	2020-05-06	2020-05-07	25	3	16	6	draft
162	Antigua and Barbuda	2020-05-07	2020-05-08	25	3	16	6	draft
163	Antigua and Barbuda	2020-05-08	2020-05-09	25	3	16	6	draft
164	Antigua and Barbuda	2020-05-09	2020-05-10	25	3	19	3	draft
165	Antigua and Barbuda	2020-05-10	2020-05-11	25	3	19	3	draft
166	Antigua and Barbuda	2020-05-11	2020-05-12	25	3	19	3	draft
167	Antigua and Barbuda	2020-05-12	2020-05-13	25	3	19	3	draft
168	Antigua and Barbuda	2020-05-13	2020-05-14	25	3	19	3	draft
169	Antigua and Barbuda	2020-05-14	2020-05-15	25	3	19	3	draft
170	Antigua and Barbuda	2020-05-15	2020-05-16	25	3	19	3	draft
171	Antigua and Barbuda	2020-05-16	2020-05-17	25	3	19	3	draft
172	Antigua and Barbuda	2020-05-17	2020-05-18	25	3	19	3	draft
173	Antigua and Barbuda	2020-05-18	2020-05-19	25	3	19	3	draft
174	Antigua and Barbuda	2020-05-19	2020-05-20	25	3	19	3	draft
175	Antigua and Barbuda	2020-05-20	2020-05-21	25	3	19	3	draft
176	Antigua and Barbuda	2020-05-21	2020-05-22	25	3	19	3	draft
177	Antigua and Barbuda	2020-05-22	2020-05-23	25	3	19	3	draft
178	Antigua and Barbuda	2020-05-23	2020-05-24	25	3	19	3	draft
179	Antigua and Barbuda	2020-05-24	2020-05-25	25	3	19	3	draft
180	Antigua and Barbuda	2020-05-25	2020-05-26	25	3	19	3	draft
181	Antigua and Barbuda	2020-05-26	2020-05-27	25	3	19	3	draft
182	Antigua and Barbuda	2020-05-27	2020-05-28	25	3	19	3	draft
183	Antigua and Barbuda	2020-05-28	2020-05-29	25	3	19	3	draft
184	Antigua and Barbuda	2020-05-29	2020-05-30	25	3	19	3	draft
185	Antigua and Barbuda	2020-05-30	2020-05-31	25	3	19	3	draft
186	Antigua and Barbuda	2020-05-31	2020-06-01	26	3	19	4	draft
187	Argentina	2020-05-01	2020-05-02	4532	225	1292	3015	draft
188	Argentina	2020-05-02	2020-05-03	4681	237	1320	3124	draft
189	Argentina	2020-05-03	2020-05-04	4783	246	1354	3183	draft
190	Argentina	2020-05-04	2020-05-05	4887	260	1442	3185	draft
191	Argentina	2020-05-05	2020-05-06	5020	264	1472	3284	draft
192	Argentina	2020-05-06	2020-05-07	5208	273	1524	3411	draft
193	Argentina	2020-05-07	2020-05-08	5371	282	1601	3488	draft
194	Argentina	2020-05-08	2020-05-09	5611	293	1659	3659	draft
195	Argentina	2020-05-09	2020-05-10	5776	300	1728	3748	draft
196	Argentina	2020-05-10	2020-05-11	6034	305	1757	3972	draft
197	Argentina	2020-05-11	2020-05-12	6278	314	1837	4127	draft
198	Argentina	2020-05-12	2020-05-13	6563	319	1862	4382	draft
199	Argentina	2020-05-13	2020-05-14	6879	329	2266	4284	draft
200	Argentina	2020-05-14	2020-05-15	7134	353	2385	4396	draft
201	Argentina	2020-05-15	2020-05-16	7479	356	2497	4626	draft
202	Argentina	2020-05-16	2020-05-17	7805	363	2534	4908	draft
203	Argentina	2020-05-17	2020-05-18	8068	373	2569	5126	draft
204	Argentina	2020-05-18	2020-05-19	8371	382	2625	5364	draft
205	Argentina	2020-05-19	2020-05-20	8809	393	2872	5544	draft
206	Argentina	2020-05-20	2020-05-21	9283	403	2933	5947	draft
207	Argentina	2020-05-21	2020-05-22	9931	416	3032	6483	draft
208	Argentina	2020-05-22	2020-05-23	10649	433	3062	7154	draft
209	Argentina	2020-05-23	2020-05-24	11353	445	3530	7378	draft
210	Argentina	2020-05-24	2020-05-25	12076	452	3732	7892	draft
211	Argentina	2020-05-25	2020-05-26	12628	467	3999	8162	draft
212	Argentina	2020-05-26	2020-05-27	13228	484	4167	8577	draft
213	Argentina	2020-05-27	2020-05-28	13933	500	4349	9084	draft
214	Argentina	2020-05-28	2020-05-29	14702	508	4617	9577	draft
215	Argentina	2020-05-29	2020-05-30	15419	520	4788	10111	draft
216	Argentina	2020-05-30	2020-05-31	16214	528	4788	10898	draft
217	Argentina	2020-05-31	2020-06-01	16851	539	5336	10976	draft
218	Armenia	2020-05-01	2020-05-02	2148	33	977	1138	draft
219	Armenia	2020-05-02	2020-05-03	2273	33	1010	1230	draft
220	Armenia	2020-05-03	2020-05-04	2386	35	1035	1316	draft
221	Armenia	2020-05-04	2020-05-05	2507	39	1071	1397	draft
222	Armenia	2020-05-05	2020-05-06	2619	40	1111	1468	draft
223	Armenia	2020-05-06	2020-05-07	2782	40	1135	1607	draft
224	Armenia	2020-05-07	2020-05-08	2884	42	1185	1657	draft
225	Armenia	2020-05-08	2020-05-09	3029	43	1218	1768	draft
226	Armenia	2020-05-09	2020-05-10	3175	44	1267	1864	draft
227	Armenia	2020-05-10	2020-05-11	3313	45	1325	1943	draft
228	Armenia	2020-05-11	2020-05-12	3392	46	1359	1987	draft
229	Armenia	2020-05-12	2020-05-13	3538	47	1430	2061	draft
230	Armenia	2020-05-13	2020-05-14	3718	48	1500	2170	draft
231	Armenia	2020-05-14	2020-05-15	3860	49	1572	2239	draft
232	Armenia	2020-05-15	2020-05-16	4044	52	1666	2326	draft
233	Armenia	2020-05-16	2020-05-17	4283	55	1791	2437	draft
234	Armenia	2020-05-17	2020-05-18	4472	60	1925	2487	draft
235	Armenia	2020-05-18	2020-05-19	4823	61	2019	2743	draft
236	Armenia	2020-05-19	2020-05-20	5041	64	2164	2813	draft
237	Armenia	2020-05-20	2020-05-21	5271	67	2419	2785	draft
238	Armenia	2020-05-21	2020-05-22	5606	70	2581	2955	draft
239	Armenia	2020-05-22	2020-05-23	5928	74	2874	2980	draft
240	Armenia	2020-05-23	2020-05-24	6302	77	2936	3289	draft
241	Armenia	2020-05-24	2020-05-25	6661	81	3064	3516	draft
242	Armenia	2020-05-25	2020-05-26	7113	87	3145	3881	draft
243	Armenia	2020-05-26	2020-05-27	7402	91	3220	4091	draft
244	Armenia	2020-05-27	2020-05-28	7774	98	3255	4421	draft
245	Armenia	2020-05-28	2020-05-29	8216	113	3287	4816	draft
246	Armenia	2020-05-29	2020-05-30	8676	120	3297	5259	draft
247	Armenia	2020-05-30	2020-05-31	8927	127	3317	5483	draft
248	Armenia	2020-05-31	2020-06-01	9282	131	3386	5765	draft
249	Australia	2020-05-01	2020-05-02	6778	93	5775	910	draft
250	Australia	2020-05-02	2020-05-03	6799	94	5814	891	draft
251	Australia	2020-05-03	2020-05-04	6822	95	5849	878	draft
252	Australia	2020-05-04	2020-05-05	6847	96	5887	864	draft
253	Australia	2020-05-05	2020-05-06	6875	97	5975	803	draft
254	Australia	2020-05-06	2020-05-07	6894	97	6031	766	draft
255	Australia	2020-05-07	2020-05-08	6913	97	6078	738	draft
256	Australia	2020-05-08	2020-05-09	6918	97	6122	699	draft
257	Australia	2020-05-09	2020-05-10	6939	97	6141	701	draft
258	Australia	2020-05-10	2020-05-11	6948	97	6167	684	draft
259	Australia	2020-05-11	2020-05-12	6970	97	6213	660	draft
260	Australia	2020-05-12	2020-05-13	6980	98	6270	612	draft
261	Australia	2020-05-13	2020-05-14	6989	98	6297	594	draft
262	Australia	2020-05-14	2020-05-15	7019	98	6334	587	draft
263	Australia	2020-05-15	2020-05-16	7035	98	6359	578	draft
264	Australia	2020-05-16	2020-05-17	7044	98	6364	582	draft
265	Australia	2020-05-17	2020-05-18	7054	99	6392	563	draft
266	Australia	2020-05-18	2020-05-19	7068	99	6413	556	draft
267	Australia	2020-05-19	2020-05-20	7072	100	6431	541	draft
268	Australia	2020-05-20	2020-05-21	7081	100	6470	511	draft
269	Australia	2020-05-21	2020-05-22	7095	101	6478	516	draft
270	Australia	2020-05-22	2020-05-23	7099	101	6485	513	draft
271	Australia	2020-05-23	2020-05-24	7114	102	6508	504	draft
272	Australia	2020-05-24	2020-05-25	7114	102	6531	481	draft
273	Australia	2020-05-25	2020-05-26	7126	102	6552	472	draft
274	Australia	2020-05-26	2020-05-27	7139	103	6560	476	draft
275	Australia	2020-05-27	2020-05-28	7150	103	6579	468	draft
276	Australia	2020-05-28	2020-05-29	7165	103	6576	486	draft
277	Australia	2020-05-29	2020-05-30	7184	103	6605	476	draft
278	Australia	2020-05-30	2020-05-31	7192	103	6614	475	draft
279	Australia	2020-05-31	2020-06-01	7202	103	6618	481	draft
280	Austria	2020-05-01	2020-05-02	15531	589	13110	1832	draft
281	Austria	2020-05-02	2020-05-03	15558	596	13180	1782	draft
282	Austria	2020-05-03	2020-05-04	15597	598	13228	1771	draft
283	Austria	2020-05-04	2020-05-05	15621	600	13316	1705	draft
284	Austria	2020-05-05	2020-05-06	15650	606	13462	1582	draft
285	Austria	2020-05-06	2020-05-07	15684	608	13639	1437	draft
286	Austria	2020-05-07	2020-05-08	15752	609	13698	1445	draft
287	Austria	2020-05-08	2020-05-09	15774	614	13836	1324	draft
288	Austria	2020-05-09	2020-05-10	15833	615	13928	1290	draft
289	Austria	2020-05-10	2020-05-11	15871	618	13991	1262	draft
290	Austria	2020-05-11	2020-05-12	15882	620	14061	1201	draft
291	Austria	2020-05-12	2020-05-13	15961	623	14148	1190	draft
292	Austria	2020-05-13	2020-05-14	15997	624	14304	1069	draft
293	Austria	2020-05-14	2020-05-15	16058	626	14405	1027	draft
294	Austria	2020-05-15	2020-05-16	16109	628	14471	1010	draft
295	Austria	2020-05-16	2020-05-17	16201	629	14524	1048	draft
296	Austria	2020-05-17	2020-05-18	16242	629	14563	1050	draft
297	Austria	2020-05-18	2020-05-19	16269	629	14614	1026	draft
298	Austria	2020-05-19	2020-05-20	16321	632	14678	1011	draft
299	Austria	2020-05-20	2020-05-21	16353	633	14882	838	draft
300	Austria	2020-05-21	2020-05-22	16404	633	14951	820	draft
301	Austria	2020-05-22	2020-05-23	16436	635	15005	796	draft
302	Austria	2020-05-23	2020-05-24	16486	639	15037	810	draft
303	Austria	2020-05-24	2020-05-25	16503	640	15063	800	draft
304	Austria	2020-05-25	2020-05-26	16539	641	15138	760	draft
305	Austria	2020-05-26	2020-05-27	16557	643	15182	732	draft
306	Austria	2020-05-27	2020-05-28	16591	645	15228	718	draft
307	Austria	2020-05-28	2020-05-29	16628	668	15286	674	draft
308	Austria	2020-05-29	2020-05-30	16655	668	15347	640	draft
309	Austria	2020-05-30	2020-05-31	16685	668	15520	497	draft
310	Austria	2020-05-31	2020-06-01	16731	668	15593	470	draft
311	Azerbaijan	2020-05-01	2020-05-02	1854	25	1365	464	draft
312	Azerbaijan	2020-05-02	2020-05-03	1894	25	1411	458	draft
313	Azerbaijan	2020-05-03	2020-05-04	1932	25	1441	466	draft
314	Azerbaijan	2020-05-04	2020-05-05	1984	26	1480	478	draft
315	Azerbaijan	2020-05-05	2020-05-06	2060	26	1508	526	draft
316	Azerbaijan	2020-05-06	2020-05-07	2127	28	1536	563	draft
317	Azerbaijan	2020-05-07	2020-05-08	2204	28	1551	625	draft
318	Azerbaijan	2020-05-08	2020-05-09	2279	28	1576	675	draft
319	Azerbaijan	2020-05-09	2020-05-10	2422	31	1620	771	draft
320	Azerbaijan	2020-05-10	2020-05-11	2519	32	1650	837	draft
321	Azerbaijan	2020-05-11	2020-05-12	2589	32	1680	877	draft
322	Azerbaijan	2020-05-12	2020-05-13	2693	33	1680	980	draft
323	Azerbaijan	2020-05-13	2020-05-14	2758	35	1789	934	draft
324	Azerbaijan	2020-05-14	2020-05-15	2879	35	1833	1011	draft
325	Azerbaijan	2020-05-15	2020-05-16	2980	36	1886	1058	draft
326	Azerbaijan	2020-05-16	2020-05-17	3138	36	1944	1158	draft
327	Azerbaijan	2020-05-17	2020-05-18	3274	39	2015	1220	draft
328	Azerbaijan	2020-05-18	2020-05-19	3387	40	2055	1292	draft
329	Azerbaijan	2020-05-19	2020-05-20	3518	41	2198	1279	draft
330	Azerbaijan	2020-05-20	2020-05-21	3631	43	2253	1335	draft
331	Azerbaijan	2020-05-21	2020-05-22	3749	44	2340	1365	draft
332	Azerbaijan	2020-05-22	2020-05-23	3855	46	2399	1410	draft
333	Azerbaijan	2020-05-23	2020-05-24	3982	49	2506	1427	draft
334	Azerbaijan	2020-05-24	2020-05-25	4122	49	2607	1466	draft
335	Azerbaijan	2020-05-25	2020-05-26	4271	51	2741	1479	draft
336	Azerbaijan	2020-05-26	2020-05-27	4403	52	2819	1532	draft
337	Azerbaijan	2020-05-27	2020-05-28	4568	54	2897	1617	draft
338	Azerbaijan	2020-05-28	2020-05-29	4759	56	3022	1681	draft
339	Azerbaijan	2020-05-29	2020-05-30	4989	58	3125	1806	draft
340	Azerbaijan	2020-05-30	2020-05-31	5246	61	3327	1858	draft
341	Azerbaijan	2020-05-31	2020-06-01	5494	63	3428	2003	draft
342	Bahamas	2020-05-01	2020-05-02	81	11	24	46	draft
343	Bahamas	2020-05-02	2020-05-03	83	11	24	48	draft
344	Bahamas	2020-05-03	2020-05-04	83	11	24	48	draft
345	Bahamas	2020-05-04	2020-05-05	83	11	25	47	draft
346	Bahamas	2020-05-05	2020-05-06	89	11	26	52	draft
347	Bahamas	2020-05-06	2020-05-07	92	11	26	55	draft
348	Bahamas	2020-05-07	2020-05-08	92	11	26	55	draft
349	Bahamas	2020-05-08	2020-05-09	92	11	31	50	draft
350	Bahamas	2020-05-09	2020-05-10	92	11	37	44	draft
351	Bahamas	2020-05-10	2020-05-11	92	11	37	44	draft
352	Bahamas	2020-05-11	2020-05-12	93	11	39	43	draft
353	Bahamas	2020-05-12	2020-05-13	93	11	39	43	draft
354	Bahamas	2020-05-13	2020-05-14	94	11	41	42	draft
355	Bahamas	2020-05-14	2020-05-15	96	11	41	44	draft
356	Bahamas	2020-05-15	2020-05-16	96	11	41	44	draft
357	Bahamas	2020-05-16	2020-05-17	96	11	42	43	draft
358	Bahamas	2020-05-17	2020-05-18	96	11	42	43	draft
359	Bahamas	2020-05-18	2020-05-19	96	11	43	42	draft
360	Bahamas	2020-05-19	2020-05-20	96	11	43	42	draft
361	Bahamas	2020-05-20	2020-05-21	97	11	43	43	draft
362	Bahamas	2020-05-21	2020-05-22	97	11	44	42	draft
363	Bahamas	2020-05-22	2020-05-23	97	11	44	42	draft
364	Bahamas	2020-05-23	2020-05-24	100	11	45	44	draft
365	Bahamas	2020-05-24	2020-05-25	100	11	45	44	draft
366	Bahamas	2020-05-25	2020-05-26	100	11	46	43	draft
367	Bahamas	2020-05-26	2020-05-27	100	11	46	43	draft
368	Bahamas	2020-05-27	2020-05-28	100	11	46	43	draft
369	Bahamas	2020-05-28	2020-05-29	101	11	47	43	draft
370	Bahamas	2020-05-29	2020-05-30	102	11	48	43	draft
371	Bahamas	2020-05-30	2020-05-31	102	11	48	43	draft
372	Bahamas	2020-05-31	2020-06-01	102	11	48	43	draft
373	Bahrain	2020-05-01	2020-05-02	3170	8	1555	1607	draft
374	Bahrain	2020-05-02	2020-05-03	3284	8	1568	1708	draft
375	Bahrain	2020-05-03	2020-05-04	3383	8	1718	1657	draft
376	Bahrain	2020-05-04	2020-05-05	3533	8	1744	1781	draft
377	Bahrain	2020-05-05	2020-05-06	3720	8	1762	1950	draft
378	Bahrain	2020-05-06	2020-05-07	3934	8	1860	2066	draft
379	Bahrain	2020-05-07	2020-05-08	4199	8	2000	2191	draft
380	Bahrain	2020-05-08	2020-05-09	4444	8	2028	2408	draft
381	Bahrain	2020-05-09	2020-05-10	4774	8	2055	2711	draft
382	Bahrain	2020-05-10	2020-05-11	4941	8	2070	2863	draft
383	Bahrain	2020-05-11	2020-05-12	5236	8	2152	3076	draft
384	Bahrain	2020-05-12	2020-05-13	5531	9	2192	3330	draft
385	Bahrain	2020-05-13	2020-05-14	5816	10	2205	3601	draft
386	Bahrain	2020-05-14	2020-05-15	6198	10	2353	3835	draft
387	Bahrain	2020-05-15	2020-05-16	6583	12	2640	3931	draft
388	Bahrain	2020-05-16	2020-05-17	6747	12	2762	3973	draft
389	Bahrain	2020-05-17	2020-05-18	6956	12	2910	4034	draft
390	Bahrain	2020-05-18	2020-05-19	7184	12	2931	4241	draft
391	Bahrain	2020-05-19	2020-05-20	7532	12	2952	4568	draft
392	Bahrain	2020-05-20	2020-05-21	7888	12	3568	4308	draft
393	Bahrain	2020-05-21	2020-05-22	8174	12	3873	4289	draft
394	Bahrain	2020-05-22	2020-05-23	8414	12	4096	4306	draft
395	Bahrain	2020-05-23	2020-05-24	8802	13	4465	4324	draft
396	Bahrain	2020-05-24	2020-05-25	9138	14	4587	4537	draft
397	Bahrain	2020-05-25	2020-05-26	9171	14	4753	4404	draft
398	Bahrain	2020-05-26	2020-05-27	9366	14	4938	4414	draft
399	Bahrain	2020-05-27	2020-05-28	9692	15	5152	4525	draft
400	Bahrain	2020-05-28	2020-05-29	10052	15	5419	4618	draft
401	Bahrain	2020-05-29	2020-05-30	10449	15	5700	4734	draft
402	Bahrain	2020-05-30	2020-05-31	10793	17	5826	4950	draft
403	Bahrain	2020-05-31	2020-06-01	11398	19	6673	4706	draft
404	Bangladesh	2020-05-01	2020-05-02	8238	170	174	7894	draft
405	Bangladesh	2020-05-02	2020-05-03	8790	175	177	8438	draft
406	Bangladesh	2020-05-03	2020-05-04	9455	177	1063	8215	draft
407	Bangladesh	2020-05-04	2020-05-05	10143	182	1209	8752	draft
408	Bangladesh	2020-05-05	2020-05-06	10929	183	1403	9343	draft
409	Bangladesh	2020-05-06	2020-05-07	11719	186	1403	10130	draft
410	Bangladesh	2020-05-07	2020-05-08	12425	199	1910	10316	draft
411	Bangladesh	2020-05-08	2020-05-09	13134	206	2101	10827	draft
412	Bangladesh	2020-05-09	2020-05-10	13770	214	2414	11142	draft
413	Bangladesh	2020-05-10	2020-05-11	14657	228	2650	11779	draft
414	Bangladesh	2020-05-11	2020-05-12	15691	239	2902	12550	draft
415	Bangladesh	2020-05-12	2020-05-13	16660	250	3147	13263	draft
416	Bangladesh	2020-05-13	2020-05-14	17822	269	3361	14192	draft
417	Bangladesh	2020-05-14	2020-05-15	18863	283	3361	15219	draft
418	Bangladesh	2020-05-15	2020-05-16	20065	298	3882	15885	draft
419	Bangladesh	2020-05-16	2020-05-17	20995	314	4117	16564	draft
420	Bangladesh	2020-05-17	2020-05-18	22268	328	4373	17567	draft
421	Bangladesh	2020-05-18	2020-05-19	23870	349	4585	18936	draft
422	Bangladesh	2020-05-19	2020-05-20	25121	370	4993	19758	draft
423	Bangladesh	2020-05-20	2020-05-21	26738	386	5207	21145	draft
424	Bangladesh	2020-05-21	2020-05-22	28511	408	5602	22501	draft
425	Bangladesh	2020-05-22	2020-05-23	30205	432	6190	23583	draft
426	Bangladesh	2020-05-23	2020-05-24	32078	452	6486	25140	draft
427	Bangladesh	2020-05-24	2020-05-25	33610	480	6901	26229	draft
428	Bangladesh	2020-05-25	2020-05-26	35585	501	7334	27750	draft
429	Bangladesh	2020-05-26	2020-05-27	36751	522	7579	28650	draft
430	Bangladesh	2020-05-27	2020-05-28	38292	544	7925	29823	draft
431	Bangladesh	2020-05-28	2020-05-29	40321	559	8425	31337	draft
432	Bangladesh	2020-05-29	2020-05-30	42844	582	9015	33247	draft
433	Bangladesh	2020-05-30	2020-05-31	44608	610	9375	34623	draft
434	Bangladesh	2020-05-31	2020-06-01	47153	650	9781	36722	draft
435	Barbados	2020-05-01	2020-05-02	81	7	39	35	draft
436	Barbados	2020-05-02	2020-05-03	81	7	44	30	draft
437	Barbados	2020-05-03	2020-05-04	82	7	44	31	draft
438	Barbados	2020-05-04	2020-05-05	82	7	46	29	draft
439	Barbados	2020-05-05	2020-05-06	82	7	47	28	draft
440	Barbados	2020-05-06	2020-05-07	82	7	47	28	draft
441	Barbados	2020-05-07	2020-05-08	82	7	53	22	draft
442	Barbados	2020-05-08	2020-05-09	83	7	53	23	draft
443	Barbados	2020-05-09	2020-05-10	84	7	57	20	draft
444	Barbados	2020-05-10	2020-05-11	84	7	57	20	draft
445	Barbados	2020-05-11	2020-05-12	84	7	57	20	draft
446	Barbados	2020-05-12	2020-05-13	85	7	57	21	draft
447	Barbados	2020-05-13	2020-05-14	85	7	65	13	draft
448	Barbados	2020-05-14	2020-05-15	85	7	65	13	draft
449	Barbados	2020-05-15	2020-05-16	85	7	65	13	draft
450	Barbados	2020-05-16	2020-05-17	86	7	67	12	draft
451	Barbados	2020-05-17	2020-05-18	88	7	68	13	draft
452	Barbados	2020-05-18	2020-05-19	88	7	68	13	draft
453	Barbados	2020-05-19	2020-05-20	90	7	68	15	draft
454	Barbados	2020-05-20	2020-05-21	90	7	70	13	draft
455	Barbados	2020-05-21	2020-05-22	90	7	70	13	draft
456	Barbados	2020-05-22	2020-05-23	90	7	70	13	draft
457	Barbados	2020-05-23	2020-05-24	92	7	70	15	draft
458	Barbados	2020-05-24	2020-05-25	92	7	70	15	draft
459	Barbados	2020-05-25	2020-05-26	92	7	71	14	draft
460	Barbados	2020-05-26	2020-05-27	92	7	71	14	draft
461	Barbados	2020-05-27	2020-05-28	92	7	76	9	draft
462	Barbados	2020-05-28	2020-05-29	92	7	76	9	draft
463	Barbados	2020-05-29	2020-05-30	92	7	76	9	draft
464	Barbados	2020-05-30	2020-05-31	92	7	76	9	draft
465	Barbados	2020-05-31	2020-06-01	92	7	76	9	draft
466	Belarus	2020-05-01	2020-05-02	14917	93	2918	11906	draft
467	Belarus	2020-05-02	2020-05-03	15828	97	3117	12614	draft
468	Belarus	2020-05-03	2020-05-04	16705	99	3196	13410	draft
469	Belarus	2020-05-04	2020-05-05	17489	103	3259	14127	draft
470	Belarus	2020-05-05	2020-05-06	18350	107	3771	14472	draft
471	Belarus	2020-05-06	2020-05-07	19255	112	4388	14755	draft
472	Belarus	2020-05-07	2020-05-08	20168	116	5067	14985	draft
473	Belarus	2020-05-08	2020-05-09	21101	121	5484	15496	draft
474	Belarus	2020-05-09	2020-05-10	22052	126	6050	15876	draft
475	Belarus	2020-05-10	2020-05-11	22973	131	6406	16436	draft
476	Belarus	2020-05-11	2020-05-12	23906	135	6531	17240	draft
477	Belarus	2020-05-12	2020-05-13	24873	142	6974	17757	draft
478	Belarus	2020-05-13	2020-05-14	25825	146	7711	17968	draft
479	Belarus	2020-05-14	2020-05-15	26772	151	8168	18453	draft
480	Belarus	2020-05-15	2020-05-16	27730	156	8807	18767	draft
481	Belarus	2020-05-16	2020-05-17	28681	160	9498	19023	draft
482	Belarus	2020-05-17	2020-05-18	29650	165	9932	19553	draft
483	Belarus	2020-05-18	2020-05-19	30572	171	10130	20271	draft
484	Belarus	2020-05-19	2020-05-20	31508	175	10620	20713	draft
485	Belarus	2020-05-20	2020-05-21	32426	179	11415	20832	draft
486	Belarus	2020-05-21	2020-05-22	33371	185	12057	21129	draft
487	Belarus	2020-05-22	2020-05-23	34303	190	12833	21280	draft
488	Belarus	2020-05-23	2020-05-24	35244	194	13528	21522	draft
489	Belarus	2020-05-24	2020-05-25	36198	199	14155	21844	draft
490	Belarus	2020-05-25	2020-05-26	37144	204	14449	22491	draft
491	Belarus	2020-05-26	2020-05-27	38059	208	15086	22765	draft
492	Belarus	2020-05-27	2020-05-28	38956	214	15923	22819	draft
493	Belarus	2020-05-28	2020-05-29	39858	219	16660	22979	draft
494	Belarus	2020-05-29	2020-05-30	40764	224	17390	23150	draft
495	Belarus	2020-05-30	2020-05-31	41658	229	17964	23465	draft
496	Belarus	2020-05-31	2020-06-01	42556	235	18514	23807	draft
497	Belgium	2020-05-01	2020-05-02	49032	7703	11892	29437	draft
498	Belgium	2020-05-02	2020-05-03	49517	7765	12211	29541	draft
499	Belgium	2020-05-03	2020-05-04	49906	7844	12309	29753	draft
500	Belgium	2020-05-04	2020-05-05	50267	7924	12378	29965	draft
501	Belgium	2020-05-05	2020-05-06	50509	8016	12441	30052	draft
502	Belgium	2020-05-06	2020-05-07	50781	8339	12731	29711	draft
503	Belgium	2020-05-07	2020-05-08	51420	8415	12980	30025	draft
504	Belgium	2020-05-08	2020-05-09	52011	8521	13201	30289	draft
505	Belgium	2020-05-09	2020-05-10	52596	8581	13411	30604	draft
506	Belgium	2020-05-10	2020-05-11	53081	8656	13642	30783	draft
507	Belgium	2020-05-11	2020-05-12	53449	8707	13697	31045	draft
508	Belgium	2020-05-12	2020-05-13	53779	8761	13732	31286	draft
509	Belgium	2020-05-13	2020-05-14	53981	8843	13937	31201	draft
510	Belgium	2020-05-14	2020-05-15	54288	8903	14111	31274	draft
511	Belgium	2020-05-15	2020-05-16	54644	8959	14301	31384	draft
512	Belgium	2020-05-16	2020-05-17	54989	9005	14460	31524	draft
513	Belgium	2020-05-17	2020-05-18	55280	9052	14630	31598	draft
514	Belgium	2020-05-18	2020-05-19	55559	9080	14657	31822	draft
515	Belgium	2020-05-19	2020-05-20	55791	9108	14687	31996	draft
516	Belgium	2020-05-20	2020-05-21	55983	9150	14847	31986	draft
517	Belgium	2020-05-21	2020-05-22	56235	9186	14988	32061	draft
518	Belgium	2020-05-22	2020-05-23	56511	9212	15123	32176	draft
519	Belgium	2020-05-23	2020-05-24	56810	9237	15155	32418	draft
520	Belgium	2020-05-24	2020-05-25	57092	9280	15272	32540	draft
521	Belgium	2020-05-25	2020-05-26	57342	9312	15297	32733	draft
522	Belgium	2020-05-26	2020-05-27	57455	9334	15320	32801	draft
523	Belgium	2020-05-27	2020-05-28	57592	9364	15465	32763	draft
524	Belgium	2020-05-28	2020-05-29	57849	9388	15572	32889	draft
525	Belgium	2020-05-29	2020-05-30	58061	9430	15682	32949	draft
526	Belgium	2020-05-30	2020-05-31	58186	9453	15769	32964	draft
527	Belgium	2020-05-31	2020-06-01	58381	9467	15887	33027	draft
528	Belize	2020-05-01	2020-05-02	18	2	13	3	draft
529	Belize	2020-05-02	2020-05-03	18	2	13	3	draft
530	Belize	2020-05-03	2020-05-04	18	2	13	3	draft
531	Belize	2020-05-04	2020-05-05	18	2	14	2	draft
532	Belize	2020-05-05	2020-05-06	18	2	16	0	draft
533	Belize	2020-05-06	2020-05-07	18	2	16	0	draft
534	Belize	2020-05-07	2020-05-08	18	2	16	0	draft
535	Belize	2020-05-08	2020-05-09	18	2	16	0	draft
536	Belize	2020-05-09	2020-05-10	18	2	16	0	draft
537	Belize	2020-05-10	2020-05-11	18	2	16	0	draft
538	Belize	2020-05-11	2020-05-12	18	2	16	0	draft
539	Belize	2020-05-12	2020-05-13	18	2	16	0	draft
540	Belize	2020-05-13	2020-05-14	18	2	16	0	draft
541	Belize	2020-05-14	2020-05-15	18	2	16	0	draft
542	Belize	2020-05-15	2020-05-16	18	2	16	0	draft
543	Belize	2020-05-16	2020-05-17	18	2	16	0	draft
544	Belize	2020-05-17	2020-05-18	18	2	16	0	draft
545	Belize	2020-05-18	2020-05-19	18	2	16	0	draft
546	Belize	2020-05-19	2020-05-20	18	2	16	0	draft
547	Belize	2020-05-20	2020-05-21	18	2	16	0	draft
548	Belize	2020-05-21	2020-05-22	18	2	16	0	draft
549	Belize	2020-05-22	2020-05-23	18	2	16	0	draft
550	Belize	2020-05-23	2020-05-24	18	2	16	0	draft
551	Belize	2020-05-24	2020-05-25	18	2	16	0	draft
552	Belize	2020-05-25	2020-05-26	18	2	16	0	draft
553	Belize	2020-05-26	2020-05-27	18	2	16	0	draft
554	Belize	2020-05-27	2020-05-28	18	2	16	0	draft
555	Belize	2020-05-28	2020-05-29	18	2	16	0	draft
556	Belize	2020-05-29	2020-05-30	18	2	16	0	draft
557	Belize	2020-05-30	2020-05-31	18	2	16	0	draft
558	Belize	2020-05-31	2020-06-01	18	2	16	0	draft
559	Benin	2020-05-01	2020-05-02	90	2	42	46	draft
560	Benin	2020-05-02	2020-05-03	90	2	42	46	draft
561	Benin	2020-05-03	2020-05-04	90	2	42	46	draft
562	Benin	2020-05-04	2020-05-05	96	2	50	44	draft
563	Benin	2020-05-05	2020-05-06	96	2	50	44	draft
564	Benin	2020-05-06	2020-05-07	96	2	50	44	draft
565	Benin	2020-05-07	2020-05-08	140	2	53	85	draft
566	Benin	2020-05-08	2020-05-09	242	2	62	178	draft
567	Benin	2020-05-09	2020-05-10	284	2	62	220	draft
568	Benin	2020-05-10	2020-05-11	319	2	62	255	draft
569	Benin	2020-05-11	2020-05-12	319	2	62	255	draft
570	Benin	2020-05-12	2020-05-13	327	2	76	249	draft
571	Benin	2020-05-13	2020-05-14	327	2	83	242	draft
572	Benin	2020-05-14	2020-05-15	339	2	83	254	draft
573	Benin	2020-05-15	2020-05-16	339	2	83	254	draft
574	Benin	2020-05-16	2020-05-17	339	2	83	254	draft
575	Benin	2020-05-17	2020-05-18	339	2	83	254	draft
576	Benin	2020-05-18	2020-05-19	339	2	83	254	draft
577	Benin	2020-05-19	2020-05-20	130	2	83	45	draft
578	Benin	2020-05-20	2020-05-21	130	2	57	71	draft
579	Benin	2020-05-21	2020-05-22	135	3	61	71	draft
580	Benin	2020-05-22	2020-05-23	135	3	61	71	draft
581	Benin	2020-05-23	2020-05-24	135	3	61	71	draft
582	Benin	2020-05-24	2020-05-25	191	3	82	106	draft
583	Benin	2020-05-25	2020-05-26	191	3	84	104	draft
584	Benin	2020-05-26	2020-05-27	208	3	118	87	draft
585	Benin	2020-05-27	2020-05-28	210	3	134	73	draft
586	Benin	2020-05-28	2020-05-29	210	3	134	73	draft
587	Benin	2020-05-29	2020-05-30	224	3	136	85	draft
588	Benin	2020-05-30	2020-05-31	224	3	136	85	draft
589	Benin	2020-05-31	2020-06-01	232	3	143	86	draft
590	Bhutan	2020-05-01	2020-05-02	7	0	5	2	draft
591	Bhutan	2020-05-02	2020-05-03	7	0	5	2	draft
592	Bhutan	2020-05-03	2020-05-04	7	0	5	2	draft
593	Bhutan	2020-05-04	2020-05-05	7	0	5	2	draft
594	Bhutan	2020-05-05	2020-05-06	7	0	5	2	draft
595	Bhutan	2020-05-06	2020-05-07	7	0	5	2	draft
596	Bhutan	2020-05-07	2020-05-08	7	0	5	2	draft
597	Bhutan	2020-05-08	2020-05-09	7	0	5	2	draft
598	Bhutan	2020-05-09	2020-05-10	7	0	5	2	draft
599	Bhutan	2020-05-10	2020-05-11	7	0	5	2	draft
600	Bhutan	2020-05-11	2020-05-12	11	0	5	6	draft
601	Bhutan	2020-05-12	2020-05-13	11	0	5	6	draft
602	Bhutan	2020-05-13	2020-05-14	15	0	5	10	draft
603	Bhutan	2020-05-14	2020-05-15	20	0	5	15	draft
604	Bhutan	2020-05-15	2020-05-16	21	0	5	16	draft
605	Bhutan	2020-05-16	2020-05-17	21	0	5	16	draft
606	Bhutan	2020-05-17	2020-05-18	21	0	5	16	draft
607	Bhutan	2020-05-18	2020-05-19	21	0	5	16	draft
608	Bhutan	2020-05-19	2020-05-20	21	0	5	16	draft
609	Bhutan	2020-05-20	2020-05-21	21	0	5	16	draft
610	Bhutan	2020-05-21	2020-05-22	21	0	6	15	draft
611	Bhutan	2020-05-22	2020-05-23	21	0	6	15	draft
612	Bhutan	2020-05-23	2020-05-24	24	0	6	18	draft
613	Bhutan	2020-05-24	2020-05-25	24	0	6	18	draft
614	Bhutan	2020-05-25	2020-05-26	27	0	6	21	draft
615	Bhutan	2020-05-26	2020-05-27	27	0	6	21	draft
616	Bhutan	2020-05-27	2020-05-28	28	0	6	22	draft
617	Bhutan	2020-05-28	2020-05-29	31	0	6	25	draft
618	Bhutan	2020-05-29	2020-05-30	31	0	6	25	draft
619	Bhutan	2020-05-30	2020-05-31	33	0	6	27	draft
620	Bhutan	2020-05-31	2020-06-01	43	0	6	37	draft
621	Bolivia	2020-05-01	2020-05-02	1229	66	134	1029	draft
622	Bolivia	2020-05-02	2020-05-03	1229	66	134	1029	draft
623	Bolivia	2020-05-03	2020-05-04	1594	76	166	1352	draft
624	Bolivia	2020-05-04	2020-05-05	1681	82	174	1425	draft
625	Bolivia	2020-05-05	2020-05-06	1802	86	187	1529	draft
626	Bolivia	2020-05-06	2020-05-07	1886	91	198	1597	draft
627	Bolivia	2020-05-07	2020-05-08	2081	102	219	1760	draft
628	Bolivia	2020-05-08	2020-05-09	2266	106	237	1923	draft
629	Bolivia	2020-05-09	2020-05-10	2437	114	258	2065	draft
630	Bolivia	2020-05-10	2020-05-11	2556	118	273	2165	draft
631	Bolivia	2020-05-11	2020-05-12	2831	122	299	2410	draft
632	Bolivia	2020-05-12	2020-05-13	2964	128	313	2523	draft
633	Bolivia	2020-05-13	2020-05-14	3148	142	339	2667	draft
634	Bolivia	2020-05-14	2020-05-15	3372	152	356	2864	draft
635	Bolivia	2020-05-15	2020-05-16	3577	164	434	2979	draft
636	Bolivia	2020-05-16	2020-05-17	3826	165	473	3188	draft
637	Bolivia	2020-05-17	2020-05-18	4088	169	493	3426	draft
638	Bolivia	2020-05-18	2020-05-19	4263	174	503	3586	draft
639	Bolivia	2020-05-19	2020-05-20	4481	189	533	3759	draft
640	Bolivia	2020-05-20	2020-05-21	4919	199	553	4167	draft
641	Bolivia	2020-05-21	2020-05-22	5187	215	561	4411	draft
642	Bolivia	2020-05-22	2020-05-23	5579	230	575	4774	draft
643	Bolivia	2020-05-23	2020-05-24	5915	240	609	5066	draft
644	Bolivia	2020-05-24	2020-05-25	6263	250	629	5384	draft
645	Bolivia	2020-05-25	2020-05-26	6660	261	647	5752	draft
646	Bolivia	2020-05-26	2020-05-27	7136	274	677	6185	draft
647	Bolivia	2020-05-27	2020-05-28	7768	280	689	6799	draft
648	Bolivia	2020-05-28	2020-05-29	8387	293	738	7356	draft
649	Bolivia	2020-05-29	2020-05-30	8731	300	749	7682	draft
650	Bolivia	2020-05-30	2020-05-31	9592	310	889	8393	draft
651	Bolivia	2020-05-31	2020-06-01	9982	313	968	8701	draft
652	Bosnia and Herzegovina	2020-05-01	2020-05-02	1781	70	755	956	draft
653	Bosnia and Herzegovina	2020-05-02	2020-05-03	1839	72	779	988	draft
654	Bosnia and Herzegovina	2020-05-03	2020-05-04	1857	77	825	955	draft
655	Bosnia and Herzegovina	2020-05-04	2020-05-05	1926	78	855	993	draft
656	Bosnia and Herzegovina	2020-05-05	2020-05-06	1946	79	911	956	draft
657	Bosnia and Herzegovina	2020-05-06	2020-05-07	1987	86	928	973	draft
658	Bosnia and Herzegovina	2020-05-07	2020-05-08	2027	90	954	983	draft
659	Bosnia and Herzegovina	2020-05-08	2020-05-09	2070	98	960	1012	draft
660	Bosnia and Herzegovina	2020-05-09	2020-05-10	2090	102	1059	929	draft
661	Bosnia and Herzegovina	2020-05-10	2020-05-11	2117	107	1106	904	draft
662	Bosnia and Herzegovina	2020-05-11	2020-05-12	2141	113	1114	914	draft
663	Bosnia and Herzegovina	2020-05-12	2020-05-13	2158	117	1168	873	draft
664	Bosnia and Herzegovina	2020-05-13	2020-05-14	2181	120	1228	833	draft
665	Bosnia and Herzegovina	2020-05-14	2020-05-15	2218	122	1272	824	draft
666	Bosnia and Herzegovina	2020-05-15	2020-05-16	2236	128	1336	772	draft
667	Bosnia and Herzegovina	2020-05-16	2020-05-17	2267	129	1355	783	draft
668	Bosnia and Herzegovina	2020-05-17	2020-05-18	2290	133	1436	721	draft
669	Bosnia and Herzegovina	2020-05-18	2020-05-19	2304	133	1464	707	draft
670	Bosnia and Herzegovina	2020-05-19	2020-05-20	2321	134	1522	665	draft
671	Bosnia and Herzegovina	2020-05-20	2020-05-21	2338	136	1557	645	draft
672	Bosnia and Herzegovina	2020-05-21	2020-05-22	2350	140	1596	614	draft
673	Bosnia and Herzegovina	2020-05-22	2020-05-23	2372	141	1614	617	draft
674	Bosnia and Herzegovina	2020-05-23	2020-05-24	2391	141	1662	588	draft
675	Bosnia and Herzegovina	2020-05-24	2020-05-25	2401	144	1680	577	draft
676	Bosnia and Herzegovina	2020-05-25	2020-05-26	2406	146	1696	564	draft
677	Bosnia and Herzegovina	2020-05-26	2020-05-27	2416	149	1721	546	draft
678	Bosnia and Herzegovina	2020-05-27	2020-05-28	2435	151	1744	540	draft
679	Bosnia and Herzegovina	2020-05-28	2020-05-29	2462	153	1781	528	draft
680	Bosnia and Herzegovina	2020-05-29	2020-05-30	2485	153	1803	529	draft
681	Bosnia and Herzegovina	2020-05-30	2020-05-31	2494	153	1831	510	draft
682	Bosnia and Herzegovina	2020-05-31	2020-06-01	2510	153	1862	495	draft
683	Botswana	2020-05-01	2020-05-02	23	1	8	14	draft
684	Botswana	2020-05-02	2020-05-03	23	1	8	14	draft
685	Botswana	2020-05-03	2020-05-04	23	1	8	14	draft
686	Botswana	2020-05-04	2020-05-05	23	1	8	14	draft
687	Botswana	2020-05-05	2020-05-06	23	1	8	14	draft
688	Botswana	2020-05-06	2020-05-07	23	1	8	14	draft
689	Botswana	2020-05-07	2020-05-08	23	1	9	13	draft
690	Botswana	2020-05-08	2020-05-09	23	1	9	13	draft
691	Botswana	2020-05-09	2020-05-10	23	1	12	10	draft
692	Botswana	2020-05-10	2020-05-11	23	1	12	10	draft
693	Botswana	2020-05-11	2020-05-12	24	1	12	11	draft
694	Botswana	2020-05-12	2020-05-13	24	1	17	6	draft
695	Botswana	2020-05-13	2020-05-14	24	1	17	6	draft
696	Botswana	2020-05-14	2020-05-15	24	1	17	6	draft
697	Botswana	2020-05-15	2020-05-16	24	1	17	6	draft
698	Botswana	2020-05-16	2020-05-17	24	1	17	6	draft
699	Botswana	2020-05-17	2020-05-18	25	1	17	7	draft
700	Botswana	2020-05-18	2020-05-19	25	1	17	7	draft
701	Botswana	2020-05-19	2020-05-20	25	1	17	7	draft
702	Botswana	2020-05-20	2020-05-21	25	1	17	7	draft
703	Botswana	2020-05-21	2020-05-22	29	1	19	9	draft
704	Botswana	2020-05-22	2020-05-23	30	1	19	10	draft
705	Botswana	2020-05-23	2020-05-24	30	1	19	10	draft
706	Botswana	2020-05-24	2020-05-25	35	1	19	15	draft
707	Botswana	2020-05-25	2020-05-26	35	1	19	15	draft
708	Botswana	2020-05-26	2020-05-27	35	1	20	14	draft
709	Botswana	2020-05-27	2020-05-28	35	1	20	14	draft
710	Botswana	2020-05-28	2020-05-29	35	1	20	14	draft
711	Botswana	2020-05-29	2020-05-30	35	1	20	14	draft
712	Botswana	2020-05-30	2020-05-31	35	1	20	14	draft
713	Botswana	2020-05-31	2020-06-01	35	1	20	14	draft
714	Brazil	2020-05-01	2020-05-02	92202	6412	38039	47751	draft
715	Brazil	2020-05-02	2020-05-03	97100	6761	40937	49402	draft
716	Brazil	2020-05-03	2020-05-04	101826	7051	42991	51784	draft
717	Brazil	2020-05-04	2020-05-05	108620	7367	45815	55438	draft
718	Brazil	2020-05-05	2020-05-06	115455	7938	48221	59296	draft
719	Brazil	2020-05-06	2020-05-07	126611	8588	51370	66653	draft
720	Brazil	2020-05-07	2020-05-08	135773	9190	55350	71233	draft
721	Brazil	2020-05-08	2020-05-09	146894	10017	59297	77580	draft
722	Brazil	2020-05-09	2020-05-10	156061	10656	61685	83720	draft
723	Brazil	2020-05-10	2020-05-11	162699	11123	64957	86619	draft
724	Brazil	2020-05-11	2020-05-12	169594	11653	67384	90557	draft
725	Brazil	2020-05-12	2020-05-13	178214	12461	72597	93156	draft
726	Brazil	2020-05-13	2020-05-14	190137	13240	78424	98473	draft
727	Brazil	2020-05-14	2020-05-15	203165	13999	79479	109687	draft
728	Brazil	2020-05-15	2020-05-16	220291	14962	84970	120359	draft
729	Brazil	2020-05-16	2020-05-17	233511	15662	89672	128177	draft
730	Brazil	2020-05-17	2020-05-18	241080	16118	94122	130840	draft
731	Brazil	2020-05-18	2020-05-19	255368	16853	100459	138056	draft
732	Brazil	2020-05-19	2020-05-20	271885	17983	106794	147108	draft
733	Brazil	2020-05-20	2020-05-21	291579	18859	116683	156037	draft
734	Brazil	2020-05-21	2020-05-22	310087	20047	125960	164080	draft
735	Brazil	2020-05-22	2020-05-23	330890	21048	135430	174412	draft
736	Brazil	2020-05-23	2020-05-24	347398	22013	142587	182798	draft
737	Brazil	2020-05-24	2020-05-25	363211	22666	149911	190634	draft
738	Brazil	2020-05-25	2020-05-26	374898	23473	153833	197592	draft
739	Brazil	2020-05-26	2020-05-27	391222	24512	158593	208117	draft
740	Brazil	2020-05-27	2020-05-28	411821	25598	166647	219576	draft
741	Brazil	2020-05-28	2020-05-29	438238	26754	177604	233880	draft
742	Brazil	2020-05-29	2020-05-30	465166	27878	189476	247812	draft
743	Brazil	2020-05-30	2020-05-31	498440	28834	200892	268714	draft
744	Brazil	2020-05-31	2020-06-01	514849	29314	206555	278980	draft
745	Brunei	2020-05-01	2020-05-02	138	1	124	13	draft
746	Brunei	2020-05-02	2020-05-03	138	1	126	11	draft
747	Brunei	2020-05-03	2020-05-04	138	1	128	9	draft
748	Brunei	2020-05-04	2020-05-05	138	1	130	7	draft
749	Brunei	2020-05-05	2020-05-06	138	1	131	6	draft
750	Brunei	2020-05-06	2020-05-07	139	1	131	7	draft
751	Brunei	2020-05-07	2020-05-08	141	1	131	9	draft
752	Brunei	2020-05-08	2020-05-09	141	1	132	8	draft
753	Brunei	2020-05-09	2020-05-10	141	1	132	8	draft
754	Brunei	2020-05-10	2020-05-11	141	1	134	6	draft
755	Brunei	2020-05-11	2020-05-12	141	1	134	6	draft
756	Brunei	2020-05-12	2020-05-13	141	1	134	6	draft
757	Brunei	2020-05-13	2020-05-14	141	1	134	6	draft
758	Brunei	2020-05-14	2020-05-15	141	1	134	6	draft
759	Brunei	2020-05-15	2020-05-16	141	1	135	5	draft
760	Brunei	2020-05-16	2020-05-17	141	1	136	4	draft
761	Brunei	2020-05-17	2020-05-18	141	1	136	4	draft
762	Brunei	2020-05-18	2020-05-19	141	1	136	4	draft
763	Brunei	2020-05-19	2020-05-20	141	1	136	4	draft
764	Brunei	2020-05-20	2020-05-21	141	1	136	4	draft
765	Brunei	2020-05-21	2020-05-22	141	1	136	4	draft
766	Brunei	2020-05-22	2020-05-23	141	1	136	4	draft
767	Brunei	2020-05-23	2020-05-24	141	1	136	4	draft
768	Brunei	2020-05-24	2020-05-25	141	1	137	3	draft
769	Brunei	2020-05-25	2020-05-26	141	1	137	3	draft
770	Brunei	2020-05-26	2020-05-27	141	1	137	3	draft
771	Brunei	2020-05-27	2020-05-28	141	2	137	2	draft
772	Brunei	2020-05-28	2020-05-29	141	2	138	1	draft
773	Brunei	2020-05-29	2020-05-30	141	2	138	1	draft
774	Brunei	2020-05-30	2020-05-31	141	2	138	1	draft
775	Brunei	2020-05-31	2020-06-01	141	2	138	1	draft
776	Bulgaria	2020-05-01	2020-05-02	1555	68	276	1211	draft
777	Bulgaria	2020-05-02	2020-05-03	1594	72	287	1235	draft
778	Bulgaria	2020-05-03	2020-05-04	1618	73	308	1237	draft
779	Bulgaria	2020-05-04	2020-05-05	1652	78	321	1253	draft
780	Bulgaria	2020-05-05	2020-05-06	1704	80	342	1282	draft
781	Bulgaria	2020-05-06	2020-05-07	1778	84	360	1334	draft
782	Bulgaria	2020-05-07	2020-05-08	1829	84	384	1361	draft
783	Bulgaria	2020-05-08	2020-05-09	1872	86	401	1385	draft
784	Bulgaria	2020-05-09	2020-05-10	1921	90	422	1409	draft
785	Bulgaria	2020-05-10	2020-05-11	1965	91	444	1430	draft
786	Bulgaria	2020-05-11	2020-05-12	1990	93	461	1436	draft
787	Bulgaria	2020-05-12	2020-05-13	2023	95	476	1452	draft
788	Bulgaria	2020-05-13	2020-05-14	2069	96	499	1474	draft
789	Bulgaria	2020-05-14	2020-05-15	2100	99	531	1470	draft
790	Bulgaria	2020-05-15	2020-05-16	2138	102	545	1491	draft
791	Bulgaria	2020-05-16	2020-05-17	2175	105	573	1497	draft
792	Bulgaria	2020-05-17	2020-05-18	2211	108	598	1505	draft
793	Bulgaria	2020-05-18	2020-05-19	2235	110	612	1513	draft
794	Bulgaria	2020-05-19	2020-05-20	2259	112	646	1501	draft
795	Bulgaria	2020-05-20	2020-05-21	2292	116	684	1492	draft
796	Bulgaria	2020-05-21	2020-05-22	2331	120	727	1484	draft
797	Bulgaria	2020-05-22	2020-05-23	2372	125	769	1478	draft
798	Bulgaria	2020-05-23	2020-05-24	2408	126	808	1474	draft
799	Bulgaria	2020-05-24	2020-05-25	2427	130	840	1457	draft
800	Bulgaria	2020-05-25	2020-05-26	2433	130	862	1441	draft
801	Bulgaria	2020-05-26	2020-05-27	2443	130	880	1433	draft
802	Bulgaria	2020-05-27	2020-05-28	2460	133	912	1415	draft
803	Bulgaria	2020-05-28	2020-05-29	2477	134	965	1378	draft
804	Bulgaria	2020-05-29	2020-05-30	2485	136	1016	1333	draft
805	Bulgaria	2020-05-30	2020-05-31	2499	139	1064	1296	draft
806	Bulgaria	2020-05-31	2020-06-01	2513	140	1074	1299	draft
807	Burkina Faso	2020-05-01	2020-05-02	649	44	517	88	draft
808	Burkina Faso	2020-05-02	2020-05-03	652	44	535	73	draft
809	Burkina Faso	2020-05-03	2020-05-04	662	45	540	77	draft
810	Burkina Faso	2020-05-04	2020-05-05	672	46	545	81	draft
811	Burkina Faso	2020-05-05	2020-05-06	688	48	548	92	draft
812	Burkina Faso	2020-05-06	2020-05-07	729	48	555	126	draft
813	Burkina Faso	2020-05-07	2020-05-08	736	48	562	126	draft
814	Burkina Faso	2020-05-08	2020-05-09	744	48	566	130	draft
815	Burkina Faso	2020-05-09	2020-05-10	748	48	569	131	draft
816	Burkina Faso	2020-05-10	2020-05-11	751	49	577	125	draft
817	Burkina Faso	2020-05-11	2020-05-12	760	50	584	126	draft
818	Burkina Faso	2020-05-12	2020-05-13	766	51	588	127	draft
819	Burkina Faso	2020-05-13	2020-05-14	773	51	592	130	draft
820	Burkina Faso	2020-05-14	2020-05-15	773	51	592	130	draft
821	Burkina Faso	2020-05-15	2020-05-16	780	51	595	134	draft
822	Burkina Faso	2020-05-16	2020-05-17	782	51	604	127	draft
823	Burkina Faso	2020-05-17	2020-05-18	796	51	644	101	draft
824	Burkina Faso	2020-05-18	2020-05-19	796	51	652	93	draft
825	Burkina Faso	2020-05-19	2020-05-20	796	51	652	93	draft
826	Burkina Faso	2020-05-20	2020-05-21	809	52	661	96	draft
827	Burkina Faso	2020-05-21	2020-05-22	812	52	669	91	draft
828	Burkina Faso	2020-05-22	2020-05-23	814	52	672	90	draft
829	Burkina Faso	2020-05-23	2020-05-24	814	52	672	90	draft
830	Burkina Faso	2020-05-24	2020-05-25	814	52	672	90	draft
831	Burkina Faso	2020-05-25	2020-05-26	832	52	672	108	draft
832	Burkina Faso	2020-05-26	2020-05-27	832	52	672	108	draft
833	Burkina Faso	2020-05-27	2020-05-28	845	53	672	120	draft
834	Burkina Faso	2020-05-28	2020-05-29	847	53	719	75	draft
835	Burkina Faso	2020-05-29	2020-05-30	847	53	720	74	draft
836	Burkina Faso	2020-05-30	2020-05-31	847	53	720	74	draft
837	Burkina Faso	2020-05-31	2020-06-01	847	53	720	74	draft
838	Burma	2020-05-01	2020-05-02	151	6	31	114	draft
839	Burma	2020-05-02	2020-05-03	151	6	37	108	draft
840	Burma	2020-05-03	2020-05-04	155	6	43	106	draft
841	Burma	2020-05-04	2020-05-05	161	6	49	106	draft
842	Burma	2020-05-05	2020-05-06	161	6	49	106	draft
843	Burma	2020-05-06	2020-05-07	161	6	50	105	draft
844	Burma	2020-05-07	2020-05-08	176	6	62	108	draft
845	Burma	2020-05-08	2020-05-09	177	6	67	104	draft
846	Burma	2020-05-09	2020-05-10	178	6	68	104	draft
847	Burma	2020-05-10	2020-05-11	180	6	72	102	draft
848	Burma	2020-05-11	2020-05-12	180	6	74	100	draft
849	Burma	2020-05-12	2020-05-13	180	6	76	98	draft
850	Burma	2020-05-13	2020-05-14	181	6	79	96	draft
851	Burma	2020-05-14	2020-05-15	181	6	84	91	draft
852	Burma	2020-05-15	2020-05-16	182	6	89	87	draft
853	Burma	2020-05-16	2020-05-17	182	6	96	80	draft
854	Burma	2020-05-17	2020-05-18	184	6	97	81	draft
855	Burma	2020-05-18	2020-05-19	191	6	101	84	draft
856	Burma	2020-05-19	2020-05-20	193	6	104	83	draft
857	Burma	2020-05-20	2020-05-21	199	6	108	85	draft
858	Burma	2020-05-21	2020-05-22	199	6	108	85	draft
859	Burma	2020-05-22	2020-05-23	199	6	116	77	draft
860	Burma	2020-05-23	2020-05-24	201	6	120	75	draft
861	Burma	2020-05-24	2020-05-25	201	6	122	73	draft
862	Burma	2020-05-25	2020-05-26	203	6	123	74	draft
863	Burma	2020-05-26	2020-05-27	206	6	124	76	draft
864	Burma	2020-05-27	2020-05-28	206	6	126	74	draft
865	Burma	2020-05-28	2020-05-29	206	6	126	74	draft
866	Burma	2020-05-29	2020-05-30	207	6	130	71	draft
867	Burma	2020-05-30	2020-05-31	224	6	130	88	draft
868	Burma	2020-05-31	2020-06-01	224	6	138	80	draft
869	Burundi	2020-05-01	2020-05-02	11	1	4	6	draft
870	Burundi	2020-05-02	2020-05-03	15	1	7	7	draft
871	Burundi	2020-05-03	2020-05-04	15	1	7	7	draft
872	Burundi	2020-05-04	2020-05-05	15	1	7	7	draft
873	Burundi	2020-05-05	2020-05-06	15	1	7	7	draft
874	Burundi	2020-05-06	2020-05-07	15	1	7	7	draft
875	Burundi	2020-05-07	2020-05-08	15	1	7	7	draft
876	Burundi	2020-05-08	2020-05-09	15	1	7	7	draft
877	Burundi	2020-05-09	2020-05-10	15	1	7	7	draft
878	Burundi	2020-05-10	2020-05-11	15	1	7	7	draft
879	Burundi	2020-05-11	2020-05-12	15	1	7	7	draft
880	Burundi	2020-05-12	2020-05-13	15	1	7	7	draft
881	Burundi	2020-05-13	2020-05-14	15	1	7	7	draft
882	Burundi	2020-05-14	2020-05-15	15	1	7	7	draft
883	Burundi	2020-05-15	2020-05-16	15	1	7	7	draft
884	Burundi	2020-05-16	2020-05-17	15	1	7	7	draft
885	Burundi	2020-05-17	2020-05-18	23	1	15	7	draft
886	Burundi	2020-05-18	2020-05-19	42	1	20	21	draft
887	Burundi	2020-05-19	2020-05-20	42	1	20	21	draft
888	Burundi	2020-05-20	2020-05-21	42	1	20	21	draft
889	Burundi	2020-05-21	2020-05-22	42	1	20	21	draft
890	Burundi	2020-05-22	2020-05-23	42	1	20	21	draft
891	Burundi	2020-05-23	2020-05-24	42	1	20	21	draft
892	Burundi	2020-05-24	2020-05-25	42	1	20	21	draft
893	Burundi	2020-05-25	2020-05-26	42	1	20	21	draft
894	Burundi	2020-05-26	2020-05-27	42	1	20	21	draft
895	Burundi	2020-05-27	2020-05-28	42	1	20	21	draft
896	Burundi	2020-05-28	2020-05-29	42	1	20	21	draft
897	Burundi	2020-05-29	2020-05-30	42	1	20	21	draft
898	Burundi	2020-05-30	2020-05-31	63	1	33	29	draft
899	Burundi	2020-05-31	2020-06-01	63	1	33	29	draft
900	Cabo Verde	2020-05-01	2020-05-02	122	1	18	103	draft
901	Cabo Verde	2020-05-02	2020-05-03	152	2	18	132	draft
902	Cabo Verde	2020-05-03	2020-05-04	165	2	33	130	draft
903	Cabo Verde	2020-05-04	2020-05-05	175	2	37	136	draft
904	Cabo Verde	2020-05-05	2020-05-06	186	2	37	147	draft
905	Cabo Verde	2020-05-06	2020-05-07	191	2	38	151	draft
906	Cabo Verde	2020-05-07	2020-05-08	218	2	38	178	draft
907	Cabo Verde	2020-05-08	2020-05-09	230	2	44	184	draft
908	Cabo Verde	2020-05-09	2020-05-10	236	2	56	178	draft
909	Cabo Verde	2020-05-10	2020-05-11	246	2	56	188	draft
910	Cabo Verde	2020-05-11	2020-05-12	260	2	58	200	draft
911	Cabo Verde	2020-05-12	2020-05-13	267	2	58	207	draft
912	Cabo Verde	2020-05-13	2020-05-14	289	2	61	226	draft
913	Cabo Verde	2020-05-14	2020-05-15	315	2	67	246	draft
914	Cabo Verde	2020-05-15	2020-05-16	326	2	67	257	draft
915	Cabo Verde	2020-05-16	2020-05-17	328	3	84	241	draft
916	Cabo Verde	2020-05-17	2020-05-18	328	3	84	241	draft
917	Cabo Verde	2020-05-18	2020-05-19	328	3	85	240	draft
918	Cabo Verde	2020-05-19	2020-05-20	335	3	85	247	draft
919	Cabo Verde	2020-05-20	2020-05-21	349	3	85	261	draft
920	Cabo Verde	2020-05-21	2020-05-22	356	3	95	258	draft
921	Cabo Verde	2020-05-22	2020-05-23	362	3	95	264	draft
922	Cabo Verde	2020-05-23	2020-05-24	371	3	142	226	draft
923	Cabo Verde	2020-05-24	2020-05-25	380	3	155	222	draft
924	Cabo Verde	2020-05-25	2020-05-26	390	3	155	232	draft
925	Cabo Verde	2020-05-26	2020-05-27	390	4	155	231	draft
926	Cabo Verde	2020-05-27	2020-05-28	390	4	155	231	draft
927	Cabo Verde	2020-05-28	2020-05-29	390	4	155	231	draft
928	Cabo Verde	2020-05-29	2020-05-30	405	4	155	246	draft
929	Cabo Verde	2020-05-30	2020-05-31	421	4	167	250	draft
930	Cabo Verde	2020-05-31	2020-06-01	435	4	193	238	draft
931	Cambodia	2020-05-01	2020-05-02	122	0	120	2	draft
932	Cambodia	2020-05-02	2020-05-03	122	0	120	2	draft
933	Cambodia	2020-05-03	2020-05-04	122	0	120	2	draft
934	Cambodia	2020-05-04	2020-05-05	122	0	120	2	draft
935	Cambodia	2020-05-05	2020-05-06	122	0	120	2	draft
936	Cambodia	2020-05-06	2020-05-07	122	0	120	2	draft
937	Cambodia	2020-05-07	2020-05-08	122	0	120	2	draft
938	Cambodia	2020-05-08	2020-05-09	122	0	120	2	draft
939	Cambodia	2020-05-09	2020-05-10	122	0	120	2	draft
940	Cambodia	2020-05-10	2020-05-11	122	0	120	2	draft
941	Cambodia	2020-05-11	2020-05-12	122	0	121	1	draft
942	Cambodia	2020-05-12	2020-05-13	122	0	121	1	draft
943	Cambodia	2020-05-13	2020-05-14	122	0	121	1	draft
944	Cambodia	2020-05-14	2020-05-15	122	0	121	1	draft
945	Cambodia	2020-05-15	2020-05-16	122	0	122	0	draft
946	Cambodia	2020-05-16	2020-05-17	122	0	122	0	draft
947	Cambodia	2020-05-17	2020-05-18	122	0	122	0	draft
948	Cambodia	2020-05-18	2020-05-19	122	0	122	0	draft
949	Cambodia	2020-05-19	2020-05-20	122	0	122	0	draft
950	Cambodia	2020-05-20	2020-05-21	122	0	122	0	draft
951	Cambodia	2020-05-21	2020-05-22	123	0	122	1	draft
952	Cambodia	2020-05-22	2020-05-23	123	0	122	1	draft
953	Cambodia	2020-05-23	2020-05-24	124	0	122	2	draft
954	Cambodia	2020-05-24	2020-05-25	124	0	122	2	draft
955	Cambodia	2020-05-25	2020-05-26	124	0	122	2	draft
956	Cambodia	2020-05-26	2020-05-27	124	0	122	2	draft
957	Cambodia	2020-05-27	2020-05-28	124	0	122	2	draft
958	Cambodia	2020-05-28	2020-05-29	124	0	122	2	draft
959	Cambodia	2020-05-29	2020-05-30	124	0	122	2	draft
960	Cambodia	2020-05-30	2020-05-31	125	0	123	2	draft
961	Cambodia	2020-05-31	2020-06-01	125	0	123	2	draft
962	Cameroon	2020-05-01	2020-05-02	1832	61	934	837	draft
963	Cameroon	2020-05-02	2020-05-03	2077	64	953	1060	draft
964	Cameroon	2020-05-03	2020-05-04	2077	64	953	1060	draft
965	Cameroon	2020-05-04	2020-05-05	2104	64	953	1087	draft
966	Cameroon	2020-05-05	2020-05-06	2104	64	953	1087	draft
967	Cameroon	2020-05-06	2020-05-07	2265	108	1000	1157	draft
968	Cameroon	2020-05-07	2020-05-08	2267	108	1002	1157	draft
969	Cameroon	2020-05-08	2020-05-09	2267	108	1002	1157	draft
970	Cameroon	2020-05-09	2020-05-10	2274	108	1232	934	draft
971	Cameroon	2020-05-10	2020-05-11	2579	114	1465	1000	draft
972	Cameroon	2020-05-11	2020-05-12	2689	125	1524	1040	draft
973	Cameroon	2020-05-12	2020-05-13	2689	125	1524	1040	draft
974	Cameroon	2020-05-13	2020-05-14	2800	136	1543	1121	draft
975	Cameroon	2020-05-14	2020-05-15	2954	139	1553	1262	draft
976	Cameroon	2020-05-15	2020-05-16	3105	140	1567	1398	draft
977	Cameroon	2020-05-16	2020-05-17	3105	140	1567	1398	draft
978	Cameroon	2020-05-17	2020-05-18	3105	140	1567	1398	draft
979	Cameroon	2020-05-18	2020-05-19	3529	140	1567	1822	draft
980	Cameroon	2020-05-19	2020-05-20	3529	140	1567	1822	draft
981	Cameroon	2020-05-20	2020-05-21	3733	146	1595	1992	draft
982	Cameroon	2020-05-21	2020-05-22	4288	156	1808	2324	draft
983	Cameroon	2020-05-22	2020-05-23	4400	159	1822	2419	draft
984	Cameroon	2020-05-23	2020-05-24	4400	159	1822	2419	draft
985	Cameroon	2020-05-24	2020-05-25	4890	165	1865	2860	draft
986	Cameroon	2020-05-25	2020-05-26	4890	165	1865	2860	draft
987	Cameroon	2020-05-26	2020-05-27	5436	175	1996	3265	draft
988	Cameroon	2020-05-27	2020-05-28	5436	175	1996	3265	draft
989	Cameroon	2020-05-28	2020-05-29	5436	175	1996	3265	draft
990	Cameroon	2020-05-29	2020-05-30	5436	177	3326	1933	draft
991	Cameroon	2020-05-30	2020-05-31	5904	191	3568	2145	draft
992	Cameroon	2020-05-31	2020-06-01	5904	191	3568	2145	draft
993	Canada	2020-05-01	2020-05-02	56343	4381	22764	30042	draft
994	Canada	2020-05-02	2020-05-03	57926	4529	23814	30428	draft
995	Canada	2020-05-03	2020-05-04	60504	4669	24921	31788	draft
996	Canada	2020-05-04	2020-05-05	61957	4911	26030	31924	draft
997	Canada	2020-05-05	2020-05-06	63215	5081	27006	32019	draft
998	Canada	2020-05-06	2020-05-07	64694	5240	28184	32144	draft
999	Canada	2020-05-07	2020-05-08	66201	5387	29260	32400	draft
1000	Canada	2020-05-08	2020-05-09	67674	5540	30239	32738	draft
1001	Canada	2020-05-09	2020-05-10	68918	5704	31262	32833	draft
1002	Canada	2020-05-10	2020-05-11	70091	5822	32109	32991	draft
1003	Canada	2020-05-11	2020-05-12	71264	5956	33007	33142	draft
1004	Canada	2020-05-12	2020-05-13	72419	6107	34055	33064	draft
1005	Canada	2020-05-13	2020-05-14	73568	6210	35177	32966	draft
1006	Canada	2020-05-14	2020-05-15	74781	6331	36104	33085	draft
1007	Canada	2020-05-15	2020-05-16	75959	6452	36908	33372	draft
1008	Canada	2020-05-16	2020-05-17	77206	6571	37832	33574	draft
1009	Canada	2020-05-17	2020-05-18	78332	6661	38563	33866	draft
1010	Canada	2020-05-18	2020-05-19	79411	6753	39251	34200	draft
1011	Canada	2020-05-19	2020-05-20	80493	6828	40069	34396	draft
1012	Canada	2020-05-20	2020-05-21	81575	6950	40793	34632	draft
1013	Canada	2020-05-21	2020-05-22	82742	7046	41731	34744	draft
1014	Canada	2020-05-22	2020-05-23	83947	7144	42608	34979	draft
1015	Canada	2020-05-23	2020-05-24	85151	7238	43318	35367	draft
1016	Canada	2020-05-24	2020-05-25	86106	7326	43998	35574	draft
1017	Canada	2020-05-25	2020-05-26	87119	7420	44651	35813	draft
1018	Canada	2020-05-26	2020-05-27	88090	7512	45352	35985	draft
1019	Canada	2020-05-27	2020-05-28	88989	7606	46248	35865	draft
1020	Canada	2020-05-28	2020-05-29	89976	7717	46961	36033	draft
1021	Canada	2020-05-29	2020-05-30	90909	7797	47905	35941	draft
1022	Canada	2020-05-30	2020-05-31	91681	7857	48517	36005	draft
1023	Canada	2020-05-31	2020-06-01	92479	7906	49213	35892	draft
1024	Central African Republic	2020-05-01	2020-05-02	72	0	10	62	draft
1025	Central African Republic	2020-05-02	2020-05-03	72	0	10	62	draft
1026	Central African Republic	2020-05-03	2020-05-04	72	0	10	62	draft
1027	Central African Republic	2020-05-04	2020-05-05	85	0	10	75	draft
1028	Central African Republic	2020-05-05	2020-05-06	85	0	10	75	draft
1029	Central African Republic	2020-05-06	2020-05-07	94	0	10	84	draft
1030	Central African Republic	2020-05-07	2020-05-08	94	0	10	84	draft
1031	Central African Republic	2020-05-08	2020-05-09	143	0	10	133	draft
1032	Central African Republic	2020-05-09	2020-05-10	143	0	10	133	draft
1033	Central African Republic	2020-05-10	2020-05-11	143	0	10	133	draft
1034	Central African Republic	2020-05-11	2020-05-12	143	0	10	133	draft
1035	Central African Republic	2020-05-12	2020-05-13	143	0	10	133	draft
1036	Central African Republic	2020-05-13	2020-05-14	143	0	10	133	draft
1037	Central African Republic	2020-05-14	2020-05-15	143	0	10	133	draft
1038	Central African Republic	2020-05-15	2020-05-16	301	0	13	288	draft
1039	Central African Republic	2020-05-16	2020-05-17	327	0	13	314	draft
1040	Central African Republic	2020-05-17	2020-05-18	327	0	13	314	draft
1041	Central African Republic	2020-05-18	2020-05-19	327	0	13	314	draft
1042	Central African Republic	2020-05-19	2020-05-20	366	0	18	348	draft
1043	Central African Republic	2020-05-20	2020-05-21	418	0	18	400	draft
1044	Central African Republic	2020-05-21	2020-05-22	436	0	18	418	draft
1045	Central African Republic	2020-05-22	2020-05-23	479	0	18	461	draft
1046	Central African Republic	2020-05-23	2020-05-24	552	1	18	533	draft
1047	Central African Republic	2020-05-24	2020-05-25	604	1	22	581	draft
1048	Central African Republic	2020-05-25	2020-05-26	652	1	22	629	draft
1049	Central African Republic	2020-05-26	2020-05-27	671	1	22	648	draft
1050	Central African Republic	2020-05-27	2020-05-28	702	1	23	678	draft
1051	Central African Republic	2020-05-28	2020-05-29	755	1	23	731	draft
1052	Central African Republic	2020-05-29	2020-05-30	874	1	23	850	draft
1053	Central African Republic	2020-05-30	2020-05-31	962	1	23	938	draft
1054	Central African Republic	2020-05-31	2020-06-01	1011	2	23	986	draft
1055	Chad	2020-05-01	2020-05-02	73	5	33	35	draft
1056	Chad	2020-05-02	2020-05-03	117	10	39	68	draft
1057	Chad	2020-05-03	2020-05-04	117	10	39	68	draft
1058	Chad	2020-05-04	2020-05-05	117	10	39	68	draft
1059	Chad	2020-05-05	2020-05-06	170	17	43	110	draft
1060	Chad	2020-05-06	2020-05-07	170	17	43	110	draft
1061	Chad	2020-05-07	2020-05-08	253	27	50	176	draft
1062	Chad	2020-05-08	2020-05-09	260	28	50	182	draft
1063	Chad	2020-05-09	2020-05-10	322	31	53	238	draft
1064	Chad	2020-05-10	2020-05-11	322	31	53	238	draft
1065	Chad	2020-05-11	2020-05-12	322	31	53	238	draft
1066	Chad	2020-05-12	2020-05-13	357	40	76	241	draft
1067	Chad	2020-05-13	2020-05-14	372	42	78	252	draft
1068	Chad	2020-05-14	2020-05-15	399	46	83	270	draft
1069	Chad	2020-05-15	2020-05-16	428	48	88	292	draft
1070	Chad	2020-05-16	2020-05-17	474	50	111	313	draft
1071	Chad	2020-05-17	2020-05-18	503	53	117	333	draft
1072	Chad	2020-05-18	2020-05-19	519	53	117	349	draft
1073	Chad	2020-05-19	2020-05-20	545	56	139	350	draft
1074	Chad	2020-05-20	2020-05-21	565	57	177	331	draft
1075	Chad	2020-05-21	2020-05-22	588	58	186	344	draft
1076	Chad	2020-05-22	2020-05-23	611	58	196	357	draft
1077	Chad	2020-05-23	2020-05-24	648	60	204	384	draft
1078	Chad	2020-05-24	2020-05-25	675	60	215	400	draft
1079	Chad	2020-05-25	2020-05-26	687	61	244	382	draft
1080	Chad	2020-05-26	2020-05-27	700	62	303	335	draft
1081	Chad	2020-05-27	2020-05-28	715	64	359	292	draft
1082	Chad	2020-05-28	2020-05-29	726	65	413	248	draft
1083	Chad	2020-05-29	2020-05-30	759	65	444	250	draft
1084	Chad	2020-05-30	2020-05-31	759	65	470	224	draft
1085	Chad	2020-05-31	2020-06-01	778	65	491	222	draft
1086	Chile	2020-05-01	2020-05-02	17008	234	9018	7756	draft
1087	Chile	2020-05-02	2020-05-03	18435	247	9572	8616	draft
1088	Chile	2020-05-03	2020-05-04	19663	260	10041	9362	draft
1089	Chile	2020-05-04	2020-05-05	20643	270	10415	9958	draft
1090	Chile	2020-05-05	2020-05-06	22016	275	10710	11031	draft
1091	Chile	2020-05-06	2020-05-07	23048	281	11189	11578	draft
1092	Chile	2020-05-07	2020-05-08	24581	285	11664	12632	draft
1093	Chile	2020-05-08	2020-05-09	25972	294	12160	13518	draft
1094	Chile	2020-05-09	2020-05-10	27219	304	12667	14248	draft
1095	Chile	2020-05-10	2020-05-11	28866	312	13112	15442	draft
1096	Chile	2020-05-11	2020-05-12	30063	323	13605	16135	draft
1097	Chile	2020-05-12	2020-05-13	31721	335	14125	17261	draft
1098	Chile	2020-05-13	2020-05-14	34381	346	14865	19170	draft
1099	Chile	2020-05-14	2020-05-15	37040	368	15655	21017	draft
1100	Chile	2020-05-15	2020-05-16	39542	394	16614	22534	draft
1101	Chile	2020-05-16	2020-05-17	41428	421	18014	22993	draft
1102	Chile	2020-05-17	2020-05-18	43781	450	19213	24118	draft
1103	Chile	2020-05-18	2020-05-19	46059	478	20165	25416	draft
1104	Chile	2020-05-19	2020-05-20	49579	509	21507	27563	draft
1105	Chile	2020-05-20	2020-05-21	53617	544	22504	30569	draft
1106	Chile	2020-05-21	2020-05-22	57581	589	23992	33000	draft
1107	Chile	2020-05-22	2020-05-23	61857	630	25342	35885	draft
1108	Chile	2020-05-23	2020-05-24	65393	673	26546	38174	draft
1109	Chile	2020-05-24	2020-05-25	69102	718	28148	40236	draft
1110	Chile	2020-05-25	2020-05-26	73997	761	29302	43934	draft
1111	Chile	2020-05-26	2020-05-27	77961	806	30915	46240	draft
1112	Chile	2020-05-27	2020-05-28	82289	841	33540	47908	draft
1113	Chile	2020-05-28	2020-05-29	86943	890	36115	49938	draft
1114	Chile	2020-05-29	2020-05-30	90638	944	38598	51096	draft
1115	Chile	2020-05-30	2020-05-31	94858	997	40431	53430	draft
1116	Chile	2020-05-31	2020-06-01	99688	1054	42727	55907	draft
1117	China	2020-05-01	2020-05-02	83959	4637	78573	749	draft
1118	China	2020-05-02	2020-05-03	83959	4637	78586	736	draft
1119	China	2020-05-03	2020-05-04	83964	4637	78684	643	draft
1120	China	2020-05-04	2020-05-05	83966	4637	78792	537	draft
1121	China	2020-05-05	2020-05-06	83968	4637	78870	461	draft
1122	China	2020-05-06	2020-05-07	83970	4637	78929	404	draft
1123	China	2020-05-07	2020-05-08	83975	4637	78977	361	draft
1124	China	2020-05-08	2020-05-09	83976	4637	78993	346	draft
1125	China	2020-05-09	2020-05-10	83990	4637	79127	226	draft
1126	China	2020-05-10	2020-05-11	84010	4637	79167	206	draft
1127	China	2020-05-11	2020-05-12	84011	4637	79198	176	draft
1128	China	2020-05-12	2020-05-13	84018	4637	79222	159	draft
1129	China	2020-05-13	2020-05-14	84024	4637	79246	141	draft
1130	China	2020-05-14	2020-05-15	84029	4637	79261	131	draft
1131	China	2020-05-15	2020-05-16	84038	4637	79281	120	draft
1132	China	2020-05-16	2020-05-17	84044	4638	79293	113	draft
1133	China	2020-05-17	2020-05-18	84054	4638	79306	110	draft
1134	China	2020-05-18	2020-05-19	84063	4638	79310	115	draft
1135	China	2020-05-19	2020-05-20	84063	4638	79310	115	draft
1136	China	2020-05-20	2020-05-21	84063	4638	79310	115	draft
1137	China	2020-05-21	2020-05-22	84063	4638	79310	115	draft
1138	China	2020-05-22	2020-05-23	84081	4638	79332	111	draft
1139	China	2020-05-23	2020-05-24	84084	4638	79335	111	draft
1140	China	2020-05-24	2020-05-25	84095	4638	79343	114	draft
1141	China	2020-05-25	2020-05-26	84102	4638	79352	112	draft
1142	China	2020-05-26	2020-05-27	84103	4638	79358	107	draft
1143	China	2020-05-27	2020-05-28	84106	4638	79367	101	draft
1144	China	2020-05-28	2020-05-29	84106	4638	79371	97	draft
1145	China	2020-05-29	2020-05-30	84123	4638	79382	103	draft
1146	China	2020-05-30	2020-05-31	84128	4638	79386	104	draft
1147	China	2020-05-31	2020-06-01	84146	4638	79389	119	draft
1148	Colombia	2020-05-01	2020-05-02	7006	314	1551	5141	draft
1149	Colombia	2020-05-02	2020-05-03	7285	324	1666	5295	draft
1150	Colombia	2020-05-03	2020-05-04	7668	340	1722	5606	draft
1151	Colombia	2020-05-04	2020-05-05	7973	358	1807	5808	draft
1152	Colombia	2020-05-05	2020-05-06	8613	378	2013	6222	draft
1153	Colombia	2020-05-06	2020-05-07	8959	397	2148	6414	draft
1154	Colombia	2020-05-07	2020-05-08	9456	407	2300	6749	draft
1155	Colombia	2020-05-08	2020-05-09	10051	428	2424	7199	draft
1156	Colombia	2020-05-09	2020-05-10	10495	445	2569	7481	draft
1157	Colombia	2020-05-10	2020-05-11	11063	463	2705	7895	draft
1158	Colombia	2020-05-11	2020-05-12	11613	479	2825	8309	draft
1159	Colombia	2020-05-12	2020-05-13	12272	493	2971	8808	draft
1160	Colombia	2020-05-13	2020-05-14	12930	509	3133	9288	draft
1161	Colombia	2020-05-14	2020-05-15	13610	525	3358	9727	draft
1162	Colombia	2020-05-15	2020-05-16	14216	546	3460	10210	draft
1163	Colombia	2020-05-16	2020-05-17	14939	562	3587	10790	draft
1164	Colombia	2020-05-17	2020-05-18	15574	574	3751	11249	draft
1165	Colombia	2020-05-18	2020-05-19	16295	592	3903	11800	draft
1166	Colombia	2020-05-19	2020-05-20	16935	613	4050	12272	draft
1167	Colombia	2020-05-20	2020-05-21	17687	630	4256	12801	draft
1168	Colombia	2020-05-21	2020-05-22	18330	652	4431	13247	draft
1169	Colombia	2020-05-22	2020-05-23	19131	682	4575	13874	draft
1170	Colombia	2020-05-23	2020-05-24	20177	705	4718	14754	draft
1171	Colombia	2020-05-24	2020-05-25	21175	727	5016	15432	draft
1172	Colombia	2020-05-25	2020-05-26	21981	750	5265	15966	draft
1173	Colombia	2020-05-26	2020-05-27	23003	776	5511	16716	draft
1174	Colombia	2020-05-27	2020-05-28	24104	803	6111	17190	draft
1175	Colombia	2020-05-28	2020-05-29	24141	833	6132	17176	draft
1176	Colombia	2020-05-29	2020-05-30	25406	855	6687	17864	draft
1177	Colombia	2020-05-30	2020-05-31	26734	891	6935	18908	draft
1178	Colombia	2020-05-31	2020-06-01	27219	916	7032	19271	draft
1179	Comoros	2020-05-01	2020-05-02	1	0	0	1	draft
1180	Comoros	2020-05-02	2020-05-03	3	0	0	3	draft
1181	Comoros	2020-05-03	2020-05-04	3	0	0	3	draft
1182	Comoros	2020-05-04	2020-05-05	3	0	0	3	draft
1183	Comoros	2020-05-05	2020-05-06	3	0	0	3	draft
1184	Comoros	2020-05-06	2020-05-07	8	1	0	7	draft
1185	Comoros	2020-05-07	2020-05-08	8	1	0	7	draft
1186	Comoros	2020-05-08	2020-05-09	8	1	0	7	draft
1187	Comoros	2020-05-09	2020-05-10	11	1	0	10	draft
1188	Comoros	2020-05-10	2020-05-11	11	1	0	10	draft
1189	Comoros	2020-05-11	2020-05-12	11	1	0	10	draft
1190	Comoros	2020-05-12	2020-05-13	11	1	0	10	draft
1191	Comoros	2020-05-13	2020-05-14	11	1	0	10	draft
1192	Comoros	2020-05-14	2020-05-15	11	1	3	7	draft
1193	Comoros	2020-05-15	2020-05-16	11	1	3	7	draft
1194	Comoros	2020-05-16	2020-05-17	11	1	3	7	draft
1195	Comoros	2020-05-17	2020-05-18	11	1	3	7	draft
1196	Comoros	2020-05-18	2020-05-19	11	1	3	7	draft
1197	Comoros	2020-05-19	2020-05-20	11	1	3	7	draft
1198	Comoros	2020-05-20	2020-05-21	34	1	8	25	draft
1199	Comoros	2020-05-21	2020-05-22	34	1	8	25	draft
1200	Comoros	2020-05-22	2020-05-23	78	1	18	59	draft
1201	Comoros	2020-05-23	2020-05-24	78	1	18	59	draft
1202	Comoros	2020-05-24	2020-05-25	87	1	21	65	draft
1203	Comoros	2020-05-25	2020-05-26	87	1	21	65	draft
1204	Comoros	2020-05-26	2020-05-27	87	1	21	65	draft
1205	Comoros	2020-05-27	2020-05-28	87	2	24	61	draft
1206	Comoros	2020-05-28	2020-05-29	87	2	24	61	draft
1207	Comoros	2020-05-29	2020-05-30	87	2	24	61	draft
1208	Comoros	2020-05-30	2020-05-31	106	2	26	78	draft
1209	Comoros	2020-05-31	2020-06-01	106	2	26	78	draft
1210	Congo (Brazzaville)	2020-05-01	2020-05-02	229	9	25	195	draft
1211	Congo (Brazzaville)	2020-05-02	2020-05-03	229	9	25	195	draft
1212	Congo (Brazzaville)	2020-05-03	2020-05-04	229	9	25	195	draft
1213	Congo (Brazzaville)	2020-05-04	2020-05-05	236	10	26	200	draft
1214	Congo (Brazzaville)	2020-05-05	2020-05-06	236	10	26	200	draft
1215	Congo (Brazzaville)	2020-05-06	2020-05-07	264	10	30	224	draft
1216	Congo (Brazzaville)	2020-05-07	2020-05-08	264	10	30	224	draft
1217	Congo (Brazzaville)	2020-05-08	2020-05-09	274	10	33	231	draft
1218	Congo (Brazzaville)	2020-05-09	2020-05-10	274	10	33	231	draft
1219	Congo (Brazzaville)	2020-05-10	2020-05-11	274	10	33	231	draft
1220	Congo (Brazzaville)	2020-05-11	2020-05-12	333	11	53	269	draft
1221	Congo (Brazzaville)	2020-05-12	2020-05-13	333	11	53	269	draft
1222	Congo (Brazzaville)	2020-05-13	2020-05-14	333	11	53	269	draft
1223	Congo (Brazzaville)	2020-05-14	2020-05-15	391	15	87	289	draft
1224	Congo (Brazzaville)	2020-05-15	2020-05-16	391	15	87	289	draft
1225	Congo (Brazzaville)	2020-05-16	2020-05-17	391	15	87	289	draft
1226	Congo (Brazzaville)	2020-05-17	2020-05-18	391	15	87	289	draft
1227	Congo (Brazzaville)	2020-05-18	2020-05-19	412	15	110	287	draft
1228	Congo (Brazzaville)	2020-05-19	2020-05-20	420	15	132	273	draft
1229	Congo (Brazzaville)	2020-05-20	2020-05-21	420	15	132	273	draft
1230	Congo (Brazzaville)	2020-05-21	2020-05-22	469	16	137	316	draft
1231	Congo (Brazzaville)	2020-05-22	2020-05-23	469	16	137	316	draft
1232	Congo (Brazzaville)	2020-05-23	2020-05-24	487	16	147	324	draft
1233	Congo (Brazzaville)	2020-05-24	2020-05-25	487	16	147	324	draft
1234	Congo (Brazzaville)	2020-05-25	2020-05-26	487	16	147	324	draft
1235	Congo (Brazzaville)	2020-05-26	2020-05-27	487	16	147	324	draft
1236	Congo (Brazzaville)	2020-05-27	2020-05-28	571	19	161	391	draft
1237	Congo (Brazzaville)	2020-05-28	2020-05-29	571	19	161	391	draft
1238	Congo (Brazzaville)	2020-05-29	2020-05-30	571	19	161	391	draft
1239	Congo (Brazzaville)	2020-05-30	2020-05-31	571	19	161	391	draft
1240	Congo (Brazzaville)	2020-05-31	2020-06-01	611	20	179	412	draft
1241	Congo (Kinshasa)	2020-05-01	2020-05-02	604	32	75	497	draft
1242	Congo (Kinshasa)	2020-05-02	2020-05-03	674	33	75	566	draft
1243	Congo (Kinshasa)	2020-05-03	2020-05-04	674	33	75	566	draft
1244	Congo (Kinshasa)	2020-05-04	2020-05-05	682	34	80	568	draft
1245	Congo (Kinshasa)	2020-05-05	2020-05-06	705	34	90	581	draft
1246	Congo (Kinshasa)	2020-05-06	2020-05-07	797	35	92	670	draft
1247	Congo (Kinshasa)	2020-05-07	2020-05-08	863	36	103	724	draft
1248	Congo (Kinshasa)	2020-05-08	2020-05-09	937	39	130	768	draft
1249	Congo (Kinshasa)	2020-05-09	2020-05-10	937	39	130	768	draft
1250	Congo (Kinshasa)	2020-05-10	2020-05-11	991	41	136	814	draft
1251	Congo (Kinshasa)	2020-05-11	2020-05-12	1024	41	141	842	draft
1252	Congo (Kinshasa)	2020-05-12	2020-05-13	1102	44	146	912	draft
1253	Congo (Kinshasa)	2020-05-13	2020-05-14	1169	50	148	971	draft
1254	Congo (Kinshasa)	2020-05-14	2020-05-15	1242	50	157	1035	draft
1255	Congo (Kinshasa)	2020-05-15	2020-05-16	1298	50	212	1036	draft
1256	Congo (Kinshasa)	2020-05-16	2020-05-17	1455	61	270	1124	draft
1257	Congo (Kinshasa)	2020-05-17	2020-05-18	1455	61	270	1124	draft
1258	Congo (Kinshasa)	2020-05-18	2020-05-19	1538	61	272	1205	draft
1259	Congo (Kinshasa)	2020-05-19	2020-05-20	1629	61	290	1278	draft
1260	Congo (Kinshasa)	2020-05-20	2020-05-21	1731	61	302	1368	draft
1261	Congo (Kinshasa)	2020-05-21	2020-05-22	1835	61	303	1471	draft
1262	Congo (Kinshasa)	2020-05-22	2020-05-23	1945	63	312	1570	draft
1263	Congo (Kinshasa)	2020-05-23	2020-05-24	2025	63	312	1650	draft
1264	Congo (Kinshasa)	2020-05-24	2020-05-25	2141	63	317	1761	draft
1265	Congo (Kinshasa)	2020-05-25	2020-05-26	2297	67	337	1893	draft
1266	Congo (Kinshasa)	2020-05-26	2020-05-27	2403	68	340	1995	draft
1267	Congo (Kinshasa)	2020-05-27	2020-05-28	2546	68	365	2113	draft
1268	Congo (Kinshasa)	2020-05-28	2020-05-29	2660	69	381	2210	draft
1269	Congo (Kinshasa)	2020-05-29	2020-05-30	2833	69	400	2364	draft
1270	Congo (Kinshasa)	2020-05-30	2020-05-31	2966	69	428	2469	draft
1271	Congo (Kinshasa)	2020-05-31	2020-06-01	3070	72	448	2550	draft
1272	Costa Rica	2020-05-01	2020-05-02	725	6	355	364	draft
1273	Costa Rica	2020-05-02	2020-05-03	733	6	372	355	draft
1274	Costa Rica	2020-05-03	2020-05-04	739	6	386	347	draft
1275	Costa Rica	2020-05-04	2020-05-05	742	6	399	337	draft
1276	Costa Rica	2020-05-05	2020-05-06	755	6	413	336	draft
1277	Costa Rica	2020-05-06	2020-05-07	761	6	428	327	draft
1278	Costa Rica	2020-05-07	2020-05-08	765	6	445	314	draft
1279	Costa Rica	2020-05-08	2020-05-09	773	6	461	306	draft
1280	Costa Rica	2020-05-09	2020-05-10	780	6	480	294	draft
1281	Costa Rica	2020-05-10	2020-05-11	792	7	501	284	draft
1282	Costa Rica	2020-05-11	2020-05-12	801	7	517	277	draft
1283	Costa Rica	2020-05-12	2020-05-13	804	7	520	277	draft
1284	Costa Rica	2020-05-13	2020-05-14	815	8	527	280	draft
1285	Costa Rica	2020-05-14	2020-05-15	830	8	535	287	draft
1286	Costa Rica	2020-05-15	2020-05-16	843	9	542	292	draft
1287	Costa Rica	2020-05-16	2020-05-17	853	10	551	292	draft
1288	Costa Rica	2020-05-17	2020-05-18	863	10	565	288	draft
1289	Costa Rica	2020-05-18	2020-05-19	866	10	575	281	draft
1290	Costa Rica	2020-05-19	2020-05-20	882	10	577	295	draft
1291	Costa Rica	2020-05-20	2020-05-21	897	10	582	305	draft
1292	Costa Rica	2020-05-21	2020-05-22	903	10	592	301	draft
1293	Costa Rica	2020-05-22	2020-05-23	911	10	600	301	draft
1294	Costa Rica	2020-05-23	2020-05-24	918	10	607	301	draft
1295	Costa Rica	2020-05-24	2020-05-25	930	10	620	300	draft
1296	Costa Rica	2020-05-25	2020-05-26	951	10	628	313	draft
1297	Costa Rica	2020-05-26	2020-05-27	956	10	634	312	draft
1298	Costa Rica	2020-05-27	2020-05-28	984	10	639	335	draft
1299	Costa Rica	2020-05-28	2020-05-29	1000	10	646	344	draft
1300	Costa Rica	2020-05-29	2020-05-30	1022	10	653	359	draft
1301	Costa Rica	2020-05-30	2020-05-31	1047	10	658	379	draft
1302	Costa Rica	2020-05-31	2020-06-01	1056	10	669	377	draft
1303	Cote d'Ivoire	2020-05-01	2020-05-02	1333	15	597	721	draft
1304	Cote d'Ivoire	2020-05-02	2020-05-03	1362	15	622	725	draft
1305	Cote d'Ivoire	2020-05-03	2020-05-04	1398	17	653	728	draft
1306	Cote d'Ivoire	2020-05-04	2020-05-05	1432	17	693	722	draft
1307	Cote d'Ivoire	2020-05-05	2020-05-06	1464	18	701	745	draft
1308	Cote d'Ivoire	2020-05-06	2020-05-07	1516	18	721	777	draft
1309	Cote d'Ivoire	2020-05-07	2020-05-08	1571	20	742	809	draft
1310	Cote d'Ivoire	2020-05-08	2020-05-09	1602	20	754	828	draft
1311	Cote d'Ivoire	2020-05-09	2020-05-10	1667	21	769	877	draft
1312	Cote d'Ivoire	2020-05-10	2020-05-11	1700	21	794	885	draft
1313	Cote d'Ivoire	2020-05-11	2020-05-12	1730	21	818	891	draft
1314	Cote d'Ivoire	2020-05-12	2020-05-13	1857	21	820	1016	draft
1315	Cote d'Ivoire	2020-05-13	2020-05-14	1912	24	902	986	draft
1316	Cote d'Ivoire	2020-05-14	2020-05-15	1971	24	930	1017	draft
1317	Cote d'Ivoire	2020-05-15	2020-05-16	2017	24	942	1051	draft
1318	Cote d'Ivoire	2020-05-16	2020-05-17	2061	25	987	1049	draft
1319	Cote d'Ivoire	2020-05-17	2020-05-18	2109	27	1004	1078	draft
1320	Cote d'Ivoire	2020-05-18	2020-05-19	2119	28	1040	1051	draft
1321	Cote d'Ivoire	2020-05-19	2020-05-20	2153	28	1050	1075	draft
1322	Cote d'Ivoire	2020-05-20	2020-05-21	2231	29	1083	1119	draft
1323	Cote d'Ivoire	2020-05-21	2020-05-22	2301	29	1100	1172	draft
1324	Cote d'Ivoire	2020-05-22	2020-05-23	2341	29	1146	1166	draft
1325	Cote d'Ivoire	2020-05-23	2020-05-24	2366	30	1188	1148	draft
1326	Cote d'Ivoire	2020-05-24	2020-05-25	2376	30	1219	1127	draft
1327	Cote d'Ivoire	2020-05-25	2020-05-26	2423	30	1257	1136	draft
1328	Cote d'Ivoire	2020-05-26	2020-05-27	2477	30	1286	1161	draft
1329	Cote d'Ivoire	2020-05-27	2020-05-28	2556	31	1302	1223	draft
1330	Cote d'Ivoire	2020-05-28	2020-05-29	2641	32	1326	1283	draft
1331	Cote d'Ivoire	2020-05-29	2020-05-30	2750	32	1370	1348	draft
1332	Cote d'Ivoire	2020-05-30	2020-05-31	2799	33	1385	1381	draft
1333	Cote d'Ivoire	2020-05-31	2020-06-01	2833	33	1435	1365	draft
1334	Croatia	2020-05-01	2020-05-02	2085	75	1421	589	draft
1335	Croatia	2020-05-02	2020-05-03	2088	77	1463	548	draft
1336	Croatia	2020-05-03	2020-05-04	2096	79	1489	528	draft
1337	Croatia	2020-05-04	2020-05-05	2101	80	1522	499	draft
1338	Croatia	2020-05-05	2020-05-06	2112	83	1560	469	draft
1339	Croatia	2020-05-06	2020-05-07	2119	85	1601	433	draft
1340	Croatia	2020-05-07	2020-05-08	2125	86	1641	398	draft
1341	Croatia	2020-05-08	2020-05-09	2161	86	1689	386	draft
1342	Croatia	2020-05-09	2020-05-10	2176	87	1726	363	draft
1343	Croatia	2020-05-10	2020-05-11	2187	90	1764	333	draft
1344	Croatia	2020-05-11	2020-05-12	2196	91	1784	321	draft
1345	Croatia	2020-05-12	2020-05-13	2207	91	1808	308	draft
1346	Croatia	2020-05-13	2020-05-14	2213	94	1834	285	draft
1347	Croatia	2020-05-14	2020-05-15	2221	94	1850	277	draft
1348	Croatia	2020-05-15	2020-05-16	2222	95	1869	258	draft
1349	Croatia	2020-05-16	2020-05-17	2224	95	1913	216	draft
1350	Croatia	2020-05-17	2020-05-18	2226	95	1936	195	draft
1351	Croatia	2020-05-18	2020-05-19	2228	95	1946	187	draft
1352	Croatia	2020-05-19	2020-05-20	2232	96	1967	169	draft
1353	Croatia	2020-05-20	2020-05-21	2234	96	1978	160	draft
1354	Croatia	2020-05-21	2020-05-22	2237	97	1978	162	draft
1355	Croatia	2020-05-22	2020-05-23	2243	99	2011	133	draft
1356	Croatia	2020-05-23	2020-05-24	2243	99	2023	121	draft
1357	Croatia	2020-05-24	2020-05-25	2244	99	2027	118	draft
1358	Croatia	2020-05-25	2020-05-26	2244	100	2035	109	draft
1359	Croatia	2020-05-26	2020-05-27	2244	101	2046	97	draft
1360	Croatia	2020-05-27	2020-05-28	2244	101	2047	96	draft
1361	Croatia	2020-05-28	2020-05-29	2245	102	2051	92	draft
1362	Croatia	2020-05-29	2020-05-30	2245	103	2059	83	draft
1363	Croatia	2020-05-30	2020-05-31	2246	103	2063	80	draft
1364	Croatia	2020-05-31	2020-06-01	2246	103	2072	71	draft
1365	Cuba	2020-05-01	2020-05-02	1537	64	714	759	draft
1366	Cuba	2020-05-02	2020-05-03	1611	66	765	780	draft
1367	Cuba	2020-05-03	2020-05-04	1649	67	827	755	draft
1368	Cuba	2020-05-04	2020-05-05	1668	69	876	723	draft
1369	Cuba	2020-05-05	2020-05-06	1685	69	954	662	draft
1370	Cuba	2020-05-06	2020-05-07	1703	69	1001	633	draft
1371	Cuba	2020-05-07	2020-05-08	1729	73	1031	625	draft
1372	Cuba	2020-05-08	2020-05-09	1741	74	1078	589	draft
1373	Cuba	2020-05-09	2020-05-10	1754	74	1140	540	draft
1374	Cuba	2020-05-10	2020-05-11	1766	77	1193	496	draft
1375	Cuba	2020-05-11	2020-05-12	1783	77	1229	477	draft
1376	Cuba	2020-05-12	2020-05-13	1804	78	1277	449	draft
1377	Cuba	2020-05-13	2020-05-14	1810	79	1326	405	draft
1378	Cuba	2020-05-14	2020-05-15	1830	79	1383	368	draft
1379	Cuba	2020-05-15	2020-05-16	1840	79	1425	336	draft
1380	Cuba	2020-05-16	2020-05-17	1862	79	1460	323	draft
1381	Cuba	2020-05-17	2020-05-18	1872	79	1495	298	draft
1382	Cuba	2020-05-18	2020-05-19	1881	79	1505	297	draft
1383	Cuba	2020-05-19	2020-05-20	1887	79	1538	270	draft
1384	Cuba	2020-05-20	2020-05-21	1900	79	1573	248	draft
1385	Cuba	2020-05-21	2020-05-22	1908	80	1603	225	draft
1386	Cuba	2020-05-22	2020-05-23	1916	81	1631	204	draft
1387	Cuba	2020-05-23	2020-05-24	1931	81	1671	179	draft
1388	Cuba	2020-05-24	2020-05-25	1941	82	1689	170	draft
1389	Cuba	2020-05-25	2020-05-26	1947	82	1704	161	draft
1390	Cuba	2020-05-26	2020-05-27	1963	82	1709	172	draft
1391	Cuba	2020-05-27	2020-05-28	1974	82	1724	168	draft
1392	Cuba	2020-05-28	2020-05-29	1983	82	1734	167	draft
1393	Cuba	2020-05-29	2020-05-30	2005	82	1760	163	draft
1394	Cuba	2020-05-30	2020-05-31	2025	83	1795	147	draft
1395	Cuba	2020-05-31	2020-06-01	2045	83	1809	153	draft
1396	Cyprus	2020-05-01	2020-05-02	857	15	296	546	draft
1397	Cyprus	2020-05-02	2020-05-03	864	15	296	553	draft
1398	Cyprus	2020-05-03	2020-05-04	872	15	296	561	draft
1399	Cyprus	2020-05-04	2020-05-05	874	15	296	563	draft
1400	Cyprus	2020-05-05	2020-05-06	878	15	296	567	draft
1401	Cyprus	2020-05-06	2020-05-07	883	15	296	572	draft
1402	Cyprus	2020-05-07	2020-05-08	889	15	400	474	draft
1403	Cyprus	2020-05-08	2020-05-09	891	15	400	476	draft
1404	Cyprus	2020-05-09	2020-05-10	892	15	401	476	draft
1405	Cyprus	2020-05-10	2020-05-11	898	16	401	481	draft
1406	Cyprus	2020-05-11	2020-05-12	901	16	401	484	draft
1407	Cyprus	2020-05-12	2020-05-13	903	16	449	438	draft
1408	Cyprus	2020-05-13	2020-05-14	905	17	449	439	draft
1409	Cyprus	2020-05-14	2020-05-15	907	17	481	409	draft
1410	Cyprus	2020-05-15	2020-05-16	910	17	481	412	draft
1411	Cyprus	2020-05-16	2020-05-17	914	17	515	382	draft
1412	Cyprus	2020-05-17	2020-05-18	916	17	515	384	draft
1413	Cyprus	2020-05-18	2020-05-19	917	17	515	385	draft
1414	Cyprus	2020-05-19	2020-05-20	918	17	515	386	draft
1415	Cyprus	2020-05-20	2020-05-21	922	17	516	389	draft
1416	Cyprus	2020-05-21	2020-05-22	923	17	561	345	draft
1417	Cyprus	2020-05-22	2020-05-23	927	17	561	349	draft
1418	Cyprus	2020-05-23	2020-05-24	927	17	594	316	draft
1419	Cyprus	2020-05-24	2020-05-25	935	17	594	324	draft
1420	Cyprus	2020-05-25	2020-05-26	937	17	594	326	draft
1421	Cyprus	2020-05-26	2020-05-27	939	17	594	328	draft
1422	Cyprus	2020-05-27	2020-05-28	939	17	594	328	draft
1423	Cyprus	2020-05-28	2020-05-29	941	17	784	140	draft
1424	Cyprus	2020-05-29	2020-05-30	942	17	784	141	draft
1425	Cyprus	2020-05-30	2020-05-31	944	17	790	137	draft
1426	Cyprus	2020-05-31	2020-06-01	944	17	790	137	draft
1427	Czechia	2020-05-01	2020-05-02	7737	240	3372	4125	draft
1428	Czechia	2020-05-02	2020-05-03	7755	245	3461	4049	draft
1429	Czechia	2020-05-03	2020-05-04	7781	248	3587	3946	draft
1430	Czechia	2020-05-04	2020-05-05	7819	252	3807	3760	draft
1431	Czechia	2020-05-05	2020-05-06	7896	257	4006	3633	draft
1432	Czechia	2020-05-06	2020-05-07	7974	262	4205	3507	draft
1433	Czechia	2020-05-07	2020-05-08	8031	270	4371	3390	draft
1434	Czechia	2020-05-08	2020-05-09	8077	273	4413	3391	draft
1435	Czechia	2020-05-09	2020-05-10	8095	276	4447	3372	draft
1436	Czechia	2020-05-10	2020-05-11	8123	280	4474	3369	draft
1437	Czechia	2020-05-11	2020-05-12	8176	282	4711	3183	draft
1438	Czechia	2020-05-12	2020-05-13	8221	283	4889	3049	draft
1439	Czechia	2020-05-13	2020-05-14	8269	290	5047	2932	draft
1440	Czechia	2020-05-14	2020-05-15	8351	293	5241	2817	draft
1441	Czechia	2020-05-15	2020-05-16	8406	295	5381	2730	draft
1442	Czechia	2020-05-16	2020-05-17	8455	296	5422	2737	draft
1443	Czechia	2020-05-17	2020-05-18	8475	298	5462	2715	draft
1444	Czechia	2020-05-18	2020-05-19	8586	297	5641	2648	draft
1445	Czechia	2020-05-19	2020-05-20	8647	302	5726	2619	draft
1446	Czechia	2020-05-20	2020-05-21	8721	304	5830	2587	draft
1447	Czechia	2020-05-21	2020-05-22	8754	306	5926	2522	draft
1448	Czechia	2020-05-22	2020-05-23	8813	312	6025	2476	draft
1449	Czechia	2020-05-23	2020-05-24	8890	314	6044	2532	draft
1450	Czechia	2020-05-24	2020-05-25	8955	315	6078	2562	draft
1451	Czechia	2020-05-25	2020-05-26	9002	317	6182	2503	draft
1452	Czechia	2020-05-26	2020-05-27	9050	317	6270	2463	draft
1453	Czechia	2020-05-27	2020-05-28	9086	317	6370	2399	draft
1454	Czechia	2020-05-28	2020-05-29	9140	319	6460	2361	draft
1455	Czechia	2020-05-29	2020-05-30	9196	319	6500	2377	draft
1456	Czechia	2020-05-30	2020-05-31	9230	319	6546	2365	draft
1457	Czechia	2020-05-31	2020-06-01	9268	320	6558	2390	draft
1458	Denmark	2020-05-01	2020-05-02	9509	460	6924	2125	draft
1459	Denmark	2020-05-02	2020-05-03	9605	475	7084	2046	draft
1460	Denmark	2020-05-03	2020-05-04	9721	484	7183	2054	draft
1461	Denmark	2020-05-04	2020-05-05	9868	493	7284	2091	draft
1462	Denmark	2020-05-05	2020-05-06	10019	503	7492	2024	draft
1463	Denmark	2020-05-06	2020-05-07	10136	506	7689	1941	draft
1464	Denmark	2020-05-07	2020-05-08	10281	514	7907	1860	draft
1465	Denmark	2020-05-08	2020-05-09	10416	522	8125	1769	draft
1466	Denmark	2020-05-09	2020-05-10	10517	526	8291	1700	draft
1467	Denmark	2020-05-10	2020-05-11	10627	529	8415	1683	draft
1468	Denmark	2020-05-11	2020-05-12	10711	533	8526	1652	draft
1469	Denmark	2020-05-12	2020-05-13	10789	527	8778	1484	draft
1470	Denmark	2020-05-13	2020-05-14	10865	533	8861	1471	draft
1471	Denmark	2020-05-14	2020-05-15	10911	537	9003	1371	draft
1472	Denmark	2020-05-15	2020-05-16	10989	537	9157	1295	draft
1473	Denmark	2020-05-16	2020-05-17	11056	543	9305	1208	draft
1474	Denmark	2020-05-17	2020-05-18	11125	547	9425	1153	draft
1475	Denmark	2020-05-18	2020-05-19	11166	548	9499	1119	draft
1476	Denmark	2020-05-19	2020-05-20	11242	551	9614	1077	draft
1477	Denmark	2020-05-20	2020-05-21	11315	554	9734	1027	draft
1478	Denmark	2020-05-21	2020-05-22	11380	561	9841	978	draft
1479	Denmark	2020-05-22	2020-05-23	11428	561	9962	905	draft
1480	Denmark	2020-05-23	2020-05-24	11487	561	10034	892	draft
1481	Denmark	2020-05-24	2020-05-25	11559	562	10098	899	draft
1482	Denmark	2020-05-25	2020-05-26	11586	563	10162	861	draft
1483	Denmark	2020-05-26	2020-05-27	11627	563	10242	822	draft
1484	Denmark	2020-05-27	2020-05-28	11680	565	10304	811	draft
1485	Denmark	2020-05-28	2020-05-29	11712	568	10378	766	draft
1486	Denmark	2020-05-29	2020-05-30	11793	568	10438	787	draft
1487	Denmark	2020-05-30	2020-05-31	11833	571	10525	737	draft
1488	Denmark	2020-05-31	2020-06-01	11869	574	10560	735	draft
1489	Diamond Princess	2020-05-01	2020-05-02	712	13	645	54	draft
1490	Diamond Princess	2020-05-02	2020-05-03	712	13	645	54	draft
1491	Diamond Princess	2020-05-03	2020-05-04	712	13	645	54	draft
1492	Diamond Princess	2020-05-04	2020-05-05	712	13	645	54	draft
1493	Diamond Princess	2020-05-05	2020-05-06	712	13	645	54	draft
1494	Diamond Princess	2020-05-06	2020-05-07	712	13	645	54	draft
1495	Diamond Princess	2020-05-07	2020-05-08	712	13	645	54	draft
1496	Diamond Princess	2020-05-08	2020-05-09	712	13	645	54	draft
1497	Diamond Princess	2020-05-09	2020-05-10	712	13	645	54	draft
1498	Diamond Princess	2020-05-10	2020-05-11	712	13	651	48	draft
1499	Diamond Princess	2020-05-11	2020-05-12	712	13	651	48	draft
1500	Diamond Princess	2020-05-12	2020-05-13	712	13	651	48	draft
1501	Diamond Princess	2020-05-13	2020-05-14	712	13	651	48	draft
1502	Diamond Princess	2020-05-14	2020-05-15	712	13	651	48	draft
1503	Diamond Princess	2020-05-15	2020-05-16	712	13	651	48	draft
1504	Diamond Princess	2020-05-16	2020-05-17	712	13	651	48	draft
1505	Diamond Princess	2020-05-17	2020-05-18	712	13	651	48	draft
1506	Diamond Princess	2020-05-18	2020-05-19	712	13	651	48	draft
1507	Diamond Princess	2020-05-19	2020-05-20	712	13	651	48	draft
1508	Diamond Princess	2020-05-20	2020-05-21	712	13	651	48	draft
1509	Diamond Princess	2020-05-21	2020-05-22	712	13	651	48	draft
1510	Diamond Princess	2020-05-22	2020-05-23	712	13	651	48	draft
1511	Diamond Princess	2020-05-23	2020-05-24	712	13	651	48	draft
1512	Diamond Princess	2020-05-24	2020-05-25	712	13	651	48	draft
1513	Diamond Princess	2020-05-25	2020-05-26	712	13	651	48	draft
1514	Diamond Princess	2020-05-26	2020-05-27	712	13	651	48	draft
1515	Diamond Princess	2020-05-27	2020-05-28	712	13	651	48	draft
1516	Diamond Princess	2020-05-28	2020-05-29	712	13	651	48	draft
1517	Diamond Princess	2020-05-29	2020-05-30	712	13	651	48	draft
1518	Diamond Princess	2020-05-30	2020-05-31	712	13	651	48	draft
1519	Diamond Princess	2020-05-31	2020-06-01	712	13	651	48	draft
1520	Djibouti	2020-05-01	2020-05-02	1097	2	672	423	draft
1521	Djibouti	2020-05-02	2020-05-03	1112	2	686	424	draft
1522	Djibouti	2020-05-03	2020-05-04	1112	2	686	424	draft
1523	Djibouti	2020-05-04	2020-05-05	1116	2	713	401	draft
1524	Djibouti	2020-05-05	2020-05-06	1120	2	745	373	draft
1525	Djibouti	2020-05-06	2020-05-07	1124	3	755	366	draft
1526	Djibouti	2020-05-07	2020-05-08	1133	3	799	331	draft
1527	Djibouti	2020-05-08	2020-05-09	1135	3	824	308	draft
1528	Djibouti	2020-05-09	2020-05-10	1189	3	834	352	draft
1529	Djibouti	2020-05-10	2020-05-11	1210	3	847	360	draft
1530	Djibouti	2020-05-11	2020-05-12	1227	3	872	352	draft
1531	Djibouti	2020-05-12	2020-05-13	1256	3	886	367	draft
1532	Djibouti	2020-05-13	2020-05-14	1268	3	900	365	draft
1533	Djibouti	2020-05-14	2020-05-15	1284	3	905	376	draft
1534	Djibouti	2020-05-15	2020-05-16	1309	4	935	370	draft
1535	Djibouti	2020-05-16	2020-05-17	1331	4	950	377	draft
1536	Djibouti	2020-05-17	2020-05-18	1401	4	972	425	draft
1537	Djibouti	2020-05-18	2020-05-19	1518	7	1018	493	draft
1538	Djibouti	2020-05-19	2020-05-20	1618	7	1033	578	draft
1539	Djibouti	2020-05-20	2020-05-21	1828	9	1052	767	draft
1540	Djibouti	2020-05-21	2020-05-22	2047	10	1055	982	draft
1541	Djibouti	2020-05-22	2020-05-23	2270	10	1064	1196	draft
1542	Djibouti	2020-05-23	2020-05-24	2270	10	1064	1196	draft
1543	Djibouti	2020-05-24	2020-05-25	2270	10	1064	1196	draft
1544	Djibouti	2020-05-25	2020-05-26	2468	14	1079	1375	draft
1545	Djibouti	2020-05-26	2020-05-27	2468	14	1079	1375	draft
1546	Djibouti	2020-05-27	2020-05-28	2697	18	1185	1494	draft
1547	Djibouti	2020-05-28	2020-05-29	2914	20	1241	1653	draft
1548	Djibouti	2020-05-29	2020-05-30	2914	20	1241	1653	draft
1549	Djibouti	2020-05-30	2020-05-31	3194	22	1286	1886	draft
1550	Djibouti	2020-05-31	2020-06-01	3354	24	1504	1826	draft
1551	Dominica	2020-05-01	2020-05-02	16	0	13	3	draft
1552	Dominica	2020-05-02	2020-05-03	16	0	13	3	draft
1553	Dominica	2020-05-03	2020-05-04	16	0	13	3	draft
1554	Dominica	2020-05-04	2020-05-05	16	0	13	3	draft
1555	Dominica	2020-05-05	2020-05-06	16	0	14	2	draft
1556	Dominica	2020-05-06	2020-05-07	16	0	14	2	draft
1557	Dominica	2020-05-07	2020-05-08	16	0	14	2	draft
1558	Dominica	2020-05-08	2020-05-09	16	0	14	2	draft
1559	Dominica	2020-05-09	2020-05-10	16	0	14	2	draft
1560	Dominica	2020-05-10	2020-05-11	16	0	15	1	draft
1561	Dominica	2020-05-11	2020-05-12	16	0	15	1	draft
1562	Dominica	2020-05-12	2020-05-13	16	0	15	1	draft
1563	Dominica	2020-05-13	2020-05-14	16	0	15	1	draft
1564	Dominica	2020-05-14	2020-05-15	16	0	15	1	draft
1565	Dominica	2020-05-15	2020-05-16	16	0	15	1	draft
1566	Dominica	2020-05-16	2020-05-17	16	0	15	1	draft
1567	Dominica	2020-05-17	2020-05-18	16	0	16	0	draft
1568	Dominica	2020-05-18	2020-05-19	16	0	16	0	draft
1569	Dominica	2020-05-19	2020-05-20	16	0	16	0	draft
1570	Dominica	2020-05-20	2020-05-21	16	0	16	0	draft
1571	Dominica	2020-05-21	2020-05-22	16	0	16	0	draft
1572	Dominica	2020-05-22	2020-05-23	16	0	16	0	draft
1573	Dominica	2020-05-23	2020-05-24	16	0	16	0	draft
1574	Dominica	2020-05-24	2020-05-25	16	0	16	0	draft
1575	Dominica	2020-05-25	2020-05-26	16	0	16	0	draft
1576	Dominica	2020-05-26	2020-05-27	16	0	16	0	draft
1577	Dominica	2020-05-27	2020-05-28	16	0	16	0	draft
1578	Dominica	2020-05-28	2020-05-29	16	0	16	0	draft
1579	Dominica	2020-05-29	2020-05-30	16	0	16	0	draft
1580	Dominica	2020-05-30	2020-05-31	16	0	16	0	draft
1581	Dominica	2020-05-31	2020-06-01	16	0	16	0	draft
1582	Dominican Republic	2020-05-01	2020-05-02	7288	313	1387	5588	draft
1583	Dominican Republic	2020-05-02	2020-05-03	7578	326	1481	5771	draft
1584	Dominican Republic	2020-05-03	2020-05-04	7954	333	1606	6015	draft
1585	Dominican Republic	2020-05-04	2020-05-05	8235	346	1771	6118	draft
1586	Dominican Republic	2020-05-05	2020-05-06	8480	354	1905	6221	draft
1587	Dominican Republic	2020-05-06	2020-05-07	8807	362	1960	6485	draft
1588	Dominican Republic	2020-05-07	2020-05-08	9095	373	2064	6658	draft
1589	Dominican Republic	2020-05-08	2020-05-09	9376	380	2286	6710	draft
1590	Dominican Republic	2020-05-09	2020-05-10	9882	385	2584	6913	draft
1591	Dominican Republic	2020-05-10	2020-05-11	10347	388	2763	7196	draft
1592	Dominican Republic	2020-05-11	2020-05-12	10634	393	2870	7371	draft
1593	Dominican Republic	2020-05-12	2020-05-13	10900	402	3221	7277	draft
1594	Dominican Republic	2020-05-13	2020-05-14	11196	409	3221	7566	draft
1595	Dominican Republic	2020-05-14	2020-05-15	11320	422	3351	7547	draft
1596	Dominican Republic	2020-05-15	2020-05-16	11739	424	3557	7758	draft
1597	Dominican Republic	2020-05-16	2020-05-17	12110	428	3726	7956	draft
1598	Dominican Republic	2020-05-17	2020-05-18	12314	428	5847	6039	draft
1599	Dominican Republic	2020-05-18	2020-05-19	12725	434	6613	5678	draft
1600	Dominican Republic	2020-05-19	2020-05-20	13223	441	6613	6169	draft
1601	Dominican Republic	2020-05-20	2020-05-21	13477	446	7142	5889	draft
1602	Dominican Republic	2020-05-21	2020-05-22	13657	448	7366	5843	draft
1603	Dominican Republic	2020-05-22	2020-05-23	13989	456	7572	5961	draft
1604	Dominican Republic	2020-05-23	2020-05-24	14422	458	7854	6110	draft
1605	Dominican Republic	2020-05-24	2020-05-25	14801	458	8133	6210	draft
1606	Dominican Republic	2020-05-25	2020-05-26	15073	460	8285	6328	draft
1607	Dominican Republic	2020-05-26	2020-05-27	15264	468	8534	6262	draft
1608	Dominican Republic	2020-05-27	2020-05-28	15723	474	8790	6459	draft
1609	Dominican Republic	2020-05-28	2020-05-29	16068	485	8952	6631	draft
1610	Dominican Republic	2020-05-29	2020-05-30	16531	488	9266	6777	draft
1611	Dominican Republic	2020-05-30	2020-05-31	16908	498	9557	6853	draft
1612	Dominican Republic	2020-05-31	2020-06-01	17285	502	10559	6224	draft
1613	Ecuador	2020-05-01	2020-05-02	26336	1063	1913	23360	draft
1614	Ecuador	2020-05-02	2020-05-03	27464	1371	2132	23961	draft
1615	Ecuador	2020-05-03	2020-05-04	29538	1564	3300	24674	draft
1616	Ecuador	2020-05-04	2020-05-05	31881	1569	3433	26879	draft
1617	Ecuador	2020-05-05	2020-05-06	31881	1569	3433	26879	draft
1618	Ecuador	2020-05-06	2020-05-07	31881	1618	3433	26830	draft
1619	Ecuador	2020-05-07	2020-05-08	30298	1654	3433	25211	draft
1620	Ecuador	2020-05-08	2020-05-09	28818	1704	3433	23681	draft
1621	Ecuador	2020-05-09	2020-05-10	29071	1717	3433	23921	draft
1622	Ecuador	2020-05-10	2020-05-11	29559	2127	3433	23999	draft
1623	Ecuador	2020-05-11	2020-05-12	29509	2145	3433	23931	draft
1624	Ecuador	2020-05-12	2020-05-13	30419	2327	3433	24659	draft
1625	Ecuador	2020-05-13	2020-05-14	30486	2334	3433	24719	draft
1626	Ecuador	2020-05-14	2020-05-15	30502	2338	3433	24731	draft
1627	Ecuador	2020-05-15	2020-05-16	31467	2594	3433	25440	draft
1628	Ecuador	2020-05-16	2020-05-17	32763	2688	3433	26642	draft
1629	Ecuador	2020-05-17	2020-05-18	33182	2736	3433	27013	draft
1630	Ecuador	2020-05-18	2020-05-19	33582	2799	3433	27350	draft
1631	Ecuador	2020-05-19	2020-05-20	34151	2839	3457	27855	draft
1632	Ecuador	2020-05-20	2020-05-21	34854	2888	3557	28409	draft
1633	Ecuador	2020-05-21	2020-05-22	35306	2939	3557	28810	draft
1634	Ecuador	2020-05-22	2020-05-23	35828	3056	3557	29215	draft
1635	Ecuador	2020-05-23	2020-05-24	36258	3096	3557	29605	draft
1636	Ecuador	2020-05-24	2020-05-25	36756	3108	3560	30088	draft
1637	Ecuador	2020-05-25	2020-05-26	37355	3203	18003	16149	draft
1638	Ecuador	2020-05-26	2020-05-27	37355	3203	18003	16149	draft
1639	Ecuador	2020-05-27	2020-05-28	38103	3275	18425	16403	draft
1640	Ecuador	2020-05-28	2020-05-29	38471	3313	18425	16733	draft
1641	Ecuador	2020-05-29	2020-05-30	38571	3334	19190	16047	draft
1642	Ecuador	2020-05-30	2020-05-31	38571	3334	19190	16047	draft
1643	Ecuador	2020-05-31	2020-06-01	39098	3358	19592	16148	draft
1644	Egypt	2020-05-01	2020-05-02	5895	406	1460	4029	draft
1645	Egypt	2020-05-02	2020-05-03	6193	415	1522	4256	draft
1646	Egypt	2020-05-03	2020-05-04	6465	429	1562	4474	draft
1647	Egypt	2020-05-04	2020-05-05	6813	436	1632	4745	draft
1648	Egypt	2020-05-05	2020-05-06	7201	452	1730	5019	draft
1649	Egypt	2020-05-06	2020-05-07	7588	469	1815	5304	draft
1650	Egypt	2020-05-07	2020-05-08	7981	482	1887	5612	draft
1651	Egypt	2020-05-08	2020-05-09	8476	503	1945	6028	draft
1652	Egypt	2020-05-09	2020-05-10	8964	514	2002	6448	draft
1653	Egypt	2020-05-10	2020-05-11	9400	525	2075	6800	draft
1654	Egypt	2020-05-11	2020-05-12	9746	533	2172	7041	draft
1655	Egypt	2020-05-12	2020-05-13	10093	544	2326	7223	draft
1656	Egypt	2020-05-13	2020-05-14	10431	556	2486	7389	draft
1657	Egypt	2020-05-14	2020-05-15	10829	571	2626	7632	draft
1658	Egypt	2020-05-15	2020-05-16	11228	592	2799	7837	draft
1659	Egypt	2020-05-16	2020-05-17	11719	612	2950	8157	draft
1660	Egypt	2020-05-17	2020-05-18	12229	630	3172	8427	draft
1661	Egypt	2020-05-18	2020-05-19	12764	645	3440	8679	draft
1662	Egypt	2020-05-19	2020-05-20	13484	659	3742	9083	draft
1663	Egypt	2020-05-20	2020-05-21	14229	680	3994	9555	draft
1664	Egypt	2020-05-21	2020-05-22	15003	696	4217	10090	draft
1665	Egypt	2020-05-22	2020-05-23	15786	707	4374	10705	draft
1666	Egypt	2020-05-23	2020-05-24	16513	735	4628	11150	draft
1667	Egypt	2020-05-24	2020-05-25	17265	764	4807	11694	draft
1668	Egypt	2020-05-25	2020-05-26	17967	783	4900	12284	draft
1669	Egypt	2020-05-26	2020-05-27	18756	797	5027	12932	draft
1670	Egypt	2020-05-27	2020-05-28	19666	816	5205	13645	draft
1671	Egypt	2020-05-28	2020-05-29	20793	845	5359	14589	draft
1672	Egypt	2020-05-29	2020-05-30	22082	879	5511	15692	draft
1673	Egypt	2020-05-30	2020-05-31	23449	913	5693	16843	draft
1674	Egypt	2020-05-31	2020-06-01	24985	959	6037	17989	draft
1675	El Salvador	2020-05-01	2020-05-02	424	10	124	290	draft
1676	El Salvador	2020-05-02	2020-05-03	446	11	141	294	draft
1677	El Salvador	2020-05-03	2020-05-04	490	11	154	325	draft
1678	El Salvador	2020-05-04	2020-05-05	555	13	180	362	draft
1679	El Salvador	2020-05-05	2020-05-06	587	14	205	368	draft
1680	El Salvador	2020-05-06	2020-05-07	633	15	219	399	draft
1681	El Salvador	2020-05-07	2020-05-08	695	15	252	428	draft
1682	El Salvador	2020-05-08	2020-05-09	742	16	257	469	draft
1683	El Salvador	2020-05-09	2020-05-10	784	17	276	491	draft
1684	El Salvador	2020-05-10	2020-05-11	889	17	293	579	draft
1685	El Salvador	2020-05-11	2020-05-12	958	18	325	615	draft
1686	El Salvador	2020-05-12	2020-05-13	998	20	349	629	draft
1687	El Salvador	2020-05-13	2020-05-14	1037	20	374	643	draft
1688	El Salvador	2020-05-14	2020-05-15	1112	23	405	684	draft
1689	El Salvador	2020-05-15	2020-05-16	1210	25	417	768	draft
1690	El Salvador	2020-05-16	2020-05-17	1265	26	441	798	draft
1691	El Salvador	2020-05-17	2020-05-18	1338	30	464	844	draft
1692	El Salvador	2020-05-18	2020-05-19	1413	30	474	909	draft
1693	El Salvador	2020-05-19	2020-05-20	1498	30	502	966	draft
1694	El Salvador	2020-05-20	2020-05-21	1571	31	537	1003	draft
1695	El Salvador	2020-05-21	2020-05-22	1640	33	544	1063	draft
1696	El Salvador	2020-05-22	2020-05-23	1725	33	570	1122	draft
1697	El Salvador	2020-05-23	2020-05-24	1819	33	570	1216	draft
1698	El Salvador	2020-05-24	2020-05-25	1915	35	633	1247	draft
1699	El Salvador	2020-05-25	2020-05-26	1983	35	772	1176	draft
1700	El Salvador	2020-05-26	2020-05-27	2042	36	787	1219	draft
1701	El Salvador	2020-05-27	2020-05-28	2109	39	891	1179	draft
1702	El Salvador	2020-05-28	2020-05-29	2194	39	1002	1153	draft
1703	El Salvador	2020-05-29	2020-05-30	2278	42	1015	1221	draft
1704	El Salvador	2020-05-30	2020-05-31	2395	46	1031	1318	draft
1705	El Salvador	2020-05-31	2020-06-01	2517	46	1040	1431	draft
1706	Equatorial Guinea	2020-05-01	2020-05-02	315	1	9	305	draft
1707	Equatorial Guinea	2020-05-02	2020-05-03	315	1	9	305	draft
1708	Equatorial Guinea	2020-05-03	2020-05-04	315	1	9	305	draft
1709	Equatorial Guinea	2020-05-04	2020-05-05	315	3	13	299	draft
1710	Equatorial Guinea	2020-05-05	2020-05-06	315	3	13	299	draft
1711	Equatorial Guinea	2020-05-06	2020-05-07	439	4	13	422	draft
1712	Equatorial Guinea	2020-05-07	2020-05-08	439	4	13	422	draft
1713	Equatorial Guinea	2020-05-08	2020-05-09	439	4	13	422	draft
1714	Equatorial Guinea	2020-05-09	2020-05-10	439	4	13	422	draft
1715	Equatorial Guinea	2020-05-10	2020-05-11	439	4	13	422	draft
1716	Equatorial Guinea	2020-05-11	2020-05-12	439	4	13	422	draft
1717	Equatorial Guinea	2020-05-12	2020-05-13	439	4	13	422	draft
1718	Equatorial Guinea	2020-05-13	2020-05-14	522	6	13	503	draft
1719	Equatorial Guinea	2020-05-14	2020-05-15	583	7	13	563	draft
1720	Equatorial Guinea	2020-05-15	2020-05-16	594	7	22	565	draft
1721	Equatorial Guinea	2020-05-16	2020-05-17	594	7	22	565	draft
1722	Equatorial Guinea	2020-05-17	2020-05-18	594	7	22	565	draft
1723	Equatorial Guinea	2020-05-18	2020-05-19	719	7	22	690	draft
1724	Equatorial Guinea	2020-05-19	2020-05-20	825	7	22	796	draft
1725	Equatorial Guinea	2020-05-20	2020-05-21	890	7	22	861	draft
1726	Equatorial Guinea	2020-05-21	2020-05-22	903	10	22	871	draft
1727	Equatorial Guinea	2020-05-22	2020-05-23	960	11	165	784	draft
1728	Equatorial Guinea	2020-05-23	2020-05-24	960	11	165	784	draft
1729	Equatorial Guinea	2020-05-24	2020-05-25	960	11	165	784	draft
1730	Equatorial Guinea	2020-05-25	2020-05-26	1043	12	165	866	draft
1731	Equatorial Guinea	2020-05-26	2020-05-27	1043	12	165	866	draft
1732	Equatorial Guinea	2020-05-27	2020-05-28	1043	12	165	866	draft
1733	Equatorial Guinea	2020-05-28	2020-05-29	1043	12	165	866	draft
1734	Equatorial Guinea	2020-05-29	2020-05-30	1306	12	200	1094	draft
1735	Equatorial Guinea	2020-05-30	2020-05-31	1306	12	200	1094	draft
1736	Equatorial Guinea	2020-05-31	2020-06-01	1306	12	200	1094	draft
1737	Eritrea	2020-05-01	2020-05-02	39	0	26	13	draft
1738	Eritrea	2020-05-02	2020-05-03	39	0	26	13	draft
1739	Eritrea	2020-05-03	2020-05-04	39	0	26	13	draft
1740	Eritrea	2020-05-04	2020-05-05	39	0	26	13	draft
1741	Eritrea	2020-05-05	2020-05-06	39	0	30	9	draft
1742	Eritrea	2020-05-06	2020-05-07	39	0	30	9	draft
1743	Eritrea	2020-05-07	2020-05-08	39	0	30	9	draft
1744	Eritrea	2020-05-08	2020-05-09	39	0	37	2	draft
1745	Eritrea	2020-05-09	2020-05-10	39	0	37	2	draft
1746	Eritrea	2020-05-10	2020-05-11	39	0	37	2	draft
1747	Eritrea	2020-05-11	2020-05-12	39	0	38	1	draft
1748	Eritrea	2020-05-12	2020-05-13	39	0	38	1	draft
1749	Eritrea	2020-05-13	2020-05-14	39	0	38	1	draft
1750	Eritrea	2020-05-14	2020-05-15	39	0	38	1	draft
1751	Eritrea	2020-05-15	2020-05-16	39	0	39	0	draft
1752	Eritrea	2020-05-16	2020-05-17	39	0	39	0	draft
1753	Eritrea	2020-05-17	2020-05-18	39	0	39	0	draft
1754	Eritrea	2020-05-18	2020-05-19	39	0	39	0	draft
1755	Eritrea	2020-05-19	2020-05-20	39	0	39	0	draft
1756	Eritrea	2020-05-20	2020-05-21	39	0	39	0	draft
1757	Eritrea	2020-05-21	2020-05-22	39	0	39	0	draft
1758	Eritrea	2020-05-22	2020-05-23	39	0	39	0	draft
1759	Eritrea	2020-05-23	2020-05-24	39	0	39	0	draft
1760	Eritrea	2020-05-24	2020-05-25	39	0	39	0	draft
1761	Eritrea	2020-05-25	2020-05-26	39	0	39	0	draft
1762	Eritrea	2020-05-26	2020-05-27	39	0	39	0	draft
1763	Eritrea	2020-05-27	2020-05-28	39	0	39	0	draft
1764	Eritrea	2020-05-28	2020-05-29	39	0	39	0	draft
1765	Eritrea	2020-05-29	2020-05-30	39	0	39	0	draft
1766	Eritrea	2020-05-30	2020-05-31	39	0	39	0	draft
1767	Eritrea	2020-05-31	2020-06-01	39	0	39	0	draft
1768	Estonia	2020-05-01	2020-05-02	1694	52	253	1389	draft
1769	Estonia	2020-05-02	2020-05-03	1699	53	256	1390	draft
1770	Estonia	2020-05-03	2020-05-04	1700	55	259	1386	draft
1771	Estonia	2020-05-04	2020-05-05	1703	55	259	1389	draft
1772	Estonia	2020-05-05	2020-05-06	1711	55	261	1395	draft
1773	Estonia	2020-05-06	2020-05-07	1713	55	264	1394	draft
1774	Estonia	2020-05-07	2020-05-08	1720	56	273	1391	draft
1775	Estonia	2020-05-08	2020-05-09	1725	56	704	965	draft
1776	Estonia	2020-05-09	2020-05-10	1733	60	747	926	draft
1777	Estonia	2020-05-10	2020-05-11	1739	60	750	929	draft
1778	Estonia	2020-05-11	2020-05-12	1741	61	751	929	draft
1779	Estonia	2020-05-12	2020-05-13	1746	61	777	908	draft
1780	Estonia	2020-05-13	2020-05-14	1751	61	777	913	draft
1781	Estonia	2020-05-14	2020-05-15	1758	62	909	787	draft
1782	Estonia	2020-05-15	2020-05-16	1766	63	923	780	draft
1783	Estonia	2020-05-16	2020-05-17	1770	63	934	773	draft
1784	Estonia	2020-05-17	2020-05-18	1774	63	938	773	draft
1785	Estonia	2020-05-18	2020-05-19	1784	64	938	782	draft
1786	Estonia	2020-05-19	2020-05-20	1791	64	938	789	draft
1787	Estonia	2020-05-20	2020-05-21	1794	64	956	774	draft
1788	Estonia	2020-05-21	2020-05-22	1800	64	1488	248	draft
1789	Estonia	2020-05-22	2020-05-23	1807	64	1508	235	draft
1790	Estonia	2020-05-23	2020-05-24	1821	64	1526	231	draft
1791	Estonia	2020-05-24	2020-05-25	1823	64	1532	227	draft
1792	Estonia	2020-05-25	2020-05-26	1824	65	1538	221	draft
1793	Estonia	2020-05-26	2020-05-27	1834	65	1552	217	draft
1794	Estonia	2020-05-27	2020-05-28	1840	66	1561	213	draft
1795	Estonia	2020-05-28	2020-05-29	1851	66	1574	211	draft
1796	Estonia	2020-05-29	2020-05-30	1859	67	1610	182	draft
1797	Estonia	2020-05-30	2020-05-31	1865	67	1622	176	draft
1798	Estonia	2020-05-31	2020-06-01	1869	68	1624	177	draft
1799	Eswatini	2020-05-01	2020-05-02	106	1	12	93	draft
1800	Eswatini	2020-05-02	2020-05-03	108	1	12	95	draft
1801	Eswatini	2020-05-03	2020-05-04	112	1	12	99	draft
1802	Eswatini	2020-05-04	2020-05-05	116	1	12	103	draft
1803	Eswatini	2020-05-05	2020-05-06	119	1	12	106	draft
1804	Eswatini	2020-05-06	2020-05-07	123	2	12	109	draft
1805	Eswatini	2020-05-07	2020-05-08	153	2	12	139	draft
1806	Eswatini	2020-05-08	2020-05-09	159	2	12	145	draft
1807	Eswatini	2020-05-09	2020-05-10	163	2	14	147	draft
1808	Eswatini	2020-05-10	2020-05-11	172	2	27	143	draft
1809	Eswatini	2020-05-11	2020-05-12	175	2	28	145	draft
1810	Eswatini	2020-05-12	2020-05-13	184	2	28	154	draft
1811	Eswatini	2020-05-13	2020-05-14	187	2	48	137	draft
1812	Eswatini	2020-05-14	2020-05-15	187	2	51	134	draft
1813	Eswatini	2020-05-15	2020-05-16	190	2	66	122	draft
1814	Eswatini	2020-05-16	2020-05-17	202	2	72	128	draft
1815	Eswatini	2020-05-17	2020-05-18	203	2	73	128	draft
1816	Eswatini	2020-05-18	2020-05-19	205	2	78	125	draft
1817	Eswatini	2020-05-19	2020-05-20	208	2	87	119	draft
1818	Eswatini	2020-05-20	2020-05-21	217	2	97	118	draft
1819	Eswatini	2020-05-21	2020-05-22	220	2	112	106	draft
1820	Eswatini	2020-05-22	2020-05-23	225	2	119	104	draft
1821	Eswatini	2020-05-23	2020-05-24	238	2	119	117	draft
1822	Eswatini	2020-05-24	2020-05-25	250	2	156	92	draft
1823	Eswatini	2020-05-25	2020-05-26	256	2	158	96	draft
1824	Eswatini	2020-05-26	2020-05-27	261	2	164	95	draft
1825	Eswatini	2020-05-27	2020-05-28	272	2	168	102	draft
1826	Eswatini	2020-05-28	2020-05-29	279	2	168	109	draft
1827	Eswatini	2020-05-29	2020-05-30	279	2	168	109	draft
1828	Eswatini	2020-05-30	2020-05-31	283	2	168	113	draft
1829	Eswatini	2020-05-31	2020-06-01	285	2	189	94	draft
1830	Ethiopia	2020-05-01	2020-05-02	133	3	66	64	draft
1831	Ethiopia	2020-05-02	2020-05-03	133	3	69	61	draft
1832	Ethiopia	2020-05-03	2020-05-04	135	3	75	57	draft
1833	Ethiopia	2020-05-04	2020-05-05	140	3	75	62	draft
1834	Ethiopia	2020-05-05	2020-05-06	145	4	91	50	draft
1835	Ethiopia	2020-05-06	2020-05-07	162	4	93	65	draft
1836	Ethiopia	2020-05-07	2020-05-08	191	4	93	94	draft
1837	Ethiopia	2020-05-08	2020-05-09	194	4	95	95	draft
1838	Ethiopia	2020-05-09	2020-05-10	210	5	97	108	draft
1839	Ethiopia	2020-05-10	2020-05-11	239	5	99	135	draft
1840	Ethiopia	2020-05-11	2020-05-12	250	5	105	140	draft
1841	Ethiopia	2020-05-12	2020-05-13	261	5	106	150	draft
1842	Ethiopia	2020-05-13	2020-05-14	263	5	108	150	draft
1843	Ethiopia	2020-05-14	2020-05-15	272	5	108	159	draft
1844	Ethiopia	2020-05-15	2020-05-16	287	5	112	170	draft
1845	Ethiopia	2020-05-16	2020-05-17	306	5	113	188	draft
1846	Ethiopia	2020-05-17	2020-05-18	317	5	113	199	draft
1847	Ethiopia	2020-05-18	2020-05-19	352	5	116	231	draft
1848	Ethiopia	2020-05-19	2020-05-20	365	5	120	240	draft
1849	Ethiopia	2020-05-20	2020-05-21	389	5	122	262	draft
1850	Ethiopia	2020-05-21	2020-05-22	399	5	123	271	draft
1851	Ethiopia	2020-05-22	2020-05-23	433	5	128	300	draft
1852	Ethiopia	2020-05-23	2020-05-24	494	5	151	338	draft
1853	Ethiopia	2020-05-24	2020-05-25	582	5	152	425	draft
1854	Ethiopia	2020-05-25	2020-05-26	655	5	159	491	draft
1855	Ethiopia	2020-05-26	2020-05-27	701	6	167	528	draft
1856	Ethiopia	2020-05-27	2020-05-28	731	6	181	544	draft
1857	Ethiopia	2020-05-28	2020-05-29	831	7	191	633	draft
1858	Ethiopia	2020-05-29	2020-05-30	968	8	197	763	draft
1859	Ethiopia	2020-05-30	2020-05-31	1063	8	208	847	draft
1860	Ethiopia	2020-05-31	2020-06-01	1172	11	209	952	draft
1861	Fiji	2020-05-01	2020-05-02	18	0	12	6	draft
1862	Fiji	2020-05-02	2020-05-03	18	0	14	4	draft
1863	Fiji	2020-05-03	2020-05-04	18	0	14	4	draft
1864	Fiji	2020-05-04	2020-05-05	18	0	14	4	draft
1865	Fiji	2020-05-05	2020-05-06	18	0	14	4	draft
1866	Fiji	2020-05-06	2020-05-07	18	0	14	4	draft
1867	Fiji	2020-05-07	2020-05-08	18	0	14	4	draft
1868	Fiji	2020-05-08	2020-05-09	18	0	14	4	draft
1869	Fiji	2020-05-09	2020-05-10	18	0	14	4	draft
1870	Fiji	2020-05-10	2020-05-11	18	0	14	4	draft
1871	Fiji	2020-05-11	2020-05-12	18	0	14	4	draft
1872	Fiji	2020-05-12	2020-05-13	18	0	14	4	draft
1873	Fiji	2020-05-13	2020-05-14	18	0	14	4	draft
1874	Fiji	2020-05-14	2020-05-15	18	0	14	4	draft
1875	Fiji	2020-05-15	2020-05-16	18	0	15	3	draft
1876	Fiji	2020-05-16	2020-05-17	18	0	15	3	draft
1877	Fiji	2020-05-17	2020-05-18	18	0	15	3	draft
1878	Fiji	2020-05-18	2020-05-19	18	0	15	3	draft
1879	Fiji	2020-05-19	2020-05-20	18	0	15	3	draft
1880	Fiji	2020-05-20	2020-05-21	18	0	15	3	draft
1881	Fiji	2020-05-21	2020-05-22	18	0	15	3	draft
1882	Fiji	2020-05-22	2020-05-23	18	0	15	3	draft
1883	Fiji	2020-05-23	2020-05-24	18	0	15	3	draft
1884	Fiji	2020-05-24	2020-05-25	18	0	15	3	draft
1885	Fiji	2020-05-25	2020-05-26	18	0	15	3	draft
1886	Fiji	2020-05-26	2020-05-27	18	0	15	3	draft
1887	Fiji	2020-05-27	2020-05-28	18	0	15	3	draft
1888	Fiji	2020-05-28	2020-05-29	18	0	15	3	draft
1889	Fiji	2020-05-29	2020-05-30	18	0	15	3	draft
1890	Fiji	2020-05-30	2020-05-31	18	0	15	3	draft
1891	Fiji	2020-05-31	2020-06-01	18	0	15	3	draft
1892	Finland	2020-05-01	2020-05-02	5051	218	3000	1833	draft
1893	Finland	2020-05-02	2020-05-03	5176	220	3000	1956	draft
1894	Finland	2020-05-03	2020-05-04	5254	230	3000	2024	draft
1895	Finland	2020-05-04	2020-05-05	5327	240	3500	1587	draft
1896	Finland	2020-05-05	2020-05-06	5412	246	3500	1666	draft
1897	Finland	2020-05-06	2020-05-07	5573	252	3500	1821	draft
1898	Finland	2020-05-07	2020-05-08	5673	255	3500	1918	draft
1899	Finland	2020-05-08	2020-05-09	5738	260	4000	1478	draft
1900	Finland	2020-05-09	2020-05-10	5880	265	4000	1615	draft
1901	Finland	2020-05-10	2020-05-11	5962	267	4000	1695	draft
1902	Finland	2020-05-11	2020-05-12	5984	271	4000	1713	draft
1903	Finland	2020-05-12	2020-05-13	6003	275	4300	1428	draft
1904	Finland	2020-05-13	2020-05-14	6054	284	4300	1470	draft
1905	Finland	2020-05-14	2020-05-15	6145	287	4300	1558	draft
1906	Finland	2020-05-15	2020-05-16	6228	293	5000	935	draft
1907	Finland	2020-05-16	2020-05-17	6286	297	5000	989	draft
1908	Finland	2020-05-17	2020-05-18	6347	298	5000	1049	draft
1909	Finland	2020-05-18	2020-05-19	6380	300	5000	1080	draft
1910	Finland	2020-05-19	2020-05-20	6399	301	5000	1098	draft
1911	Finland	2020-05-20	2020-05-21	6443	304	4800	1339	draft
1912	Finland	2020-05-21	2020-05-22	6493	306	4800	1387	draft
1913	Finland	2020-05-22	2020-05-23	6537	306	4800	1431	draft
1914	Finland	2020-05-23	2020-05-24	6568	306	4800	1462	draft
1915	Finland	2020-05-24	2020-05-25	6579	307	4800	1472	draft
1916	Finland	2020-05-25	2020-05-26	6599	308	5100	1191	draft
1917	Finland	2020-05-26	2020-05-27	6628	312	5100	1216	draft
1918	Finland	2020-05-27	2020-05-28	6692	313	5100	1279	draft
1919	Finland	2020-05-28	2020-05-29	6743	313	5500	930	draft
1920	Finland	2020-05-29	2020-05-30	6776	314	5500	962	draft
1921	Finland	2020-05-30	2020-05-31	6826	316	5500	1010	draft
1922	Finland	2020-05-31	2020-06-01	6859	320	5500	1039	draft
1923	France	2020-05-01	2020-05-02	169387	24597	51124	91553	draft
1924	France	2020-05-02	2020-05-03	170179	24763	50663	93092	draft
1925	France	2020-05-03	2020-05-04	170540	24898	50885	93140	draft
1926	France	2020-05-04	2020-05-05	171102	25204	51476	92903	draft
1927	France	2020-05-05	2020-05-06	172219	25537	52842	92308	draft
1928	France	2020-05-06	2020-05-07	176355	25812	54079	94333	draft
1929	France	2020-05-07	2020-05-08	177096	25991	55191	93737	draft
1930	France	2020-05-08	2020-05-09	177627	26233	55892	94077	draft
1931	France	2020-05-09	2020-05-10	178156	26313	56148	94321	draft
1932	France	2020-05-10	2020-05-11	178405	26383	56327	94384	draft
1933	France	2020-05-11	2020-05-12	178719	26646	56835	94066	draft
1934	France	2020-05-12	2020-05-13	179472	26994	57898	93457	draft
1935	France	2020-05-13	2020-05-14	179993	27079	58786	92321	draft
1936	France	2020-05-14	2020-05-15	180635	27430	59719	91847	draft
1937	France	2020-05-15	2020-05-16	181148	27532	60562	91536	draft
1938	France	2020-05-16	2020-05-17	181563	27630	60562	91536	draft
1939	France	2020-05-17	2020-05-18	181703	28113	61327	90255	draft
1940	France	2020-05-18	2020-05-19	182147	28242	61843	89966	draft
1941	France	2020-05-19	2020-05-20	182648	28025	62678	90230	draft
1942	France	2020-05-20	2020-05-21	183130	28136	63472	90093	draft
1943	France	2020-05-21	2020-05-22	183397	28218	63976	89757	draft
1944	France	2020-05-22	2020-05-23	183814	28292	63986	89811	draft
1945	France	2020-05-23	2020-05-24	184041	28335	63988	89830	draft
1946	France	2020-05-24	2020-05-25	184260	28372	64735	89604	draft
1947	France	2020-05-25	2020-05-26	184585	28461	65317	89290	draft
1948	France	2020-05-26	2020-05-27	184840	28598	65997	88317	draft
1949	France	2020-05-27	2020-05-28	185012	28599	66702	87737	draft
1950	France	2020-05-28	2020-05-29	188355	28666	67309	90390	draft
1951	France	2020-05-29	2020-05-30	188949	28717	67921	90285	draft
1952	France	2020-05-30	2020-05-31	190744	28774	68386	91592	draft
1953	France	2020-05-31	2020-06-01	190975	28805	68473	91731	draft
1954	Gabon	2020-05-01	2020-05-02	276	3	67	206	draft
1955	Gabon	2020-05-02	2020-05-03	335	5	85	245	draft
1956	Gabon	2020-05-03	2020-05-04	335	5	85	245	draft
1957	Gabon	2020-05-04	2020-05-05	367	6	93	268	draft
1958	Gabon	2020-05-05	2020-05-06	397	6	93	298	draft
1959	Gabon	2020-05-06	2020-05-07	397	6	93	298	draft
1960	Gabon	2020-05-07	2020-05-08	504	8	110	386	draft
1961	Gabon	2020-05-08	2020-05-09	620	8	110	502	draft
1962	Gabon	2020-05-09	2020-05-10	661	8	110	543	draft
1963	Gabon	2020-05-10	2020-05-11	661	8	110	543	draft
1964	Gabon	2020-05-11	2020-05-12	802	9	127	666	draft
1965	Gabon	2020-05-12	2020-05-13	863	9	137	717	draft
1966	Gabon	2020-05-13	2020-05-14	1004	9	152	843	draft
1967	Gabon	2020-05-14	2020-05-15	1104	10	182	912	draft
1968	Gabon	2020-05-15	2020-05-16	1209	10	219	980	draft
1969	Gabon	2020-05-16	2020-05-17	1320	11	244	1065	draft
1970	Gabon	2020-05-17	2020-05-18	1320	11	244	1065	draft
1971	Gabon	2020-05-18	2020-05-19	1432	11	301	1120	draft
1972	Gabon	2020-05-19	2020-05-20	1502	12	318	1172	draft
1973	Gabon	2020-05-20	2020-05-21	1567	12	365	1190	draft
1974	Gabon	2020-05-21	2020-05-22	1567	12	365	1190	draft
1975	Gabon	2020-05-22	2020-05-23	1728	12	402	1314	draft
1976	Gabon	2020-05-23	2020-05-24	1934	12	459	1463	draft
1977	Gabon	2020-05-24	2020-05-25	1934	12	459	1463	draft
1978	Gabon	2020-05-25	2020-05-26	2135	14	562	1559	draft
1979	Gabon	2020-05-26	2020-05-27	2238	14	593	1631	draft
1980	Gabon	2020-05-27	2020-05-28	2319	14	631	1674	draft
1981	Gabon	2020-05-28	2020-05-29	2431	14	668	1749	draft
1982	Gabon	2020-05-29	2020-05-30	2613	15	709	1889	draft
1983	Gabon	2020-05-30	2020-05-31	2655	17	722	1916	draft
1984	Gabon	2020-05-31	2020-06-01	2655	17	722	1916	draft
1985	Gambia	2020-05-01	2020-05-02	12	1	8	3	draft
1986	Gambia	2020-05-02	2020-05-03	17	1	9	7	draft
1987	Gambia	2020-05-03	2020-05-04	17	1	9	7	draft
1988	Gambia	2020-05-04	2020-05-05	17	1	9	7	draft
1989	Gambia	2020-05-05	2020-05-06	17	1	9	7	draft
1990	Gambia	2020-05-06	2020-05-07	17	1	9	7	draft
1991	Gambia	2020-05-07	2020-05-08	18	1	9	8	draft
1992	Gambia	2020-05-08	2020-05-09	20	1	9	10	draft
1993	Gambia	2020-05-09	2020-05-10	20	1	9	10	draft
1994	Gambia	2020-05-10	2020-05-11	20	1	9	10	draft
1995	Gambia	2020-05-11	2020-05-12	22	1	10	11	draft
1996	Gambia	2020-05-12	2020-05-13	22	1	10	11	draft
1997	Gambia	2020-05-13	2020-05-14	23	1	10	12	draft
1998	Gambia	2020-05-14	2020-05-15	23	1	10	12	draft
1999	Gambia	2020-05-15	2020-05-16	23	1	10	12	draft
2000	Gambia	2020-05-16	2020-05-17	23	1	12	10	draft
2001	Gambia	2020-05-17	2020-05-18	23	1	12	10	draft
2002	Gambia	2020-05-18	2020-05-19	24	1	13	10	draft
2003	Gambia	2020-05-19	2020-05-20	24	1	13	10	draft
2004	Gambia	2020-05-20	2020-05-21	24	1	13	10	draft
2005	Gambia	2020-05-21	2020-05-22	24	1	13	10	draft
2006	Gambia	2020-05-22	2020-05-23	25	1	13	11	draft
2007	Gambia	2020-05-23	2020-05-24	25	1	13	11	draft
2008	Gambia	2020-05-24	2020-05-25	25	1	13	11	draft
2009	Gambia	2020-05-25	2020-05-26	25	1	17	7	draft
2010	Gambia	2020-05-26	2020-05-27	25	1	18	6	draft
2011	Gambia	2020-05-27	2020-05-28	25	1	19	5	draft
2012	Gambia	2020-05-28	2020-05-29	25	1	19	5	draft
2013	Gambia	2020-05-29	2020-05-30	25	1	20	4	draft
2014	Gambia	2020-05-30	2020-05-31	25	1	20	4	draft
2015	Gambia	2020-05-31	2020-06-01	25	1	20	4	draft
2016	Georgia	2020-05-01	2020-05-02	566	7	207	352	draft
2017	Georgia	2020-05-02	2020-05-03	582	8	207	367	draft
2018	Georgia	2020-05-03	2020-05-04	589	9	223	357	draft
2019	Georgia	2020-05-04	2020-05-05	593	9	223	361	draft
2020	Georgia	2020-05-05	2020-05-06	604	9	240	355	draft
2021	Georgia	2020-05-06	2020-05-07	610	9	269	332	draft
2022	Georgia	2020-05-07	2020-05-08	615	9	275	331	draft
2023	Georgia	2020-05-08	2020-05-09	623	10	288	325	draft
2024	Georgia	2020-05-09	2020-05-10	626	10	297	319	draft
2025	Georgia	2020-05-10	2020-05-11	635	10	309	316	draft
2026	Georgia	2020-05-11	2020-05-12	638	11	317	310	draft
2027	Georgia	2020-05-12	2020-05-13	642	11	349	282	draft
2028	Georgia	2020-05-13	2020-05-14	647	11	372	264	draft
2029	Georgia	2020-05-14	2020-05-15	667	12	383	272	draft
2030	Georgia	2020-05-15	2020-05-16	671	12	393	266	draft
2031	Georgia	2020-05-16	2020-05-17	683	12	419	252	draft
2032	Georgia	2020-05-17	2020-05-18	695	12	425	258	draft
2033	Georgia	2020-05-18	2020-05-19	701	12	432	257	draft
2034	Georgia	2020-05-19	2020-05-20	707	12	456	239	draft
2035	Georgia	2020-05-20	2020-05-21	713	12	475	226	draft
2036	Georgia	2020-05-21	2020-05-22	721	12	485	224	draft
2037	Georgia	2020-05-22	2020-05-23	723	12	495	216	draft
2038	Georgia	2020-05-23	2020-05-24	728	12	509	207	draft
2039	Georgia	2020-05-24	2020-05-25	730	12	522	196	draft
2040	Georgia	2020-05-25	2020-05-26	731	12	526	193	draft
2041	Georgia	2020-05-26	2020-05-27	732	12	537	183	draft
2042	Georgia	2020-05-27	2020-05-28	735	12	557	166	draft
2043	Georgia	2020-05-28	2020-05-29	738	12	573	153	draft
2044	Georgia	2020-05-29	2020-05-30	746	12	576	158	draft
2045	Georgia	2020-05-30	2020-05-31	757	12	600	145	draft
2046	Georgia	2020-05-31	2020-06-01	783	12	605	166	draft
2047	Germany	2020-05-01	2020-05-02	164077	6736	126900	30441	draft
2048	Germany	2020-05-02	2020-05-03	164967	6812	129000	29155	draft
2049	Germany	2020-05-03	2020-05-04	165664	6866	130600	28198	draft
2050	Germany	2020-05-04	2020-05-05	166152	6993	132700	26459	draft
2051	Germany	2020-05-05	2020-05-06	167007	6993	135100	24914	draft
2052	Germany	2020-05-06	2020-05-07	168162	7275	139900	20987	draft
2053	Germany	2020-05-07	2020-05-08	169430	7392	141700	20338	draft
2054	Germany	2020-05-08	2020-05-09	170588	7510	141700	21378	draft
2055	Germany	2020-05-09	2020-05-10	171324	7549	143300	20475	draft
2056	Germany	2020-05-10	2020-05-11	171879	7569	144400	19910	draft
2057	Germany	2020-05-11	2020-05-12	172576	7661	145617	19298	draft
2058	Germany	2020-05-12	2020-05-13	173171	7738	147200	18233	draft
2059	Germany	2020-05-13	2020-05-14	174098	7861	148700	17537	draft
2060	Germany	2020-05-14	2020-05-15	174478	7884	150300	16294	draft
2061	Germany	2020-05-15	2020-05-16	175233	7897	151597	15739	draft
2062	Germany	2020-05-16	2020-05-17	175752	7938	152600	15214	draft
2063	Germany	2020-05-17	2020-05-18	176369	7962	154011	14396	draft
2064	Germany	2020-05-18	2020-05-19	176551	8003	155041	13507	draft
2065	Germany	2020-05-19	2020-05-20	177778	8081	155681	14016	draft
2066	Germany	2020-05-20	2020-05-21	178473	8144	156966	13363	draft
2067	Germany	2020-05-21	2020-05-22	179021	8203	158087	12731	draft
2068	Germany	2020-05-22	2020-05-23	179710	8228	159064	12418	draft
2069	Germany	2020-05-23	2020-05-24	179986	8261	159716	12009	draft
2070	Germany	2020-05-24	2020-05-25	180328	8283	160281	11764	draft
2071	Germany	2020-05-25	2020-05-26	180600	8309	161199	11092	draft
2072	Germany	2020-05-26	2020-05-27	181200	8372	161967	10861	draft
2073	Germany	2020-05-27	2020-05-28	181524	8428	162820	10276	draft
2074	Germany	2020-05-28	2020-05-29	182196	8470	163360	10366	draft
2075	Germany	2020-05-29	2020-05-30	182922	8504	164245	10173	draft
2076	Germany	2020-05-30	2020-05-31	183189	8530	164908	9751	draft
2077	Germany	2020-05-31	2020-06-01	183410	8540	165352	9518	draft
2078	Ghana	2020-05-01	2020-05-02	2074	17	212	1845	draft
2079	Ghana	2020-05-02	2020-05-03	2169	18	229	1922	draft
2080	Ghana	2020-05-03	2020-05-04	2169	18	229	1922	draft
2081	Ghana	2020-05-04	2020-05-05	2719	18	294	2407	draft
2082	Ghana	2020-05-05	2020-05-06	2719	18	294	2407	draft
2083	Ghana	2020-05-06	2020-05-07	3091	18	294	2779	draft
2084	Ghana	2020-05-07	2020-05-08	3091	18	303	2770	draft
2085	Ghana	2020-05-08	2020-05-09	4012	18	323	3671	draft
2086	Ghana	2020-05-09	2020-05-10	4263	22	378	3863	draft
2087	Ghana	2020-05-10	2020-05-11	4263	22	378	3863	draft
2088	Ghana	2020-05-11	2020-05-12	4700	22	494	4184	draft
2089	Ghana	2020-05-12	2020-05-13	5127	22	494	4611	draft
2090	Ghana	2020-05-13	2020-05-14	5408	24	514	4870	draft
2091	Ghana	2020-05-14	2020-05-15	5530	24	674	4832	draft
2092	Ghana	2020-05-15	2020-05-16	5638	28	1460	4150	draft
2093	Ghana	2020-05-16	2020-05-17	5735	29	1754	3952	draft
2094	Ghana	2020-05-17	2020-05-18	5735	29	1754	3952	draft
2095	Ghana	2020-05-18	2020-05-19	5735	29	1754	3952	draft
2096	Ghana	2020-05-19	2020-05-20	6096	31	1773	4292	draft
2097	Ghana	2020-05-20	2020-05-21	6269	31	1898	4340	draft
2098	Ghana	2020-05-21	2020-05-22	6269	31	1898	4340	draft
2099	Ghana	2020-05-22	2020-05-23	6486	31	1951	4504	draft
2100	Ghana	2020-05-23	2020-05-24	6617	31	1978	4608	draft
2101	Ghana	2020-05-24	2020-05-25	6683	32	1998	4653	draft
2102	Ghana	2020-05-25	2020-05-26	6808	32	2070	4706	draft
2103	Ghana	2020-05-26	2020-05-27	7117	34	2317	4766	draft
2104	Ghana	2020-05-27	2020-05-28	7303	34	2412	4857	draft
2105	Ghana	2020-05-28	2020-05-29	7303	34	2412	4857	draft
2106	Ghana	2020-05-29	2020-05-30	7616	34	2421	5161	draft
2107	Ghana	2020-05-30	2020-05-31	7768	35	2540	5193	draft
2108	Ghana	2020-05-31	2020-06-01	8070	36	2947	5087	draft
2109	Greece	2020-05-01	2020-05-02	2612	140	1374	1098	draft
2110	Greece	2020-05-02	2020-05-03	2620	143	1374	1103	draft
2111	Greece	2020-05-03	2020-05-04	2626	144	1374	1108	draft
2112	Greece	2020-05-04	2020-05-05	2632	146	1374	1112	draft
2113	Greece	2020-05-05	2020-05-06	2642	146	1374	1122	draft
2114	Greece	2020-05-06	2020-05-07	2663	147	1374	1142	draft
2115	Greece	2020-05-07	2020-05-08	2678	148	1374	1156	draft
2116	Greece	2020-05-08	2020-05-09	2691	150	1374	1167	draft
2117	Greece	2020-05-09	2020-05-10	2710	151	1374	1185	draft
2118	Greece	2020-05-10	2020-05-11	2716	151	1374	1191	draft
2119	Greece	2020-05-11	2020-05-12	2726	151	1374	1201	draft
2120	Greece	2020-05-12	2020-05-13	2744	152	1374	1218	draft
2121	Greece	2020-05-13	2020-05-14	2760	155	1374	1231	draft
2122	Greece	2020-05-14	2020-05-15	2770	156	1374	1240	draft
2123	Greece	2020-05-15	2020-05-16	2810	160	1374	1276	draft
2124	Greece	2020-05-16	2020-05-17	2819	162	1374	1283	draft
2125	Greece	2020-05-17	2020-05-18	2834	163	1374	1297	draft
2126	Greece	2020-05-18	2020-05-19	2836	165	1374	1297	draft
2127	Greece	2020-05-19	2020-05-20	2840	165	1374	1301	draft
2128	Greece	2020-05-20	2020-05-21	2850	166	1374	1310	draft
2129	Greece	2020-05-21	2020-05-22	2853	168	1374	1311	draft
2130	Greece	2020-05-22	2020-05-23	2874	169	1374	1331	draft
2131	Greece	2020-05-23	2020-05-24	2876	171	1374	1331	draft
2132	Greece	2020-05-24	2020-05-25	2878	171	1374	1333	draft
2133	Greece	2020-05-25	2020-05-26	2882	172	1374	1336	draft
2134	Greece	2020-05-26	2020-05-27	2892	173	1374	1345	draft
2135	Greece	2020-05-27	2020-05-28	2903	173	1374	1356	draft
2136	Greece	2020-05-28	2020-05-29	2906	175	1374	1357	draft
2137	Greece	2020-05-29	2020-05-30	2909	175	1374	1360	draft
2138	Greece	2020-05-30	2020-05-31	2915	175	1374	1366	draft
2139	Greece	2020-05-31	2020-06-01	2917	175	1374	1368	draft
2140	Grenada	2020-05-01	2020-05-02	20	0	13	7	draft
2141	Grenada	2020-05-02	2020-05-03	21	0	13	8	draft
2142	Grenada	2020-05-03	2020-05-04	21	0	13	8	draft
2143	Grenada	2020-05-04	2020-05-05	21	0	13	8	draft
2144	Grenada	2020-05-05	2020-05-06	21	0	13	8	draft
2145	Grenada	2020-05-06	2020-05-07	21	0	13	8	draft
2146	Grenada	2020-05-07	2020-05-08	21	0	13	8	draft
2147	Grenada	2020-05-08	2020-05-09	21	0	13	8	draft
2148	Grenada	2020-05-09	2020-05-10	21	0	13	8	draft
2149	Grenada	2020-05-10	2020-05-11	21	0	13	8	draft
2150	Grenada	2020-05-11	2020-05-12	21	0	13	8	draft
2151	Grenada	2020-05-12	2020-05-13	21	0	13	8	draft
2152	Grenada	2020-05-13	2020-05-14	21	0	13	8	draft
2153	Grenada	2020-05-14	2020-05-15	21	0	14	7	draft
2154	Grenada	2020-05-15	2020-05-16	22	0	14	8	draft
2155	Grenada	2020-05-16	2020-05-17	22	0	14	8	draft
2156	Grenada	2020-05-17	2020-05-18	22	0	14	8	draft
2157	Grenada	2020-05-18	2020-05-19	22	0	14	8	draft
2158	Grenada	2020-05-19	2020-05-20	22	0	14	8	draft
2159	Grenada	2020-05-20	2020-05-21	22	0	17	5	draft
2160	Grenada	2020-05-21	2020-05-22	22	0	17	5	draft
2161	Grenada	2020-05-22	2020-05-23	22	0	17	5	draft
2162	Grenada	2020-05-23	2020-05-24	22	0	17	5	draft
2163	Grenada	2020-05-24	2020-05-25	22	0	17	5	draft
2164	Grenada	2020-05-25	2020-05-26	23	0	18	5	draft
2165	Grenada	2020-05-26	2020-05-27	23	0	18	5	draft
2166	Grenada	2020-05-27	2020-05-28	23	0	18	5	draft
2167	Grenada	2020-05-28	2020-05-29	23	0	18	5	draft
2168	Grenada	2020-05-29	2020-05-30	23	0	18	5	draft
2169	Grenada	2020-05-30	2020-05-31	23	0	18	5	draft
2170	Grenada	2020-05-31	2020-06-01	23	0	18	5	draft
2171	Guatemala	2020-05-01	2020-05-02	644	16	72	556	draft
2172	Guatemala	2020-05-02	2020-05-03	688	17	72	599	draft
2173	Guatemala	2020-05-03	2020-05-04	703	17	72	614	draft
2174	Guatemala	2020-05-04	2020-05-05	730	19	79	632	draft
2175	Guatemala	2020-05-05	2020-05-06	763	19	79	665	draft
2176	Guatemala	2020-05-06	2020-05-07	798	21	86	691	draft
2177	Guatemala	2020-05-07	2020-05-08	832	23	90	719	draft
2178	Guatemala	2020-05-08	2020-05-09	900	24	101	775	draft
2179	Guatemala	2020-05-09	2020-05-10	967	24	104	839	draft
2180	Guatemala	2020-05-10	2020-05-11	1052	26	110	916	draft
2181	Guatemala	2020-05-11	2020-05-12	1114	26	111	977	draft
2182	Guatemala	2020-05-12	2020-05-13	1199	27	120	1052	draft
2183	Guatemala	2020-05-13	2020-05-14	1342	29	121	1192	draft
2184	Guatemala	2020-05-14	2020-05-15	1518	29	129	1360	draft
2185	Guatemala	2020-05-15	2020-05-16	1643	30	135	1478	draft
2186	Guatemala	2020-05-16	2020-05-17	1763	33	138	1592	draft
2187	Guatemala	2020-05-17	2020-05-18	1763	33	138	1592	draft
2188	Guatemala	2020-05-18	2020-05-19	1912	35	138	1739	draft
2189	Guatemala	2020-05-19	2020-05-20	2133	43	155	1935	draft
2190	Guatemala	2020-05-20	2020-05-21	2265	45	159	2061	draft
2191	Guatemala	2020-05-21	2020-05-22	2512	48	222	2242	draft
2192	Guatemala	2020-05-22	2020-05-23	2743	51	222	2470	draft
2193	Guatemala	2020-05-23	2020-05-24	3054	55	244	2755	draft
2194	Guatemala	2020-05-24	2020-05-25	3424	58	258	3108	draft
2195	Guatemala	2020-05-25	2020-05-26	3760	59	274	3427	draft
2196	Guatemala	2020-05-26	2020-05-27	3954	63	289	3602	draft
2197	Guatemala	2020-05-27	2020-05-28	4145	68	493	3584	draft
2198	Guatemala	2020-05-28	2020-05-29	4348	80	565	3703	draft
2199	Guatemala	2020-05-29	2020-05-30	4607	90	648	3869	draft
2200	Guatemala	2020-05-30	2020-05-31	4739	102	706	3931	draft
2201	Guatemala	2020-05-31	2020-06-01	5087	108	735	4244	draft
2202	Guinea	2020-05-01	2020-05-02	1537	7	342	1188	draft
2203	Guinea	2020-05-02	2020-05-03	1586	7	405	1174	draft
2204	Guinea	2020-05-03	2020-05-04	1586	7	405	1174	draft
2205	Guinea	2020-05-04	2020-05-05	1710	9	450	1251	draft
2206	Guinea	2020-05-05	2020-05-06	1811	10	498	1303	draft
2207	Guinea	2020-05-06	2020-05-07	1856	11	597	1248	draft
2208	Guinea	2020-05-07	2020-05-08	1927	11	629	1287	draft
2209	Guinea	2020-05-08	2020-05-09	2009	11	663	1335	draft
2210	Guinea	2020-05-09	2020-05-10	2042	11	698	1333	draft
2211	Guinea	2020-05-10	2020-05-11	2146	11	714	1421	draft
2212	Guinea	2020-05-11	2020-05-12	2146	11	714	1421	draft
2213	Guinea	2020-05-12	2020-05-13	2298	11	816	1471	draft
2214	Guinea	2020-05-13	2020-05-14	2374	14	856	1504	draft
2215	Guinea	2020-05-14	2020-05-15	2473	15	895	1563	draft
2216	Guinea	2020-05-15	2020-05-16	2473	15	895	1563	draft
2217	Guinea	2020-05-16	2020-05-17	2658	16	1133	1509	draft
2218	Guinea	2020-05-17	2020-05-18	2658	16	1133	1509	draft
2219	Guinea	2020-05-18	2020-05-19	2796	16	1263	1517	draft
2220	Guinea	2020-05-19	2020-05-20	2863	18	1525	1320	draft
2221	Guinea	2020-05-20	2020-05-21	2863	18	1525	1320	draft
2222	Guinea	2020-05-21	2020-05-22	3067	18	1575	1474	draft
2223	Guinea	2020-05-22	2020-05-23	3067	19	1575	1473	draft
2224	Guinea	2020-05-23	2020-05-24	3176	20	1631	1525	draft
2225	Guinea	2020-05-24	2020-05-25	3275	20	1673	1582	draft
2226	Guinea	2020-05-25	2020-05-26	3275	20	1673	1582	draft
2227	Guinea	2020-05-26	2020-05-27	3275	20	1673	1582	draft
2228	Guinea	2020-05-27	2020-05-28	3275	20	1673	1582	draft
2229	Guinea	2020-05-28	2020-05-29	3553	22	1950	1581	draft
2230	Guinea	2020-05-29	2020-05-30	3656	22	2000	1634	draft
2231	Guinea	2020-05-30	2020-05-31	3706	23	2030	1653	draft
2232	Guinea	2020-05-31	2020-06-01	3706	23	2030	1653	draft
2233	Guinea-Bissau	2020-05-01	2020-05-02	257	1	19	237	draft
2234	Guinea-Bissau	2020-05-02	2020-05-03	257	1	19	237	draft
2235	Guinea-Bissau	2020-05-03	2020-05-04	257	1	19	237	draft
2236	Guinea-Bissau	2020-05-04	2020-05-05	413	1	19	393	draft
2237	Guinea-Bissau	2020-05-05	2020-05-06	413	1	19	393	draft
2238	Guinea-Bissau	2020-05-06	2020-05-07	475	2	24	449	draft
2239	Guinea-Bissau	2020-05-07	2020-05-08	564	2	25	537	draft
2240	Guinea-Bissau	2020-05-08	2020-05-09	594	2	25	567	draft
2241	Guinea-Bissau	2020-05-09	2020-05-10	641	3	25	613	draft
2242	Guinea-Bissau	2020-05-10	2020-05-11	726	3	26	697	draft
2243	Guinea-Bissau	2020-05-11	2020-05-12	761	3	26	732	draft
2244	Guinea-Bissau	2020-05-12	2020-05-13	820	3	26	791	draft
2245	Guinea-Bissau	2020-05-13	2020-05-14	836	3	26	807	draft
2246	Guinea-Bissau	2020-05-14	2020-05-15	913	3	26	884	draft
2247	Guinea-Bissau	2020-05-15	2020-05-16	913	3	26	884	draft
2248	Guinea-Bissau	2020-05-16	2020-05-17	969	4	26	939	draft
2249	Guinea-Bissau	2020-05-17	2020-05-18	990	4	26	960	draft
2250	Guinea-Bissau	2020-05-18	2020-05-19	1032	4	38	990	draft
2251	Guinea-Bissau	2020-05-19	2020-05-20	1038	6	42	990	draft
2252	Guinea-Bissau	2020-05-20	2020-05-21	1089	6	42	1041	draft
2253	Guinea-Bissau	2020-05-21	2020-05-22	1109	6	42	1061	draft
2601	Ireland	2020-05-28	2020-05-29	24841	1639	22089	1113	draft
2254	Guinea-Bissau	2020-05-22	2020-05-23	1114	6	42	1066	draft
2255	Guinea-Bissau	2020-05-23	2020-05-24	1114	6	42	1066	draft
2256	Guinea-Bissau	2020-05-24	2020-05-25	1114	6	42	1066	draft
2257	Guinea-Bissau	2020-05-25	2020-05-26	1178	7	42	1129	draft
2258	Guinea-Bissau	2020-05-26	2020-05-27	1178	7	42	1129	draft
2259	Guinea-Bissau	2020-05-27	2020-05-28	1195	7	42	1146	draft
2260	Guinea-Bissau	2020-05-28	2020-05-29	1195	8	42	1145	draft
2261	Guinea-Bissau	2020-05-29	2020-05-30	1256	8	42	1206	draft
2262	Guinea-Bissau	2020-05-30	2020-05-31	1256	8	42	1206	draft
2263	Guinea-Bissau	2020-05-31	2020-06-01	1256	8	42	1206	draft
2264	Guyana	2020-05-01	2020-05-02	82	9	22	51	draft
2265	Guyana	2020-05-02	2020-05-03	82	9	22	51	draft
2266	Guyana	2020-05-03	2020-05-04	82	9	22	51	draft
2267	Guyana	2020-05-04	2020-05-05	92	9	27	56	draft
2268	Guyana	2020-05-05	2020-05-06	93	10	27	56	draft
2269	Guyana	2020-05-06	2020-05-07	93	10	27	56	draft
2270	Guyana	2020-05-07	2020-05-08	93	10	27	56	draft
2271	Guyana	2020-05-08	2020-05-09	94	10	35	49	draft
2272	Guyana	2020-05-09	2020-05-10	94	10	35	49	draft
2273	Guyana	2020-05-10	2020-05-11	104	10	35	59	draft
2274	Guyana	2020-05-11	2020-05-12	109	10	36	63	draft
2275	Guyana	2020-05-12	2020-05-13	113	10	36	67	draft
2276	Guyana	2020-05-13	2020-05-14	113	10	41	62	draft
2277	Guyana	2020-05-14	2020-05-15	113	10	42	61	draft
2278	Guyana	2020-05-15	2020-05-16	116	10	43	63	draft
2279	Guyana	2020-05-16	2020-05-17	117	10	43	64	draft
2280	Guyana	2020-05-17	2020-05-18	117	10	43	64	draft
2281	Guyana	2020-05-18	2020-05-19	124	10	44	70	draft
2282	Guyana	2020-05-19	2020-05-20	125	10	46	69	draft
2283	Guyana	2020-05-20	2020-05-21	125	10	47	68	draft
2284	Guyana	2020-05-21	2020-05-22	127	10	57	60	draft
2285	Guyana	2020-05-22	2020-05-23	127	10	57	60	draft
2286	Guyana	2020-05-23	2020-05-24	127	10	58	59	draft
2287	Guyana	2020-05-24	2020-05-25	135	10	62	63	draft
2288	Guyana	2020-05-25	2020-05-26	137	11	62	64	draft
2289	Guyana	2020-05-26	2020-05-27	139	11	62	66	draft
2290	Guyana	2020-05-27	2020-05-28	139	11	67	61	draft
2291	Guyana	2020-05-28	2020-05-29	150	11	67	72	draft
2292	Guyana	2020-05-29	2020-05-30	150	11	67	72	draft
2293	Guyana	2020-05-30	2020-05-31	152	12	67	73	draft
2294	Guyana	2020-05-31	2020-06-01	153	12	70	71	draft
2295	Haiti	2020-05-01	2020-05-02	76	7	10	67	draft
2296	Haiti	2020-05-02	2020-05-03	81	8	10	67	draft
2297	Haiti	2020-05-03	2020-05-04	85	8	10	69	draft
2298	Haiti	2020-05-04	2020-05-05	85	8	10	79	draft
2299	Haiti	2020-05-05	2020-05-06	88	9	10	79	draft
2300	Haiti	2020-05-06	2020-05-07	100	11	10	79	draft
2301	Haiti	2020-05-07	2020-05-08	101	12	16	101	draft
2302	Haiti	2020-05-08	2020-05-09	108	12	17	117	draft
2303	Haiti	2020-05-09	2020-05-10	129	12	17	122	draft
2304	Haiti	2020-05-10	2020-05-11	146	12	17	150	draft
2305	Haiti	2020-05-11	2020-05-12	151	12	17	176	draft
2306	Haiti	2020-05-12	2020-05-13	182	15	17	184	draft
2307	Haiti	2020-05-13	2020-05-14	209	16	17	199	draft
2308	Haiti	2020-05-14	2020-05-15	219	18	18	235	draft
2309	Haiti	2020-05-15	2020-05-16	234	18	29	261	draft
2310	Haiti	2020-05-16	2020-05-17	273	20	29	309	draft
2311	Haiti	2020-05-17	2020-05-18	310	20	21	415	draft
2312	Haiti	2020-05-18	2020-05-19	358	20	21	491	draft
2313	Haiti	2020-05-19	2020-05-20	456	20	21	491	draft
2314	Haiti	2020-05-20	2020-05-21	533	21	21	553	draft
2315	Haiti	2020-05-21	2020-05-22	596	22	21	688	draft
2316	Haiti	2020-05-22	2020-05-23	663	22	22	765	draft
2317	Haiti	2020-05-23	2020-05-24	734	25	22	817	draft
2318	Haiti	2020-05-24	2020-05-25	812	25	22	817	draft
2319	Haiti	2020-05-25	2020-05-26	865	26	22	909	draft
2320	Haiti	2020-05-26	2020-05-27	958	27	22	1119	draft
2321	Haiti	2020-05-27	2020-05-28	1063	31	22	1264	draft
2322	Haiti	2020-05-28	2020-05-29	1174	33	22	1264	draft
2323	Haiti	2020-05-29	2020-05-30	1320	34	22	1527	draft
2324	Haiti	2020-05-30	2020-05-31	1443	35	24	1800	draft
2325	Haiti	2020-05-31	2020-06-01	1584	35	24	2056	draft
2326	Holy See	2020-05-01	2020-05-02	11	0	2	9	draft
2327	Holy See	2020-05-02	2020-05-03	11	0	2	9	draft
2328	Holy See	2020-05-03	2020-05-04	11	0	2	9	draft
2329	Holy See	2020-05-04	2020-05-05	11	0	2	9	draft
2330	Holy See	2020-05-05	2020-05-06	11	0	2	9	draft
2331	Holy See	2020-05-06	2020-05-07	12	0	2	10	draft
2332	Holy See	2020-05-07	2020-05-08	12	0	2	10	draft
2333	Holy See	2020-05-08	2020-05-09	12	0	2	10	draft
2334	Holy See	2020-05-09	2020-05-10	12	0	2	10	draft
2335	Holy See	2020-05-10	2020-05-11	12	0	2	10	draft
2336	Holy See	2020-05-11	2020-05-12	12	0	2	10	draft
2337	Holy See	2020-05-12	2020-05-13	12	0	2	10	draft
2338	Holy See	2020-05-13	2020-05-14	12	0	2	10	draft
2339	Holy See	2020-05-14	2020-05-15	12	0	2	10	draft
2340	Holy See	2020-05-15	2020-05-16	12	0	2	10	draft
2341	Holy See	2020-05-16	2020-05-17	12	0	2	10	draft
2342	Holy See	2020-05-17	2020-05-18	12	0	2	10	draft
2343	Holy See	2020-05-18	2020-05-19	12	0	2	10	draft
2344	Holy See	2020-05-19	2020-05-20	12	0	2	10	draft
2345	Holy See	2020-05-20	2020-05-21	12	0	2	10	draft
2346	Holy See	2020-05-21	2020-05-22	12	0	2	10	draft
2347	Holy See	2020-05-22	2020-05-23	12	0	2	10	draft
2348	Holy See	2020-05-23	2020-05-24	12	0	2	10	draft
2349	Holy See	2020-05-24	2020-05-25	12	0	2	10	draft
2350	Holy See	2020-05-25	2020-05-26	12	0	2	10	draft
2351	Holy See	2020-05-26	2020-05-27	12	0	2	10	draft
2352	Holy See	2020-05-27	2020-05-28	12	0	2	10	draft
2353	Holy See	2020-05-28	2020-05-29	12	0	2	10	draft
2354	Holy See	2020-05-29	2020-05-30	12	0	2	10	draft
2355	Holy See	2020-05-30	2020-05-31	12	0	2	10	draft
2356	Holy See	2020-05-31	2020-06-01	12	0	2	10	draft
2357	Honduras	2020-05-01	2020-05-02	804	75	112	617	draft
2358	Honduras	2020-05-02	2020-05-03	1010	76	116	818	draft
2359	Honduras	2020-05-03	2020-05-04	1055	82	118	855	draft
2360	Honduras	2020-05-04	2020-05-05	1178	83	122	973	draft
2361	Honduras	2020-05-05	2020-05-06	1270	93	122	1055	draft
2362	Honduras	2020-05-06	2020-05-07	1461	99	132	1230	draft
2363	Honduras	2020-05-07	2020-05-08	1685	105	154	1426	draft
2364	Honduras	2020-05-08	2020-05-09	1771	107	192	1472	draft
2365	Honduras	2020-05-09	2020-05-10	1830	108	195	1527	draft
2366	Honduras	2020-05-10	2020-05-11	1972	108	203	1661	draft
2367	Honduras	2020-05-11	2020-05-12	2100	116	206	1778	draft
2368	Honduras	2020-05-12	2020-05-13	2080	121	211	1748	draft
2369	Honduras	2020-05-13	2020-05-14	2255	123	237	1895	draft
2370	Honduras	2020-05-14	2020-05-15	2318	133	253	1932	draft
2371	Honduras	2020-05-15	2020-05-16	2460	134	264	2062	draft
2372	Honduras	2020-05-16	2020-05-17	2565	138	278	2149	draft
2373	Honduras	2020-05-17	2020-05-18	2646	142	319	2185	draft
2374	Honduras	2020-05-18	2020-05-19	2798	146	340	2312	draft
2375	Honduras	2020-05-19	2020-05-20	2955	147	349	2459	draft
2376	Honduras	2020-05-20	2020-05-21	2955	147	349	2459	draft
2377	Honduras	2020-05-21	2020-05-22	3204	156	397	2651	draft
2378	Honduras	2020-05-22	2020-05-23	3477	167	439	2871	draft
2379	Honduras	2020-05-23	2020-05-24	3477	167	439	2871	draft
2380	Honduras	2020-05-24	2020-05-25	3950	180	468	3302	draft
2381	Honduras	2020-05-25	2020-05-26	4189	182	473	3534	draft
2382	Honduras	2020-05-26	2020-05-27	4401	188	493	3720	draft
2383	Honduras	2020-05-27	2020-05-28	4640	194	506	3940	draft
2384	Honduras	2020-05-28	2020-05-29	4752	196	519	4037	draft
2385	Honduras	2020-05-29	2020-05-30	4752	196	519	4037	draft
2386	Honduras	2020-05-30	2020-05-31	5094	201	536	4357	draft
2387	Honduras	2020-05-31	2020-06-01	5202	212	537	4453	draft
2388	Hungary	2020-05-01	2020-05-02	2863	323	609	1931	draft
2389	Hungary	2020-05-02	2020-05-03	2942	335	625	1982	draft
2390	Hungary	2020-05-03	2020-05-04	2998	340	629	2029	draft
2391	Hungary	2020-05-04	2020-05-05	3035	351	630	2054	draft
2392	Hungary	2020-05-05	2020-05-06	3065	363	709	1993	draft
2393	Hungary	2020-05-06	2020-05-07	3111	373	759	1979	draft
2394	Hungary	2020-05-07	2020-05-08	3150	383	801	1966	draft
2395	Hungary	2020-05-08	2020-05-09	3178	392	865	1921	draft
2396	Hungary	2020-05-09	2020-05-10	3213	405	904	1904	draft
2397	Hungary	2020-05-10	2020-05-11	3263	413	933	1917	draft
2398	Hungary	2020-05-11	2020-05-12	3284	421	958	1905	draft
2399	Hungary	2020-05-12	2020-05-13	3313	425	1007	1881	draft
2400	Hungary	2020-05-13	2020-05-14	3341	430	1102	1809	draft
2401	Hungary	2020-05-14	2020-05-15	3380	436	1169	1775	draft
2402	Hungary	2020-05-15	2020-05-16	3417	442	1287	1688	draft
2403	Hungary	2020-05-16	2020-05-17	3473	448	1371	1654	draft
2404	Hungary	2020-05-17	2020-05-18	3509	451	1396	1662	draft
2405	Hungary	2020-05-18	2020-05-19	3535	462	1400	1673	draft
2406	Hungary	2020-05-19	2020-05-20	3556	467	1412	1677	draft
2407	Hungary	2020-05-20	2020-05-21	3598	470	1454	1674	draft
2408	Hungary	2020-05-21	2020-05-22	3641	473	1509	1659	draft
2409	Hungary	2020-05-22	2020-05-23	3678	476	1587	1615	draft
2410	Hungary	2020-05-23	2020-05-24	3713	482	1655	1576	draft
2411	Hungary	2020-05-24	2020-05-25	3741	486	1690	1565	draft
2412	Hungary	2020-05-25	2020-05-26	3756	491	1711	1554	draft
2413	Hungary	2020-05-26	2020-05-27	3771	499	1836	1436	draft
2414	Hungary	2020-05-27	2020-05-28	3793	505	1856	1432	draft
2415	Hungary	2020-05-28	2020-05-29	3816	509	1996	1311	draft
2416	Hungary	2020-05-29	2020-05-30	3841	517	2024	1300	draft
2417	Hungary	2020-05-30	2020-05-31	3867	524	2142	1201	draft
2418	Hungary	2020-05-31	2020-06-01	3876	526	2147	1203	draft
2419	Iceland	2020-05-01	2020-05-02	1798	10	1689	99	draft
2420	Iceland	2020-05-02	2020-05-03	1798	10	1706	82	draft
2421	Iceland	2020-05-03	2020-05-04	1799	10	1717	72	draft
2422	Iceland	2020-05-04	2020-05-05	1799	10	1723	66	draft
2423	Iceland	2020-05-05	2020-05-06	1799	10	1733	56	draft
2424	Iceland	2020-05-06	2020-05-07	1799	10	1750	39	draft
2425	Iceland	2020-05-07	2020-05-08	1801	10	1755	36	draft
2426	Iceland	2020-05-08	2020-05-09	1801	10	1765	26	draft
2427	Iceland	2020-05-09	2020-05-10	1801	10	1773	18	draft
2428	Iceland	2020-05-10	2020-05-11	1801	10	1773	18	draft
2429	Iceland	2020-05-11	2020-05-12	1801	10	1773	18	draft
2430	Iceland	2020-05-12	2020-05-13	1801	10	1776	15	draft
2431	Iceland	2020-05-13	2020-05-14	1802	10	1780	12	draft
2432	Iceland	2020-05-14	2020-05-15	1802	10	1780	12	draft
2433	Iceland	2020-05-15	2020-05-16	1802	10	1782	10	draft
2434	Iceland	2020-05-16	2020-05-17	1802	10	1786	6	draft
2435	Iceland	2020-05-17	2020-05-18	1802	10	1786	6	draft
2436	Iceland	2020-05-18	2020-05-19	1802	10	1786	6	draft
2437	Iceland	2020-05-19	2020-05-20	1802	10	1789	3	draft
2438	Iceland	2020-05-20	2020-05-21	1803	10	1789	4	draft
2439	Iceland	2020-05-21	2020-05-22	1803	10	1790	3	draft
2440	Iceland	2020-05-22	2020-05-23	1803	10	1791	2	draft
2441	Iceland	2020-05-23	2020-05-24	1804	10	1791	3	draft
2442	Iceland	2020-05-24	2020-05-25	1804	10	1791	3	draft
2443	Iceland	2020-05-25	2020-05-26	1804	10	1791	3	draft
2444	Iceland	2020-05-26	2020-05-27	1804	10	1792	2	draft
2445	Iceland	2020-05-27	2020-05-28	1805	10	1792	3	draft
2446	Iceland	2020-05-28	2020-05-29	1805	10	1792	3	draft
2447	Iceland	2020-05-29	2020-05-30	1805	10	1794	1	draft
2448	Iceland	2020-05-30	2020-05-31	1806	10	1794	2	draft
2449	Iceland	2020-05-31	2020-06-01	1806	10	1794	2	draft
2450	India	2020-05-01	2020-05-02	37257	1223	10007	26027	draft
2451	India	2020-05-02	2020-05-03	39699	1323	10819	27557	draft
2452	India	2020-05-03	2020-05-04	42505	1391	11775	29339	draft
2453	India	2020-05-04	2020-05-05	46437	1566	12847	32024	draft
2454	India	2020-05-05	2020-05-06	49400	1693	14142	33565	draft
2455	India	2020-05-06	2020-05-07	52987	1785	15331	35871	draft
2456	India	2020-05-07	2020-05-08	56351	1889	16776	37686	draft
2457	India	2020-05-08	2020-05-09	59695	1985	17887	39823	draft
2458	India	2020-05-09	2020-05-10	62808	2101	19301	41406	draft
2459	India	2020-05-10	2020-05-11	67161	2212	20969	43980	draft
2460	India	2020-05-11	2020-05-12	70768	2294	22549	45925	draft
2461	India	2020-05-12	2020-05-13	74292	2415	24420	47457	draft
2462	India	2020-05-13	2020-05-14	78055	2551	26400	49104	draft
2463	India	2020-05-14	2020-05-15	81997	2649	27969	51379	draft
2464	India	2020-05-15	2020-05-16	85784	2753	30258	52773	draft
2465	India	2020-05-16	2020-05-17	90648	2871	34224	53553	draft
2466	India	2020-05-17	2020-05-18	95698	3025	36795	55878	draft
2467	India	2020-05-18	2020-05-19	100328	3156	39233	57939	draft
2468	India	2020-05-19	2020-05-20	106475	3302	42309	60864	draft
2469	India	2020-05-20	2020-05-21	112028	3434	45422	63172	draft
2470	India	2020-05-21	2020-05-22	118226	3584	48553	66089	draft
2471	India	2020-05-22	2020-05-23	124794	3726	51824	69244	draft
2472	India	2020-05-23	2020-05-24	131423	3868	54385	73170	draft
2473	India	2020-05-24	2020-05-25	138536	4024	57692	76820	draft
2474	India	2020-05-25	2020-05-26	144950	4172	60706	80072	draft
2475	India	2020-05-26	2020-05-27	150793	4344	64277	82172	draft
2476	India	2020-05-27	2020-05-28	158086	4534	67749	85803	draft
2477	India	2020-05-28	2020-05-29	165386	4711	70920	89755	draft
2478	India	2020-05-29	2020-05-30	173491	4980	82627	85884	draft
2479	India	2020-05-30	2020-05-31	181827	5185	86936	89706	draft
2480	India	2020-05-31	2020-06-01	190609	5408	91852	93349	draft
2481	Indonesia	2020-05-01	2020-05-02	10551	800	1591	8160	draft
2482	Indonesia	2020-05-02	2020-05-03	10843	831	1665	8347	draft
2483	Indonesia	2020-05-03	2020-05-04	11192	845	1876	8471	draft
2484	Indonesia	2020-05-04	2020-05-05	11587	864	1954	8769	draft
2485	Indonesia	2020-05-05	2020-05-06	12071	872	2197	9002	draft
2486	Indonesia	2020-05-06	2020-05-07	12438	895	2317	9226	draft
2487	Indonesia	2020-05-07	2020-05-08	12776	930	2381	9465	draft
2488	Indonesia	2020-05-08	2020-05-09	13112	943	2494	9675	draft
2489	Indonesia	2020-05-09	2020-05-10	13645	959	2607	10079	draft
2490	Indonesia	2020-05-10	2020-05-11	14032	973	2698	10361	draft
2491	Indonesia	2020-05-11	2020-05-12	14265	991	2881	10393	draft
2492	Indonesia	2020-05-12	2020-05-13	14749	1007	3063	10679	draft
2493	Indonesia	2020-05-13	2020-05-14	15438	1028	3287	11123	draft
2494	Indonesia	2020-05-14	2020-05-15	16006	1043	3518	11445	draft
2495	Indonesia	2020-05-15	2020-05-16	16496	1076	3803	11617	draft
2496	Indonesia	2020-05-16	2020-05-17	17025	1089	3911	12025	draft
2497	Indonesia	2020-05-17	2020-05-18	17514	1148	4129	12237	draft
2498	Indonesia	2020-05-18	2020-05-19	18010	1191	4324	12495	draft
2499	Indonesia	2020-05-19	2020-05-20	18496	1221	4467	12808	draft
2500	Indonesia	2020-05-20	2020-05-21	19189	1242	4575	13372	draft
2501	Indonesia	2020-05-21	2020-05-22	20162	1278	4838	14046	draft
2502	Indonesia	2020-05-22	2020-05-23	20796	1326	5057	14413	draft
2503	Indonesia	2020-05-23	2020-05-24	21745	1351	5249	15145	draft
2504	Indonesia	2020-05-24	2020-05-25	22271	1372	5402	15497	draft
2505	Indonesia	2020-05-25	2020-05-26	22750	1391	5642	15717	draft
2506	Indonesia	2020-05-26	2020-05-27	23165	1418	5877	15870	draft
2507	Indonesia	2020-05-27	2020-05-28	23851	1473	6057	16321	draft
2508	Indonesia	2020-05-28	2020-05-29	24538	1496	6240	16802	draft
2509	Indonesia	2020-05-29	2020-05-30	25216	1520	6492	17204	draft
2510	Indonesia	2020-05-30	2020-05-31	25773	1573	7015	17185	draft
2511	Indonesia	2020-05-31	2020-06-01	26473	1613	7308	17552	draft
2512	Iran	2020-05-01	2020-05-02	95646	6091	76318	13237	draft
2513	Iran	2020-05-02	2020-05-03	96448	6156	77350	12942	draft
2514	Iran	2020-05-03	2020-05-04	97424	6203	78422	12799	draft
2515	Iran	2020-05-04	2020-05-05	98647	6277	79379	12991	draft
2516	Iran	2020-05-05	2020-05-06	99970	6340	80475	13155	draft
2517	Iran	2020-05-06	2020-05-07	101650	6418	81587	13645	draft
2518	Iran	2020-05-07	2020-05-08	103135	6486	82744	13905	draft
2519	Iran	2020-05-08	2020-05-09	104691	6541	83837	14313	draft
2520	Iran	2020-05-09	2020-05-10	106220	6589	85064	14567	draft
2521	Iran	2020-05-10	2020-05-11	107603	6640	86143	14820	draft
2522	Iran	2020-05-11	2020-05-12	109286	6685	87422	15179	draft
2523	Iran	2020-05-12	2020-05-13	110767	6733	88357	15677	draft
2524	Iran	2020-05-13	2020-05-14	112725	6783	89428	16514	draft
2525	Iran	2020-05-14	2020-05-15	114533	6854	90539	17140	draft
2526	Iran	2020-05-15	2020-05-16	116635	6902	91836	17897	draft
2527	Iran	2020-05-16	2020-05-17	118392	6937	93147	18308	draft
2528	Iran	2020-05-17	2020-05-18	120198	6988	94464	18746	draft
2529	Iran	2020-05-18	2020-05-19	122492	7057	95661	19774	draft
2530	Iran	2020-05-19	2020-05-20	124603	7119	97173	20311	draft
2531	Iran	2020-05-20	2020-05-21	126949	7183	98808	20958	draft
2532	Iran	2020-05-21	2020-05-22	129341	7249	100564	21528	draft
2533	Iran	2020-05-22	2020-05-23	131652	7300	102276	22076	draft
2534	Iran	2020-05-23	2020-05-24	133521	7359	104072	22090	draft
2535	Iran	2020-05-24	2020-05-25	135701	7417	105801	22483	draft
2536	Iran	2020-05-25	2020-05-26	137724	7451	107713	22560	draft
2537	Iran	2020-05-26	2020-05-27	139511	7508	109437	22566	draft
2538	Iran	2020-05-27	2020-05-28	141591	7564	111176	22851	draft
2539	Iran	2020-05-28	2020-05-29	143849	7627	112988	23234	draft
2540	Iran	2020-05-29	2020-05-30	146668	7677	114931	24060	draft
2541	Iran	2020-05-30	2020-05-31	148950	7734	116827	24389	draft
2542	Iran	2020-05-31	2020-06-01	151466	7797	118848	24821	draft
2543	Iraq	2020-05-01	2020-05-02	2153	94	1414	645	draft
2544	Iraq	2020-05-02	2020-05-03	2219	95	1473	651	draft
2545	Iraq	2020-05-03	2020-05-04	2296	97	1490	709	draft
2546	Iraq	2020-05-04	2020-05-05	2346	98	1544	704	draft
2547	Iraq	2020-05-05	2020-05-06	2431	102	1571	758	draft
2548	Iraq	2020-05-06	2020-05-07	2480	102	1602	776	draft
2549	Iraq	2020-05-07	2020-05-08	2543	102	1626	815	draft
2550	Iraq	2020-05-08	2020-05-09	2603	104	1661	838	draft
2551	Iraq	2020-05-09	2020-05-10	2679	107	1702	870	draft
2552	Iraq	2020-05-10	2020-05-11	2767	109	1734	924	draft
2553	Iraq	2020-05-11	2020-05-12	2818	110	1790	918	draft
2554	Iraq	2020-05-12	2020-05-13	2913	112	1903	898	draft
2555	Iraq	2020-05-13	2020-05-14	3032	115	1966	951	draft
2556	Iraq	2020-05-14	2020-05-15	3143	115	2028	1000	draft
2557	Iraq	2020-05-15	2020-05-16	3193	117	2089	987	draft
2558	Iraq	2020-05-16	2020-05-17	3260	121	2126	1013	draft
2559	Iraq	2020-05-17	2020-05-18	3404	123	2218	1063	draft
2560	Iraq	2020-05-18	2020-05-19	3554	127	2310	1117	draft
2561	Iraq	2020-05-19	2020-05-20	3611	131	2366	1114	draft
2562	Iraq	2020-05-20	2020-05-21	3724	134	2438	1152	draft
2563	Iraq	2020-05-21	2020-05-22	3877	140	2483	1254	draft
2564	Iraq	2020-05-22	2020-05-23	3964	147	2532	1285	draft
2565	Iraq	2020-05-23	2020-05-24	4272	152	2585	1535	draft
2566	Iraq	2020-05-24	2020-05-25	4469	160	2738	1571	draft
2567	Iraq	2020-05-25	2020-05-26	4632	163	2811	1658	draft
2568	Iraq	2020-05-26	2020-05-27	4848	169	2852	1827	draft
2569	Iraq	2020-05-27	2020-05-28	5135	175	2904	2056	draft
2570	Iraq	2020-05-28	2020-05-29	5457	179	2971	2307	draft
2571	Iraq	2020-05-29	2020-05-30	5873	185	3044	2644	draft
2572	Iraq	2020-05-30	2020-05-31	6179	195	3110	2874	draft
2573	Iraq	2020-05-31	2020-06-01	6439	205	3156	3078	draft
2574	Ireland	2020-05-01	2020-05-02	20833	1265	13386	6182	draft
2575	Ireland	2020-05-02	2020-05-03	21176	1286	13386	6504	draft
2576	Ireland	2020-05-03	2020-05-04	21506	1303	13386	6817	draft
2577	Ireland	2020-05-04	2020-05-05	21772	1319	13386	7067	draft
2578	Ireland	2020-05-05	2020-05-06	21983	1339	13386	7258	draft
2579	Ireland	2020-05-06	2020-05-07	22248	1375	17110	3763	draft
2580	Ireland	2020-05-07	2020-05-08	22385	1403	17110	3872	draft
2581	Ireland	2020-05-08	2020-05-09	22541	1429	17110	4002	draft
2582	Ireland	2020-05-09	2020-05-10	22760	1446	17110	4204	draft
2583	Ireland	2020-05-10	2020-05-11	22996	1458	17110	4428	draft
2584	Ireland	2020-05-11	2020-05-12	23135	1467	17110	4558	draft
2585	Ireland	2020-05-12	2020-05-13	23242	1488	17110	4644	draft
2586	Ireland	2020-05-13	2020-05-14	23401	1497	19470	2434	draft
2587	Ireland	2020-05-14	2020-05-15	23827	1506	19470	2851	draft
2588	Ireland	2020-05-15	2020-05-16	23956	1518	19470	2968	draft
2589	Ireland	2020-05-16	2020-05-17	24048	1533	19470	3045	draft
2590	Ireland	2020-05-17	2020-05-18	24112	1543	19470	3099	draft
2591	Ireland	2020-05-18	2020-05-19	24200	1547	19470	3183	draft
2592	Ireland	2020-05-19	2020-05-20	24251	1561	19470	3220	draft
2593	Ireland	2020-05-20	2020-05-21	24315	1571	21060	1684	draft
2594	Ireland	2020-05-21	2020-05-22	24391	1583	21060	1748	draft
2595	Ireland	2020-05-22	2020-05-23	24506	1592	21060	1854	draft
2596	Ireland	2020-05-23	2020-05-24	24582	1604	21060	1918	draft
2597	Ireland	2020-05-24	2020-05-25	24639	1608	21060	1971	draft
2598	Ireland	2020-05-25	2020-05-26	24698	1606	21060	2032	draft
2599	Ireland	2020-05-26	2020-05-27	24735	1615	21060	2060	draft
2600	Ireland	2020-05-27	2020-05-28	24803	1631	22089	1083	draft
2602	Ireland	2020-05-29	2020-05-30	24876	1645	22089	1142	draft
2603	Ireland	2020-05-30	2020-05-31	24929	1651	22089	1189	draft
2604	Ireland	2020-05-31	2020-06-01	24990	1652	22089	1249	draft
2605	Israel	2020-05-01	2020-05-02	16012	229	9393	6720	draft
2606	Israel	2020-05-02	2020-05-03	16069	232	9611	6363	draft
2607	Israel	2020-05-03	2020-05-04	16096	235	9945	6227	draft
2608	Israel	2020-05-04	2020-05-05	16149	238	10233	5947	draft
2609	Israel	2020-05-05	2020-05-06	16181	240	10561	5586	draft
2610	Israel	2020-05-06	2020-05-07	16246	241	10843	5434	draft
2611	Israel	2020-05-07	2020-05-08	16307	242	11103	5268	draft
2612	Israel	2020-05-08	2020-05-09	16340	248	11318	4962	draft
2613	Israel	2020-05-09	2020-05-10	16359	251	11402	4831	draft
2614	Israel	2020-05-10	2020-05-11	16388	255	11649	4795	draft
2615	Israel	2020-05-11	2020-05-12	16427	260	11940	4405	draft
2616	Israel	2020-05-12	2020-05-13	16450	263	12195	4186	draft
2617	Israel	2020-05-13	2020-05-14	16489	266	12398	4052	draft
2618	Israel	2020-05-14	2020-05-15	16511	268	12648	3793	draft
2619	Israel	2020-05-15	2020-05-16	16523	268	12793	3736	draft
2620	Israel	2020-05-16	2020-05-17	16528	271	12880	3485	draft
2621	Israel	2020-05-17	2020-05-18	16543	275	13062	3403	draft
2622	Israel	2020-05-18	2020-05-19	16570	278	13346	3114	draft
2623	Israel	2020-05-19	2020-05-20	16592	280	13485	2946	draft
2624	Israel	2020-05-20	2020-05-21	16607	281	13613	2884	draft
2625	Israel	2020-05-21	2020-05-22	16624	281	13780	2680	draft
2626	Israel	2020-05-22	2020-05-23	16643	281	13925	2496	draft
2627	Israel	2020-05-23	2020-05-24	16648	281	13976	2343	draft
2628	Israel	2020-05-24	2020-05-25	16661	282	14121	2285	draft
2629	Israel	2020-05-25	2020-05-26	16683	284	14252	2146	draft
2630	Israel	2020-05-26	2020-05-27	16733	284	14352	2019	draft
2631	Israel	2020-05-27	2020-05-28	16773	286	14414	1942	draft
2632	Israel	2020-05-28	2020-05-29	16850	287	14532	1909	draft
2633	Israel	2020-05-29	2020-05-30	16963	287	14568	1927	draft
2634	Israel	2020-05-30	2020-05-31	16992	287	14608	1917	draft
2635	Israel	2020-05-31	2020-06-01	17079	287	14675	1974	draft
2636	Italy	2020-05-01	2020-05-02	207428	28236	78249	100943	draft
2637	Italy	2020-05-02	2020-05-03	209328	28710	79914	100704	draft
2638	Italy	2020-05-03	2020-05-04	210717	28884	81654	100179	draft
2639	Italy	2020-05-04	2020-05-05	211938	29079	82879	99980	draft
2640	Italy	2020-05-05	2020-05-06	213013	29315	85231	98467	draft
2641	Italy	2020-05-06	2020-05-07	214457	29684	93245	91528	draft
2642	Italy	2020-05-07	2020-05-08	215858	29958	96276	89624	draft
2643	Italy	2020-05-08	2020-05-09	217185	30201	99023	87961	draft
2644	Italy	2020-05-09	2020-05-10	218268	30395	103031	84842	draft
2645	Italy	2020-05-10	2020-05-11	219070	30560	105186	83324	draft
2646	Italy	2020-05-11	2020-05-12	219814	30739	106587	82488	draft
2647	Italy	2020-05-12	2020-05-13	221216	30911	109039	81266	draft
2648	Italy	2020-05-13	2020-05-14	222104	31106	112541	78457	draft
2649	Italy	2020-05-14	2020-05-15	223096	31368	115288	76440	draft
2650	Italy	2020-05-15	2020-05-16	223885	31610	120205	72070	draft
2651	Italy	2020-05-16	2020-05-17	224760	31763	122810	70187	draft
2652	Italy	2020-05-17	2020-05-18	225435	31908	125176	68351	draft
2653	Italy	2020-05-18	2020-05-19	225886	32007	127326	66553	draft
2654	Italy	2020-05-19	2020-05-20	226699	32169	129401	65129	draft
2655	Italy	2020-05-20	2020-05-21	227364	32330	132282	62752	draft
2656	Italy	2020-05-21	2020-05-22	228006	32486	134560	60960	draft
2657	Italy	2020-05-22	2020-05-23	228658	32616	136720	59322	draft
2658	Italy	2020-05-23	2020-05-24	229327	32735	138840	57752	draft
2659	Italy	2020-05-24	2020-05-25	229858	32785	140479	56594	draft
2660	Italy	2020-05-25	2020-05-26	230158	32877	141981	55300	draft
2661	Italy	2020-05-26	2020-05-27	230555	32955	144658	52942	draft
2662	Italy	2020-05-27	2020-05-28	231139	33072	147101	50966	draft
2663	Italy	2020-05-28	2020-05-29	231732	33142	150604	47986	draft
2664	Italy	2020-05-29	2020-05-30	232248	33229	152844	46175	draft
2665	Italy	2020-05-30	2020-05-31	232664	33340	155633	43691	draft
2666	Italy	2020-05-31	2020-06-01	232997	33415	157507	42075	draft
2667	Jamaica	2020-05-01	2020-05-02	432	8	31	393	draft
2668	Jamaica	2020-05-02	2020-05-03	463	8	33	422	draft
2669	Jamaica	2020-05-03	2020-05-04	469	9	38	422	draft
2670	Jamaica	2020-05-04	2020-05-05	471	9	38	424	draft
2671	Jamaica	2020-05-05	2020-05-06	473	9	56	408	draft
2672	Jamaica	2020-05-06	2020-05-07	478	9	57	412	draft
2673	Jamaica	2020-05-07	2020-05-08	488	9	58	421	draft
2674	Jamaica	2020-05-08	2020-05-09	490	9	62	419	draft
2675	Jamaica	2020-05-09	2020-05-10	490	9	62	419	draft
2676	Jamaica	2020-05-10	2020-05-11	502	9	90	403	draft
2677	Jamaica	2020-05-11	2020-05-12	505	9	90	406	draft
2678	Jamaica	2020-05-12	2020-05-13	507	9	100	398	draft
2679	Jamaica	2020-05-13	2020-05-14	509	9	113	387	draft
2680	Jamaica	2020-05-14	2020-05-15	509	9	118	382	draft
2681	Jamaica	2020-05-15	2020-05-16	511	9	121	381	draft
2682	Jamaica	2020-05-16	2020-05-17	517	9	121	387	draft
2683	Jamaica	2020-05-17	2020-05-18	520	9	127	384	draft
2684	Jamaica	2020-05-18	2020-05-19	520	9	131	380	draft
2685	Jamaica	2020-05-19	2020-05-20	520	9	145	366	draft
2686	Jamaica	2020-05-20	2020-05-21	529	9	171	349	draft
2687	Jamaica	2020-05-21	2020-05-22	534	9	181	344	draft
2688	Jamaica	2020-05-22	2020-05-23	544	9	191	344	draft
2689	Jamaica	2020-05-23	2020-05-24	550	9	200	341	draft
2690	Jamaica	2020-05-24	2020-05-25	552	9	211	332	draft
2691	Jamaica	2020-05-25	2020-05-26	556	9	238	309	draft
2692	Jamaica	2020-05-26	2020-05-27	564	9	267	288	draft
2693	Jamaica	2020-05-27	2020-05-28	569	9	279	281	draft
2694	Jamaica	2020-05-28	2020-05-29	569	9	284	276	draft
2695	Jamaica	2020-05-29	2020-05-30	575	9	289	277	draft
2696	Jamaica	2020-05-30	2020-05-31	581	9	290	282	draft
2697	Jamaica	2020-05-31	2020-06-01	586	9	311	266	draft
2698	Japan	2020-05-01	2020-05-02	14305	455	2975	10875	draft
2699	Japan	2020-05-02	2020-05-03	14571	474	3205	10892	draft
2700	Japan	2020-05-03	2020-05-04	14877	487	3981	10409	draft
2701	Japan	2020-05-04	2020-05-05	15078	536	4156	10386	draft
2702	Japan	2020-05-05	2020-05-06	15253	556	4496	10201	draft
2703	Japan	2020-05-06	2020-05-07	15253	556	4496	10201	draft
2704	Japan	2020-05-07	2020-05-08	15477	577	4918	9982	draft
2705	Japan	2020-05-08	2020-05-09	15575	590	5146	9839	draft
2706	Japan	2020-05-09	2020-05-10	15663	607	5906	9150	draft
2707	Japan	2020-05-10	2020-05-11	15777	624	8127	7026	draft
2708	Japan	2020-05-11	2020-05-12	15847	633	8293	6921	draft
2709	Japan	2020-05-12	2020-05-13	15968	657	8531	6780	draft
2710	Japan	2020-05-13	2020-05-14	16049	678	8920	6451	draft
2711	Japan	2020-05-14	2020-05-15	16120	697	9868	5555	draft
2712	Japan	2020-05-15	2020-05-16	16203	713	10338	5152	draft
2713	Japan	2020-05-16	2020-05-17	16237	725	10338	5174	draft
2714	Japan	2020-05-17	2020-05-18	16285	744	11153	4388	draft
2715	Japan	2020-05-18	2020-05-19	16305	749	11564	3992	draft
2716	Japan	2020-05-19	2020-05-20	16367	768	11564	4035	draft
2717	Japan	2020-05-20	2020-05-21	16367	768	11564	4035	draft
2718	Japan	2020-05-21	2020-05-22	16424	777	12672	2975	draft
2719	Japan	2020-05-22	2020-05-23	16513	796	13005	2712	draft
2720	Japan	2020-05-23	2020-05-24	16536	808	13244	2484	draft
2721	Japan	2020-05-24	2020-05-25	16550	820	13413	2317	draft
2722	Japan	2020-05-25	2020-05-26	16581	830	13612	2139	draft
2723	Japan	2020-05-26	2020-05-27	16623	846	13810	1967	draft
2724	Japan	2020-05-27	2020-05-28	16651	858	13973	1820	draft
2725	Japan	2020-05-28	2020-05-29	16598	881	14096	1621	draft
2726	Japan	2020-05-29	2020-05-30	16673	887	14213	1573	draft
2727	Japan	2020-05-30	2020-05-31	16716	894	14267	1555	draft
2728	Japan	2020-05-31	2020-06-01	16751	898	14342	1511	draft
2729	Jordan	2020-05-01	2020-05-02	459	8	364	87	draft
2730	Jordan	2020-05-02	2020-05-03	460	9	367	84	draft
2731	Jordan	2020-05-03	2020-05-04	461	9	367	85	draft
2732	Jordan	2020-05-04	2020-05-05	465	9	370	86	draft
2733	Jordan	2020-05-05	2020-05-06	471	9	375	87	draft
2734	Jordan	2020-05-06	2020-05-07	473	9	377	87	draft
2735	Jordan	2020-05-07	2020-05-08	494	9	381	104	draft
2736	Jordan	2020-05-08	2020-05-09	508	9	385	114	draft
2737	Jordan	2020-05-09	2020-05-10	522	9	387	126	draft
2738	Jordan	2020-05-10	2020-05-11	540	9	389	142	draft
2739	Jordan	2020-05-11	2020-05-12	562	9	390	163	draft
2740	Jordan	2020-05-12	2020-05-13	576	9	390	177	draft
2741	Jordan	2020-05-13	2020-05-14	582	9	392	181	draft
2742	Jordan	2020-05-14	2020-05-15	586	9	393	184	draft
2743	Jordan	2020-05-15	2020-05-16	596	9	401	186	draft
2744	Jordan	2020-05-16	2020-05-17	607	9	404	194	draft
2745	Jordan	2020-05-17	2020-05-18	613	9	408	196	draft
2746	Jordan	2020-05-18	2020-05-19	629	9	413	207	draft
2747	Jordan	2020-05-19	2020-05-20	649	9	417	223	draft
2748	Jordan	2020-05-20	2020-05-21	672	9	446	217	draft
2749	Jordan	2020-05-21	2020-05-22	684	9	457	218	draft
2750	Jordan	2020-05-22	2020-05-23	700	9	461	230	draft
2751	Jordan	2020-05-23	2020-05-24	704	9	470	225	draft
2752	Jordan	2020-05-24	2020-05-25	708	9	471	228	draft
2753	Jordan	2020-05-25	2020-05-26	711	9	479	223	draft
2754	Jordan	2020-05-26	2020-05-27	718	9	586	123	draft
2755	Jordan	2020-05-27	2020-05-28	720	9	586	125	draft
2756	Jordan	2020-05-28	2020-05-29	728	9	497	222	draft
2757	Jordan	2020-05-29	2020-05-30	730	9	507	214	draft
2758	Jordan	2020-05-30	2020-05-31	734	9	507	218	draft
2759	Jordan	2020-05-31	2020-06-01	739	9	522	208	draft
2760	Kazakhstan	2020-05-01	2020-05-02	3597	25	922	2650	draft
2761	Kazakhstan	2020-05-02	2020-05-03	3857	25	985	2847	draft
2762	Kazakhstan	2020-05-03	2020-05-04	3920	27	1084	2809	draft
2763	Kazakhstan	2020-05-04	2020-05-05	4049	29	1173	2847	draft
2764	Kazakhstan	2020-05-05	2020-05-06	4205	29	1279	2897	draft
2765	Kazakhstan	2020-05-06	2020-05-07	4422	30	1408	2984	draft
2766	Kazakhstan	2020-05-07	2020-05-08	4578	30	1518	3030	draft
2767	Kazakhstan	2020-05-08	2020-05-09	4834	31	1631	3172	draft
2768	Kazakhstan	2020-05-09	2020-05-10	4975	31	1776	3168	draft
2769	Kazakhstan	2020-05-10	2020-05-11	5090	31	1941	3118	draft
2770	Kazakhstan	2020-05-11	2020-05-12	5207	32	2074	3101	draft
2771	Kazakhstan	2020-05-12	2020-05-13	5279	32	2223	3024	draft
2772	Kazakhstan	2020-05-13	2020-05-14	5417	32	2408	2977	draft
2773	Kazakhstan	2020-05-14	2020-05-15	5571	32	2531	3008	draft
2774	Kazakhstan	2020-05-15	2020-05-16	5689	34	2707	2948	draft
2775	Kazakhstan	2020-05-16	2020-05-17	5850	34	2980	2836	draft
2776	Kazakhstan	2020-05-17	2020-05-18	6157	34	3256	2867	draft
2777	Kazakhstan	2020-05-18	2020-05-19	6751	35	3469	3247	draft
2778	Kazakhstan	2020-05-19	2020-05-20	6751	35	3598	3118	draft
2779	Kazakhstan	2020-05-20	2020-05-21	6969	35	3734	3200	draft
2780	Kazakhstan	2020-05-21	2020-05-22	7234	35	3843	3356	draft
2781	Kazakhstan	2020-05-22	2020-05-23	7919	35	4096	3788	draft
2782	Kazakhstan	2020-05-23	2020-05-24	7919	35	4214	3670	draft
2783	Kazakhstan	2020-05-24	2020-05-25	8531	35	4352	4144	draft
2784	Kazakhstan	2020-05-25	2020-05-26	8969	35	4515	4419	draft
2785	Kazakhstan	2020-05-26	2020-05-27	8969	37	4613	4319	draft
2786	Kazakhstan	2020-05-27	2020-05-28	9304	37	4768	4499	draft
2787	Kazakhstan	2020-05-28	2020-05-29	9576	37	4900	4639	draft
2788	Kazakhstan	2020-05-29	2020-05-30	9932	37	5057	4838	draft
2789	Kazakhstan	2020-05-30	2020-05-31	10382	38	5220	5124	draft
2790	Kazakhstan	2020-05-31	2020-06-01	10858	40	5404	5414	draft
2791	Kenya	2020-05-01	2020-05-02	411	21	150	240	draft
2792	Kenya	2020-05-02	2020-05-03	435	22	152	261	draft
2793	Kenya	2020-05-03	2020-05-04	465	24	167	274	draft
2794	Kenya	2020-05-04	2020-05-05	490	24	173	293	draft
2795	Kenya	2020-05-05	2020-05-06	535	24	182	329	draft
2796	Kenya	2020-05-06	2020-05-07	582	26	190	366	draft
2797	Kenya	2020-05-07	2020-05-08	607	29	197	381	draft
2798	Kenya	2020-05-08	2020-05-09	621	29	202	390	draft
2799	Kenya	2020-05-09	2020-05-10	649	30	207	412	draft
2800	Kenya	2020-05-10	2020-05-11	672	32	239	401	draft
2801	Kenya	2020-05-11	2020-05-12	700	33	251	416	draft
2802	Kenya	2020-05-12	2020-05-13	715	36	259	420	draft
2803	Kenya	2020-05-13	2020-05-14	737	40	281	416	draft
2804	Kenya	2020-05-14	2020-05-15	758	42	284	432	draft
2805	Kenya	2020-05-15	2020-05-16	781	45	284	452	draft
2806	Kenya	2020-05-16	2020-05-17	830	50	301	479	draft
2807	Kenya	2020-05-17	2020-05-18	887	50	313	524	draft
2808	Kenya	2020-05-18	2020-05-19	912	50	336	526	draft
2809	Kenya	2020-05-19	2020-05-20	963	50	358	555	draft
2810	Kenya	2020-05-20	2020-05-21	1029	50	366	613	draft
2811	Kenya	2020-05-21	2020-05-22	1109	50	375	684	draft
2812	Kenya	2020-05-22	2020-05-23	1161	50	380	731	draft
2813	Kenya	2020-05-23	2020-05-24	1192	50	380	762	draft
2814	Kenya	2020-05-24	2020-05-25	1214	51	383	780	draft
2815	Kenya	2020-05-25	2020-05-26	1286	52	402	832	draft
2816	Kenya	2020-05-26	2020-05-27	1348	52	405	891	draft
2817	Kenya	2020-05-27	2020-05-28	1471	55	408	1008	draft
2818	Kenya	2020-05-28	2020-05-29	1618	58	421	1139	draft
2819	Kenya	2020-05-29	2020-05-30	1745	62	438	1245	draft
2820	Kenya	2020-05-30	2020-05-31	1888	63	464	1361	draft
2821	Kenya	2020-05-31	2020-06-01	1962	64	478	1420	draft
2822	Kiribati	2020-05-01	2020-05-02	0	0	0	0	draft
2823	Kiribati	2020-05-02	2020-05-03	0	0	0	0	draft
2824	Kiribati	2020-05-03	2020-05-04	0	0	0	0	draft
2825	Kiribati	2020-05-04	2020-05-05	0	0	0	0	draft
2826	Kiribati	2020-05-05	2020-05-06	0	0	0	0	draft
2827	Kiribati	2020-05-06	2020-05-07	0	0	0	0	draft
2828	Kiribati	2020-05-07	2020-05-08	0	0	0	0	draft
2829	Kiribati	2020-05-08	2020-05-09	0	0	0	0	draft
2830	Kiribati	2020-05-09	2020-05-10	0	0	0	0	draft
2831	Kiribati	2020-05-10	2020-05-11	0	0	0	0	draft
2832	Kiribati	2020-05-11	2020-05-12	0	0	0	0	draft
2833	Kiribati	2020-05-12	2020-05-13	0	0	0	0	draft
2834	Kiribati	2020-05-13	2020-05-14	0	0	0	0	draft
2835	Kiribati	2020-05-14	2020-05-15	0	0	0	0	draft
2836	Kiribati	2020-05-15	2020-05-16	0	0	0	0	draft
2837	Kiribati	2020-05-16	2020-05-17	0	0	0	0	draft
2838	Kiribati	2020-05-17	2020-05-18	0	0	0	0	draft
2839	Kiribati	2020-05-18	2020-05-19	0	0	0	0	draft
2840	Kiribati	2020-05-19	2020-05-20	0	0	0	0	draft
2841	Kiribati	2020-05-20	2020-05-21	0	0	0	0	draft
2842	Kiribati	2020-05-21	2020-05-22	0	0	0	0	draft
2843	Kiribati	2020-05-22	2020-05-23	0	0	0	0	draft
2844	Kiribati	2020-05-23	2020-05-24	0	0	0	0	draft
2845	Kiribati	2020-05-24	2020-05-25	0	0	0	0	draft
2846	Kiribati	2020-05-25	2020-05-26	0	0	0	0	draft
2847	Kiribati	2020-05-26	2020-05-27	0	0	0	0	draft
2848	Kiribati	2020-05-27	2020-05-28	0	0	0	0	draft
2849	Kiribati	2020-05-28	2020-05-29	0	0	0	0	draft
2850	Kiribati	2020-05-29	2020-05-30	0	0	0	0	draft
2851	Kiribati	2020-05-30	2020-05-31	0	0	0	0	draft
2852	Kiribati	2020-05-31	2020-06-01	0	0	0	0	draft
2853	Korea, South	2020-05-01	2020-05-02	10780	250	9123	1407	draft
2854	Korea, South	2020-05-02	2020-05-03	10793	250	9183	1360	draft
2855	Korea, South	2020-05-03	2020-05-04	10801	252	9217	1332	draft
2856	Korea, South	2020-05-04	2020-05-05	10804	254	9283	1267	draft
2857	Korea, South	2020-05-05	2020-05-06	10806	255	9333	1218	draft
2858	Korea, South	2020-05-06	2020-05-07	10810	256	9419	1135	draft
2859	Korea, South	2020-05-07	2020-05-08	10822	256	9484	1082	draft
2860	Korea, South	2020-05-08	2020-05-09	10840	256	9568	1016	draft
2861	Korea, South	2020-05-09	2020-05-10	10874	256	9610	1008	draft
2862	Korea, South	2020-05-10	2020-05-11	10909	256	9632	1021	draft
2863	Korea, South	2020-05-11	2020-05-12	10936	258	9670	1008	draft
2864	Korea, South	2020-05-12	2020-05-13	10962	259	9695	1008	draft
2865	Korea, South	2020-05-13	2020-05-14	10991	260	9762	969	draft
2866	Korea, South	2020-05-14	2020-05-15	11018	260	9821	937	draft
2867	Korea, South	2020-05-15	2020-05-16	11037	262	9851	924	draft
2868	Korea, South	2020-05-16	2020-05-17	11050	262	9888	900	draft
2869	Korea, South	2020-05-17	2020-05-18	11065	263	9904	898	draft
2870	Korea, South	2020-05-18	2020-05-19	11078	263	9938	877	draft
2871	Korea, South	2020-05-19	2020-05-20	11110	263	10066	781	draft
2872	Korea, South	2020-05-20	2020-05-21	11122	264	10135	723	draft
2873	Korea, South	2020-05-21	2020-05-22	11142	264	10162	716	draft
2874	Korea, South	2020-05-22	2020-05-23	11165	266	10194	705	draft
2875	Korea, South	2020-05-23	2020-05-24	11190	266	10213	711	draft
2876	Korea, South	2020-05-24	2020-05-25	11206	267	10226	713	draft
2877	Korea, South	2020-05-25	2020-05-26	11225	269	10275	681	draft
2878	Korea, South	2020-05-26	2020-05-27	11265	269	10295	701	draft
2879	Korea, South	2020-05-27	2020-05-28	11344	269	10340	735	draft
2880	Korea, South	2020-05-28	2020-05-29	11402	269	10363	770	draft
2881	Korea, South	2020-05-29	2020-05-30	11441	269	10398	774	draft
2882	Korea, South	2020-05-30	2020-05-31	11468	270	10405	793	draft
2883	Korea, South	2020-05-31	2020-06-01	11503	271	10422	810	draft
2884	Kosovo	2020-05-01	2020-05-02	806	22	271	513	draft
2885	Kosovo	2020-05-02	2020-05-03	823	22	336	465	draft
2886	Kosovo	2020-05-03	2020-05-04	851	22	381	448	draft
2887	Kosovo	2020-05-04	2020-05-05	855	26	403	426	draft
2888	Kosovo	2020-05-05	2020-05-06	856	26	490	340	draft
2889	Kosovo	2020-05-06	2020-05-07	856	26	490	340	draft
2890	Kosovo	2020-05-07	2020-05-08	861	27	562	272	draft
2891	Kosovo	2020-05-08	2020-05-09	861	27	562	272	draft
2892	Kosovo	2020-05-09	2020-05-10	862	28	622	212	draft
2893	Kosovo	2020-05-10	2020-05-11	870	28	653	189	draft
2894	Kosovo	2020-05-11	2020-05-12	884	28	655	201	draft
2895	Kosovo	2020-05-12	2020-05-13	919	29	671	219	draft
2896	Kosovo	2020-05-13	2020-05-14	919	29	671	219	draft
2897	Kosovo	2020-05-14	2020-05-15	944	29	690	225	draft
2898	Kosovo	2020-05-15	2020-05-16	944	29	690	225	draft
2899	Kosovo	2020-05-16	2020-05-17	944	29	690	225	draft
2900	Kosovo	2020-05-17	2020-05-18	955	29	691	235	draft
2901	Kosovo	2020-05-18	2020-05-19	955	29	691	235	draft
2902	Kosovo	2020-05-19	2020-05-20	989	29	769	191	draft
2903	Kosovo	2020-05-20	2020-05-21	989	29	769	191	draft
2904	Kosovo	2020-05-21	2020-05-22	1003	29	772	202	draft
2905	Kosovo	2020-05-22	2020-05-23	1004	29	772	203	draft
2906	Kosovo	2020-05-23	2020-05-24	1025	29	782	214	draft
2907	Kosovo	2020-05-24	2020-05-25	1032	29	785	218	draft
2908	Kosovo	2020-05-25	2020-05-26	1038	30	791	217	draft
2909	Kosovo	2020-05-26	2020-05-27	1038	30	791	217	draft
2910	Kosovo	2020-05-27	2020-05-28	1047	30	794	223	draft
2911	Kosovo	2020-05-28	2020-05-29	1048	30	801	217	draft
2912	Kosovo	2020-05-29	2020-05-30	1048	30	801	217	draft
2913	Kosovo	2020-05-30	2020-05-31	1064	30	829	205	draft
2914	Kosovo	2020-05-31	2020-06-01	1064	30	829	205	draft
2915	Kuwait	2020-05-01	2020-05-02	4377	30	1602	2745	draft
2916	Kuwait	2020-05-02	2020-05-03	4619	33	1703	2883	draft
2917	Kuwait	2020-05-03	2020-05-04	4983	38	1776	3169	draft
2918	Kuwait	2020-05-04	2020-05-05	5278	40	1947	3291	draft
2919	Kuwait	2020-05-05	2020-05-06	5804	40	2032	3732	draft
2920	Kuwait	2020-05-06	2020-05-07	6289	42	2219	4028	draft
2921	Kuwait	2020-05-07	2020-05-08	6567	44	2381	4142	draft
2922	Kuwait	2020-05-08	2020-05-09	7208	47	2466	4695	draft
2923	Kuwait	2020-05-09	2020-05-10	7623	49	2622	4952	draft
2924	Kuwait	2020-05-10	2020-05-11	8688	58	2729	5901	draft
2925	Kuwait	2020-05-11	2020-05-12	9286	65	2907	6314	draft
2926	Kuwait	2020-05-12	2020-05-13	10277	75	3101	7101	draft
2927	Kuwait	2020-05-13	2020-05-14	11028	82	3263	7683	draft
2928	Kuwait	2020-05-14	2020-05-15	11975	88	3451	8436	draft
2929	Kuwait	2020-05-15	2020-05-16	12860	96	3640	9124	draft
2930	Kuwait	2020-05-16	2020-05-17	13802	107	3843	9852	draft
2931	Kuwait	2020-05-17	2020-05-18	14850	112	4093	10645	draft
2932	Kuwait	2020-05-18	2020-05-19	15691	118	4339	11234	draft
2933	Kuwait	2020-05-19	2020-05-20	16764	121	4681	11962	draft
2934	Kuwait	2020-05-20	2020-05-21	17568	124	4885	12559	draft
2935	Kuwait	2020-05-21	2020-05-22	18609	129	5205	13275	draft
2936	Kuwait	2020-05-22	2020-05-23	19564	138	5515	13911	draft
2937	Kuwait	2020-05-23	2020-05-24	20464	148	5747	14569	draft
2938	Kuwait	2020-05-24	2020-05-25	21302	156	6117	15029	draft
2939	Kuwait	2020-05-25	2020-05-26	21967	165	6621	15181	draft
2940	Kuwait	2020-05-26	2020-05-27	22575	172	7306	15097	draft
2941	Kuwait	2020-05-27	2020-05-28	23267	175	7946	15146	draft
2942	Kuwait	2020-05-28	2020-05-29	24112	185	8698	15229	draft
2943	Kuwait	2020-05-29	2020-05-30	25184	194	9273	15717	draft
2944	Kuwait	2020-05-30	2020-05-31	26192	205	10156	15831	draft
2945	Kuwait	2020-05-31	2020-06-01	27043	212	11386	15445	draft
2946	Kyrgyzstan	2020-05-01	2020-05-02	756	8	504	244	draft
2947	Kyrgyzstan	2020-05-02	2020-05-03	769	8	527	234	draft
2948	Kyrgyzstan	2020-05-03	2020-05-04	795	10	564	221	draft
2949	Kyrgyzstan	2020-05-04	2020-05-05	830	10	575	245	draft
2950	Kyrgyzstan	2020-05-05	2020-05-06	843	11	600	232	draft
2951	Kyrgyzstan	2020-05-06	2020-05-07	871	12	614	245	draft
2952	Kyrgyzstan	2020-05-07	2020-05-08	895	12	637	246	draft
2953	Kyrgyzstan	2020-05-08	2020-05-09	906	12	650	244	draft
2954	Kyrgyzstan	2020-05-09	2020-05-10	931	12	658	261	draft
2955	Kyrgyzstan	2020-05-10	2020-05-11	1002	12	675	315	draft
2956	Kyrgyzstan	2020-05-11	2020-05-12	1016	12	688	316	draft
2957	Kyrgyzstan	2020-05-12	2020-05-13	1037	12	709	316	draft
2958	Kyrgyzstan	2020-05-13	2020-05-14	1044	12	726	306	draft
2959	Kyrgyzstan	2020-05-14	2020-05-15	1082	12	735	335	draft
2960	Kyrgyzstan	2020-05-15	2020-05-16	1111	14	745	352	draft
2961	Kyrgyzstan	2020-05-16	2020-05-17	1117	14	783	320	draft
2962	Kyrgyzstan	2020-05-17	2020-05-18	1138	14	804	320	draft
2963	Kyrgyzstan	2020-05-18	2020-05-19	1216	14	827	375	draft
2964	Kyrgyzstan	2020-05-19	2020-05-20	1243	14	898	331	draft
2965	Kyrgyzstan	2020-05-20	2020-05-21	1270	14	910	346	draft
2966	Kyrgyzstan	2020-05-21	2020-05-22	1313	14	923	376	draft
2967	Kyrgyzstan	2020-05-22	2020-05-23	1350	14	939	397	draft
2968	Kyrgyzstan	2020-05-23	2020-05-24	1365	14	957	394	draft
2969	Kyrgyzstan	2020-05-24	2020-05-25	1403	14	980	409	draft
2970	Kyrgyzstan	2020-05-25	2020-05-26	1433	16	992	425	draft
2971	Kyrgyzstan	2020-05-26	2020-05-27	1468	16	1015	437	draft
2972	Kyrgyzstan	2020-05-27	2020-05-28	1520	16	1043	461	draft
2973	Kyrgyzstan	2020-05-28	2020-05-29	1594	16	1066	512	draft
2974	Kyrgyzstan	2020-05-29	2020-05-30	1662	16	1088	558	draft
2975	Kyrgyzstan	2020-05-30	2020-05-31	1722	16	1113	593	draft
2976	Kyrgyzstan	2020-05-31	2020-06-01	1748	16	1170	562	draft
2977	Laos	2020-05-01	2020-05-02	19	0	8	11	draft
2978	Laos	2020-05-02	2020-05-03	19	0	9	10	draft
2979	Laos	2020-05-03	2020-05-04	19	0	9	10	draft
2980	Laos	2020-05-04	2020-05-05	19	0	9	10	draft
2981	Laos	2020-05-05	2020-05-06	19	0	9	10	draft
2982	Laos	2020-05-06	2020-05-07	19	0	10	9	draft
2983	Laos	2020-05-07	2020-05-08	19	0	9	10	draft
2984	Laos	2020-05-08	2020-05-09	19	0	9	10	draft
2985	Laos	2020-05-09	2020-05-10	19	0	13	6	draft
2986	Laos	2020-05-10	2020-05-11	19	0	13	6	draft
2987	Laos	2020-05-11	2020-05-12	19	0	13	6	draft
2988	Laos	2020-05-12	2020-05-13	19	0	13	6	draft
2989	Laos	2020-05-13	2020-05-14	19	0	14	5	draft
2990	Laos	2020-05-14	2020-05-15	19	0	14	5	draft
2991	Laos	2020-05-15	2020-05-16	19	0	14	5	draft
2992	Laos	2020-05-16	2020-05-17	19	0	14	5	draft
2993	Laos	2020-05-17	2020-05-18	19	0	14	5	draft
2994	Laos	2020-05-18	2020-05-19	19	0	14	5	draft
2995	Laos	2020-05-19	2020-05-20	19	0	14	5	draft
2996	Laos	2020-05-20	2020-05-21	19	0	14	5	draft
2997	Laos	2020-05-21	2020-05-22	19	0	14	5	draft
2998	Laos	2020-05-22	2020-05-23	19	0	14	5	draft
2999	Laos	2020-05-23	2020-05-24	19	0	14	5	draft
3000	Laos	2020-05-24	2020-05-25	19	0	14	5	draft
3001	Laos	2020-05-25	2020-05-26	19	0	14	5	draft
3002	Laos	2020-05-26	2020-05-27	19	0	14	5	draft
3003	Laos	2020-05-27	2020-05-28	19	0	16	3	draft
3004	Laos	2020-05-28	2020-05-29	19	0	16	3	draft
3005	Laos	2020-05-29	2020-05-30	19	0	16	3	draft
3006	Laos	2020-05-30	2020-05-31	19	0	16	3	draft
3007	Laos	2020-05-31	2020-06-01	19	0	16	3	draft
3008	Latvia	2020-05-01	2020-05-02	870	16	348	506	draft
3009	Latvia	2020-05-02	2020-05-03	871	16	348	507	draft
3010	Latvia	2020-05-03	2020-05-04	879	16	348	515	draft
3011	Latvia	2020-05-04	2020-05-05	896	16	348	532	draft
3012	Latvia	2020-05-05	2020-05-06	896	17	348	531	draft
3013	Latvia	2020-05-06	2020-05-07	900	17	464	419	draft
3014	Latvia	2020-05-07	2020-05-08	909	18	464	427	draft
3015	Latvia	2020-05-08	2020-05-09	928	18	464	446	draft
3016	Latvia	2020-05-09	2020-05-10	930	18	464	448	draft
3017	Latvia	2020-05-10	2020-05-11	939	18	464	457	draft
3018	Latvia	2020-05-11	2020-05-12	946	18	464	464	draft
3019	Latvia	2020-05-12	2020-05-13	950	18	627	305	draft
3020	Latvia	2020-05-13	2020-05-14	951	19	627	305	draft
3021	Latvia	2020-05-14	2020-05-15	962	19	627	316	draft
3022	Latvia	2020-05-15	2020-05-16	970	19	662	289	draft
3023	Latvia	2020-05-16	2020-05-17	997	19	662	316	draft
3024	Latvia	2020-05-17	2020-05-18	1008	19	662	327	draft
3025	Latvia	2020-05-18	2020-05-19	1009	19	662	328	draft
3026	Latvia	2020-05-19	2020-05-20	1012	21	694	297	draft
3027	Latvia	2020-05-20	2020-05-21	1016	21	694	301	draft
3028	Latvia	2020-05-21	2020-05-22	1025	22	694	309	draft
3029	Latvia	2020-05-22	2020-05-23	1030	22	712	296	draft
3030	Latvia	2020-05-23	2020-05-24	1046	22	712	312	draft
3031	Latvia	2020-05-24	2020-05-25	1047	22	712	313	draft
3032	Latvia	2020-05-25	2020-05-26	1049	22	712	315	draft
3033	Latvia	2020-05-26	2020-05-27	1053	22	741	290	draft
3034	Latvia	2020-05-27	2020-05-28	1057	23	741	293	draft
3035	Latvia	2020-05-28	2020-05-29	1061	24	741	296	draft
3036	Latvia	2020-05-29	2020-05-30	1064	24	745	295	draft
3037	Latvia	2020-05-30	2020-05-31	1065	24	745	296	draft
3038	Latvia	2020-05-31	2020-06-01	1066	24	745	297	draft
3039	Lebanon	2020-05-01	2020-05-02	729	24	192	513	draft
3040	Lebanon	2020-05-02	2020-05-03	733	25	197	511	draft
3041	Lebanon	2020-05-03	2020-05-04	737	25	200	512	draft
3042	Lebanon	2020-05-04	2020-05-05	740	25	200	515	draft
3043	Lebanon	2020-05-05	2020-05-06	741	25	206	510	draft
3044	Lebanon	2020-05-06	2020-05-07	750	25	206	519	draft
3045	Lebanon	2020-05-07	2020-05-08	784	25	220	539	draft
3046	Lebanon	2020-05-08	2020-05-09	796	26	223	547	draft
3047	Lebanon	2020-05-09	2020-05-10	809	26	234	549	draft
3048	Lebanon	2020-05-10	2020-05-11	845	26	234	585	draft
3049	Lebanon	2020-05-11	2020-05-12	859	26	234	599	draft
3050	Lebanon	2020-05-12	2020-05-13	870	26	234	610	draft
3051	Lebanon	2020-05-13	2020-05-14	878	26	236	616	draft
3052	Lebanon	2020-05-14	2020-05-15	886	26	236	624	draft
3053	Lebanon	2020-05-15	2020-05-16	891	26	246	619	draft
3054	Lebanon	2020-05-16	2020-05-17	902	26	247	629	draft
3055	Lebanon	2020-05-17	2020-05-18	911	26	247	638	draft
3056	Lebanon	2020-05-18	2020-05-19	931	26	251	654	draft
3057	Lebanon	2020-05-19	2020-05-20	954	26	251	677	draft
3058	Lebanon	2020-05-20	2020-05-21	961	26	251	684	draft
3059	Lebanon	2020-05-21	2020-05-22	1024	26	663	335	draft
3060	Lebanon	2020-05-22	2020-05-23	1086	26	663	397	draft
3061	Lebanon	2020-05-23	2020-05-24	1097	26	667	404	draft
3062	Lebanon	2020-05-24	2020-05-25	1114	26	688	400	draft
3063	Lebanon	2020-05-25	2020-05-26	1119	26	688	405	draft
3064	Lebanon	2020-05-26	2020-05-27	1140	26	689	425	draft
3065	Lebanon	2020-05-27	2020-05-28	1161	26	692	443	draft
3066	Lebanon	2020-05-28	2020-05-29	1168	26	699	443	draft
3067	Lebanon	2020-05-29	2020-05-30	1172	26	705	441	draft
3068	Lebanon	2020-05-30	2020-05-31	1191	26	708	457	draft
3069	Lebanon	2020-05-31	2020-06-01	1220	27	712	481	draft
3070	Lesotho	2020-05-13	2020-05-14	1	0	0	1	draft
3071	Lesotho	2020-05-14	2020-05-15	1	0	0	1	draft
3072	Lesotho	2020-05-15	2020-05-16	1	0	0	1	draft
3073	Lesotho	2020-05-16	2020-05-17	1	0	0	1	draft
3074	Lesotho	2020-05-17	2020-05-18	1	0	0	1	draft
3075	Lesotho	2020-05-18	2020-05-19	1	0	0	1	draft
3076	Lesotho	2020-05-19	2020-05-20	1	0	0	1	draft
3077	Lesotho	2020-05-20	2020-05-21	1	0	0	1	draft
3078	Lesotho	2020-05-21	2020-05-22	1	0	0	1	draft
3079	Lesotho	2020-05-22	2020-05-23	2	0	0	2	draft
3080	Lesotho	2020-05-23	2020-05-24	2	0	0	2	draft
3081	Lesotho	2020-05-24	2020-05-25	2	0	0	2	draft
3082	Lesotho	2020-05-25	2020-05-26	2	0	0	2	draft
3083	Lesotho	2020-05-26	2020-05-27	2	0	0	2	draft
3084	Lesotho	2020-05-27	2020-05-28	2	0	0	2	draft
3085	Lesotho	2020-05-28	2020-05-29	2	0	1	1	draft
3086	Lesotho	2020-05-29	2020-05-30	2	0	1	1	draft
3087	Lesotho	2020-05-30	2020-05-31	2	0	1	1	draft
3088	Lesotho	2020-05-31	2020-06-01	2	0	1	1	draft
3089	Liberia	2020-05-01	2020-05-02	152	18	45	89	draft
3090	Liberia	2020-05-02	2020-05-03	154	18	48	88	draft
3091	Liberia	2020-05-03	2020-05-04	158	18	58	82	draft
3092	Liberia	2020-05-04	2020-05-05	166	18	58	90	draft
3093	Liberia	2020-05-05	2020-05-06	170	20	58	92	draft
3094	Liberia	2020-05-06	2020-05-07	178	20	75	83	draft
3095	Liberia	2020-05-07	2020-05-08	189	20	79	90	draft
3096	Liberia	2020-05-08	2020-05-09	199	20	79	100	draft
3097	Liberia	2020-05-09	2020-05-10	199	20	79	100	draft
3098	Liberia	2020-05-10	2020-05-11	199	20	79	100	draft
3099	Liberia	2020-05-11	2020-05-12	211	20	85	106	draft
3100	Liberia	2020-05-12	2020-05-13	211	20	85	106	draft
3101	Liberia	2020-05-13	2020-05-14	213	20	101	92	draft
3102	Liberia	2020-05-14	2020-05-15	215	20	105	90	draft
3103	Liberia	2020-05-15	2020-05-16	219	20	108	91	draft
3104	Liberia	2020-05-16	2020-05-17	223	20	116	87	draft
3105	Liberia	2020-05-17	2020-05-18	226	21	120	85	draft
3106	Liberia	2020-05-18	2020-05-19	229	22	123	84	draft
3107	Liberia	2020-05-19	2020-05-20	233	23	125	85	draft
3108	Liberia	2020-05-20	2020-05-21	238	23	128	87	draft
3109	Liberia	2020-05-21	2020-05-22	240	23	131	86	draft
3110	Liberia	2020-05-22	2020-05-23	249	24	136	89	draft
3111	Liberia	2020-05-23	2020-05-24	255	26	136	93	draft
3112	Liberia	2020-05-24	2020-05-25	265	26	139	100	draft
3113	Liberia	2020-05-25	2020-05-26	265	26	141	98	draft
3114	Liberia	2020-05-26	2020-05-27	266	26	144	96	draft
3115	Liberia	2020-05-27	2020-05-28	266	27	144	95	draft
3116	Liberia	2020-05-28	2020-05-29	269	27	144	98	draft
3117	Liberia	2020-05-29	2020-05-30	273	27	146	100	draft
3118	Liberia	2020-05-30	2020-05-31	280	27	148	105	draft
3119	Liberia	2020-05-31	2020-06-01	288	27	157	104	draft
3120	Libya	2020-05-01	2020-05-02	63	3	18	42	draft
3121	Libya	2020-05-02	2020-05-03	63	3	22	38	draft
3122	Libya	2020-05-03	2020-05-04	63	3	22	38	draft
3123	Libya	2020-05-04	2020-05-05	63	3	23	37	draft
3124	Libya	2020-05-05	2020-05-06	63	3	23	37	draft
3125	Libya	2020-05-06	2020-05-07	64	3	24	37	draft
3126	Libya	2020-05-07	2020-05-08	64	3	24	37	draft
3127	Libya	2020-05-08	2020-05-09	64	3	24	37	draft
3128	Libya	2020-05-09	2020-05-10	64	3	24	37	draft
3129	Libya	2020-05-10	2020-05-11	64	3	24	37	draft
3130	Libya	2020-05-11	2020-05-12	64	3	28	33	draft
3131	Libya	2020-05-12	2020-05-13	64	3	28	33	draft
3132	Libya	2020-05-13	2020-05-14	64	3	28	33	draft
3133	Libya	2020-05-14	2020-05-15	64	3	28	33	draft
3134	Libya	2020-05-15	2020-05-16	64	3	28	33	draft
3135	Libya	2020-05-16	2020-05-17	65	3	28	34	draft
3136	Libya	2020-05-17	2020-05-18	65	3	35	27	draft
3137	Libya	2020-05-18	2020-05-19	65	3	35	27	draft
3138	Libya	2020-05-19	2020-05-20	68	3	35	30	draft
3139	Libya	2020-05-20	2020-05-21	69	3	35	31	draft
3140	Libya	2020-05-21	2020-05-22	71	3	35	33	draft
3141	Libya	2020-05-22	2020-05-23	72	3	38	31	draft
3142	Libya	2020-05-23	2020-05-24	75	3	39	33	draft
3143	Libya	2020-05-24	2020-05-25	75	3	39	33	draft
3144	Libya	2020-05-25	2020-05-26	75	3	40	32	draft
3145	Libya	2020-05-26	2020-05-27	77	3	40	34	draft
3146	Libya	2020-05-27	2020-05-28	99	4	40	55	draft
3147	Libya	2020-05-28	2020-05-29	105	5	41	59	draft
3148	Libya	2020-05-29	2020-05-30	118	5	41	72	draft
3149	Libya	2020-05-30	2020-05-31	130	5	50	75	draft
3150	Libya	2020-05-31	2020-06-01	156	5	52	99	draft
3151	Liechtenstein	2020-05-01	2020-05-02	82	1	55	26	draft
3152	Liechtenstein	2020-05-02	2020-05-03	82	1	55	26	draft
3153	Liechtenstein	2020-05-03	2020-05-04	82	1	55	26	draft
3154	Liechtenstein	2020-05-04	2020-05-05	82	1	55	26	draft
3155	Liechtenstein	2020-05-05	2020-05-06	82	1	55	26	draft
3156	Liechtenstein	2020-05-06	2020-05-07	82	1	55	26	draft
3157	Liechtenstein	2020-05-07	2020-05-08	82	1	55	26	draft
3158	Liechtenstein	2020-05-08	2020-05-09	82	1	55	26	draft
3159	Liechtenstein	2020-05-09	2020-05-10	82	1	55	26	draft
3160	Liechtenstein	2020-05-10	2020-05-11	82	1	55	26	draft
3161	Liechtenstein	2020-05-11	2020-05-12	82	1	55	26	draft
3162	Liechtenstein	2020-05-12	2020-05-13	82	1	55	26	draft
3163	Liechtenstein	2020-05-13	2020-05-14	82	1	55	26	draft
3164	Liechtenstein	2020-05-14	2020-05-15	82	1	55	26	draft
3165	Liechtenstein	2020-05-15	2020-05-16	82	1	55	26	draft
3166	Liechtenstein	2020-05-16	2020-05-17	82	1	55	26	draft
3167	Liechtenstein	2020-05-17	2020-05-18	82	1	55	26	draft
3168	Liechtenstein	2020-05-18	2020-05-19	82	1	55	26	draft
3169	Liechtenstein	2020-05-19	2020-05-20	82	1	55	26	draft
3170	Liechtenstein	2020-05-20	2020-05-21	82	1	55	26	draft
3171	Liechtenstein	2020-05-21	2020-05-22	82	1	55	26	draft
3172	Liechtenstein	2020-05-22	2020-05-23	82	1	55	26	draft
3173	Liechtenstein	2020-05-23	2020-05-24	82	1	55	26	draft
3174	Liechtenstein	2020-05-24	2020-05-25	82	1	55	26	draft
3175	Liechtenstein	2020-05-25	2020-05-26	82	1	55	26	draft
3176	Liechtenstein	2020-05-26	2020-05-27	82	1	55	26	draft
3177	Liechtenstein	2020-05-27	2020-05-28	82	1	55	26	draft
3178	Liechtenstein	2020-05-28	2020-05-29	82	1	55	26	draft
3179	Liechtenstein	2020-05-29	2020-05-30	82	1	55	26	draft
3180	Liechtenstein	2020-05-30	2020-05-31	82	1	55	26	draft
3181	Liechtenstein	2020-05-31	2020-06-01	82	1	55	26	draft
3182	Lithuania	2020-05-01	2020-05-02	1389	32	615	760	draft
3183	Lithuania	2020-05-02	2020-05-03	1394	33	644	728	draft
3184	Lithuania	2020-05-03	2020-05-04	1399	33	686	729	draft
3185	Lithuania	2020-05-04	2020-05-05	1407	33	715	735	draft
3186	Lithuania	2020-05-05	2020-05-06	1410	33	761	699	draft
3187	Lithuania	2020-05-06	2020-05-07	1416	34	804	662	draft
3188	Lithuania	2020-05-07	2020-05-08	1421	35	858	645	draft
3189	Lithuania	2020-05-08	2020-05-09	1430	35	888	622	draft
3190	Lithuania	2020-05-09	2020-05-10	1459	35	905	567	draft
3191	Lithuania	2020-05-10	2020-05-11	1471	36	927	601	draft
3192	Lithuania	2020-05-11	2020-05-12	1479	36	946	602	draft
3193	Lithuania	2020-05-12	2020-05-13	1488	39	969	591	draft
3194	Lithuania	2020-05-13	2020-05-14	1502	39	989	543	draft
3195	Lithuania	2020-05-14	2020-05-15	1511	39	1049	523	draft
3196	Lithuania	2020-05-15	2020-05-16	1521	41	1096	504	draft
3197	Lithuania	2020-05-16	2020-05-17	1536	42	1119	491	draft
3198	Lithuania	2020-05-17	2020-05-18	1545	43	1134	488	draft
3199	Lithuania	2020-05-18	2020-05-19	1551	45	1156	491	draft
3200	Lithuania	2020-05-19	2020-05-20	1559	45	1174	477	draft
3201	Lithuania	2020-05-20	2020-05-21	1580	46	1181	468	draft
3202	Lithuania	2020-05-21	2020-05-22	1592	46	1189	483	draft
3203	Lithuania	2020-05-22	2020-05-23	1598	46	1198	432	draft
3204	Lithuania	2020-05-23	2020-05-24	1612	47	1209	418	draft
3205	Lithuania	2020-05-24	2020-05-25	1618	48	1212	422	draft
3206	Lithuania	2020-05-25	2020-05-26	1628	49	1241	434	draft
3207	Lithuania	2020-05-26	2020-05-27	1632	51	1256	409	draft
3208	Lithuania	2020-05-27	2020-05-28	1640	51	1260	397	draft
3209	Lithuania	2020-05-28	2020-05-29	1649	52	1266	395	draft
3210	Lithuania	2020-05-29	2020-05-30	1654	52	1269	378	draft
3211	Lithuania	2020-05-30	2020-05-31	1662	54	1274	371	draft
3212	Lithuania	2020-05-31	2020-06-01	1667	54	1279	369	draft
3213	Luxembourg	2020-05-01	2020-05-02	3802	92	3213	497	draft
3214	Luxembourg	2020-05-02	2020-05-03	3812	92	3318	402	draft
3215	Luxembourg	2020-05-03	2020-05-04	3824	96	3379	349	draft
3216	Luxembourg	2020-05-04	2020-05-05	3828	96	3405	327	draft
3217	Luxembourg	2020-05-05	2020-05-06	3840	96	3412	332	draft
3218	Luxembourg	2020-05-06	2020-05-07	3851	98	3452	301	draft
3219	Luxembourg	2020-05-07	2020-05-08	3859	100	3505	254	draft
3220	Luxembourg	2020-05-08	2020-05-09	3871	100	3526	245	draft
3221	Luxembourg	2020-05-09	2020-05-10	3877	101	3550	226	draft
3222	Luxembourg	2020-05-10	2020-05-11	3886	101	3586	199	draft
3223	Luxembourg	2020-05-11	2020-05-12	3888	101	3602	185	draft
3224	Luxembourg	2020-05-12	2020-05-13	3894	102	3610	182	draft
3225	Luxembourg	2020-05-13	2020-05-14	3904	103	3629	172	draft
3226	Luxembourg	2020-05-14	2020-05-15	3915	103	3665	147	draft
3227	Luxembourg	2020-05-15	2020-05-16	3923	104	3682	137	draft
3228	Luxembourg	2020-05-16	2020-05-17	3930	104	3699	127	draft
3229	Luxembourg	2020-05-17	2020-05-18	3945	107	3702	136	draft
3230	Luxembourg	2020-05-18	2020-05-19	3947	107	3715	125	draft
3231	Luxembourg	2020-05-19	2020-05-20	3958	109	3718	131	draft
3232	Luxembourg	2020-05-20	2020-05-21	3971	109	3728	134	draft
3233	Luxembourg	2020-05-21	2020-05-22	3980	109	3741	130	draft
3234	Luxembourg	2020-05-22	2020-05-23	3981	109	3748	124	draft
3235	Luxembourg	2020-05-23	2020-05-24	3990	109	3758	123	draft
3236	Luxembourg	2020-05-24	2020-05-25	3992	110	3767	115	draft
3237	Luxembourg	2020-05-25	2020-05-26	3993	110	3781	102	draft
3238	Luxembourg	2020-05-26	2020-05-27	3995	110	3783	102	draft
3239	Luxembourg	2020-05-27	2020-05-28	4001	110	3791	100	draft
3240	Luxembourg	2020-05-28	2020-05-29	4008	110	3803	95	draft
3241	Luxembourg	2020-05-29	2020-05-30	4012	110	3815	87	draft
3242	Luxembourg	2020-05-30	2020-05-31	4016	110	3815	91	draft
3243	Luxembourg	2020-05-31	2020-06-01	4018	110	3833	75	draft
3244	MS Zaandam	2020-05-01	2020-05-02	9	2	0	7	draft
3245	MS Zaandam	2020-05-02	2020-05-03	9	2	0	7	draft
3246	MS Zaandam	2020-05-03	2020-05-04	9	2	0	7	draft
3247	MS Zaandam	2020-05-04	2020-05-05	9	2	0	7	draft
3248	MS Zaandam	2020-05-05	2020-05-06	9	2	0	7	draft
3249	MS Zaandam	2020-05-06	2020-05-07	9	2	0	7	draft
3250	MS Zaandam	2020-05-07	2020-05-08	9	2	0	7	draft
3251	MS Zaandam	2020-05-08	2020-05-09	9	2	0	7	draft
3252	MS Zaandam	2020-05-09	2020-05-10	9	2	0	7	draft
3253	MS Zaandam	2020-05-10	2020-05-11	9	2	0	7	draft
3254	MS Zaandam	2020-05-11	2020-05-12	9	2	0	7	draft
3255	MS Zaandam	2020-05-12	2020-05-13	9	2	0	7	draft
3256	MS Zaandam	2020-05-13	2020-05-14	9	2	0	7	draft
3257	MS Zaandam	2020-05-14	2020-05-15	9	2	0	7	draft
3258	MS Zaandam	2020-05-15	2020-05-16	9	2	0	7	draft
3259	MS Zaandam	2020-05-16	2020-05-17	9	2	0	7	draft
3260	MS Zaandam	2020-05-17	2020-05-18	9	2	0	7	draft
3261	MS Zaandam	2020-05-18	2020-05-19	9	2	0	7	draft
3262	MS Zaandam	2020-05-19	2020-05-20	9	2	0	7	draft
3263	MS Zaandam	2020-05-20	2020-05-21	9	2	0	7	draft
3264	MS Zaandam	2020-05-21	2020-05-22	9	2	0	7	draft
3265	MS Zaandam	2020-05-22	2020-05-23	9	2	0	7	draft
3266	MS Zaandam	2020-05-23	2020-05-24	9	2	0	7	draft
3267	MS Zaandam	2020-05-24	2020-05-25	9	2	0	7	draft
3268	MS Zaandam	2020-05-25	2020-05-26	9	2	0	7	draft
3269	MS Zaandam	2020-05-26	2020-05-27	9	2	0	7	draft
3270	MS Zaandam	2020-05-27	2020-05-28	9	2	0	7	draft
3271	MS Zaandam	2020-05-28	2020-05-29	9	2	0	7	draft
3272	MS Zaandam	2020-05-29	2020-05-30	9	2	0	7	draft
3273	MS Zaandam	2020-05-30	2020-05-31	9	2	0	7	draft
3274	MS Zaandam	2020-05-31	2020-06-01	9	2	0	7	draft
3275	Madagascar	2020-05-01	2020-05-02	132	0	94	38	draft
3276	Madagascar	2020-05-02	2020-05-03	135	0	97	38	draft
3277	Madagascar	2020-05-03	2020-05-04	149	0	98	51	draft
3278	Madagascar	2020-05-04	2020-05-05	149	0	99	50	draft
3279	Madagascar	2020-05-05	2020-05-06	151	0	101	50	draft
3280	Madagascar	2020-05-06	2020-05-07	158	0	101	57	draft
3281	Madagascar	2020-05-07	2020-05-08	193	0	101	92	draft
3282	Madagascar	2020-05-08	2020-05-09	193	0	101	92	draft
3283	Madagascar	2020-05-09	2020-05-10	193	0	101	92	draft
3284	Madagascar	2020-05-10	2020-05-11	193	0	101	92	draft
3285	Madagascar	2020-05-11	2020-05-12	186	0	101	85	draft
3286	Madagascar	2020-05-12	2020-05-13	186	0	101	85	draft
3287	Madagascar	2020-05-13	2020-05-14	212	0	107	105	draft
3288	Madagascar	2020-05-14	2020-05-15	230	0	108	122	draft
3289	Madagascar	2020-05-15	2020-05-16	238	0	112	126	draft
3290	Madagascar	2020-05-16	2020-05-17	283	0	114	169	draft
3291	Madagascar	2020-05-17	2020-05-18	304	1	114	189	draft
3292	Madagascar	2020-05-18	2020-05-19	322	1	119	202	draft
3293	Madagascar	2020-05-19	2020-05-20	326	2	119	205	draft
3294	Madagascar	2020-05-20	2020-05-21	371	2	131	238	draft
3295	Madagascar	2020-05-21	2020-05-22	405	2	131	272	draft
3296	Madagascar	2020-05-22	2020-05-23	448	2	135	311	draft
3297	Madagascar	2020-05-23	2020-05-24	488	2	138	348	draft
3298	Madagascar	2020-05-24	2020-05-25	527	2	142	383	draft
3299	Madagascar	2020-05-25	2020-05-26	542	2	147	393	draft
3300	Madagascar	2020-05-26	2020-05-27	586	2	147	437	draft
3301	Madagascar	2020-05-27	2020-05-28	612	2	151	459	draft
3302	Madagascar	2020-05-28	2020-05-29	656	2	154	500	draft
3303	Madagascar	2020-05-29	2020-05-30	698	5	164	529	draft
3304	Madagascar	2020-05-30	2020-05-31	758	6	165	587	draft
3305	Madagascar	2020-05-31	2020-06-01	771	6	168	597	draft
3306	Malawi	2020-05-01	2020-05-02	37	3	9	25	draft
3307	Malawi	2020-05-02	2020-05-03	38	3	9	26	draft
3308	Malawi	2020-05-03	2020-05-04	39	3	9	27	draft
3309	Malawi	2020-05-04	2020-05-05	41	3	9	29	draft
3310	Malawi	2020-05-05	2020-05-06	41	3	9	29	draft
3311	Malawi	2020-05-06	2020-05-07	43	3	9	31	draft
3312	Malawi	2020-05-07	2020-05-08	43	3	14	26	draft
3313	Malawi	2020-05-08	2020-05-09	43	3	14	26	draft
3314	Malawi	2020-05-09	2020-05-10	56	3	14	39	draft
3315	Malawi	2020-05-10	2020-05-11	56	3	14	39	draft
3316	Malawi	2020-05-11	2020-05-12	57	3	24	30	draft
3317	Malawi	2020-05-12	2020-05-13	57	3	24	30	draft
3318	Malawi	2020-05-13	2020-05-14	63	3	24	36	draft
3319	Malawi	2020-05-14	2020-05-15	63	3	24	36	draft
3320	Malawi	2020-05-15	2020-05-16	63	3	24	36	draft
3321	Malawi	2020-05-16	2020-05-17	65	3	24	38	draft
3322	Malawi	2020-05-17	2020-05-18	70	3	27	40	draft
3323	Malawi	2020-05-18	2020-05-19	70	3	27	40	draft
3324	Malawi	2020-05-19	2020-05-20	70	3	27	40	draft
3325	Malawi	2020-05-20	2020-05-21	71	3	27	41	draft
3326	Malawi	2020-05-21	2020-05-22	72	3	27	42	draft
3327	Malawi	2020-05-22	2020-05-23	82	3	28	51	draft
3328	Malawi	2020-05-23	2020-05-24	82	3	28	51	draft
3329	Malawi	2020-05-24	2020-05-25	83	4	33	46	draft
3330	Malawi	2020-05-25	2020-05-26	101	4	33	64	draft
3331	Malawi	2020-05-26	2020-05-27	101	4	37	60	draft
3332	Malawi	2020-05-27	2020-05-28	101	4	37	60	draft
3333	Malawi	2020-05-28	2020-05-29	203	4	37	162	draft
3334	Malawi	2020-05-29	2020-05-30	273	4	42	227	draft
3335	Malawi	2020-05-30	2020-05-31	279	4	42	233	draft
3336	Malawi	2020-05-31	2020-06-01	284	4	42	238	draft
3337	Malaysia	2020-05-01	2020-05-02	6071	103	4210	1758	draft
3338	Malaysia	2020-05-02	2020-05-03	6176	103	4326	1747	draft
3339	Malaysia	2020-05-03	2020-05-04	6298	105	4413	1780	draft
3340	Malaysia	2020-05-04	2020-05-05	6353	105	4484	1764	draft
3341	Malaysia	2020-05-05	2020-05-06	6383	106	4567	1710	draft
3342	Malaysia	2020-05-06	2020-05-07	6428	107	4702	1619	draft
3343	Malaysia	2020-05-07	2020-05-08	6467	107	4776	1584	draft
3344	Malaysia	2020-05-08	2020-05-09	6535	107	4864	1564	draft
3345	Malaysia	2020-05-09	2020-05-10	6589	108	4929	1552	draft
3346	Malaysia	2020-05-10	2020-05-11	6656	108	5025	1523	draft
3347	Malaysia	2020-05-11	2020-05-12	6726	109	5113	1504	draft
3348	Malaysia	2020-05-12	2020-05-13	6742	109	5223	1410	draft
3349	Malaysia	2020-05-13	2020-05-14	6779	111	5281	1387	draft
3350	Malaysia	2020-05-14	2020-05-15	6819	112	5351	1356	draft
3351	Malaysia	2020-05-15	2020-05-16	6855	112	5439	1304	draft
3352	Malaysia	2020-05-16	2020-05-17	6872	113	5512	1247	draft
3353	Malaysia	2020-05-17	2020-05-18	6894	113	5571	1210	draft
3354	Malaysia	2020-05-18	2020-05-19	6941	113	5615	1213	draft
3355	Malaysia	2020-05-19	2020-05-20	6978	114	5646	1218	draft
3356	Malaysia	2020-05-20	2020-05-21	7009	114	5706	1189	draft
3357	Malaysia	2020-05-21	2020-05-22	7059	114	5796	1149	draft
3358	Malaysia	2020-05-22	2020-05-23	7137	115	5859	1163	draft
3359	Malaysia	2020-05-23	2020-05-24	7185	115	5912	1158	draft
3360	Malaysia	2020-05-24	2020-05-25	7245	115	5945	1185	draft
3361	Malaysia	2020-05-25	2020-05-26	7417	115	5979	1323	draft
3362	Malaysia	2020-05-26	2020-05-27	7604	115	6041	1448	draft
3363	Malaysia	2020-05-27	2020-05-28	7619	115	6083	1421	draft
3364	Malaysia	2020-05-28	2020-05-29	7629	115	6169	1345	draft
3365	Malaysia	2020-05-29	2020-05-30	7732	115	6235	1382	draft
3366	Malaysia	2020-05-30	2020-05-31	7762	115	6330	1317	draft
3367	Malaysia	2020-05-31	2020-06-01	7819	115	6353	1351	draft
3368	Maldives	2020-05-01	2020-05-02	491	1	17	473	draft
3369	Maldives	2020-05-02	2020-05-03	519	1	18	500	draft
3370	Maldives	2020-05-03	2020-05-04	527	1	18	508	draft
3371	Maldives	2020-05-04	2020-05-05	541	1	18	522	draft
3372	Maldives	2020-05-05	2020-05-06	573	2	20	551	draft
3373	Maldives	2020-05-06	2020-05-07	617	2	20	595	draft
3374	Maldives	2020-05-07	2020-05-08	648	3	20	625	draft
3375	Maldives	2020-05-08	2020-05-09	744	3	20	721	draft
3376	Maldives	2020-05-09	2020-05-10	790	3	29	758	draft
3377	Maldives	2020-05-10	2020-05-11	835	3	29	803	draft
3378	Maldives	2020-05-11	2020-05-12	897	3	29	865	draft
3379	Maldives	2020-05-12	2020-05-13	904	3	29	872	draft
3380	Maldives	2020-05-13	2020-05-14	955	4	40	911	draft
3381	Maldives	2020-05-14	2020-05-15	982	4	45	933	draft
3382	Maldives	2020-05-15	2020-05-16	1031	4	49	978	draft
3383	Maldives	2020-05-16	2020-05-17	1078	4	58	1016	draft
3384	Maldives	2020-05-17	2020-05-18	1094	4	58	1032	draft
3385	Maldives	2020-05-18	2020-05-19	1106	4	58	1044	draft
3386	Maldives	2020-05-19	2020-05-20	1143	4	91	1048	draft
3387	Maldives	2020-05-20	2020-05-21	1186	4	91	1091	draft
3388	Maldives	2020-05-21	2020-05-22	1216	4	91	1121	draft
3389	Maldives	2020-05-22	2020-05-23	1274	4	109	1161	draft
3390	Maldives	2020-05-23	2020-05-24	1313	4	128	1181	draft
3391	Maldives	2020-05-24	2020-05-25	1371	4	144	1223	draft
3392	Maldives	2020-05-25	2020-05-26	1395	4	155	1236	draft
3393	Maldives	2020-05-26	2020-05-27	1438	5	197	1236	draft
3394	Maldives	2020-05-27	2020-05-28	1457	5	197	1255	draft
3395	Maldives	2020-05-28	2020-05-29	1513	5	197	1311	draft
3396	Maldives	2020-05-29	2020-05-30	1591	5	197	1389	draft
3397	Maldives	2020-05-30	2020-05-31	1672	5	406	1261	draft
3398	Maldives	2020-05-31	2020-06-01	1773	5	453	1315	draft
3399	Mali	2020-05-01	2020-05-02	508	26	196	286	draft
3400	Mali	2020-05-02	2020-05-03	544	26	206	312	draft
3401	Mali	2020-05-03	2020-05-04	563	27	213	323	draft
3402	Mali	2020-05-04	2020-05-05	580	29	223	328	draft
3403	Mali	2020-05-05	2020-05-06	612	32	228	352	draft
3404	Mali	2020-05-06	2020-05-07	631	32	261	338	draft
3405	Mali	2020-05-07	2020-05-08	650	32	271	347	draft
3406	Mali	2020-05-08	2020-05-09	668	35	285	348	draft
3407	Mali	2020-05-09	2020-05-10	692	37	298	357	draft
3408	Mali	2020-05-10	2020-05-11	704	38	351	315	draft
3409	Mali	2020-05-11	2020-05-12	712	39	377	296	draft
3410	Mali	2020-05-12	2020-05-13	730	40	398	292	draft
3411	Mali	2020-05-13	2020-05-14	758	44	412	302	draft
3412	Mali	2020-05-14	2020-05-15	779	46	436	297	draft
3413	Mali	2020-05-15	2020-05-16	806	46	455	305	draft
3414	Mali	2020-05-16	2020-05-17	835	48	479	308	draft
3415	Mali	2020-05-17	2020-05-18	860	52	494	314	draft
3416	Mali	2020-05-18	2020-05-19	874	52	512	310	draft
3417	Mali	2020-05-19	2020-05-20	901	53	529	319	draft
3418	Mali	2020-05-20	2020-05-21	931	55	543	333	draft
3419	Mali	2020-05-21	2020-05-22	947	60	558	329	draft
3420	Mali	2020-05-22	2020-05-23	969	62	560	347	draft
3421	Mali	2020-05-23	2020-05-24	1015	63	574	378	draft
3422	Mali	2020-05-24	2020-05-25	1030	65	597	368	draft
3423	Mali	2020-05-25	2020-05-26	1059	67	604	388	draft
3424	Mali	2020-05-26	2020-05-27	1077	70	617	390	draft
3425	Mali	2020-05-27	2020-05-28	1116	70	632	414	draft
3426	Mali	2020-05-28	2020-05-29	1194	72	652	470	draft
3427	Mali	2020-05-29	2020-05-30	1226	73	669	484	draft
3428	Mali	2020-05-30	2020-05-31	1250	76	696	478	draft
3429	Mali	2020-05-31	2020-06-01	1265	77	716	472	draft
3430	Malta	2020-05-01	2020-05-02	467	4	383	80	draft
3431	Malta	2020-05-02	2020-05-03	468	4	379	85	draft
3432	Malta	2020-05-03	2020-05-04	477	4	392	81	draft
3433	Malta	2020-05-04	2020-05-05	480	4	399	77	draft
3434	Malta	2020-05-05	2020-05-06	482	5	403	74	draft
3435	Malta	2020-05-06	2020-05-07	484	5	407	72	draft
3436	Malta	2020-05-07	2020-05-08	486	5	413	68	draft
3437	Malta	2020-05-08	2020-05-09	489	5	419	65	draft
3438	Malta	2020-05-09	2020-05-10	490	5	427	58	draft
3439	Malta	2020-05-10	2020-05-11	496	5	433	58	draft
3440	Malta	2020-05-11	2020-05-12	503	5	434	64	draft
3441	Malta	2020-05-12	2020-05-13	506	5	434	67	draft
3442	Malta	2020-05-13	2020-05-14	508	6	436	66	draft
3443	Malta	2020-05-14	2020-05-15	522	6	443	73	draft
3444	Malta	2020-05-15	2020-05-16	532	6	458	68	draft
3445	Malta	2020-05-16	2020-05-17	546	6	450	90	draft
3446	Malta	2020-05-17	2020-05-18	553	6	454	93	draft
3447	Malta	2020-05-18	2020-05-19	558	6	456	96	draft
3448	Malta	2020-05-19	2020-05-20	569	6	460	103	draft
3449	Malta	2020-05-20	2020-05-21	584	6	465	113	draft
3450	Malta	2020-05-21	2020-05-22	599	6	468	125	draft
3451	Malta	2020-05-22	2020-05-23	600	6	469	125	draft
3452	Malta	2020-05-23	2020-05-24	609	6	473	130	draft
3453	Malta	2020-05-24	2020-05-25	610	6	476	128	draft
3454	Malta	2020-05-25	2020-05-26	611	6	485	120	draft
3455	Malta	2020-05-26	2020-05-27	611	6	485	120	draft
3456	Malta	2020-05-27	2020-05-28	612	7	491	114	draft
3457	Malta	2020-05-28	2020-05-29	616	7	501	108	draft
3458	Malta	2020-05-29	2020-05-30	616	9	514	93	draft
3459	Malta	2020-05-30	2020-05-31	618	9	525	84	draft
3460	Malta	2020-05-31	2020-06-01	618	9	534	75	draft
3461	Mauritania	2020-05-01	2020-05-02	8	1	6	1	draft
3462	Mauritania	2020-05-02	2020-05-03	8	1	6	1	draft
3463	Mauritania	2020-05-03	2020-05-04	8	1	6	1	draft
3464	Mauritania	2020-05-04	2020-05-05	8	1	6	1	draft
3465	Mauritania	2020-05-05	2020-05-06	8	1	6	1	draft
3466	Mauritania	2020-05-06	2020-05-07	8	1	6	1	draft
3467	Mauritania	2020-05-07	2020-05-08	8	1	6	1	draft
3468	Mauritania	2020-05-08	2020-05-09	8	1	6	1	draft
3469	Mauritania	2020-05-09	2020-05-10	8	1	6	1	draft
3470	Mauritania	2020-05-10	2020-05-11	8	1	6	1	draft
3471	Mauritania	2020-05-11	2020-05-12	8	1	6	1	draft
3472	Mauritania	2020-05-12	2020-05-13	9	1	6	2	draft
3473	Mauritania	2020-05-13	2020-05-14	15	2	6	7	draft
3474	Mauritania	2020-05-14	2020-05-15	20	2	7	11	draft
3475	Mauritania	2020-05-15	2020-05-16	29	3	7	19	draft
3476	Mauritania	2020-05-16	2020-05-17	40	4	7	29	draft
3477	Mauritania	2020-05-17	2020-05-18	62	4	7	51	draft
3478	Mauritania	2020-05-18	2020-05-19	81	4	7	70	draft
3479	Mauritania	2020-05-19	2020-05-20	131	4	7	120	draft
3480	Mauritania	2020-05-20	2020-05-21	141	4	7	130	draft
3481	Mauritania	2020-05-21	2020-05-22	173	5	7	161	draft
3482	Mauritania	2020-05-22	2020-05-23	200	6	7	187	draft
3483	Mauritania	2020-05-23	2020-05-24	227	6	7	214	draft
3484	Mauritania	2020-05-24	2020-05-25	237	6	15	216	draft
3485	Mauritania	2020-05-25	2020-05-26	262	9	15	238	draft
3486	Mauritania	2020-05-26	2020-05-27	268	13	15	240	draft
3487	Mauritania	2020-05-27	2020-05-28	292	16	15	261	draft
3488	Mauritania	2020-05-28	2020-05-29	346	19	15	312	draft
3489	Mauritania	2020-05-29	2020-05-30	423	20	21	382	draft
3490	Mauritania	2020-05-30	2020-05-31	483	20	21	442	draft
3491	Mauritania	2020-05-31	2020-06-01	530	23	27	480	draft
3492	Mauritius	2020-05-01	2020-05-02	332	10	312	10	draft
3493	Mauritius	2020-05-02	2020-05-03	332	10	314	8	draft
3494	Mauritius	2020-05-03	2020-05-04	332	10	315	7	draft
3495	Mauritius	2020-05-04	2020-05-05	332	10	316	6	draft
3496	Mauritius	2020-05-05	2020-05-06	332	10	319	3	draft
3497	Mauritius	2020-05-06	2020-05-07	332	10	320	2	draft
3498	Mauritius	2020-05-07	2020-05-08	332	10	320	2	draft
3499	Mauritius	2020-05-08	2020-05-09	332	10	320	2	draft
3500	Mauritius	2020-05-09	2020-05-10	332	10	320	2	draft
3501	Mauritius	2020-05-10	2020-05-11	332	10	320	2	draft
3502	Mauritius	2020-05-11	2020-05-12	332	10	322	0	draft
3503	Mauritius	2020-05-12	2020-05-13	332	10	322	0	draft
3504	Mauritius	2020-05-13	2020-05-14	332	10	322	0	draft
3505	Mauritius	2020-05-14	2020-05-15	332	10	322	0	draft
3506	Mauritius	2020-05-15	2020-05-16	332	10	322	0	draft
3507	Mauritius	2020-05-16	2020-05-17	332	10	322	0	draft
3508	Mauritius	2020-05-17	2020-05-18	332	10	322	0	draft
3509	Mauritius	2020-05-18	2020-05-19	332	10	322	0	draft
3510	Mauritius	2020-05-19	2020-05-20	332	10	322	0	draft
3511	Mauritius	2020-05-20	2020-05-21	332	10	322	0	draft
3512	Mauritius	2020-05-21	2020-05-22	332	10	322	0	draft
3513	Mauritius	2020-05-22	2020-05-23	332	10	322	0	draft
3514	Mauritius	2020-05-23	2020-05-24	332	10	322	0	draft
3515	Mauritius	2020-05-24	2020-05-25	334	10	322	2	draft
3516	Mauritius	2020-05-25	2020-05-26	334	10	322	2	draft
3517	Mauritius	2020-05-26	2020-05-27	334	10	322	2	draft
3518	Mauritius	2020-05-27	2020-05-28	334	10	322	2	draft
3519	Mauritius	2020-05-28	2020-05-29	334	10	322	2	draft
3520	Mauritius	2020-05-29	2020-05-30	335	10	322	3	draft
3521	Mauritius	2020-05-30	2020-05-31	335	10	322	3	draft
3522	Mauritius	2020-05-31	2020-06-01	335	10	322	3	draft
3523	Mexico	2020-05-01	2020-05-02	20739	1972	12377	6390	draft
3524	Mexico	2020-05-02	2020-05-03	22088	2061	12377	7650	draft
3525	Mexico	2020-05-03	2020-05-04	23471	2154	13447	7870	draft
3526	Mexico	2020-05-04	2020-05-05	24905	2271	13447	9187	draft
3527	Mexico	2020-05-05	2020-05-06	26025	2507	16810	6708	draft
3528	Mexico	2020-05-06	2020-05-07	27634	2704	17781	7149	draft
3529	Mexico	2020-05-07	2020-05-08	29616	2961	17781	8874	draft
3530	Mexico	2020-05-08	2020-05-09	31522	3160	20314	8048	draft
3531	Mexico	2020-05-09	2020-05-10	33460	3353	21824	8283	draft
3532	Mexico	2020-05-10	2020-05-11	35022	3465	21824	9733	draft
3533	Mexico	2020-05-11	2020-05-12	36327	3573	23100	9654	draft
3534	Mexico	2020-05-12	2020-05-13	38324	3926	25935	8463	draft
3535	Mexico	2020-05-13	2020-05-14	40186	4220	26990	8976	draft
3536	Mexico	2020-05-14	2020-05-15	42595	4477	28475	9643	draft
3537	Mexico	2020-05-15	2020-05-16	45032	4767	30451	9814	draft
3538	Mexico	2020-05-16	2020-05-17	47144	5045	31848	10251	draft
3539	Mexico	2020-05-17	2020-05-18	49219	5177	33329	10713	draft
3540	Mexico	2020-05-18	2020-05-19	51633	5332	35388	10913	draft
3541	Mexico	2020-05-19	2020-05-20	54346	5666	37325	11355	draft
3542	Mexico	2020-05-20	2020-05-21	56594	6090	38419	12085	draft
3543	Mexico	2020-05-21	2020-05-22	59567	6510	40152	12905	draft
3544	Mexico	2020-05-22	2020-05-23	62527	6989	42191	13347	draft
3545	Mexico	2020-05-23	2020-05-24	65856	7179	44424	14253	draft
3546	Mexico	2020-05-24	2020-05-25	68620	7394	46979	14247	draft
3547	Mexico	2020-05-25	2020-05-26	71105	7633	49452	14020	draft
3548	Mexico	2020-05-26	2020-05-27	74560	8134	51708	14718	draft
3549	Mexico	2020-05-27	2020-05-28	78023	8597	53834	15592	draft
3550	Mexico	2020-05-28	2020-05-29	81400	9044	56041	16315	draft
3551	Mexico	2020-05-29	2020-05-30	84627	9415	59003	16209	draft
3552	Mexico	2020-05-30	2020-05-31	87512	9779	61247	16486	draft
3553	Mexico	2020-05-31	2020-06-01	90664	9930	63772	16962	draft
3554	Moldova	2020-05-01	2020-05-02	3980	122	1272	2586	draft
3555	Moldova	2020-05-02	2020-05-03	4052	124	1334	2594	draft
3556	Moldova	2020-05-03	2020-05-04	4121	125	1382	2614	draft
3557	Moldova	2020-05-04	2020-05-05	4248	132	1423	2693	draft
3558	Moldova	2020-05-05	2020-05-06	4363	136	1544	2683	draft
3559	Moldova	2020-05-06	2020-05-07	4476	143	1658	2675	draft
3560	Moldova	2020-05-07	2020-05-08	4605	145	1747	2713	draft
3561	Moldova	2020-05-08	2020-05-09	4728	150	1826	2752	draft
3562	Moldova	2020-05-09	2020-05-10	4867	161	1925	2781	draft
3563	Moldova	2020-05-10	2020-05-11	4927	169	1958	2800	draft
3564	Moldova	2020-05-11	2020-05-12	4995	175	1980	2840	draft
3565	Moldova	2020-05-12	2020-05-13	5154	182	2069	2903	draft
3566	Moldova	2020-05-13	2020-05-14	5406	185	2176	3045	draft
3567	Moldova	2020-05-14	2020-05-15	5553	194	2228	3131	draft
3568	Moldova	2020-05-15	2020-05-16	5745	202	2228	3315	draft
3569	Moldova	2020-05-16	2020-05-17	5934	207	2344	3383	draft
3570	Moldova	2020-05-17	2020-05-18	6060	211	2344	3505	draft
3571	Moldova	2020-05-18	2020-05-19	6138	217	2425	3496	draft
3572	Moldova	2020-05-19	2020-05-20	6340	221	2508	3611	draft
3573	Moldova	2020-05-20	2020-05-21	6553	228	2953	3372	draft
3574	Moldova	2020-05-21	2020-05-22	6704	233	2953	3518	draft
3575	Moldova	2020-05-22	2020-05-23	6847	237	3369	3241	draft
3576	Moldova	2020-05-23	2020-05-24	6994	242	3452	3300	draft
3577	Moldova	2020-05-24	2020-05-25	7093	250	3713	3130	draft
3578	Moldova	2020-05-25	2020-05-26	7147	261	3802	3084	draft
3579	Moldova	2020-05-26	2020-05-27	7305	267	3884	3154	draft
3580	Moldova	2020-05-27	2020-05-28	7537	274	3884	3379	draft
3581	Moldova	2020-05-28	2020-05-29	7725	282	4123	3320	draft
3582	Moldova	2020-05-29	2020-05-30	7896	288	4278	3330	draft
3583	Moldova	2020-05-30	2020-05-31	8098	291	4455	3352	draft
3584	Moldova	2020-05-31	2020-06-01	8251	295	4581	3375	draft
3585	Monaco	2020-05-01	2020-05-02	95	4	73	18	draft
3586	Monaco	2020-05-02	2020-05-03	95	4	78	13	draft
3587	Monaco	2020-05-03	2020-05-04	95	4	78	13	draft
3588	Monaco	2020-05-04	2020-05-05	95	4	78	13	draft
3589	Monaco	2020-05-05	2020-05-06	95	4	81	10	draft
3590	Monaco	2020-05-06	2020-05-07	95	4	82	9	draft
3591	Monaco	2020-05-07	2020-05-08	95	4	82	9	draft
3592	Monaco	2020-05-08	2020-05-09	95	4	82	9	draft
3593	Monaco	2020-05-09	2020-05-10	96	4	82	10	draft
3594	Monaco	2020-05-10	2020-05-11	96	4	82	10	draft
3595	Monaco	2020-05-11	2020-05-12	96	4	85	7	draft
3596	Monaco	2020-05-12	2020-05-13	96	4	85	7	draft
3597	Monaco	2020-05-13	2020-05-14	96	4	87	5	draft
3598	Monaco	2020-05-14	2020-05-15	96	4	87	5	draft
3599	Monaco	2020-05-15	2020-05-16	96	4	87	5	draft
3600	Monaco	2020-05-16	2020-05-17	96	4	87	5	draft
3601	Monaco	2020-05-17	2020-05-18	96	4	87	5	draft
3602	Monaco	2020-05-18	2020-05-19	97	4	87	6	draft
3603	Monaco	2020-05-19	2020-05-20	97	4	87	6	draft
3604	Monaco	2020-05-20	2020-05-21	97	4	90	3	draft
3605	Monaco	2020-05-21	2020-05-22	97	4	90	3	draft
3606	Monaco	2020-05-22	2020-05-23	97	4	90	3	draft
3607	Monaco	2020-05-23	2020-05-24	98	4	90	4	draft
3608	Monaco	2020-05-24	2020-05-25	98	4	90	4	draft
3609	Monaco	2020-05-25	2020-05-26	98	4	90	4	draft
3610	Monaco	2020-05-26	2020-05-27	98	4	90	4	draft
3611	Monaco	2020-05-27	2020-05-28	98	4	90	4	draft
3612	Monaco	2020-05-28	2020-05-29	98	4	90	4	draft
3613	Monaco	2020-05-29	2020-05-30	98	4	90	4	draft
3614	Monaco	2020-05-30	2020-05-31	99	4	90	5	draft
3615	Monaco	2020-05-31	2020-06-01	99	4	90	5	draft
3616	Mongolia	2020-05-01	2020-05-02	38	0	10	28	draft
3617	Mongolia	2020-05-02	2020-05-03	39	0	10	29	draft
3618	Mongolia	2020-05-03	2020-05-04	39	0	10	29	draft
3619	Mongolia	2020-05-04	2020-05-05	40	0	12	28	draft
3620	Mongolia	2020-05-05	2020-05-06	41	0	13	28	draft
3621	Mongolia	2020-05-06	2020-05-07	41	0	13	28	draft
3622	Mongolia	2020-05-07	2020-05-08	41	0	13	28	draft
3623	Mongolia	2020-05-08	2020-05-09	42	0	13	29	draft
3624	Mongolia	2020-05-09	2020-05-10	42	0	14	28	draft
3625	Mongolia	2020-05-10	2020-05-11	42	0	14	28	draft
3626	Mongolia	2020-05-11	2020-05-12	42	0	14	28	draft
3627	Mongolia	2020-05-12	2020-05-13	42	0	15	27	draft
3628	Mongolia	2020-05-13	2020-05-14	42	0	15	27	draft
3629	Mongolia	2020-05-14	2020-05-15	98	0	15	83	draft
3630	Mongolia	2020-05-15	2020-05-16	98	0	20	78	draft
3631	Mongolia	2020-05-16	2020-05-17	135	0	20	115	draft
3632	Mongolia	2020-05-17	2020-05-18	136	0	21	115	draft
3633	Mongolia	2020-05-18	2020-05-19	140	0	24	116	draft
3634	Mongolia	2020-05-19	2020-05-20	140	0	26	114	draft
3635	Mongolia	2020-05-20	2020-05-21	140	0	26	114	draft
3636	Mongolia	2020-05-21	2020-05-22	140	0	26	114	draft
3637	Mongolia	2020-05-22	2020-05-23	141	0	28	113	draft
3638	Mongolia	2020-05-23	2020-05-24	141	0	30	111	draft
3639	Mongolia	2020-05-24	2020-05-25	141	0	32	109	draft
3640	Mongolia	2020-05-25	2020-05-26	141	0	33	108	draft
3641	Mongolia	2020-05-26	2020-05-27	141	0	37	104	draft
3642	Mongolia	2020-05-27	2020-05-28	148	0	43	105	draft
3643	Mongolia	2020-05-28	2020-05-29	161	0	43	118	draft
3644	Mongolia	2020-05-29	2020-05-30	179	0	43	136	draft
3645	Mongolia	2020-05-30	2020-05-31	179	0	44	135	draft
3646	Mongolia	2020-05-31	2020-06-01	179	0	44	135	draft
3647	Montenegro	2020-05-01	2020-05-02	322	7	233	82	draft
3648	Montenegro	2020-05-02	2020-05-03	322	8	245	69	draft
3649	Montenegro	2020-05-03	2020-05-04	322	8	249	65	draft
3650	Montenegro	2020-05-04	2020-05-05	323	8	253	62	draft
3651	Montenegro	2020-05-05	2020-05-06	324	8	253	63	draft
3652	Montenegro	2020-05-06	2020-05-07	324	8	261	55	draft
3653	Montenegro	2020-05-07	2020-05-08	324	8	265	51	draft
3654	Montenegro	2020-05-08	2020-05-09	324	8	267	49	draft
3655	Montenegro	2020-05-09	2020-05-10	324	8	274	42	draft
3656	Montenegro	2020-05-10	2020-05-11	324	9	290	25	draft
3657	Montenegro	2020-05-11	2020-05-12	324	9	294	21	draft
3658	Montenegro	2020-05-12	2020-05-13	324	9	298	17	draft
3659	Montenegro	2020-05-13	2020-05-14	324	9	307	8	draft
3660	Montenegro	2020-05-14	2020-05-15	324	9	309	6	draft
3661	Montenegro	2020-05-15	2020-05-16	324	9	311	4	draft
3662	Montenegro	2020-05-16	2020-05-17	324	9	311	4	draft
3663	Montenegro	2020-05-17	2020-05-18	324	9	311	4	draft
3664	Montenegro	2020-05-18	2020-05-19	324	9	311	4	draft
3665	Montenegro	2020-05-19	2020-05-20	324	9	312	3	draft
3666	Montenegro	2020-05-20	2020-05-21	324	9	312	3	draft
3667	Montenegro	2020-05-21	2020-05-22	324	9	314	1	draft
3668	Montenegro	2020-05-22	2020-05-23	324	9	314	1	draft
3669	Montenegro	2020-05-23	2020-05-24	324	9	314	1	draft
3670	Montenegro	2020-05-24	2020-05-25	324	9	315	0	draft
3671	Montenegro	2020-05-25	2020-05-26	324	9	315	0	draft
3672	Montenegro	2020-05-26	2020-05-27	324	9	315	0	draft
3673	Montenegro	2020-05-27	2020-05-28	324	9	315	0	draft
3674	Montenegro	2020-05-28	2020-05-29	324	9	315	0	draft
3675	Montenegro	2020-05-29	2020-05-30	324	9	315	0	draft
3676	Montenegro	2020-05-30	2020-05-31	324	9	315	0	draft
3677	Montenegro	2020-05-31	2020-06-01	324	9	315	0	draft
3678	Morocco	2020-05-01	2020-05-02	4569	171	1083	3315	draft
3679	Morocco	2020-05-02	2020-05-03	4729	173	1256	3300	draft
3680	Morocco	2020-05-03	2020-05-04	4903	174	1438	3291	draft
3681	Morocco	2020-05-04	2020-05-05	5053	179	1653	3221	draft
3682	Morocco	2020-05-05	2020-05-06	5219	181	1838	3200	draft
3683	Morocco	2020-05-06	2020-05-07	5408	183	2017	3208	draft
3684	Morocco	2020-05-07	2020-05-08	5548	183	2179	3186	draft
3685	Morocco	2020-05-08	2020-05-09	5711	186	2324	3201	draft
3686	Morocco	2020-05-09	2020-05-10	5910	186	2461	3263	draft
3687	Morocco	2020-05-10	2020-05-11	6063	188	2554	3321	draft
3688	Morocco	2020-05-11	2020-05-12	6281	188	2811	3282	draft
3689	Morocco	2020-05-12	2020-05-13	6418	188	2991	3239	draft
3690	Morocco	2020-05-13	2020-05-14	6512	188	3131	3193	draft
3691	Morocco	2020-05-14	2020-05-15	6607	190	3310	3107	draft
3692	Morocco	2020-05-15	2020-05-16	6652	190	3400	3062	draft
3693	Morocco	2020-05-16	2020-05-17	6741	192	3487	3062	draft
3694	Morocco	2020-05-17	2020-05-18	6870	192	3660	3018	draft
3695	Morocco	2020-05-18	2020-05-19	6952	192	3758	3002	draft
3696	Morocco	2020-05-19	2020-05-20	7023	193	3901	2929	draft
3697	Morocco	2020-05-20	2020-05-21	7133	194	4098	2841	draft
3698	Morocco	2020-05-21	2020-05-22	7211	196	4280	2735	draft
3699	Morocco	2020-05-22	2020-05-23	7332	197	4377	2758	draft
3700	Morocco	2020-05-23	2020-05-24	7406	198	4638	2570	draft
3701	Morocco	2020-05-24	2020-05-25	7433	199	4703	2531	draft
3702	Morocco	2020-05-25	2020-05-26	7532	200	4774	2558	draft
3703	Morocco	2020-05-26	2020-05-27	7577	202	4881	2494	draft
3704	Morocco	2020-05-27	2020-05-28	7601	202	4978	2421	draft
3705	Morocco	2020-05-28	2020-05-29	7643	202	5195	2246	draft
3706	Morocco	2020-05-29	2020-05-30	7714	202	5271	2241	draft
3707	Morocco	2020-05-30	2020-05-31	7780	204	5401	2175	draft
3708	Morocco	2020-05-31	2020-06-01	7807	205	5459	2143	draft
3709	Mozambique	2020-05-01	2020-05-02	79	0	12	67	draft
3710	Mozambique	2020-05-02	2020-05-03	79	0	18	61	draft
3711	Mozambique	2020-05-03	2020-05-04	80	0	19	61	draft
3712	Mozambique	2020-05-04	2020-05-05	80	0	19	61	draft
3713	Mozambique	2020-05-05	2020-05-06	81	0	19	62	draft
3714	Mozambique	2020-05-06	2020-05-07	81	0	21	60	draft
3715	Mozambique	2020-05-07	2020-05-08	81	0	24	57	draft
3716	Mozambique	2020-05-08	2020-05-09	82	0	27	55	draft
3717	Mozambique	2020-05-09	2020-05-10	87	0	34	53	draft
3718	Mozambique	2020-05-10	2020-05-11	91	0	34	57	draft
3719	Mozambique	2020-05-11	2020-05-12	103	0	34	69	draft
3720	Mozambique	2020-05-12	2020-05-13	104	0	34	70	draft
3721	Mozambique	2020-05-13	2020-05-14	104	0	34	70	draft
3722	Mozambique	2020-05-14	2020-05-15	115	0	35	80	draft
3723	Mozambique	2020-05-15	2020-05-16	119	0	42	77	draft
3724	Mozambique	2020-05-16	2020-05-17	129	0	43	86	draft
3725	Mozambique	2020-05-17	2020-05-18	137	0	44	93	draft
3726	Mozambique	2020-05-18	2020-05-19	145	0	44	101	draft
3727	Mozambique	2020-05-19	2020-05-20	146	0	44	102	draft
3728	Mozambique	2020-05-20	2020-05-21	156	0	48	108	draft
3729	Mozambique	2020-05-21	2020-05-22	162	0	48	114	draft
3730	Mozambique	2020-05-22	2020-05-23	164	0	48	116	draft
3731	Mozambique	2020-05-23	2020-05-24	168	0	48	120	draft
3732	Mozambique	2020-05-24	2020-05-25	194	0	51	143	draft
3733	Mozambique	2020-05-25	2020-05-26	209	1	71	137	draft
3734	Mozambique	2020-05-26	2020-05-27	213	1	71	141	draft
3735	Mozambique	2020-05-27	2020-05-28	227	1	71	155	draft
3736	Mozambique	2020-05-28	2020-05-29	233	2	82	149	draft
3737	Mozambique	2020-05-29	2020-05-30	234	2	84	148	draft
3738	Mozambique	2020-05-30	2020-05-31	244	2	90	152	draft
3739	Mozambique	2020-05-31	2020-06-01	254	2	91	161	draft
3740	Namibia	2020-05-01	2020-05-02	16	0	8	8	draft
3741	Namibia	2020-05-02	2020-05-03	16	0	8	8	draft
3742	Namibia	2020-05-03	2020-05-04	16	0	8	8	draft
3743	Namibia	2020-05-04	2020-05-05	16	0	8	8	draft
3744	Namibia	2020-05-05	2020-05-06	16	0	8	8	draft
3745	Namibia	2020-05-06	2020-05-07	16	0	8	8	draft
3746	Namibia	2020-05-07	2020-05-08	16	0	9	7	draft
3747	Namibia	2020-05-08	2020-05-09	16	0	9	7	draft
3748	Namibia	2020-05-09	2020-05-10	16	0	10	6	draft
3749	Namibia	2020-05-10	2020-05-11	16	0	11	5	draft
3750	Namibia	2020-05-11	2020-05-12	16	0	11	5	draft
3751	Namibia	2020-05-12	2020-05-13	16	0	11	5	draft
3752	Namibia	2020-05-13	2020-05-14	16	0	11	5	draft
3753	Namibia	2020-05-14	2020-05-15	16	0	12	4	draft
3754	Namibia	2020-05-15	2020-05-16	16	0	13	3	draft
3755	Namibia	2020-05-16	2020-05-17	16	0	13	3	draft
3756	Namibia	2020-05-17	2020-05-18	16	0	13	3	draft
3757	Namibia	2020-05-18	2020-05-19	16	0	13	3	draft
3758	Namibia	2020-05-19	2020-05-20	16	0	13	3	draft
3759	Namibia	2020-05-20	2020-05-21	16	0	14	2	draft
3760	Namibia	2020-05-21	2020-05-22	18	0	14	4	draft
3761	Namibia	2020-05-22	2020-05-23	19	0	14	5	draft
3762	Namibia	2020-05-23	2020-05-24	20	0	14	6	draft
3763	Namibia	2020-05-24	2020-05-25	21	0	14	7	draft
3764	Namibia	2020-05-25	2020-05-26	21	0	14	7	draft
3765	Namibia	2020-05-26	2020-05-27	21	0	14	7	draft
3766	Namibia	2020-05-27	2020-05-28	22	0	14	8	draft
3767	Namibia	2020-05-28	2020-05-29	22	0	14	8	draft
3768	Namibia	2020-05-29	2020-05-30	23	0	14	9	draft
3769	Namibia	2020-05-30	2020-05-31	23	0	14	9	draft
3770	Namibia	2020-05-31	2020-06-01	24	0	14	10	draft
3771	Nepal	2020-05-01	2020-05-02	59	0	16	43	draft
3772	Nepal	2020-05-02	2020-05-03	59	0	16	43	draft
3773	Nepal	2020-05-03	2020-05-04	75	0	16	59	draft
3774	Nepal	2020-05-04	2020-05-05	75	0	16	59	draft
3775	Nepal	2020-05-05	2020-05-06	82	0	16	66	draft
3776	Nepal	2020-05-06	2020-05-07	99	0	22	77	draft
3777	Nepal	2020-05-07	2020-05-08	101	0	22	79	draft
3778	Nepal	2020-05-08	2020-05-09	102	0	31	71	draft
3779	Nepal	2020-05-09	2020-05-10	110	0	31	79	draft
3780	Nepal	2020-05-10	2020-05-11	110	0	31	79	draft
3781	Nepal	2020-05-11	2020-05-12	134	0	33	101	draft
3782	Nepal	2020-05-12	2020-05-13	217	0	33	184	draft
3783	Nepal	2020-05-13	2020-05-14	250	0	35	215	draft
3784	Nepal	2020-05-14	2020-05-15	249	0	35	214	draft
3785	Nepal	2020-05-15	2020-05-16	267	0	36	231	draft
3786	Nepal	2020-05-16	2020-05-17	291	1	36	254	draft
3787	Nepal	2020-05-17	2020-05-18	295	2	36	257	draft
3788	Nepal	2020-05-18	2020-05-19	375	2	36	337	draft
3789	Nepal	2020-05-19	2020-05-20	402	2	37	363	draft
3790	Nepal	2020-05-20	2020-05-21	427	2	45	380	draft
3791	Nepal	2020-05-21	2020-05-22	457	3	49	405	draft
3792	Nepal	2020-05-22	2020-05-23	516	3	70	443	draft
3793	Nepal	2020-05-23	2020-05-24	584	3	70	511	draft
3794	Nepal	2020-05-24	2020-05-25	603	3	87	513	draft
3795	Nepal	2020-05-25	2020-05-26	682	4	112	566	draft
3796	Nepal	2020-05-26	2020-05-27	772	4	155	613	draft
3797	Nepal	2020-05-27	2020-05-28	886	4	183	699	draft
3798	Nepal	2020-05-28	2020-05-29	1042	5	187	850	draft
3799	Nepal	2020-05-29	2020-05-30	1212	6	206	1000	draft
3800	Nepal	2020-05-30	2020-05-31	1401	6	219	1176	draft
3801	Nepal	2020-05-31	2020-06-01	1572	8	220	1344	draft
3802	Netherlands	2020-05-01	2020-05-02	39989	4909	138	34942	draft
3803	Netherlands	2020-05-02	2020-05-03	40434	5003	138	35293	draft
3804	Netherlands	2020-05-03	2020-05-04	40769	5072	138	35559	draft
3805	Netherlands	2020-05-04	2020-05-05	40968	5098	138	35732	draft
3806	Netherlands	2020-05-05	2020-05-06	41286	5185	139	35962	draft
3807	Netherlands	2020-05-06	2020-05-07	41518	5221	146	36151	draft
3808	Netherlands	2020-05-07	2020-05-08	41973	5306	147	36520	draft
3809	Netherlands	2020-05-08	2020-05-09	42292	5377	147	36768	draft
3810	Netherlands	2020-05-09	2020-05-10	42581	5441	149	36991	draft
3811	Netherlands	2020-05-10	2020-05-11	42826	5459	149	37218	draft
3812	Netherlands	2020-05-11	2020-05-12	42987	5475	149	37363	draft
3813	Netherlands	2020-05-12	2020-05-13	43183	5529	149	37505	draft
3814	Netherlands	2020-05-13	2020-05-14	43410	5581	157	37672	draft
3815	Netherlands	2020-05-14	2020-05-15	43680	5609	159	37912	draft
3816	Netherlands	2020-05-15	2020-05-16	43880	5662	159	38059	draft
3817	Netherlands	2020-05-16	2020-05-17	44070	5689	167	38214	draft
3818	Netherlands	2020-05-17	2020-05-18	44195	5699	167	38329	draft
3819	Netherlands	2020-05-18	2020-05-19	44341	5713	167	38461	draft
3820	Netherlands	2020-05-19	2020-05-20	44449	5734	167	38548	draft
3821	Netherlands	2020-05-20	2020-05-21	44647	5767	169	38711	draft
3822	Netherlands	2020-05-21	2020-05-22	44900	5794	169	38937	draft
3823	Netherlands	2020-05-22	2020-05-23	45088	5807	174	39107	draft
3824	Netherlands	2020-05-23	2020-05-24	45265	5830	174	39261	draft
3825	Netherlands	2020-05-24	2020-05-25	45437	5841	174	39422	draft
3826	Netherlands	2020-05-25	2020-05-26	45647	5849	174	39624	draft
3827	Netherlands	2020-05-26	2020-05-27	45780	5875	174	39731	draft
3828	Netherlands	2020-05-27	2020-05-28	45970	5890	177	39903	draft
3829	Netherlands	2020-05-28	2020-05-29	46152	5922	178	40052	draft
3830	Netherlands	2020-05-29	2020-05-30	46328	5950	178	40200	draft
3831	Netherlands	2020-05-30	2020-05-31	46460	5970	178	40312	draft
3832	Netherlands	2020-05-31	2020-06-01	46645	5975	178	40492	draft
3833	New Zealand	2020-05-01	2020-05-02	1485	20	1263	202	draft
3834	New Zealand	2020-05-02	2020-05-03	1487	20	1266	201	draft
3835	New Zealand	2020-05-03	2020-05-04	1487	20	1276	191	draft
3836	New Zealand	2020-05-04	2020-05-05	1486	20	1302	164	draft
3837	New Zealand	2020-05-05	2020-05-06	1488	21	1316	151	draft
3838	New Zealand	2020-05-06	2020-05-07	1489	21	1332	136	draft
3839	New Zealand	2020-05-07	2020-05-08	1490	21	1347	122	draft
3840	New Zealand	2020-05-08	2020-05-09	1492	21	1368	103	draft
3841	New Zealand	2020-05-09	2020-05-10	1494	21	1371	102	draft
3842	New Zealand	2020-05-10	2020-05-11	1497	21	1386	90	draft
3843	New Zealand	2020-05-11	2020-05-12	1497	21	1398	78	draft
3844	New Zealand	2020-05-12	2020-05-13	1497	21	1402	74	draft
3845	New Zealand	2020-05-13	2020-05-14	1497	21	1411	65	draft
3846	New Zealand	2020-05-14	2020-05-15	1498	21	1421	56	draft
3847	New Zealand	2020-05-15	2020-05-16	1498	21	1428	49	draft
3848	New Zealand	2020-05-16	2020-05-17	1499	21	1433	45	draft
3849	New Zealand	2020-05-17	2020-05-18	1499	21	1433	45	draft
3850	New Zealand	2020-05-18	2020-05-19	1499	21	1433	45	draft
3851	New Zealand	2020-05-19	2020-05-20	1503	21	1447	35	draft
3852	New Zealand	2020-05-20	2020-05-21	1503	21	1452	30	draft
3853	New Zealand	2020-05-21	2020-05-22	1504	21	1455	28	draft
3854	New Zealand	2020-05-22	2020-05-23	1504	21	1455	28	draft
3855	New Zealand	2020-05-23	2020-05-24	1504	21	1456	27	draft
3856	New Zealand	2020-05-24	2020-05-25	1504	21	1456	27	draft
3857	New Zealand	2020-05-25	2020-05-26	1504	21	1461	22	draft
3858	New Zealand	2020-05-26	2020-05-27	1504	21	1462	21	draft
3859	New Zealand	2020-05-27	2020-05-28	1504	22	1474	8	draft
3860	New Zealand	2020-05-28	2020-05-29	1504	22	1481	1	draft
3861	New Zealand	2020-05-29	2020-05-30	1504	22	1481	1	draft
3862	New Zealand	2020-05-30	2020-05-31	1504	22	1481	1	draft
3863	New Zealand	2020-05-31	2020-06-01	1504	22	1481	1	draft
3864	Nicaragua	2020-05-01	2020-05-02	14	3	7	4	draft
3865	Nicaragua	2020-05-02	2020-05-03	14	3	7	4	draft
3866	Nicaragua	2020-05-03	2020-05-04	15	5	7	3	draft
3867	Nicaragua	2020-05-04	2020-05-05	15	5	7	3	draft
3868	Nicaragua	2020-05-05	2020-05-06	16	5	7	4	draft
3869	Nicaragua	2020-05-06	2020-05-07	16	5	7	4	draft
3870	Nicaragua	2020-05-07	2020-05-08	16	5	7	4	draft
3871	Nicaragua	2020-05-08	2020-05-09	16	5	7	4	draft
3872	Nicaragua	2020-05-09	2020-05-10	16	5	7	4	draft
3873	Nicaragua	2020-05-10	2020-05-11	16	5	7	4	draft
3874	Nicaragua	2020-05-11	2020-05-12	16	5	7	4	draft
3875	Nicaragua	2020-05-12	2020-05-13	25	8	7	10	draft
3876	Nicaragua	2020-05-13	2020-05-14	25	8	7	10	draft
3877	Nicaragua	2020-05-14	2020-05-15	25	8	7	10	draft
3878	Nicaragua	2020-05-15	2020-05-16	25	8	7	10	draft
3879	Nicaragua	2020-05-16	2020-05-17	25	8	7	10	draft
3880	Nicaragua	2020-05-17	2020-05-18	25	8	7	10	draft
3881	Nicaragua	2020-05-18	2020-05-19	25	8	7	10	draft
3882	Nicaragua	2020-05-19	2020-05-20	254	17	199	38	draft
3883	Nicaragua	2020-05-20	2020-05-21	254	17	199	38	draft
3884	Nicaragua	2020-05-21	2020-05-22	279	17	199	63	draft
3885	Nicaragua	2020-05-22	2020-05-23	279	17	199	63	draft
3886	Nicaragua	2020-05-23	2020-05-24	279	17	199	63	draft
3887	Nicaragua	2020-05-24	2020-05-25	279	17	199	63	draft
3888	Nicaragua	2020-05-25	2020-05-26	279	17	199	63	draft
3889	Nicaragua	2020-05-26	2020-05-27	759	35	370	354	draft
3890	Nicaragua	2020-05-27	2020-05-28	759	35	370	354	draft
3891	Nicaragua	2020-05-28	2020-05-29	759	35	370	354	draft
3892	Nicaragua	2020-05-29	2020-05-30	759	35	370	354	draft
3893	Nicaragua	2020-05-30	2020-05-31	759	35	370	354	draft
3894	Nicaragua	2020-05-31	2020-06-01	759	35	370	354	draft
3895	Niger	2020-05-01	2020-05-02	728	33	478	217	draft
3896	Niger	2020-05-02	2020-05-03	736	35	507	194	draft
3897	Niger	2020-05-03	2020-05-04	750	36	518	196	draft
3898	Niger	2020-05-04	2020-05-05	755	37	534	184	draft
3899	Niger	2020-05-05	2020-05-06	763	38	543	182	draft
3900	Niger	2020-05-06	2020-05-07	770	38	561	171	draft
3901	Niger	2020-05-07	2020-05-08	781	42	586	153	draft
3902	Niger	2020-05-08	2020-05-09	795	44	600	151	draft
3903	Niger	2020-05-09	2020-05-10	815	45	617	153	draft
3904	Niger	2020-05-10	2020-05-11	821	46	624	151	draft
3905	Niger	2020-05-11	2020-05-12	832	46	637	149	draft
3906	Niger	2020-05-12	2020-05-13	854	47	648	159	draft
3907	Niger	2020-05-13	2020-05-14	860	49	658	153	draft
3908	Niger	2020-05-14	2020-05-15	876	50	677	149	draft
3909	Niger	2020-05-15	2020-05-16	885	51	684	150	draft
3910	Niger	2020-05-16	2020-05-17	889	51	689	149	draft
3911	Niger	2020-05-17	2020-05-18	904	54	698	152	draft
3912	Niger	2020-05-18	2020-05-19	909	55	714	140	draft
3913	Niger	2020-05-19	2020-05-20	914	55	734	125	draft
3914	Niger	2020-05-20	2020-05-21	920	58	738	124	draft
3915	Niger	2020-05-21	2020-05-22	924	60	753	111	draft
3916	Niger	2020-05-22	2020-05-23	937	60	764	113	draft
3917	Niger	2020-05-23	2020-05-24	943	61	775	107	draft
3918	Niger	2020-05-24	2020-05-25	945	61	783	101	draft
3919	Niger	2020-05-25	2020-05-26	951	62	786	103	draft
3920	Niger	2020-05-26	2020-05-27	952	63	796	93	draft
3921	Niger	2020-05-27	2020-05-28	952	63	796	93	draft
3922	Niger	2020-05-28	2020-05-29	955	64	803	88	draft
3923	Niger	2020-05-29	2020-05-30	955	64	813	78	draft
3924	Niger	2020-05-30	2020-05-31	956	64	818	74	draft
3925	Niger	2020-05-31	2020-06-01	958	64	839	55	draft
3926	Nigeria	2020-05-01	2020-05-02	2170	68	351	1751	draft
3927	Nigeria	2020-05-02	2020-05-03	2388	85	351	1952	draft
3928	Nigeria	2020-05-03	2020-05-04	2558	87	400	2071	draft
3929	Nigeria	2020-05-04	2020-05-05	2802	93	417	2292	draft
3930	Nigeria	2020-05-05	2020-05-06	2950	98	481	2371	draft
3931	Nigeria	2020-05-06	2020-05-07	3145	103	534	2508	draft
3932	Nigeria	2020-05-07	2020-05-08	3526	107	601	2818	draft
3933	Nigeria	2020-05-08	2020-05-09	3912	117	679	3116	draft
3934	Nigeria	2020-05-09	2020-05-10	4151	128	745	3278	draft
3935	Nigeria	2020-05-10	2020-05-11	4399	143	778	3478	draft
3936	Nigeria	2020-05-11	2020-05-12	4641	150	902	3589	draft
3937	Nigeria	2020-05-12	2020-05-13	4787	158	959	3670	draft
3938	Nigeria	2020-05-13	2020-05-14	4971	164	1070	3737	draft
3939	Nigeria	2020-05-14	2020-05-15	5162	167	1180	3815	draft
3940	Nigeria	2020-05-15	2020-05-16	5450	171	1320	3959	draft
3941	Nigeria	2020-05-16	2020-05-17	5621	176	1472	3973	draft
3942	Nigeria	2020-05-17	2020-05-18	5959	182	1594	4183	draft
3943	Nigeria	2020-05-18	2020-05-19	6175	191	1644	4340	draft
3944	Nigeria	2020-05-19	2020-05-20	6401	192	1734	4475	draft
3945	Nigeria	2020-05-20	2020-05-21	6677	200	1840	4637	draft
3946	Nigeria	2020-05-21	2020-05-22	7016	211	1907	4898	draft
3947	Nigeria	2020-05-22	2020-05-23	7261	221	2007	5033	draft
3948	Nigeria	2020-05-23	2020-05-24	7526	221	2174	5131	draft
3949	Nigeria	2020-05-24	2020-05-25	7839	226	2263	5350	draft
3950	Nigeria	2020-05-25	2020-05-26	8068	233	2311	5524	draft
3951	Nigeria	2020-05-26	2020-05-27	8344	249	2385	5710	draft
3952	Nigeria	2020-05-27	2020-05-28	8733	254	2501	5978	draft
3953	Nigeria	2020-05-28	2020-05-29	8915	259	2592	6064	draft
3954	Nigeria	2020-05-29	2020-05-30	9302	261	2697	6344	draft
3955	Nigeria	2020-05-30	2020-05-31	9855	273	2856	6726	draft
3956	Nigeria	2020-05-31	2020-06-01	10162	287	3007	6868	draft
3957	North Macedonia	2020-05-01	2020-05-02	1494	81	807	606	draft
3958	North Macedonia	2020-05-02	2020-05-03	1506	82	852	572	draft
3959	North Macedonia	2020-05-03	2020-05-04	1511	84	945	482	draft
3960	North Macedonia	2020-05-04	2020-05-05	1518	85	992	441	draft
3961	North Macedonia	2020-05-05	2020-05-06	1526	86	1013	427	draft
3962	North Macedonia	2020-05-06	2020-05-07	1539	88	1057	394	draft
3963	North Macedonia	2020-05-07	2020-05-08	1572	89	1079	404	draft
3964	North Macedonia	2020-05-08	2020-05-09	1586	90	1099	397	draft
3965	North Macedonia	2020-05-09	2020-05-10	1622	91	1112	419	draft
3966	North Macedonia	2020-05-10	2020-05-11	1642	91	1136	415	draft
3967	North Macedonia	2020-05-11	2020-05-12	1664	91	1200	373	draft
3968	North Macedonia	2020-05-12	2020-05-13	1674	92	1205	377	draft
3969	North Macedonia	2020-05-13	2020-05-14	1694	95	1229	370	draft
3970	North Macedonia	2020-05-14	2020-05-15	1723	95	1235	393	draft
3971	North Macedonia	2020-05-15	2020-05-16	1740	97	1251	392	draft
3972	North Macedonia	2020-05-16	2020-05-17	1762	98	1267	397	draft
3973	North Macedonia	2020-05-17	2020-05-18	1792	101	1293	398	draft
3974	North Macedonia	2020-05-18	2020-05-19	1817	104	1301	412	draft
3975	North Macedonia	2020-05-19	2020-05-20	1839	106	1351	382	draft
3976	North Macedonia	2020-05-20	2020-05-21	1858	110	1367	381	draft
3977	North Macedonia	2020-05-21	2020-05-22	1898	111	1378	409	draft
3978	North Macedonia	2020-05-22	2020-05-23	1921	112	1387	422	draft
3979	North Macedonia	2020-05-23	2020-05-24	1941	113	1411	417	draft
3980	North Macedonia	2020-05-24	2020-05-25	1978	113	1422	443	draft
3981	North Macedonia	2020-05-25	2020-05-26	1999	113	1439	447	draft
3982	North Macedonia	2020-05-26	2020-05-27	2014	116	1453	445	draft
3983	North Macedonia	2020-05-27	2020-05-28	2039	119	1470	450	draft
3984	North Macedonia	2020-05-28	2020-05-29	2077	121	1486	470	draft
3985	North Macedonia	2020-05-29	2020-05-30	2129	126	1516	487	draft
3986	North Macedonia	2020-05-30	2020-05-31	2164	131	1535	498	draft
3987	North Macedonia	2020-05-31	2020-06-01	2226	133	1552	541	draft
3988	Norway	2020-05-01	2020-05-02	7783	210	32	7541	draft
3989	Norway	2020-05-02	2020-05-03	7809	211	32	7566	draft
3990	Norway	2020-05-03	2020-05-04	7847	211	32	7604	draft
3991	Norway	2020-05-04	2020-05-05	7904	214	32	7658	draft
3992	Norway	2020-05-05	2020-05-06	7955	215	32	7708	draft
3993	Norway	2020-05-06	2020-05-07	7996	216	32	7748	draft
3994	Norway	2020-05-07	2020-05-08	8034	217	32	7785	draft
3995	Norway	2020-05-08	2020-05-09	8070	218	32	7820	draft
3996	Norway	2020-05-09	2020-05-10	8099	219	32	7848	draft
3997	Norway	2020-05-10	2020-05-11	8105	219	32	7854	draft
3998	Norway	2020-05-11	2020-05-12	8132	224	32	7876	draft
3999	Norway	2020-05-12	2020-05-13	8157	228	32	7897	draft
4000	Norway	2020-05-13	2020-05-14	8175	229	32	7914	draft
4001	Norway	2020-05-14	2020-05-15	8196	232	32	7932	draft
4002	Norway	2020-05-15	2020-05-16	8219	232	32	7955	draft
4003	Norway	2020-05-16	2020-05-17	8237	232	32	7973	draft
4004	Norway	2020-05-17	2020-05-18	8249	232	32	7985	draft
4005	Norway	2020-05-18	2020-05-19	8257	233	32	7992	draft
4006	Norway	2020-05-19	2020-05-20	8267	233	32	8002	draft
4007	Norway	2020-05-20	2020-05-21	8281	234	32	8015	draft
4008	Norway	2020-05-21	2020-05-22	8309	235	32	8042	draft
4009	Norway	2020-05-22	2020-05-23	8332	235	7727	370	draft
4010	Norway	2020-05-23	2020-05-24	8346	235	7727	384	draft
4011	Norway	2020-05-24	2020-05-25	8352	235	7727	390	draft
4012	Norway	2020-05-25	2020-05-26	8364	235	7727	402	draft
4013	Norway	2020-05-26	2020-05-27	8383	235	7727	421	draft
4014	Norway	2020-05-27	2020-05-28	8401	235	7727	439	draft
4015	Norway	2020-05-28	2020-05-29	8411	236	7727	448	draft
4016	Norway	2020-05-29	2020-05-30	8422	236	7727	459	draft
4017	Norway	2020-05-30	2020-05-31	8437	236	7727	474	draft
4018	Norway	2020-05-31	2020-06-01	8440	236	7727	477	draft
4019	Oman	2020-05-01	2020-05-02	2447	11	495	1941	draft
4020	Oman	2020-05-02	2020-05-03	2483	12	750	1721	draft
4021	Oman	2020-05-03	2020-05-04	2568	12	750	1806	draft
4022	Oman	2020-05-04	2020-05-05	2637	12	816	1809	draft
4023	Oman	2020-05-05	2020-05-06	2735	13	858	1864	draft
4024	Oman	2020-05-06	2020-05-07	2903	13	888	2002	draft
4025	Oman	2020-05-07	2020-05-08	2958	15	980	1963	draft
4026	Oman	2020-05-08	2020-05-09	3112	16	1025	2071	draft
4027	Oman	2020-05-09	2020-05-10	3224	17	1068	2139	draft
4028	Oman	2020-05-10	2020-05-11	3399	17	1117	2265	draft
4029	Oman	2020-05-11	2020-05-12	3573	17	1250	2306	draft
4030	Oman	2020-05-12	2020-05-13	3721	17	1250	2454	draft
4031	Oman	2020-05-13	2020-05-14	4019	17	1289	2713	draft
4032	Oman	2020-05-14	2020-05-15	4341	18	1303	3020	draft
4033	Oman	2020-05-15	2020-05-16	4625	20	1350	3255	draft
4034	Oman	2020-05-16	2020-05-17	5029	21	1436	3572	draft
4035	Oman	2020-05-17	2020-05-18	5186	22	1465	3699	draft
4036	Oman	2020-05-18	2020-05-19	5379	25	1496	3858	draft
4037	Oman	2020-05-19	2020-05-20	5671	27	1574	4070	draft
4038	Oman	2020-05-20	2020-05-21	6043	30	1661	4352	draft
4039	Oman	2020-05-21	2020-05-22	6370	31	1821	4518	draft
4040	Oman	2020-05-22	2020-05-23	6794	34	1821	4939	draft
4041	Oman	2020-05-23	2020-05-24	7257	36	1848	5373	draft
4042	Oman	2020-05-24	2020-05-25	7770	37	1933	5800	draft
4043	Oman	2020-05-25	2020-05-26	7770	37	1933	5800	draft
4044	Oman	2020-05-26	2020-05-27	8118	37	2067	6014	draft
4045	Oman	2020-05-27	2020-05-28	8373	39	2177	6157	draft
4046	Oman	2020-05-28	2020-05-29	9009	40	2177	6792	draft
4047	Oman	2020-05-29	2020-05-30	9820	40	2396	7384	draft
4048	Oman	2020-05-30	2020-05-31	10423	42	2396	7985	draft
4049	Oman	2020-05-31	2020-06-01	11437	49	2682	8706	draft
4050	Pakistan	2020-05-01	2020-05-02	18114	417	4715	12982	draft
4051	Pakistan	2020-05-02	2020-05-03	19103	440	4817	13846	draft
4052	Pakistan	2020-05-03	2020-05-04	20084	457	5114	14513	draft
4053	Pakistan	2020-05-04	2020-05-05	20941	476	5635	14830	draft
4054	Pakistan	2020-05-05	2020-05-06	22049	514	5801	15734	draft
4055	Pakistan	2020-05-06	2020-05-07	24073	564	6464	17045	draft
4056	Pakistan	2020-05-07	2020-05-08	24644	585	6464	17595	draft
4057	Pakistan	2020-05-08	2020-05-09	26435	599	7530	18306	draft
4058	Pakistan	2020-05-09	2020-05-10	28736	636	7809	20291	draft
4059	Pakistan	2020-05-10	2020-05-11	30334	659	8063	21612	draft
4060	Pakistan	2020-05-11	2020-05-12	32081	706	8555	22820	draft
4061	Pakistan	2020-05-12	2020-05-13	34336	737	8812	24787	draft
4062	Pakistan	2020-05-13	2020-05-14	35298	761	8899	25638	draft
4063	Pakistan	2020-05-14	2020-05-15	35788	770	9695	25323	draft
4064	Pakistan	2020-05-15	2020-05-16	38799	834	10880	27085	draft
4065	Pakistan	2020-05-16	2020-05-17	38799	834	10880	27085	draft
4066	Pakistan	2020-05-17	2020-05-18	40151	873	11341	27937	draft
4067	Pakistan	2020-05-18	2020-05-19	42125	903	11922	29300	draft
4068	Pakistan	2020-05-19	2020-05-20	43966	939	12489	30538	draft
4069	Pakistan	2020-05-20	2020-05-21	45898	985	13101	31812	draft
4070	Pakistan	2020-05-21	2020-05-22	48091	1017	14155	32919	draft
4071	Pakistan	2020-05-22	2020-05-23	50694	1067	15201	34426	draft
4072	Pakistan	2020-05-23	2020-05-24	52437	1101	16653	34683	draft
4073	Pakistan	2020-05-24	2020-05-25	54601	1133	17198	36270	draft
4074	Pakistan	2020-05-25	2020-05-26	56349	1167	17482	37700	draft
4075	Pakistan	2020-05-26	2020-05-27	57705	1197	18314	38194	draft
4076	Pakistan	2020-05-27	2020-05-28	59151	1225	19142	38784	draft
4077	Pakistan	2020-05-28	2020-05-29	61227	1260	20231	39736	draft
4078	Pakistan	2020-05-29	2020-05-30	64028	1317	22305	40406	draft
4079	Pakistan	2020-05-30	2020-05-31	66457	1395	24131	40931	draft
4080	Pakistan	2020-05-31	2020-06-01	69496	1483	25271	42742	draft
4081	Palau	2020-05-01	2020-05-02	0	0	0	0	draft
4082	Palau	2020-05-02	2020-05-03	0	0	0	0	draft
4083	Palau	2020-05-03	2020-05-04	0	0	0	0	draft
4084	Palau	2020-05-04	2020-05-05	0	0	0	0	draft
4085	Palau	2020-05-05	2020-05-06	0	0	0	0	draft
4086	Palau	2020-05-06	2020-05-07	0	0	0	0	draft
4087	Palau	2020-05-07	2020-05-08	0	0	0	0	draft
4088	Palau	2020-05-08	2020-05-09	0	0	0	0	draft
4089	Palau	2020-05-09	2020-05-10	0	0	0	0	draft
4090	Palau	2020-05-10	2020-05-11	0	0	0	0	draft
4091	Palau	2020-05-11	2020-05-12	0	0	0	0	draft
4092	Palau	2020-05-12	2020-05-13	0	0	0	0	draft
4093	Palau	2020-05-13	2020-05-14	0	0	0	0	draft
4094	Palau	2020-05-14	2020-05-15	0	0	0	0	draft
4095	Palau	2020-05-15	2020-05-16	0	0	0	0	draft
4096	Palau	2020-05-16	2020-05-17	0	0	0	0	draft
4097	Palau	2020-05-17	2020-05-18	0	0	0	0	draft
4098	Palau	2020-05-18	2020-05-19	0	0	0	0	draft
4099	Palau	2020-05-19	2020-05-20	0	0	0	0	draft
4100	Palau	2020-05-20	2020-05-21	0	0	0	0	draft
4101	Palau	2020-05-21	2020-05-22	0	0	0	0	draft
4102	Palau	2020-05-22	2020-05-23	0	0	0	0	draft
4103	Palau	2020-05-23	2020-05-24	0	0	0	0	draft
4104	Palau	2020-05-24	2020-05-25	0	0	0	0	draft
4105	Palau	2020-05-25	2020-05-26	0	0	0	0	draft
4106	Palau	2020-05-26	2020-05-27	0	0	0	0	draft
4107	Palau	2020-05-27	2020-05-28	0	0	0	0	draft
4108	Palau	2020-05-28	2020-05-29	0	0	0	0	draft
4109	Palau	2020-05-29	2020-05-30	0	0	0	0	draft
4110	Palau	2020-05-30	2020-05-31	0	0	0	0	draft
4111	Palau	2020-05-31	2020-06-01	0	0	0	0	draft
4112	Panama	2020-05-01	2020-05-02	6720	192	622	5906	draft
4113	Panama	2020-05-02	2020-05-03	7090	197	641	6252	draft
4114	Panama	2020-05-03	2020-05-04	7090	197	641	6252	draft
4115	Panama	2020-05-04	2020-05-05	7197	200	641	6356	draft
4116	Panama	2020-05-05	2020-05-06	7523	210	823	6490	draft
4117	Panama	2020-05-06	2020-05-07	7731	218	859	6654	draft
4118	Panama	2020-05-07	2020-05-08	7868	225	886	6757	draft
4119	Panama	2020-05-08	2020-05-09	8070	231	886	6953	draft
4120	Panama	2020-05-09	2020-05-10	8282	237	4501	3544	draft
4121	Panama	2020-05-10	2020-05-11	8448	244	4687	3517	draft
4122	Panama	2020-05-11	2020-05-12	8616	249	4687	3680	draft
4123	Panama	2020-05-12	2020-05-13	8783	252	6021	2510	draft
4124	Panama	2020-05-13	2020-05-14	8944	256	6067	2621	draft
4125	Panama	2020-05-14	2020-05-15	9118	260	6080	2778	draft
4126	Panama	2020-05-15	2020-05-16	9268	266	6080	2922	draft
4127	Panama	2020-05-16	2020-05-17	9449	269	6080	3100	draft
4128	Panama	2020-05-17	2020-05-18	9606	275	6081	3250	draft
4129	Panama	2020-05-18	2020-05-19	9726	279	6081	3366	draft
4130	Panama	2020-05-19	2020-05-20	9867	281	6194	3392	draft
4131	Panama	2020-05-20	2020-05-21	9977	287	6194	3496	draft
4132	Panama	2020-05-21	2020-05-22	10116	291	6245	3580	draft
4133	Panama	2020-05-22	2020-05-23	10267	295	6275	3697	draft
4134	Panama	2020-05-23	2020-05-24	10577	299	6279	3999	draft
4135	Panama	2020-05-24	2020-05-25	10926	306	6279	4341	draft
4136	Panama	2020-05-25	2020-05-26	11183	310	6279	4594	draft
4137	Panama	2020-05-26	2020-05-27	11447	313	6379	4755	draft
4138	Panama	2020-05-27	2020-05-28	11728	315	7379	4034	draft
4139	Panama	2020-05-28	2020-05-29	12131	320	7379	4432	draft
4140	Panama	2020-05-29	2020-05-30	12531	326	7540	4665	draft
4141	Panama	2020-05-30	2020-05-31	13018	330	9414	3274	draft
4142	Panama	2020-05-31	2020-06-01	13463	336	9514	3613	draft
4143	Papua New Guinea	2020-05-01	2020-05-02	8	0	0	8	draft
4144	Papua New Guinea	2020-05-02	2020-05-03	8	0	0	8	draft
4145	Papua New Guinea	2020-05-03	2020-05-04	8	0	0	8	draft
4146	Papua New Guinea	2020-05-04	2020-05-05	8	0	8	0	draft
4147	Papua New Guinea	2020-05-05	2020-05-06	8	0	8	0	draft
4148	Papua New Guinea	2020-05-06	2020-05-07	8	0	8	0	draft
4149	Papua New Guinea	2020-05-07	2020-05-08	8	0	8	0	draft
4150	Papua New Guinea	2020-05-08	2020-05-09	8	0	8	0	draft
4151	Papua New Guinea	2020-05-09	2020-05-10	8	0	8	0	draft
4152	Papua New Guinea	2020-05-10	2020-05-11	8	0	8	0	draft
4153	Papua New Guinea	2020-05-11	2020-05-12	8	0	8	0	draft
4154	Papua New Guinea	2020-05-12	2020-05-13	8	0	8	0	draft
4155	Papua New Guinea	2020-05-13	2020-05-14	8	0	8	0	draft
4156	Papua New Guinea	2020-05-14	2020-05-15	8	0	8	0	draft
4157	Papua New Guinea	2020-05-15	2020-05-16	8	0	8	0	draft
4158	Papua New Guinea	2020-05-16	2020-05-17	8	0	8	0	draft
4159	Papua New Guinea	2020-05-17	2020-05-18	8	0	8	0	draft
4160	Papua New Guinea	2020-05-18	2020-05-19	8	0	8	0	draft
4161	Papua New Guinea	2020-05-19	2020-05-20	8	0	8	0	draft
4162	Papua New Guinea	2020-05-20	2020-05-21	8	0	8	0	draft
4163	Papua New Guinea	2020-05-21	2020-05-22	8	0	8	0	draft
4164	Papua New Guinea	2020-05-22	2020-05-23	8	0	8	0	draft
4165	Papua New Guinea	2020-05-23	2020-05-24	8	0	8	0	draft
4166	Papua New Guinea	2020-05-24	2020-05-25	8	0	8	0	draft
4167	Papua New Guinea	2020-05-25	2020-05-26	8	0	8	0	draft
4168	Papua New Guinea	2020-05-26	2020-05-27	8	0	8	0	draft
4169	Papua New Guinea	2020-05-27	2020-05-28	8	0	8	0	draft
4170	Papua New Guinea	2020-05-28	2020-05-29	8	0	8	0	draft
4171	Papua New Guinea	2020-05-29	2020-05-30	8	0	8	0	draft
4172	Papua New Guinea	2020-05-30	2020-05-31	8	0	8	0	draft
4173	Papua New Guinea	2020-05-31	2020-06-01	8	0	8	0	draft
4174	Paraguay	2020-05-01	2020-05-02	333	10	115	208	draft
4175	Paraguay	2020-05-02	2020-05-03	370	10	119	241	draft
4176	Paraguay	2020-05-03	2020-05-04	396	10	126	260	draft
4177	Paraguay	2020-05-04	2020-05-05	415	10	130	275	draft
4178	Paraguay	2020-05-05	2020-05-06	431	10	135	286	draft
4179	Paraguay	2020-05-06	2020-05-07	440	10	142	288	draft
4180	Paraguay	2020-05-07	2020-05-08	462	10	148	304	draft
4181	Paraguay	2020-05-08	2020-05-09	563	10	152	401	draft
4182	Paraguay	2020-05-09	2020-05-10	689	10	155	524	draft
4183	Paraguay	2020-05-10	2020-05-11	713	10	165	538	draft
4184	Paraguay	2020-05-11	2020-05-12	724	10	170	544	draft
4185	Paraguay	2020-05-12	2020-05-13	737	10	173	554	draft
4186	Paraguay	2020-05-13	2020-05-14	740	11	182	547	draft
4187	Paraguay	2020-05-14	2020-05-15	754	11	184	559	draft
4188	Paraguay	2020-05-15	2020-05-16	759	11	193	555	draft
4189	Paraguay	2020-05-16	2020-05-17	778	11	198	569	draft
4190	Paraguay	2020-05-17	2020-05-18	786	11	202	573	draft
4191	Paraguay	2020-05-18	2020-05-19	788	11	219	558	draft
4192	Paraguay	2020-05-19	2020-05-20	829	11	230	588	draft
4193	Paraguay	2020-05-20	2020-05-21	833	11	242	580	draft
4194	Paraguay	2020-05-21	2020-05-22	836	11	256	569	draft
4195	Paraguay	2020-05-22	2020-05-23	838	11	264	563	draft
4196	Paraguay	2020-05-23	2020-05-24	850	11	298	541	draft
4197	Paraguay	2020-05-24	2020-05-25	862	11	307	544	draft
4198	Paraguay	2020-05-25	2020-05-26	865	11	344	510	draft
4199	Paraguay	2020-05-26	2020-05-27	877	11	382	484	draft
4200	Paraguay	2020-05-27	2020-05-28	884	11	392	481	draft
4201	Paraguay	2020-05-28	2020-05-29	900	11	402	487	draft
4202	Paraguay	2020-05-29	2020-05-30	917	11	413	493	draft
4203	Paraguay	2020-05-30	2020-05-31	964	11	466	487	draft
4204	Paraguay	2020-05-31	2020-06-01	986	11	477	498	draft
4205	Peru	2020-05-01	2020-05-02	40459	5181	11129	28206	draft
4206	Peru	2020-05-02	2020-05-03	42534	5589	12434	28900	draft
4207	Peru	2020-05-03	2020-05-04	45928	6004	13550	31092	draft
4208	Peru	2020-05-04	2020-05-05	47372	6442	14427	31601	draft
4209	Peru	2020-05-05	2020-05-06	51189	6871	15413	34332	draft
4210	Peru	2020-05-06	2020-05-07	54817	7328	17527	35757	draft
4211	Peru	2020-05-07	2020-05-08	58526	7809	18388	38511	draft
4212	Peru	2020-05-08	2020-05-09	61847	8263	19012	41121	draft
4213	Peru	2020-05-09	2020-05-10	65015	8740	20246	42955	draft
4214	Peru	2020-05-10	2020-05-11	67307	9258	21349	44069	draft
4215	Peru	2020-05-11	2020-05-12	68822	9778	22406	44455	draft
4216	Peru	2020-05-12	2020-05-13	72059	10294	23324	46678	draft
4217	Peru	2020-05-13	2020-05-14	76306	10760	24324	49813	draft
4218	Peru	2020-05-14	2020-05-15	80604	11277	25151	53186	draft
4219	Peru	2020-05-15	2020-05-16	84495	11824	27147	54956	draft
4220	Peru	2020-05-16	2020-05-17	88541	12333	28272	57746	draft
4221	Peru	2020-05-17	2020-05-18	92273	12835	28621	61004	draft
4222	Peru	2020-05-18	2020-05-19	94933	13369	30306	61838	draft
4223	Peru	2020-05-19	2020-05-20	99483	13984	36524	60045	draft
4224	Peru	2020-05-20	2020-05-21	104020	14512	41968	59028	draft
4225	Peru	2020-05-21	2020-05-22	108769	15056	43587	62034	draft
4226	Peru	2020-05-22	2020-05-23	111698	15583	44848	63606	draft
4227	Peru	2020-05-23	2020-05-24	115754	16101	47915	64466	draft
4228	Peru	2020-05-24	2020-05-25	119959	16644	49795	66708	draft
4229	Peru	2020-05-25	2020-05-26	123979	17216	50949	69401	draft
4230	Peru	2020-05-26	2020-05-27	129751	17796	52906	73057	draft
4231	Peru	2020-05-27	2020-05-28	135905	18340	56169	75753	draft
4232	Peru	2020-05-28	2020-05-29	141779	18924	59442	78238	draft
4233	Peru	2020-05-29	2020-05-30	141779	19478	62791	74889	draft
4234	Peru	2020-05-30	2020-05-31	155671	20111	66447	84853	draft
4235	Peru	2020-05-31	2020-06-01	164476	20710	67208	92762	draft
4236	Philippines	2020-05-01	2020-05-02	8772	579	1084	7109	draft
4237	Philippines	2020-05-02	2020-05-03	8928	603	1124	7201	draft
4238	Philippines	2020-05-03	2020-05-04	9223	607	1214	7402	draft
4239	Philippines	2020-05-04	2020-05-05	9485	623	1315	7547	draft
4240	Philippines	2020-05-05	2020-05-06	9684	637	1408	7639	draft
4241	Philippines	2020-05-06	2020-05-07	10004	658	1506	7840	draft
4242	Philippines	2020-05-07	2020-05-08	10343	685	1618	8040	draft
4243	Philippines	2020-05-08	2020-05-09	10463	696	1734	8033	draft
4244	Philippines	2020-05-09	2020-05-10	10610	704	1842	8064	draft
4245	Philippines	2020-05-10	2020-05-11	10794	719	1924	8151	draft
4246	Philippines	2020-05-11	2020-05-12	11086	726	1999	8361	draft
4247	Philippines	2020-05-12	2020-05-13	11350	751	2106	8493	draft
4248	Philippines	2020-05-13	2020-05-14	11618	772	2251	8595	draft
4249	Philippines	2020-05-14	2020-05-15	11876	790	2337	8749	draft
4250	Philippines	2020-05-15	2020-05-16	12091	806	2460	8825	draft
4251	Philippines	2020-05-16	2020-05-17	12305	817	2561	8927	draft
4252	Philippines	2020-05-17	2020-05-18	12513	824	2635	9054	draft
4253	Philippines	2020-05-18	2020-05-19	12718	831	2729	9158	draft
4254	Philippines	2020-05-19	2020-05-20	12942	837	2843	9262	draft
4255	Philippines	2020-05-20	2020-05-21	13221	842	2932	9447	draft
4256	Philippines	2020-05-21	2020-05-22	13434	846	3000	9588	draft
4257	Philippines	2020-05-22	2020-05-23	13597	857	3092	9648	draft
4258	Philippines	2020-05-23	2020-05-24	13777	863	3177	9737	draft
4259	Philippines	2020-05-24	2020-05-25	14035	868	3249	9918	draft
4260	Philippines	2020-05-25	2020-05-26	14319	873	3323	10123	draft
4261	Philippines	2020-05-26	2020-05-27	14669	886	3412	10371	draft
4262	Philippines	2020-05-27	2020-05-28	15049	904	3506	10639	draft
4263	Philippines	2020-05-28	2020-05-29	15588	921	3598	11069	draft
4264	Philippines	2020-05-29	2020-05-30	16634	942	3720	11972	draft
4265	Philippines	2020-05-30	2020-05-31	17224	950	3808	12466	draft
4266	Philippines	2020-05-31	2020-06-01	18086	957	3909	13220	draft
4267	Poland	2020-05-01	2020-05-02	13105	651	3491	8963	draft
4268	Poland	2020-05-02	2020-05-03	13375	664	3762	8949	draft
4269	Poland	2020-05-03	2020-05-04	13693	678	3945	9070	draft
4270	Poland	2020-05-04	2020-05-05	14006	698	4095	9213	draft
4271	Poland	2020-05-05	2020-05-06	14431	716	4280	9435	draft
4272	Poland	2020-05-06	2020-05-07	14740	733	4655	9352	draft
4273	Poland	2020-05-07	2020-05-08	15047	755	4862	9430	draft
4274	Poland	2020-05-08	2020-05-09	15366	776	5184	9406	draft
4275	Poland	2020-05-09	2020-05-10	15651	785	5437	9429	draft
4276	Poland	2020-05-10	2020-05-11	15996	800	5698	9498	draft
4277	Poland	2020-05-11	2020-05-12	16326	811	5816	9699	draft
4278	Poland	2020-05-12	2020-05-13	16921	839	6131	9951	draft
4279	Poland	2020-05-13	2020-05-14	17204	861	6410	9933	draft
4280	Poland	2020-05-14	2020-05-15	17615	883	6696	10036	draft
4281	Poland	2020-05-15	2020-05-16	18016	907	6918	10191	draft
4282	Poland	2020-05-16	2020-05-17	18257	915	7175	10167	draft
4283	Poland	2020-05-17	2020-05-18	18529	925	7451	10153	draft
4284	Poland	2020-05-18	2020-05-19	18885	936	7628	10321	draft
4285	Poland	2020-05-19	2020-05-20	19268	948	7903	10417	draft
4286	Poland	2020-05-20	2020-05-21	19739	962	8183	10594	draft
4287	Poland	2020-05-21	2020-05-22	20143	972	8452	10719	draft
4288	Poland	2020-05-22	2020-05-23	20619	982	8731	10906	draft
4289	Poland	2020-05-23	2020-05-24	20931	993	8977	10961	draft
4290	Poland	2020-05-24	2020-05-25	21326	996	9194	11136	draft
4291	Poland	2020-05-25	2020-05-26	21631	1007	9276	11348	draft
4292	Poland	2020-05-26	2020-05-27	22074	1024	10020	11030	draft
4293	Poland	2020-05-27	2020-05-28	22473	1028	10330	11115	draft
4294	Poland	2020-05-28	2020-05-29	22825	1038	10560	11227	draft
4295	Poland	2020-05-29	2020-05-30	23155	1051	10692	11412	draft
4296	Poland	2020-05-30	2020-05-31	23571	1061	11016	11494	draft
4297	Poland	2020-05-31	2020-06-01	23786	1064	11271	11451	draft
4298	Portugal	2020-05-01	2020-05-02	25351	1007	1647	22697	draft
4299	Portugal	2020-05-02	2020-05-03	25190	1023	1671	22496	draft
4300	Portugal	2020-05-03	2020-05-04	25282	1043	1689	22550	draft
4301	Portugal	2020-05-04	2020-05-05	25524	1063	1712	22749	draft
4302	Portugal	2020-05-05	2020-05-06	25702	1074	1743	22885	draft
4303	Portugal	2020-05-06	2020-05-07	26182	1089	2076	23017	draft
4304	Portugal	2020-05-07	2020-05-08	26715	1105	2258	23352	draft
4305	Portugal	2020-05-08	2020-05-09	27268	1114	2422	23732	draft
4306	Portugal	2020-05-09	2020-05-10	27406	1126	2499	23781	draft
4307	Portugal	2020-05-10	2020-05-11	27581	1135	2549	23897	draft
4308	Portugal	2020-05-11	2020-05-12	27679	1144	2549	23986	draft
4309	Portugal	2020-05-12	2020-05-13	27913	1163	3013	23737	draft
4310	Portugal	2020-05-13	2020-05-14	28132	1175	3182	23775	draft
4311	Portugal	2020-05-14	2020-05-15	28319	1184	3198	23937	draft
4312	Portugal	2020-05-15	2020-05-16	28583	1190	3328	24065	draft
4313	Portugal	2020-05-16	2020-05-17	28810	1203	3822	23785	draft
4314	Portugal	2020-05-17	2020-05-18	29036	1218	4636	23182	draft
4315	Portugal	2020-05-18	2020-05-19	29209	1231	6430	21548	draft
4316	Portugal	2020-05-19	2020-05-20	29432	1247	6431	21754	draft
4317	Portugal	2020-05-20	2020-05-21	29660	1263	6452	21945	draft
4318	Portugal	2020-05-21	2020-05-22	29912	1277	6452	22183	draft
4319	Portugal	2020-05-22	2020-05-23	30200	1289	7590	21321	draft
4320	Portugal	2020-05-23	2020-05-24	30471	1302	7705	21464	draft
4321	Portugal	2020-05-24	2020-05-25	30623	1316	17549	11758	draft
4322	Portugal	2020-05-25	2020-05-26	30788	1330	17822	11636	draft
4323	Portugal	2020-05-26	2020-05-27	31007	1342	18096	11569	draft
4324	Portugal	2020-05-27	2020-05-28	31292	1356	18349	11587	draft
4325	Portugal	2020-05-28	2020-05-29	31596	1369	18637	11590	draft
4326	Portugal	2020-05-29	2020-05-30	31946	1383	18911	11652	draft
4327	Portugal	2020-05-30	2020-05-31	32203	1396	19186	11621	draft
4328	Portugal	2020-05-31	2020-06-01	32500	1410	19409	11681	draft
4329	Qatar	2020-05-01	2020-05-02	14096	12	1436	12648	draft
4330	Qatar	2020-05-02	2020-05-03	14872	12	1534	13326	draft
4331	Qatar	2020-05-03	2020-05-04	15551	12	1664	13875	draft
4332	Qatar	2020-05-04	2020-05-05	16191	12	1810	14369	draft
4333	Qatar	2020-05-05	2020-05-06	17142	12	1924	15206	draft
4334	Qatar	2020-05-06	2020-05-07	17972	12	2070	15890	draft
4335	Qatar	2020-05-07	2020-05-08	18890	12	2286	16592	draft
4336	Qatar	2020-05-08	2020-05-09	20201	12	2370	17819	draft
4337	Qatar	2020-05-09	2020-05-10	21331	13	2449	18869	draft
4338	Qatar	2020-05-10	2020-05-11	22520	14	2753	19753	draft
4339	Qatar	2020-05-11	2020-05-12	23623	14	2840	20769	draft
4340	Qatar	2020-05-12	2020-05-13	25149	14	3019	22116	draft
4341	Qatar	2020-05-13	2020-05-14	26539	14	3143	23382	draft
4342	Qatar	2020-05-14	2020-05-15	28272	14	3356	24902	draft
4343	Qatar	2020-05-15	2020-05-16	29425	14	3546	25865	draft
4344	Qatar	2020-05-16	2020-05-17	30972	15	3788	27169	draft
4345	Qatar	2020-05-17	2020-05-18	32604	15	4370	28219	draft
4346	Qatar	2020-05-18	2020-05-19	33969	15	4899	29055	draft
4347	Qatar	2020-05-19	2020-05-20	35606	15	5634	29957	draft
4348	Qatar	2020-05-20	2020-05-21	37097	16	6600	30481	draft
4349	Qatar	2020-05-21	2020-05-22	38651	17	7288	31346	draft
4350	Qatar	2020-05-22	2020-05-23	40481	19	7893	32569	draft
4351	Qatar	2020-05-23	2020-05-24	42213	21	8513	33679	draft
4352	Qatar	2020-05-24	2020-05-25	43714	23	9170	34521	draft
4353	Qatar	2020-05-25	2020-05-26	45465	26	10363	35076	draft
4354	Qatar	2020-05-26	2020-05-27	47207	28	11844	35335	draft
4355	Qatar	2020-05-27	2020-05-28	48947	30	13283	35634	draft
4356	Qatar	2020-05-28	2020-05-29	50914	33	15399	35482	draft
4357	Qatar	2020-05-29	2020-05-30	52907	36	20604	32267	draft
4358	Qatar	2020-05-30	2020-05-31	55262	36	25839	29387	draft
4359	Qatar	2020-05-31	2020-06-01	56910	38	30290	26582	draft
4360	Romania	2020-05-01	2020-05-02	12567	744	4328	7495	draft
4361	Romania	2020-05-02	2020-05-03	12732	771	4547	7414	draft
4362	Romania	2020-05-03	2020-05-04	13163	790	4869	7504	draft
4363	Romania	2020-05-04	2020-05-05	13512	818	5269	7425	draft
4364	Romania	2020-05-05	2020-05-06	13837	841	5454	7542	draft
4365	Romania	2020-05-06	2020-05-07	14107	864	5788	7455	draft
4366	Romania	2020-05-07	2020-05-08	14499	888	6144	7467	draft
4367	Romania	2020-05-08	2020-05-09	14811	923	6423	7465	draft
4368	Romania	2020-05-09	2020-05-10	15131	939	6912	7280	draft
4369	Romania	2020-05-10	2020-05-11	15362	961	7051	7350	draft
4370	Romania	2020-05-11	2020-05-12	15588	982	7245	7361	draft
4371	Romania	2020-05-12	2020-05-13	15778	1002	7685	7091	draft
4372	Romania	2020-05-13	2020-05-14	16002	1036	7961	7005	draft
4373	Romania	2020-05-14	2020-05-15	16247	1053	9053	6141	draft
4374	Romania	2020-05-15	2020-05-16	16437	1070	9370	5997	draft
4375	Romania	2020-05-16	2020-05-17	16704	1094	9574	6036	draft
4376	Romania	2020-05-17	2020-05-18	16871	1107	9890	5874	draft
4377	Romania	2020-05-18	2020-05-19	17036	1120	9930	5986	draft
4378	Romania	2020-05-19	2020-05-20	17191	1137	10166	5888	draft
4379	Romania	2020-05-20	2020-05-21	17387	1147	10356	5884	draft
4380	Romania	2020-05-21	2020-05-22	17585	1156	10581	5848	draft
4381	Romania	2020-05-22	2020-05-23	17712	1166	10777	5769	draft
4382	Romania	2020-05-23	2020-05-24	17857	1176	11187	5494	draft
4383	Romania	2020-05-24	2020-05-25	18070	1185	11399	5486	draft
4384	Romania	2020-05-25	2020-05-26	18283	1205	11630	5448	draft
4385	Romania	2020-05-26	2020-05-27	18429	1216	11874	5339	draft
4386	Romania	2020-05-27	2020-05-28	18594	1227	12162	5205	draft
4387	Romania	2020-05-28	2020-05-29	18791	1235	12629	4927	draft
4388	Romania	2020-05-29	2020-05-30	18982	1248	12829	4905	draft
4389	Romania	2020-05-30	2020-05-31	19133	1259	13046	4828	draft
4390	Romania	2020-05-31	2020-06-01	19257	1266	13256	4735	draft
4391	Russia	2020-05-01	2020-05-02	114431	1169	13220	100042	draft
4392	Russia	2020-05-02	2020-05-03	124054	1222	15013	107819	draft
4393	Russia	2020-05-03	2020-05-04	134687	1280	16639	116768	draft
4394	Russia	2020-05-04	2020-05-05	145268	1356	18095	125817	draft
4395	Russia	2020-05-05	2020-05-06	155370	1451	19865	134054	draft
4396	Russia	2020-05-06	2020-05-07	165929	1537	21327	143065	draft
4397	Russia	2020-05-07	2020-05-08	177160	1625	23803	151732	draft
4398	Russia	2020-05-08	2020-05-09	187859	1723	26608	159528	draft
4399	Russia	2020-05-09	2020-05-10	198676	1827	31916	164933	draft
4400	Russia	2020-05-10	2020-05-11	209688	1915	34306	173467	draft
4401	Russia	2020-05-11	2020-05-12	221344	2009	39801	179534	draft
4402	Russia	2020-05-12	2020-05-13	232243	2116	43512	186615	draft
4403	Russia	2020-05-13	2020-05-14	242271	2212	48003	192056	draft
4404	Russia	2020-05-14	2020-05-15	252245	2305	53530	196410	draft
4405	Russia	2020-05-15	2020-05-16	262843	2418	58226	202199	draft
4406	Russia	2020-05-16	2020-05-17	272043	2537	63166	206340	draft
4407	Russia	2020-05-17	2020-05-18	281752	2631	67373	211748	draft
4408	Russia	2020-05-18	2020-05-19	290678	2722	70209	217747	draft
4409	Russia	2020-05-19	2020-05-20	299941	2837	76130	220974	draft
4410	Russia	2020-05-20	2020-05-21	308705	2972	85392	220341	draft
4411	Russia	2020-05-21	2020-05-22	317554	3099	92681	221774	draft
4412	Russia	2020-05-22	2020-05-23	326448	3249	99825	223374	draft
4413	Russia	2020-05-23	2020-05-24	335882	3388	107936	224558	draft
4414	Russia	2020-05-24	2020-05-25	344481	3541	113299	227641	draft
4415	Russia	2020-05-25	2020-05-26	353427	3633	118798	230996	draft
4416	Russia	2020-05-26	2020-05-27	362342	3807	131129	227406	draft
4417	Russia	2020-05-27	2020-05-28	370680	3968	142208	224504	draft
4418	Russia	2020-05-28	2020-05-29	379051	4142	150993	223916	draft
4419	Russia	2020-05-29	2020-05-30	387623	4374	159257	223992	draft
4420	Russia	2020-05-30	2020-05-31	396575	4555	167469	224551	draft
4421	Russia	2020-05-31	2020-06-01	405843	4693	171883	229267	draft
4422	Rwanda	2020-05-01	2020-05-02	249	0	109	140	draft
4423	Rwanda	2020-05-02	2020-05-03	255	0	120	135	draft
4424	Rwanda	2020-05-03	2020-05-04	259	0	124	135	draft
4425	Rwanda	2020-05-04	2020-05-05	261	0	128	133	draft
4426	Rwanda	2020-05-05	2020-05-06	261	0	129	132	draft
4427	Rwanda	2020-05-06	2020-05-07	268	0	130	138	draft
4428	Rwanda	2020-05-07	2020-05-08	271	0	133	138	draft
4429	Rwanda	2020-05-08	2020-05-09	273	0	136	137	draft
4430	Rwanda	2020-05-09	2020-05-10	280	0	140	140	draft
4431	Rwanda	2020-05-10	2020-05-11	284	0	140	144	draft
4432	Rwanda	2020-05-11	2020-05-12	285	0	150	135	draft
4433	Rwanda	2020-05-12	2020-05-13	286	0	153	133	draft
4434	Rwanda	2020-05-13	2020-05-14	287	0	164	123	draft
4435	Rwanda	2020-05-14	2020-05-15	287	0	168	119	draft
4436	Rwanda	2020-05-15	2020-05-16	287	0	177	110	draft
4437	Rwanda	2020-05-16	2020-05-17	289	0	178	111	draft
4438	Rwanda	2020-05-17	2020-05-18	292	0	197	95	draft
4439	Rwanda	2020-05-18	2020-05-19	297	0	203	94	draft
4440	Rwanda	2020-05-19	2020-05-20	308	0	209	99	draft
4441	Rwanda	2020-05-20	2020-05-21	314	0	216	98	draft
4442	Rwanda	2020-05-21	2020-05-22	320	0	217	103	draft
4443	Rwanda	2020-05-22	2020-05-23	321	0	222	99	draft
4444	Rwanda	2020-05-23	2020-05-24	325	0	227	98	draft
4445	Rwanda	2020-05-24	2020-05-25	327	0	237	90	draft
4446	Rwanda	2020-05-25	2020-05-26	336	0	238	98	draft
4447	Rwanda	2020-05-26	2020-05-27	339	0	244	95	draft
4448	Rwanda	2020-05-27	2020-05-28	346	0	245	101	draft
4449	Rwanda	2020-05-28	2020-05-29	349	0	245	104	draft
4450	Rwanda	2020-05-29	2020-05-30	355	0	247	108	draft
4451	Rwanda	2020-05-30	2020-05-31	359	1	250	108	draft
4452	Rwanda	2020-05-31	2020-06-01	370	1	256	113	draft
4453	Saint Kitts and Nevis	2020-05-01	2020-05-02	15	0	8	7	draft
4454	Saint Kitts and Nevis	2020-05-02	2020-05-03	15	0	8	7	draft
4455	Saint Kitts and Nevis	2020-05-03	2020-05-04	15	0	8	7	draft
4456	Saint Kitts and Nevis	2020-05-04	2020-05-05	15	0	8	7	draft
4457	Saint Kitts and Nevis	2020-05-05	2020-05-06	15	0	12	3	draft
4458	Saint Kitts and Nevis	2020-05-06	2020-05-07	15	0	12	3	draft
4459	Saint Kitts and Nevis	2020-05-07	2020-05-08	15	0	12	3	draft
4460	Saint Kitts and Nevis	2020-05-08	2020-05-09	15	0	13	2	draft
4461	Saint Kitts and Nevis	2020-05-09	2020-05-10	15	0	14	1	draft
4462	Saint Kitts and Nevis	2020-05-10	2020-05-11	15	0	14	1	draft
4463	Saint Kitts and Nevis	2020-05-11	2020-05-12	15	0	14	1	draft
4464	Saint Kitts and Nevis	2020-05-12	2020-05-13	15	0	14	1	draft
4465	Saint Kitts and Nevis	2020-05-13	2020-05-14	15	0	14	1	draft
4466	Saint Kitts and Nevis	2020-05-14	2020-05-15	15	0	14	1	draft
4467	Saint Kitts and Nevis	2020-05-15	2020-05-16	15	0	14	1	draft
4468	Saint Kitts and Nevis	2020-05-16	2020-05-17	15	0	14	1	draft
4469	Saint Kitts and Nevis	2020-05-17	2020-05-18	15	0	14	1	draft
4470	Saint Kitts and Nevis	2020-05-18	2020-05-19	15	0	14	1	draft
4471	Saint Kitts and Nevis	2020-05-19	2020-05-20	15	0	15	0	draft
4472	Saint Kitts and Nevis	2020-05-20	2020-05-21	15	0	15	0	draft
4473	Saint Kitts and Nevis	2020-05-21	2020-05-22	15	0	15	0	draft
4474	Saint Kitts and Nevis	2020-05-22	2020-05-23	15	0	15	0	draft
4475	Saint Kitts and Nevis	2020-05-23	2020-05-24	15	0	15	0	draft
4476	Saint Kitts and Nevis	2020-05-24	2020-05-25	15	0	15	0	draft
4477	Saint Kitts and Nevis	2020-05-25	2020-05-26	15	0	15	0	draft
4478	Saint Kitts and Nevis	2020-05-26	2020-05-27	15	0	15	0	draft
4479	Saint Kitts and Nevis	2020-05-27	2020-05-28	15	0	15	0	draft
4480	Saint Kitts and Nevis	2020-05-28	2020-05-29	15	0	15	0	draft
4481	Saint Kitts and Nevis	2020-05-29	2020-05-30	15	0	15	0	draft
4482	Saint Kitts and Nevis	2020-05-30	2020-05-31	15	0	15	0	draft
4591	San Marino	2020-05-15	2020-05-16	652	41	189	422	draft
4483	Saint Kitts and Nevis	2020-05-31	2020-06-01	15	0	15	0	draft
4484	Saint Lucia	2020-05-01	2020-05-02	17	0	15	2	draft
4485	Saint Lucia	2020-05-02	2020-05-03	17	0	15	2	draft
4486	Saint Lucia	2020-05-03	2020-05-04	18	0	15	3	draft
4487	Saint Lucia	2020-05-04	2020-05-05	18	0	15	3	draft
4488	Saint Lucia	2020-05-05	2020-05-06	18	0	15	3	draft
4489	Saint Lucia	2020-05-06	2020-05-07	18	0	15	3	draft
4490	Saint Lucia	2020-05-07	2020-05-08	18	0	17	1	draft
4491	Saint Lucia	2020-05-08	2020-05-09	18	0	17	1	draft
4492	Saint Lucia	2020-05-09	2020-05-10	18	0	17	1	draft
4493	Saint Lucia	2020-05-10	2020-05-11	18	0	17	1	draft
4494	Saint Lucia	2020-05-11	2020-05-12	18	0	17	1	draft
4495	Saint Lucia	2020-05-12	2020-05-13	18	0	17	1	draft
4496	Saint Lucia	2020-05-13	2020-05-14	18	0	18	0	draft
4497	Saint Lucia	2020-05-14	2020-05-15	18	0	18	0	draft
4498	Saint Lucia	2020-05-15	2020-05-16	18	0	18	0	draft
4499	Saint Lucia	2020-05-16	2020-05-17	18	0	18	0	draft
4500	Saint Lucia	2020-05-17	2020-05-18	18	0	18	0	draft
4501	Saint Lucia	2020-05-18	2020-05-19	18	0	18	0	draft
4502	Saint Lucia	2020-05-19	2020-05-20	18	0	18	0	draft
4503	Saint Lucia	2020-05-20	2020-05-21	18	0	18	0	draft
4504	Saint Lucia	2020-05-21	2020-05-22	18	0	18	0	draft
4505	Saint Lucia	2020-05-22	2020-05-23	18	0	18	0	draft
4506	Saint Lucia	2020-05-23	2020-05-24	18	0	18	0	draft
4507	Saint Lucia	2020-05-24	2020-05-25	18	0	18	0	draft
4508	Saint Lucia	2020-05-25	2020-05-26	18	0	18	0	draft
4509	Saint Lucia	2020-05-26	2020-05-27	18	0	18	0	draft
4510	Saint Lucia	2020-05-27	2020-05-28	18	0	18	0	draft
4511	Saint Lucia	2020-05-28	2020-05-29	18	0	18	0	draft
4512	Saint Lucia	2020-05-29	2020-05-30	18	0	18	0	draft
4513	Saint Lucia	2020-05-30	2020-05-31	18	0	18	0	draft
4514	Saint Lucia	2020-05-31	2020-06-01	18	0	18	0	draft
4515	Saint Vincent and the Grenadines	2020-05-01	2020-05-02	16	0	8	8	draft
4516	Saint Vincent and the Grenadines	2020-05-02	2020-05-03	16	0	8	8	draft
4517	Saint Vincent and the Grenadines	2020-05-03	2020-05-04	16	0	8	8	draft
4518	Saint Vincent and the Grenadines	2020-05-04	2020-05-05	17	0	9	8	draft
4519	Saint Vincent and the Grenadines	2020-05-05	2020-05-06	17	0	9	8	draft
4520	Saint Vincent and the Grenadines	2020-05-06	2020-05-07	17	0	9	8	draft
4521	Saint Vincent and the Grenadines	2020-05-07	2020-05-08	17	0	9	8	draft
4522	Saint Vincent and the Grenadines	2020-05-08	2020-05-09	17	0	9	8	draft
4523	Saint Vincent and the Grenadines	2020-05-09	2020-05-10	17	0	9	8	draft
4524	Saint Vincent and the Grenadines	2020-05-10	2020-05-11	17	0	9	8	draft
5070	Sudan	2020-05-29	2020-05-30	4346	233	816	3472	draft
4525	Saint Vincent and the Grenadines	2020-05-11	2020-05-12	17	0	9	8	draft
4526	Saint Vincent and the Grenadines	2020-05-12	2020-05-13	17	0	12	5	draft
4527	Saint Vincent and the Grenadines	2020-05-13	2020-05-14	17	0	12	5	draft
4528	Saint Vincent and the Grenadines	2020-05-14	2020-05-15	17	0	12	5	draft
4529	Saint Vincent and the Grenadines	2020-05-15	2020-05-16	17	0	14	3	draft
4530	Saint Vincent and the Grenadines	2020-05-16	2020-05-17	17	0	14	3	draft
4531	Saint Vincent and the Grenadines	2020-05-17	2020-05-18	17	0	14	3	draft
4532	Saint Vincent and the Grenadines	2020-05-18	2020-05-19	17	0	14	3	draft
4533	Saint Vincent and the Grenadines	2020-05-19	2020-05-20	17	0	14	3	draft
4534	Saint Vincent and the Grenadines	2020-05-20	2020-05-21	18	0	14	4	draft
4535	Saint Vincent and the Grenadines	2020-05-21	2020-05-22	18	0	14	4	draft
4536	Saint Vincent and the Grenadines	2020-05-22	2020-05-23	18	0	14	4	draft
4537	Saint Vincent and the Grenadines	2020-05-23	2020-05-24	18	0	14	4	draft
4538	Saint Vincent and the Grenadines	2020-05-24	2020-05-25	18	0	14	4	draft
4539	Saint Vincent and the Grenadines	2020-05-25	2020-05-26	18	0	14	4	draft
4540	Saint Vincent and the Grenadines	2020-05-26	2020-05-27	18	0	14	4	draft
4541	Saint Vincent and the Grenadines	2020-05-27	2020-05-28	18	0	14	4	draft
4542	Saint Vincent and the Grenadines	2020-05-28	2020-05-29	25	0	14	11	draft
4543	Saint Vincent and the Grenadines	2020-05-29	2020-05-30	26	0	14	12	draft
4544	Saint Vincent and the Grenadines	2020-05-30	2020-05-31	26	0	15	11	draft
4545	Saint Vincent and the Grenadines	2020-05-31	2020-06-01	26	0	15	11	draft
4546	Samoa	2020-05-01	2020-05-02	0	0	0	0	draft
4547	Samoa	2020-05-02	2020-05-03	0	0	0	0	draft
4548	Samoa	2020-05-03	2020-05-04	0	0	0	0	draft
4549	Samoa	2020-05-04	2020-05-05	0	0	0	0	draft
4550	Samoa	2020-05-05	2020-05-06	0	0	0	0	draft
4551	Samoa	2020-05-06	2020-05-07	0	0	0	0	draft
4552	Samoa	2020-05-07	2020-05-08	0	0	0	0	draft
4553	Samoa	2020-05-08	2020-05-09	0	0	0	0	draft
4554	Samoa	2020-05-09	2020-05-10	0	0	0	0	draft
4555	Samoa	2020-05-10	2020-05-11	0	0	0	0	draft
4556	Samoa	2020-05-11	2020-05-12	0	0	0	0	draft
4557	Samoa	2020-05-12	2020-05-13	0	0	0	0	draft
4558	Samoa	2020-05-13	2020-05-14	0	0	0	0	draft
4559	Samoa	2020-05-14	2020-05-15	0	0	0	0	draft
4560	Samoa	2020-05-15	2020-05-16	0	0	0	0	draft
4561	Samoa	2020-05-16	2020-05-17	0	0	0	0	draft
4562	Samoa	2020-05-17	2020-05-18	0	0	0	0	draft
4563	Samoa	2020-05-18	2020-05-19	0	0	0	0	draft
4564	Samoa	2020-05-19	2020-05-20	0	0	0	0	draft
4565	Samoa	2020-05-20	2020-05-21	0	0	0	0	draft
4566	Samoa	2020-05-21	2020-05-22	0	0	0	0	draft
4567	Samoa	2020-05-22	2020-05-23	0	0	0	0	draft
4568	Samoa	2020-05-23	2020-05-24	0	0	0	0	draft
4569	Samoa	2020-05-24	2020-05-25	0	0	0	0	draft
4570	Samoa	2020-05-25	2020-05-26	0	0	0	0	draft
4571	Samoa	2020-05-26	2020-05-27	0	0	0	0	draft
4572	Samoa	2020-05-27	2020-05-28	0	0	0	0	draft
4573	Samoa	2020-05-28	2020-05-29	0	0	0	0	draft
4574	Samoa	2020-05-29	2020-05-30	0	0	0	0	draft
4575	Samoa	2020-05-30	2020-05-31	0	0	0	0	draft
4576	Samoa	2020-05-31	2020-06-01	0	0	0	0	draft
4577	San Marino	2020-05-01	2020-05-02	580	41	82	457	draft
4578	San Marino	2020-05-02	2020-05-03	580	41	83	456	draft
4579	San Marino	2020-05-03	2020-05-04	582	41	86	455	draft
4580	San Marino	2020-05-04	2020-05-05	582	41	86	455	draft
4581	San Marino	2020-05-05	2020-05-06	589	41	92	456	draft
4582	San Marino	2020-05-06	2020-05-07	608	41	97	470	draft
4583	San Marino	2020-05-07	2020-05-08	622	41	106	475	draft
4584	San Marino	2020-05-08	2020-05-09	623	41	114	468	draft
4585	San Marino	2020-05-09	2020-05-10	637	41	126	470	draft
4586	San Marino	2020-05-10	2020-05-11	628	41	126	461	draft
4587	San Marino	2020-05-11	2020-05-12	628	41	130	457	draft
4588	San Marino	2020-05-12	2020-05-13	638	41	161	436	draft
4589	San Marino	2020-05-13	2020-05-14	643	41	161	441	draft
4590	San Marino	2020-05-14	2020-05-15	648	41	172	435	draft
4592	San Marino	2020-05-16	2020-05-17	653	41	198	414	draft
4593	San Marino	2020-05-17	2020-05-18	654	41	201	412	draft
4594	San Marino	2020-05-18	2020-05-19	654	41	203	410	draft
4595	San Marino	2020-05-19	2020-05-20	655	41	211	403	draft
4596	San Marino	2020-05-20	2020-05-21	656	41	220	395	draft
4597	San Marino	2020-05-21	2020-05-22	658	41	235	382	draft
4598	San Marino	2020-05-22	2020-05-23	661	41	254	366	draft
4599	San Marino	2020-05-23	2020-05-24	665	42	266	357	draft
4600	San Marino	2020-05-24	2020-05-25	665	42	266	357	draft
4601	San Marino	2020-05-25	2020-05-26	666	42	270	354	draft
4602	San Marino	2020-05-26	2020-05-27	666	42	275	349	draft
4603	San Marino	2020-05-27	2020-05-28	667	42	294	331	draft
4604	San Marino	2020-05-28	2020-05-29	670	42	322	306	draft
4605	San Marino	2020-05-29	2020-05-30	671	42	344	285	draft
4606	San Marino	2020-05-30	2020-05-31	671	42	357	272	draft
4607	San Marino	2020-05-31	2020-06-01	671	42	357	272	draft
4608	Sao Tome and Principe	2020-05-01	2020-05-02	16	1	4	11	draft
4609	Sao Tome and Principe	2020-05-02	2020-05-03	16	1	4	11	draft
4610	Sao Tome and Principe	2020-05-03	2020-05-04	16	1	4	11	draft
4611	Sao Tome and Principe	2020-05-04	2020-05-05	23	3	4	16	draft
4612	Sao Tome and Principe	2020-05-05	2020-05-06	174	3	4	167	draft
4613	Sao Tome and Principe	2020-05-06	2020-05-07	174	3	4	167	draft
4614	Sao Tome and Principe	2020-05-07	2020-05-08	187	4	4	179	draft
4615	Sao Tome and Principe	2020-05-08	2020-05-09	208	5	4	199	draft
4616	Sao Tome and Principe	2020-05-09	2020-05-10	208	5	4	199	draft
4617	Sao Tome and Principe	2020-05-10	2020-05-11	208	5	4	199	draft
4618	Sao Tome and Principe	2020-05-11	2020-05-12	208	5	4	199	draft
4619	Sao Tome and Principe	2020-05-12	2020-05-13	208	5	4	199	draft
4620	Sao Tome and Principe	2020-05-13	2020-05-14	220	6	4	210	draft
4621	Sao Tome and Principe	2020-05-14	2020-05-15	235	7	4	224	draft
4622	Sao Tome and Principe	2020-05-15	2020-05-16	235	7	4	224	draft
4623	Sao Tome and Principe	2020-05-16	2020-05-17	235	7	4	224	draft
4624	Sao Tome and Principe	2020-05-17	2020-05-18	235	7	4	224	draft
4625	Sao Tome and Principe	2020-05-18	2020-05-19	246	7	4	235	draft
4626	Sao Tome and Principe	2020-05-19	2020-05-20	251	8	4	239	draft
4627	Sao Tome and Principe	2020-05-20	2020-05-21	251	8	4	239	draft
4628	Sao Tome and Principe	2020-05-21	2020-05-22	251	8	4	239	draft
4629	Sao Tome and Principe	2020-05-22	2020-05-23	251	8	4	239	draft
4630	Sao Tome and Principe	2020-05-23	2020-05-24	251	8	4	239	draft
4631	Sao Tome and Principe	2020-05-24	2020-05-25	251	8	4	239	draft
4632	Sao Tome and Principe	2020-05-25	2020-05-26	299	11	4	284	draft
4633	Sao Tome and Principe	2020-05-26	2020-05-27	441	12	68	361	draft
4634	Sao Tome and Principe	2020-05-27	2020-05-28	443	12	68	363	draft
4635	Sao Tome and Principe	2020-05-28	2020-05-29	458	12	68	378	draft
4636	Sao Tome and Principe	2020-05-29	2020-05-30	463	12	68	383	draft
4637	Sao Tome and Principe	2020-05-30	2020-05-31	479	12	68	399	draft
4638	Sao Tome and Principe	2020-05-31	2020-06-01	483	12	68	403	draft
4639	Saudi Arabia	2020-05-01	2020-05-02	24097	169	3555	20373	draft
4640	Saudi Arabia	2020-05-02	2020-05-03	25459	176	3765	21518	draft
4641	Saudi Arabia	2020-05-03	2020-05-04	27011	184	4134	22693	draft
4642	Saudi Arabia	2020-05-04	2020-05-05	28656	191	4476	23989	draft
4643	Saudi Arabia	2020-05-05	2020-05-06	30251	200	5431	24620	draft
4644	Saudi Arabia	2020-05-06	2020-05-07	31938	209	6783	24946	draft
4645	Saudi Arabia	2020-05-07	2020-05-08	33731	219	7798	25714	draft
4646	Saudi Arabia	2020-05-08	2020-05-09	35432	229	9120	26083	draft
4647	Saudi Arabia	2020-05-09	2020-05-10	37136	239	10144	26753	draft
4648	Saudi Arabia	2020-05-10	2020-05-11	39048	246	11457	27345	draft
4649	Saudi Arabia	2020-05-11	2020-05-12	41014	255	12737	28022	draft
4650	Saudi Arabia	2020-05-12	2020-05-13	42925	264	15257	27404	draft
4651	Saudi Arabia	2020-05-13	2020-05-14	44830	273	17622	26935	draft
4652	Saudi Arabia	2020-05-14	2020-05-15	46869	283	19051	27535	draft
4653	Saudi Arabia	2020-05-15	2020-05-16	49176	292	21869	27015	draft
4654	Saudi Arabia	2020-05-16	2020-05-17	52016	302	23666	28048	draft
4655	Saudi Arabia	2020-05-17	2020-05-18	54752	312	25722	28718	draft
4656	Saudi Arabia	2020-05-18	2020-05-19	57345	320	28748	28277	draft
4657	Saudi Arabia	2020-05-19	2020-05-20	59854	329	31634	27891	draft
4658	Saudi Arabia	2020-05-20	2020-05-21	62545	339	33478	28728	draft
4659	Saudi Arabia	2020-05-21	2020-05-22	65077	351	36040	28686	draft
4660	Saudi Arabia	2020-05-22	2020-05-23	67719	364	39003	28352	draft
4661	Saudi Arabia	2020-05-23	2020-05-24	70161	379	41236	28546	draft
4662	Saudi Arabia	2020-05-24	2020-05-25	72560	390	43520	28650	draft
4663	Saudi Arabia	2020-05-25	2020-05-26	74795	399	45668	28728	draft
4664	Saudi Arabia	2020-05-26	2020-05-27	76726	411	48450	27865	draft
4665	Saudi Arabia	2020-05-27	2020-05-28	78541	425	51022	27094	draft
4666	Saudi Arabia	2020-05-28	2020-05-29	80185	441	54553	25191	draft
4667	Saudi Arabia	2020-05-29	2020-05-30	81766	458	57013	24295	draft
4668	Saudi Arabia	2020-05-30	2020-05-31	83384	480	58883	24021	draft
4669	Saudi Arabia	2020-05-31	2020-06-01	85261	503	62442	22316	draft
4670	Senegal	2020-05-01	2020-05-02	1024	9	356	659	draft
4671	Senegal	2020-05-02	2020-05-03	1115	9	368	738	draft
4672	Senegal	2020-05-03	2020-05-04	1182	9	372	801	draft
4673	Senegal	2020-05-04	2020-05-05	1271	10	415	846	draft
4674	Senegal	2020-05-05	2020-05-06	1329	11	470	848	draft
4675	Senegal	2020-05-06	2020-05-07	1433	12	493	928	draft
4676	Senegal	2020-05-07	2020-05-08	1492	13	562	917	draft
4677	Senegal	2020-05-08	2020-05-09	1551	13	611	927	draft
4678	Senegal	2020-05-09	2020-05-10	1634	17	643	974	draft
4679	Senegal	2020-05-10	2020-05-11	1709	19	650	1040	draft
4680	Senegal	2020-05-11	2020-05-12	1886	19	715	1152	draft
4681	Senegal	2020-05-12	2020-05-13	1995	19	742	1234	draft
4682	Senegal	2020-05-13	2020-05-14	2105	21	782	1302	draft
4683	Senegal	2020-05-14	2020-05-15	2189	23	842	1324	draft
4684	Senegal	2020-05-15	2020-05-16	2310	25	890	1395	draft
4685	Senegal	2020-05-16	2020-05-17	2429	25	949	1455	draft
4686	Senegal	2020-05-17	2020-05-18	2480	25	973	1482	draft
4687	Senegal	2020-05-18	2020-05-19	2544	26	1076	1442	draft
4688	Senegal	2020-05-19	2020-05-20	2617	30	1133	1454	draft
4689	Senegal	2020-05-20	2020-05-21	2714	30	1186	1498	draft
4690	Senegal	2020-05-21	2020-05-22	2812	33	1251	1528	draft
4691	Senegal	2020-05-22	2020-05-23	2909	33	1311	1565	draft
4692	Senegal	2020-05-23	2020-05-24	2976	34	1416	1526	draft
4693	Senegal	2020-05-24	2020-05-25	3047	35	1456	1556	draft
4694	Senegal	2020-05-25	2020-05-26	3130	35	1515	1580	draft
4695	Senegal	2020-05-26	2020-05-27	3161	36	1565	1560	draft
4696	Senegal	2020-05-27	2020-05-28	3253	38	1586	1629	draft
4697	Senegal	2020-05-28	2020-05-29	3348	39	1686	1623	draft
4698	Senegal	2020-05-29	2020-05-30	3429	41	1738	1650	draft
4699	Senegal	2020-05-30	2020-05-31	3535	42	1761	1732	draft
4700	Senegal	2020-05-31	2020-06-01	3645	42	1801	1802	draft
4701	Serbia	2020-05-01	2020-05-02	9009	179	1343	7487	draft
4702	Serbia	2020-05-02	2020-05-03	9362	189	1426	7747	draft
4703	Serbia	2020-05-03	2020-05-04	9464	193	1551	7720	draft
4704	Serbia	2020-05-04	2020-05-05	9557	197	1574	7786	draft
4705	Serbia	2020-05-05	2020-05-06	9677	200	1723	7754	draft
4706	Serbia	2020-05-06	2020-05-07	9791	203	1971	7617	draft
4707	Serbia	2020-05-07	2020-05-08	9848	206	2160	7482	draft
4708	Serbia	2020-05-08	2020-05-09	9943	209	2453	7281	draft
4709	Serbia	2020-05-09	2020-05-10	10032	215	2732	7085	draft
4710	Serbia	2020-05-10	2020-05-11	10032	215	2732	7085	draft
4711	Serbia	2020-05-11	2020-05-12	10176	218	3290	6668	draft
4712	Serbia	2020-05-12	2020-05-13	10243	220	3600	6423	draft
4713	Serbia	2020-05-13	2020-05-14	10295	222	3824	6249	draft
4714	Serbia	2020-05-14	2020-05-15	10374	224	4084	6066	draft
4715	Serbia	2020-05-15	2020-05-16	10438	225	4301	5912	draft
4716	Serbia	2020-05-16	2020-05-17	10496	228	4479	5789	draft
4717	Serbia	2020-05-17	2020-05-18	10610	230	4713	5667	draft
4718	Serbia	2020-05-18	2020-05-19	10699	231	4799	5669	draft
4719	Serbia	2020-05-19	2020-05-20	10733	234	4904	5595	draft
4720	Serbia	2020-05-20	2020-05-21	10833	235	5067	5531	draft
4721	Serbia	2020-05-21	2020-05-22	10919	237	5370	5312	draft
4722	Serbia	2020-05-22	2020-05-23	11024	237	5541	5246	draft
4723	Serbia	2020-05-23	2020-05-24	11092	238	5699	5155	draft
4724	Serbia	2020-05-24	2020-05-25	11159	238	5857	5064	draft
4725	Serbia	2020-05-25	2020-05-26	11193	239	5920	5034	draft
4726	Serbia	2020-05-26	2020-05-27	11227	239	6067	4921	draft
4727	Serbia	2020-05-27	2020-05-28	11275	240	6277	4758	draft
4728	Serbia	2020-05-28	2020-05-29	11300	241	6438	4621	draft
4729	Serbia	2020-05-29	2020-05-30	11354	242	6524	4588	draft
4730	Serbia	2020-05-30	2020-05-31	11381	242	6606	4533	draft
4731	Serbia	2020-05-31	2020-06-01	11412	243	6698	4471	draft
4732	Seychelles	2020-05-01	2020-05-02	11	0	6	5	draft
4733	Seychelles	2020-05-02	2020-05-03	11	0	6	5	draft
4734	Seychelles	2020-05-03	2020-05-04	11	0	6	5	draft
4735	Seychelles	2020-05-04	2020-05-05	11	0	6	5	draft
4736	Seychelles	2020-05-05	2020-05-06	11	0	8	3	draft
4737	Seychelles	2020-05-06	2020-05-07	11	0	8	3	draft
4738	Seychelles	2020-05-07	2020-05-08	11	0	8	3	draft
4739	Seychelles	2020-05-08	2020-05-09	11	0	8	3	draft
4740	Seychelles	2020-05-09	2020-05-10	11	0	8	3	draft
4741	Seychelles	2020-05-10	2020-05-11	11	0	10	1	draft
4742	Seychelles	2020-05-11	2020-05-12	11	0	10	1	draft
4743	Seychelles	2020-05-12	2020-05-13	11	0	10	1	draft
4744	Seychelles	2020-05-13	2020-05-14	11	0	10	1	draft
4745	Seychelles	2020-05-14	2020-05-15	11	0	10	1	draft
4746	Seychelles	2020-05-15	2020-05-16	11	0	10	1	draft
4747	Seychelles	2020-05-16	2020-05-17	11	0	10	1	draft
4748	Seychelles	2020-05-17	2020-05-18	11	0	10	1	draft
4749	Seychelles	2020-05-18	2020-05-19	11	0	11	0	draft
4750	Seychelles	2020-05-19	2020-05-20	11	0	11	0	draft
4751	Seychelles	2020-05-20	2020-05-21	11	0	11	0	draft
4752	Seychelles	2020-05-21	2020-05-22	11	0	11	0	draft
4753	Seychelles	2020-05-22	2020-05-23	11	0	11	0	draft
4754	Seychelles	2020-05-23	2020-05-24	11	0	11	0	draft
4755	Seychelles	2020-05-24	2020-05-25	11	0	11	0	draft
4756	Seychelles	2020-05-25	2020-05-26	11	0	11	0	draft
4757	Seychelles	2020-05-26	2020-05-27	11	0	11	0	draft
4758	Seychelles	2020-05-27	2020-05-28	11	0	11	0	draft
4759	Seychelles	2020-05-28	2020-05-29	11	0	11	0	draft
4760	Seychelles	2020-05-29	2020-05-30	11	0	11	0	draft
4761	Seychelles	2020-05-30	2020-05-31	11	0	11	0	draft
4762	Seychelles	2020-05-31	2020-06-01	11	0	11	0	draft
4763	Sierra Leone	2020-05-01	2020-05-02	136	7	21	108	draft
4764	Sierra Leone	2020-05-02	2020-05-03	155	8	21	126	draft
4765	Sierra Leone	2020-05-03	2020-05-04	166	8	29	129	draft
4766	Sierra Leone	2020-05-04	2020-05-05	178	9	37	132	draft
4767	Sierra Leone	2020-05-05	2020-05-06	199	11	43	145	draft
4768	Sierra Leone	2020-05-06	2020-05-07	225	14	54	157	draft
4769	Sierra Leone	2020-05-07	2020-05-08	231	16	54	161	draft
4770	Sierra Leone	2020-05-08	2020-05-09	257	17	54	186	draft
4771	Sierra Leone	2020-05-09	2020-05-10	291	18	58	215	draft
4772	Sierra Leone	2020-05-10	2020-05-11	307	18	67	222	draft
4773	Sierra Leone	2020-05-11	2020-05-12	338	19	72	247	draft
4774	Sierra Leone	2020-05-12	2020-05-13	338	19	72	247	draft
4775	Sierra Leone	2020-05-13	2020-05-14	387	26	97	264	draft
4776	Sierra Leone	2020-05-14	2020-05-15	408	26	97	285	draft
4777	Sierra Leone	2020-05-15	2020-05-16	447	27	97	323	draft
4778	Sierra Leone	2020-05-16	2020-05-17	462	29	106	327	draft
4779	Sierra Leone	2020-05-17	2020-05-18	505	32	141	332	draft
4780	Sierra Leone	2020-05-18	2020-05-19	519	33	148	338	draft
4781	Sierra Leone	2020-05-19	2020-05-20	534	33	167	334	draft
4782	Sierra Leone	2020-05-20	2020-05-21	570	34	205	331	draft
4783	Sierra Leone	2020-05-21	2020-05-22	585	35	205	345	draft
4784	Sierra Leone	2020-05-22	2020-05-23	606	38	230	338	draft
4785	Sierra Leone	2020-05-23	2020-05-24	621	39	241	341	draft
4786	Sierra Leone	2020-05-24	2020-05-25	707	40	241	426	draft
4787	Sierra Leone	2020-05-25	2020-05-26	735	42	293	400	draft
4788	Sierra Leone	2020-05-26	2020-05-27	754	44	297	413	draft
4789	Sierra Leone	2020-05-27	2020-05-28	782	45	297	440	draft
4790	Sierra Leone	2020-05-28	2020-05-29	812	45	361	406	draft
4791	Sierra Leone	2020-05-29	2020-05-30	829	45	386	398	draft
4792	Sierra Leone	2020-05-30	2020-05-31	852	46	415	391	draft
4793	Sierra Leone	2020-05-31	2020-06-01	861	46	454	361	draft
4794	Singapore	2020-05-01	2020-05-02	17101	16	1268	15817	draft
4795	Singapore	2020-05-02	2020-05-03	17548	17	1347	16184	draft
4796	Singapore	2020-05-03	2020-05-04	18205	18	1408	16779	draft
4797	Singapore	2020-05-04	2020-05-05	18778	18	1457	17303	draft
4798	Singapore	2020-05-05	2020-05-06	19410	18	1519	17873	draft
4799	Singapore	2020-05-06	2020-05-07	20198	20	1634	18544	draft
4800	Singapore	2020-05-07	2020-05-08	20939	20	1712	19207	draft
4801	Singapore	2020-05-08	2020-05-09	21707	20	2040	19647	draft
4802	Singapore	2020-05-09	2020-05-10	22460	20	2296	20144	draft
4803	Singapore	2020-05-10	2020-05-11	23336	20	2721	20595	draft
4804	Singapore	2020-05-11	2020-05-12	23822	21	3225	20576	draft
4805	Singapore	2020-05-12	2020-05-13	24671	21	3851	20799	draft
4806	Singapore	2020-05-13	2020-05-14	25346	21	4809	20516	draft
4807	Singapore	2020-05-14	2020-05-15	26098	21	5973	20104	draft
4808	Singapore	2020-05-15	2020-05-16	26891	21	7248	19622	draft
4809	Singapore	2020-05-16	2020-05-17	27356	22	8342	18992	draft
4810	Singapore	2020-05-17	2020-05-18	28038	22	9340	18676	draft
4811	Singapore	2020-05-18	2020-05-19	28343	22	9835	18486	draft
4812	Singapore	2020-05-19	2020-05-20	28794	22	10365	18407	draft
4813	Singapore	2020-05-20	2020-05-21	29364	22	11207	18135	draft
4814	Singapore	2020-05-21	2020-05-22	29812	23	12117	17672	draft
4815	Singapore	2020-05-22	2020-05-23	30426	23	12995	17408	draft
4816	Singapore	2020-05-23	2020-05-24	31068	23	13882	17163	draft
4817	Singapore	2020-05-24	2020-05-25	31616	23	14876	16717	draft
4818	Singapore	2020-05-25	2020-05-26	31960	23	15738	16199	draft
4819	Singapore	2020-05-26	2020-05-27	32343	23	16444	15876	draft
4820	Singapore	2020-05-27	2020-05-28	32876	23	17276	15577	draft
4821	Singapore	2020-05-28	2020-05-29	33249	23	18294	14932	draft
4822	Singapore	2020-05-29	2020-05-30	33860	23	19631	14206	draft
4823	Singapore	2020-05-30	2020-05-31	34366	23	20727	13616	draft
4824	Singapore	2020-05-31	2020-06-01	34884	23	21699	13162	draft
4825	Slovakia	2020-05-01	2020-05-02	1403	23	558	822	draft
4826	Slovakia	2020-05-02	2020-05-03	1407	24	608	775	draft
4827	Slovakia	2020-05-03	2020-05-04	1408	24	619	765	draft
4828	Slovakia	2020-05-04	2020-05-05	1413	25	643	745	draft
4829	Slovakia	2020-05-05	2020-05-06	1421	25	741	655	draft
4830	Slovakia	2020-05-06	2020-05-07	1429	25	762	642	draft
4831	Slovakia	2020-05-07	2020-05-08	1445	26	806	613	draft
4832	Slovakia	2020-05-08	2020-05-09	1455	26	905	524	draft
4833	Slovakia	2020-05-09	2020-05-10	1455	26	919	510	draft
4834	Slovakia	2020-05-10	2020-05-11	1457	26	941	490	draft
4835	Slovakia	2020-05-11	2020-05-12	1457	26	959	472	draft
4836	Slovakia	2020-05-12	2020-05-13	1465	27	983	455	draft
4837	Slovakia	2020-05-13	2020-05-14	1469	27	1060	382	draft
4838	Slovakia	2020-05-14	2020-05-15	1477	27	1112	338	draft
4839	Slovakia	2020-05-15	2020-05-16	1480	27	1131	322	draft
4840	Slovakia	2020-05-16	2020-05-17	1493	28	1151	314	draft
4841	Slovakia	2020-05-17	2020-05-18	1494	28	1163	303	draft
4842	Slovakia	2020-05-18	2020-05-19	1495	28	1185	282	draft
4843	Slovakia	2020-05-19	2020-05-20	1495	28	1192	275	draft
4844	Slovakia	2020-05-20	2020-05-21	1496	28	1231	237	draft
4845	Slovakia	2020-05-21	2020-05-22	1502	28	1245	229	draft
4846	Slovakia	2020-05-22	2020-05-23	1503	28	1256	219	draft
4847	Slovakia	2020-05-23	2020-05-24	1504	28	1280	196	draft
4848	Slovakia	2020-05-24	2020-05-25	1509	28	1301	180	draft
4849	Slovakia	2020-05-25	2020-05-26	1511	28	1307	176	draft
4850	Slovakia	2020-05-26	2020-05-27	1513	28	1322	163	draft
4851	Slovakia	2020-05-27	2020-05-28	1515	28	1327	160	draft
4852	Slovakia	2020-05-28	2020-05-29	1520	28	1332	160	draft
4853	Slovakia	2020-05-29	2020-05-30	1520	28	1338	154	draft
4854	Slovakia	2020-05-30	2020-05-31	1521	28	1356	137	draft
4855	Slovakia	2020-05-31	2020-06-01	1521	28	1366	127	draft
4856	Slovenia	2020-05-01	2020-05-02	1434	92	233	1109	draft
4857	Slovenia	2020-05-02	2020-05-03	1439	94	239	1106	draft
4858	Slovenia	2020-05-03	2020-05-04	1439	96	241	1102	draft
4859	Slovenia	2020-05-04	2020-05-05	1439	97	241	1101	draft
4860	Slovenia	2020-05-05	2020-05-06	1445	98	244	1103	draft
4861	Slovenia	2020-05-06	2020-05-07	1448	99	246	1103	draft
4862	Slovenia	2020-05-07	2020-05-08	1449	99	247	1103	draft
4863	Slovenia	2020-05-08	2020-05-09	1450	100	252	1098	draft
4864	Slovenia	2020-05-09	2020-05-10	1454	101	255	1098	draft
4865	Slovenia	2020-05-10	2020-05-11	1457	102	256	1099	draft
4866	Slovenia	2020-05-11	2020-05-12	1460	102	256	1102	draft
4867	Slovenia	2020-05-12	2020-05-13	1461	102	259	1100	draft
4868	Slovenia	2020-05-13	2020-05-14	1463	103	260	1100	draft
4869	Slovenia	2020-05-14	2020-05-15	1464	103	267	1094	draft
4870	Slovenia	2020-05-15	2020-05-16	1465	103	270	1092	draft
4871	Slovenia	2020-05-16	2020-05-17	1465	103	272	1090	draft
4872	Slovenia	2020-05-17	2020-05-18	1466	104	273	1089	draft
4873	Slovenia	2020-05-18	2020-05-19	1466	104	1335	27	draft
4874	Slovenia	2020-05-19	2020-05-20	1467	104	1338	25	draft
4875	Slovenia	2020-05-20	2020-05-21	1468	105	1340	23	draft
4876	Slovenia	2020-05-21	2020-05-22	1468	106	1340	22	draft
4877	Slovenia	2020-05-22	2020-05-23	1468	106	1340	22	draft
4878	Slovenia	2020-05-23	2020-05-24	1468	106	1340	22	draft
4879	Slovenia	2020-05-24	2020-05-25	1468	107	1340	21	draft
4880	Slovenia	2020-05-25	2020-05-26	1469	107	1346	16	draft
4881	Slovenia	2020-05-26	2020-05-27	1469	108	1346	15	draft
4882	Slovenia	2020-05-27	2020-05-28	1471	108	1354	9	draft
4883	Slovenia	2020-05-28	2020-05-29	1473	108	1356	9	draft
4884	Slovenia	2020-05-29	2020-05-30	1473	108	1357	8	draft
4885	Slovenia	2020-05-30	2020-05-31	1473	108	1357	8	draft
4886	Slovenia	2020-05-31	2020-06-01	1473	108	1358	7	draft
4887	Somalia	2020-05-01	2020-05-02	601	28	31	542	draft
4888	Somalia	2020-05-02	2020-05-03	671	31	34	606	draft
4889	Somalia	2020-05-03	2020-05-04	722	32	44	646	draft
4890	Somalia	2020-05-04	2020-05-05	756	35	61	660	draft
4891	Somalia	2020-05-05	2020-05-06	835	38	75	722	draft
4892	Somalia	2020-05-06	2020-05-07	873	39	87	747	draft
4893	Somalia	2020-05-07	2020-05-08	928	44	106	778	draft
4894	Somalia	2020-05-08	2020-05-09	928	44	106	778	draft
4895	Somalia	2020-05-09	2020-05-10	997	48	110	839	draft
4896	Somalia	2020-05-10	2020-05-11	1054	51	118	885	draft
4897	Somalia	2020-05-11	2020-05-12	1089	52	121	916	draft
4898	Somalia	2020-05-12	2020-05-13	1170	52	126	992	draft
4899	Somalia	2020-05-13	2020-05-14	1219	52	130	1037	draft
4900	Somalia	2020-05-14	2020-05-15	1284	53	135	1096	draft
4901	Somalia	2020-05-15	2020-05-16	1284	53	135	1096	draft
4902	Somalia	2020-05-16	2020-05-17	1357	55	148	1154	draft
4903	Somalia	2020-05-17	2020-05-18	1421	56	152	1213	draft
4904	Somalia	2020-05-18	2020-05-19	1455	57	163	1235	draft
4905	Somalia	2020-05-19	2020-05-20	1502	59	178	1265	draft
4906	Somalia	2020-05-20	2020-05-21	1573	61	188	1324	draft
4907	Somalia	2020-05-21	2020-05-22	1594	61	204	1329	draft
4908	Somalia	2020-05-22	2020-05-23	1594	61	204	1329	draft
4909	Somalia	2020-05-23	2020-05-24	1594	61	204	1329	draft
4910	Somalia	2020-05-24	2020-05-25	1594	61	204	1329	draft
4911	Somalia	2020-05-25	2020-05-26	1689	66	235	1388	draft
4912	Somalia	2020-05-26	2020-05-27	1711	67	253	1391	draft
4913	Somalia	2020-05-27	2020-05-28	1731	67	265	1399	draft
4914	Somalia	2020-05-28	2020-05-29	1828	72	310	1446	draft
4915	Somalia	2020-05-29	2020-05-30	1828	72	310	1446	draft
4916	Somalia	2020-05-30	2020-05-31	1916	73	327	1516	draft
4917	Somalia	2020-05-31	2020-06-01	1976	78	348	1550	draft
4918	South Africa	2020-05-01	2020-05-02	5951	116	2382	3453	draft
4919	South Africa	2020-05-02	2020-05-03	6336	123	2549	3664	draft
4920	South Africa	2020-05-03	2020-05-04	6783	131	2549	4103	draft
4921	South Africa	2020-05-04	2020-05-05	7220	138	2746	4336	draft
4922	South Africa	2020-05-05	2020-05-06	7572	148	2746	4678	draft
4923	South Africa	2020-05-06	2020-05-07	7808	153	3153	4502	draft
4924	South Africa	2020-05-07	2020-05-08	8232	161	3153	4918	draft
4925	South Africa	2020-05-08	2020-05-09	8895	178	3153	5564	draft
4926	South Africa	2020-05-09	2020-05-10	9420	186	3983	5251	draft
4927	South Africa	2020-05-10	2020-05-11	10015	194	4173	5648	draft
4928	South Africa	2020-05-11	2020-05-12	10652	206	4357	6089	draft
4929	South Africa	2020-05-12	2020-05-13	11350	206	4357	6787	draft
4930	South Africa	2020-05-13	2020-05-14	12074	219	4745	7110	draft
4931	South Africa	2020-05-14	2020-05-15	12739	238	5676	6825	draft
4932	South Africa	2020-05-15	2020-05-16	13524	247	6083	7194	draft
4933	South Africa	2020-05-16	2020-05-17	14355	261	6478	7616	draft
4934	South Africa	2020-05-17	2020-05-18	15515	264	7006	8245	draft
4935	South Africa	2020-05-18	2020-05-19	16433	286	7298	8849	draft
4936	South Africa	2020-05-19	2020-05-20	17200	312	7960	8928	draft
4937	South Africa	2020-05-20	2020-05-21	18003	339	8950	8714	draft
4938	South Africa	2020-05-21	2020-05-22	19137	369	8950	9818	draft
4939	South Africa	2020-05-22	2020-05-23	20125	397	10104	9624	draft
4940	South Africa	2020-05-23	2020-05-24	21343	407	10104	10832	draft
4941	South Africa	2020-05-24	2020-05-25	22583	429	11100	11054	draft
4942	South Africa	2020-05-25	2020-05-26	23615	481	11917	11217	draft
4943	South Africa	2020-05-26	2020-05-27	24264	524	12741	10999	draft
4944	South Africa	2020-05-27	2020-05-28	25937	552	13451	11934	draft
4945	South Africa	2020-05-28	2020-05-29	27403	577	14370	12456	draft
4946	South Africa	2020-05-29	2020-05-30	29240	611	15093	13536	draft
4947	South Africa	2020-05-30	2020-05-31	30967	643	16116	14208	draft
4948	South Africa	2020-05-31	2020-06-01	32683	683	16809	15191	draft
4949	South Sudan	2020-05-01	2020-05-02	45	0	0	45	draft
4950	South Sudan	2020-05-02	2020-05-03	45	0	0	45	draft
4951	South Sudan	2020-05-03	2020-05-04	46	0	0	46	draft
4952	South Sudan	2020-05-04	2020-05-05	46	0	0	46	draft
4953	South Sudan	2020-05-05	2020-05-06	52	0	0	52	draft
4954	South Sudan	2020-05-06	2020-05-07	58	0	0	58	draft
4955	South Sudan	2020-05-07	2020-05-08	74	0	0	74	draft
4956	South Sudan	2020-05-08	2020-05-09	120	0	2	118	draft
4957	South Sudan	2020-05-09	2020-05-10	120	0	2	118	draft
4958	South Sudan	2020-05-10	2020-05-11	120	0	2	118	draft
4959	South Sudan	2020-05-11	2020-05-12	156	0	2	154	draft
4960	South Sudan	2020-05-12	2020-05-13	194	0	2	192	draft
4961	South Sudan	2020-05-13	2020-05-14	203	0	2	201	draft
4962	South Sudan	2020-05-14	2020-05-15	203	0	3	200	draft
4963	South Sudan	2020-05-15	2020-05-16	236	4	4	228	draft
4964	South Sudan	2020-05-16	2020-05-17	236	4	4	228	draft
4965	South Sudan	2020-05-17	2020-05-18	290	4	4	282	draft
4966	South Sudan	2020-05-18	2020-05-19	290	4	4	282	draft
4967	South Sudan	2020-05-19	2020-05-20	290	4	4	282	draft
4968	South Sudan	2020-05-20	2020-05-21	290	4	4	282	draft
4969	South Sudan	2020-05-21	2020-05-22	481	4	4	473	draft
4970	South Sudan	2020-05-22	2020-05-23	563	6	6	551	draft
4971	South Sudan	2020-05-23	2020-05-24	655	8	6	641	draft
4972	South Sudan	2020-05-24	2020-05-25	655	8	6	641	draft
4973	South Sudan	2020-05-25	2020-05-26	806	8	6	792	draft
4974	South Sudan	2020-05-26	2020-05-27	806	8	6	792	draft
4975	South Sudan	2020-05-27	2020-05-28	994	10	6	978	draft
4976	South Sudan	2020-05-28	2020-05-29	994	10	6	978	draft
4977	South Sudan	2020-05-29	2020-05-30	994	10	6	978	draft
4978	South Sudan	2020-05-30	2020-05-31	994	10	6	978	draft
4979	South Sudan	2020-05-31	2020-06-01	994	10	6	978	draft
4980	Spain	2020-05-01	2020-05-02	213435	24543	112050	76842	draft
4981	Spain	2020-05-02	2020-05-03	216582	25100	117248	74234	draft
4982	Spain	2020-05-03	2020-05-04	217466	25264	118902	73300	draft
4983	Spain	2020-05-04	2020-05-05	218011	25428	121343	71240	draft
4984	Spain	2020-05-05	2020-05-06	219329	25613	123486	70230	draft
4985	Spain	2020-05-06	2020-05-07	220325	25857	126002	68466	draft
4986	Spain	2020-05-07	2020-05-08	221447	26070	128511	66866	draft
4987	Spain	2020-05-08	2020-05-09	222857	26299	131148	65410	draft
4988	Spain	2020-05-09	2020-05-10	223578	26478	133952	63148	draft
4989	Spain	2020-05-10	2020-05-11	224350	26621	136166	61563	draft
4990	Spain	2020-05-11	2020-05-12	227436	26744	137139	63553	draft
4991	Spain	2020-05-12	2020-05-13	228030	26920	138980	62130	draft
4992	Spain	2020-05-13	2020-05-14	228691	27104	140823	60764	draft
4993	Spain	2020-05-14	2020-05-15	229540	27321	143374	58845	draft
4994	Spain	2020-05-15	2020-05-16	230183	27459	144783	57941	draft
4995	Spain	2020-05-16	2020-05-17	230698	27563	146446	56689	draft
4996	Spain	2020-05-17	2020-05-18	230698	27563	146446	56689	draft
4997	Spain	2020-05-18	2020-05-19	231606	27709	150376	53521	draft
4998	Spain	2020-05-19	2020-05-20	232037	27778	150376	53883	draft
4999	Spain	2020-05-20	2020-05-21	232555	27888	150376	54291	draft
5000	Spain	2020-05-21	2020-05-22	233037	27940	150376	54721	draft
5001	Spain	2020-05-22	2020-05-23	234824	28628	150376	55820	draft
5002	Spain	2020-05-23	2020-05-24	235290	28678	150376	56236	draft
5003	Spain	2020-05-24	2020-05-25	235772	28752	150376	56644	draft
5004	Spain	2020-05-25	2020-05-26	235400	26834	150376	58190	draft
5005	Spain	2020-05-26	2020-05-27	236259	27117	150376	58766	draft
5006	Spain	2020-05-27	2020-05-28	236259	27117	150376	58766	draft
5007	Spain	2020-05-28	2020-05-29	237906	27119	150376	60411	draft
5008	Spain	2020-05-29	2020-05-30	238564	27121	150376	61067	draft
5009	Spain	2020-05-30	2020-05-31	239228	27125	150376	61727	draft
5010	Spain	2020-05-31	2020-06-01	239479	27127	150376	61976	draft
5011	Sri Lanka	2020-05-01	2020-05-02	690	7	162	521	draft
5012	Sri Lanka	2020-05-02	2020-05-03	705	7	172	526	draft
5013	Sri Lanka	2020-05-03	2020-05-04	718	7	184	527	draft
5014	Sri Lanka	2020-05-04	2020-05-05	751	8	194	549	draft
5015	Sri Lanka	2020-05-05	2020-05-06	771	9	213	549	draft
5016	Sri Lanka	2020-05-06	2020-05-07	797	9	215	573	draft
5017	Sri Lanka	2020-05-07	2020-05-08	824	9	232	583	draft
5018	Sri Lanka	2020-05-08	2020-05-09	835	9	240	586	draft
5019	Sri Lanka	2020-05-09	2020-05-10	847	9	260	578	draft
5020	Sri Lanka	2020-05-10	2020-05-11	863	9	321	533	draft
5021	Sri Lanka	2020-05-11	2020-05-12	869	9	343	517	draft
5022	Sri Lanka	2020-05-12	2020-05-13	889	9	366	514	draft
5023	Sri Lanka	2020-05-13	2020-05-14	915	9	382	524	draft
5024	Sri Lanka	2020-05-14	2020-05-15	925	9	445	471	draft
5025	Sri Lanka	2020-05-15	2020-05-16	935	9	477	449	draft
5026	Sri Lanka	2020-05-16	2020-05-17	960	9	520	431	draft
5027	Sri Lanka	2020-05-17	2020-05-18	981	9	538	434	draft
5028	Sri Lanka	2020-05-18	2020-05-19	992	9	559	424	draft
5029	Sri Lanka	2020-05-19	2020-05-20	1027	9	569	449	draft
5030	Sri Lanka	2020-05-20	2020-05-21	1028	9	584	435	draft
5031	Sri Lanka	2020-05-21	2020-05-22	1055	9	604	442	draft
5032	Sri Lanka	2020-05-22	2020-05-23	1068	9	620	439	draft
5033	Sri Lanka	2020-05-23	2020-05-24	1089	9	660	420	draft
5034	Sri Lanka	2020-05-24	2020-05-25	1141	9	674	458	draft
5035	Sri Lanka	2020-05-25	2020-05-26	1182	10	695	477	draft
5036	Sri Lanka	2020-05-26	2020-05-27	1319	10	712	597	draft
5037	Sri Lanka	2020-05-27	2020-05-28	1469	10	732	727	draft
5038	Sri Lanka	2020-05-28	2020-05-29	1530	10	745	775	draft
5039	Sri Lanka	2020-05-29	2020-05-30	1558	10	754	794	draft
5040	Sri Lanka	2020-05-30	2020-05-31	1620	10	781	829	draft
5041	Sri Lanka	2020-05-31	2020-06-01	1633	10	801	822	draft
5042	Sudan	2020-05-01	2020-05-02	442	36	46	451	draft
5043	Sudan	2020-05-02	2020-05-03	533	41	52	499	draft
5044	Sudan	2020-05-03	2020-05-04	592	41	52	499	draft
5045	Sudan	2020-05-04	2020-05-05	678	41	61	576	draft
5046	Sudan	2020-05-05	2020-05-06	778	45	70	663	draft
5047	Sudan	2020-05-06	2020-05-07	852	49	80	723	draft
5048	Sudan	2020-05-07	2020-05-08	930	52	92	786	draft
5049	Sudan	2020-05-08	2020-05-09	930	59	102	950	draft
5050	Sudan	2020-05-09	2020-05-10	1111	64	119	981	draft
5051	Sudan	2020-05-10	2020-05-11	1164	70	149	1146	draft
5052	Sudan	2020-05-11	2020-05-12	1365	74	162	1290	draft
5053	Sudan	2020-05-12	2020-05-13	1526	80	173	1408	draft
5054	Sudan	2020-05-13	2020-05-14	1660	90	198	1530	draft
5055	Sudan	2020-05-14	2020-05-15	1818	90	198	1530	draft
5056	Sudan	2020-05-15	2020-05-16	1964	91	205	1668	draft
5057	Sudan	2020-05-16	2020-05-17	1964	97	222	1970	draft
5058	Sudan	2020-05-17	2020-05-18	2289	97	222	1970	draft
5059	Sudan	2020-05-18	2020-05-19	2591	105	247	2239	draft
5060	Sudan	2020-05-19	2020-05-20	2591	111	286	2331	draft
5061	Sudan	2020-05-20	2020-05-21	2728	111	286	2331	draft
5062	Sudan	2020-05-21	2020-05-22	3138	121	309	2708	draft
5063	Sudan	2020-05-22	2020-05-23	3138	137	372	2869	draft
5064	Sudan	2020-05-23	2020-05-24	3378	146	424	3058	draft
5065	Sudan	2020-05-24	2020-05-25	3634	165	458	3197	draft
5066	Sudan	2020-05-25	2020-05-26	3826	170	503	3303	draft
5067	Sudan	2020-05-26	2020-05-27	3976	170	503	3303	draft
5068	Sudan	2020-05-27	2020-05-28	4146	195	749	3402	draft
5069	Sudan	2020-05-28	2020-05-29	4346	195	749	3402	draft
5071	Sudan	2020-05-30	2020-05-31	4521	262	1272	3266	draft
5072	Sudan	2020-05-31	2020-06-01	4800	286	1423	3317	draft
5073	Summer Olympics 2020	2020-05-01	2020-05-02	0	0	0	0	draft
5074	Summer Olympics 2020	2020-05-02	2020-05-03	0	0	0	0	draft
5075	Summer Olympics 2020	2020-05-03	2020-05-04	0	0	0	0	draft
5076	Summer Olympics 2020	2020-05-04	2020-05-05	0	0	0	0	draft
5077	Summer Olympics 2020	2020-05-05	2020-05-06	0	0	0	0	draft
5078	Summer Olympics 2020	2020-05-06	2020-05-07	0	0	0	0	draft
5079	Summer Olympics 2020	2020-05-07	2020-05-08	0	0	0	0	draft
5080	Summer Olympics 2020	2020-05-08	2020-05-09	0	0	0	0	draft
5081	Summer Olympics 2020	2020-05-09	2020-05-10	0	0	0	0	draft
5082	Summer Olympics 2020	2020-05-10	2020-05-11	0	0	0	0	draft
5083	Summer Olympics 2020	2020-05-11	2020-05-12	0	0	0	0	draft
5084	Summer Olympics 2020	2020-05-12	2020-05-13	0	0	0	0	draft
5085	Summer Olympics 2020	2020-05-13	2020-05-14	0	0	0	0	draft
5086	Summer Olympics 2020	2020-05-14	2020-05-15	0	0	0	0	draft
5087	Summer Olympics 2020	2020-05-15	2020-05-16	0	0	0	0	draft
5088	Summer Olympics 2020	2020-05-16	2020-05-17	0	0	0	0	draft
5089	Summer Olympics 2020	2020-05-17	2020-05-18	0	0	0	0	draft
5090	Summer Olympics 2020	2020-05-18	2020-05-19	0	0	0	0	draft
5091	Summer Olympics 2020	2020-05-19	2020-05-20	0	0	0	0	draft
5092	Summer Olympics 2020	2020-05-20	2020-05-21	0	0	0	0	draft
5093	Summer Olympics 2020	2020-05-21	2020-05-22	0	0	0	0	draft
5094	Summer Olympics 2020	2020-05-22	2020-05-23	0	0	0	0	draft
5095	Summer Olympics 2020	2020-05-23	2020-05-24	0	0	0	0	draft
5096	Summer Olympics 2020	2020-05-24	2020-05-25	0	0	0	0	draft
5097	Summer Olympics 2020	2020-05-25	2020-05-26	0	0	0	0	draft
5098	Summer Olympics 2020	2020-05-26	2020-05-27	0	0	0	0	draft
5099	Summer Olympics 2020	2020-05-27	2020-05-28	0	0	0	0	draft
5100	Summer Olympics 2020	2020-05-28	2020-05-29	0	0	0	0	draft
5101	Summer Olympics 2020	2020-05-29	2020-05-30	0	0	0	0	draft
5102	Summer Olympics 2020	2020-05-30	2020-05-31	0	0	0	0	draft
5103	Summer Olympics 2020	2020-05-31	2020-06-01	0	0	0	0	draft
5104	Suriname	2020-05-01	2020-05-02	10	1	8	1	draft
5105	Suriname	2020-05-02	2020-05-03	10	1	8	1	draft
5106	Suriname	2020-05-03	2020-05-04	10	1	9	0	draft
5107	Suriname	2020-05-04	2020-05-05	10	1	9	0	draft
5108	Suriname	2020-05-05	2020-05-06	10	1	9	0	draft
5109	Suriname	2020-05-06	2020-05-07	10	1	9	0	draft
5110	Suriname	2020-05-07	2020-05-08	10	1	9	0	draft
5111	Suriname	2020-05-08	2020-05-09	10	1	9	0	draft
5112	Suriname	2020-05-09	2020-05-10	10	1	9	0	draft
5113	Suriname	2020-05-10	2020-05-11	10	1	9	0	draft
5114	Suriname	2020-05-11	2020-05-12	10	1	9	0	draft
5115	Suriname	2020-05-12	2020-05-13	10	1	9	0	draft
5116	Suriname	2020-05-13	2020-05-14	10	1	9	0	draft
5117	Suriname	2020-05-14	2020-05-15	10	1	9	0	draft
5118	Suriname	2020-05-15	2020-05-16	10	1	9	0	draft
5119	Suriname	2020-05-16	2020-05-17	10	1	9	0	draft
5120	Suriname	2020-05-17	2020-05-18	10	1	9	0	draft
5121	Suriname	2020-05-18	2020-05-19	11	1	9	1	draft
5122	Suriname	2020-05-19	2020-05-20	11	1	9	1	draft
5123	Suriname	2020-05-20	2020-05-21	11	1	9	1	draft
5124	Suriname	2020-05-21	2020-05-22	11	1	9	1	draft
5125	Suriname	2020-05-22	2020-05-23	11	1	9	1	draft
5126	Suriname	2020-05-23	2020-05-24	11	1	9	1	draft
5127	Suriname	2020-05-24	2020-05-25	11	1	9	1	draft
5128	Suriname	2020-05-25	2020-05-26	11	1	9	1	draft
5129	Suriname	2020-05-26	2020-05-27	11	1	9	1	draft
5130	Suriname	2020-05-27	2020-05-28	12	1	9	2	draft
5131	Suriname	2020-05-28	2020-05-29	12	1	9	2	draft
5132	Suriname	2020-05-29	2020-05-30	12	1	9	2	draft
5133	Suriname	2020-05-30	2020-05-31	14	1	9	4	draft
5134	Suriname	2020-05-31	2020-06-01	23	1	9	13	draft
5135	Sweden	2020-05-01	2020-05-02	21520	2653	1005	17862	draft
5136	Sweden	2020-05-02	2020-05-03	22082	2669	1005	18408	draft
5137	Sweden	2020-05-03	2020-05-04	22317	2679	1005	18633	draft
5138	Sweden	2020-05-04	2020-05-05	22721	2769	4074	15878	draft
5139	Sweden	2020-05-05	2020-05-06	23216	2854	4074	16288	draft
5140	Sweden	2020-05-06	2020-05-07	23918	2941	4074	16903	draft
5141	Sweden	2020-05-07	2020-05-08	24623	3040	4971	16612	draft
5142	Sweden	2020-05-08	2020-05-09	25265	3175	4971	17119	draft
5143	Sweden	2020-05-09	2020-05-10	25921	3220	4971	17730	draft
5144	Sweden	2020-05-10	2020-05-11	26322	3225	4971	18126	draft
5145	Sweden	2020-05-11	2020-05-12	26670	3256	4971	18443	draft
5146	Sweden	2020-05-12	2020-05-13	27272	3313	4971	18988	draft
5147	Sweden	2020-05-13	2020-05-14	27909	3460	4971	19478	draft
5148	Sweden	2020-05-14	2020-05-15	28582	3529	4971	20082	draft
5149	Sweden	2020-05-15	2020-05-16	29207	3646	4971	20590	draft
5150	Sweden	2020-05-16	2020-05-17	29677	3674	4971	21032	draft
5151	Sweden	2020-05-17	2020-05-18	30143	3679	4971	21493	draft
5152	Sweden	2020-05-18	2020-05-19	30377	3698	4971	21708	draft
5153	Sweden	2020-05-19	2020-05-20	30799	3743	4971	22085	draft
5154	Sweden	2020-05-20	2020-05-21	31523	3831	4971	22721	draft
5155	Sweden	2020-05-21	2020-05-22	32172	3871	4971	23330	draft
5156	Sweden	2020-05-22	2020-05-23	32809	3925	4971	23913	draft
5157	Sweden	2020-05-23	2020-05-24	33188	3992	4971	24225	draft
5158	Sweden	2020-05-24	2020-05-25	33459	3998	4971	24490	draft
5159	Sweden	2020-05-25	2020-05-26	33843	4029	4971	24843	draft
5160	Sweden	2020-05-26	2020-05-27	34440	4125	4971	25344	draft
5161	Sweden	2020-05-27	2020-05-28	35088	4220	4971	25897	draft
5162	Sweden	2020-05-28	2020-05-29	35727	4266	4971	26490	draft
5163	Sweden	2020-05-29	2020-05-30	36476	4350	4971	27155	draft
5164	Sweden	2020-05-30	2020-05-31	37113	4395	4971	27747	draft
5165	Sweden	2020-05-31	2020-06-01	37542	4395	4971	28176	draft
5166	Switzerland	2020-05-01	2020-05-02	29705	1754	23900	4051	draft
5167	Switzerland	2020-05-02	2020-05-03	29817	1762	24200	3855	draft
5168	Switzerland	2020-05-03	2020-05-04	29905	1762	24500	3643	draft
5169	Switzerland	2020-05-04	2020-05-05	29981	1784	25200	2997	draft
5170	Switzerland	2020-05-05	2020-05-06	30009	1795	25400	2814	draft
5171	Switzerland	2020-05-06	2020-05-07	30060	1805	25700	2555	draft
5172	Switzerland	2020-05-07	2020-05-08	30126	1810	25900	2416	draft
5173	Switzerland	2020-05-08	2020-05-09	30207	1823	26100	2284	draft
5174	Switzerland	2020-05-09	2020-05-10	30251	1830	26400	2021	draft
5175	Switzerland	2020-05-10	2020-05-11	30305	1833	26600	1872	draft
5176	Switzerland	2020-05-11	2020-05-12	30344	1845	26800	1699	draft
5177	Switzerland	2020-05-12	2020-05-13	30380	1867	26800	1713	draft
5178	Switzerland	2020-05-13	2020-05-14	30413	1870	27100	1443	draft
5179	Switzerland	2020-05-14	2020-05-15	30463	1872	27100	1491	draft
5180	Switzerland	2020-05-15	2020-05-16	30514	1878	27100	1536	draft
5181	Switzerland	2020-05-16	2020-05-17	30572	1879	27400	1293	draft
5182	Switzerland	2020-05-17	2020-05-18	30587	1881	27500	1206	draft
5183	Switzerland	2020-05-18	2020-05-19	30597	1886	27600	1111	draft
5184	Switzerland	2020-05-19	2020-05-20	30618	1891	27700	1027	draft
5185	Switzerland	2020-05-20	2020-05-21	30658	1892	27800	966	draft
5186	Switzerland	2020-05-21	2020-05-22	30694	1898	27900	896	draft
5187	Switzerland	2020-05-22	2020-05-23	30707	1903	27900	904	draft
5188	Switzerland	2020-05-23	2020-05-24	30725	1905	28000	820	draft
5189	Switzerland	2020-05-24	2020-05-25	30736	1906	28100	730	draft
5190	Switzerland	2020-05-25	2020-05-26	30746	1913	28200	633	draft
5191	Switzerland	2020-05-26	2020-05-27	30761	1915	28200	646	draft
5192	Switzerland	2020-05-27	2020-05-28	30776	1917	28300	559	draft
5193	Switzerland	2020-05-28	2020-05-29	30796	1919	28300	577	draft
5194	Switzerland	2020-05-29	2020-05-30	30828	1919	28300	609	draft
5195	Switzerland	2020-05-30	2020-05-31	30845	1919	28400	526	draft
5196	Switzerland	2020-05-31	2020-06-01	30862	1920	28500	442	draft
5197	Syria	2020-05-01	2020-05-02	44	3	27	14	draft
5198	Syria	2020-05-02	2020-05-03	44	3	27	14	draft
5199	Syria	2020-05-03	2020-05-04	44	3	27	14	draft
5200	Syria	2020-05-04	2020-05-05	44	3	27	14	draft
5201	Syria	2020-05-05	2020-05-06	44	3	27	14	draft
5202	Syria	2020-05-06	2020-05-07	45	3	27	15	draft
5203	Syria	2020-05-07	2020-05-08	45	3	27	15	draft
5204	Syria	2020-05-08	2020-05-09	47	3	29	15	draft
5205	Syria	2020-05-09	2020-05-10	47	3	29	15	draft
5206	Syria	2020-05-10	2020-05-11	47	3	29	15	draft
5207	Syria	2020-05-11	2020-05-12	47	3	29	15	draft
5208	Syria	2020-05-12	2020-05-13	47	3	29	15	draft
5209	Syria	2020-05-13	2020-05-14	48	3	29	16	draft
5210	Syria	2020-05-14	2020-05-15	48	3	29	16	draft
5211	Syria	2020-05-15	2020-05-16	50	3	36	11	draft
5212	Syria	2020-05-16	2020-05-17	51	3	36	12	draft
5213	Syria	2020-05-17	2020-05-18	58	3	36	19	draft
5214	Syria	2020-05-18	2020-05-19	58	3	36	19	draft
5215	Syria	2020-05-19	2020-05-20	58	3	36	19	draft
5216	Syria	2020-05-20	2020-05-21	58	3	36	19	draft
5217	Syria	2020-05-21	2020-05-22	58	3	36	19	draft
5218	Syria	2020-05-22	2020-05-23	59	4	37	18	draft
5219	Syria	2020-05-23	2020-05-24	70	4	37	29	draft
5220	Syria	2020-05-24	2020-05-25	86	4	41	41	draft
5221	Syria	2020-05-25	2020-05-26	106	4	41	61	draft
5222	Syria	2020-05-26	2020-05-27	121	4	41	76	draft
5223	Syria	2020-05-27	2020-05-28	121	4	43	74	draft
5224	Syria	2020-05-28	2020-05-29	122	4	43	75	draft
5225	Syria	2020-05-29	2020-05-30	122	4	43	75	draft
5226	Syria	2020-05-30	2020-05-31	122	4	43	75	draft
5227	Syria	2020-05-31	2020-06-01	122	5	46	71	draft
5228	Taiwan*	2020-05-01	2020-05-02	429	6	324	99	draft
5229	Taiwan*	2020-05-02	2020-05-03	432	6	324	102	draft
5230	Taiwan*	2020-05-03	2020-05-04	436	6	332	98	draft
5231	Taiwan*	2020-05-04	2020-05-05	438	6	334	98	draft
5232	Taiwan*	2020-05-05	2020-05-06	438	6	334	98	draft
5233	Taiwan*	2020-05-06	2020-05-07	439	6	339	94	draft
5234	Taiwan*	2020-05-07	2020-05-08	440	6	347	87	draft
5235	Taiwan*	2020-05-08	2020-05-09	440	6	355	79	draft
5236	Taiwan*	2020-05-09	2020-05-10	440	6	361	73	draft
5237	Taiwan*	2020-05-10	2020-05-11	440	6	366	68	draft
5238	Taiwan*	2020-05-11	2020-05-12	440	7	368	65	draft
5239	Taiwan*	2020-05-12	2020-05-13	440	7	372	61	draft
5240	Taiwan*	2020-05-13	2020-05-14	440	7	375	58	draft
5241	Taiwan*	2020-05-14	2020-05-15	440	7	383	50	draft
5242	Taiwan*	2020-05-15	2020-05-16	440	7	387	46	draft
5243	Taiwan*	2020-05-16	2020-05-17	440	7	389	44	draft
5244	Taiwan*	2020-05-17	2020-05-18	440	7	395	38	draft
5245	Taiwan*	2020-05-18	2020-05-19	440	7	398	35	draft
5246	Taiwan*	2020-05-19	2020-05-20	440	7	398	35	draft
5247	Taiwan*	2020-05-20	2020-05-21	440	7	398	35	draft
5248	Taiwan*	2020-05-21	2020-05-22	440	7	398	35	draft
5249	Taiwan*	2020-05-22	2020-05-23	441	7	408	26	draft
5250	Taiwan*	2020-05-23	2020-05-24	441	7	411	23	draft
5251	Taiwan*	2020-05-24	2020-05-25	441	7	414	20	draft
5252	Taiwan*	2020-05-25	2020-05-26	441	7	415	19	draft
5253	Taiwan*	2020-05-26	2020-05-27	441	7	416	18	draft
5254	Taiwan*	2020-05-27	2020-05-28	441	7	419	15	draft
5255	Taiwan*	2020-05-28	2020-05-29	441	7	420	14	draft
5256	Taiwan*	2020-05-29	2020-05-30	442	7	420	15	draft
5257	Taiwan*	2020-05-30	2020-05-31	442	7	421	14	draft
5258	Taiwan*	2020-05-31	2020-06-01	442	7	423	12	draft
5259	Tajikistan	2020-05-01	2020-05-02	15	0	0	15	draft
5260	Tajikistan	2020-05-02	2020-05-03	76	2	0	74	draft
5261	Tajikistan	2020-05-03	2020-05-04	128	2	0	126	draft
5262	Tajikistan	2020-05-04	2020-05-05	230	3	0	227	draft
5263	Tajikistan	2020-05-05	2020-05-06	293	5	0	288	draft
5264	Tajikistan	2020-05-06	2020-05-07	379	8	0	371	draft
5265	Tajikistan	2020-05-07	2020-05-08	461	12	0	449	draft
5266	Tajikistan	2020-05-08	2020-05-09	522	12	0	510	draft
5267	Tajikistan	2020-05-09	2020-05-10	612	20	0	592	draft
5268	Tajikistan	2020-05-10	2020-05-11	612	20	0	592	draft
5269	Tajikistan	2020-05-11	2020-05-12	661	21	0	640	draft
5270	Tajikistan	2020-05-12	2020-05-13	729	21	0	708	draft
5271	Tajikistan	2020-05-13	2020-05-14	801	23	0	778	draft
5272	Tajikistan	2020-05-14	2020-05-15	907	29	0	878	draft
5273	Tajikistan	2020-05-15	2020-05-16	1118	33	0	1085	draft
5274	Tajikistan	2020-05-16	2020-05-17	1322	36	0	1286	draft
5275	Tajikistan	2020-05-17	2020-05-18	1524	39	0	1485	draft
5276	Tajikistan	2020-05-18	2020-05-19	1729	41	0	1688	draft
5277	Tajikistan	2020-05-19	2020-05-20	1936	41	641	1254	draft
5278	Tajikistan	2020-05-20	2020-05-21	2140	41	470	1629	draft
5279	Tajikistan	2020-05-21	2020-05-22	2350	44	470	1836	draft
5280	Tajikistan	2020-05-22	2020-05-23	2551	44	1089	1418	draft
5281	Tajikistan	2020-05-23	2020-05-24	2738	44	1223	1471	draft
5282	Tajikistan	2020-05-24	2020-05-25	2929	46	1301	1582	draft
5283	Tajikistan	2020-05-25	2020-05-26	3100	46	1395	1659	draft
5284	Tajikistan	2020-05-26	2020-05-27	3266	47	1417	1802	draft
5285	Tajikistan	2020-05-27	2020-05-28	3424	47	1575	1802	draft
5286	Tajikistan	2020-05-28	2020-05-29	3563	47	1674	1842	draft
5287	Tajikistan	2020-05-29	2020-05-30	3686	47	1769	1870	draft
5288	Tajikistan	2020-05-30	2020-05-31	3807	47	1865	1895	draft
5289	Tajikistan	2020-05-31	2020-06-01	3930	47	2004	1879	draft
5290	Tanzania	2020-05-01	2020-05-02	480	16	167	297	draft
5291	Tanzania	2020-05-02	2020-05-03	480	16	167	297	draft
5292	Tanzania	2020-05-03	2020-05-04	480	16	167	297	draft
5293	Tanzania	2020-05-04	2020-05-05	480	16	167	297	draft
5294	Tanzania	2020-05-05	2020-05-06	480	16	167	297	draft
5295	Tanzania	2020-05-06	2020-05-07	480	16	167	297	draft
5296	Tanzania	2020-05-07	2020-05-08	480	16	167	297	draft
5297	Tanzania	2020-05-08	2020-05-09	509	21	183	305	draft
5298	Tanzania	2020-05-09	2020-05-10	509	21	183	305	draft
5299	Tanzania	2020-05-10	2020-05-11	509	21	183	305	draft
5300	Tanzania	2020-05-11	2020-05-12	509	21	183	305	draft
5301	Tanzania	2020-05-12	2020-05-13	509	21	183	305	draft
5302	Tanzania	2020-05-13	2020-05-14	509	21	183	305	draft
5303	Tanzania	2020-05-14	2020-05-15	509	21	183	305	draft
5304	Tanzania	2020-05-15	2020-05-16	509	21	183	305	draft
5305	Tanzania	2020-05-16	2020-05-17	509	21	183	305	draft
5306	Tanzania	2020-05-17	2020-05-18	509	21	183	305	draft
5307	Tanzania	2020-05-18	2020-05-19	509	21	183	305	draft
5308	Tanzania	2020-05-19	2020-05-20	509	21	183	305	draft
5309	Tanzania	2020-05-20	2020-05-21	509	21	183	305	draft
5310	Tanzania	2020-05-21	2020-05-22	509	21	183	305	draft
5311	Tanzania	2020-05-22	2020-05-23	509	21	183	305	draft
5312	Tanzania	2020-05-23	2020-05-24	509	21	183	305	draft
5313	Tanzania	2020-05-24	2020-05-25	509	21	183	305	draft
5314	Tanzania	2020-05-25	2020-05-26	509	21	183	305	draft
5315	Tanzania	2020-05-26	2020-05-27	509	21	183	305	draft
5316	Tanzania	2020-05-27	2020-05-28	509	21	183	305	draft
5317	Tanzania	2020-05-28	2020-05-29	509	21	183	305	draft
5318	Tanzania	2020-05-29	2020-05-30	509	21	183	305	draft
5319	Tanzania	2020-05-30	2020-05-31	509	21	183	305	draft
5320	Tanzania	2020-05-31	2020-06-01	509	21	183	305	draft
5321	Thailand	2020-05-01	2020-05-02	2960	54	2719	187	draft
5322	Thailand	2020-05-02	2020-05-03	2966	54	2732	180	draft
5323	Thailand	2020-05-03	2020-05-04	2969	54	2739	176	draft
5324	Thailand	2020-05-04	2020-05-05	2987	54	2740	193	draft
5325	Thailand	2020-05-05	2020-05-06	2988	54	2747	187	draft
5326	Thailand	2020-05-06	2020-05-07	2989	55	2761	173	draft
5327	Thailand	2020-05-07	2020-05-08	2992	55	2772	165	draft
5328	Thailand	2020-05-08	2020-05-09	3000	55	2784	161	draft
5329	Thailand	2020-05-09	2020-05-10	3004	56	2787	161	draft
5330	Thailand	2020-05-10	2020-05-11	3009	56	2794	159	draft
5331	Thailand	2020-05-11	2020-05-12	3015	56	2796	163	draft
5332	Thailand	2020-05-12	2020-05-13	3017	56	2798	163	draft
5333	Thailand	2020-05-13	2020-05-14	3017	56	2844	117	draft
5334	Thailand	2020-05-14	2020-05-15	3018	56	2850	112	draft
5335	Thailand	2020-05-15	2020-05-16	3025	56	2854	115	draft
5336	Thailand	2020-05-16	2020-05-17	3025	56	2855	114	draft
5337	Thailand	2020-05-17	2020-05-18	3028	56	2856	116	draft
5338	Thailand	2020-05-18	2020-05-19	3031	56	2857	118	draft
5339	Thailand	2020-05-19	2020-05-20	3033	56	2857	120	draft
5340	Thailand	2020-05-20	2020-05-21	3034	56	2888	90	draft
5341	Thailand	2020-05-21	2020-05-22	3037	56	2897	84	draft
5342	Thailand	2020-05-22	2020-05-23	3037	56	2910	71	draft
5343	Thailand	2020-05-23	2020-05-24	3040	56	2916	68	draft
5344	Thailand	2020-05-24	2020-05-25	3040	56	2921	63	draft
5345	Thailand	2020-05-25	2020-05-26	3042	57	2928	57	draft
5346	Thailand	2020-05-26	2020-05-27	3045	57	2929	59	draft
5347	Thailand	2020-05-27	2020-05-28	3054	57	2931	66	draft
5348	Thailand	2020-05-28	2020-05-29	3065	57	2945	63	draft
5349	Thailand	2020-05-29	2020-05-30	3076	57	2945	74	draft
5350	Thailand	2020-05-30	2020-05-31	3077	57	2961	59	draft
5351	Thailand	2020-05-31	2020-06-01	3081	57	2963	61	draft
5352	Timor-Leste	2020-05-01	2020-05-02	24	0	16	8	draft
5353	Timor-Leste	2020-05-02	2020-05-03	24	0	16	8	draft
5354	Timor-Leste	2020-05-03	2020-05-04	24	0	16	8	draft
5355	Timor-Leste	2020-05-04	2020-05-05	24	0	20	4	draft
5356	Timor-Leste	2020-05-05	2020-05-06	24	0	20	4	draft
5357	Timor-Leste	2020-05-06	2020-05-07	24	0	20	4	draft
5358	Timor-Leste	2020-05-07	2020-05-08	24	0	21	3	draft
5359	Timor-Leste	2020-05-08	2020-05-09	24	0	21	3	draft
5360	Timor-Leste	2020-05-09	2020-05-10	24	0	21	3	draft
5361	Timor-Leste	2020-05-10	2020-05-11	24	0	21	3	draft
5362	Timor-Leste	2020-05-11	2020-05-12	24	0	21	3	draft
5363	Timor-Leste	2020-05-12	2020-05-13	24	0	21	3	draft
5364	Timor-Leste	2020-05-13	2020-05-14	24	0	21	3	draft
5365	Timor-Leste	2020-05-14	2020-05-15	24	0	21	3	draft
5366	Timor-Leste	2020-05-15	2020-05-16	24	0	24	0	draft
5367	Timor-Leste	2020-05-16	2020-05-17	24	0	24	0	draft
5368	Timor-Leste	2020-05-17	2020-05-18	24	0	24	0	draft
5369	Timor-Leste	2020-05-18	2020-05-19	24	0	24	0	draft
5370	Timor-Leste	2020-05-19	2020-05-20	24	0	24	0	draft
5371	Timor-Leste	2020-05-20	2020-05-21	24	0	24	0	draft
5372	Timor-Leste	2020-05-21	2020-05-22	24	0	24	0	draft
5373	Timor-Leste	2020-05-22	2020-05-23	24	0	24	0	draft
5374	Timor-Leste	2020-05-23	2020-05-24	24	0	24	0	draft
5375	Timor-Leste	2020-05-24	2020-05-25	24	0	24	0	draft
5376	Timor-Leste	2020-05-25	2020-05-26	24	0	24	0	draft
5377	Timor-Leste	2020-05-26	2020-05-27	24	0	24	0	draft
5378	Timor-Leste	2020-05-27	2020-05-28	24	0	24	0	draft
5379	Timor-Leste	2020-05-28	2020-05-29	24	0	24	0	draft
5380	Timor-Leste	2020-05-29	2020-05-30	24	0	24	0	draft
5381	Timor-Leste	2020-05-30	2020-05-31	24	0	24	0	draft
5382	Timor-Leste	2020-05-31	2020-06-01	24	0	24	0	draft
5383	Togo	2020-05-01	2020-05-02	123	9	66	48	draft
5384	Togo	2020-05-02	2020-05-03	123	9	66	48	draft
5385	Togo	2020-05-03	2020-05-04	124	9	67	48	draft
5386	Togo	2020-05-04	2020-05-05	126	9	74	43	draft
5387	Togo	2020-05-05	2020-05-06	128	9	74	45	draft
5388	Togo	2020-05-06	2020-05-07	128	9	77	42	draft
5389	Togo	2020-05-07	2020-05-08	135	9	85	41	draft
5390	Togo	2020-05-08	2020-05-09	145	10	85	50	draft
5391	Togo	2020-05-09	2020-05-10	153	10	87	56	draft
5392	Togo	2020-05-10	2020-05-11	174	11	89	74	draft
5393	Togo	2020-05-11	2020-05-12	181	11	89	81	draft
5394	Togo	2020-05-12	2020-05-13	199	11	92	96	draft
5395	Togo	2020-05-13	2020-05-14	219	11	96	112	draft
5396	Togo	2020-05-14	2020-05-15	238	11	96	131	draft
5397	Togo	2020-05-15	2020-05-16	263	11	96	156	draft
5398	Togo	2020-05-16	2020-05-17	298	11	99	188	draft
5399	Togo	2020-05-17	2020-05-18	301	11	104	186	draft
5400	Togo	2020-05-18	2020-05-19	330	12	106	212	draft
5401	Togo	2020-05-19	2020-05-20	338	12	107	219	draft
5402	Togo	2020-05-20	2020-05-21	340	12	110	218	draft
5403	Togo	2020-05-21	2020-05-22	354	12	118	224	draft
5404	Togo	2020-05-22	2020-05-23	363	12	121	230	draft
5405	Togo	2020-05-23	2020-05-24	373	12	133	228	draft
5406	Togo	2020-05-24	2020-05-25	381	12	141	228	draft
5407	Togo	2020-05-25	2020-05-26	386	13	161	212	draft
5408	Togo	2020-05-26	2020-05-27	391	13	177	201	draft
5409	Togo	2020-05-27	2020-05-28	395	13	183	199	draft
5410	Togo	2020-05-28	2020-05-29	422	13	197	212	draft
5411	Togo	2020-05-29	2020-05-30	428	13	202	213	draft
5412	Togo	2020-05-30	2020-05-31	433	13	206	214	draft
5413	Togo	2020-05-31	2020-06-01	442	13	211	218	draft
5414	Trinidad and Tobago	2020-05-01	2020-05-02	116	8	83	25	draft
5415	Trinidad and Tobago	2020-05-02	2020-05-03	116	8	88	20	draft
5416	Trinidad and Tobago	2020-05-03	2020-05-04	116	8	93	15	draft
5417	Trinidad and Tobago	2020-05-04	2020-05-05	116	8	99	9	draft
5418	Trinidad and Tobago	2020-05-05	2020-05-06	116	8	103	5	draft
5419	Trinidad and Tobago	2020-05-06	2020-05-07	116	8	103	5	draft
5420	Trinidad and Tobago	2020-05-07	2020-05-08	116	8	103	5	draft
5421	Trinidad and Tobago	2020-05-08	2020-05-09	116	8	103	5	draft
5422	Trinidad and Tobago	2020-05-09	2020-05-10	116	8	104	4	draft
5423	Trinidad and Tobago	2020-05-10	2020-05-11	116	8	107	1	draft
5424	Trinidad and Tobago	2020-05-11	2020-05-12	116	8	107	1	draft
5425	Trinidad and Tobago	2020-05-12	2020-05-13	116	8	107	1	draft
5426	Trinidad and Tobago	2020-05-13	2020-05-14	116	8	107	1	draft
5427	Trinidad and Tobago	2020-05-14	2020-05-15	116	8	107	1	draft
5428	Trinidad and Tobago	2020-05-15	2020-05-16	116	8	107	1	draft
5429	Trinidad and Tobago	2020-05-16	2020-05-17	116	8	107	1	draft
5430	Trinidad and Tobago	2020-05-17	2020-05-18	116	8	107	1	draft
5431	Trinidad and Tobago	2020-05-18	2020-05-19	116	8	107	1	draft
5432	Trinidad and Tobago	2020-05-19	2020-05-20	116	8	107	1	draft
5433	Trinidad and Tobago	2020-05-20	2020-05-21	116	8	107	1	draft
5434	Trinidad and Tobago	2020-05-21	2020-05-22	116	8	108	0	draft
5435	Trinidad and Tobago	2020-05-22	2020-05-23	116	8	108	0	draft
5436	Trinidad and Tobago	2020-05-23	2020-05-24	116	8	108	0	draft
5437	Trinidad and Tobago	2020-05-24	2020-05-25	116	8	108	0	draft
5438	Trinidad and Tobago	2020-05-25	2020-05-26	116	8	108	0	draft
5439	Trinidad and Tobago	2020-05-26	2020-05-27	116	8	108	0	draft
5440	Trinidad and Tobago	2020-05-27	2020-05-28	116	8	108	0	draft
5441	Trinidad and Tobago	2020-05-28	2020-05-29	116	8	108	0	draft
5442	Trinidad and Tobago	2020-05-29	2020-05-30	116	8	108	0	draft
5443	Trinidad and Tobago	2020-05-30	2020-05-31	117	8	108	1	draft
5444	Trinidad and Tobago	2020-05-31	2020-06-01	117	8	108	1	draft
5445	Tunisia	2020-05-01	2020-05-02	998	41	316	641	draft
5446	Tunisia	2020-05-02	2020-05-03	1009	42	323	644	draft
5447	Tunisia	2020-05-03	2020-05-04	1013	42	328	643	draft
5448	Tunisia	2020-05-04	2020-05-05	1018	43	406	569	draft
5449	Tunisia	2020-05-05	2020-05-06	1022	43	482	497	draft
5450	Tunisia	2020-05-06	2020-05-07	1025	43	591	391	draft
5451	Tunisia	2020-05-07	2020-05-08	1026	44	600	382	draft
5452	Tunisia	2020-05-08	2020-05-09	1030	45	638	347	draft
5453	Tunisia	2020-05-09	2020-05-10	1032	45	660	327	draft
5454	Tunisia	2020-05-10	2020-05-11	1032	45	700	287	draft
5455	Tunisia	2020-05-11	2020-05-12	1032	45	727	260	draft
5456	Tunisia	2020-05-12	2020-05-13	1032	45	740	247	draft
5457	Tunisia	2020-05-13	2020-05-14	1032	45	759	228	draft
5458	Tunisia	2020-05-14	2020-05-15	1032	45	770	217	draft
5459	Tunisia	2020-05-15	2020-05-16	1035	45	802	188	draft
5460	Tunisia	2020-05-16	2020-05-17	1037	45	807	185	draft
5461	Tunisia	2020-05-17	2020-05-18	1037	45	816	176	draft
5462	Tunisia	2020-05-18	2020-05-19	1043	46	819	178	draft
5463	Tunisia	2020-05-19	2020-05-20	1044	47	826	171	draft
5464	Tunisia	2020-05-20	2020-05-21	1045	47	862	136	draft
5465	Tunisia	2020-05-21	2020-05-22	1046	47	883	116	draft
5466	Tunisia	2020-05-22	2020-05-23	1048	47	903	98	draft
5467	Tunisia	2020-05-23	2020-05-24	1048	48	914	86	draft
5468	Tunisia	2020-05-24	2020-05-25	1051	48	917	86	draft
5469	Tunisia	2020-05-25	2020-05-26	1051	48	919	84	draft
5470	Tunisia	2020-05-26	2020-05-27	1051	48	929	74	draft
5471	Tunisia	2020-05-27	2020-05-28	1051	48	929	74	draft
5472	Tunisia	2020-05-28	2020-05-29	1068	48	938	82	draft
5473	Tunisia	2020-05-29	2020-05-30	1071	48	946	77	draft
5474	Tunisia	2020-05-30	2020-05-31	1076	48	950	78	draft
5475	Tunisia	2020-05-31	2020-06-01	1077	48	960	69	draft
5476	Turkey	2020-05-01	2020-05-02	122392	3258	53808	65326	draft
5477	Turkey	2020-05-02	2020-05-03	124375	3336	58259	62780	draft
5478	Turkey	2020-05-03	2020-05-04	126045	3397	63151	59497	draft
5479	Turkey	2020-05-04	2020-05-05	127659	3461	68166	56032	draft
5480	Turkey	2020-05-05	2020-05-06	129491	3520	73285	52686	draft
5481	Turkey	2020-05-06	2020-05-07	131744	3584	78202	49958	draft
5482	Turkey	2020-05-07	2020-05-08	133721	3641	82984	47096	draft
5483	Turkey	2020-05-08	2020-05-09	135569	3689	86396	45484	draft
5484	Turkey	2020-05-09	2020-05-10	137115	3739	89480	43896	draft
5485	Turkey	2020-05-10	2020-05-11	138657	3786	92691	42180	draft
5486	Turkey	2020-05-11	2020-05-12	139771	3841	95780	40150	draft
5487	Turkey	2020-05-12	2020-05-13	141475	3894	98889	38692	draft
5488	Turkey	2020-05-13	2020-05-14	143114	3952	101715	37447	draft
5489	Turkey	2020-05-14	2020-05-15	144749	4007	104030	36712	draft
5490	Turkey	2020-05-15	2020-05-16	146457	4055	106133	36269	draft
5491	Turkey	2020-05-16	2020-05-17	148067	4096	108137	35834	draft
5492	Turkey	2020-05-17	2020-05-18	149435	4140	109962	35333	draft
5493	Turkey	2020-05-18	2020-05-19	150593	4171	111577	34845	draft
5494	Turkey	2020-05-19	2020-05-20	151615	4199	112895	34521	draft
5495	Turkey	2020-05-20	2020-05-21	152587	4222	113987	34378	draft
5496	Turkey	2020-05-21	2020-05-22	153548	4249	114990	34309	draft
5497	Turkey	2020-05-22	2020-05-23	154500	4276	116111	34113	draft
5498	Turkey	2020-05-23	2020-05-24	155686	4308	117602	33776	draft
5499	Turkey	2020-05-24	2020-05-25	156827	4340	118694	33793	draft
5500	Turkey	2020-05-25	2020-05-26	157814	4369	120015	33430	draft
5501	Turkey	2020-05-26	2020-05-27	158762	4397	121507	32858	draft
5502	Turkey	2020-05-27	2020-05-28	159797	4431	122793	32573	draft
5503	Turkey	2020-05-28	2020-05-29	160979	4461	124369	32149	draft
5504	Turkey	2020-05-29	2020-05-30	162120	4489	125963	31668	draft
5505	Turkey	2020-05-30	2020-05-31	163103	4515	126984	31604	draft
5506	Turkey	2020-05-31	2020-06-01	163942	4540	127973	31429	draft
5507	US	2020-05-01	2020-05-02	1104691	65386	164015	903178	draft
5508	US	2020-05-02	2020-05-03	1133576	66966	175382	917894	draft
5509	US	2020-05-03	2020-05-04	1158859	68350	180152	939851	draft
5510	US	2020-05-04	2020-05-05	1181277	69641	187180	954281	draft
5511	US	2020-05-05	2020-05-06	1205428	71687	189791	972526	draft
5512	US	2020-05-06	2021-04-02	1229809	73887	189910	987827	draft
5513	US	2020-05-07	2021-04-02	1258204	76112	195036	1011058	draft
5514	US	2020-05-08	2021-04-02	1285206	77636	198993	1027704	draft
5515	US	2020-05-09	2021-04-02	1311126	79233	212534	1033324	draft
5516	US	2020-05-10	2021-04-02	1330677	80046	216169	1043141	draft
5517	US	2020-05-11	2021-04-02	1349027	81238	232733	1051488	draft
5518	US	2020-05-12	2021-04-02	1371262	82906	230287	1057473	draft
5519	US	2020-05-13	2021-04-02	1392010	84605	243430	1067859	draft
5520	US	2020-05-14	2021-04-02	1419022	86384	246414	1085191	draft
5521	US	2020-05-15	2021-04-02	1444125	88008	250747	1102212	draft
5522	US	2020-05-16	2021-04-02	1469160	89219	268376	1111939	draft
5523	US	2020-05-17	2021-04-02	1488256	90086	272265	1122366	draft
5524	US	2020-05-18	2021-04-02	1509949	90923	283178	1135016	draft
5525	US	2020-05-19	2021-04-02	1530327	92404	289392	1144851	draft
5526	US	2020-05-20	2021-04-02	1553435	93901	294312	1162407	draft
5527	US	2020-05-21	2021-04-02	1578909	95123	298418	1180548	draft
5528	US	2020-05-22	2021-04-02	1602815	96378	350135	1195014	draft
5529	US	2020-05-23	2021-04-02	1624155	97460	361239	1197128	draft
5530	US	2020-05-24	2021-04-02	1644622	98106	366736	1210704	draft
5531	US	2020-05-25	2021-04-02	1663640	98645	379157	1218472	draft
5532	US	2020-05-26	2021-04-02	1682562	99341	384902	1228728	draft
5533	US	2020-05-27	2021-04-02	1701037	100798	391508	1234641	draft
5534	US	2020-05-28	2021-04-02	1723667	101905	399991	1249340	draft
5535	US	2020-05-29	2021-04-02	1748095	103074	406446	1267758	draft
5536	US	2020-05-30	2021-04-02	1772316	104045	416461	1284150	draft
5537	US	2020-05-31	2021-04-02	1791873	104681	444758	1295795	draft
5538	Uganda	2020-05-01	2020-05-02	85	0	52	33	draft
5539	Uganda	2020-05-02	2020-05-03	88	0	52	36	draft
5540	Uganda	2020-05-03	2020-05-04	89	0	52	37	draft
5541	Uganda	2020-05-04	2020-05-05	97	0	55	42	draft
5542	Uganda	2020-05-05	2020-05-06	98	0	55	43	draft
5543	Uganda	2020-05-06	2020-05-07	100	0	55	45	draft
5544	Uganda	2020-05-07	2020-05-08	101	0	55	46	draft
5545	Uganda	2020-05-08	2020-05-09	101	0	55	46	draft
5546	Uganda	2020-05-09	2020-05-10	116	0	55	61	draft
5547	Uganda	2020-05-10	2020-05-11	121	0	55	66	draft
5548	Uganda	2020-05-11	2020-05-12	121	0	55	66	draft
5549	Uganda	2020-05-12	2020-05-13	129	0	55	74	draft
5550	Uganda	2020-05-13	2020-05-14	139	0	55	84	draft
5551	Uganda	2020-05-14	2020-05-15	160	0	63	97	draft
5552	Uganda	2020-05-15	2020-05-16	203	0	63	140	draft
5553	Uganda	2020-05-16	2020-05-17	227	0	63	164	draft
5554	Uganda	2020-05-17	2020-05-18	227	0	63	164	draft
5555	Uganda	2020-05-18	2020-05-19	248	0	63	185	draft
5556	Uganda	2020-05-19	2020-05-20	260	0	63	197	draft
5557	Uganda	2020-05-20	2020-05-21	264	0	65	199	draft
5558	Uganda	2020-05-21	2020-05-22	160	0	66	94	draft
5559	Uganda	2020-05-22	2020-05-23	175	0	68	107	draft
5560	Uganda	2020-05-23	2020-05-24	198	0	68	130	draft
5561	Uganda	2020-05-24	2020-05-25	198	0	68	130	draft
5562	Uganda	2020-05-25	2020-05-26	222	0	69	153	draft
5563	Uganda	2020-05-26	2020-05-27	253	0	69	184	draft
5564	Uganda	2020-05-27	2020-05-28	281	0	69	212	draft
5565	Uganda	2020-05-28	2020-05-29	317	0	69	248	draft
5566	Uganda	2020-05-29	2020-05-30	329	0	72	257	draft
5567	Uganda	2020-05-30	2020-05-31	413	0	72	341	draft
5568	Uganda	2020-05-31	2020-06-01	417	0	72	345	draft
5569	Ukraine	2020-05-01	2020-05-02	10861	272	1413	9176	draft
5570	Ukraine	2020-05-02	2020-05-03	11411	279	1498	9634	draft
5571	Ukraine	2020-05-03	2020-05-04	11913	288	1548	10077	draft
5572	Ukraine	2020-05-04	2020-05-05	12331	303	1619	10409	draft
5573	Ukraine	2020-05-05	2020-05-06	12697	316	1875	10506	draft
5574	Ukraine	2020-05-06	2020-05-07	13184	327	2097	10760	draft
5575	Ukraine	2020-05-07	2020-05-08	13691	340	2396	10955	draft
5576	Ukraine	2020-05-08	2020-05-09	14195	361	2706	11128	draft
5577	Ukraine	2020-05-09	2020-05-10	14710	376	2909	11425	draft
5578	Ukraine	2020-05-10	2020-05-11	15232	391	3060	11781	draft
5579	Ukraine	2020-05-11	2020-05-12	15648	408	3288	11952	draft
5580	Ukraine	2020-05-12	2020-05-13	16023	425	3373	12225	draft
5581	Ukraine	2020-05-13	2020-05-14	16425	439	3716	12270	draft
5582	Ukraine	2020-05-14	2020-05-15	16847	456	4143	12248	draft
5583	Ukraine	2020-05-15	2020-05-16	17330	476	4473	12381	draft
5584	Ukraine	2020-05-16	2020-05-17	17858	497	4906	12455	draft
5585	Ukraine	2020-05-17	2020-05-18	18291	514	5116	12661	draft
5586	Ukraine	2020-05-18	2020-05-19	18616	535	5276	12805	draft
5587	Ukraine	2020-05-19	2020-05-20	18876	548	5632	12696	draft
5588	Ukraine	2020-05-20	2020-05-21	19230	564	5955	12711	draft
5589	Ukraine	2020-05-21	2020-05-22	19706	579	6227	12900	draft
5590	Ukraine	2020-05-22	2020-05-23	20148	588	6585	12975	draft
5591	Ukraine	2020-05-23	2020-05-24	20580	605	6929	13046	draft
5592	Ukraine	2020-05-24	2020-05-25	20986	617	7108	13261	draft
5593	Ukraine	2020-05-25	2020-05-26	21245	623	7234	13388	draft
5594	Ukraine	2020-05-26	2020-05-27	21584	644	7575	13365	draft
5595	Ukraine	2020-05-27	2020-05-28	21905	658	7995	13252	draft
5596	Ukraine	2020-05-28	2020-05-29	22382	669	8439	13274	draft
5597	Ukraine	2020-05-29	2020-05-30	22811	679	8934	13198	draft
5598	Ukraine	2020-05-30	2020-05-31	23204	696	9311	13197	draft
5599	Ukraine	2020-05-31	2020-06-01	23672	708	9538	13426	draft
5600	United Arab Emirates	2020-05-01	2020-05-02	13038	111	2543	10384	draft
5601	United Arab Emirates	2020-05-02	2020-05-03	13599	119	2664	10816	draft
5602	United Arab Emirates	2020-05-03	2020-05-04	14163	126	2763	11274	draft
5603	United Arab Emirates	2020-05-04	2020-05-05	14730	137	2966	11627	draft
5604	United Arab Emirates	2020-05-05	2020-05-06	15192	146	3153	11893	draft
5605	United Arab Emirates	2020-05-06	2020-05-07	15738	157	3359	12222	draft
5606	United Arab Emirates	2020-05-07	2020-05-08	16240	165	3572	12503	draft
5607	United Arab Emirates	2020-05-08	2020-05-09	16793	174	3837	12782	draft
5608	United Arab Emirates	2020-05-09	2020-05-10	17417	185	4295	12937	draft
5609	United Arab Emirates	2020-05-10	2020-05-11	18198	198	4804	13196	draft
5610	United Arab Emirates	2020-05-11	2020-05-12	18878	201	5381	13296	draft
5611	United Arab Emirates	2020-05-12	2020-05-13	19661	203	6012	13446	draft
5612	United Arab Emirates	2020-05-13	2020-05-14	20386	206	6523	13657	draft
5613	United Arab Emirates	2020-05-14	2020-05-15	21084	208	6930	13946	draft
5614	United Arab Emirates	2020-05-15	2020-05-16	21831	210	7328	14293	draft
5615	United Arab Emirates	2020-05-16	2020-05-17	22627	214	7931	14482	draft
5616	United Arab Emirates	2020-05-17	2020-05-18	23358	220	8512	14626	draft
5617	United Arab Emirates	2020-05-18	2020-05-19	24190	224	9577	14389	draft
5618	United Arab Emirates	2020-05-19	2020-05-20	25063	227	10791	14045	draft
5619	United Arab Emirates	2020-05-20	2020-05-21	26004	233	11809	13962	draft
5620	United Arab Emirates	2020-05-21	2020-05-22	26898	237	12755	13906	draft
5621	United Arab Emirates	2020-05-22	2020-05-23	27892	241	13798	13853	draft
5622	United Arab Emirates	2020-05-23	2020-05-24	28704	244	14495	13965	draft
5623	United Arab Emirates	2020-05-24	2020-05-25	29485	245	15056	14184	draft
5624	United Arab Emirates	2020-05-25	2020-05-26	30307	248	15657	14402	draft
5625	United Arab Emirates	2020-05-26	2020-05-27	31086	253	15982	14851	draft
5846	Yemen	2020-05-30	2020-05-31	310	77	13	220	draft
5626	United Arab Emirates	2020-05-27	2020-05-28	31969	255	16371	15343	draft
5627	United Arab Emirates	2020-05-28	2020-05-29	32532	258	16685	15589	draft
5628	United Arab Emirates	2020-05-29	2020-05-30	33170	260	17097	15813	draft
5629	United Arab Emirates	2020-05-30	2020-05-31	33896	262	17546	16088	draft
5630	United Arab Emirates	2020-05-31	2020-06-01	34557	264	17932	16361	draft
5631	United Kingdom	2020-05-01	2020-05-02	178685	27583	892	150210	draft
5632	United Kingdom	2020-05-02	2020-05-03	183500	28205	896	154399	draft
5633	United Kingdom	2020-05-03	2020-05-04	187842	28520	901	158421	draft
5634	United Kingdom	2020-05-04	2020-05-05	191832	28809	910	162113	draft
5635	United Kingdom	2020-05-05	2020-05-06	196243	29501	926	165816	draft
5753	Venezuela	2020-05-30	2020-05-31	1459	14	302	1143	draft
5636	United Kingdom	2020-05-06	2020-05-07	202359	30150	934	171275	draft
5637	United Kingdom	2020-05-07	2020-05-08	207977	30689	970	176318	draft
5638	United Kingdom	2020-05-08	2020-05-09	212629	31316	997	180316	draft
5639	United Kingdom	2020-05-09	2020-05-10	216525	31662	1001	183862	draft
5640	United Kingdom	2020-05-10	2020-05-11	220449	31930	1002	187517	draft
5641	United Kingdom	2020-05-11	2020-05-12	224332	32141	1015	191176	draft
5642	United Kingdom	2020-05-12	2020-05-13	227741	32769	1023	193949	draft
5643	United Kingdom	2020-05-13	2020-05-14	230985	33264	1032	196689	draft
5644	United Kingdom	2020-05-14	2020-05-15	234440	33693	1043	199704	draft
5645	United Kingdom	2020-05-15	2020-05-16	238004	34078	1047	202879	draft
5646	United Kingdom	2020-05-16	2020-05-17	241461	34546	1058	205857	draft
5647	United Kingdom	2020-05-17	2020-05-18	244995	34716	1058	209221	draft
5648	United Kingdom	2020-05-18	2020-05-19	247709	34876	1090	211743	draft
5649	United Kingdom	2020-05-19	2020-05-20	250138	35422	1099	213617	draft
5650	United Kingdom	2020-05-20	2020-05-21	249619	35786	1116	212717	draft
5651	United Kingdom	2020-05-21	2020-05-22	252246	36124	1134	214988	draft
5652	United Kingdom	2020-05-22	2020-05-23	255544	36475	1142	217927	draft
5653	United Kingdom	2020-05-23	2020-05-24	258504	36757	1149	220598	draft
5654	United Kingdom	2020-05-24	2020-05-25	260916	36875	1151	222890	draft
5655	United Kingdom	2020-05-25	2020-05-26	262547	36996	1161	224390	draft
5656	United Kingdom	2020-05-26	2020-05-27	266599	37130	1161	228308	draft
5657	United Kingdom	2020-05-27	2020-05-28	268619	37542	1166	229911	draft
5658	United Kingdom	2020-05-28	2020-05-29	270508	37919	1167	231422	draft
5659	United Kingdom	2020-05-29	2020-05-30	272607	38243	1172	233192	draft
5660	United Kingdom	2020-05-30	2020-05-31	274219	38458	1187	234574	draft
5661	United Kingdom	2020-05-31	2020-06-01	276156	38571	1190	236395	draft
5662	Uruguay	2020-05-01	2020-05-02	648	17	435	196	draft
5663	Uruguay	2020-05-02	2020-05-03	652	17	440	195	draft
5664	Uruguay	2020-05-03	2020-05-04	655	17	442	196	draft
5665	Uruguay	2020-05-04	2020-05-05	657	17	447	193	draft
5666	Uruguay	2020-05-05	2020-05-06	670	17	468	185	draft
5667	Uruguay	2020-05-06	2020-05-07	673	17	486	170	draft
5668	Uruguay	2020-05-07	2020-05-08	684	17	492	175	draft
5669	Uruguay	2020-05-08	2020-05-09	694	18	506	170	draft
5670	Uruguay	2020-05-09	2020-05-10	702	18	513	171	draft
5671	Uruguay	2020-05-10	2020-05-11	707	19	517	171	draft
5672	Uruguay	2020-05-11	2020-05-12	711	19	523	169	draft
5673	Uruguay	2020-05-12	2020-05-13	717	19	532	166	draft
5674	Uruguay	2020-05-13	2020-05-14	719	19	545	155	draft
5675	Uruguay	2020-05-14	2020-05-15	724	19	547	158	draft
5676	Uruguay	2020-05-15	2020-05-16	732	19	553	160	draft
5677	Uruguay	2020-05-16	2020-05-17	733	19	558	156	draft
5678	Uruguay	2020-05-17	2020-05-18	734	20	564	150	draft
5679	Uruguay	2020-05-18	2020-05-19	737	20	569	148	draft
5680	Uruguay	2020-05-19	2020-05-20	738	20	579	139	draft
5681	Uruguay	2020-05-20	2020-05-21	746	20	588	138	draft
5682	Uruguay	2020-05-21	2020-05-22	749	20	594	135	draft
5683	Uruguay	2020-05-22	2020-05-23	753	20	603	130	draft
5684	Uruguay	2020-05-23	2020-05-24	764	22	616	126	draft
5685	Uruguay	2020-05-24	2020-05-25	769	22	618	129	draft
5686	Uruguay	2020-05-25	2020-05-26	787	22	629	136	draft
5687	Uruguay	2020-05-26	2020-05-27	789	22	638	129	draft
5688	Uruguay	2020-05-27	2020-05-28	803	22	650	131	draft
5689	Uruguay	2020-05-28	2020-05-29	811	22	654	135	draft
5690	Uruguay	2020-05-29	2020-05-30	816	22	680	114	draft
5691	Uruguay	2020-05-30	2020-05-31	821	22	682	117	draft
5692	Uruguay	2020-05-31	2020-06-01	823	22	685	116	draft
5693	Uzbekistan	2020-05-01	2020-05-02	2086	9	1212	865	draft
5694	Uzbekistan	2020-05-02	2020-05-03	2118	9	1271	838	draft
5695	Uzbekistan	2020-05-03	2020-05-04	2149	10	1319	820	draft
5696	Uzbekistan	2020-05-04	2020-05-05	2189	10	1405	774	draft
5697	Uzbekistan	2020-05-05	2020-05-06	2207	10	1501	696	draft
5698	Uzbekistan	2020-05-06	2020-05-07	2233	10	1577	646	draft
5699	Uzbekistan	2020-05-07	2020-05-08	2298	10	1656	632	draft
5700	Uzbekistan	2020-05-08	2020-05-09	2325	10	1775	540	draft
5701	Uzbekistan	2020-05-09	2020-05-10	2349	10	1846	493	draft
5702	Uzbekistan	2020-05-10	2020-05-11	2418	10	1881	527	draft
5703	Uzbekistan	2020-05-11	2020-05-12	2486	10	1988	488	draft
5704	Uzbekistan	2020-05-12	2020-05-13	2519	10	2010	499	draft
5705	Uzbekistan	2020-05-13	2020-05-14	2612	11	2076	525	draft
5706	Uzbekistan	2020-05-14	2020-05-15	2645	11	2136	498	draft
5707	Uzbekistan	2020-05-15	2020-05-16	2686	11	2158	517	draft
5708	Uzbekistan	2020-05-16	2020-05-17	2738	11	2213	514	draft
5709	Uzbekistan	2020-05-17	2020-05-18	2753	12	2247	494	draft
5710	Uzbekistan	2020-05-18	2020-05-19	2791	13	2314	464	draft
5711	Uzbekistan	2020-05-19	2020-05-20	2855	13	2338	504	draft
5712	Uzbekistan	2020-05-20	2020-05-21	2939	13	2372	554	draft
5713	Uzbekistan	2020-05-21	2020-05-22	2964	13	2407	544	draft
5714	Uzbekistan	2020-05-22	2020-05-23	3028	13	2492	523	draft
5715	Uzbekistan	2020-05-23	2020-05-24	3115	13	2532	570	draft
5716	Uzbekistan	2020-05-24	2020-05-25	3164	13	2565	586	draft
5717	Uzbekistan	2020-05-25	2020-05-26	3189	13	2607	569	draft
5718	Uzbekistan	2020-05-26	2020-05-27	3290	14	2636	640	draft
5719	Uzbekistan	2020-05-27	2020-05-28	3369	14	2668	687	draft
5720	Uzbekistan	2020-05-28	2020-05-29	3444	14	2694	736	draft
5721	Uzbekistan	2020-05-29	2020-05-30	3468	14	2728	726	draft
5722	Uzbekistan	2020-05-30	2020-05-31	3546	14	2783	749	draft
5723	Uzbekistan	2020-05-31	2020-06-01	3623	15	2837	771	draft
5724	Venezuela	2020-05-01	2020-05-02	335	10	148	177	draft
5725	Venezuela	2020-05-02	2020-05-03	345	10	148	187	draft
5726	Venezuela	2020-05-03	2020-05-04	357	10	158	189	draft
5727	Venezuela	2020-05-04	2020-05-05	357	10	158	189	draft
5728	Venezuela	2020-05-05	2020-05-06	361	10	158	193	draft
5729	Venezuela	2020-05-06	2020-05-07	379	10	176	193	draft
5730	Venezuela	2020-05-07	2020-05-08	381	10	185	186	draft
5731	Venezuela	2020-05-08	2020-05-09	388	10	190	188	draft
5732	Venezuela	2020-05-09	2020-05-10	402	10	190	202	draft
5733	Venezuela	2020-05-10	2020-05-11	414	10	193	211	draft
5734	Venezuela	2020-05-11	2020-05-12	422	10	205	207	draft
5735	Venezuela	2020-05-12	2020-05-13	423	10	220	193	draft
5736	Venezuela	2020-05-13	2020-05-14	423	10	220	193	draft
5737	Venezuela	2020-05-14	2020-05-15	455	10	220	225	draft
5738	Venezuela	2020-05-15	2020-05-16	459	10	229	220	draft
5739	Venezuela	2020-05-16	2020-05-17	504	10	241	253	draft
5740	Venezuela	2020-05-17	2020-05-18	541	10	241	290	draft
5741	Venezuela	2020-05-18	2020-05-19	618	10	253	355	draft
5742	Venezuela	2020-05-19	2020-05-20	749	10	253	486	draft
5743	Venezuela	2020-05-20	2020-05-21	824	10	262	552	draft
5744	Venezuela	2020-05-21	2020-05-22	882	10	262	610	draft
5745	Venezuela	2020-05-22	2020-05-23	944	10	262	672	draft
5746	Venezuela	2020-05-23	2020-05-24	1010	10	262	738	draft
5747	Venezuela	2020-05-24	2020-05-25	1121	10	262	849	draft
5748	Venezuela	2020-05-25	2020-05-26	1177	10	302	865	draft
5749	Venezuela	2020-05-26	2020-05-27	1211	11	302	898	draft
5750	Venezuela	2020-05-27	2020-05-28	1245	11	302	932	draft
5751	Venezuela	2020-05-28	2020-05-29	1325	11	302	1012	draft
5752	Venezuela	2020-05-29	2020-05-30	1370	14	302	1054	draft
5754	Venezuela	2020-05-31	2020-06-01	1510	14	302	1194	draft
5755	Vietnam	2020-05-01	2020-05-02	270	0	219	51	draft
5756	Vietnam	2020-05-02	2020-05-03	270	0	219	51	draft
5757	Vietnam	2020-05-03	2020-05-04	271	0	219	52	draft
5758	Vietnam	2020-05-04	2020-05-05	271	0	219	52	draft
5759	Vietnam	2020-05-05	2020-05-06	271	0	232	39	draft
5760	Vietnam	2020-05-06	2020-05-07	271	0	232	39	draft
5761	Vietnam	2020-05-07	2020-05-08	288	0	233	55	draft
5762	Vietnam	2020-05-08	2020-05-09	288	0	241	47	draft
5763	Vietnam	2020-05-09	2020-05-10	288	0	241	47	draft
5764	Vietnam	2020-05-10	2020-05-11	288	0	241	47	draft
5765	Vietnam	2020-05-11	2020-05-12	288	0	249	39	draft
5766	Vietnam	2020-05-12	2020-05-13	288	0	252	36	draft
5767	Vietnam	2020-05-13	2020-05-14	288	0	252	36	draft
5768	Vietnam	2020-05-14	2020-05-15	312	0	260	52	draft
5769	Vietnam	2020-05-15	2020-05-16	314	0	260	54	draft
5770	Vietnam	2020-05-16	2020-05-17	318	0	260	58	draft
5771	Vietnam	2020-05-17	2020-05-18	320	0	260	60	draft
5772	Vietnam	2020-05-18	2020-05-19	324	0	263	61	draft
5773	Vietnam	2020-05-19	2020-05-20	324	0	263	61	draft
5774	Vietnam	2020-05-20	2020-05-21	324	0	263	61	draft
5775	Vietnam	2020-05-21	2020-05-22	324	0	266	58	draft
5776	Vietnam	2020-05-22	2020-05-23	324	0	267	57	draft
5777	Vietnam	2020-05-23	2020-05-24	325	0	267	58	draft
5778	Vietnam	2020-05-24	2020-05-25	325	0	267	58	draft
5779	Vietnam	2020-05-25	2020-05-26	326	0	272	54	draft
5780	Vietnam	2020-05-26	2020-05-27	327	0	272	55	draft
5781	Vietnam	2020-05-27	2020-05-28	327	0	278	49	draft
5782	Vietnam	2020-05-28	2020-05-29	327	0	278	49	draft
5783	Vietnam	2020-05-29	2020-05-30	328	0	279	49	draft
5784	Vietnam	2020-05-30	2020-05-31	328	0	279	49	draft
5785	Vietnam	2020-05-31	2020-06-01	328	0	279	49	draft
5786	West Bank and Gaza	2020-05-01	2020-05-02	353	2	76	275	draft
5787	West Bank and Gaza	2020-05-02	2020-05-03	353	2	76	275	draft
5788	West Bank and Gaza	2020-05-03	2020-05-04	353	2	77	274	draft
5789	West Bank and Gaza	2020-05-04	2020-05-05	362	2	102	258	draft
5790	West Bank and Gaza	2020-05-05	2020-05-06	371	2	127	242	draft
5791	West Bank and Gaza	2020-05-06	2020-05-07	374	2	174	198	draft
5792	West Bank and Gaza	2020-05-07	2020-05-08	375	2	176	197	draft
5793	West Bank and Gaza	2020-05-08	2020-05-09	375	2	228	145	draft
5794	West Bank and Gaza	2020-05-09	2020-05-10	375	2	228	145	draft
5795	West Bank and Gaza	2020-05-10	2020-05-11	375	2	263	110	draft
5796	West Bank and Gaza	2020-05-11	2020-05-12	375	2	301	72	draft
5797	West Bank and Gaza	2020-05-12	2020-05-13	375	2	308	65	draft
5798	West Bank and Gaza	2020-05-13	2020-05-14	375	2	310	63	draft
5799	West Bank and Gaza	2020-05-14	2020-05-15	375	2	310	63	draft
5800	West Bank and Gaza	2020-05-15	2020-05-16	375	2	315	58	draft
5801	West Bank and Gaza	2020-05-16	2020-05-17	376	2	329	45	draft
5802	West Bank and Gaza	2020-05-17	2020-05-18	381	2	335	44	draft
5803	West Bank and Gaza	2020-05-18	2020-05-19	388	2	337	49	draft
5804	West Bank and Gaza	2020-05-19	2020-05-20	391	2	346	43	draft
5805	West Bank and Gaza	2020-05-20	2020-05-21	398	2	346	50	draft
5806	West Bank and Gaza	2020-05-21	2020-05-22	423	2	346	75	draft
5807	West Bank and Gaza	2020-05-22	2020-05-23	423	2	346	75	draft
5808	West Bank and Gaza	2020-05-23	2020-05-24	423	3	348	72	draft
5809	West Bank and Gaza	2020-05-24	2020-05-25	423	3	357	63	draft
5810	West Bank and Gaza	2020-05-25	2020-05-26	423	3	357	63	draft
5811	West Bank and Gaza	2020-05-26	2020-05-27	429	3	365	61	draft
5812	West Bank and Gaza	2020-05-27	2020-05-28	434	3	365	66	draft
5813	West Bank and Gaza	2020-05-28	2020-05-29	446	3	368	75	draft
5814	West Bank and Gaza	2020-05-29	2020-05-30	446	3	368	75	draft
5815	West Bank and Gaza	2020-05-30	2020-05-31	447	3	368	76	draft
5816	West Bank and Gaza	2020-05-31	2020-06-01	448	3	372	73	draft
5817	Yemen	2020-05-01	2020-05-02	7	2	1	4	draft
5818	Yemen	2020-05-02	2020-05-03	10	2	1	7	draft
5819	Yemen	2020-05-03	2020-05-04	10	2	1	7	draft
5820	Yemen	2020-05-04	2020-05-05	12	2	1	9	draft
5821	Yemen	2020-05-05	2020-05-06	21	3	1	17	draft
5822	Yemen	2020-05-06	2020-05-07	25	5	1	19	draft
5823	Yemen	2020-05-07	2020-05-08	25	5	1	19	draft
5824	Yemen	2020-05-08	2020-05-09	34	5	1	26	draft
5825	Yemen	2020-05-09	2020-05-10	34	7	1	26	draft
5826	Yemen	2020-05-10	2020-05-11	51	8	1	42	draft
5827	Yemen	2020-05-11	2020-05-12	56	9	1	46	draft
5828	Yemen	2020-05-12	2020-05-13	65	10	1	54	draft
5829	Yemen	2020-05-13	2020-05-14	70	12	1	57	draft
5830	Yemen	2020-05-14	2020-05-15	85	12	1	72	draft
5831	Yemen	2020-05-15	2020-05-16	106	15	1	90	draft
5832	Yemen	2020-05-16	2020-05-17	122	18	1	103	draft
5833	Yemen	2020-05-17	2020-05-18	128	20	1	107	draft
5834	Yemen	2020-05-18	2020-05-19	130	20	1	109	draft
5835	Yemen	2020-05-19	2020-05-20	167	28	5	134	draft
5836	Yemen	2020-05-20	2020-05-21	180	29	5	149	draft
5837	Yemen	2020-05-21	2020-05-22	193	33	5	159	draft
5838	Yemen	2020-05-22	2020-05-23	205	33	6	165	draft
5839	Yemen	2020-05-23	2020-05-24	212	39	6	162	draft
5840	Yemen	2020-05-24	2020-05-25	222	42	10	170	draft
5841	Yemen	2020-05-25	2020-05-26	233	44	10	179	draft
5842	Yemen	2020-05-26	2020-05-27	249	49	10	190	draft
5843	Yemen	2020-05-27	2020-05-28	255	53	10	193	draft
5844	Yemen	2020-05-28	2020-05-29	278	57	11	210	draft
5845	Yemen	2020-05-29	2020-05-30	283	65	11	207	draft
5847	Yemen	2020-05-31	2020-06-01	323	80	14	229	draft
5848	Zambia	2020-05-01	2020-05-02	109	3	74	32	draft
5849	Zambia	2020-05-02	2020-05-03	119	3	75	41	draft
5850	Zambia	2020-05-03	2020-05-04	124	3	78	43	draft
5851	Zambia	2020-05-04	2020-05-05	137	3	78	56	draft
5852	Zambia	2020-05-05	2020-05-06	138	3	92	43	draft
5853	Zambia	2020-05-06	2020-05-07	146	4	101	41	draft
5854	Zambia	2020-05-07	2020-05-08	153	4	103	46	draft
5855	Zambia	2020-05-08	2020-05-09	167	4	111	52	draft
5856	Zambia	2020-05-09	2020-05-10	252	7	112	133	draft
5857	Zambia	2020-05-10	2020-05-11	267	7	117	143	draft
5858	Zambia	2020-05-11	2020-05-12	267	7	117	143	draft
5859	Zambia	2020-05-12	2020-05-13	441	7	117	317	draft
5860	Zambia	2020-05-13	2020-05-14	446	7	124	315	draft
5861	Zambia	2020-05-14	2020-05-15	654	7	124	523	draft
5862	Zambia	2020-05-15	2020-05-16	654	7	124	523	draft
5863	Zambia	2020-05-16	2020-05-17	679	7	183	489	draft
5864	Zambia	2020-05-17	2020-05-18	753	7	188	558	draft
5865	Zambia	2020-05-18	2020-05-19	761	7	192	562	draft
5866	Zambia	2020-05-19	2020-05-20	772	7	192	573	draft
5867	Zambia	2020-05-20	2020-05-21	832	7	197	628	draft
5868	Zambia	2020-05-21	2020-05-22	866	7	302	557	draft
5869	Zambia	2020-05-22	2020-05-23	920	7	336	577	draft
5870	Zambia	2020-05-23	2020-05-24	920	7	336	577	draft
5871	Zambia	2020-05-24	2020-05-25	920	7	336	577	draft
5872	Zambia	2020-05-25	2020-05-26	920	7	336	577	draft
5873	Zambia	2020-05-26	2020-05-27	920	7	336	577	draft
5874	Zambia	2020-05-27	2020-05-28	1057	7	779	271	draft
5875	Zambia	2020-05-28	2020-05-29	1057	7	779	271	draft
5876	Zambia	2020-05-29	2020-05-30	1057	7	779	271	draft
5877	Zambia	2020-05-30	2020-05-31	1057	7	779	271	draft
5878	Zambia	2020-05-31	2020-06-01	1057	7	779	271	draft
5879	Zimbabwe	2020-05-01	2020-05-02	40	4	5	31	draft
5880	Zimbabwe	2020-05-02	2020-05-03	34	4	5	25	draft
5881	Zimbabwe	2020-05-03	2020-05-04	34	4	5	25	draft
5882	Zimbabwe	2020-05-04	2020-05-05	34	4	5	25	draft
5883	Zimbabwe	2020-05-05	2020-05-06	34	4	5	25	draft
5884	Zimbabwe	2020-05-06	2020-05-07	34	4	5	25	draft
5885	Zimbabwe	2020-05-07	2020-05-08	34	4	5	25	draft
5886	Zimbabwe	2020-05-08	2020-05-09	34	4	9	21	draft
5887	Zimbabwe	2020-05-09	2020-05-10	35	4	9	22	draft
5888	Zimbabwe	2020-05-10	2020-05-11	36	4	9	23	draft
5889	Zimbabwe	2020-05-11	2020-05-12	36	4	9	23	draft
5890	Zimbabwe	2020-05-12	2020-05-13	36	4	9	23	draft
5891	Zimbabwe	2020-05-13	2020-05-14	37	4	12	21	draft
5892	Zimbabwe	2020-05-14	2020-05-15	37	4	13	20	draft
5893	Zimbabwe	2020-05-15	2020-05-16	42	4	13	25	draft
5894	Zimbabwe	2020-05-16	2020-05-17	42	4	13	25	draft
5895	Zimbabwe	2020-05-17	2020-05-18	44	4	17	23	draft
5896	Zimbabwe	2020-05-18	2020-05-19	46	4	18	24	draft
5897	Zimbabwe	2020-05-19	2020-05-20	46	4	18	24	draft
5898	Zimbabwe	2020-05-20	2020-05-21	48	4	18	26	draft
5899	Zimbabwe	2020-05-21	2020-05-22	51	4	18	29	draft
5900	Zimbabwe	2020-05-22	2020-05-23	51	4	18	29	draft
5901	Zimbabwe	2020-05-23	2020-05-24	56	4	18	34	draft
5902	Zimbabwe	2020-05-24	2020-05-25	56	4	25	27	draft
5903	Zimbabwe	2020-05-25	2020-05-26	56	4	25	27	draft
5904	Zimbabwe	2020-05-26	2020-05-27	56	4	25	27	draft
5905	Zimbabwe	2020-05-27	2020-05-28	132	4	25	103	draft
5906	Zimbabwe	2020-05-28	2020-05-29	149	4	28	117	draft
5907	Zimbabwe	2020-05-29	2020-05-30	149	4	28	117	draft
5908	Zimbabwe	2020-05-30	2020-05-31	174	4	29	141	draft
5909	Zimbabwe	2020-05-31	2020-06-01	178	4	29	145	draft
5910	test	2021-07-16	2021-07-16	1	1	1	1	draft
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 75, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 12, true);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 29, true);


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

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 5, true);


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

