---------------------
-- CLASS: location_information --
---------------------

------------------
-- DEFINITION
------------------

CREATE TABLE location_information (
      dni          text NOT NULL REFERENCES contact_information(dni),
      address      text NOT NULL,
      zipcode      text NOT NULL,
      province     text NOT NULL,
      country      text NOT NULL
);

------------------
-- CONSTRUCTOR
------------------

CREATE OR REPLACE FUNCTION location_information (
	IN p_dni          text,
	IN p_address      text,
	IN p_zipcode      text,
	IN p_province     text,
	IN p_country      text
) RETURNS location_information AS $$
DECLARE
    v_location_information     location_information;
BEGIN
	IF NOT EXISTS (SELECT 1 FROM location_information WHERE dni = p_dni)
	THEN
		EXECUTE 'INSERT INTO location_information (address, zipcode, province, country) VALUES (''' || p_dni || ''',''' || p_address || ''', ''' || p_zipcode || ''', ''' || p_province|| ''', ''' || p_country ||''') RETURNING *' INTO v_location_information;
		
		RETURN v_location_information;
	ELSE
	    RAISE EXCEPTION 'YA SE ENCUENTRAN CARGADOS LOS DATOS PARA ESTE CLIENTE';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE
SET search_path FROM CURRENT;

------------------
-- DESSTRUCTOR
------------------

CREATE OR REPLACE FUNCTION location_information_destroy (
	IN p_location_information      location_information
) RETURNS void AS $$
BEGIN
	EXECUTE 'DELETE FROM location_information x WHERE x =' || p_location_information || ';';
END
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;

--------------------
-- IDENTYFY & SEARCH
--------------------
CREATE OR REPLACE FUNCTION location_information_identify_by_dni (
	IN p_dni         text
) RETURNS location_information AS $$
BEGIN 
	EXECUTE 'SELECT * FROM location_information WHERE dni =  ' || p_dni || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

--------------------
-- GETTERS & SETTERS
--------------------
CREATE OR REPLACE FUNCTION location_information_get_address (
	IN p_location_information            location_information
) RETURNS text AS $$
BEGIN 
	EXECUTE 'SELECT ' || p_location_information.address || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION location_information_set_address (
	IN p_location_information            location_information,
	IN p_address             text
) RETURNS void AS $$
BEGIN 
	IF EXISTS (SELECT 1 FROM location_information WHERE dni = p_location_information.dni)
	THEN 
		UPDATE location_information SET address = p_address WHERE dni = p_location_information.dni;
	ELSE 
		RAISE EXCEPTION 'NO EXISTE LA PERSONA INGRESADA';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION location_information_get_zipcode (
	IN p_location_information            location_information
) RETURNS text AS $$
BEGIN 
	EXECUTE 'SELECT ' || p_location_information.zipcode || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION location_information_set_zipcode (
	IN p_location_information            location_information,
	IN p_zipcode             text
) RETURNS void AS $$
BEGIN 
	IF EXISTS (SELECT 1 FROM location_information WHERE dni = p_location_information.dni)
	THEN 
		UPDATE location_information SET zipcode = p_zipcode WHERE dni = p_location_information.dni;
	ELSE 
		RAISE EXCEPTION 'NO EXISTE LA PERSONA INGRESADA';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION location_information_get_province (
	IN p_location_information            location_information
) RETURNS text AS $$
BEGIN 
	EXECUTE 'SELECT ' || p_location_information.province || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION location_information_get_country (
	IN p_location_information            location_information
) RETURNS text AS $$
BEGIN 
	EXECUTE 'SELECT ' || p_location_information.country || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION location_information_set_country (
	IN p_location_information            location_information,
	IN p_country             text
) RETURNS void AS $$
BEGIN 
	IF EXISTS (SELECT 1 FROM location_information WHERE dni = p_location_information.dni)
	THEN 
		UPDATE location_information SET country = p_country WHERE dni = p_location_information.dni;
	ELSE 
		RAISE EXCEPTION 'NO EXISTE LA PERSONA INGRESADA';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;
