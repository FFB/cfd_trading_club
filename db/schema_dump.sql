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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: confidence; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE confidence (
    id integer NOT NULL,
    name character varying NOT NULL,
    value integer
);


ALTER TABLE public.confidence OWNER TO zany;

--
-- Name: confidence_id_seq; Type: SEQUENCE; Schema: public; Owner: zany
--

CREATE SEQUENCE confidence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.confidence_id_seq OWNER TO zany;

--
-- Name: confidence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zany
--

ALTER SEQUENCE confidence_id_seq OWNED BY confidence.id;


--
-- Name: estimate; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE estimate (
    id integer NOT NULL,
    name character varying NOT NULL,
    icon character varying
);


ALTER TABLE public.estimate OWNER TO zany;

--
-- Name: estimate_id_seq; Type: SEQUENCE; Schema: public; Owner: zany
--

CREATE SEQUENCE estimate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.estimate_id_seq OWNER TO zany;

--
-- Name: estimate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zany
--

ALTER SEQUENCE estimate_id_seq OWNED BY estimate.id;


--
-- Name: prediction; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE prediction (
    id integer NOT NULL,
    p_id integer,
    user_id integer,
    "time" timestamp with time zone NOT NULL,
    est_id integer,
    conf_id integer
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
-- Name: predictor; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE predictor (
    id integer NOT NULL,
    ticker character varying,
    open_time time with time zone NOT NULL,
    close_time time with time zone NOT NULL
);


ALTER TABLE public.predictor OWNER TO zany;

--
-- Name: predictor_id_seq; Type: SEQUENCE; Schema: public; Owner: zany
--

CREATE SEQUENCE predictor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.predictor_id_seq OWNER TO zany;

--
-- Name: predictor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zany
--

ALTER SEQUENCE predictor_id_seq OWNED BY predictor.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: zany; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    rolename character varying
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
    email character varying NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    mobile character varying
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

ALTER TABLE confidence ALTER COLUMN id SET DEFAULT nextval('confidence_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE estimate ALTER COLUMN id SET DEFAULT nextval('estimate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE prediction ALTER COLUMN id SET DEFAULT nextval('prediction_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE predictor ALTER COLUMN id SET DEFAULT nextval('predictor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: zany
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: confidence_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY confidence
    ADD CONSTRAINT confidence_pkey PRIMARY KEY (id);


--
-- Name: estimate_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_pkey PRIMARY KEY (id);


--
-- Name: prediction_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY prediction
    ADD CONSTRAINT prediction_pkey PRIMARY KEY (id);


--
-- Name: predictor_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY predictor
    ADD CONSTRAINT predictor_pkey PRIMARY KEY (id);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: zany; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: prediction_conf_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zany
--

ALTER TABLE ONLY prediction
    ADD CONSTRAINT prediction_conf_id_fkey FOREIGN KEY (conf_id) REFERENCES confidence(id) ON DELETE CASCADE;


--
-- Name: prediction_est_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zany
--

ALTER TABLE ONLY prediction
    ADD CONSTRAINT prediction_est_id_fkey FOREIGN KEY (est_id) REFERENCES estimate(id) ON DELETE CASCADE;


--
-- Name: prediction_p_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zany
--

ALTER TABLE ONLY prediction
    ADD CONSTRAINT prediction_p_id_fkey FOREIGN KEY (p_id) REFERENCES predictor(id) ON DELETE CASCADE;


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

