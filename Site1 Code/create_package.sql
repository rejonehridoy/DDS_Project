CREATE OR REPLACE PACKAGE dataset_insertion AS
	FUNCTION generate_vid
	RETURN INT;
	
	PROCEDURE insert_dataset_values(datasetName IN DatasetInfo.name%TYPE,x_value IN DatasetValues.x%TYPE,y_value IN DatasetValues.y%TYPE);
END dataset_insertion;
/

CREATE OR REPLACE PACKAGE dataset_display AS
	
	PROCEDURE display_dataset;
	PROCEDURE display_dataset_values(datasetname IN DatasetInfo.name%TYPE);
	
END dataset_display;
/

CREATE OR REPLACE PACKAGE dataset_delete AS
	
	PROCEDURE delete_dataset(datasetName IN DatasetInfo.name%TYPE);
	PROCEDURE delete_dataset_value(datasetName IN DatasetInfo.name%TYPE,x_value IN DatasetValues.x%TYPE,y_value IN DatasetValues.y%TYPE);
	
END dataset_delete;
/