--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.4
-- Dumped by pg_dump version 9.3.4
-- Started on 2014-04-27 16:19:52

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

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
    appeal_letter character varying(255)
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
-- TOC entry 2100 (class 0 OID 0)
-- Dependencies: 213
-- Name: abusereport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE abusereport_id_seq OWNED BY abusereport.id;


--
-- TOC entry 1965 (class 2604 OID 24590)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport ALTER COLUMN id SET DEFAULT nextval('abusereport_id_seq'::regclass);


--
-- TOC entry 2095 (class 0 OID 24587)
-- Dependencies: 214
-- Data for Name: abusereport; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (15, '2014-04-20', '2014-04-20 22:20:00.601', 1, 'PUBLIC-LOG-000015', 5, 'User', NULL, '1232131232', 'Yes', 'Brother', 8, 'Miguel', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, 6, NULL, 'John', '79 Wester Avenue', 'Sister', NULL, '1980-01-01', NULL, 'TTY
', 5, 'User', NULL, NULL, NULL, 2, 'Dept. of Developmental Svcs. 
', '12', 'Institutional 
', 'Physical 
 Omission
 ', 'Daily 
', 'Yes', '2010-03-03', '1', '1', '1', '1', '1', 'Yes', '2010-03-03', 'No', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (20, '2014-04-20', '2014-04-20 23:03:54.631', 1, 'PUBLIC-LOG-000020', 5, 'User', NULL, '1232131232', 'Yes', 'Brother', 6, 'John', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, 6, NULL, 'John', '79 Wester Avenue', 'Brother', NULL, '1980-01-01', NULL, 'Sign Interpreter
', 2, 'Mark', NULL, NULL, NULL, 1, 'Dept. of Mental Health 
', '1', 'Institutional 
', 'Physical 
 Sexual 
 ', 'Daily 
', 'Yes', '2010-03-03', '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (23, '2014-04-24', '2014-04-24 20:15:06.862', 2, 'PUBLIC-LOG-000023', 2, 'Mark', NULL, '508-8762347', 'Yes', 'Brother', 7, 'Michael', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', NULL, 'Brother', NULL, '1980-01-01', '508-8762347', 'Sign Interpreter
', 5, 'User', NULL, NULL, NULL, 1, 'Dept. of Mental Health 
', '1', 'Institutional 
', 'Physical 
 Omission
 ', 'Daily 
', 'Yes', '2010-03-03', '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (24, '2014-04-26', '2014-04-26 17:37:32.683', 2, 'PUBLIC-LOG-000024', 2, 'Mark', NULL, '508-8762347', 'Yes', 'Brother', 8, 'Miguel', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 5, 'User', NULL, 'Brother', NULL, '1980-02-01', '1232131232', 'Sign Interpreter
', 5, 'User', NULL, NULL, NULL, 2, 'Dept. of Developmental Svcs. 
', '1', 'Institutional 
', 'Physical 
 Omission
 ', 'Daily 
', 'Yes', '2010-03-03', '1', '1', '2', '3', '2', 'No', NULL, 'Yes', '', NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (25, '2014-04-26', '2014-04-26 17:56:36.186', 2, 'PUBLIC-LOG-000025', 2, 'Mark', NULL, '508-8762347', 'Yes', 'Sister', 7, 'Michael', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 5, 'User', NULL, 'Brother', NULL, '1980-02-01', '1232131232', 'Other', 5, 'User', NULL, NULL, NULL, 1, 'Dept. of Mental Health 
', '1', 'Institutional 
', 'Physical 
 Omission
 ', 'Daily 
', 'Yes', '2010-03-03', '1', '1', '1', '1', '1', 'Yes', '2010-03-03', 'No', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (27, '2014-04-26', '2014-04-26 18:01:32.24', 2, 'PUBLIC-LOG-000027', 2, 'Mark', NULL, '508-8762347', 'Yes', 'Sister', 7, 'Michael', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', NULL, 'Brother', NULL, '1980-01-01', '508-8762347', '12321312', 5, 'User', NULL, NULL, NULL, 1, 'Dept. of Mental Health 
', '1', 'Institutional 
', 'Physical 
 Omission
 Sexual 
 ', 'Daily 
', 'Yes', '2010-03-03', '1', '1', '1', '1', '1', 'Yes', '2010-03-03', 'No', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (18, '2014-04-20', '2014-04-27 12:52:46.859', 2, 'PUBLIC-LOG-000018', 5, 'User', NULL, '1232131232', 'No', 'Brother', NULL, 'Mark', NULL, '508-8762347', 'F', 5, '1980-01-01', 0, 6, NULL, 'John', '79 Wester Avenue', 'Brother', NULL, '1980-01-01', NULL, 'Sign Interpreter
', 2, 'Mark', NULL, NULL, NULL, 1, 'Dept. of Mental Health 
', '123', 'Institutional 
', 'Physical 
 Sexual 
 ', 'Daily 
', 'Yes', '2010-03-03', '1212', '21', '212', '121', '221', 'Yes', '', 'Yes', '', NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (28, '2014-04-26', '2014-04-27 13:50:00.123', 2, 'PUBLIC-LOG-000028', 2, 'Mark', NULL, '508-8762347', 'Yes', 'Sister', 8, 'Miguel', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', NULL, 'Brother', NULL, '1980-01-01', '508-8762347', 'Sign Interpreter', 5, 'User', NULL, NULL, NULL, 2, 'Dept. of Developmental Svcs. 
', '123', 'Institutional 
', 'Physical 
 Omission
 ', 'Daily 
', 'Yes', '2010-03-03', '1', '1', '1', '1', '1', 'Yes', '2010-03-03', 'No', NULL, NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (30, '2014-04-27', '2014-04-27 16:02:37.782', 2, 'PUBLIC-LOG-000030', 2, 'Mark', NULL, '508-8762347', 'Yes', 'Brother', 8, 'Miguel', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', NULL, 'Brother', NULL, '1980-01-01', '508-8762347', 'Sign Interpreter', 5, 'User', NULL, NULL, NULL, 2, 'Dept. of Developmental Svcs. 
', '123', 'Institutional 
', 'Physical 
 ', 'Daily 
', 'Yes', NULL, '123', '213', '23', '12', '123', 'Yes', '', 'Yes', '', NULL, NULL, NULL);
INSERT INTO abusereport (id, created, modified, status, public_log_number, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_staff_id, alleged_victim_datebirth, alleged_victim_marital_status_id, alleged_abuser_patient_id, alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment, disposition_letter, decision_letter, appeal_letter) VALUES (32, '2014-04-27', '2014-04-27 16:16:09.902', 2, 'PUBLIC-LOG-000032', 2, 'MarkTwain', '12asdfad', '508-8762347', 'Yes', 'Brother', 8, 'Miguel', '79 Wester Avenue', NULL, 'M', NULL, '1980-01-01', 2, NULL, 2, 'Mark', '12asdfad', 'Brother', NULL, '1980-01-01', '508-8762347', 'Sign Interpreter', 5, 'User', '13 sdafads', NULL, NULL, 2, 'Dept. of Developmental Svcs. 
', '1', 'Institutional 
', 'Physical 
 ', 'Daily 
', 'Yes', NULL, '1', '1', '1', '1', '1', 'Yes', '', 'Yes', '', NULL, NULL, NULL);


--
-- TOC entry 2101 (class 0 OID 0)
-- Dependencies: 213
-- Name: abusereport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('abusereport_id_seq', 32, true);


--
-- TOC entry 1973 (class 2606 OID 24601)
-- Name: abusereport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_pkey PRIMARY KEY (id);


--
-- TOC entry 1983 (class 2620 OID 24719)
-- Name: create_abuse_report_disability_trg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER create_abuse_report_disability_trg AFTER INSERT ON abusereport FOR EACH ROW EXECUTE PROCEDURE create_abuse_report_disability();


--
-- TOC entry 1981 (class 2620 OID 24637)
-- Name: create_public_log_number_trg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER create_public_log_number_trg AFTER INSERT ON abusereport FOR EACH ROW EXECUTE PROCEDURE create_public_log_number();


--
-- TOC entry 1982 (class 2620 OID 24638)
-- Name: update_lastmodified_modtime_abusereport; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_lastmodified_modtime_abusereport BEFORE UPDATE ON abusereport FOR EACH ROW EXECUTE PROCEDURE update_lastmodified_column();


--
-- TOC entry 1974 (class 2606 OID 24602)
-- Name: abusereport_alleged_abuser_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_alleged_abuser_patient_id_fkey FOREIGN KEY (alleged_abuser_patient_id) REFERENCES patient(id);


--
-- TOC entry 1975 (class 2606 OID 24607)
-- Name: abusereport_alleged_abuser_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_alleged_abuser_staff_id_fkey FOREIGN KEY (alleged_abuser_staff_id) REFERENCES system_user(id);


--
-- TOC entry 1976 (class 2606 OID 24612)
-- Name: abusereport_alleged_victim_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_alleged_victim_patient_id_fkey FOREIGN KEY (alleged_victim_patient_id) REFERENCES patient(id);


--
-- TOC entry 1977 (class 2606 OID 24617)
-- Name: abusereport_alleged_victim_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_alleged_victim_staff_id_fkey FOREIGN KEY (alleged_victim_staff_id) REFERENCES system_user(id);


--
-- TOC entry 1978 (class 2606 OID 24622)
-- Name: abusereport_client_guardian_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_client_guardian_id_fkey FOREIGN KEY (client_guardian_id) REFERENCES system_user(id);


--
-- TOC entry 1979 (class 2606 OID 24627)
-- Name: abusereport_currently_served_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_currently_served_by_id_fkey FOREIGN KEY (currently_served_by_id) REFERENCES currently_served_by(id);


--
-- TOC entry 1980 (class 2606 OID 24632)
-- Name: abusereport_reporter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abusereport
    ADD CONSTRAINT abusereport_reporter_id_fkey FOREIGN KEY (reporter_id) REFERENCES system_user(id);


-- Completed on 2014-04-27 16:19:53

--
-- PostgreSQL database dump complete
--

