--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg130+1)
-- Dumped by pg_dump version 17.0

-- Started on 2026-07-14 07:17:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16387)
-- Name: block_management; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA block_management;


ALTER SCHEMA block_management OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 40982)
-- Name: app_user; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.app_user (
    id uuid NOT NULL,
    person_id uuid,
    name text NOT NULL,
    password text NOT NULL
);


ALTER TABLE block_management.app_user OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 49201)
-- Name: app_user_role; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.app_user_role (
    user_id uuid NOT NULL,
    role_id uuid NOT NULL
);


ALTER TABLE block_management.app_user_role OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 49168)
-- Name: authority; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.authority (
    id uuid NOT NULL,
    name text NOT NULL
);


ALTER TABLE block_management.authority OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16408)
-- Name: block; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.block (
    id uuid NOT NULL,
    electricity_code text NOT NULL,
    water_code text NOT NULL,
    natural_gas_code text,
    tax_code text,
    cadastralp_code text,
    street text NOT NULL,
    street_number text NOT NULL,
    postcode text NOT NULL
);


ALTER TABLE block_management.block OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16413)
-- Name: block_expense; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.block_expense (
    expense_id uuid NOT NULL,
    block_id uuid NOT NULL
);


ALTER TABLE block_management.block_expense OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16416)
-- Name: expense; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.expense (
    id uuid NOT NULL,
    cost numeric(6,2) NOT NULL,
    period_start date NOT NULL,
    period_end date NOT NULL,
    paid boolean NOT NULL,
    expense_type_id uuid NOT NULL,
    CONSTRAINT expense_cost_check CHECK ((cost >= (0)::numeric))
);


ALTER TABLE block_management.expense OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 49216)
-- Name: expense_type; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.expense_type (
    id uuid NOT NULL,
    code text NOT NULL
);


ALTER TABLE block_management.expense_type OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16427)
-- Name: flat; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.flat (
    id uuid NOT NULL,
    code text NOT NULL,
    floor integer NOT NULL,
    square_meters integer NOT NULL,
    block_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    tenant_id uuid
);


ALTER TABLE block_management.flat OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16432)
-- Name: flat_expense; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.flat_expense (
    expense_id uuid NOT NULL,
    flat_id uuid NOT NULL,
    block_expense_id uuid NOT NULL
);


ALTER TABLE block_management.flat_expense OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 57344)
-- Name: manager_period; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.manager_period (
    id uuid NOT NULL,
    block_id uuid NOT NULL,
    manager_id uuid NOT NULL,
    viewer_id uuid NOT NULL,
    period_start date NOT NULL,
    period_end date
);


ALTER TABLE block_management.manager_period OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 49225)
-- Name: multiplier_configuration; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.multiplier_configuration (
    id uuid NOT NULL,
    flat_id uuid NOT NULL,
    expense_type_id uuid NOT NULL,
    multiplier numeric(5,4) NOT NULL,
    CONSTRAINT multiplier_configuration_multiplier_check CHECK (((multiplier >= (0)::numeric) AND (multiplier <= (1)::numeric)))
);


ALTER TABLE block_management.multiplier_configuration OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16444)
-- Name: person; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.person (
    id uuid NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    mobile_phone text NOT NULL,
    phone text,
    email text,
    CONSTRAINT person_email_check CHECK ((email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT person_mobile_phone_check CHECK ((mobile_phone ~ '^[0-9]{10}$'::text)),
    CONSTRAINT person_phone_check CHECK ((phone ~ '^[0-9]{10}$'::text))
);


ALTER TABLE block_management.person OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 49177)
-- Name: role; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.role (
    id uuid NOT NULL,
    name text NOT NULL
);


ALTER TABLE block_management.role OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 49186)
-- Name: role_authority; Type: TABLE; Schema: block_management; Owner: postgres
--

CREATE TABLE block_management.role_authority (
    role_id uuid NOT NULL,
    authority_id uuid NOT NULL
);


ALTER TABLE block_management.role_authority OWNER TO postgres;

--
-- TOC entry 3555 (class 0 OID 40982)
-- Dependencies: 224
-- Data for Name: app_user; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.app_user (id, person_id, name, password) FROM stdin;
c385c86f-f99f-47a8-9175-cebef822fa8c	\N	panos	$2a$10$aHJNfYFDL4S4CyY6ttSWz.hzpOtMyVNPc1Rom85dJ.2wMsQbcCHKu
\.


--
-- TOC entry 3559 (class 0 OID 49201)
-- Dependencies: 228
-- Data for Name: app_user_role; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.app_user_role (user_id, role_id) FROM stdin;
c385c86f-f99f-47a8-9175-cebef822fa8c	8b68b064-5cca-46d0-bc61-633bbb90faa8
\.


--
-- TOC entry 3556 (class 0 OID 49168)
-- Dependencies: 225
-- Data for Name: authority; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.authority (id, name) FROM stdin;
0ae0c607-bf98-4b5a-9463-a72df0570709	person.create
ce29468c-7faf-42e4-a99f-dea2724ba0b5	block.getById
8e57b866-cba2-4db7-b7ca-260c3fb39f54	block.create
7223c93c-4c26-475f-beee-b80891ab4319	block.getFlats
75da42ec-2e34-4fbb-8b00-fe9e01ecdb44	block.getExpenses
6d0d59e4-29fc-4485-9adb-93a3c23ee945	block.createExpense
635efe68-6339-4d81-aa4f-e052c9271805	person.getById
5c93fac7-5732-4b2a-a7d3-01add5418891	person.getPersons
9d8c9559-0e9e-44ee-8066-9de874f7d9d1	block.getBlocks
c1185c73-40d1-4d13-a813-00906ac63cc9	flat.update
f127b0a8-c699-4daf-be1d-3efbde330d67	managerPeriod.getManagerPeriods
84012407-382a-4c69-a2bb-9250081786bf	managerPeriod.create
7ec0f02e-62ac-4fb3-9c6b-c71b3f3d6a2d	managerPeriod.getById
e7f2bd35-18f3-4ec9-b69c-66a6d8e614fb	user.create
2776c59b-3d7d-47f3-b86f-a1821d7234fa	manager.getInfo
e1a4298f-52f8-4eb1-b129-559643ae827f	manager.getPeriods
9006a918-fb00-413d-b5c0-ce42d90b7ab3	blockExpense.getFlatExpenses
b771ac24-e09f-4e96-9b4f-12ee9c953c63	blockExpense.update
d2a22e02-a20d-400c-9b22-5dcd904142b5	block.createFlat
cf805903-7c7c-4f49-8506-e056bbd0a6fd	block.getReport
dd5d9d94-6335-452c-8ec3-acfdad6befa3	block.getEmail
1e48a5f0-804f-48a7-8919-445c7265d95f	flatExpense.update
070e917e-38a0-4ccc-8480-facb88dd41ce	flat.getMultiplierConfigurations
a86c2836-6252-47fc-9db9-5d7e0e1c6f1c	flat.createMultiplierConfiguration
12244a9f-b737-44f0-b965-d7ce0d14f8f9	expenseType.getExpenseTypes
a26c62e2-1aae-4642-9adf-b3a1409a7610	viewer.getManagerPeriod
\.


--
-- TOC entry 3549 (class 0 OID 16408)
-- Dependencies: 218
-- Data for Name: block; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.block (id, electricity_code, water_code, natural_gas_code, tax_code, cadastralp_code, street, street_number, postcode) FROM stdin;
\.


--
-- TOC entry 3550 (class 0 OID 16413)
-- Dependencies: 219
-- Data for Name: block_expense; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.block_expense (expense_id, block_id) FROM stdin;
\.


--
-- TOC entry 3551 (class 0 OID 16416)
-- Dependencies: 220
-- Data for Name: expense; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.expense (id, cost, period_start, period_end, paid, expense_type_id) FROM stdin;
\.


--
-- TOC entry 3560 (class 0 OID 49216)
-- Dependencies: 229
-- Data for Name: expense_type; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.expense_type (id, code) FROM stdin;
9b97caa4-cd89-4930-9a7a-84204a4bca73	ELECTRICITY
1a66e50e-91da-41f1-8fb2-3ff3e59a6bab	WATER
19d392c3-826f-4ac2-a8e5-efe5ced9f83e	ELEVATOR
b9d388b7-9918-4cc6-a6b9-9583d7f6df94	CLEANING
\.


--
-- TOC entry 3552 (class 0 OID 16427)
-- Dependencies: 221
-- Data for Name: flat; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.flat (id, code, floor, square_meters, block_id, owner_id, tenant_id) FROM stdin;
\.


--
-- TOC entry 3553 (class 0 OID 16432)
-- Dependencies: 222
-- Data for Name: flat_expense; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.flat_expense (expense_id, flat_id, block_expense_id) FROM stdin;
\.


--
-- TOC entry 3562 (class 0 OID 57344)
-- Dependencies: 231
-- Data for Name: manager_period; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.manager_period (id, block_id, manager_id, viewer_id, period_start, period_end) FROM stdin;
\.


--
-- TOC entry 3561 (class 0 OID 49225)
-- Dependencies: 230
-- Data for Name: multiplier_configuration; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.multiplier_configuration (id, flat_id, expense_type_id, multiplier) FROM stdin;
\.


--
-- TOC entry 3554 (class 0 OID 16444)
-- Dependencies: 223
-- Data for Name: person; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.person (id, first_name, last_name, mobile_phone, phone, email) FROM stdin;
\.


--
-- TOC entry 3557 (class 0 OID 49177)
-- Dependencies: 226
-- Data for Name: role; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.role (id, name) FROM stdin;
8b68b064-5cca-46d0-bc61-633bbb90faa8	ADMIN
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	MANAGER
1ff137c9-2314-48ba-94c0-b59872fb6174	VIEWER
\.


--
-- TOC entry 3558 (class 0 OID 49186)
-- Dependencies: 227
-- Data for Name: role_authority; Type: TABLE DATA; Schema: block_management; Owner: postgres
--

COPY block_management.role_authority (role_id, authority_id) FROM stdin;
8b68b064-5cca-46d0-bc61-633bbb90faa8	0ae0c607-bf98-4b5a-9463-a72df0570709
8b68b064-5cca-46d0-bc61-633bbb90faa8	ce29468c-7faf-42e4-a99f-dea2724ba0b5
8b68b064-5cca-46d0-bc61-633bbb90faa8	8e57b866-cba2-4db7-b7ca-260c3fb39f54
8b68b064-5cca-46d0-bc61-633bbb90faa8	7223c93c-4c26-475f-beee-b80891ab4319
8b68b064-5cca-46d0-bc61-633bbb90faa8	635efe68-6339-4d81-aa4f-e052c9271805
8b68b064-5cca-46d0-bc61-633bbb90faa8	5c93fac7-5732-4b2a-a7d3-01add5418891
8b68b064-5cca-46d0-bc61-633bbb90faa8	9d8c9559-0e9e-44ee-8066-9de874f7d9d1
8b68b064-5cca-46d0-bc61-633bbb90faa8	c1185c73-40d1-4d13-a813-00906ac63cc9
8b68b064-5cca-46d0-bc61-633bbb90faa8	f127b0a8-c699-4daf-be1d-3efbde330d67
8b68b064-5cca-46d0-bc61-633bbb90faa8	84012407-382a-4c69-a2bb-9250081786bf
8b68b064-5cca-46d0-bc61-633bbb90faa8	7ec0f02e-62ac-4fb3-9c6b-c71b3f3d6a2d
8b68b064-5cca-46d0-bc61-633bbb90faa8	e7f2bd35-18f3-4ec9-b69c-66a6d8e614fb
8b68b064-5cca-46d0-bc61-633bbb90faa8	d2a22e02-a20d-400c-9b22-5dcd904142b5
8b68b064-5cca-46d0-bc61-633bbb90faa8	070e917e-38a0-4ccc-8480-facb88dd41ce
8b68b064-5cca-46d0-bc61-633bbb90faa8	a86c2836-6252-47fc-9db9-5d7e0e1c6f1c
8b68b064-5cca-46d0-bc61-633bbb90faa8	12244a9f-b737-44f0-b965-d7ce0d14f8f9
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	ce29468c-7faf-42e4-a99f-dea2724ba0b5
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	7223c93c-4c26-475f-beee-b80891ab4319
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	75da42ec-2e34-4fbb-8b00-fe9e01ecdb44
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	6d0d59e4-29fc-4485-9adb-93a3c23ee945
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	635efe68-6339-4d81-aa4f-e052c9271805
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	7ec0f02e-62ac-4fb3-9c6b-c71b3f3d6a2d
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	2776c59b-3d7d-47f3-b86f-a1821d7234fa
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	e1a4298f-52f8-4eb1-b129-559643ae827f
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	9006a918-fb00-413d-b5c0-ce42d90b7ab3
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	b771ac24-e09f-4e96-9b4f-12ee9c953c63
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	cf805903-7c7c-4f49-8506-e056bbd0a6fd
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	dd5d9d94-6335-452c-8ec3-acfdad6befa3
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	1e48a5f0-804f-48a7-8919-445c7265d95f
e2cc9ce5-9bfe-4b5b-9c9a-5a2bff2d052d	070e917e-38a0-4ccc-8480-facb88dd41ce
1ff137c9-2314-48ba-94c0-b59872fb6174	ce29468c-7faf-42e4-a99f-dea2724ba0b5
1ff137c9-2314-48ba-94c0-b59872fb6174	7223c93c-4c26-475f-beee-b80891ab4319
1ff137c9-2314-48ba-94c0-b59872fb6174	75da42ec-2e34-4fbb-8b00-fe9e01ecdb44
1ff137c9-2314-48ba-94c0-b59872fb6174	635efe68-6339-4d81-aa4f-e052c9271805
1ff137c9-2314-48ba-94c0-b59872fb6174	7ec0f02e-62ac-4fb3-9c6b-c71b3f3d6a2d
1ff137c9-2314-48ba-94c0-b59872fb6174	a26c62e2-1aae-4642-9adf-b3a1409a7610
1ff137c9-2314-48ba-94c0-b59872fb6174	9006a918-fb00-413d-b5c0-ce42d90b7ab3
1ff137c9-2314-48ba-94c0-b59872fb6174	070e917e-38a0-4ccc-8480-facb88dd41ce
\.


--
-- TOC entry 3356 (class 2606 OID 40990)
-- Name: app_user app_user_person_id_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.app_user
    ADD CONSTRAINT app_user_person_id_unique UNIQUE (person_id);


--
-- TOC entry 3358 (class 2606 OID 40988)
-- Name: app_user app_user_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.app_user
    ADD CONSTRAINT app_user_pk PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 49205)
-- Name: app_user_role app_user_role_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.app_user_role
    ADD CONSTRAINT app_user_role_pk PRIMARY KEY (user_id, role_id);


--
-- TOC entry 3360 (class 2606 OID 40992)
-- Name: app_user app_user_username_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.app_user
    ADD CONSTRAINT app_user_username_unique UNIQUE (name);


--
-- TOC entry 3362 (class 2606 OID 49176)
-- Name: authority authority_name_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.authority
    ADD CONSTRAINT authority_name_unique UNIQUE (name);


--
-- TOC entry 3364 (class 2606 OID 49174)
-- Name: authority authority_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.authority
    ADD CONSTRAINT authority_pk PRIMARY KEY (id);


--
-- TOC entry 3332 (class 2606 OID 16475)
-- Name: block block_cadastralp_code_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block
    ADD CONSTRAINT block_cadastralp_code_unique UNIQUE (cadastralp_code);


--
-- TOC entry 3334 (class 2606 OID 16477)
-- Name: block block_electricity_code_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block
    ADD CONSTRAINT block_electricity_code_unique UNIQUE (electricity_code);


--
-- TOC entry 3344 (class 2606 OID 16479)
-- Name: block_expense block_expense_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block_expense
    ADD CONSTRAINT block_expense_pk PRIMARY KEY (expense_id);


--
-- TOC entry 3336 (class 2606 OID 16481)
-- Name: block block_natural_gas_code_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block
    ADD CONSTRAINT block_natural_gas_code_unique UNIQUE (natural_gas_code);


--
-- TOC entry 3338 (class 2606 OID 16483)
-- Name: block block_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block
    ADD CONSTRAINT block_pk PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 16485)
-- Name: block block_tax_code_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block
    ADD CONSTRAINT block_tax_code_unique UNIQUE (tax_code);


--
-- TOC entry 3342 (class 2606 OID 16487)
-- Name: block block_water_code_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block
    ADD CONSTRAINT block_water_code_unique UNIQUE (water_code);


--
-- TOC entry 3346 (class 2606 OID 16489)
-- Name: expense expense_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.expense
    ADD CONSTRAINT expense_pk PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 49224)
-- Name: expense_type expense_type_code_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.expense_type
    ADD CONSTRAINT expense_type_code_unique UNIQUE (code);


--
-- TOC entry 3376 (class 2606 OID 49222)
-- Name: expense_type expense_type_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.expense_type
    ADD CONSTRAINT expense_type_pk PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 16493)
-- Name: flat_expense flat_expense_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.flat_expense
    ADD CONSTRAINT flat_expense_pk PRIMARY KEY (expense_id);


--
-- TOC entry 3348 (class 2606 OID 16495)
-- Name: flat flat_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.flat
    ADD CONSTRAINT flat_pk PRIMARY KEY (id);


--
-- TOC entry 3382 (class 2606 OID 57348)
-- Name: manager_period manager_period_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.manager_period
    ADD CONSTRAINT manager_period_pk PRIMARY KEY (id);


--
-- TOC entry 3384 (class 2606 OID 57350)
-- Name: manager_period manager_period_viewer_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.manager_period
    ADD CONSTRAINT manager_period_viewer_unique UNIQUE (viewer_id);


--
-- TOC entry 3378 (class 2606 OID 49232)
-- Name: multiplier_configuration multiplier_configuration_expense_type_flat_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.multiplier_configuration
    ADD CONSTRAINT multiplier_configuration_expense_type_flat_unique UNIQUE (expense_type_id, flat_id);


--
-- TOC entry 3380 (class 2606 OID 49230)
-- Name: multiplier_configuration multiplier_configuration_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.multiplier_configuration
    ADD CONSTRAINT multiplier_configuration_pk PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 16505)
-- Name: person person_mobile_phone_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.person
    ADD CONSTRAINT person_mobile_phone_unique UNIQUE (mobile_phone);


--
-- TOC entry 3354 (class 2606 OID 16507)
-- Name: person person_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.person
    ADD CONSTRAINT person_pk PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 49190)
-- Name: role_authority role_authority_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.role_authority
    ADD CONSTRAINT role_authority_pk PRIMARY KEY (role_id, authority_id);


--
-- TOC entry 3366 (class 2606 OID 49185)
-- Name: role role_name_unique; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.role
    ADD CONSTRAINT role_name_unique UNIQUE (name);


--
-- TOC entry 3368 (class 2606 OID 49183)
-- Name: role role_pk; Type: CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.role
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- TOC entry 3394 (class 2606 OID 40993)
-- Name: app_user app_user_person_id_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.app_user
    ADD CONSTRAINT app_user_person_id_fk FOREIGN KEY (person_id) REFERENCES block_management.person(id);


--
-- TOC entry 3397 (class 2606 OID 49206)
-- Name: app_user_role app_user_role_app_user_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.app_user_role
    ADD CONSTRAINT app_user_role_app_user_fk FOREIGN KEY (user_id) REFERENCES block_management.app_user(id);


--
-- TOC entry 3398 (class 2606 OID 49211)
-- Name: app_user_role app_user_role_role_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.app_user_role
    ADD CONSTRAINT app_user_role_role_fk FOREIGN KEY (role_id) REFERENCES block_management.role(id);


--
-- TOC entry 3385 (class 2606 OID 16534)
-- Name: block_expense block_expense_block_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block_expense
    ADD CONSTRAINT block_expense_block_fk FOREIGN KEY (block_id) REFERENCES block_management.block(id);


--
-- TOC entry 3386 (class 2606 OID 16539)
-- Name: block_expense block_expense_expense_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.block_expense
    ADD CONSTRAINT block_expense_expense_fk FOREIGN KEY (expense_id) REFERENCES block_management.expense(id);


--
-- TOC entry 3387 (class 2606 OID 49243)
-- Name: expense expense_expense_type_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.expense
    ADD CONSTRAINT expense_expense_type_fk FOREIGN KEY (expense_type_id) REFERENCES block_management.expense_type(id);


--
-- TOC entry 3388 (class 2606 OID 16559)
-- Name: flat flat_block_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.flat
    ADD CONSTRAINT flat_block_fk FOREIGN KEY (block_id) REFERENCES block_management.block(id);


--
-- TOC entry 3391 (class 2606 OID 16564)
-- Name: flat_expense flat_expense_block_expense_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.flat_expense
    ADD CONSTRAINT flat_expense_block_expense_fk FOREIGN KEY (block_expense_id) REFERENCES block_management.block_expense(expense_id);


--
-- TOC entry 3392 (class 2606 OID 16569)
-- Name: flat_expense flat_expense_expense_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.flat_expense
    ADD CONSTRAINT flat_expense_expense_fk FOREIGN KEY (expense_id) REFERENCES block_management.expense(id);


--
-- TOC entry 3393 (class 2606 OID 16574)
-- Name: flat_expense flat_expense_flat_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.flat_expense
    ADD CONSTRAINT flat_expense_flat_fk FOREIGN KEY (flat_id) REFERENCES block_management.flat(id);


--
-- TOC entry 3389 (class 2606 OID 16589)
-- Name: flat flat_owner_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.flat
    ADD CONSTRAINT flat_owner_fk FOREIGN KEY (owner_id) REFERENCES block_management.person(id);


--
-- TOC entry 3390 (class 2606 OID 16594)
-- Name: flat flat_tenant_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.flat
    ADD CONSTRAINT flat_tenant_fk FOREIGN KEY (tenant_id) REFERENCES block_management.person(id);


--
-- TOC entry 3401 (class 2606 OID 57355)
-- Name: manager_period manager_period_block_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.manager_period
    ADD CONSTRAINT manager_period_block_fk FOREIGN KEY (block_id) REFERENCES block_management.block(id);


--
-- TOC entry 3402 (class 2606 OID 57360)
-- Name: manager_period manager_period_manager_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.manager_period
    ADD CONSTRAINT manager_period_manager_fk FOREIGN KEY (manager_id) REFERENCES block_management.app_user(id);


--
-- TOC entry 3403 (class 2606 OID 57365)
-- Name: manager_period manager_period_viewer_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.manager_period
    ADD CONSTRAINT manager_period_viewer_fk FOREIGN KEY (viewer_id) REFERENCES block_management.app_user(id);


--
-- TOC entry 3399 (class 2606 OID 49233)
-- Name: multiplier_configuration multiplier_configuration_expense_type_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.multiplier_configuration
    ADD CONSTRAINT multiplier_configuration_expense_type_fk FOREIGN KEY (expense_type_id) REFERENCES block_management.expense_type(id);


--
-- TOC entry 3400 (class 2606 OID 49238)
-- Name: multiplier_configuration multiplier_configuration_flat_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.multiplier_configuration
    ADD CONSTRAINT multiplier_configuration_flat_fk FOREIGN KEY (flat_id) REFERENCES block_management.flat(id);


--
-- TOC entry 3395 (class 2606 OID 49191)
-- Name: role_authority role_authority_authority_id_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.role_authority
    ADD CONSTRAINT role_authority_authority_id_fk FOREIGN KEY (authority_id) REFERENCES block_management.authority(id);


--
-- TOC entry 3396 (class 2606 OID 49196)
-- Name: role_authority role_authority_role_id_fk; Type: FK CONSTRAINT; Schema: block_management; Owner: postgres
--

ALTER TABLE ONLY block_management.role_authority
    ADD CONSTRAINT role_authority_role_id_fk FOREIGN KEY (role_id) REFERENCES block_management.role(id);


-- Completed on 2026-07-14 07:17:14

--
-- PostgreSQL database dump complete
--

