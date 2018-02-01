---------------------
-- CLASS: client --
---------------------

------------------
-- DEFINITION
------------------

CREATE TABLE client (
      client_id    serial NOT NULL
      type          client_type NOT NULL DEFAULT 'REGULAR'
);

------------------
-- CONSTRUCTOR
------------------

CREATE OR REPLACE FUNCTION client (
	IN p_type   text,
	IN p_account     account,
	IN p_person      person

) RETURNS client AS $$
DECLARE
    v_client     client;
BEGIN
	IF NOT EXISTS (SELECT 1 FROM client WHERE client_id = p_client_id)
	THEN
		EXECUTE 'INSERT INTO client (type) VALUES (''' || p_type || ''') RETURNING *' INTO v_client;
		
		RETURN v_client;
	ELSE
	    RAISE EXCEPTION 'YA SE ENCUENTRAN CARGADOS LOS DATOS PARA ESTE CLIENTE';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE
SET search_path FROM CURRENT;

--------------------
-- IDENTYFY & SEARCH
--------------------
CREATE OR REPLACE FUNCTION client_identify_by_client_id (
	IN p_client_id        text
) RETURNS client AS $$
BEGIN 
	EXECUTE 'SELECT * FROM client WHERE client_id =  ' || p_client_id || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

--------------------
-- GETTERS & SETTERS
--------------------
CREATE OR REPLACE FUNCTION client_get_client_id (
	IN p_client            client
) RETURNS integer AS $$
BEGIN 
	EXECUTE 'SELECT ' || p_client.client_id || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION client_get_type (
	IN p_client            client
) RETURNS text AS $$
BEGIN 
	EXECUTE 'SELECT ' || p_client.type || ';';
END
$$ LANGUAGE PLpgSQL STABLE STRICT
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION client_set_type (
	IN p_client           client,
	IN p_type             text
) RETURNS void AS $$
BEGIN 
	IF EXISTS (SELECT 1 FROM client WHERE client_id = p_client.client_id)
	THEN 
		UPDATE client SET type = p_type WHERE client_id = p_client.client_id;
	ELSE 
		RAISE EXCEPTION 'NO EXISTE LA PERSONA INGRESADA';
	END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE STRICT
SET search_path FROM CURRENT;

