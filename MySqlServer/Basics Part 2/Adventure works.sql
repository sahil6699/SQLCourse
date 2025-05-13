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
SELECT TOP 5 * FROM HumanResources.Employee
Go

-- Employee pay history table
SELECT top 4 * from HumanResources.EmployeePayHistory

-- JobCandidate table
SELECT top 6 * from HumanResources.JobCandidate
