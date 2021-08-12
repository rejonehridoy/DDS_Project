CREATE OR REPLACE PACKAGE BODY dataset_insertion AS

	FUNCTION generate_vid
	RETURN int
	IS
		vid DatasetValues.vid%TYPE;
		temp DatasetValues.vid%TYPE;

	BEGIN
		select count(vid) into temp from DatasetValues;
		select count(vid) into vid from DatasetValues@site1;
		IF temp > vid THEN
			vid := temp;
		END IF;
		vid := vid + 1;
		RETURN vid;


	END generate_vid;


	PROCEDURE insert_dataset_values(datasetName IN DatasetInfo.name%TYPE,x_value IN DatasetValues.x%TYPE,y_value IN DatasetValues.y%TYPE)
	IS
		vid DatasetValues.vid%TYPE;
		did DatasetInfo.did%TYPE := 0;
		isFound NUMBER;
		dataset_storage NUMBER;
		
	BEGIN
		
		select count(did) into isFound from DatasetInfo where name = datasetName;
		
		IF isFound = 1 THEN
			select did into did from DatasetInfo where name = datasetName;
			vid := generate_vid;
			dataset_storage := 0;	-- 0 for server
			insert into DatasetValues values(vid,did,x_value,y_value);
			DBMS_OUTPUT.PUT_LINE('value inserted into ' || datasetName);
			generate_equation(did,0);	-- 0 for server
			
		
		ELSE
			select count(did) into isFound from DatasetInfo@site1 where name = datasetName;
			
			IF isFound = 1 THEN
				select did into did from DatasetInfo@site1 where name = datasetName;
				vid := generate_vid;
				dataset_storage := 1;	-- 1 for site1
				insert into DatasetValues@site1 values(vid,did,x_value,y_value);
				DBMS_OUTPUT.PUT_LINE('value inserted into ' || datasetName);
				generate_equation(did,1);	--1 for site1
			
			ELSE
				DBMS_OUTPUT.PUT_LINE(datasetName || ' not found');
			
			END IF;
			
			
		END IF;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Invalid dataset name');
		WHEN DUP_VAL_ON_INDEX THEN
			--DBMS_OUTPUT.PUT_LINE('Duplicate vid found,cant store values');
			vid := vid + 1;
			IF dataset_storage = 0 THEN
				--server
				insert into DatasetValues values(vid,did,x_value,y_value);
				DBMS_OUTPUT.PUT_LINE('value inserted into ' || datasetName);
				generate_equation(did,0);	-- 0 for server
			
			ELSE
				--site1
				insert into DatasetValues@site1 values(vid,did,x_value,y_value);
				DBMS_OUTPUT.PUT_LINE('value inserted into ' || datasetName);
				generate_equation(did,1);	--1 for site1
			
			END IF;
		
	END insert_dataset_values;

END dataset_insertion;
/
