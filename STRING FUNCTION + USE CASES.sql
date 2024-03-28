
--create table EmployeeErrors (
--EmployeeID varchar(50)
--,FirstName varchar(50)
--,LastName varchar(50)
--)

--insert into EmployeeErrors values
--('1001  ', 'Jimbo', 'Halbert')
--,('  1002', 'Pamela', 'Beasely')
--,('1005', 'TOby', 'Flenderson - Fired')


Select *
from EmployeeErrors




--Using Trim, LTRIM, RTRIM


SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors


--SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
--FROM EmployeeErrors


--SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
--FROM EmployeeErrors



--Using Replace 

--SELECT LastName, REPLACE(LastName, '- Fired','') as LastNameFixed
--FROM EmployeeErrors




----Using Substring

SELECT SUBSTRING(FirstName,1,3)
FROM EmployeeErrors




----Using UPPER and Lower
  
--SELECT LastName, LOWER(FirstName)
--FROM EmployeeErrors


--SELECT LastName, UPPER(FirstName)
--FROM EmployeeErrors
