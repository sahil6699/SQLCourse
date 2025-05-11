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

/*
NULL - means there is nothing here in this field
if we specify NULL along side a field we are creating we saying that a NULL value can be stored here, means if the user stores nothing here while inserting value it will still not give an error

NOT NULL - if specify NOT NULL along a field then we can't save NULL in this field or user has to provide any value while saving if there is not default value

DEFAULT(value) - is something we use when we want that if the user doesn't provide any value while insert/updating value should be used
it prevents us from getting error when it is speicified as field is NOT NULL
*/
CREATE TABLE Inventory.Furniture(
    FurnitureId INT IDENTITY(1,1),
    FurnitureType VARCHAR(50) NULL,
    FurnitureName VARCHAR(50) NOT NULL,
    Price DECIMAL(18,4),
    Quantity INT DEFAULT(0) NOT NULL,
    ReleaseDate DATE,
    CreatedDate DATETIME,
    UpdatedDate DATETIME
)

select *  from Inventory.Furniture
exec sp_help 'Inventory.Furniture'
---- INSERT INTO TABLE lecture

/*
here we haven't inserted in Furniture Id because that is the identity column we let sql to generate that 
also, date should be put in iso type like 2025-08-15 
and datetime will be like 2025-08-15 20:00:00 
*/
INSERT INTO Inventory.Furniture(
    FurnitureType,
    FurnitureName,
    Price,
    Quantity,
    ReleaseDate,
    CreatedDate,
    UpdatedDate
)
VALUES(
    'Couch',
    'The Super Deluxe Section',
    1299.99,
    34,
    '2023-08-15',--put date in iso format i.e yyyy-mm-dd
    '2023-08-15 20: 00: 00',
    '2023-08-15 20: 00: 00'
)
-- select * returns all the fields in the table
SELECT * from inventory.Furniture;
-- we can return selected fields in the table by specifying which field we need
-- this is generaly fast as we only requesting the data which we need instead of all data
SELECT [FurnitureId],
    [FurnitureType],
    [FurnitureName],
    [Price],
    [Quantity] 
from inventory.Furniture

-- we can give alias to the table like
-- when we used ctrl + spacebar on mac around start we got the
-- field name as Alias_name.Field_name
-- when there are mutltiple table in a single query this helps us to differentiate which column is of which table
-- when there are multiple tables in a single query
SELECT [Furniture1].[FurnitureId],
[Furniture1].[FurnitureType],
[Furniture1].[FurnitureName],
[Furniture1].[Price],
[Furniture1].[Quantity],
[Furniture1].[ReleaseDate],
[Furniture1].[CreatedDate],
[Furniture1].[UpdatedDate] from inventory.Furniture AS Furniture1
