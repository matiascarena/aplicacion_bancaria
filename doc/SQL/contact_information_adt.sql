
---------------------
-- CLASS: contact_infomration --
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
CREATE ON REPLACE FUNCTION contact_information (
    IN p_dni         text,
    IN p_phone       text,
    IN p_mobile      text,
    IN email         text

) RETURNS contact_information AS $$
DECLARE 
        v_contact_information     contact_information;
BEGIN 
		IF NOT EXISTS (SELECT 1 FROM contact_infomration WHERE dni = p_dni)
		THEN
			EXECUTE 'INSERT INTO Contact_information(phone, mobile, email)
		       VALUES (''' || p_dni || ''',''' || p_phone || ''', ''' || p_mobile || ''', ''' || p_email ||''') RETURNING *' INTO v_contact_information;
		       
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
	
	EXECUTE 'DELETE FROM contact_information x WHERE x = p_contact_information;' 
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
	EXECUTE 'SELECT * FROM location WHERE dni = p_dni' ;
END;
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION contact_information_identify_by_phone (
	IN p_phone         text
) RETURNS contact_information AS $$
BEGIN
	EXECUTE 'SELECT * FROM location WHERE dni = p_phone' ;
END;
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION contact_information_identify_by_mobile (
	IN p_mobile         text
) RETURNS contact_information AS $$
BEGIN
	EXECUTE 'SELECT * FROM location WHERE dni = p_mobile' ;
END;
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION contact_information_identify_by_email (
	IN p_email         text
) RETURNS contact_information AS $$
BEGIN
	EXECUTE 'SELECT * FROM location WHERE dni = p_email' ;
END;
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


