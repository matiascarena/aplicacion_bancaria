CREATE TABLE person (
        name         text NOT NULL,
        surname      text NOT NULL,
        dni          text PRIMARY KEY,
        birthday     timestamp with time zone NOT NULL,
        nationality  text
);

CREATE OR REPLACE FUNCTION person (
       IN p_name                text,
       IN p_surname             text,
       IN p_dni                 text,
       IN birthday              timestamp with time zone,
       IN nationality           text,
       IN p_contact_information contact_information
) RETUNRS person AS $$
DECLARE 
       v_person      person;
BEGIN 
      IF NOT EXISTS (SELECT 1 FROM person WHERE dni = p_dni)
      THEN
		  EXECUTE 'INSERT INTO person(name, surname, dni, birthday, nationality) VALUES (''' || p_name || ''', ''' || p_surname || ''', ''' || p_dni || ''', '''  || birthday || ''', ''' || nationality || ''') RETURNING *' INTO v_person;
		  
		  RETURN v_person;
	  ELSE
		  RAISE EXCEPTION 'Ya existe una person con este dni';
	  END IF;
END;
$$ LANGUAGE PLpgSQL VOLATILE
SET search_path FROM CURRENT;
