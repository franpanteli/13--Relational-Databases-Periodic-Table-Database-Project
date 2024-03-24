-- PostgreSQL database dump

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

-- Setting various parameters
SET statement_timeout = 0;  -- No statement timeout
SET lock_timeout = 0;  -- No lock timeout
SET idle_in_transaction_session_timeout = 0;  -- No timeout for idle transactions
SET client_encoding = 'UTF8';  -- Client encoding set to UTF-8
SET standard_conforming_strings = on;  -- Enable standard conforming strings
SELECT pg_catalog.set_config('search_path', '', false);  -- Set search path
SET check_function_bodies = false;  -- Disable function body checks
SET xmloption = content;  -- XML option set to content
SET client_min_messages = warning;  -- Client minimum messages set to warning
SET row_security = off;  -- Disable row security

DROP DATABASE periodic_table;  -- Drop existing periodic_table database if it exists

-- Creating periodic_table database
CREATE DATABASE periodic_table WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';

ALTER DATABASE periodic_table OWNER TO postgres;  -- Set owner of periodic_table database to postgres

\connect periodic_table  -- Connect to periodic_table database

-- Setting various parameters for the connected database
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

SET default_tablespace = '';  -- Set default tablespace

SET default_table_access_method = heap;  -- Set default table access method

-- Creating 'elements' table
CREATE TABLE public.elements (
    atomic_number integer NOT NULL,
    symbol character varying(2) NOT NULL,
    name character varying(40) NOT NULL
);

ALTER TABLE public.elements OWNER TO freecodecamp;  -- Set owner of 'elements' table to freecodecamp

-- Creating 'properties' table
CREATE TABLE public.properties (
    atomic_number integer NOT NULL,
    atomic_mass numeric NOT NULL,
    melting_point_celsius numeric NOT NULL,
    boiling_point_celsius numeric NOT NULL,
    type_id integer NOT NULL
);

ALTER TABLE public.properties OWNER TO freecodecamp;  -- Set owner of 'properties' table to freecodecamp

-- Creating 'types' table
CREATE TABLE public.types (
    type_id integer NOT NULL,
    type character varying(20) NOT NULL
);

ALTER TABLE public.types OWNER TO freecodecamp;  -- Set owner of 'types' table to freecodecamp

-- Creating sequence for 'types' table
CREATE SEQUENCE public.types_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.types_type_seq OWNER TO freecodecamp;  -- Set owner of sequence to freecodecamp

-- Set ownership of sequence to 'types' table
ALTER SEQUENCE public.types_type_seq OWNED BY public.types.type_id;

-- Set default value for 'type_id' column in 'types' table
ALTER TABLE ONLY public.types ALTER COLUMN type_id SET DEFAULT nextval('public.types_type_seq'::regclass);

-- Inserting data into 'elements' table
INSERT INTO public.elements VALUES (1, 'H', 'Hydrogen');
INSERT INTO public.elements VALUES (4, 'Be', 'Beryllium');
INSERT INTO public.elements VALUES (5, 'B', 'Boron');
INSERT INTO public.elements VALUES (6, 'C', 'Carbon');
INSERT INTO public.elements VALUES (7, 'N', 'Nitrogen');
INSERT INTO public.elements VALUES (8, 'O', 'Oxygen');
INSERT INTO public.elements VALUES (2, 'He', 'Helium');
INSERT INTO public.elements VALUES (3, 'Li', 'Lithium');
INSERT INTO public.elements VALUES (9, 'F', 'Fluorine');
INSERT INTO public.elements VALUES (10, 'Ne', 'Neon');

-- Inserting data into 'properties' table
INSERT INTO public.properties VALUES (3, 6.94, 180.54, 1342, 1);
INSERT INTO public.properties VALUES (4, 9.0122, 1287, 2470, 1);
INSERT INTO public.properties VALUES (5, 10.81, 2075, 4000, 2);
INSERT INTO public.properties VALUES (1, 1.008, -259.1, -252.9, 3);
INSERT INTO public.properties VALUES (2, 4.0026, -272.2, -269, 3);
INSERT INTO public.properties VALUES (6, 12.011, 3550, 4027, 3);
INSERT INTO public.properties VALUES (7, 14.007, -210.1, -195.8, 3);
INSERT INTO public.properties VALUES (8, 15.999, -218, -183, 3);
INSERT INTO public.properties VALUES (9, 18.998, -220, -188.1, 3);
INSERT INTO public.properties VALUES (10, 20.18, -248.6, -246.1, 3);

-- Inserting data into 'types' table
INSERT INTO public.types VALUES (1, 'metal');
INSERT INTO public.types VALUES (2, 'metalloid');
INSERT INTO public.types VALUES (3, 'nonmetal');

-- Set sequence value for 'types' table
SELECT pg_catalog.setval('public.types_type_seq', 3, true);

-- Adding constraints to 'elements' table
ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_atomic_number_key UNIQUE (atomic_number);
ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_name_key UNIQUE (name);
ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (atomic_number);
ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_symbol_key UNIQUE (symbol);

-- Adding constraints to 'properties' table
ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_atomic_number_key UNIQUE (atomic_number);
ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (atomic_number);

-- Adding constraint to 'types' table
ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (type_id);

-- Adding foreign key constraints to 'properties' table
ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_atomic_number_fkey FOREIGN KEY (atomic_number) REFERENCES public.elements(atomic_number);
ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.types(type_id);

-- PostgreSQL database dump complete
