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

CREATE OR REPLACE FUNCION location_information (
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
	EXECUTE 'DELETE FROM location_information x WHERE x = p_location_information;'
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
	EXECUTE 'SELECT * FROM location_information WHERE dni = p_dni;'
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;



