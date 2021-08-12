CREATE OR REPLACE PROCEDURE generate_equation(id IN DatasetInfo.did%TYPE,data_storage IN NUMBER)
IS
	sum_x DatasetValues.X%TYPE;
	sum_y DatasetValues.Y%TYPE;
	avg_x DatasetValues.X%TYPE;
	avg_y DatasetValues.Y%TYPE;
	xx DatasetValues.X%TYPE := 0;
	xy DatasetValues.Y%TYPE := 0;
	a DatasetInfo.constant%TYPE;
	b DatasetInfo.coefficient%TYPE;
	n integer;

BEGIN
	select count(vid) into n from (select vid from datasetvalues where did = id union select vid from datasetvalues@server1 where did = id);
	select sum(x),sum(y) into sum_x,sum_y from (select did,x,y from datasetvalues union select did,x,y from datasetvalues@server1) where did = id;
	select avg(x),avg(y) into avg_x,avg_y from (select did,x,y from datasetvalues union select did,x,y from datasetvalues@server1) where did = id;
	
	FOR R in (select X,Y from datasetvalues where did = id union select X,Y from datasetvalues@server1 where did = id) LOOP
		xx := xx + R.X * R.X;
		xy := xy + R.X * R.Y;
	END LOOP;
	
	
	b := (n * xy - (sum_x*sum_y)) / (n * xx - (sum_x * sum_x));
	a := avg_y - (b * avg_x);

	--save data into DatasetInfo table y = a + bx, where a = constant, b = coefficient
	IF data_storage = 0 THEN
		-- store value at server
		update DatasetInfo@server1 set constant = a, coefficient = b where did = id;
	ELSE
		-- store value at site1
		update DatasetInfo set constant = a, coefficient = b where did = id;
	END IF;
	
EXCEPTION
	WHEN ZERO_DIVIDE THEN
		DBMS_OUTPUT.PUT_LINE('Invalid operation causes divide by zero.Need at least 2 pair of data to generate equation');
	


END generate_equation;
/