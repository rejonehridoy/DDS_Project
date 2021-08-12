CREATE OR REPLACE PROCEDURE update_dataset(datasetName IN DatasetInfo.name%TYPE,updateDatasetName IN DatasetInfo.name%TYPE)
IS
	
	isUpdated number := 0;

BEGIN
	
	FOR R in (select * from DatasetInfo@server1 where name = datasetName) LOOP
		update DatasetInfo@server1 set name = updateDatasetName where did = R.did;
		isUpdated := 1;
		
	END LOOP;
	
	IF isUpdated = 0 THEN
		FOR R in (select * from DatasetInfo where name = datasetName) LOOP
			update DatasetInfo set name = updateDatasetName where did = R.did;
			isUpdated := 1;
			
		END LOOP;
	END IF;
	
	IF isUpdated = 0 THEN
		DBMS_OUTPUT.PUT_LINE('Dataset not found');
	
	END IF;
	

END update_dataset;
/