-- Load input file from HDFS
salesTable = LOAD 'hdfs:///user/ravi/sales.csv' Using PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group Data 
FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the total number of words (Reduce)
totalCount = FOREACH grpd GENERATE $0, COUNT($1);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
--Delete the
--rmf hdfs:///user/ravi/PigOutput;
-- Store the result/output in HDFS
STORE totalCount INTO 'hdfs:///user/ravi/PigOutput';
