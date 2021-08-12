CREATE OR REPLACE PACKAGE BODY dataset_delete AS

	PROCEDURE delete_dataset(datasetName IN DatasetInfo.name%TYPE)
	IS
		
		isDeleted number := 0;

	BEGIN
		FOR R in (select did from DatasetInfo where name = datasetName) LOOP
			delete DatasetValues where did = R.did;
			delete DatasetInfo where did = R.did;
			isDeleted := 1;
			
		END LOOP;
		
		IF isDeleted = 0 THEN
			FOR R in (select did from DatasetInfo@site1 where name = datasetName) LOOP
				delete DatasetValues@site1 where did = R.did;
				delete DatasetInfo@site1 where did = R.did;
				isDeleted := 1;
				DBMS_OUTPUT.PUT_LINE('DATASET DELETED');
				
			END LOOP;
		END IF;
		
		IF isDeleted = 0 THEN
			DBMS_OUTPUT.PUT_LINE('DATASET NOT FOUND');
		END IF;


	END delete_dataset;



	PROCEDURE delete_dataset_value(datasetName IN DatasetInfo.name%TYPE,x_value IN DatasetValues.x%TYPE,y_value IN DatasetValues.y%TYPE)
	IS
		
		isDeleted NUMBER := 0;
		id DatasetInfo.did%TYPE;

	BEGIN

		FOR R IN (select vid from (select vid,x,y from datasetvalues where did in 
			(select did from datasetinfo where name = datasetName)) where x = x_value and y = y_value) LOOP
			
			delete datasetvalues where vid = R.vid;
			isDeleted := 1;
			select did into id from datasetinfo where name = datasetName;
			
			--generate the equation again
			generate_equation(id,0);	-- 0 for server
		
		END LOOP;
		
		IF isDeleted = 0 THEN
			FOR R IN (select vid from (select vid,x,y from datasetvalues@site1 where did in 
				(select did from datasetinfo@site1 where name = datasetName)) where x = x_value and y = y_value) LOOP
				
				delete datasetvalues@site1 where vid = R.vid;
				isDeleted := 1;
				
				select did into id from datasetinfo@site1 where name = datasetName;
				--generate the equation again
				generate_equation(id,1);	-- 1 for site1
				DBMS_OUTPUT.PUT_LINE('Data Deleted successfully from site1');
		
			END LOOP;
		
		END IF;
		
		IF isDeleted = 0 THEN
			DBMS_OUTPUT.PUT_LINE('NO DATA FOUND TO DELETE');
		END IF;


	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');

	END delete_dataset_value;


END dataset_delete;
/