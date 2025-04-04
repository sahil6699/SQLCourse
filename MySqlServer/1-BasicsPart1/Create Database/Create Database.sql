-- command to create a database
--CREATE OBJECT_TYPE(DATABASE) name_of_object
CREATE DATABASE SAHIL 
GO
-- command to delete/drop a whole object(database)
-- DROP OBJECT_TYPE(DATABASE) name_of_objec
DROP DATABASE SAHIL 
GO
-- command to select which database to use
use master
CREATE DATABASE TempDatabase
GO

use master
DROP DATABASE TempDatabase
GO

-- command to see list of all the databases in sql server
-- we can also see the same list from the dropdown above 
-- and select which database to se from the same
SELECT * FROM sys.databases
GO
-- but we sometimes go to the command - "USE database_name"
-- this is done because lets say we are using database TempDatabase and we are using drop command on TempDatabase then we can't drop it as we are currently using it
-- so to do that we first have to switch from one database to another to delete that databse

--lets say we have a scenario- we have to drop the database TestDatabse if it exist and create a new one
-- but we are currently on TestDatabse so we can't do it unless we change database
-- want to comeback againi to this newly created TestDatabse
-- how can we do it?

-- so do do that we can do is:- 

use master
DROP DATABASE IF EXISTS TempDatabase
CREATE DATABASE TempDatabase
use TempDatabase
GO

--GO keyword
--Go makes 
-- "GO" indicates the end of a batch of SQL statements.
-- Execution Context:

-- All commands before "GO" are executed together; commands after "GO" are treated as a new batch.
-- Required for Certain Operations:

-- Necessary for creating or altering database objects like stored procedures, which must be first in a batch.
-- Script Organization:

-- Helps organize scripts by separating logical code sections for better readability and execution flow.
-- Example:
-- Code
CREATE DATABASE SampleDB;
GO
USE SampleDB;
GO
CREATE TABLE Users (ID INT, Name NVARCHAR(50));
GO
-- ** one imp point of using go is that
/* In this example, "GO" ensures that each command (creating the database, switching to that database, and creating a table) runs in its own context.
Multiple Queries:
If you ran all commands in a query window without "GO," SQL Server would attempt to execute them all together. This isn't always valid, especially when certain commands depend on the successful completion of s*/