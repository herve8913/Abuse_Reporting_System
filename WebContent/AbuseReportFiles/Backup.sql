--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.11
-- Dumped by pg_dump version 9.1.11
-- Started on 2014-03-12 12:43:40 EDT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 202 (class 3079 OID 11680)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 202
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 215 (class 1255 OID 24932)
-- Dependencies: 628 5
-- Name: create_patient_log(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION create_patient_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 
  patient_log_number_var character varying;
  
  BEGIN
    IF(NEW.patient_log_number = '-1') THEN 
      patient_log_number_var := 'PATIENT'||'-'||TRIM(to_char(NEW.id,'000000'));   
      UPDATE patient SET patient_log_number=patient_log_number_var WHERE id= NEW.id;
    END IF;  
    RETURN NULL;
  END;
$$;


ALTER FUNCTION public.create_patient_log() OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 25227)
-- Dependencies: 5 628
-- Name: create_public_log_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION create_public_log_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 
  public_log_number_var character varying;
  
  BEGIN
    IF(NEW.public_log_number = '-1') THEN 
      public_log_number_var := 'PUBLIC-LOG'||'-'||TRIM(to_char(NEW.id,'000000'));   
      UPDATE abuse_report SET public_log_number=public_log_number_var WHERE id= NEW.id;
    END IF;  
    RETURN NULL;
  END;
$$;


ALTER FUNCTION public.create_public_log_number() OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 24890)
-- Dependencies: 628 5
-- Name: update_lastmodified_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_lastmodified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.modified = NOW();
    
    RETURN NEW;
  END;
$$;


ALTER FUNCTION public.update_lastmodified_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 193 (class 1259 OID 25346)
-- Dependencies: 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 5
-- Name: abuse_report; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE abuse_report (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    public_log_number character varying(255) DEFAULT (-1) NOT NULL,
    reporter_id integer DEFAULT 11 NOT NULL,
    reporter_name character varying(255) NOT NULL,
    reporter_address text,
    reporter_telephone character varying(255) NOT NULL,
    mandated integer DEFAULT 1 NOT NULL,
    reporter_relationship_to_victim_id integer NOT NULL,
    alleged_victim_patient_id integer,
    alleged_victim_name character varying(255) NOT NULL,
    alleged_victim_address character varying(255),
    alleged_victim_telephone character varying(255),
    alleged_victim_sex "char" NOT NULL,
    alleged_victim_staff_id integer,
    alleged_victim_datebirth date NOT NULL,
    alleged_victim_marital_status_id integer NOT NULL,
    alleged_abuser_patient_id integer,
    alleged_abuser_staff_id integer,
    alleged_abuser_name character varying(255) NOT NULL,
    alleged_abuser_address text,
    alleged_abuser_relationship_id integer NOT NULL,
    alleged_abuser_social_security character varying(255),
    alleged_abuser_datebirth date NOT NULL,
    alleged_abuser_telephone character varying(100),
    comunication_need_id integer,
    comunication_need_comment character varying(255),
    client_guardian_name character varying(255),
    client_guardian_address text,
    client_guardian_relationship_id integer,
    client_guardian_telephone character varying(100),
    currently_served_by_id integer,
    currently_served_by_comment character varying(255),
    collateral_contacts_notification text,
    type_of_service_id integer,
    type_of_service_comment character varying(255),
    is_victim_aware character varying(3) NOT NULL,
    description_alleged_report text,
    description_level_risk text,
    description_resulting_injuries text,
    description_witnesses text,
    description_caregiver_relationship text,
    oral_report_filed character varying(3),
    oral_report_filed_comment text,
    risk_to_investigator character varying(3),
    risk_to_investigator_comment text,
    date_of_last_incident date,
    disposition_letter character varying(255),
    decision_letter character varying(255),
    appeal_letter character varying(255),
    CONSTRAINT abuse_report_alleged_victim_sex_check CHECK (((alleged_victim_sex = 'M'::"char") OR (alleged_victim_sex = 'F'::"char"))),
    CONSTRAINT abuse_report_is_victim_aware_check CHECK ((((is_victim_aware)::text = 'Yes'::text) OR ((is_victim_aware)::text = 'No'::text))),
    CONSTRAINT abuse_report_mandated_check CHECK (((mandated = 1) OR (mandated = 0))),
    CONSTRAINT abuse_report_oral_report_filed_check CHECK ((((oral_report_filed)::text = 'Yes'::text) OR ((oral_report_filed)::text = 'No'::text))),
    CONSTRAINT abuse_report_risk_to_investigator_check CHECK ((((risk_to_investigator)::text = 'Yes'::text) OR ((risk_to_investigator)::text = 'No'::text)))
);


ALTER TABLE public.abuse_report OWNER TO abusereportuser;

--
-- TOC entry 195 (class 1259 OID 25431)
-- Dependencies: 2007 2008 5
-- Name: abuse_report_disability; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE abuse_report_disability (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    disability_id integer NOT NULL,
    disability_name character varying(255) NOT NULL,
    disability_comment character varying(255),
    patient_id integer NOT NULL,
    abuse_report_id integer NOT NULL
);


ALTER TABLE public.abuse_report_disability OWNER TO abusereportuser;

--
-- TOC entry 194 (class 1259 OID 25429)
-- Dependencies: 195 5
-- Name: abuse_report_disability_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE abuse_report_disability_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abuse_report_disability_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2268 (class 0 OID 0)
-- Dependencies: 194
-- Name: abuse_report_disability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE abuse_report_disability_id_seq OWNED BY abuse_report_disability.id;


--
-- TOC entry 197 (class 1259 OID 25460)
-- Dependencies: 2010 2011 5
-- Name: abuse_report_frequency_of_abuse; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE abuse_report_frequency_of_abuse (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    frequency_of_abuse_id integer NOT NULL,
    frequency_of_abuse_name character varying(255) NOT NULL,
    frequency_of_abuse_comment character varying(255),
    patient_id integer NOT NULL,
    abuse_report_id integer NOT NULL
);


ALTER TABLE public.abuse_report_frequency_of_abuse OWNER TO abusereportuser;

--
-- TOC entry 196 (class 1259 OID 25458)
-- Dependencies: 197 5
-- Name: abuse_report_frequency_of_abuse_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE abuse_report_frequency_of_abuse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abuse_report_frequency_of_abuse_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2269 (class 0 OID 0)
-- Dependencies: 196
-- Name: abuse_report_frequency_of_abuse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE abuse_report_frequency_of_abuse_id_seq OWNED BY abuse_report_frequency_of_abuse.id;


--
-- TOC entry 192 (class 1259 OID 25344)
-- Dependencies: 5 193
-- Name: abuse_report_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE abuse_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abuse_report_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2270 (class 0 OID 0)
-- Dependencies: 192
-- Name: abuse_report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE abuse_report_id_seq OWNED BY abuse_report.id;


--
-- TOC entry 199 (class 1259 OID 25489)
-- Dependencies: 2013 2014 5
-- Name: abuse_report_type_of_abuse; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE abuse_report_type_of_abuse (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    type_of_abuse_id integer NOT NULL,
    type_of_abuse_name character varying(255) NOT NULL,
    type_of_abuse_comment character varying(255),
    patient_id integer NOT NULL,
    abuse_report_id integer NOT NULL
);


ALTER TABLE public.abuse_report_type_of_abuse OWNER TO abusereportuser;

--
-- TOC entry 198 (class 1259 OID 25487)
-- Dependencies: 5 199
-- Name: abuse_report_type_of_abuse_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE abuse_report_type_of_abuse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abuse_report_type_of_abuse_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2271 (class 0 OID 0)
-- Dependencies: 198
-- Name: abuse_report_type_of_abuse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE abuse_report_type_of_abuse_id_seq OWNED BY abuse_report_type_of_abuse.id;


--
-- TOC entry 175 (class 1259 OID 25076)
-- Dependencies: 1959 1960 1961 5
-- Name: master_data; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE master_data (
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    master_data_name character varying NOT NULL,
    description text
);


ALTER TABLE public.master_data OWNER TO abusereportuser;

--
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN master_data.status; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN master_data.status IS '1:"Active"
0:"Inactive"';


--
-- TOC entry 179 (class 1259 OID 25153)
-- Dependencies: 175 5
-- Name: comunication_need; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE comunication_need (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.comunication_need OWNER TO abusereportuser;

--
-- TOC entry 178 (class 1259 OID 25151)
-- Dependencies: 179 5
-- Name: comunication_need_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE comunication_need_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comunication_need_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 178
-- Name: comunication_need_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE comunication_need_id_seq OWNED BY comunication_need.id;


--
-- TOC entry 177 (class 1259 OID 25139)
-- Dependencies: 175 5
-- Name: currently_served_by; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE currently_served_by (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.currently_served_by OWNER TO abusereportuser;

--
-- TOC entry 176 (class 1259 OID 25137)
-- Dependencies: 177 5
-- Name: currently_served_by_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE currently_served_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currently_served_by_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 176
-- Name: currently_served_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE currently_served_by_id_seq OWNED BY currently_served_by.id;


--
-- TOC entry 166 (class 1259 OID 24936)
-- Dependencies: 1941 1942 1943 1944 5
-- Name: disability; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE disability (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    disability_name character varying NOT NULL,
    description text,
    disability_type_id integer NOT NULL,
    CONSTRAINT disability_status_check CHECK (((status = 0) OR (status = 1)))
);


ALTER TABLE public.disability OWNER TO abusereportuser;

--
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN disability.status; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN disability.status IS '1:"Active"
0:"Inactive"';


--
-- TOC entry 165 (class 1259 OID 24934)
-- Dependencies: 5 166
-- Name: disability_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE disability_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disability_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 165
-- Name: disability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE disability_id_seq OWNED BY disability.id;


--
-- TOC entry 170 (class 1259 OID 24972)
-- Dependencies: 1951 1952 5
-- Name: disability_patient; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE disability_patient (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    disability_id integer NOT NULL,
    patient_id integer NOT NULL
);


ALTER TABLE public.disability_patient OWNER TO abusereportuser;

--
-- TOC entry 169 (class 1259 OID 24970)
-- Dependencies: 5 170
-- Name: disability_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE disability_patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disability_patient_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 169
-- Name: disability_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE disability_patient_id_seq OWNED BY disability_patient.id;


--
-- TOC entry 174 (class 1259 OID 25018)
-- Dependencies: 1957 1958 5
-- Name: disabiltity_type; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE disabiltity_type (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    name_disabiltity_type character varying NOT NULL
);


ALTER TABLE public.disabiltity_type OWNER TO abusereportuser;

--
-- TOC entry 173 (class 1259 OID 25016)
-- Dependencies: 174 5
-- Name: disabiltity_type_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE disabiltity_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disabiltity_type_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 173
-- Name: disabiltity_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE disabiltity_type_id_seq OWNED BY disabiltity_type.id;


--
-- TOC entry 168 (class 1259 OID 24949)
-- Dependencies: 1946 1947 1948 1949 5
-- Name: drug; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE drug (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    drug_name character varying NOT NULL,
    description text,
    CONSTRAINT drug_status_check CHECK (((status = 0) OR (status = 1)))
);


ALTER TABLE public.drug OWNER TO abusereportuser;

--
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN drug.status; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN drug.status IS '1: "Active"
0: "Inactive"';


--
-- TOC entry 167 (class 1259 OID 24947)
-- Dependencies: 168 5
-- Name: drug_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE drug_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drug_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 167
-- Name: drug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE drug_id_seq OWNED BY drug.id;


--
-- TOC entry 172 (class 1259 OID 24983)
-- Dependencies: 1954 1955 5
-- Name: drug_patient; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE drug_patient (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    drug_id integer NOT NULL,
    patient_id integer NOT NULL,
    periodicity character varying(255) NOT NULL
);


ALTER TABLE public.drug_patient OWNER TO abusereportuser;

--
-- TOC entry 171 (class 1259 OID 24981)
-- Dependencies: 5 172
-- Name: drug_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE drug_patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drug_patient_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 171
-- Name: drug_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE drug_patient_id_seq OWNED BY drug_patient.id;


--
-- TOC entry 187 (class 1259 OID 25214)
-- Dependencies: 175 5
-- Name: ethnicity; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE ethnicity (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.ethnicity OWNER TO abusereportuser;

--
-- TOC entry 186 (class 1259 OID 25212)
-- Dependencies: 5 187
-- Name: ethnicity_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE ethnicity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ethnicity_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 186
-- Name: ethnicity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE ethnicity_id_seq OWNED BY ethnicity.id;


--
-- TOC entry 183 (class 1259 OID 25186)
-- Dependencies: 5 175
-- Name: frequency_of_abuse; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE frequency_of_abuse (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.frequency_of_abuse OWNER TO abusereportuser;

--
-- TOC entry 182 (class 1259 OID 25184)
-- Dependencies: 5 183
-- Name: frequency_of_abuse_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE frequency_of_abuse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.frequency_of_abuse_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 182
-- Name: frequency_of_abuse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE frequency_of_abuse_id_seq OWNED BY frequency_of_abuse.id;


--
-- TOC entry 201 (class 1259 OID 25518)
-- Dependencies: 175 5
-- Name: group_home; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE group_home (
    id integer NOT NULL,
    address character varying(255) NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.group_home OWNER TO abusereportuser;

--
-- TOC entry 200 (class 1259 OID 25516)
-- Dependencies: 201 5
-- Name: group_home_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE group_home_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_home_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 200
-- Name: group_home_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE group_home_id_seq OWNED BY group_home.id;


--
-- TOC entry 189 (class 1259 OID 25275)
-- Dependencies: 5 175
-- Name: marital_status; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE marital_status (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.marital_status OWNER TO abusereportuser;

--
-- TOC entry 188 (class 1259 OID 25273)
-- Dependencies: 5 189
-- Name: marital_status_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE marital_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.marital_status_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 188
-- Name: marital_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE marital_status_id_seq OWNED BY marital_status.id;


--
-- TOC entry 164 (class 1259 OID 24912)
-- Dependencies: 1934 1935 1936 1937 1938 1939 5
-- Name: patient; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE patient (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    patient_name character varying(255) NOT NULL,
    patient_midname character varying(255) NOT NULL,
    patient_last_name character varying(255) NOT NULL,
    patient_log_number character varying(255) DEFAULT (-1) NOT NULL,
    iq integer NOT NULL,
    birthdate date NOT NULL,
    sex "char" NOT NULL,
    address text,
    telephone character(100),
    marital_status_id integer NOT NULL,
    group_home_id integer NOT NULL,
    CONSTRAINT patient_iq_check CHECK ((iq < 72)),
    CONSTRAINT patient_sex_check CHECK (((sex = 'M'::"char") OR (sex = 'F'::"char")))
);


ALTER TABLE public.patient OWNER TO abusereportuser;

--
-- TOC entry 163 (class 1259 OID 24910)
-- Dependencies: 5 164
-- Name: patient_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patient_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 163
-- Name: patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE patient_id_seq OWNED BY patient.id;


--
-- TOC entry 191 (class 1259 OID 25332)
-- Dependencies: 5 175
-- Name: relationship; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE relationship (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.relationship OWNER TO abusereportuser;

--
-- TOC entry 190 (class 1259 OID 25330)
-- Dependencies: 5 191
-- Name: relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE relationship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relationship_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 190
-- Name: relationship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE relationship_id_seq OWNED BY relationship.id;


--
-- TOC entry 162 (class 1259 OID 24893)
-- Dependencies: 1928 1929 1930 1931 1932 5
-- Name: system_user; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE system_user (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    user_type integer NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    user_name character varying(255) NOT NULL,
    user_last_name character varying(255) NOT NULL,
    login character varying(255),
    login_password character varying(255) NOT NULL,
    social_security character varying(255),
    address text,
    telephone character varying(100) NOT NULL,
    birthdate date NOT NULL,
    marital_status_id integer NOT NULL,
    CONSTRAINT system_user_status_check CHECK (((status = 0) OR (status = 1))),
    CONSTRAINT system_user_user_type_check CHECK (((user_type > 0) AND (user_type < 5)))
);


ALTER TABLE public.system_user OWNER TO abusereportuser;

--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN system_user.user_type; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN system_user.user_type IS '1: "Administrator"
2: "Supervisor"
3: "Staff"
4: "Human Rights Commitee"';


--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN system_user.status; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN system_user.status IS '0: "Inactive"
1:"Active"';


--
-- TOC entry 161 (class 1259 OID 24891)
-- Dependencies: 5 162
-- Name: system_user_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE system_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_user_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 161
-- Name: system_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE system_user_id_seq OWNED BY system_user.id;


--
-- TOC entry 185 (class 1259 OID 25200)
-- Dependencies: 175 5
-- Name: type_of_abuse; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE type_of_abuse (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.type_of_abuse OWNER TO abusereportuser;

--
-- TOC entry 184 (class 1259 OID 25198)
-- Dependencies: 5 185
-- Name: type_of_abuse_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE type_of_abuse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_of_abuse_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 184
-- Name: type_of_abuse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE type_of_abuse_id_seq OWNED BY type_of_abuse.id;


--
-- TOC entry 181 (class 1259 OID 25171)
-- Dependencies: 5 175
-- Name: type_of_service; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE type_of_service (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.type_of_service OWNER TO abusereportuser;

--
-- TOC entry 180 (class 1259 OID 25169)
-- Dependencies: 5 181
-- Name: type_of_service_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE type_of_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_of_service_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 180
-- Name: type_of_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE type_of_service_id_seq OWNED BY type_of_service.id;


--
-- TOC entry 1994 (class 2604 OID 25349)
-- Dependencies: 193 192 193
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report ALTER COLUMN id SET DEFAULT nextval('abuse_report_id_seq'::regclass);


--
-- TOC entry 2006 (class 2604 OID 25434)
-- Dependencies: 194 195 195
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_disability ALTER COLUMN id SET DEFAULT nextval('abuse_report_disability_id_seq'::regclass);


--
-- TOC entry 2009 (class 2604 OID 25463)
-- Dependencies: 197 196 197
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse ALTER COLUMN id SET DEFAULT nextval('abuse_report_frequency_of_abuse_id_seq'::regclass);


--
-- TOC entry 2012 (class 2604 OID 25492)
-- Dependencies: 199 198 199
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_type_of_abuse ALTER COLUMN id SET DEFAULT nextval('abuse_report_type_of_abuse_id_seq'::regclass);


--
-- TOC entry 1966 (class 2604 OID 25156)
-- Dependencies: 179 179
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY comunication_need ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 1967 (class 2604 OID 25157)
-- Dependencies: 179 179
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY comunication_need ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 1968 (class 2604 OID 25158)
-- Dependencies: 179 179
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY comunication_need ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 1969 (class 2604 OID 25159)
-- Dependencies: 179 178 179
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY comunication_need ALTER COLUMN id SET DEFAULT nextval('comunication_need_id_seq'::regclass);


--
-- TOC entry 1962 (class 2604 OID 25142)
-- Dependencies: 177 177
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY currently_served_by ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 1963 (class 2604 OID 25143)
-- Dependencies: 177 177
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY currently_served_by ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 1964 (class 2604 OID 25144)
-- Dependencies: 177 177
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY currently_served_by ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 1965 (class 2604 OID 25145)
-- Dependencies: 176 177 177
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY currently_served_by ALTER COLUMN id SET DEFAULT nextval('currently_served_by_id_seq'::regclass);


--
-- TOC entry 1940 (class 2604 OID 24939)
-- Dependencies: 166 165 166
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability ALTER COLUMN id SET DEFAULT nextval('disability_id_seq'::regclass);


--
-- TOC entry 1950 (class 2604 OID 24975)
-- Dependencies: 169 170 170
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability_patient ALTER COLUMN id SET DEFAULT nextval('disability_patient_id_seq'::regclass);


--
-- TOC entry 1956 (class 2604 OID 25021)
-- Dependencies: 174 173 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disabiltity_type ALTER COLUMN id SET DEFAULT nextval('disabiltity_type_id_seq'::regclass);


--
-- TOC entry 1945 (class 2604 OID 24952)
-- Dependencies: 167 168 168
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY drug ALTER COLUMN id SET DEFAULT nextval('drug_id_seq'::regclass);


--
-- TOC entry 1953 (class 2604 OID 24986)
-- Dependencies: 172 171 172
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY drug_patient ALTER COLUMN id SET DEFAULT nextval('drug_patient_id_seq'::regclass);


--
-- TOC entry 1982 (class 2604 OID 25217)
-- Dependencies: 187 187
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY ethnicity ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 1983 (class 2604 OID 25218)
-- Dependencies: 187 187
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY ethnicity ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 1984 (class 2604 OID 25219)
-- Dependencies: 187 187
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY ethnicity ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 1985 (class 2604 OID 25220)
-- Dependencies: 186 187 187
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY ethnicity ALTER COLUMN id SET DEFAULT nextval('ethnicity_id_seq'::regclass);


--
-- TOC entry 1974 (class 2604 OID 25189)
-- Dependencies: 183 183
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY frequency_of_abuse ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 1975 (class 2604 OID 25190)
-- Dependencies: 183 183
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY frequency_of_abuse ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 1976 (class 2604 OID 25191)
-- Dependencies: 183 183
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY frequency_of_abuse ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 1977 (class 2604 OID 25192)
-- Dependencies: 182 183 183
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY frequency_of_abuse ALTER COLUMN id SET DEFAULT nextval('frequency_of_abuse_id_seq'::regclass);


--
-- TOC entry 2015 (class 2604 OID 25521)
-- Dependencies: 201 201
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2016 (class 2604 OID 25522)
-- Dependencies: 201 201
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2017 (class 2604 OID 25523)
-- Dependencies: 201 201
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2018 (class 2604 OID 25524)
-- Dependencies: 201 200 201
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home ALTER COLUMN id SET DEFAULT nextval('group_home_id_seq'::regclass);


--
-- TOC entry 1986 (class 2604 OID 25278)
-- Dependencies: 189 189
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY marital_status ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 1987 (class 2604 OID 25279)
-- Dependencies: 189 189
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY marital_status ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 1988 (class 2604 OID 25280)
-- Dependencies: 189 189
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY marital_status ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 1989 (class 2604 OID 25281)
-- Dependencies: 188 189 189
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY marital_status ALTER COLUMN id SET DEFAULT nextval('marital_status_id_seq'::regclass);


--
-- TOC entry 1933 (class 2604 OID 24915)
-- Dependencies: 163 164 164
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient ALTER COLUMN id SET DEFAULT nextval('patient_id_seq'::regclass);


--
-- TOC entry 1990 (class 2604 OID 25335)
-- Dependencies: 191 191
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY relationship ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 1991 (class 2604 OID 25336)
-- Dependencies: 191 191
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY relationship ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 1992 (class 2604 OID 25337)
-- Dependencies: 191 191
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY relationship ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 1993 (class 2604 OID 25338)
-- Dependencies: 190 191 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY relationship ALTER COLUMN id SET DEFAULT nextval('relationship_id_seq'::regclass);


--
-- TOC entry 1927 (class 2604 OID 24896)
-- Dependencies: 161 162 162
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY system_user ALTER COLUMN id SET DEFAULT nextval('system_user_id_seq'::regclass);


--
-- TOC entry 1978 (class 2604 OID 25203)
-- Dependencies: 185 185
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_abuse ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 1979 (class 2604 OID 25204)
-- Dependencies: 185 185
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_abuse ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 1980 (class 2604 OID 25205)
-- Dependencies: 185 185
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_abuse ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 1981 (class 2604 OID 25206)
-- Dependencies: 184 185 185
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_abuse ALTER COLUMN id SET DEFAULT nextval('type_of_abuse_id_seq'::regclass);


--
-- TOC entry 1970 (class 2604 OID 25174)
-- Dependencies: 181 181
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_service ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 1971 (class 2604 OID 25175)
-- Dependencies: 181 181
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_service ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 1972 (class 2604 OID 25176)
-- Dependencies: 181 181
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_service ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 1973 (class 2604 OID 25177)
-- Dependencies: 180 181 181
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_service ALTER COLUMN id SET DEFAULT nextval('type_of_service_id_seq'::regclass);


--
-- TOC entry 2251 (class 0 OID 25346)
-- Dependencies: 193 2260
-- Data for Name: abuse_report; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY abuse_report (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim_id, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship_id, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need_id, comunication_need_comment, client_guardian_name, client_guardian_address, client_guardian_relationship_id, client_guardian_telephone, currently_served_by_id, currently_served_by_comment, collateral_contacts_notification, type_of_service_id, type_of_service_comment, is_victim_aware, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, date_of_last_incident, disposition_letter, decision_letter, appeal_letter) FROM stdin;
\.


--
-- TOC entry 2253 (class 0 OID 25431)
-- Dependencies: 195 2260
-- Data for Name: abuse_report_disability; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abuse_report_id) FROM stdin;
\.


--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 194
-- Name: abuse_report_disability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('abuse_report_disability_id_seq', 1, false);


--
-- TOC entry 2255 (class 0 OID 25460)
-- Dependencies: 197 2260
-- Data for Name: abuse_report_frequency_of_abuse; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY abuse_report_frequency_of_abuse (id, created, modified, frequency_of_abuse_id, frequency_of_abuse_name, frequency_of_abuse_comment, patient_id, abuse_report_id) FROM stdin;
\.


--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 196
-- Name: abuse_report_frequency_of_abuse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('abuse_report_frequency_of_abuse_id_seq', 1, false);


--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 192
-- Name: abuse_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('abuse_report_id_seq', 1, false);


--
-- TOC entry 2257 (class 0 OID 25489)
-- Dependencies: 199 2260
-- Data for Name: abuse_report_type_of_abuse; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY abuse_report_type_of_abuse (id, created, modified, type_of_abuse_id, type_of_abuse_name, type_of_abuse_comment, patient_id, abuse_report_id) FROM stdin;
\.


--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 198
-- Name: abuse_report_type_of_abuse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('abuse_report_type_of_abuse_id_seq', 1, false);


--
-- TOC entry 2237 (class 0 OID 25153)
-- Dependencies: 179 2260
-- Data for Name: comunication_need; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY comunication_need (created, modified, status, master_data_name, description, id) FROM stdin;
2014-03-11	2014-03-11 12:08:25.427833	1	TTY\n	TTY\n	1
2014-03-11	2014-03-11 12:08:42.945229	1	Sign Interpreter\n	Sign Interpreter\n	2
2014-03-11	2014-03-11 12:08:54.916424	1	Other\n	Other\n	3
\.


--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 178
-- Name: comunication_need_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('comunication_need_id_seq', 3, true);


--
-- TOC entry 2235 (class 0 OID 25139)
-- Dependencies: 177 2260
-- Data for Name: currently_served_by; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY currently_served_by (created, modified, status, master_data_name, description, id) FROM stdin;
2014-03-11	2014-03-11 12:09:33.091758	1	Dept. of Mental Health \n	Dept. of Mental Health \n	1
2014-03-11	2014-03-11 12:09:48.780928	1	Dept. of Developmental Svcs. \n	Dept. of Developmental Svcs. \n	2
2014-03-11	2014-03-11 12:09:59.13548	1	Mass. Rehab. Comm. \n	Mass. Rehab. Comm. \n	3
2014-03-11	2014-03-11 12:10:11.221233	1	Dept. of Correction \n	Dept. of Correction \n	4
2014-03-11	2014-03-11 12:10:23.538554	1	Dept. of Public Health \n	Dept. of Public Health \n	5
2014-03-11	2014-03-11 12:10:35.268302	1	Mass Comm./Blind\n	Mass Comm./Blind\n	6
2014-03-11	2014-03-11 12:10:46.764698	1	Mass. Comm./Deaf/HH\n	Mass. Comm./Deaf/HH\n	7
2014-03-11	2014-03-11 12:10:57.531832	1	Unknown\n	Unknown\n	8
2014-03-11	2014-03-11 12:11:46.436107	1	Other\n	Other\n	9
2014-03-11	2014-03-11 12:16:27.564098	1	None	None	10
\.


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 176
-- Name: currently_served_by_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('currently_served_by_id_seq', 14, true);


--
-- TOC entry 2224 (class 0 OID 24936)
-- Dependencies: 166 2260
-- Data for Name: disability; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY disability (id, created, modified, status, disability_name, description, disability_type_id) FROM stdin;
1	2014-03-10	2014-03-10 19:21:35.570379	1	Anosmia 	Anosmia 	4
2	2014-03-10	2014-03-10 19:22:02.505992	1	Dysosmia	Dysosmia	4
3	2014-03-10	2014-03-10 19:22:07.763961	1	Hyperosmia	Hyperosmia	4
4	2014-03-10	2014-03-10 19:22:16.828112	1	Hyposmia	Hyposmia	4
5	2014-03-10	2014-03-10 19:22:29.476001	1	Olfactory Reference Syndrome	Olfactory Reference Syndrome	4
6	2014-03-10	2014-03-10 19:22:40.684233	1	Parosmia	Parosmia	4
7	2014-03-10	2014-03-10 19:22:51.011936	1	Phantosmia	Phantosmia	4
8	2014-03-10	2014-03-10 19:23:17.84422	1	Vertigo	Vertigo	6
9	2014-03-10	2014-03-10 19:23:25.562481	1	Disequilibrium	Disequilibrium	6
10	2014-03-10	2014-03-10 19:23:33.124232	1	Pre-syncope 	Pre-syncope 	6
11	2014-03-10	2014-03-10 19:23:47.10798	1	Benign Paroxysmal Positional Vertigo	Benign Paroxysmal Positional Vertigo	6
12	2014-03-10	2014-03-10 19:23:59.96252	1	Labyrinthitis	Labyrinthitis	6
13	2014-03-10	2014-03-10 19:24:09.322436	1	Ménière's disease 	Ménière's disease 	6
14	2014-03-10	2014-03-10 19:24:18.690521	1	Perilymph fistula	Perilymph fistula	6
15	2014-03-10	2014-03-10 19:24:26.836074	1	Superior canal dehiscence syndrome 	Superior canal dehiscence syndrome 	6
16	2014-03-10	2014-03-10 19:24:34.162468	1	Bilateral vestibulopathy	Bilateral vestibulopathy	6
17	2014-03-10	2014-03-10 19:24:46.732297	1	meningitis	meningitis	6
18	2014-03-10	2014-03-10 19:24:57.412121	1	encephalitis	encephalitis	6
19	2014-03-10	2014-03-10 19:25:10.420234	1	Cogan syndrome	Cogan syndrome	6
20	2014-03-10	2014-03-10 19:25:39.746409	1	oral language development	oral language development	7
21	2014-03-10	2014-03-10 19:25:59.314516	1	Deficits in memory skills	Deficits in memory skills	7
22	2014-03-10	2014-03-10 19:26:09.0046	1	Difficulty learning social rules	Difficulty learning social rules	7
23	2014-03-10	2014-03-10 19:26:18.916063	1	Difficulty with problem solving skills	Difficulty with problem solving skills	7
24	2014-03-10	2014-03-10 19:26:29.636051	1	Delays in the development of adaptive behaviors such as self-help or self-care skills	Delays in the development of adaptive behaviors such as self-help or self-care skills	7
25	2014-03-10	2014-03-10 19:26:38.235985	1	Lack of social inhibitors	Lack of social inhibitors	7
26	2014-03-11	2014-03-11 09:38:21.916729	1	Mental Retardation \n	Mental Retardation \n	7
27	2014-03-11	2014-03-11 09:39:09.212781	1	Mental Illness\n	Mental Illness\n	7
28	2014-03-11	2014-03-11 09:39:58.348944	1	Mobility \n	Mobility \n	7
29	2014-03-11	2014-03-11 09:40:12.236946	1	Head Injury\n	Head Injury\n	7
30	2014-03-11	2014-03-11 09:40:24.756689	1	Visual \n	Visual \n	7
31	2014-03-11	2014-03-11 09:40:37.996863	1	Deaf / Hard of Hearing\n	Deaf / Hard of Hearing\n	7
32	2014-03-11	2014-03-11 09:40:51.860834	1	Cerebral Palsy \n	Cerebral Palsy \n	7
33	2014-03-11	2014-03-11 09:41:05.165352	1	Multiple Sclerosis\n	Multiple Sclerosis\n	7
34	2014-03-11	2014-03-11 09:41:18.388812	1	Seizures \n	Seizures \n	7
\.


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 165
-- Name: disability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('disability_id_seq', 34, true);


--
-- TOC entry 2228 (class 0 OID 24972)
-- Dependencies: 170 2260
-- Data for Name: disability_patient; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY disability_patient (id, created, modified, disability_id, patient_id) FROM stdin;
\.


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 169
-- Name: disability_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('disability_patient_id_seq', 1, false);


--
-- TOC entry 2232 (class 0 OID 25018)
-- Dependencies: 174 2260
-- Data for Name: disabiltity_type; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY disabiltity_type (id, created, modified, name_disabiltity_type) FROM stdin;
1	2014-03-10	2014-03-10 19:18:50.490033	Physical disability
2	2014-03-10	2014-03-10 19:18:59.739256	Sensory disability
3	2014-03-10	2014-03-10 19:19:07.659339	Vision impairment
4	2014-03-10	2014-03-10 19:19:15.139389	Olfactory and gustatory impairment
5	2014-03-10	2014-03-10 19:19:22.4021	Somatosensory impairment
6	2014-03-10	2014-03-10 19:19:29.266074	Balance disorder
7	2014-03-10	2014-03-10 19:19:35.41804	Intellectual disability
8	2014-03-10	2014-03-10 19:19:41.778359	Mental health and emotional disabilities
9	2014-03-10	2014-03-10 19:19:48.65135	Developmental disability
10	2014-03-10	2014-03-10 19:19:55.795395	Nonvisible disabilities
\.


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 173
-- Name: disabiltity_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('disabiltity_type_id_seq', 10, true);


--
-- TOC entry 2226 (class 0 OID 24949)
-- Dependencies: 168 2260
-- Data for Name: drug; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY drug (id, created, modified, status, drug_name, description) FROM stdin;
1	2014-03-10	2014-03-10 18:52:48.820899	1	Abacavir Sulfate (Ziagen)- FDA	WARNING\nRISK OF HYPERSENSITIVITY REACTIONS, LACTIC ACIDOSIS, AND SEVERE HEPATOMEGALY\nHypersensitivity Reactions: Serious and sometimes fatal hypersensitivity reactions have been associated with ZIAGEN® (abacavir sulfate).\nHypersensitivity to abacavir is a multi-organ clinical syndrome usually characterized by a sign or symptom in 2 or more of the following groups: (1) fever, (2) rash, (3) gastrointestinal (including nausea, vomiting, diarrhea, or abdominal pain), (4) constitutional (including generalized malaise, fatigue, or achiness), and (5) respiratory (including dyspnea, cough, or pharyngitis). Discontinue ZIAGEN as soon as a hypersensitivity reaction is suspected.\nPatients who carry the HLA-B*5701 allele are at high risk for experiencing a hypersensitivity reaction to abacavir. Prior to initiating therapy with abacavir, screening for the HLA-B*5701 allele is recommended; this approach has been found to decrease the risk of hypersensitivity reaction. Screening is also recommended prior to reinitiation of abacavir in patients of unknown HLA-B*5701 status who have previously tolerated abacavir. HLA-B*5701-negative patients may develop a suspected hypersensitivity reaction to abacavir; however, this occurs significantly less frequently than in HLA-B*5701-positive patients.\nRegardless of HLA-B*5701 status, permanently discontinue ZIAGEN if hypersensitivity cannot be ruled out, even when other diagnoses are possible.\nFollowing a hypersensitivity reaction to abacavir, NEVER restart ZIAGEN or any other abacavir-containing product because more severe symptoms can occur within hours and may include life-threatening hypotension and death.\nReintroduction of ZIAGEN or any other abacavir-containing product, even in patients who have no identified history or unrecognized symptoms of hypersensitivity to abacavir therapy, can result in serious or fatal hypersensitivity reactions. Such reactions can occur within hours [see WARNINGS AND PRECAUTIONS].\nLactic Acidosis and Severe Hepatomegaly: Lactic acidosis and severe hepatomegaly with steatosis, including fatal cases, have been reported with the use of nucleoside analogues alone or in combination, including ZIAGEN and other antiretrovirals [see WARNINGS AND PRECAUTIONS].
2	2014-03-10	2014-03-10 18:54:46.955654	1	Accolate (Zafirlukast)- FDA	Zafirlukast is a synthetic, selective peptide leukotriene receptor antagonist (LTRA), with the chemical name 4(5-cyclopentyloxy-carbonylamino-1-methyl-indol-3ylmethyl)-3-methoxy-N-o-tolylsulfonylbenzamide. The molecular weight of zafirlukast is 575.7 and the structural formula i The empirical formula is: C31H33N3O6S\n\nZafirlukast, a fine white to pale yellow amorphous powder, is practically insoluble in water. It is slightly soluble in methanol and freely soluble in tetrahydrofuran, dimethylsulfoxide, and acetone.\n\nACCOLATE is supplied as 10 and 20 mg tablets for oral administration.\n\nInactive Ingredients: Film-coated tablets containing croscarmellose sodium, lactose, magnesium stearate, microcrystalline cellulose, povidone, hypromellose, and titanium dioxide.s:
3	2014-03-10	2014-03-10 18:56:45.24375	1	Accutane	Accutane
4	2014-03-10	2014-03-10 18:58:28.996896	1	Aceon	Aceon
5	2014-03-10	2014-03-10 18:58:30.459468	1	Soriatane	Soriatane
6	2014-03-10	2014-03-10 18:58:31.876883	1	Actonel	Actonel
7	2014-03-10	2014-03-10 18:58:33.843995	1	Azor	Azor
8	2014-03-10	2014-03-10 18:59:34.612807	1	Azopt	Azopt
9	2014-03-10	2014-03-10 18:59:36.331863	1	Zithromax	Zithromax
10	2014-03-10	2014-03-10 18:59:39.204534	1	Azilect	Azilect
\.


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 167
-- Name: drug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('drug_id_seq', 11, true);


--
-- TOC entry 2230 (class 0 OID 24983)
-- Dependencies: 172 2260
-- Data for Name: drug_patient; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY drug_patient (id, created, modified, drug_id, patient_id, periodicity) FROM stdin;
\.


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 171
-- Name: drug_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('drug_patient_id_seq', 1, false);


--
-- TOC entry 2245 (class 0 OID 25214)
-- Dependencies: 187 2260
-- Data for Name: ethnicity; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY ethnicity (created, modified, status, master_data_name, description, id) FROM stdin;
2014-03-11	2014-03-11 12:29:01.812496	1	Caucasian \n	Caucasian \n	1
2014-03-11	2014-03-11 12:29:17.307362	1	Hispanic\n	Hispanic\n	2
2014-03-11	2014-03-11 12:29:25.187348	1	Asian\n	Asian\n	3
2014-03-11	2014-03-11 12:29:42.451736	1	African American \n	African American \n	4
2014-03-11	2014-03-11 12:29:53.339345	1	Native American\n	Native American\n	5
2014-03-11	2014-03-11 12:30:02.29145	1	Other\n	Other\n	6
\.


--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 186
-- Name: ethnicity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('ethnicity_id_seq', 6, true);


--
-- TOC entry 2241 (class 0 OID 25186)
-- Dependencies: 183 2260
-- Data for Name: frequency_of_abuse; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY frequency_of_abuse (created, modified, status, master_data_name, description, id) FROM stdin;
2014-03-11	2014-03-11 12:30:23.067509	1	Daily \n	Daily \n	1
2014-03-11	2014-03-11 12:30:52.340338	1	Increasing \n\n	Increasing \n	2
2014-03-11	2014-03-11 12:31:00.747484	1	Weekly \n	Weekly \n	3
2014-03-11	2014-03-11 12:31:10.811366	1	Decreasing \n	Decreasing \n	4
2014-03-11	2014-03-11 12:31:19.797237	1	Episodic \n	Episodic \n	5
2014-03-11	2014-03-11 12:31:45.651451	1	Constant \n	Constant \n	6
2014-03-11	2014-03-11 12:32:53.468233	1	Unknown \n	Unknown \n	7
\.


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 182
-- Name: frequency_of_abuse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('frequency_of_abuse_id_seq', 7, true);


--
-- TOC entry 2259 (class 0 OID 25518)
-- Dependencies: 201 2260
-- Data for Name: group_home; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY group_home (created, modified, status, master_data_name, description, id, address) FROM stdin;
2014-03-12	2014-03-12 10:50:01.439586	1	Group Home #1	People with mental problems	1	79 Wester Avenue
2014-03-12	2014-03-12 10:50:36.35127	1	Group Home #2	People with motor disability	2	Park avenue
\.


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 200
-- Name: group_home_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('group_home_id_seq', 3, true);


--
-- TOC entry 2247 (class 0 OID 25275)
-- Dependencies: 189 2260
-- Data for Name: marital_status; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY marital_status (created, modified, status, master_data_name, description, id) FROM stdin;
2014-03-11	2014-03-11 15:44:44.865871	1	Married	Married	1
2014-03-11	2014-03-11 15:44:54.777887	1	Divorced	Divorced	2
2014-03-11	2014-03-11 15:45:01.761829	1	Single	Single	3
2014-03-11	2014-03-11 15:45:13.994981	1	Other	Other	4
\.


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 188
-- Name: marital_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('marital_status_id_seq', 4, true);


--
-- TOC entry 2233 (class 0 OID 25076)
-- Dependencies: 175 2260
-- Data for Name: master_data; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY master_data (created, modified, status, master_data_name, description) FROM stdin;
\.


--
-- TOC entry 2222 (class 0 OID 24912)
-- Dependencies: 164 2260
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY patient (id, created, modified, status, patient_name, patient_midname, patient_last_name, patient_log_number, iq, birthdate, sex, address, telephone, marital_status_id, group_home_id) FROM stdin;
6	2014-03-10	2014-03-12 10:50:53.592769	1	John	rafael	Doe	PATIENT-000006	71	1980-01-01	M	\N	\N	2	1
7	2014-03-10	2014-03-12 10:50:54.887214	1	Michael	sd	Stype	PATIENT-000007	21	1980-01-01	M	\N	\N	2	1
8	2014-03-10	2014-03-12 10:50:55.896884	1	Miguel	Angel	Sorriano	PATIENT-000008	2	1980-01-01	M	\N	\N	2	1
10	2014-03-10	2014-03-12 10:50:57.4638	1	Dexter	A	Morgan	PATIENT-000010	71	1980-01-01	M	\N	\N	2	1
\.


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 163
-- Name: patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('patient_id_seq', 10, true);


--
-- TOC entry 2249 (class 0 OID 25332)
-- Dependencies: 191 2260
-- Data for Name: relationship; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY relationship (created, modified, status, master_data_name, description, id) FROM stdin;
2014-03-11	2014-03-11 16:26:33.610164	1	Brother	Brother	1
2014-03-11	2014-03-11 16:26:44.95429	1	Sister	Sister	2
2014-03-11	2014-03-11 16:26:51.986263	1	Father	Father	3
2014-03-11	2014-03-11 16:26:58.778974	1	Mother	Mother	4
2014-03-11	2014-03-11 16:27:13.850438	1	Step-brother	Step-brother	5
2014-03-11	2014-03-11 16:27:26.906477	1	Step-sister	Step-sister	6
2014-03-11	2014-03-11 16:27:54.610352	1	Step-Father	Step-Father	7
2014-03-11	2014-03-11 16:28:07.331037	1	Step-Mother	Step-Mother	8
2014-03-11	2014-03-11 16:28:59.6105	1	Cousin	\N	9
2014-03-11	2014-03-11 16:29:06.650524	1	Wife	\N	10
2014-03-11	2014-03-11 16:29:11.32331	1	Husband	\N	11
2014-03-11	2014-03-11 16:29:20.234358	1	Grand-mother	\N	12
2014-03-11	2014-03-11 16:29:37.82624	1	Grand-father	\N	13
2014-03-11	2014-03-11 16:29:42.874946	1	Friend	\N	14
2014-03-11	2014-03-11 16:29:59.842527	1	Other	\N	15
\.


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 190
-- Name: relationship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('relationship_id_seq', 15, true);


--
-- TOC entry 2220 (class 0 OID 24893)
-- Dependencies: 162 2260
-- Data for Name: system_user; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY system_user (id, created, modified, user_type, status, user_name, user_last_name, login, login_password, social_security, address, telephone, birthdate, marital_status_id) FROM stdin;
1	2014-03-10	2014-03-11 16:02:21.219543	1	1	John	Doe	Administrator	202cb962ac59075b964b07152d234b70	\N	\N	508-8762345	1980-01-01	1
2	2014-03-10	2014-03-11 16:02:23.473976	2	1	Mark	Twain	mtwain	202cb962ac59075b964b07152d234b70	\N	\N	508-8762347	1980-01-01	1
\.


--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 161
-- Name: system_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('system_user_id_seq', 2, true);


--
-- TOC entry 2243 (class 0 OID 25200)
-- Dependencies: 185 2260
-- Data for Name: type_of_abuse; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY type_of_abuse (created, modified, status, master_data_name, description, id) FROM stdin;
2014-03-11	2014-03-11 12:33:18.875219	1	Physical \n	Physical \n	1
2014-03-11	2014-03-11 12:33:29.051259	1	Omission\n	Omission\n	2
2014-03-11	2014-03-11 12:33:36.356243	1	Sexual \n	Sexual \n	3
2014-03-11	2014-03-11 12:33:43.499518	1	Other\n	Other\n	4
2014-03-11	2014-03-11 12:33:50.419899	1	Emotional\n	Emotional\n	5
\.


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 184
-- Name: type_of_abuse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('type_of_abuse_id_seq', 5, true);


--
-- TOC entry 2239 (class 0 OID 25171)
-- Dependencies: 181 2260
-- Data for Name: type_of_service; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

COPY type_of_service (created, modified, status, master_data_name, description, id) FROM stdin;
2014-03-11	2014-03-11 12:22:27.459231	1	Institutional \n	Institutional \n	1
2014-03-11	2014-03-11 12:22:44.555306	1	Residential \n	Residential \n	2
2014-03-11	2014-03-11 12:22:54.720681	1	Day Program \n	Day Program \n	3
2014-03-11	2014-03-11 12:23:07.491363	1	Case Management \n	Case Management \n	4
2014-03-11	2014-03-11 12:23:21.851692	1	Service Coordination\n	Service Coordination\n	5
2014-03-11	2014-03-11 12:23:31.491449	1	Foster / Spec. Home Care\n	Foster / Spec. Home Care\n	6
2014-03-11	2014-03-11 12:25:28.747519	1	Respite\n	Respite\n	7
2014-03-11	2014-03-11 12:25:41.620217	1	Other\n	Other\n	8
\.


--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 180
-- Name: type_of_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('type_of_service_id_seq', 8, true);


--
-- TOC entry 2068 (class 2606 OID 25438)
-- Dependencies: 195 195 2261
-- Name: abuse_report_disability_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY abuse_report_disability
    ADD CONSTRAINT abuse_report_disability_pkey PRIMARY KEY (id);


--
-- TOC entry 2070 (class 2606 OID 25470)
-- Dependencies: 197 197 2261
-- Name: abuse_report_frequency_of_abuse_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse
    ADD CONSTRAINT abuse_report_frequency_of_abuse_pkey PRIMARY KEY (id);


--
-- TOC entry 2066 (class 2606 OID 25362)
-- Dependencies: 193 193 2261
-- Name: abuse_report_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_pkey PRIMARY KEY (id);


--
-- TOC entry 2072 (class 2606 OID 25499)
-- Dependencies: 199 199 2261
-- Name: abuse_report_type_of_abuse_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY abuse_report_type_of_abuse
    ADD CONSTRAINT abuse_report_type_of_abuse_pkey PRIMARY KEY (id);


--
-- TOC entry 2052 (class 2606 OID 25164)
-- Dependencies: 179 179 2261
-- Name: comunication_need_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY comunication_need
    ADD CONSTRAINT comunication_need_pkey PRIMARY KEY (id);


--
-- TOC entry 2050 (class 2606 OID 25150)
-- Dependencies: 177 177 2261
-- Name: currently_served_by_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY currently_served_by
    ADD CONSTRAINT currently_served_by_pkey PRIMARY KEY (id);


--
-- TOC entry 2028 (class 2606 OID 24963)
-- Dependencies: 166 166 2261
-- Name: disability_disability_name_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disability
    ADD CONSTRAINT disability_disability_name_key UNIQUE (disability_name);


--
-- TOC entry 2036 (class 2606 OID 25003)
-- Dependencies: 170 170 170 2261
-- Name: disability_patient_disability_id_patient_id_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disability_patient
    ADD CONSTRAINT disability_patient_disability_id_patient_id_key UNIQUE (disability_id, patient_id);


--
-- TOC entry 2038 (class 2606 OID 24979)
-- Dependencies: 170 170 2261
-- Name: disability_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disability_patient
    ADD CONSTRAINT disability_patient_pkey PRIMARY KEY (id);


--
-- TOC entry 2030 (class 2606 OID 24961)
-- Dependencies: 166 166 2261
-- Name: disability_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disability
    ADD CONSTRAINT disability_pkey PRIMARY KEY (id);


--
-- TOC entry 2044 (class 2606 OID 25032)
-- Dependencies: 174 174 2261
-- Name: disabiltity_type_name_disabiltity_type_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disabiltity_type
    ADD CONSTRAINT disabiltity_type_name_disabiltity_type_key UNIQUE (name_disabiltity_type);


--
-- TOC entry 2046 (class 2606 OID 25030)
-- Dependencies: 174 174 2261
-- Name: disabiltity_type_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disabiltity_type
    ADD CONSTRAINT disabiltity_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2032 (class 2606 OID 24969)
-- Dependencies: 168 168 2261
-- Name: drug_drug_name_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_drug_name_key UNIQUE (drug_name);


--
-- TOC entry 2040 (class 2606 OID 25015)
-- Dependencies: 172 172 172 2261
-- Name: drug_patient_drug_id_patient_id_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY drug_patient
    ADD CONSTRAINT drug_patient_drug_id_patient_id_key UNIQUE (drug_id, patient_id);


--
-- TOC entry 2042 (class 2606 OID 24990)
-- Dependencies: 172 172 2261
-- Name: drug_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY drug_patient
    ADD CONSTRAINT drug_patient_pkey PRIMARY KEY (id);


--
-- TOC entry 2034 (class 2606 OID 24966)
-- Dependencies: 168 168 2261
-- Name: drug_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_pkey PRIMARY KEY (id);


--
-- TOC entry 2060 (class 2606 OID 25225)
-- Dependencies: 187 187 2261
-- Name: ethnicity_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY ethnicity
    ADD CONSTRAINT ethnicity_pkey PRIMARY KEY (id);


--
-- TOC entry 2056 (class 2606 OID 25197)
-- Dependencies: 183 183 2261
-- Name: frequency_of_abuse_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY frequency_of_abuse
    ADD CONSTRAINT frequency_of_abuse_pkey PRIMARY KEY (id);


--
-- TOC entry 2074 (class 2606 OID 25529)
-- Dependencies: 201 201 2261
-- Name: group_home_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY group_home
    ADD CONSTRAINT group_home_pkey PRIMARY KEY (id);


--
-- TOC entry 2062 (class 2606 OID 25286)
-- Dependencies: 189 189 2261
-- Name: marital_status_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY marital_status
    ADD CONSTRAINT marital_status_pkey PRIMARY KEY (id);


--
-- TOC entry 2048 (class 2606 OID 25168)
-- Dependencies: 175 175 2261
-- Name: master_data_master_data_name_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY master_data
    ADD CONSTRAINT master_data_master_data_name_key UNIQUE (master_data_name);


--
-- TOC entry 2024 (class 2606 OID 24930)
-- Dependencies: 164 164 2261
-- Name: patient_patient_log_number_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_patient_log_number_key UNIQUE (patient_log_number);


--
-- TOC entry 2026 (class 2606 OID 24924)
-- Dependencies: 164 164 2261
-- Name: patient_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);


--
-- TOC entry 2064 (class 2606 OID 25343)
-- Dependencies: 191 191 2261
-- Name: relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY relationship
    ADD CONSTRAINT relationship_pkey PRIMARY KEY (id);


--
-- TOC entry 2020 (class 2606 OID 24905)
-- Dependencies: 162 162 2261
-- Name: system_user_login_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT system_user_login_key UNIQUE (login);


--
-- TOC entry 2022 (class 2606 OID 24900)
-- Dependencies: 162 162 2261
-- Name: system_user_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT system_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2058 (class 2606 OID 25211)
-- Dependencies: 185 185 2261
-- Name: type_of_abuse_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY type_of_abuse
    ADD CONSTRAINT type_of_abuse_pkey PRIMARY KEY (id);


--
-- TOC entry 2054 (class 2606 OID 25182)
-- Dependencies: 181 181 2261
-- Name: type_of_service_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY type_of_service
    ADD CONSTRAINT type_of_service_pkey PRIMARY KEY (id);


--
-- TOC entry 2106 (class 2620 OID 24933)
-- Dependencies: 215 164 2261
-- Name: create_patient_log_trg; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER create_patient_log_trg AFTER INSERT ON patient FOR EACH ROW EXECUTE PROCEDURE create_patient_log();


--
-- TOC entry 2113 (class 2620 OID 25393)
-- Dependencies: 193 216 2261
-- Name: create_public_log_number_trg; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER create_public_log_number_trg AFTER INSERT ON abuse_report FOR EACH ROW EXECUTE PROCEDURE create_public_log_number();


--
-- TOC entry 2114 (class 2620 OID 25394)
-- Dependencies: 193 214 2261
-- Name: update_lastmodified_modtime_abuse_report; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_abuse_report BEFORE UPDATE ON abuse_report FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2115 (class 2620 OID 25439)
-- Dependencies: 195 214 2261
-- Name: update_lastmodified_modtime_abuse_report_disability; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_abuse_report_disability BEFORE UPDATE ON abuse_report_disability FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2116 (class 2620 OID 25471)
-- Dependencies: 197 214 2261
-- Name: update_lastmodified_modtime_abuse_report_frequency_of_abuse; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_abuse_report_frequency_of_abuse BEFORE UPDATE ON abuse_report_frequency_of_abuse FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2117 (class 2620 OID 25500)
-- Dependencies: 199 214 2261
-- Name: update_lastmodified_modtime_abuse_report_type_of_abuse; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_abuse_report_type_of_abuse BEFORE UPDATE ON abuse_report_type_of_abuse FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2107 (class 2620 OID 24946)
-- Dependencies: 166 214 2261
-- Name: update_lastmodified_modtime_disability; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_disability BEFORE UPDATE ON disability FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2109 (class 2620 OID 24980)
-- Dependencies: 214 170 2261
-- Name: update_lastmodified_modtime_disability_patient; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_disability_patient BEFORE UPDATE ON disability_patient FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2111 (class 2620 OID 25027)
-- Dependencies: 214 174 2261
-- Name: update_lastmodified_modtime_disabiltity_type; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_disabiltity_type BEFORE UPDATE ON disabiltity_type FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2108 (class 2620 OID 24959)
-- Dependencies: 168 214 2261
-- Name: update_lastmodified_modtime_drug; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_drug BEFORE UPDATE ON drug FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2110 (class 2620 OID 24991)
-- Dependencies: 214 172 2261
-- Name: update_lastmodified_modtime_drug_patient; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_drug_patient BEFORE UPDATE ON drug_patient FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2112 (class 2620 OID 25085)
-- Dependencies: 214 175 2261
-- Name: update_lastmodified_modtime_master_data; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_master_data BEFORE UPDATE ON master_data FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2105 (class 2620 OID 24922)
-- Dependencies: 214 164 2261
-- Name: update_lastmodified_modtime_patient; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_patient BEFORE UPDATE ON patient FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2104 (class 2620 OID 24906)
-- Dependencies: 214 162 2261
-- Name: update_lastmodified_modtime_system_user; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_system_user BEFORE UPDATE ON system_user FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2083 (class 2606 OID 25363)
-- Dependencies: 193 164 2025 2261
-- Name: abuse_report_alleged_abuser_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_abuser_patient_id_fkey FOREIGN KEY (alleged_abuser_patient_id) REFERENCES patient(id);


--
-- TOC entry 2090 (class 2606 OID 25400)
-- Dependencies: 2063 191 193 2261
-- Name: abuse_report_alleged_abuser_relationship_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_abuser_relationship_id_fkey FOREIGN KEY (alleged_abuser_relationship_id) REFERENCES relationship(id);


--
-- TOC entry 2084 (class 2606 OID 25368)
-- Dependencies: 162 193 2021 2261
-- Name: abuse_report_alleged_abuser_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_abuser_staff_id_fkey FOREIGN KEY (alleged_abuser_staff_id) REFERENCES system_user(id);


--
-- TOC entry 2085 (class 2606 OID 25373)
-- Dependencies: 193 189 2061 2261
-- Name: abuse_report_alleged_victim_marital_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_victim_marital_status_id_fkey FOREIGN KEY (alleged_victim_marital_status_id) REFERENCES marital_status(id);


--
-- TOC entry 2086 (class 2606 OID 25378)
-- Dependencies: 2025 164 193 2261
-- Name: abuse_report_alleged_victim_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_victim_patient_id_fkey FOREIGN KEY (alleged_victim_patient_id) REFERENCES patient(id);


--
-- TOC entry 2087 (class 2606 OID 25383)
-- Dependencies: 162 2021 193 2261
-- Name: abuse_report_alleged_victim_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_victim_staff_id_fkey FOREIGN KEY (alleged_victim_staff_id) REFERENCES system_user(id);


--
-- TOC entry 2091 (class 2606 OID 25406)
-- Dependencies: 191 193 2063 2261
-- Name: abuse_report_client_guardian_relationship_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_client_guardian_relationship_id_fkey FOREIGN KEY (client_guardian_relationship_id) REFERENCES relationship(id);


--
-- TOC entry 2093 (class 2606 OID 25416)
-- Dependencies: 193 179 2051 2261
-- Name: abuse_report_comunication_need_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_comunication_need_id_fkey FOREIGN KEY (comunication_need_id) REFERENCES comunication_need(id);


--
-- TOC entry 2092 (class 2606 OID 25411)
-- Dependencies: 177 2049 193 2261
-- Name: abuse_report_currently_served_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_currently_served_by_id_fkey FOREIGN KEY (currently_served_by_id) REFERENCES currently_served_by(id);


--
-- TOC entry 2097 (class 2606 OID 25453)
-- Dependencies: 195 193 2065 2261
-- Name: abuse_report_disability_abuse_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_disability
    ADD CONSTRAINT abuse_report_disability_abuse_report_id_fkey FOREIGN KEY (abuse_report_id) REFERENCES abuse_report(id);


--
-- TOC entry 2095 (class 2606 OID 25443)
-- Dependencies: 2029 195 166 2261
-- Name: abuse_report_disability_disability_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_disability
    ADD CONSTRAINT abuse_report_disability_disability_id_fkey FOREIGN KEY (disability_id) REFERENCES disability(id);


--
-- TOC entry 2096 (class 2606 OID 25448)
-- Dependencies: 164 195 2025 2261
-- Name: abuse_report_disability_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_disability
    ADD CONSTRAINT abuse_report_disability_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2098 (class 2606 OID 25472)
-- Dependencies: 197 2065 193 2261
-- Name: abuse_report_frequency_of_abuse_abuse_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse
    ADD CONSTRAINT abuse_report_frequency_of_abuse_abuse_report_id_fkey FOREIGN KEY (abuse_report_id) REFERENCES abuse_report(id);


--
-- TOC entry 2099 (class 2606 OID 25477)
-- Dependencies: 183 197 2055 2261
-- Name: abuse_report_frequency_of_abuse_frequency_of_abuse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse
    ADD CONSTRAINT abuse_report_frequency_of_abuse_frequency_of_abuse_id_fkey FOREIGN KEY (frequency_of_abuse_id) REFERENCES frequency_of_abuse(id);


--
-- TOC entry 2100 (class 2606 OID 25482)
-- Dependencies: 164 197 2025 2261
-- Name: abuse_report_frequency_of_abuse_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse
    ADD CONSTRAINT abuse_report_frequency_of_abuse_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2088 (class 2606 OID 25388)
-- Dependencies: 162 2021 193 2261
-- Name: abuse_report_reporter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_reporter_id_fkey FOREIGN KEY (reporter_id) REFERENCES system_user(id);


--
-- TOC entry 2089 (class 2606 OID 25395)
-- Dependencies: 2063 193 191 2261
-- Name: abuse_report_reporter_relationship_to_victim_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_reporter_relationship_to_victim_id_fkey FOREIGN KEY (reporter_relationship_to_victim_id) REFERENCES relationship(id);


--
-- TOC entry 2101 (class 2606 OID 25501)
-- Dependencies: 199 2065 193 2261
-- Name: abuse_report_type_of_abuse_abuse_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_type_of_abuse
    ADD CONSTRAINT abuse_report_type_of_abuse_abuse_report_id_fkey FOREIGN KEY (abuse_report_id) REFERENCES abuse_report(id);


--
-- TOC entry 2102 (class 2606 OID 25506)
-- Dependencies: 2025 164 199 2261
-- Name: abuse_report_type_of_abuse_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_type_of_abuse
    ADD CONSTRAINT abuse_report_type_of_abuse_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2103 (class 2606 OID 25511)
-- Dependencies: 185 199 2057 2261
-- Name: abuse_report_type_of_abuse_type_of_abuse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_type_of_abuse
    ADD CONSTRAINT abuse_report_type_of_abuse_type_of_abuse_id_fkey FOREIGN KEY (type_of_abuse_id) REFERENCES type_of_abuse(id);


--
-- TOC entry 2094 (class 2606 OID 25421)
-- Dependencies: 181 193 2053 2261
-- Name: abuse_report_type_of_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_type_of_service_id_fkey FOREIGN KEY (type_of_service_id) REFERENCES type_of_service(id);


--
-- TOC entry 2078 (class 2606 OID 25033)
-- Dependencies: 166 174 2045 2261
-- Name: disability_disability_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability
    ADD CONSTRAINT disability_disability_type_id_fkey FOREIGN KEY (disability_type_id) REFERENCES disabiltity_type(id);


--
-- TOC entry 2079 (class 2606 OID 24992)
-- Dependencies: 166 2029 170 2261
-- Name: disability_patient_disability_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability_patient
    ADD CONSTRAINT disability_patient_disability_id_fkey FOREIGN KEY (disability_id) REFERENCES disability(id);


--
-- TOC entry 2080 (class 2606 OID 24997)
-- Dependencies: 2025 170 164 2261
-- Name: disability_patient_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability_patient
    ADD CONSTRAINT disability_patient_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2081 (class 2606 OID 25004)
-- Dependencies: 2033 168 172 2261
-- Name: drug_patient_drug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY drug_patient
    ADD CONSTRAINT drug_patient_drug_id_fkey FOREIGN KEY (drug_id) REFERENCES drug(id);


--
-- TOC entry 2082 (class 2606 OID 25009)
-- Dependencies: 172 2025 164 2261
-- Name: drug_patient_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY drug_patient
    ADD CONSTRAINT drug_patient_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2077 (class 2606 OID 25530)
-- Dependencies: 164 2073 201 2261
-- Name: patient_group_home_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_group_home_id_fkey FOREIGN KEY (group_home_id) REFERENCES group_home(id);


--
-- TOC entry 2076 (class 2606 OID 25300)
-- Dependencies: 189 164 2061 2261
-- Name: patient_marital_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_marital_status_id_fkey FOREIGN KEY (marital_status_id) REFERENCES marital_status(id);


--
-- TOC entry 2075 (class 2606 OID 25287)
-- Dependencies: 2061 162 189 2261
-- Name: system_user_marital_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT system_user_marital_status_id_fkey FOREIGN KEY (marital_status_id) REFERENCES marital_status(id);


--
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-03-12 12:43:41 EDT

--
-- PostgreSQL database dump complete
--

