CREATE OR REPLACE PACKAGE BODY dataset_display AS
	PROCEDURE display_dataset
	IS
		
	BEGIN
		DBMS_OUTPUT.PUT_LINE('DID  NAME      CONSTANT  COEFFICIENT');
		FOR R IN (select * from all_dataset_info) LOOP
			DBMS_OUTPUT.PUT_LINE(R.did || '    ' || R.name || '    ' || ROUND(R.constant,3) || '      ' || ROUND(R.coefficient,3));
		END LOOP;
		
	END display_dataset;

	PROCEDURE display_dataset_values(datasetname IN DatasetInfo.name%TYPE)
	IS
		
	BEGIN
		DBMS_OUTPUT.PUT_LINE('VID    X    Y');
		FOR R IN (select dv.vid,dv.X,dv.Y from (select * from DatasetValues union select * from DatasetValues@server1) dv 
			inner join (select * from DatasetInfo union select * from DatasetInfo@server1) di on dv.did = di.did where 
			di.name = datasetname) LOOP
			DBMS_OUTPUT.PUT_LINE(R.vid || '     ' || R.X || '   ' || R.Y);
		END LOOP;

	END display_dataset_values;

END dataset_display;
/


