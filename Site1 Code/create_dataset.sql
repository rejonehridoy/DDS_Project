CREATE OR REPLACE FUNCTION create_dataset(dataset_name IN DatasetInfo.name%TYPE)
RETURN number
IS
	
	did DatasetInfo.did%TYPE;
	total_size DatasetInfo.did%TYPE :=0;
	isExist NUMBER := 0;
BEGIN
	
	FOR R IN (select * from datasetinfo where name = dataset_name union select * from datasetinfo@server1 where name = dataset_name) LOOP
		isExist := 1;
	END LOOP;
	
	IF isExist = 0 THEN
		select count(did) into total_size from all_dataset_info;
		did := total_size + 1;
		
		--if new inserted did is even then data will store into server pc,otherwise in the site pc
		IF MOD(did,2) = 0 THEN
			insert into DatasetInfo@server1 values(did,dataset_name,0,0);
			DBMS_OUTPUT.PUT_LINE('Dataset created in server');
		ELSE
			insert into DatasetInfo values(did,dataset_name,0,0);
			DBMS_OUTPUT.PUT_LINE('Dataset created in site1');
		END IF;
		
		RETURN did;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Dataset already exist');
		RETURN 0;
	
	END IF;
	
END create_dataset;
/