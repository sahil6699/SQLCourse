USE AdventureWorks2019
------------ order by clause----------
-- ORDER BY clause is used to sort the data
-- we can sort it ascending or descending
-- if we don't mention asc or desc by default asc is applied
-- like 'ORDER BY GroupName' here we have not mention asc or desc so it will take asc by default
-- ORDER BY is first applied to the first value we write accross order by and then by that value is if multiple, then inside that value second one written after comma in order is applied
-- for both we have to seprately mention asc or desc or whose one which is not mentioned will be considered asc by default
SELECT [DepartmentID],
    [Name],
    [GroupName],
    [ModifiedDate]
FROM HumanResources.Department
-- ORDER BY GroupName, [Name]
ORDER BY GroupName ASC, [Name] DESC
-- ORDER by GroupName DESC, [Name] DESC

