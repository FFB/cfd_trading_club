--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Name: direction; Type: DOMAIN; Schema: public; Owner: zany
--

CREATE DOMAIN direction AS text
	CONSTRAINT direction_check CHECK (((upper(VALUE) <> 'UP'::text) OR (upper(VALUE) <> 'DOWN'::text)));


ALTER DOMAIN public.direction OWNER TO zany;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: prediction; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE prediction (
    id integer NOT NULL,
    ticker_id integer NOT NULL,
    user_id integer NOT NULL,
    "time" timestamp with time zone NOT NULL,
    direction direction NOT NULL
);


ALTER TABLE public.prediction OWNER TO zany;

--
-- Name: prediction_id_seq; Type: SEQUENCE; Schema: public; Owner: zany
--

CREATE SEQUENCE prediction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.prediction_id_seq OWNER TO zany;

--
-- Name: prediction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zany
--

ALTER SEQUENCE prediction_id_seq OWNED BY prediction.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    rolename character varying NOT NULL
);


ALTER TABLE public.role OWNER TO zany;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: zany
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO zany;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zany
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: ticker; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE ticker (
    id integer NOT NULL,
    code character varying NOT NULL,
    text character varying,
    image character varying NOT NULL
);


ALTER TABLE public.ticker OWNER TO zany;

--
-- Name: ticker_id_seq; Type: SEQUENCE; Schema: public; Owner: zany
--

CREATE SEQUENCE ticker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ticker_id_seq OWNER TO zany;

--
-- Name: ticker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zany
--

ALTER SEQUENCE ticker_id_seq OWNED BY ticker.id;


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE user_role (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_role OWNER TO zany;

--
-- Name: users; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    upi character varying NOT NULL,
    student_id integer NOT NULL,
    email character varying NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    mobile character varying,
    degree character varying NOT NULL,
    major character varying,
    year character varying NOT NULL,
    experience character varying NOT NULL
);


ALTER TABLE public.users OWNER TO zany;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: zany
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO zany;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zany
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE prediction ALTER COLUMN id SET DEFAULT nextval('prediction_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE ticker ALTER COLUMN id SET DEFAULT nextval('ticker_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: prediction_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY prediction
    ADD CONSTRAINT prediction_pkey PRIMARY KEY (id);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: role_rolename_key; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_rolename_key UNIQUE (rolename);


--
-- Name: ticker_code_key; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY ticker
    ADD CONSTRAINT ticker_code_key UNIQUE (code);


--
-- Name: ticker_image_key; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY ticker
    ADD CONSTRAINT ticker_image_key UNIQUE (image);


--
-- Name: ticker_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY ticker
    ADD CONSTRAINT ticker_pkey PRIMARY KEY (id);


--
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_student_id_key; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_student_id_key UNIQUE (student_id);


--
-- Name: users_upi_key; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_upi_key UNIQUE (upi);


--
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: prediction_ticker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zany
--

ALTER TABLE ONLY prediction
    ADD CONSTRAINT prediction_ticker_id_fkey FOREIGN KEY (ticker_id) REFERENCES ticker(id) ON DELETE CASCADE;


--
-- Name: prediction_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zany
--

ALTER TABLE ONLY prediction
    ADD CONSTRAINT prediction_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zany
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE;


--
-- Name: user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zany
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

