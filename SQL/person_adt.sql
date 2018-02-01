CREATE TABLE person (
        name         text NOT NULL,
        surname      text NOT NULL,
        dni          text PRIMARY KEY,
        birthday     timestamp with time zone NOT NULL,
        nationality  text NOT NULL
);

------------------
-- CONSTRUCTOR
------------------

CREATE OR REPLACE FUNCTION person (
       IN p_name                text,
       IN p_surname             text,
       IN p_dni                 text,
       IN birthday              timestamp with time zone,
       IN nationality           text,
       IN p_contact_information contact_information
) RETURNS person AS $$
DECLARE 
       v_person      person;
BEGIN 
      IF NOT EXISTS (SELECT 1 FROM person WHERE dni = p_dni)
      THEN
		  EXECUTE 'INSERT INTO person(name, surname, dni, birthday, nationality) VALUES (''' || p_name || ''', ''' || p_surname || ''', ''' || p_dni || ''', '''  || birthday || ''', ''' || nationality || ''') RETURNING *' INTO v_person;
		  
		  RETURN v_person;
	  ELSE
		  RAISE EXCEPTION 'Ya existe una person con este dni%', p_dni;
	  END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE
SET search_path FROM CURRENT;

--------------------
-- IDENTYFY & SEARCH
--------------------

CREATE OR REPLACE FUNCTION student_identify_by_dni (
	IN p_dni                 text
) RETURNS person AS $$
BEGIN
		 EXECUTE 'SELECT * FROM student WHERE dni = ' || p_dni || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION person_lookup_by_name (
	IN p_name               text
) RETURNS SETOF person AS $$
BEGIN
	EXECUTE 'SELECT * FROM student WHERE name = ' || p_name || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION person_lookup_by_surname (
	IN p_surname               text
) RETURNS SETOF person AS $$
BEGIN
	EXECUTE 'SELECT * FROM student WHERE surname = ' || p_surname || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION person_lookup_by_birthday (
	IN p_birthday            text
) RETURNS SETOF person AS $$
BEGIN
	EXECUTE 'SELECT * FROM student WHERE birthday = ' || p_birthday || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION person_lookup_by_nationality  (
	IN p_nationality           text
) RETURNS SETOF person AS $$
BEGIN
	EXECUTE 'SELECT * FROM student WHERE nationality  = ' || p_nationality || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

--------------------
-- GETTERS & SETTERS
--------------------

CREATE OR REPLACE FUNCTION person_get_dni (
	IN p_person             person
) RETURNS text AS $$
BEGIN
	EXECUTE 'SELECT ' || p_person.dni || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION person_get_name (
	IN p_person             person
) RETURNS text AS $$
BEGIN
	EXECUTE 'SELECT ' || p_person.name || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION person_get_surname (
	IN p_person             person
) RETURNS text AS $$
BEGIN
	EXECUTE 'SELECT ' || p_person.surname || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION person_get_birthday (
	IN p_person             person
) RETURNS text AS $$
BEGIN
	EXECUTE 'SELECT ' || p_person.birthday || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION person_get_nationality (
	IN p_person             person
) RETURNS text AS $$
BEGIN
	EXECUTE 'SELECT ' || p_person.nationality || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;
