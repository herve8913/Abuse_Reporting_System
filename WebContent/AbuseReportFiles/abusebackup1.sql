--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.4
-- Dumped by pg_dump version 9.3.4
-- Started on 2014-04-29 21:16:07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2389 (class 1262 OID 16393)
-- Name: abusereport; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE abusereport WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Chinese (Simplified)_People''s Republic of China.936' LC_CTYPE = 'Chinese (Simplified)_People''s Republic of China.936';


ALTER DATABASE abusereport OWNER TO postgres;

\connect abusereport

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 221 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 221
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 236 (class 1255 OID 24725)
-- Name: close_abuse_report(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION close_abuse_report() RETURNS boolean
    LANGUAGE plpgsql
    AS $$   DECLARE
 cursor1 RECORD; 
 days_left int;
 band BOOL;
 date_1 date;
 BEGIN
   band:=FALSE;date_1:=current_date;
   FOR cursor1 IN SELECT * FROM abusereport WHERE (status=5 OR status=6) LOOP
     IF(date_1>cursor1.due_date)THEN
       UPDATE  abusereport SET status=7 WHERE id=cursor1.id;
       band:=TRUE;
     END IF;
     
   END LOOP;
   return band;
 END;
$$;


ALTER FUNCTION public.close_abuse_report() OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 24718)
-- Name: create_abuse_report_disability(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION create_abuse_report_disability() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  patient_id1 INT;
  cursor1 RECORD;
  band BOOL;
  BEGIN
/***************************************************/
/*** FIRST WE SE IF THE RECORD WAS ALREDAY INSERTED**/ 
/***************************************************/
    band:=FALSE; 
    IF(NEW.alleged_victim_patient_id>0)THEN
      band:=TRUE;
      patient_id1:=NEW.alleged_victim_patient_id; 
    ELSE
      IF(NEW.alleged_abuser_patient_id>0)THEN
        patient_id1:=NEW.alleged_abuser_patient_id; 
        band:=TRUE;
      END IF; 
    END IF;
    IF(band=TRUE)THEN
     SELECT * FROM  abuse_report_disability WHERE abusereport_id=NEW.id INTO cursor1;
      IF(cursor1.id IS NULL)THEN
        FOR cursor1 IN SELECT disability.id,disability.disability_name,disability.description
        FROM disability,disability_patient,patient WHERE 
        disability.id=disability_id AND patient.id=disability_patient.patient_id 
        AND patient.id=patient_id1 LOOP
           INSERT INTO abuse_report_disability(disability_id,disability_name,disability_comment,patient_id,abusereport_id)
           VALUES(cursor1.id,cursor1.disability_name, cursor1.description,patient_id1,NEW.id);
        END LOOP;
      END IF;
    END IF;     
    RETURN NULL;
  END;
$$;


ALTER FUNCTION public.create_abuse_report_disability() OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 16415)
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
-- TOC entry 238 (class 1255 OID 16416)
-- Name: create_public_log_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION create_public_log_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  band BOOL;
  public_log_number_var character varying;
  cursor1 RECORD;
  date_of_last_incident1 DATE;
  insertion_possible BOOL;
  minutes_last INT;
  hours_last INT;
  days_last INT;
  month_last INT;
  year_last INT;

  minutes_new INT;
  hours_new INT;
  days_new INT;
  month_new INT;
  year_new INT;
  modified character varying; 
  subtraction int;
  BEGIN
    IF(NEW.public_log_number = '-1') THEN 
      insertion_possible:=TRUE;
         
 /*********************************************************************************/
 
      band:=FALSE;
      IF(NEW.alleged_victim_patient_id>0) THEN
        SELECT * FROM abusereport WHERE  alleged_victim_patient_id=NEW.alleged_victim_patient_id
        AND public_log_number<> '-1'
        ORDER BY id DESC LIMIT 1 INTO cursor1;
        IF(cursor1.id IS NOT NULL)THEN
            
           year_last:=substring(CAST (cursor1.modified AS character varying)  from 1 for 4);
           month_last:=substring(CAST (cursor1.modified AS character varying)  from 6 for 2);
           days_last:=substring(CAST (cursor1.modified AS character varying)  from 9 for 2);
           hours_last:=substring(CAST (cursor1.modified AS character varying)  from 12 for 2);
           minutes_last:=substring(CAST (cursor1.modified AS character varying)  from 15 for 2);

           year_new:=substring(CAST (NEW.modified AS character varying) from 1 for 4);
           month_new:=substring(CAST (NEW.modified AS character varying) from 6 for 2);
           days_new:=substring(CAST (NEW.modified AS character varying) from 9 for 2);
           hours_new:=substring(CAST (NEW.modified AS character varying) from 12 for 2);
           minutes_new:=substring(CAST (NEW.modified AS character varying) from 15 for 2);
           subtraction:=CAST(minutes_new AS integer)- CAST (minutes_last AS integer);
           IF((year_last=year_new)AND(month_last=month_new)
           AND (days_last=days_new)AND(hours_last=hours_new)
           AND((minutes_last=minutes_new)OR(subtraction=1)))THEN
             insertion_possible:=FALSE;
             
           ELSE
             date_of_last_incident1:=cursor1.created;
             band:=TRUE;   
           END IF;
          
        END IF;
      ELSE
        SELECT * FROM abusereport WHERE  alleged_abuser_patient_id=NEW.alleged_abuser_patient_id
        AND public_log_number<> '-1'
        ORDER BY id DESC LIMIT 1 INTO cursor1;
        IF(cursor1.id IS NOT NULL)THEN
           year_last:=substring(CAST (cursor1.modified AS character varying)  from 1 for 4);
           month_last:=substring(CAST (cursor1.modified AS character varying)  from 6 for 2);
           days_last:=substring(CAST (cursor1.modified AS character varying)  from 9 for 2);
           hours_last:=substring(CAST (cursor1.modified AS character varying)  from 12 for 2);
           minutes_last:=substring(CAST (cursor1.modified AS character varying)  from 15 for 2);

           year_new:=substring(CAST (NEW.modified AS character varying) from 1 for 4);
           month_new:=substring(CAST (NEW.modified AS character varying) from 6 for 2);
           days_new:=substring(CAST (NEW.modified AS character varying) from 9 for 2);
           hours_new:=substring(CAST (NEW.modified AS character varying) from 12 for 2);
           minutes_new:=substring(CAST (NEW.modified AS character varying) from 15 for 2);
           subtraction:=CAST(minutes_new AS integer)- CAST (minutes_last AS integer);
           IF((year_last=year_new)AND(month_last=month_new)
           AND (days_last=days_new)AND(hours_last=hours_new)
           AND((minutes_last=minutes_new)OR(subtraction=1)))THEN
            insertion_possible:=FALSE;
             
          ELSE  
            date_of_last_incident1:=cursor1.created;
            band:=TRUE;
          END IF;
        END IF;
      END IF;  
      
 /*********************************************************************************/
      IF(insertion_possible=TRUE)THEN
        public_log_number_var := 'PUBLIC-LOG'||'-'||TRIM(to_char(NEW.id,'000000')); 
        IF(band=TRUE)THEN
          UPDATE abusereport SET public_log_number=public_log_number_var,
          date_of_last_incident=date_of_last_incident1 WHERE id= NEW.id;
        ELSE
          UPDATE abusereport SET public_log_number=public_log_number_var WHERE id= NEW.id;
        END IF;
      ELSE
        DELETE FROM abusereport WHERE id=NEW.id AND public_log_number='-1';
      END IF;
    END IF;  
    RETURN NULL;
  END;
$$;


ALTER FUNCTION public.create_public_log_number() OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 16417)
-- Name: update_lastmodified_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_lastmodified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 DECLARE
  date1 date;
  string1 character varying;
 BEGIN
   NEW.modified = NOW();
   
   
   IF (TG_TABLE_NAME='abusereport')THEN
    IF((NEW.status=5) AND (NEW.due_date IS  NULL))THEN
     string1:=CAST(NEW.modified  AS DATE);
     date1:=CAST(substring (string1 FROM 1 FOR 10) AS DATE)+30;
     
     NEW.due_date:=date1;
    END IF; 
   END IF;
   RETURN NEW;
 END;
$$;


ALTER FUNCTION public.update_lastmodified_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 170 (class 1259 OID 16418)
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
-- TOC entry 171 (class 1259 OID 16435)
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
    abusereport_id integer NOT NULL
);


ALTER TABLE public.abuse_report_disability OWNER TO abusereportuser;

--
-- TOC entry 172 (class 1259 OID 16443)
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
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 172
-- Name: abuse_report_disability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE abuse_report_disability_id_seq OWNED BY abuse_report_disability.id;


--
-- TOC entry 173 (class 1259 OID 16445)
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
    abusereport_id integer NOT NULL
);


ALTER TABLE public.abuse_report_frequency_of_abuse OWNER TO abusereportuser;

--
-- TOC entry 174 (class 1259 OID 16453)
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
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 174
-- Name: abuse_report_frequency_of_abuse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE abuse_report_frequency_of_abuse_id_seq OWNED BY abuse_report_frequency_of_abuse.id;


--
-- TOC entry 175 (class 1259 OID 16455)
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
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 175
-- Name: abuse_report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE abuse_report_id_seq OWNED BY abuse_report.id;


--
-- TOC entry 176 (class 1259 OID 16457)
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
    abusereport_id integer NOT NULL
);


ALTER TABLE public.abuse_report_type_of_abuse OWNER TO abusereportuser;

--
-- TOC entry 177 (class 1259 OID 16465)
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
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 177
-- Name: abuse_report_type_of_abuse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE abuse_report_type_of_abuse_id_seq OWNED BY abuse_report_type_of_abuse.id;


--
-- TOC entry 214 (class 1259 OID 24587)
-- Name: abusereport; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE abusereport (
    id integer NOT NULL,
    created date DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    public_log_number character varying(255) DEFAULT (-1) NOT NULL,
    reporter_id integer DEFAULT 11 NOT NULL,
    reporter_name character varying(255) NOT NULL,
    reporter_address text,
    reporter_telephone character varying(255) NOT NULL,
    mandated character varying(5) DEFAULT 1 NOT NULL,
    reporter_relationship_to_victim character varying(255) NOT NULL,
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
    alleged_abuser_relationship character varying(255) NOT NULL,
    alleged_abuser_social_security character varying(255),
    alleged_abuser_datebirth date NOT NULL,
    alleged_abuser_telephone character varying(100),
    comunication_need character varying(255) NOT NULL,
    client_guardian_id integer,
    client_guardian_name character varying(255),
    client_guardian_address text,
    client_guardian_relationship character varying(255),
    client_guardian_telephone character varying(100),
    currently_served_by_id integer,
    currently_served_by_department character varying(255),
    collateral_contacts_notification text,
    type_of_service character varying(255),
    type_of_abusereport character varying(255),
    frequency_of_abuse character varying(255),
    is_victim_aware character varying(3) NOT NULL,
    date_of_last_incident date,
    description_alleged_report text,
    description_level_risk text,
    description_resulting_injuries text,
    description_witnesses text,
    description_caregiver_relationship text,
    oral_report_filed character varying(3),
    oral_report_filed_comment text,
    risk_to_investigator character varying(3),
    risk_to_investigator_comment text,
    disposition_letter character varying(255),
    decision_letter character varying(255),
    appeal_letter character varying(255),
    due_date date
);


ALTER TABLE public.abusereport OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24585)
-- Name: abusereport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE abusereport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abusereport_id_seq OWNER TO postgres;

--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 213
-- Name: abusereport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE abusereport_id_seq OWNED BY abusereport.id;


--
-- TOC entry 178 (class 1259 OID 16467)
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
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN master_data.status; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN master_data.status IS '1:"Active"
0:"Inactive"';


--
-- TOC entry 201 (class 1259 OID 16590)
-- Name: marital_status; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE marital_status (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.marital_status OWNER TO abusereportuser;

--
-- TOC entry 207 (class 1259 OID 16626)
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
    telephone character varying(100) NOT NULL,
    birthdate date NOT NULL,
    marital_status_id integer NOT NULL,
    supervisor_id integer,
    user_address character varying(255),
    sex "char" NOT NULL,
    CONSTRAINT system_user_sex_check CHECK (((sex = 'M'::"char") OR (sex = 'F'::"char"))),
    CONSTRAINT system_user_status_check CHECK (((status = 0) OR (status = 1))),
    CONSTRAINT system_user_user_type_check CHECK (((user_type > 0) AND (user_type < 5))),
    CONSTRAINT system_user_user_type_check1 CHECK (((user_type <> 1) OR (user_type <> 2)))
);


ALTER TABLE public.system_user OWNER TO abusereportuser;

--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN system_user.user_type; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN system_user.user_type IS '1: "Administrator"
2: "Supervisor"
3: "Staff"
4: "Human Rights Commitee"';


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN system_user.status; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN system_user.status IS '0: "Inactive"
1:"Active"';


--
-- TOC entry 218 (class 1259 OID 24733)
-- Name: all_user_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW all_user_view AS
 SELECT s.id,
    s.created,
    s.modified,
    s.user_type,
    s.status,
    s.user_name,
    s.user_last_name,
    s.login,
    s.login_password,
    s.social_security,
    s.telephone,
    s.birthdate,
    s.marital_status_id,
    s.supervisor_id,
    s.user_address,
    s.sex,
    m.master_data_name
   FROM system_user s,
    marital_status m
  WHERE (s.marital_status_id = m.id)
  ORDER BY s.id;


ALTER TABLE public.all_user_view OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 16476)
-- Name: comunication_need; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE comunication_need (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.comunication_need OWNER TO abusereportuser;

--
-- TOC entry 180 (class 1259 OID 16485)
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
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 180
-- Name: comunication_need_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE comunication_need_id_seq OWNED BY comunication_need.id;


--
-- TOC entry 181 (class 1259 OID 16487)
-- Name: currently_served_by; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE currently_served_by (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.currently_served_by OWNER TO abusereportuser;

--
-- TOC entry 182 (class 1259 OID 16496)
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
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 182
-- Name: currently_served_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE currently_served_by_id_seq OWNED BY currently_served_by.id;


--
-- TOC entry 183 (class 1259 OID 16498)
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
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN disability.status; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN disability.status IS '1:"Active"
0:"Inactive"';


--
-- TOC entry 184 (class 1259 OID 16508)
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
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 184
-- Name: disability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE disability_id_seq OWNED BY disability.id;


--
-- TOC entry 185 (class 1259 OID 16510)
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
-- TOC entry 186 (class 1259 OID 16515)
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
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 186
-- Name: disability_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE disability_patient_id_seq OWNED BY disability_patient.id;


--
-- TOC entry 187 (class 1259 OID 16517)
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
-- TOC entry 188 (class 1259 OID 16525)
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
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 188
-- Name: disabiltity_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE disabiltity_type_id_seq OWNED BY disabiltity_type.id;


--
-- TOC entry 189 (class 1259 OID 16527)
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
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN drug.status; Type: COMMENT; Schema: public; Owner: abusereportuser
--

COMMENT ON COLUMN drug.status IS '1: "Active"
0: "Inactive"';


--
-- TOC entry 190 (class 1259 OID 16537)
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
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 190
-- Name: drug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE drug_id_seq OWNED BY drug.id;


--
-- TOC entry 191 (class 1259 OID 16539)
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
-- TOC entry 192 (class 1259 OID 16544)
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
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 192
-- Name: drug_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE drug_patient_id_seq OWNED BY drug_patient.id;


--
-- TOC entry 193 (class 1259 OID 16546)
-- Name: ethnicity; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE ethnicity (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.ethnicity OWNER TO abusereportuser;

--
-- TOC entry 194 (class 1259 OID 16555)
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
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 194
-- Name: ethnicity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE ethnicity_id_seq OWNED BY ethnicity.id;


--
-- TOC entry 195 (class 1259 OID 16557)
-- Name: frequency_of_abuse; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE frequency_of_abuse (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.frequency_of_abuse OWNER TO abusereportuser;

--
-- TOC entry 196 (class 1259 OID 16566)
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
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 196
-- Name: frequency_of_abuse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE frequency_of_abuse_id_seq OWNED BY frequency_of_abuse.id;


--
-- TOC entry 197 (class 1259 OID 16568)
-- Name: group_home; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE group_home (
    id integer NOT NULL,
    address character varying(255) NOT NULL,
    healthcareorg_id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.group_home OWNER TO abusereportuser;

--
-- TOC entry 198 (class 1259 OID 16577)
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
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 198
-- Name: group_home_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE group_home_id_seq OWNED BY group_home.id;


--
-- TOC entry 199 (class 1259 OID 16579)
-- Name: healthcareorg; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE healthcareorg (
    id integer NOT NULL,
    zipcode character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    state character varying(255) NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.healthcareorg OWNER TO abusereportuser;

--
-- TOC entry 200 (class 1259 OID 16588)
-- Name: healthcareorg_id_seq; Type: SEQUENCE; Schema: public; Owner: abusereportuser
--

CREATE SEQUENCE healthcareorg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.healthcareorg_id_seq OWNER TO abusereportuser;

--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 200
-- Name: healthcareorg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE healthcareorg_id_seq OWNED BY healthcareorg.id;


--
-- TOC entry 202 (class 1259 OID 16599)
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
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 202
-- Name: marital_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE marital_status_id_seq OWNED BY marital_status.id;


--
-- TOC entry 203 (class 1259 OID 16601)
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
    telephone character(100),
    marital_status_id integer NOT NULL,
    group_home_id integer NOT NULL,
    currently_served_by_id integer NOT NULL,
    client_guardian_id integer,
    ethnicity_id integer NOT NULL,
    CONSTRAINT patient_iq_check CHECK ((iq < 72)),
    CONSTRAINT patient_sex_check CHECK (((sex = 'M'::"char") OR (sex = 'F'::"char")))
);


ALTER TABLE public.patient OWNER TO abusereportuser;

--
-- TOC entry 204 (class 1259 OID 16613)
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
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 204
-- Name: patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE patient_id_seq OWNED BY patient.id;


--
-- TOC entry 205 (class 1259 OID 16615)
-- Name: relationship; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE relationship (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.relationship OWNER TO abusereportuser;

--
-- TOC entry 206 (class 1259 OID 16624)
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
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 206
-- Name: relationship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE relationship_id_seq OWNED BY relationship.id;


--
-- TOC entry 208 (class 1259 OID 16638)
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
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 208
-- Name: system_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE system_user_id_seq OWNED BY system_user.id;


--
-- TOC entry 209 (class 1259 OID 16640)
-- Name: type_of_abuse; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE type_of_abuse (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.type_of_abuse OWNER TO abusereportuser;

--
-- TOC entry 210 (class 1259 OID 16649)
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
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 210
-- Name: type_of_abuse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE type_of_abuse_id_seq OWNED BY type_of_abuse.id;


--
-- TOC entry 211 (class 1259 OID 16651)
-- Name: type_of_service; Type: TABLE; Schema: public; Owner: abusereportuser; Tablespace: 
--

CREATE TABLE type_of_service (
    id integer NOT NULL
)
INHERITS (master_data);


ALTER TABLE public.type_of_service OWNER TO abusereportuser;

--
-- TOC entry 212 (class 1259 OID 16660)
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
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 212
-- Name: type_of_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abusereportuser
--

ALTER SEQUENCE type_of_service_id_seq OWNED BY type_of_service.id;


--
-- TOC entry 217 (class 1259 OID 24720)
-- Name: view_abuse_report; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW view_abuse_report AS
 SELECT ar.id,
    ar.status,
    ar.public_log_number,
    ar.reporter_id,
    ar.reporter_name,
    ar.reporter_address,
    ar.reporter_telephone,
    ar.mandated,
    ar.reporter_relationship_to_victim,
    ar.alleged_victim_patient_id,
    ar.alleged_victim_name,
    ar.alleged_victim_address,
    ar.alleged_victim_telephone,
    ar.alleged_victim_sex,
    ar.alleged_victim_staff_id,
    ar.alleged_victim_datebirth,
    ar.alleged_victim_marital_status_id,
    marital_status.master_data_name AS marital_status,
    ar.alleged_abuser_patient_id,
    ar.alleged_abuser_staff_id,
    ar.alleged_abuser_name,
    ar.alleged_abuser_address,
    ar.alleged_abuser_relationship,
    ar.alleged_abuser_social_security,
    ar.alleged_abuser_datebirth,
    ar.alleged_abuser_telephone,
    ar.comunication_need,
    ar.client_guardian_id,
    ar.client_guardian_name,
    ar.client_guardian_address,
    ar.client_guardian_relationship,
    ar.client_guardian_telephone,
    ar.currently_served_by_id,
    ar.currently_served_by_department,
    ar.collateral_contacts_notification,
    ar.type_of_service,
    ar.type_of_abusereport,
    ar.frequency_of_abuse,
    ar.is_victim_aware,
    ar.date_of_last_incident,
    ar.description_alleged_report,
    ar.description_level_risk,
    ar.description_resulting_injuries,
    ar.description_witnesses,
    ar.description_caregiver_relationship,
    ar.oral_report_filed,
    ar.oral_report_filed_comment,
    ar.risk_to_investigator,
    ar.risk_to_investigator_comment,
    ar.disposition_letter,
    ar.decision_letter,
    ar.appeal_letter,
    abuse_report_disability.disability_id,
    abuse_report_disability.disability_name,
    abuse_report_disability.disability_comment
   FROM ((abusereport ar
   LEFT JOIN marital_status ON ((marital_status.id = ar.alleged_victim_marital_status_id)))
   LEFT JOIN abuse_report_disability ON ((abuse_report_disability.abusereport_id = ar.id)));


ALTER TABLE public.view_abuse_report OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24737)
-- Name: view_disability_type; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW view_disability_type AS
 SELECT d.id,
    d.created,
    d.modified,
    d.status,
    d.disability_name,
    d.description,
    d.disability_type_id,
    t.name_disabiltity_type
   FROM disability d,
    disabiltity_type t
  WHERE (d.disability_type_id = t.id);


ALTER TABLE public.view_disability_type OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24741)
-- Name: view_patient; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW view_patient AS
 SELECT patient.status AS patient_status,
    patient.patient_name,
    patient.patient_midname,
    patient.patient_last_name,
    patient.patient_log_number,
    patient.iq,
    patient.birthdate,
    patient.sex,
    patient.telephone,
    marital_status.master_data_name AS marital_status,
    group_home.address,
    currently_served_by.master_data_name AS currently_served_by,
    system_user.user_name,
    system_user.user_last_name,
    ethnicity.master_data_name AS ethnicity
   FROM (((((patient
   LEFT JOIN group_home ON ((group_home.id = patient.group_home_id)))
   LEFT JOIN marital_status ON ((marital_status.id = patient.marital_status_id)))
   LEFT JOIN currently_served_by ON ((currently_served_by.id = patient.currently_served_by_id)))
   LEFT JOIN system_user ON ((system_user.id = patient.client_guardian_id)))
   LEFT JOIN ethnicity ON ((ethnicity.id = patient.ethnicity_id)));


ALTER TABLE public.view_patient OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24713)
-- Name: view_staff_guardian_patient; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW view_staff_guardian_patient AS
 SELECT s1.id AS staff_id,
    s1.user_name AS staff_user_name,
    s1.user_last_name AS staff_user_last_name,
    s1.telephone AS staff_telephone,
    s1.user_type,
    s1.status,
    s2.id AS client_guardian_id,
    s2.user_name AS client_guardian_name,
    s2.user_last_name AS client_guardian_user_last_name,
    s2.telephone AS client_guardian_telephone,
    patient.id,
    patient.patient_name,
    patient.patient_midname,
    patient.patient_last_name,
    patient.birthdate,
    patient.iq,
    patient.patient_log_number,
    patient.sex,
    patient.telephone,
    marital_status.id AS marital_status_id,
    marital_status.master_data_name,
    group_home.id AS group_home_id,
    group_home.address AS group_home_address,
    currently_served_by.id AS currently_served_by_id,
    currently_served_by.master_data_name AS currently_served_by_name,
    ethnicity.id AS ethnicity_id,
    ethnicity.master_data_name AS ethnicity_name,
    s1.user_address
   FROM system_user s1,
    (((((system_user s2
   FULL JOIN patient ON ((patient.client_guardian_id = s2.id)))
   LEFT JOIN marital_status ON ((marital_status.id = patient.marital_status_id)))
   LEFT JOIN group_home ON ((group_home.id = patient.group_home_id)))
   LEFT JOIN currently_served_by ON ((currently_served_by.id = patient.currently_served_by_id)))
   LEFT JOIN ethnicity ON ((ethnicity.id = patient.ethnicity_id)))
  WHERE ((s1.status = 1) AND (s1.user_type = 3));


ALTER TABLE public.view_staff_guardian_patient OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24674)
-- Name: view_user_marital_status; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW view_user_marital_status AS
 SELECT system_user.id AS system_user_id,
    system_user.user_type,
    system_user.user_name,
    system_user.user_last_name,
    system_user.login,
    system_user.telephone,
    system_user.birthdate,
    system_user.user_address,
    system_user.sex,
    marital_status.master_data_name
   FROM system_user,
    marital_status
  WHERE (system_user.marital_status_id = marital_status.id);


ALTER TABLE public.view_user_marital_status OWNER TO postgres;

--
-- TOC entry 2009 (class 2604 OID 16662)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report ALTER COLUMN id SET DEFAULT nextval('abuse_report_id_seq'::regclass);


--
-- TOC entry 2017 (class 2604 OID 16663)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_disability ALTER COLUMN id SET DEFAULT nextval('abuse_report_disability_id_seq'::regclass);


--
-- TOC entry 2020 (class 2604 OID 16664)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse ALTER COLUMN id SET DEFAULT nextval('abuse_report_frequency_of_abuse_id_seq'::regclass);


--
-- TOC entry 2023 (class 2604 OID 16665)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_type_of_abuse ALTER COLUMN id SET DEFAULT nextval('abuse_report_type_of_abuse_id_seq'::regclass);


--
-- TOC entry 2101 (class 2604 OID 24590)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport ALTER COLUMN id SET DEFAULT nextval('abusereport_id_seq'::regclass);


--
-- TOC entry 2027 (class 2604 OID 16666)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY comunication_need ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2028 (class 2604 OID 16667)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY comunication_need ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2029 (class 2604 OID 16668)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY comunication_need ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2030 (class 2604 OID 16669)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY comunication_need ALTER COLUMN id SET DEFAULT nextval('comunication_need_id_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 16670)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY currently_served_by ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2032 (class 2604 OID 16671)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY currently_served_by ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2033 (class 2604 OID 16672)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY currently_served_by ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2034 (class 2604 OID 16673)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY currently_served_by ALTER COLUMN id SET DEFAULT nextval('currently_served_by_id_seq'::regclass);


--
-- TOC entry 2038 (class 2604 OID 16674)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability ALTER COLUMN id SET DEFAULT nextval('disability_id_seq'::regclass);


--
-- TOC entry 2042 (class 2604 OID 16675)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability_patient ALTER COLUMN id SET DEFAULT nextval('disability_patient_id_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 16676)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disabiltity_type ALTER COLUMN id SET DEFAULT nextval('disabiltity_type_id_seq'::regclass);


--
-- TOC entry 2049 (class 2604 OID 16677)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY drug ALTER COLUMN id SET DEFAULT nextval('drug_id_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 16678)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY drug_patient ALTER COLUMN id SET DEFAULT nextval('drug_patient_id_seq'::regclass);


--
-- TOC entry 2054 (class 2604 OID 16679)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY ethnicity ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2055 (class 2604 OID 16680)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY ethnicity ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2056 (class 2604 OID 16681)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY ethnicity ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2057 (class 2604 OID 16682)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY ethnicity ALTER COLUMN id SET DEFAULT nextval('ethnicity_id_seq'::regclass);


--
-- TOC entry 2058 (class 2604 OID 16683)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY frequency_of_abuse ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2059 (class 2604 OID 16684)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY frequency_of_abuse ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2060 (class 2604 OID 16685)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY frequency_of_abuse ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2061 (class 2604 OID 16686)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY frequency_of_abuse ALTER COLUMN id SET DEFAULT nextval('frequency_of_abuse_id_seq'::regclass);


--
-- TOC entry 2062 (class 2604 OID 16687)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2063 (class 2604 OID 16688)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2064 (class 2604 OID 16689)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2065 (class 2604 OID 16690)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home ALTER COLUMN id SET DEFAULT nextval('group_home_id_seq'::regclass);


--
-- TOC entry 2066 (class 2604 OID 16691)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY healthcareorg ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2067 (class 2604 OID 16692)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY healthcareorg ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2068 (class 2604 OID 16693)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY healthcareorg ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2069 (class 2604 OID 16694)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY healthcareorg ALTER COLUMN id SET DEFAULT nextval('healthcareorg_id_seq'::regclass);


--
-- TOC entry 2070 (class 2604 OID 16695)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY marital_status ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2071 (class 2604 OID 16696)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY marital_status ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2072 (class 2604 OID 16697)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY marital_status ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2073 (class 2604 OID 16698)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY marital_status ALTER COLUMN id SET DEFAULT nextval('marital_status_id_seq'::regclass);


--
-- TOC entry 2078 (class 2604 OID 16699)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient ALTER COLUMN id SET DEFAULT nextval('patient_id_seq'::regclass);


--
-- TOC entry 2081 (class 2604 OID 16700)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY relationship ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2082 (class 2604 OID 16701)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY relationship ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2083 (class 2604 OID 16702)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY relationship ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2084 (class 2604 OID 16703)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY relationship ALTER COLUMN id SET DEFAULT nextval('relationship_id_seq'::regclass);


--
-- TOC entry 2088 (class 2604 OID 16704)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY system_user ALTER COLUMN id SET DEFAULT nextval('system_user_id_seq'::regclass);


--
-- TOC entry 2093 (class 2604 OID 16705)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_abuse ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2094 (class 2604 OID 16706)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_abuse ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2095 (class 2604 OID 16707)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_abuse ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2096 (class 2604 OID 16708)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_abuse ALTER COLUMN id SET DEFAULT nextval('type_of_abuse_id_seq'::regclass);


--
-- TOC entry 2097 (class 2604 OID 16709)
-- Name: created; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_service ALTER COLUMN created SET DEFAULT now();


--
-- TOC entry 2098 (class 2604 OID 16710)
-- Name: modified; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_service ALTER COLUMN modified SET DEFAULT now();


--
-- TOC entry 2099 (class 2604 OID 16711)
-- Name: status; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_service ALTER COLUMN status SET DEFAULT 1;


--
-- TOC entry 2100 (class 2604 OID 16712)
-- Name: id; Type: DEFAULT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY type_of_service ALTER COLUMN id SET DEFAULT nextval('type_of_service_id_seq'::regclass);


--
-- TOC entry 2340 (class 0 OID 16418)
-- Dependencies: 170
-- Data for Name: abuse_report; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO abuse_report (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim_id, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship_id, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need_id, comunication_need_comment, client_guardian_name, client_guardian_address, client_guardian_relationship_id, client_guardian_telephone, currently_served_by_id, currently_served_by_comment, collateral_contacts_notification, type_of_service_id, type_of_service_comment, is_victim_aware, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, date_of_last_incident, disposition_letter, decision_letter, appeal_letter) VALUES (11, '2014-04-16', '2014-04-16 12:44:40.614', 2, 'PUBLIC-LOG-000011', 2, 'Mark', '1121321', '508-8762347', 1, 1, 6, 'John', '21321321', '212321312', 'M', 5, '1980-02-03', 1, NULL, NULL, 'User', NULL, 1, NULL, '1990-01-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO abuse_report (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim_id, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship_id, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need_id, comunication_need_comment, client_guardian_name, client_guardian_address, client_guardian_relationship_id, client_guardian_telephone, currently_served_by_id, currently_served_by_comment, collateral_contacts_notification, type_of_service_id, type_of_service_comment, is_victim_aware, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, date_of_last_incident, disposition_letter, decision_letter, appeal_letter) VALUES (23, '2014-04-16', '2014-04-16 13:54:06.435', 1, 'PUBLIC-LOG-000023', 5, 'User', '121321321', '1232131232', 1, 1, 6, 'John', '2131231', NULL, 'M', NULL, '1980-02-03', 1, NULL, NULL, 'Mark', NULL, 1, NULL, '1990-01-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2341 (class 0 OID 16435)
-- Dependencies: 171
-- Data for Name: abuse_report_disability; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (60, '2014-04-27', '2014-04-27 17:13:40.397', 2, 'Dysosmia', 'Dysosmia', 8, 47);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (61, '2014-04-27', '2014-04-27 17:13:40.397', 3, 'Hyperosmia', 'Hyperosmia', 8, 47);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (62, '2014-04-27', '2014-04-27 17:13:40.397', 16, 'Bilateral vestibulopathy', 'Bilateral vestibulopathy', 8, 47);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (63, '2014-04-27', '2014-04-27 17:13:40.397', 17, 'meningitis', 'meningitis', 8, 47);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (79, '2014-04-28', '2014-04-28 10:39:19.569', 1, 'Anosmia ', 'Anosmia ', 6, 53);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (80, '2014-04-28', '2014-04-28 10:39:19.569', 2, 'Dysosmia', 'Dysosmia', 6, 53);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (81, '2014-04-28', '2014-04-28 10:39:19.569', 3, 'Hyperosmia', 'Hyperosmia', 6, 53);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (85, '2014-04-28', '2014-04-28 20:31:47.599', 1, 'Anosmia ', 'Anosmia ', 6, 55);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (86, '2014-04-28', '2014-04-28 20:31:47.599', 2, 'Dysosmia', 'Dysosmia', 6, 55);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (87, '2014-04-28', '2014-04-28 20:31:47.599', 3, 'Hyperosmia', 'Hyperosmia', 6, 55);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (91, '2014-04-28', '2014-04-28 21:03:27.978', 1, 'Anosmia ', 'Anosmia ', 6, 57);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (92, '2014-04-28', '2014-04-28 21:03:27.978', 2, 'Dysosmia', 'Dysosmia', 6, 57);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (93, '2014-04-28', '2014-04-28 21:03:27.978', 3, 'Hyperosmia', 'Hyperosmia', 6, 57);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (97, '2014-04-28', '2014-04-28 21:10:53.284', 1, 'Anosmia ', 'Anosmia ', 6, 59);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (98, '2014-04-28', '2014-04-28 21:10:53.284', 2, 'Dysosmia', 'Dysosmia', 6, 59);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (99, '2014-04-28', '2014-04-28 21:10:53.284', 3, 'Hyperosmia', 'Hyperosmia', 6, 59);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (100, '2014-04-28', '2014-04-28 21:27:34.799', 1, 'Anosmia ', 'Anosmia ', 6, 60);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (101, '2014-04-28', '2014-04-28 21:27:34.799', 2, 'Dysosmia', 'Dysosmia', 6, 60);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (102, '2014-04-28', '2014-04-28 21:27:34.799', 3, 'Hyperosmia', 'Hyperosmia', 6, 60);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (106, '2014-04-28', '2014-04-28 22:48:05.023', 1, 'Anosmia ', 'Anosmia ', 6, 63);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (107, '2014-04-28', '2014-04-28 22:48:05.023', 2, 'Dysosmia', 'Dysosmia', 6, 63);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (108, '2014-04-28', '2014-04-28 22:48:05.023', 3, 'Hyperosmia', 'Hyperosmia', 6, 63);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (109, '2014-04-28', '2014-04-28 22:50:43.515', 1, 'Anosmia ', 'Anosmia ', 6, 64);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (110, '2014-04-28', '2014-04-28 22:50:43.515', 2, 'Dysosmia', 'Dysosmia', 6, 64);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (111, '2014-04-28', '2014-04-28 22:50:43.515', 3, 'Hyperosmia', 'Hyperosmia', 6, 64);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (112, '2014-04-29', '2014-04-29 15:12:32.586', 1, 'Anosmia ', 'Anosmia ', 6, 65);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (113, '2014-04-29', '2014-04-29 15:12:32.586', 2, 'Dysosmia', 'Dysosmia', 6, 65);
INSERT INTO abuse_report_disability (id, created, modified, disability_id, disability_name, disability_comment, patient_id, abusereport_id) VALUES (114, '2014-04-29', '2014-04-29 15:12:32.586', 3, 'Hyperosmia', 'Hyperosmia', 6, 65);


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 172
-- Name: abuse_report_disability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('abuse_report_disability_id_seq', 114, true);


--
-- TOC entry 2343 (class 0 OID 16445)
-- Dependencies: 173
-- Data for Name: abuse_report_frequency_of_abuse; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--



--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 174
-- Name: abuse_report_frequency_of_abuse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('abuse_report_frequency_of_abuse_id_seq', 1, false);


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 175
-- Name: abuse_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('abuse_report_id_seq', 23, true);


--
-- TOC entry 2346 (class 0 OID 16457)
-- Dependencies: 176
-- Data for Name: abuse_report_type_of_abuse; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--



--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 177
-- Name: abuse_report_type_of_abuse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('abuse_report_type_of_abuse_id_seq', 1, false);


--
-- TOC entry 2384 (class 0 OID 24587)
-- Dependencies: 214
-- Data for Name: abusereport; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (59, '2014-04-28', '2014-04-29 12:37:19.641', 5, 'PUBLIC-LOG-000059', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 6, 'John rafael Doe', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'TTY', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '1', 'Institutional 
', 'Physical', 'Daily 
', 'Yes', '2014-04-28', '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', NULL, NULL, NULL, '2014-05-29');
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (47, '2014-04-27', '2014-04-29 12:41:11.346', 3, 'PUBLIC-LOG-000047', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 8, 'Miguel Angel Sorriano', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'asa', 5, 'User Name', '13 sdafads', NULL, NULL, 2, 'Dept. of Developmental Svcs. 
', '1', 'Institutional 
', 'adosnjanlakn', 'Daily 
', 'Yes', NULL, '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', 'Driver_Manual_0712.pdf', 'labsafetytraining.pdf', 'ice cream social.pdf', NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (55, '2014-04-28', '2014-04-29 12:31:20.614', 5, 'PUBLIC-LOG-000055', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 6, 'John rafael Doe', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'Sign Interpreter', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '1', 'Institutional 
', 'Physical', 'Daily 
', 'Yes', NULL, '1', '1', '1', '1', '213213212133', 'Yes', '', 'Yes', '', 'mqphadnbook.pdf', 'ice cream social.pdf', NULL, '2014-05-29');
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (57, '2014-04-28', '2014-04-29 12:36:08.361', 5, 'PUBLIC-LOG-000057', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 6, 'John rafael Doe', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'TTY', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '121', 'Institutional 
', 'Physical', 'Daily 
', 'Yes', NULL, '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', 'ice cream social.pdf', 'ice cream social.pdf', NULL, '2014-05-29');
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (63, '2014-04-28', '2014-04-29 15:13:49.711', 2, 'PUBLIC-LOG-000063', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 6, 'John rafael Doe', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'Sign Interpreter', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '2321', 'Institutional 
', 'Physical', 'Daily 
', 'Yes', NULL, '21323', '21321', '33213', '123', '21321', 'Yes', '', 'Yes', '', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (60, '2014-04-28', '2014-04-29 15:26:19.475', 1, 'PUBLIC-LOG-000060', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 6, 'John rafael Doe', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'something else', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '1213213123', 'Institutional 
', 'Sexual', 'Daily 
', 'Yes', NULL, '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (65, '2014-04-29', '2014-04-29 15:27:55.024', 1, 'PUBLIC-LOG-000065', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 6, 'John rafael Doe', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'something else', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '213213213', 'Institutional 
', 'Sexual', 'Daily 
', 'Yes', NULL, '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (53, '2014-04-28', '2014-04-28 16:13:16.254', 2, 'PUBLIC-LOG-000053', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 6, 'John rafael Doe', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'Sign Interpreter', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '1', 'Institutional 
', 'Something', 'Daily 
', 'Yes', NULL, '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (24, '2014-04-26', '2014-04-28 17:59:28.059', 4, 'PUBLIC-LOG-000024', 2, 'Mark Twain', '12asdfad', '508-8762347', 'No', 'Step-brother', 8, 'Miguel Angel Sorriano', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 5, 'User', '13 sdafads', 'Brother', NULL, '1980-02-01', '1232131232', 'Sign Interpreter', 5, 'User Name', '13 sdafads', NULL, NULL, 2, 'Dept. of Developmental Svcs. 
', '1', 'Institutional 
', 'Physical', 'Daily 
', 'Yes', NULL, '1', '1', '2', '3', '2', 'No', NULL, 'Yes', '', 'ice cream social.pdf', 'ice cream social.pdf', NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (15, '2014-04-20', '2014-04-28 16:13:05.042', 1, 'PUBLIC-LOG-000015', 5, 'User', NULL, '1232131232', 'Yes', 'Brother', 8, 'Miguel', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, 6, NULL, 'John', '79 Wester Avenue', 'Sister', NULL, '1980-01-01', NULL, 'TTY', 5, 'User', NULL, NULL, NULL, 2, 'Dept. of Developmental Svcs. 
', '12', 'Institutional 
', 'Physical', 'Daily 
', 'Yes', '2010-03-03', '1', '1', '1', '1', '1', 'Yes', '2010-03-03', 'No', NULL, NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (64, '2014-04-28', '2014-04-29 00:51:06.033', 2, 'PUBLIC-LOG-000064', 2, 'Mark Twain', '12asdfad', '508-8762347', 'Yes', 'Brother', 6, 'John rafael Doe', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'TTY', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '21321', 'Institutional 
', 'Physical', 'Daily 
', 'Yes', NULL, '213', '21313', '21313', '21321', '3213123', 'Yes', '', 'Yes', '', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter, due_date) VALUES (18, '2014-04-20', '2014-04-29 11:20:33.679', 3, 'PUBLIC-LOG-000018', 5, 'User Name', '13 sdafads', '1232131232', 'Yes', 'Brother', NULL, 'User', '13 sdafads', '1232131232', 'M', 5, '1980-02-01', 0, 6, NULL, 'John rafael Doe', '79 Wester Avenue', 'Brother', NULL, '1980-01-01', NULL, 'otherthing', 2, 'Mark Twain', '12asdfad', NULL, NULL, 1, 'Dept. of Mental Health 
', '123', 'Institutional 
', 'something', 'Increasing 

', 'Yes', NULL, '1212', '21', '212', '121', '22121321321', 'Yes', '', 'Yes', '', 'labsafetytraining.pdf', NULL, NULL, NULL);


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 213
-- Name: abusereport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('abusereport_id_seq', 65, true);


--
-- TOC entry 2349 (class 0 OID 16476)
-- Dependencies: 179
-- Data for Name: comunication_need; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO comunication_need (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:08:54.916424', 1, 'Other', 'Other', 3);
INSERT INTO comunication_need (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:08:25.427833', 1, 'TTY', 'TTY
', 1);
INSERT INTO comunication_need (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:08:42.945229', 1, 'Sign Interpreter', 'Sign Interpreter
', 2);


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 180
-- Name: comunication_need_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('comunication_need_id_seq', 3, true);


--
-- TOC entry 2351 (class 0 OID 16487)
-- Dependencies: 181
-- Data for Name: currently_served_by; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:09:33.091758', 1, 'Dept. of Mental Health 
', 'Dept. of Mental Health 
', 1);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:09:48.780928', 1, 'Dept. of Developmental Svcs. 
', 'Dept. of Developmental Svcs. 
', 2);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:09:59.13548', 1, 'Mass. Rehab. Comm. 
', 'Mass. Rehab. Comm. 
', 3);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:10:11.221233', 1, 'Dept. of Correction 
', 'Dept. of Correction 
', 4);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:10:23.538554', 1, 'Dept. of Public Health 
', 'Dept. of Public Health 
', 5);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:10:35.268302', 1, 'Mass Comm./Blind
', 'Mass Comm./Blind
', 6);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:10:46.764698', 1, 'Mass. Comm./Deaf/HH
', 'Mass. Comm./Deaf/HH
', 7);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:10:57.531832', 1, 'Unknown
', 'Unknown
', 8);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:11:46.436107', 1, 'Other
', 'Other
', 9);
INSERT INTO currently_served_by (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:16:27.564098', 1, 'None', 'None', 10);


--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 182
-- Name: currently_served_by_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('currently_served_by_id_seq', 14, true);


--
-- TOC entry 2353 (class 0 OID 16498)
-- Dependencies: 183
-- Data for Name: disability; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (1, '2014-03-10', '2014-03-10 19:21:35.570379', 1, 'Anosmia ', 'Anosmia ', 4);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (2, '2014-03-10', '2014-03-10 19:22:02.505992', 1, 'Dysosmia', 'Dysosmia', 4);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (3, '2014-03-10', '2014-03-10 19:22:07.763961', 1, 'Hyperosmia', 'Hyperosmia', 4);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (4, '2014-03-10', '2014-03-10 19:22:16.828112', 1, 'Hyposmia', 'Hyposmia', 4);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (5, '2014-03-10', '2014-03-10 19:22:29.476001', 1, 'Olfactory Reference Syndrome', 'Olfactory Reference Syndrome', 4);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (6, '2014-03-10', '2014-03-10 19:22:40.684233', 1, 'Parosmia', 'Parosmia', 4);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (7, '2014-03-10', '2014-03-10 19:22:51.011936', 1, 'Phantosmia', 'Phantosmia', 4);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (8, '2014-03-10', '2014-03-10 19:23:17.84422', 1, 'Vertigo', 'Vertigo', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (9, '2014-03-10', '2014-03-10 19:23:25.562481', 1, 'Disequilibrium', 'Disequilibrium', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (10, '2014-03-10', '2014-03-10 19:23:33.124232', 1, 'Pre-syncope ', 'Pre-syncope ', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (11, '2014-03-10', '2014-03-10 19:23:47.10798', 1, 'Benign Paroxysmal Positional Vertigo', 'Benign Paroxysmal Positional Vertigo', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (12, '2014-03-10', '2014-03-10 19:23:59.96252', 1, 'Labyrinthitis', 'Labyrinthitis', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (13, '2014-03-10', '2014-03-10 19:24:09.322436', 1, 'Ménière''s disease ', 'Ménière''s disease ', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (14, '2014-03-10', '2014-03-10 19:24:18.690521', 1, 'Perilymph fistula', 'Perilymph fistula', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (15, '2014-03-10', '2014-03-10 19:24:26.836074', 1, 'Superior canal dehiscence syndrome ', 'Superior canal dehiscence syndrome ', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (16, '2014-03-10', '2014-03-10 19:24:34.162468', 1, 'Bilateral vestibulopathy', 'Bilateral vestibulopathy', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (17, '2014-03-10', '2014-03-10 19:24:46.732297', 1, 'meningitis', 'meningitis', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (18, '2014-03-10', '2014-03-10 19:24:57.412121', 1, 'encephalitis', 'encephalitis', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (19, '2014-03-10', '2014-03-10 19:25:10.420234', 1, 'Cogan syndrome', 'Cogan syndrome', 6);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (20, '2014-03-10', '2014-03-10 19:25:39.746409', 1, 'oral language development', 'oral language development', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (21, '2014-03-10', '2014-03-10 19:25:59.314516', 1, 'Deficits in memory skills', 'Deficits in memory skills', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (22, '2014-03-10', '2014-03-10 19:26:09.0046', 1, 'Difficulty learning social rules', 'Difficulty learning social rules', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (23, '2014-03-10', '2014-03-10 19:26:18.916063', 1, 'Difficulty with problem solving skills', 'Difficulty with problem solving skills', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (24, '2014-03-10', '2014-03-10 19:26:29.636051', 1, 'Delays in the development of adaptive behaviors such as self-help or self-care skills', 'Delays in the development of adaptive behaviors such as self-help or self-care skills', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (25, '2014-03-10', '2014-03-10 19:26:38.235985', 1, 'Lack of social inhibitors', 'Lack of social inhibitors', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (26, '2014-03-11', '2014-03-11 09:38:21.916729', 1, 'Mental Retardation 
', 'Mental Retardation 
', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (27, '2014-03-11', '2014-03-11 09:39:09.212781', 1, 'Mental Illness
', 'Mental Illness
', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (28, '2014-03-11', '2014-03-11 09:39:58.348944', 1, 'Mobility 
', 'Mobility 
', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (29, '2014-03-11', '2014-03-11 09:40:12.236946', 1, 'Head Injury
', 'Head Injury
', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (30, '2014-03-11', '2014-03-11 09:40:24.756689', 1, 'Visual 
', 'Visual 
', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (31, '2014-03-11', '2014-03-11 09:40:37.996863', 1, 'Deaf / Hard of Hearing
', 'Deaf / Hard of Hearing
', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (32, '2014-03-11', '2014-03-11 09:40:51.860834', 1, 'Cerebral Palsy 
', 'Cerebral Palsy 
', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (33, '2014-03-11', '2014-03-11 09:41:05.165352', 1, 'Multiple Sclerosis
', 'Multiple Sclerosis
', 7);
INSERT INTO disability (id, created, modified, status, disability_name, description, disability_type_id) VALUES (34, '2014-03-11', '2014-03-11 09:41:18.388812', 1, 'Seizures 
', 'Seizures 
', 7);


--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 184
-- Name: disability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('disability_id_seq', 34, true);


--
-- TOC entry 2355 (class 0 OID 16510)
-- Dependencies: 185
-- Data for Name: disability_patient; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO disability_patient (id, created, modified, disability_id, patient_id) VALUES (3, '2014-03-12', '2014-03-12 19:52:50.137626', 1, 6);
INSERT INTO disability_patient (id, created, modified, disability_id, patient_id) VALUES (4, '2014-03-12', '2014-03-12 19:52:56.705908', 2, 6);
INSERT INTO disability_patient (id, created, modified, disability_id, patient_id) VALUES (5, '2014-03-12', '2014-03-12 19:53:02.193515', 3, 6);
INSERT INTO disability_patient (id, created, modified, disability_id, patient_id) VALUES (6, '2014-04-26', '2014-04-26 18:18:38.451', 2, 8);
INSERT INTO disability_patient (id, created, modified, disability_id, patient_id) VALUES (7, '2014-04-26', '2014-04-26 18:18:43.546', 3, 8);
INSERT INTO disability_patient (id, created, modified, disability_id, patient_id) VALUES (8, '2014-04-26', '2014-04-26 18:19:00.803', 16, 8);
INSERT INTO disability_patient (id, created, modified, disability_id, patient_id) VALUES (9, '2014-04-26', '2014-04-26 18:19:05.899', 17, 8);


--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 186
-- Name: disability_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('disability_patient_id_seq', 9, true);


--
-- TOC entry 2357 (class 0 OID 16517)
-- Dependencies: 187
-- Data for Name: disabiltity_type; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (1, '2014-03-10', '2014-03-10 19:18:50.490033', 'Physical disability');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (2, '2014-03-10', '2014-03-10 19:18:59.739256', 'Sensory disability');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (3, '2014-03-10', '2014-03-10 19:19:07.659339', 'Vision impairment');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (4, '2014-03-10', '2014-03-10 19:19:15.139389', 'Olfactory and gustatory impairment');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (5, '2014-03-10', '2014-03-10 19:19:22.4021', 'Somatosensory impairment');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (6, '2014-03-10', '2014-03-10 19:19:29.266074', 'Balance disorder');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (7, '2014-03-10', '2014-03-10 19:19:35.41804', 'Intellectual disability');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (8, '2014-03-10', '2014-03-10 19:19:41.778359', 'Mental health and emotional disabilities');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (9, '2014-03-10', '2014-03-10 19:19:48.65135', 'Developmental disability');
INSERT INTO disabiltity_type (id, created, modified, name_disabiltity_type) VALUES (10, '2014-03-10', '2014-03-10 19:19:55.795395', 'Nonvisible disabilities');


--
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 188
-- Name: disabiltity_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('disabiltity_type_id_seq', 10, true);


--
-- TOC entry 2359 (class 0 OID 16527)
-- Dependencies: 189
-- Data for Name: drug; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (1, '2014-03-10', '2014-03-10 18:52:48.820899', 1, 'Abacavir Sulfate (Ziagen)- FDA', 'WARNING
RISK OF HYPERSENSITIVITY REACTIONS, LACTIC ACIDOSIS, AND SEVERE HEPATOMEGALY
Hypersensitivity Reactions: Serious and sometimes fatal hypersensitivity reactions have been associated with ZIAGEN® (abacavir sulfate).
Hypersensitivity to abacavir is a multi-organ clinical syndrome usually characterized by a sign or symptom in 2 or more of the following groups: (1) fever, (2) rash, (3) gastrointestinal (including nausea, vomiting, diarrhea, or abdominal pain), (4) constitutional (including generalized malaise, fatigue, or achiness), and (5) respiratory (including dyspnea, cough, or pharyngitis). Discontinue ZIAGEN as soon as a hypersensitivity reaction is suspected.
Patients who carry the HLA-B*5701 allele are at high risk for experiencing a hypersensitivity reaction to abacavir. Prior to initiating therapy with abacavir, screening for the HLA-B*5701 allele is recommended; this approach has been found to decrease the risk of hypersensitivity reaction. Screening is also recommended prior to reinitiation of abacavir in patients of unknown HLA-B*5701 status who have previously tolerated abacavir. HLA-B*5701-negative patients may develop a suspected hypersensitivity reaction to abacavir; however, this occurs significantly less frequently than in HLA-B*5701-positive patients.
Regardless of HLA-B*5701 status, permanently discontinue ZIAGEN if hypersensitivity cannot be ruled out, even when other diagnoses are possible.
Following a hypersensitivity reaction to abacavir, NEVER restart ZIAGEN or any other abacavir-containing product because more severe symptoms can occur within hours and may include life-threatening hypotension and death.
Reintroduction of ZIAGEN or any other abacavir-containing product, even in patients who have no identified history or unrecognized symptoms of hypersensitivity to abacavir therapy, can result in serious or fatal hypersensitivity reactions. Such reactions can occur within hours [see WARNINGS AND PRECAUTIONS].
Lactic Acidosis and Severe Hepatomegaly: Lactic acidosis and severe hepatomegaly with steatosis, including fatal cases, have been reported with the use of nucleoside analogues alone or in combination, including ZIAGEN and other antiretrovirals [see WARNINGS AND PRECAUTIONS].');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (2, '2014-03-10', '2014-03-10 18:54:46.955654', 1, 'Accolate (Zafirlukast)- FDA', 'Zafirlukast is a synthetic, selective peptide leukotriene receptor antagonist (LTRA), with the chemical name 4(5-cyclopentyloxy-carbonylamino-1-methyl-indol-3ylmethyl)-3-methoxy-N-o-tolylsulfonylbenzamide. The molecular weight of zafirlukast is 575.7 and the structural formula i The empirical formula is: C31H33N3O6S

Zafirlukast, a fine white to pale yellow amorphous powder, is practically insoluble in water. It is slightly soluble in methanol and freely soluble in tetrahydrofuran, dimethylsulfoxide, and acetone.

ACCOLATE is supplied as 10 and 20 mg tablets for oral administration.

Inactive Ingredients: Film-coated tablets containing croscarmellose sodium, lactose, magnesium stearate, microcrystalline cellulose, povidone, hypromellose, and titanium dioxide.s:');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (3, '2014-03-10', '2014-03-10 18:56:45.24375', 1, 'Accutane', 'Accutane');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (4, '2014-03-10', '2014-03-10 18:58:28.996896', 1, 'Aceon', 'Aceon');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (5, '2014-03-10', '2014-03-10 18:58:30.459468', 1, 'Soriatane', 'Soriatane');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (6, '2014-03-10', '2014-03-10 18:58:31.876883', 1, 'Actonel', 'Actonel');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (7, '2014-03-10', '2014-03-10 18:58:33.843995', 1, 'Azor', 'Azor');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (8, '2014-03-10', '2014-03-10 18:59:34.612807', 1, 'Azopt', 'Azopt');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (9, '2014-03-10', '2014-03-10 18:59:36.331863', 1, 'Zithromax', 'Zithromax');
INSERT INTO drug (id, created, modified, status, drug_name, description) VALUES (10, '2014-03-10', '2014-04-29 17:04:42.353', 1, 'Azilect', 'Azilect');


--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 190
-- Name: drug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('drug_id_seq', 14, true);


--
-- TOC entry 2361 (class 0 OID 16539)
-- Dependencies: 191
-- Data for Name: drug_patient; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--



--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 192
-- Name: drug_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('drug_patient_id_seq', 1, false);


--
-- TOC entry 2363 (class 0 OID 16546)
-- Dependencies: 193
-- Data for Name: ethnicity; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO ethnicity (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:29:01.812496', 1, 'Caucasian 
', 'Caucasian 
', 1);
INSERT INTO ethnicity (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:29:17.307362', 1, 'Hispanic
', 'Hispanic
', 2);
INSERT INTO ethnicity (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:29:25.187348', 1, 'Asian
', 'Asian
', 3);
INSERT INTO ethnicity (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:29:42.451736', 1, 'African American 
', 'African American 
', 4);
INSERT INTO ethnicity (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:29:53.339345', 1, 'Native American
', 'Native American
', 5);
INSERT INTO ethnicity (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:30:02.29145', 1, 'Other
', 'Other
', 6);


--
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 194
-- Name: ethnicity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('ethnicity_id_seq', 6, true);


--
-- TOC entry 2365 (class 0 OID 16557)
-- Dependencies: 195
-- Data for Name: frequency_of_abuse; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO frequency_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:30:23.067509', 1, 'Daily 
', 'Daily 
', 1);
INSERT INTO frequency_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:30:52.340338', 1, 'Increasing 

', 'Increasing 
', 2);
INSERT INTO frequency_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:31:00.747484', 1, 'Weekly 
', 'Weekly 
', 3);
INSERT INTO frequency_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:31:10.811366', 1, 'Decreasing 
', 'Decreasing 
', 4);
INSERT INTO frequency_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:31:19.797237', 1, 'Episodic 
', 'Episodic 
', 5);
INSERT INTO frequency_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:31:45.651451', 1, 'Constant 
', 'Constant 
', 6);
INSERT INTO frequency_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:32:53.468233', 1, 'Unknown 
', 'Unknown 
', 7);


--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 196
-- Name: frequency_of_abuse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('frequency_of_abuse_id_seq', 7, true);


--
-- TOC entry 2367 (class 0 OID 16568)
-- Dependencies: 197
-- Data for Name: group_home; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO group_home (created, modified, status, master_data_name, description, id, address, healthcareorg_id) VALUES ('2014-03-12', '2014-03-12 10:50:01.439586', 1, 'Group Home #1', 'People with mental problems', 1, '79 Wester Avenue', 1);
INSERT INTO group_home (created, modified, status, master_data_name, description, id, address, healthcareorg_id) VALUES ('2014-03-12', '2014-03-12 10:50:36.35127', 1, 'Group Home #2', 'People with motor disability', 2, 'Park avenue', 1);


--
-- TOC entry 2434 (class 0 OID 0)
-- Dependencies: 198
-- Name: group_home_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('group_home_id_seq', 3, true);


--
-- TOC entry 2369 (class 0 OID 16579)
-- Dependencies: 199
-- Data for Name: healthcareorg; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO healthcareorg (created, modified, status, master_data_name, description, id, zipcode, address, state) VALUES ('2014-03-13', '2014-03-13 13:54:13.778948', 1, 'Health Care Org', 'Health Care Org', 1, '010605', '79 Park AV.', 'Massachussetts');


--
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 200
-- Name: healthcareorg_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('healthcareorg_id_seq', 1, true);


--
-- TOC entry 2371 (class 0 OID 16590)
-- Dependencies: 201
-- Data for Name: marital_status; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO marital_status (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 15:44:44.865871', 1, 'Married', 'Married', 1);
INSERT INTO marital_status (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 15:44:54.777887', 1, 'Divorced', 'Divorced', 2);
INSERT INTO marital_status (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 15:45:01.761829', 1, 'Single', 'Single', 3);
INSERT INTO marital_status (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 15:45:13.994981', 1, 'Other', 'Other', 4);


--
-- TOC entry 2436 (class 0 OID 0)
-- Dependencies: 202
-- Name: marital_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('marital_status_id_seq', 4, true);


--
-- TOC entry 2348 (class 0 OID 16467)
-- Dependencies: 178
-- Data for Name: master_data; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--



--
-- TOC entry 2373 (class 0 OID 16601)
-- Dependencies: 203
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO patient (id, created, modified, status, patient_name, patient_midname, patient_last_name, patient_log_number, iq, birthdate, sex, telephone, marital_status_id, group_home_id, currently_served_by_id, client_guardian_id, ethnicity_id) VALUES (6, '2014-03-10', '2014-04-19 18:22:31.942', 1, 'John', 'rafael', 'Doe', 'PATIENT-000006', 71, '1980-01-01', 'M', NULL, 2, 1, 1, 2, 1);
INSERT INTO patient (id, created, modified, status, patient_name, patient_midname, patient_last_name, patient_log_number, iq, birthdate, sex, telephone, marital_status_id, group_home_id, currently_served_by_id, client_guardian_id, ethnicity_id) VALUES (7, '2014-03-10', '2014-04-19 18:22:34.341', 1, 'Michael', 'sd', 'Stype', 'PATIENT-000007', 21, '1980-01-01', 'M', NULL, 2, 1, 1, 5, 2);
INSERT INTO patient (id, created, modified, status, patient_name, patient_midname, patient_last_name, patient_log_number, iq, birthdate, sex, telephone, marital_status_id, group_home_id, currently_served_by_id, client_guardian_id, ethnicity_id) VALUES (8, '2014-03-10', '2014-04-19 18:22:34.718', 1, 'Miguel', 'Angel', 'Sorriano', 'PATIENT-000008', 2, '1980-01-01', 'M', NULL, 2, 1, 2, 5, 3);
INSERT INTO patient (id, created, modified, status, patient_name, patient_midname, patient_last_name, patient_log_number, iq, birthdate, sex, telephone, marital_status_id, group_home_id, currently_served_by_id, client_guardian_id, ethnicity_id) VALUES (10, '2014-03-10', '2014-04-19 18:22:36.176', 1, 'Dexter', 'A', 'Morgan', 'PATIENT-000010', 71, '1980-01-01', 'M', NULL, 2, 1, 1, 2, 4);


--
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 204
-- Name: patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('patient_id_seq', 10, true);


--
-- TOC entry 2375 (class 0 OID 16615)
-- Dependencies: 205
-- Data for Name: relationship; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:26:33.610164', 1, 'Brother', 'Brother', 1);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:26:44.95429', 1, 'Sister', 'Sister', 2);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:26:51.986263', 1, 'Father', 'Father', 3);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:26:58.778974', 1, 'Mother', 'Mother', 4);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:27:13.850438', 1, 'Step-brother', 'Step-brother', 5);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:27:26.906477', 1, 'Step-sister', 'Step-sister', 6);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:27:54.610352', 1, 'Step-Father', 'Step-Father', 7);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:28:07.331037', 1, 'Step-Mother', 'Step-Mother', 8);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:28:59.6105', 1, 'Cousin', NULL, 9);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:29:06.650524', 1, 'Wife', NULL, 10);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:29:11.32331', 1, 'Husband', NULL, 11);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:29:20.234358', 1, 'Grand-mother', NULL, 12);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:29:37.82624', 1, 'Grand-father', NULL, 13);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:29:42.874946', 1, 'Friend', NULL, 14);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 16:29:59.842527', 1, 'Supervisor', NULL, 15);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-04-17', '2014-04-17 20:31:53.363', 1, 'Staff', NULL, 16);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-04-17', '2014-04-17 20:32:10.262', 1, 'Colleague', NULL, 17);
INSERT INTO relationship (created, modified, status, master_data_name, description, id) VALUES ('2014-04-17', '2014-04-17 20:32:17.976', 1, 'Other', NULL, 18);


--
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 206
-- Name: relationship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('relationship_id_seq', 18, true);


--
-- TOC entry 2377 (class 0 OID 16626)
-- Dependencies: 207
-- Data for Name: system_user; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO system_user (id, created, modified, user_type, status, user_name, user_last_name, login, login_password, social_security, telephone, birthdate, marital_status_id, supervisor_id, user_address, sex) VALUES (1, '2014-03-10', '2014-04-19 17:58:46.118', 1, 1, 'John', 'Doe', 'Administrator', '321', NULL, '508-8762345', '1980-01-01', 1, NULL, '24 Trowbridge Rd, Worcester, MA, 01609', 'M');
INSERT INTO system_user (id, created, modified, user_type, status, user_name, user_last_name, login, login_password, social_security, telephone, birthdate, marital_status_id, supervisor_id, user_address, sex) VALUES (7, '2014-04-26', '2014-04-26 18:32:38.931', 2, 1, 'Mike', 'Smith', 'msmith', '123', NULL, '5082625986', '1980-02-03', 1, NULL, '24 Trowbridge Rd, Worcester, MA, 01609', 'M');
INSERT INTO system_user (id, created, modified, user_type, status, user_name, user_last_name, login, login_password, social_security, telephone, birthdate, marital_status_id, supervisor_id, user_address, sex) VALUES (2, '2014-03-10', '2014-04-27 16:12:30.338', 3, 1, 'Mark', 'Twain', 'mtwain', '123', NULL, '508-8762347', '1980-01-01', 1, NULL, '12asdfad', 'F');
INSERT INTO system_user (id, created, modified, user_type, status, user_name, user_last_name, login, login_password, social_security, telephone, birthdate, marital_status_id, supervisor_id, user_address, sex) VALUES (5, '2014-04-09', '2014-04-27 16:12:35.462', 3, 1, 'User', 'Name', 'cs509group1@wpi.edu', '123123', NULL, '1232131232', '1980-02-01', 1, NULL, '13 sdafads', 'M');
INSERT INTO system_user (id, created, modified, user_type, status, user_name, user_last_name, login, login_password, social_security, telephone, birthdate, marital_status_id, supervisor_id, user_address, sex) VALUES (9, '2014-04-29', '2014-04-29 12:15:40.022', 3, 1, 'hello', 'world', 'whello@gmail.com', '111111111', '21321321312', '21321321312', '2010-03-03', 1, NULL, '213213213', 'M');


--
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 208
-- Name: system_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('system_user_id_seq', 9, true);


--
-- TOC entry 2379 (class 0 OID 16640)
-- Dependencies: 209
-- Data for Name: type_of_abuse; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO type_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:33:43.499518', 1, 'Emotional', 'Emotional', 4);
INSERT INTO type_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:33:50.419899', 1, 'Other', 'Other', 5);
INSERT INTO type_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:33:18.875219', 1, 'Physical', 'Physical 
', 1);
INSERT INTO type_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:33:29.051259', 1, 'Omission', 'Omission
', 2);
INSERT INTO type_of_abuse (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:33:36.356243', 1, 'Sexual', 'Sexual 
', 3);


--
-- TOC entry 2440 (class 0 OID 0)
-- Dependencies: 210
-- Name: type_of_abuse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('type_of_abuse_id_seq', 5, true);


--
-- TOC entry 2381 (class 0 OID 16651)
-- Dependencies: 211
-- Data for Name: type_of_service; Type: TABLE DATA; Schema: public; Owner: abusereportuser
--

INSERT INTO type_of_service (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:22:27.459231', 1, 'Institutional 
', 'Institutional 
', 1);
INSERT INTO type_of_service (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:22:44.555306', 1, 'Residential 
', 'Residential 
', 2);
INSERT INTO type_of_service (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:22:54.720681', 1, 'Day Program 
', 'Day Program 
', 3);
INSERT INTO type_of_service (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:23:07.491363', 1, 'Case Management 
', 'Case Management 
', 4);
INSERT INTO type_of_service (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:23:21.851692', 1, 'Service Coordination
', 'Service Coordination
', 5);
INSERT INTO type_of_service (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:23:31.491449', 1, 'Foster / Spec. Home Care
', 'Foster / Spec. Home Care
', 6);
INSERT INTO type_of_service (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:25:28.747519', 1, 'Respite
', 'Respite
', 7);
INSERT INTO type_of_service (created, modified, status, master_data_name, description, id) VALUES ('2014-03-11', '2014-03-11 12:25:41.620217', 1, 'Other
', 'Other
', 8);


--
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 212
-- Name: type_of_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abusereportuser
--

SELECT pg_catalog.setval('type_of_service_id_seq', 8, true);


--
-- TOC entry 2111 (class 2606 OID 16714)
-- Name: abuse_report_disability_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY abuse_report_disability
    ADD CONSTRAINT abuse_report_disability_pkey PRIMARY KEY (id);


--
-- TOC entry 2113 (class 2606 OID 16716)
-- Name: abuse_report_frequency_of_abuse_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse
    ADD CONSTRAINT abuse_report_frequency_of_abuse_pkey PRIMARY KEY (id);


--
-- TOC entry 2109 (class 2606 OID 16718)
-- Name: abuse_report_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_pkey PRIMARY KEY (id);


--
-- TOC entry 2115 (class 2606 OID 16720)
-- Name: abuse_report_type_of_abuse_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY abuse_report_type_of_abuse
    ADD CONSTRAINT abuse_report_type_of_abuse_pkey PRIMARY KEY (id);


--
-- TOC entry 2167 (class 2606 OID 24601)
-- Name: abusereport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_pkey PRIMARY KEY (id);


--
-- TOC entry 2119 (class 2606 OID 16722)
-- Name: comunication_need_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY comunication_need
    ADD CONSTRAINT comunication_need_pkey PRIMARY KEY (id);


--
-- TOC entry 2121 (class 2606 OID 16724)
-- Name: currently_served_by_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY currently_served_by
    ADD CONSTRAINT currently_served_by_pkey PRIMARY KEY (id);


--
-- TOC entry 2123 (class 2606 OID 16726)
-- Name: disability_disability_name_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disability
    ADD CONSTRAINT disability_disability_name_key UNIQUE (disability_name);


--
-- TOC entry 2127 (class 2606 OID 16728)
-- Name: disability_patient_disability_id_patient_id_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disability_patient
    ADD CONSTRAINT disability_patient_disability_id_patient_id_key UNIQUE (disability_id, patient_id);


--
-- TOC entry 2129 (class 2606 OID 16730)
-- Name: disability_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disability_patient
    ADD CONSTRAINT disability_patient_pkey PRIMARY KEY (id);


--
-- TOC entry 2125 (class 2606 OID 16732)
-- Name: disability_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disability
    ADD CONSTRAINT disability_pkey PRIMARY KEY (id);


--
-- TOC entry 2131 (class 2606 OID 16734)
-- Name: disabiltity_type_name_disabiltity_type_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disabiltity_type
    ADD CONSTRAINT disabiltity_type_name_disabiltity_type_key UNIQUE (name_disabiltity_type);


--
-- TOC entry 2133 (class 2606 OID 16736)
-- Name: disabiltity_type_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY disabiltity_type
    ADD CONSTRAINT disabiltity_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2135 (class 2606 OID 16738)
-- Name: drug_drug_name_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_drug_name_key UNIQUE (drug_name);


--
-- TOC entry 2139 (class 2606 OID 16740)
-- Name: drug_patient_drug_id_patient_id_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY drug_patient
    ADD CONSTRAINT drug_patient_drug_id_patient_id_key UNIQUE (drug_id, patient_id);


--
-- TOC entry 2141 (class 2606 OID 16742)
-- Name: drug_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY drug_patient
    ADD CONSTRAINT drug_patient_pkey PRIMARY KEY (id);


--
-- TOC entry 2137 (class 2606 OID 16744)
-- Name: drug_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_pkey PRIMARY KEY (id);


--
-- TOC entry 2143 (class 2606 OID 16746)
-- Name: ethnicity_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY ethnicity
    ADD CONSTRAINT ethnicity_pkey PRIMARY KEY (id);


--
-- TOC entry 2145 (class 2606 OID 16748)
-- Name: frequency_of_abuse_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY frequency_of_abuse
    ADD CONSTRAINT frequency_of_abuse_pkey PRIMARY KEY (id);


--
-- TOC entry 2147 (class 2606 OID 16750)
-- Name: group_home_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY group_home
    ADD CONSTRAINT group_home_pkey PRIMARY KEY (id);


--
-- TOC entry 2149 (class 2606 OID 16752)
-- Name: healthcareorg_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY healthcareorg
    ADD CONSTRAINT healthcareorg_pkey PRIMARY KEY (id);


--
-- TOC entry 2151 (class 2606 OID 16754)
-- Name: marital_status_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY marital_status
    ADD CONSTRAINT marital_status_pkey PRIMARY KEY (id);


--
-- TOC entry 2117 (class 2606 OID 16756)
-- Name: master_data_master_data_name_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY master_data
    ADD CONSTRAINT master_data_master_data_name_key UNIQUE (master_data_name);


--
-- TOC entry 2153 (class 2606 OID 16758)
-- Name: patient_patient_log_number_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_patient_log_number_key UNIQUE (patient_log_number);


--
-- TOC entry 2155 (class 2606 OID 16760)
-- Name: patient_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);


--
-- TOC entry 2157 (class 2606 OID 16762)
-- Name: relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY relationship
    ADD CONSTRAINT relationship_pkey PRIMARY KEY (id);


--
-- TOC entry 2159 (class 2606 OID 16764)
-- Name: system_user_login_key; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT system_user_login_key UNIQUE (login);


--
-- TOC entry 2161 (class 2606 OID 16766)
-- Name: system_user_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT system_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2163 (class 2606 OID 16768)
-- Name: type_of_abuse_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY type_of_abuse
    ADD CONSTRAINT type_of_abuse_pkey PRIMARY KEY (id);


--
-- TOC entry 2165 (class 2606 OID 16770)
-- Name: type_of_service_pkey; Type: CONSTRAINT; Schema: public; Owner: abusereportuser; Tablespace: 
--

ALTER TABLE ONLY type_of_service
    ADD CONSTRAINT type_of_service_pkey PRIMARY KEY (id);


--
-- TOC entry 2226 (class 2620 OID 24719)
-- Name: create_abuse_report_disability_trg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER create_abuse_report_disability_trg AFTER INSERT ON abusereport FOR EACH ROW EXECUTE PROCEDURE create_abuse_report_disability();


--
-- TOC entry 2221 (class 2620 OID 16771)
-- Name: create_patient_log_trg; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER create_patient_log_trg AFTER INSERT ON patient FOR EACH ROW EXECUTE PROCEDURE create_patient_log();


--
-- TOC entry 2210 (class 2620 OID 16772)
-- Name: create_public_log_number_trg; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER create_public_log_number_trg AFTER INSERT ON abuse_report FOR EACH ROW EXECUTE PROCEDURE create_public_log_number();


--
-- TOC entry 2224 (class 2620 OID 24637)
-- Name: create_public_log_number_trg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER create_public_log_number_trg AFTER INSERT ON abusereport FOR EACH ROW EXECUTE PROCEDURE create_public_log_number();


--
-- TOC entry 2211 (class 2620 OID 16773)
-- Name: update_lastmodified_modtime_abuse_report; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_abuse_report BEFORE UPDATE ON abuse_report FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2212 (class 2620 OID 16774)
-- Name: update_lastmodified_modtime_abuse_report_disability; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_abuse_report_disability BEFORE UPDATE ON abuse_report_disability FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2213 (class 2620 OID 16775)
-- Name: update_lastmodified_modtime_abuse_report_frequency_of_abuse; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_abuse_report_frequency_of_abuse BEFORE UPDATE ON abuse_report_frequency_of_abuse FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2214 (class 2620 OID 16776)
-- Name: update_lastmodified_modtime_abuse_report_type_of_abuse; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_abuse_report_type_of_abuse BEFORE UPDATE ON abuse_report_type_of_abuse FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2225 (class 2620 OID 24638)
-- Name: update_lastmodified_modtime_abusereport; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_lastmodified_modtime_abusereport BEFORE UPDATE ON abusereport FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2216 (class 2620 OID 16777)
-- Name: update_lastmodified_modtime_disability; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_disability BEFORE UPDATE ON disability FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2217 (class 2620 OID 16778)
-- Name: update_lastmodified_modtime_disability_patient; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_disability_patient BEFORE UPDATE ON disability_patient FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2218 (class 2620 OID 16779)
-- Name: update_lastmodified_modtime_disabiltity_type; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_disabiltity_type BEFORE UPDATE ON disabiltity_type FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2219 (class 2620 OID 16780)
-- Name: update_lastmodified_modtime_drug; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_drug BEFORE UPDATE ON drug FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2220 (class 2620 OID 16781)
-- Name: update_lastmodified_modtime_drug_patient; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_drug_patient BEFORE UPDATE ON drug_patient FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2215 (class 2620 OID 16782)
-- Name: update_lastmodified_modtime_master_data; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_master_data BEFORE UPDATE ON master_data FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2222 (class 2620 OID 16783)
-- Name: update_lastmodified_modtime_patient; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_patient BEFORE UPDATE ON patient FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2223 (class 2620 OID 16784)
-- Name: update_lastmodified_modtime_system_user; Type: TRIGGER; Schema: public; Owner: abusereportuser
--

CREATE TRIGGER update_lastmodified_modtime_system_user BEFORE UPDATE ON system_user FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 2168 (class 2606 OID 16785)
-- Name: abuse_report_alleged_abuser_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_abuser_patient_id_fkey FOREIGN KEY (alleged_abuser_patient_id) REFERENCES patient(id);


--
-- TOC entry 2169 (class 2606 OID 16790)
-- Name: abuse_report_alleged_abuser_relationship_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_abuser_relationship_id_fkey FOREIGN KEY (alleged_abuser_relationship_id) REFERENCES relationship(id);


--
-- TOC entry 2170 (class 2606 OID 16795)
-- Name: abuse_report_alleged_abuser_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_abuser_staff_id_fkey FOREIGN KEY (alleged_abuser_staff_id) REFERENCES system_user(id);


--
-- TOC entry 2171 (class 2606 OID 16800)
-- Name: abuse_report_alleged_victim_marital_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_victim_marital_status_id_fkey FOREIGN KEY (alleged_victim_marital_status_id) REFERENCES marital_status(id);


--
-- TOC entry 2172 (class 2606 OID 16805)
-- Name: abuse_report_alleged_victim_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_victim_patient_id_fkey FOREIGN KEY (alleged_victim_patient_id) REFERENCES patient(id);


--
-- TOC entry 2173 (class 2606 OID 16810)
-- Name: abuse_report_alleged_victim_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_alleged_victim_staff_id_fkey FOREIGN KEY (alleged_victim_staff_id) REFERENCES system_user(id);


--
-- TOC entry 2174 (class 2606 OID 16815)
-- Name: abuse_report_client_guardian_relationship_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_client_guardian_relationship_id_fkey FOREIGN KEY (client_guardian_relationship_id) REFERENCES relationship(id);


--
-- TOC entry 2175 (class 2606 OID 16820)
-- Name: abuse_report_comunication_need_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_comunication_need_id_fkey FOREIGN KEY (comunication_need_id) REFERENCES comunication_need(id);


--
-- TOC entry 2176 (class 2606 OID 16825)
-- Name: abuse_report_currently_served_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_currently_served_by_id_fkey FOREIGN KEY (currently_served_by_id) REFERENCES currently_served_by(id);


--
-- TOC entry 2182 (class 2606 OID 24728)
-- Name: abuse_report_disability_abusereport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_disability
    ADD CONSTRAINT abuse_report_disability_abusereport_id_fkey FOREIGN KEY (abusereport_id) REFERENCES abusereport(id) ON DELETE CASCADE;


--
-- TOC entry 2180 (class 2606 OID 16835)
-- Name: abuse_report_disability_disability_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_disability
    ADD CONSTRAINT abuse_report_disability_disability_id_fkey FOREIGN KEY (disability_id) REFERENCES disability(id);


--
-- TOC entry 2181 (class 2606 OID 16840)
-- Name: abuse_report_disability_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_disability
    ADD CONSTRAINT abuse_report_disability_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2185 (class 2606 OID 24693)
-- Name: abuse_report_frequency_of_abuse_abusereport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse
    ADD CONSTRAINT abuse_report_frequency_of_abuse_abusereport_id_fkey FOREIGN KEY (abusereport_id) REFERENCES abusereport(id);


--
-- TOC entry 2183 (class 2606 OID 16850)
-- Name: abuse_report_frequency_of_abuse_frequency_of_abuse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse
    ADD CONSTRAINT abuse_report_frequency_of_abuse_frequency_of_abuse_id_fkey FOREIGN KEY (frequency_of_abuse_id) REFERENCES frequency_of_abuse(id);


--
-- TOC entry 2184 (class 2606 OID 16855)
-- Name: abuse_report_frequency_of_abuse_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_frequency_of_abuse
    ADD CONSTRAINT abuse_report_frequency_of_abuse_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2177 (class 2606 OID 16860)
-- Name: abuse_report_reporter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_reporter_id_fkey FOREIGN KEY (reporter_id) REFERENCES system_user(id);


--
-- TOC entry 2178 (class 2606 OID 16865)
-- Name: abuse_report_reporter_relationship_to_victim_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_reporter_relationship_to_victim_id_fkey FOREIGN KEY (reporter_relationship_to_victim_id) REFERENCES relationship(id);


--
-- TOC entry 2188 (class 2606 OID 24698)
-- Name: abuse_report_type_of_abuse_abusereport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_type_of_abuse
    ADD CONSTRAINT abuse_report_type_of_abuse_abusereport_id_fkey FOREIGN KEY (abusereport_id) REFERENCES abusereport(id);


--
-- TOC entry 2186 (class 2606 OID 16875)
-- Name: abuse_report_type_of_abuse_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_type_of_abuse
    ADD CONSTRAINT abuse_report_type_of_abuse_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2187 (class 2606 OID 16880)
-- Name: abuse_report_type_of_abuse_type_of_abuse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report_type_of_abuse
    ADD CONSTRAINT abuse_report_type_of_abuse_type_of_abuse_id_fkey FOREIGN KEY (type_of_abuse_id) REFERENCES type_of_abuse(id);


--
-- TOC entry 2179 (class 2606 OID 16885)
-- Name: abuse_report_type_of_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY abuse_report
    ADD CONSTRAINT abuse_report_type_of_service_id_fkey FOREIGN KEY (type_of_service_id) REFERENCES type_of_service(id);


--
-- TOC entry 2203 (class 2606 OID 24602)
-- Name: abusereport_alleged_abuser_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_alleged_abuser_patient_id_fkey FOREIGN KEY (alleged_abuser_patient_id) REFERENCES patient(id);


--
-- TOC entry 2204 (class 2606 OID 24607)
-- Name: abusereport_alleged_abuser_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_alleged_abuser_staff_id_fkey FOREIGN KEY (alleged_abuser_staff_id) REFERENCES system_user(id);


--
-- TOC entry 2205 (class 2606 OID 24612)
-- Name: abusereport_alleged_victim_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_alleged_victim_patient_id_fkey FOREIGN KEY (alleged_victim_patient_id) REFERENCES patient(id);


--
-- TOC entry 2206 (class 2606 OID 24617)
-- Name: abusereport_alleged_victim_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_alleged_victim_staff_id_fkey FOREIGN KEY (alleged_victim_staff_id) REFERENCES system_user(id);


--
-- TOC entry 2207 (class 2606 OID 24622)
-- Name: abusereport_client_guardian_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_client_guardian_id_fkey FOREIGN KEY (client_guardian_id) REFERENCES system_user(id);


--
-- TOC entry 2208 (class 2606 OID 24627)
-- Name: abusereport_currently_served_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_currently_served_by_id_fkey FOREIGN KEY (currently_served_by_id) REFERENCES currently_served_by(id);


--
-- TOC entry 2209 (class 2606 OID 24632)
-- Name: abusereport_reporter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_reporter_id_fkey FOREIGN KEY (reporter_id) REFERENCES system_user(id);


--
-- TOC entry 2189 (class 2606 OID 16890)
-- Name: disability_disability_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability
    ADD CONSTRAINT disability_disability_type_id_fkey FOREIGN KEY (disability_type_id) REFERENCES disabiltity_type(id);


--
-- TOC entry 2190 (class 2606 OID 16895)
-- Name: disability_patient_disability_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability_patient
    ADD CONSTRAINT disability_patient_disability_id_fkey FOREIGN KEY (disability_id) REFERENCES disability(id);


--
-- TOC entry 2191 (class 2606 OID 16900)
-- Name: disability_patient_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY disability_patient
    ADD CONSTRAINT disability_patient_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2192 (class 2606 OID 16905)
-- Name: drug_patient_drug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY drug_patient
    ADD CONSTRAINT drug_patient_drug_id_fkey FOREIGN KEY (drug_id) REFERENCES drug(id);


--
-- TOC entry 2193 (class 2606 OID 16910)
-- Name: drug_patient_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY drug_patient
    ADD CONSTRAINT drug_patient_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patient(id);


--
-- TOC entry 2194 (class 2606 OID 16915)
-- Name: group_home_healthcareorg_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY group_home
    ADD CONSTRAINT group_home_healthcareorg_id_fkey FOREIGN KEY (healthcareorg_id) REFERENCES healthcareorg(id);


--
-- TOC entry 2199 (class 2606 OID 24663)
-- Name: patient_client_guardian_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_client_guardian_id_fkey FOREIGN KEY (client_guardian_id) REFERENCES system_user(id);


--
-- TOC entry 2197 (class 2606 OID 24653)
-- Name: patient_currently_served_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_currently_served_by_id_fkey FOREIGN KEY (currently_served_by_id) REFERENCES currently_served_by(id);


--
-- TOC entry 2198 (class 2606 OID 24658)
-- Name: patient_currently_served_by_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_currently_served_by_id_fkey1 FOREIGN KEY (currently_served_by_id) REFERENCES currently_served_by(id);


--
-- TOC entry 2200 (class 2606 OID 24703)
-- Name: patient_ethnicity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_ethnicity_id_fkey FOREIGN KEY (ethnicity_id) REFERENCES ethnicity(id);


--
-- TOC entry 2195 (class 2606 OID 16920)
-- Name: patient_group_home_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_group_home_id_fkey FOREIGN KEY (group_home_id) REFERENCES group_home(id);


--
-- TOC entry 2196 (class 2606 OID 16925)
-- Name: patient_marital_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_marital_status_id_fkey FOREIGN KEY (marital_status_id) REFERENCES marital_status(id);


--
-- TOC entry 2201 (class 2606 OID 16930)
-- Name: system_user_marital_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT system_user_marital_status_id_fkey FOREIGN KEY (marital_status_id) REFERENCES marital_status(id);


--
-- TOC entry 2202 (class 2606 OID 16935)
-- Name: system_user_supervisor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abusereportuser
--

ALTER TABLE ONLY system_user
    ADD CONSTRAINT system_user_supervisor_id_fkey FOREIGN KEY (supervisor_id) REFERENCES system_user(id);


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-04-29 21:16:08

--
-- PostgreSQL database dump complete
--

