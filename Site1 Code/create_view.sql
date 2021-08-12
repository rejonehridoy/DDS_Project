CREATE OR REPLACE VIEW all_dataset_info AS
select * from DatasetInfo union select * from DatasetInfo@server1;

CREATE OR REPLACE VIEW all_dataset_values AS
select did,x,y from datasetvalues union select did,x,y from datasetvalues@server1;