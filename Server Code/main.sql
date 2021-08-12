SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET LINESIZE 200;
SET PAGESIZE 100;

@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\create_package.sql";
@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\create_trigger.sql";
@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\create_view.sql";
@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\create_dataset.sql";
@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\display_dataset.sql";
@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\insert_dataset_values.sql";
@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\delete_dataset.sql";
@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\update_dataset.sql";
@"C:\Users\user\Desktop\CSE NEW\4.1\CSE4126 - Distributed Database Systems Lab\Project\determine_y.sql";


DECLARE
	action number := &action;
	datasetName DatasetInfo.name%TYPE := '&datasetName';
	updateDatasetName DatasetInfo.name%TYPE := '&updateDatasetName';
	x_value DatasetValues.x%TYPE := &X;
	y_value DatasetValues.y%TYPE := &Y;
	inserted_id number;

BEGIN
	/*DBMS_OUTPUT.PUT_LINE('1. CREATE DATASET');
	DBMS_OUTPUT.PUT_LINE('2. DISPLAY DATASETS');
	DBMS_OUTPUT.PUT_LINE('3. DISPLAY DATASET VALUES');
	DBMS_OUTPUT.PUT_LINE('4. INSERT VALUE INTO DATASET');
	DBMS_OUTPUT.PUT_LINE('5. DELETE DATASET');
	DBMS_OUTPUT.PUT_LINE('6. DELETE DATASET VALUES');
	DBMS_OUTPUT.PUT_LINE('7. UPDATE DATASET');
	DBMS_OUTPUT.PUT_LINE('8. DETERMINE VALUE OF Y');*/
	
	
	IF action = 1 THEN
		inserted_id := create_dataset(datasetName);
	ELSIF action = 2 THEN
		dataset_display.display_dataset;
		
	ELSIF action = 3 THEN
		dataset_display.display_dataset_values(datasetName);
		
	ELSIF action = 4 THEN
		dataset_insertion.insert_dataset_values(datasetName,x_value,y_value);
		
	ELSIF action = 5 THEN
		dataset_delete.delete_dataset(datasetName);
		
	ELSIF action = 6 THEN
		dataset_delete.delete_dataset_value(datasetName,x_value,y_value);
		
	ELSIF action = 7 THEN
		update_dataset(datasetName,updateDatasetName);
	
	ELSIF action = 8 THEN
		determine_y(datasetName,x_value);
	ELSE 
		DBMS_OUTPUT.PUT_LINE('Invalid Operation');
	
	END IF;
	
END;
/
commit;