DROP DATABASE mysql;
CREATE DATABASE mysql;
USE mysql;
CREATE TABLE Myfirst_Table
(
	first_column varchar(10),
	second_column varchar(10),
	third_column float,
	fourth_column smalldatetime,
	fifth_column decimal(5,1)
)

SELECT * FROM Myfirst_Table
INSERT INTO Myfirst_Table 
(
first_column,
second_column,
third_column,
fourth_column,
fifth_column
)
VALUES (
'Dang Minh',
'1312',
80,
'12-13-2004',
5.65
)
DELETE FROM Myfirst_Table
WHERE fourth_column IS NULL