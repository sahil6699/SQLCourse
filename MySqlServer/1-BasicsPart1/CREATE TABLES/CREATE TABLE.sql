--CREATE TABLE LECTURE
USE TestDatabase;
GO

--This drops the table if it exists already in db
DROP TABLE if EXISTS inventory.Furniture;

--creating a table 
-- syntax of creating a table 
/*
CREATE TABLE SCHEMA_NAME.Table_name (
    field_name1 datatype_of_field1,
    field_name2 datatype_of_field2,
    ....
)
*/

-- here we have used IDENTITY
-- indentity tell sql server that this field is the identity of this table
--  syntax:- IDENTITY(startFrom(seed number), increment)
-- it not necessary to start from 1 and increment,
--  we can even start from 100 and increment 1000 each time
-- then table columns FurnitureId would be 100,1100 ,2100,...and so on
CREATE TABLE Inventory.Furniture(
    FurnitureId INT IDENTITY(1,1),
    FurnitureType VARCHAR(50),
    FurnitureName VARCHAR(50),
    Price DECIMAL(18,4),
    Quantity int,
    ReleaseDate Date,
    CreatedDate DATETIME,
    UpdatedDate DATETIME
)

