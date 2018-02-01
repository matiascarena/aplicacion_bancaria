
---------------------
-- CLASS: contact_information --
---------------------

------------------
-- DEFINITION
------------------

CREATE TABLE contact_information (
         dni           text NOT NULL REFERENCES person(dni),
         phone         text,
         mobile        text,
         email         text 
);

------------------
-- CONSTRUCTOR
------------------
CREATE OR REPLACE FUNCTION contact_information (
    IN p_dni                text,
    IN p_phone              text,
    IN p_mobile             text,
    IN email                text,
    IN p_local_information  local_information

) RETURNS contact_information AS $$
DECLARE 
        v_contact_information     contact_information;
BEGIN 
		IF NOT EXISTS (SELECT 1 FROM contact_information WHERE dni = p_dni)
		THEN
			EXECUTE 'INSERT INTO Contact_information(phone, mobile, email) VALUES (''' || p_dni || ''',''' || p_phone || ''', ''' || p_mobile || ''', ''' || p_email ||''') RETURNING *' INTO v_contact_information;
		       
		       RETURN v_contact_information;
		ELSE
		    RAISE EXCEPTION 'YA EXISTE UNA PERSONA CON ESE CONTACTO'
		END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE
SET search_path FROM CURRENT;

------------------
-- DESSTRUCTOR
------------------

CREATE OR REPLACE FUNCTION contact_information_destroy (
	IN p_contact_information            contact_information
) RETURNS void AS $$
BEGIN
	
	EXECUTE 'DELETE FROM contact_information x WHERE x =' || 
p_contact_information || ';' 
END;
	
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;


--------------------
-- IDENTYFY & SEARCH
--------------------
CREATE OR REPLACE FUNCTION contact_information_identify_by_dni (
	IN p_dni         text
) RETURNS contact_information AS $$
BEGIN
	EXECUTE 'SELECT * FROM location WHERE dni =' || p_dni || ';'
END;
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


--------------------
-- GETTERS & SETTERS
--------------------

CREATE OR REPLACE FUNCTION contact_information_get_phone (
	IN p_contact_information            contact_information
) RETURNS text AS $$
BEGIN
	EXECUTE 'SELECT' || p_contact_information.phone || ';'
END;
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION contact_information_set_phone (
	IN p_contact_information            contact_information,
	IN p_phone                          text
) RETURNS void AS $$
BEGIN 
	IF EXISTS (SELECT 1 FROM contact_information WHERE dni = 
p_contact_information.dni)
	THEN 
		UPDATE contact_information SET phone = p_phone WHERE dni = p_contact_information.dni;
	ELSE 
		RAISE EXCEPTION 'NO EXISTE EL CONTACTO INDICADO';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION contact_information_get_mobile (
	IN p_contact_information            contact_information
) RETURNS text AS $$
BEGIN
	EXECUTE 'SELECT' || p_contact_information.mobile || ';'
END;
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION contact_information_set_mobile (
	IN p_contact_information            contact_information,
	IN p_mobile                          text
) RETURNS void AS $$
BEGIN 
	IF EXISTS (SELECT 1 FROM contact_information WHERE dni = p_contact_information.dni)
	THEN 
		UPDATE contact_information SET mobile = p_mobile WHERE dni = p_contact_information.dni;
	ELSE 
		RAISE EXCEPTION 'NO EXISTE EL CONTACTO INDICADO';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION contact_information_get_email (
	IN p_contact_information            contact_information
) RETURNS text AS $$
BEGIN
	EXECUTE 'SELECT' || p_contact_information.email || ';'
END;
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION contact_information_set_email (
	IN p_contact_information            contact_information,
	IN p_email                          text
) RETURNS void AS $$
BEGIN 
	IF EXISTS (SELECT 1 FROM contact_information WHERE dni = p_contact_information.dni)
	THEN 
		UPDATE contact_information SET email = p_email WHERE dni = p_contact_information.dni;
	ELSE 
		RAISE EXCEPTION 'NO EXISTE EL CONTACTO INDICADO';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;
