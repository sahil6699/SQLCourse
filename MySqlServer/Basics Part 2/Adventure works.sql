-- top lecutre
USE AdventureWorks2019 
GO 

-- top  returns only the nuber of columns we have requested
-- like here we have reqeuested 7
-- department table which has the list of all the departments in the  company
SELECT TOP 7[DepartmentID],
    [Name],
    [GroupName],
    [ModifiedDate] 
 FROM HumanResources.Department;


 /*
 TOP Assignment
Hello!

TOP is a great tool for quickly finding out what kind of information is in a table.

Now that you have learned how to use the TOP keyword, lets explore the other tables on the Human Resources Schema using TOP.

Use TOP to take a look at the top 10 records from the following tables:



Shift

Employee

EmployeeDepartmentHistory

EmployeePayHistory

JobCandidate
 */

--  Shift table- which is a master table and has a record of all the shifts availiable in the company
-- seeing top 2 records
SELECT top 2 [ShiftID],
[Name],
[StartTime],
[EndTime],
[ModifiedDate] from HumanResources.Shift;
Go
-- Employee table
SELECT TOP 5 [BusinessEntityID],
[NationalIDNumber],
[LoginID],
[OrganizationNode],
[OrganizationLevel],
[JobTitle],
[BirthDate],
[MaritalStatus],
[Gender],
[HireDate],
[SalariedFlag],
[VacationHours],
[SickLeaveHours],
[CurrentFlag],
[rowguid],
[ModifiedDate] FROM HumanResources.Employee
Go

-- Employee pay history table
SELECT top 4 [BusinessEntityID],
    [RateChangeDate],
    [Rate],
    [PayFrequency],
    [ModifiedDate]
 from HumanResources.EmployeePayHistory

-- JobCandidate table
SELECT top 6 [JobCandidateID],
    [BusinessEntityID],
    [Resume],
    [ModifiedDate] from HumanResources.JobCandidate

-------------------------------
-- WHERE CLAUSE
-- where clause is used to filter data
SELECT [DepartmentID],
    [Name],
    [GroupName],
    [ModifiedDate]
 FROM HumanResources.Department
--  WHERE DepartmentID > 7 
-- WHERE Name='Production Control';
-- WHERE GroupName='MANUFACTURING'
---- this gives result that ends with production
-- WHERE [Name]  LIKE '%Production'
-- this gives results that starts with Production
-- this search is generally more faster as sql normally finds thing by first sorting them in alphabetical order and then finding them
-- WHERE [Name] LIKE 'Production%';
-- when we to find something i.e in between the word(string) then we use %automation1%
-- WHERE [Name] LIKE '%Production%'
-- WHERE GroupName = 'Manufacturing' -- is equal
-- WHERE GroupName <> 'Manufacturing' -- is not equal
WHERE DepartmentID <> 7 -- this gives results with departmentId not equal to 7


-- we can't compare with NULL using =(equal to) and <> (not equal to) it will always give false result as comparison with null using these operators is not possible
-- eg:- 
-- this is false because not we can't compare to null not becuase there is no null value in table
SELECT * from HumanResources.Department
where GroupName = NULL

-- similarty not equal to null also not give any ouput as we can't compare with null
SELECT * from HumanResources.Department
WHERE GroupName <> NULL

-- we can also compare null = null this will also give empty ouput
-- this should have true according to a newbie programmer but since in sql we can't compare to null hence it will be false
SELECT * from HumanResources.Department
WHERE null = null

-- similarly we null <> null is also gives false for condtion or no ouput
SELECT * from HumanResources.Department
where NULL <> NULL

-- For comparing with NULL we have to use 
-- IS NULL -- for checking values equal to NULL
SELECT [DepartmentID],
[Name],
[GroupName],
[ModifiedDate] from HumanResources.Department
where GroupName IS NULL


-- IS NOT NULL -- for checking values which are not equal to null
SELECT [DepartmentID],
    [Name],
    [GroupName],
    [ModifiedDate]
 FROM HumanResources.Department
 WHERE GroupName IS NOT NULL

--  if we wanted to  print multiple values then we could 'IN' keyword
SELECT [DepartmentID],
    [Name],
    [GroupName],
    [ModifiedDate]
FROM HumanResources.Department
-- finding multiple integer values
-- WHERE DepartmentID IN(7,11) -- this will give results which have DepartmentId as 7 and 11
-- finding multiple string values
-- WHERE [Name] in ('PRODUCTION','Sales') -- this will gives resuls which have name as Sales and Production
-- for finding something in between INT values it doesn't work for string and both starting no and end no are included in result
WHERE DepartmentID between 7 AND 11


-- using AND and Or keywords

-- for AND both condition need to be true
SELECT * 
from HumanResources.Department
where GroupName = 'Manufacturing'
AND DepartmentID BETWEEN 7  AND 11

-- for OR even if one condition is true the results come
-- its almost like finding results for two different condition and then joining them
SELECT * FROM 
HumanResources.Department
WHERE GroupName = 'Manufacturing'
or DepartmentID BETWEEN 7 and 11


-- assignment find all the employees which are married
SELECT [BusinessEntityID],
[NationalIDNumber],
[LoginID],
[OrganizationNode],
[OrganizationLevel],
[JobTitle],
[BirthDate],
[MaritalStatus],
[Gender],
[HireDate],
[SalariedFlag],
[VacationHours],
[SickLeaveHours],
[CurrentFlag],
[rowguid],
[ModifiedDate] from HumanResources.Employee
WHERE MaritalStatus = 'M'


-------------DELETE CLAUSE-----------
-- always run a select clause with same condition as delete clause before running the actual delete clause 
-- as there can be sometimes complex condition which you have not taken care and after using delete there is not way to get them back 
SELECT * FROM HumanResources.Department
WHERE DepartmentID=7

DELETE FROM HumanResources.Department
WHERE DepartmentID=7
/*
Msg 547, Level 16, State 0, Line 1
The DELETE statement conflicted with the REFERENCE constraint 
"FK_EmployeeDepartmentHistory_Department_DepartmentID". The conflict occurred in database "AdventureWorks2019", 
table "HumanResources.EmployeeDepartmentHistory", column 'DepartmentID'.
*/
-- we get above error when trying to delete the above row of the table 
-- because it is a foriegn key in another table 
-- so we first have to delete all the records with this field in that table and then come to delete here

SELECT * FROM HumanResources.EmployeeDepartmentHistory
WHERE DepartmentID=7
DELETE FROM HumanResources.EmployeeDepartmentHistory
WHERE DepartmentID=7


--------------------------------UPDATE CLAUSE-----------------------
--  if we want we can select the rows that are being updated with the condition in the update clause to see which fields are being updated

SELECT * FROM HumanResources.Department
WHERE DepartmentID=6

UPDATE HumanResources.Department
SET [Name] = 'R and D'
WHERE DepartmentID=6

-- now we'll update the group name from Research and Development to R and D
SELECT DepartmentID from HumanResources.Department
WHERE GroupName='Research and Development'

SELECT * FROM HumanResources.Department
WHERE GroupName='Research and Development'

-- should we go with this or below one which is better and which would work?
UPDATE HumanResources.Department
SET GroupName='R and D'
WHERE GroupName='Research and Development'

-- both will work correctly
UPDATE HumanResources.Department
SET GroupName='R and D'
WHERE DepartmentID in (SELECT DepartmentID FROM HumanResources.Department WHERE GroupName='Research and Development')

-------------------------------------INTO CLAUSE-------------------------
-- again running this code will error as into statement always creates a new table
-- this will not insert entries again into same table but give an error as into statement always creates a new table and then inserts into it
-- we can avoid the error by writting DROP Table_name IF EXISTS but this will create a new table and inserted into that and drop the already saved table if saved , this will not make a new entry to the same table
DROP  TABLE IF EXISTS HumanResources.DepartmentCopy
SELECT [DepartmentID],
    [Name],
    [GroupName],
    [ModifiedDate]
    INTO HumanResources.DepartmentCopy
FROM HumanResources.Department
-- we can use where condition too with into this will copy only the things that satify the condition
WHERE DepartmentID >7

SELECT * from HumanResources.DepartmentCopy


-------------------------TRUNCATE STATEMENT---------------
-- remmember : in truncate we reset the table as empty table
INSERT INTO HumanResources.DepartmentCopy(
    [Name],
    [GroupName],
    [ModifiedDate]
) VALUES('Random Name', 'Random Group',GETDATE())

SELECT * from HumanResources.DepartmentCopy

-- TRUNCATE SYNTAX
-- TRUNCATE Object_name(TABLE) table_name(object_name_set_by_user)
-- TRUNCATE has one main functionality that it resets the identity and everything and delete doesn't do it we start from where the last delte ended in that case
TRUNCATE TABLE HumanResources.DepartmentCopy

-- in case of delete it will start from the id where the last one ended where as truncate will start like a new session
DELETE from HumanResources.DepartmentCopy WHERE 1=1
