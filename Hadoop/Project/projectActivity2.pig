-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/ravi/episodeIV_dialogues.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the total number of words (Reduce)
ordpd = ORDER words by word DES;

totalCount = FOREACH grpd GENERATE $0, COUNT($1);

--Delete the 
rmf hdfs:///user/ravi/PigOutput; 
-- Store the result/output in HDFS
STORE totalCount INTO 'hdfs:///user/ravi/PigOutput';
