CREATE OR REPLACE PROCEDURE determine_y(datasetName IN DatasetInfo.name%TYPE,x IN DatasetValues.X%TYPE)
IS
	
	constant DatasetInfo.constant%TYPE;
	coefficient DatasetInfo.coefficient%TYPE;
	y DatasetValues.Y%TYPE;
	isFound number := 0;

BEGIN
	FOR R IN (select constant,coefficient from DatasetInfo where name = datasetName union select constant,coefficient from DatasetInfo@server1 where name = datasetName) LOOP
		constant := R.constant;
		coefficient := R.coefficient;
		--DBMS_OUTPUT.PUT_LINE('constant = ' || constant || ' coefficient = ' || coefficient);
		
		y := constant + coefficient * x;
		DBMS_OUTPUT.PUT_LINE('value of y for x = ' || x || ' is ' || ROUND(y,3));
		isFound := 1;
	
	END LOOP;
	IF isFound = 0 THEN
		DBMS_OUTPUT.PUT_LINE('DATASET NOT FOUND');
	END IF;
END determine_y;
/