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

/*
syntax:- 
select * from table_name
or 

select field_name1,field_name2,...
from table_name
*/
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

-- Basic update without where clause
/*
syntax:- 
UPDATE table_name
set field_name=field_value
where fielname=field_value
*/
-- this will update the whole table, it is usually not recommended update statement should always be used with the where clause
UPDATE inventory.Furniture
SET Quantity=40


----ALTER TABLE LECTURE
/*
this will give error as:- 
"ALTER TABLE only allows columns to be added that can contain nulls, or have a DEFAULT definition specified, or the column being added is an identity or timestamp column, or alternatively if none of the previous conditions are satisfied the table must be empty to allow addition of this column. Column 'subcategory' cannot be added to non-empty table 'Furniture' because it does not satisfy these conditions."
*/
ALTER TABLE inventory.Furniture
ADD  subcategory VARCHAR(50) NOT NULL; 

-- to fix this we have to use DEFAULT AS given below
ALTER TABLE Inventory.Furniture
ADD subcategory NVARCHAR(50) NOT NULL DEFAULT('')

SELECT * from inventory.Furniture

-- now how to drop a column inside the table
-- this code is correct but it gave errors below given as because 
-- we tried to drop the column without removing the CONTSTRAINT of default value for subcategory
-- so in any case if we have a column with default value we first have to remove the constraint of default value first and then we can remove the column on which this default value is dependent upon
/*

The object 'DF__Furniture__subca__4F7CD00D' is dependent on 
column 'subcategory'.
ALTER TABLE DROP COLUMN subcategory failed because one or more objects 
access this column.
*/
ALTER TABLE inventory.Furniture
DROP COLUMN subcategory 

-- to fix above issue we'll first drop the constrant of default value
-- syntax:- DROP CONSTRAINT constraint_name
ALTER TABLE inventory.Furniture
DROP CONSTRAINT DF__Furniture__subca__4F7CD00D
-- now this will not give any error
ALTER TABLE inventory.Furniture
DROP COLUMN subcategory 

SELECT * from inventory.Furniture

-- now lets add the new column which allows nullable values
ALTER TABLE inventory.Furniture
ADD subcategory VARCHAR(50)
-- now to drop it
-- it easily got dropped because it didn't have any CONSTRAINT of default value
ALTER TABLE inventory.Furniture
DROP COLUMN subcategory

-- now lets test if we add a column using alter which 
-- has nullable fields allowed and we add default value as DEFAULT('')
-- anybody would think that if default value is '' and nullable is allowed 
--  then '' would be saved in subcategory but NULL is saved actually
-- this is because we haven't explicitly inserted nothing in subcategory so that it would go back to default value
-- and since null is allowed so during alter it will give all columns as null
ALTER TABLE inventory.Furniture
ADD subcategory VARCHAR(50) NULL DEFAULT('');
-- now that we have explicitly didn't gave any value it saved '' in the subcategory
INSERT INTO inventory.Furniture(
 [FurnitureType],
[FurnitureName],
[Price],
[Quantity],
[ReleaseDate],
[CreatedDate],
[UpdatedDate]  
)VALUES(
   ' FurnitureType',
'[FurnitureName]',
345,
23,
GETDATE(),
GETDATE(),
GETDATE()
)
-- now that we have explicitly gave it null so since null is allowed it is saving null rather than going to default value
INSERT INTO inventory.Furniture(
 [FurnitureType],
[FurnitureName],
[Price],
[Quantity],
[ReleaseDate],
[CreatedDate],
[UpdatedDate],
[subcategory]  
)VALUES(
   ' FurnitureType',
'[FurnitureName]',
345,
23,
GETDATE(),
GETDATE(),
GETDATE(),
null
)

-- now lets drop the subcategory column again
ALTER TABLE inventory.Furniture
DROP COLUMN subcategory
--it gives error
-- but first remember we have to remove the default value constraint,so
ALTER TABLE inventory.Furniture
DROP CONSTRAINT DF__Furniture__subca__5070F446
-- now lets try to drop again it will work
ALTER TABLE inventory.Furniture
DROP COLUMN subcategory
-- yes it worked
select * from inventory.Furniture
-- now after dropping i am adding it again
ALTER TABLE inventory.Furniture
ADD subcategory VARCHAR(50)


-- now lets say we have to alter the subcategory and make it not null
-- and also lets change its data type to say nvarchar(150)
-- below  statement is giving error because of 2 reason
    -- 1 we are making it null but not giving any default value while we are making it not null viz not correct
    -- 2 there are already NULL values saved in subcategory column so first we have to remove them
-- to fix above point 
    -- 1 we have to add default constraint, lets add it using add constraint command this time
    -- 2 we have to change already saved value of null to some other value like '' 
/*
Cannot insert the value NULL into column 'subcategory', table 'TestDatabase.inventory.Furniture'; column does not allow nulls. UPDATE fails.
The statement has been terminated.
*/
ALTER TABLE inventory.Furniture
ALTER COLUMN subcategory NVARCHAR(50) NOT NULL

-- working on above fixing points we discussed
-- 1 add constraint command
ALTER TABLE inventory.Furniture
ADD CONSTRAINT DF__Furniture__subcategory DEFAULT '' FOR subcategory

-- 2 update the subcategory value from null to ''(default)
UPDATE inventory.Furniture
set subcategory=default

select * from inventory.Furniture

-- now we have implemented our 2 fixes i.e changed already saved value from null to '' and added default constraint for subcategory
-- now lets make it not null
/* error occured
The object 'DF__Furniture__subcategory' is dependent on column 'subcategory'.
ALTER TABLE ALTER COLUMN subcategory failed because one or more objects access this column.
*/
-- now it still gave error because
-- we are trying to replace and change it/alter the field subcategory of VARCHAR(50) with subcategory of NVARCHAR(50)
-- with a already saved CONSTRAINT of default, so when there is a constraint present we can't replace with other /alter it
-- so first we have to remove the constraint, then alter the category back again with nvarchar and then again add the constraint
ALTER TABLE inventory.Furniture
ALTER COLUMN subcategory NVARCHAR(50)  NOT NULL

select * from inventory.Furniture
-- dropping constraing
ALTER TABLE inventory.Furniture
DROP CONSTRAINT DF__Furniture__subcategory
-- now we have implemented these steps lets make the column not nullable using alter and then add default constraint again
ALTER TABLE inventory.Furniture
ALTER COLUMN subcategory NVARCHAR(150) NOT NULL

-- adding constraint again as said above
/*
syntax to add constraint of default for any field
ALTER TABLE schema_name.table_name
ADD CONSTRAINT name_of_constraint DEFAULT value_of_default FOR name_of_column
*/
ALTER TABLE inventory.Furniture
ADD CONSTRAINT DF__Furniture__subcategory DEFAULT '' FOR subcategory


-- CUSTOM TYPES lecture
-- actual idea for custom type is that we standardize the use of some specific type, so if we use the named type it will be same as the orignal data type
-- CREATE TYPE schema_name.type_name FROM data_type_to_be_made_from
-- now instead of writing varchar(255) again and again we can use dbo.String and there are some project which follow this
CREATE TYPE dbo.String FROM VARCHAR(255)
DECLARE @MyString dbo.String = 'My string value which can stoRe 255 unicode characters that take each take 1 byte'
SELECT @MyString

-- how to look at all of the types in our db
-- in this output we can not the we have our user defined data type string in there and the column is_user_defined is 1 for that
-- we can check if some data type is based on data type by checking that their system_type_id are not same as user_type_id and they are same for some other
-- like sysname is based on nvarchar it has same system_type_id of 231 as nvarchar but is user_type_id is not same it is 256
-- also our created String is based on varchar it has same system_type_id as varchar of 167 but its user_type_id is different as 257
-- but for varchar its both system_type_id and user_type_id are 167
-- same for nvarchar they both are same as 231
SELECT * from sys.types