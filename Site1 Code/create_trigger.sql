
CREATE OR REPLACE TRIGGER delete_datasetinfo
AFTER DELETE
ON DatasetInfo
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Dataset deleted successfully');
END;
/

CREATE OR REPLACE TRIGGER delete_datasetvalues
AFTER DELETE
ON DatasetValues
FOR EACH ROW
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Data deleted successfully');
END;
/


CREATE OR REPLACE TRIGGER update_datasetinfo 
AFTER UPDATE
OF NAME
ON DatasetInfo
FOR EACH ROW
DECLARE
	prev_name DatasetInfo.name%TYPE;
	new_name DatasetInfo.name%TYPE;
BEGIN
	prev_name := :OLD.name;
	new_name := :NEW.name;
	DBMS_OUTPUT.PUT_LINE(prev_name || ' updated successfully into ' || new_name);
END;
/
