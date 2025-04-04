
use master

DROP DATABASE IF EXISTS TempDatabase
CREATE DATABASE TempDatabase
Go

use TempDatabase
GO

-- I am gonna consider this table TempDataBase a database of furnitures so we are creating a schema ofinventory in this db
-- schema is like giving folders to a particular type of data
-- lets there is a schema of all the properties you own i.e Properties which say furniture or list of all properites
-- but a schema of Company there is will contain lists of all the employees, shareholders, stakeholders,etc 
--CREATE SCHEMA name_of_schema
CREATE SCHEMA Inventory
---------------------------------------------------------------------------------------------------------------------------------------
-- if we want to create a new schema and discard already saved schema then we use this
use TempDatabase
GO

DROP SCHEMA  IF EXISTS Inventory
Go
-- we had to write Go above create schema must the the first command of the batch 
CREATE SCHEMA Inventory
