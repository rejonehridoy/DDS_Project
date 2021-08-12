clear screen;
drop TABLE DatasetInfo;
drop TABLE DatasetValues;
CREATE TABLE DatasetInfo(
	did int, 
	name varchar2(30), 
	constant float, 
	coefficient float, 
        PRIMARY KEY(did)
);

CREATE TABLE DatasetValues (
	vid int, 
	did int, 
	x float, 
	y float,
	PRIMARY KEY(vid),
	FOREIGN KEY(did) REFERENCES DatasetInfo(did)
);
