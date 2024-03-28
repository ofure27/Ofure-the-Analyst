--SELECT TOP (1000) [EmployeeID]
--      ,[FirstName]
--      ,[LastName]
--      ,[Age]
--      ,[Gender]
--  FROM [My SQL Tutorial].[dbo].[WareHouseEmployeeDemographics]


  --SELECT *
  --FROM [My SQL Tutorial].dbo.EmployeeDemographics
 -- Full Outer join [My SQL Tutorial].dbo.WareHouseEmployeeDemographics
 -- ON EmployeeDemographics.EmployeeID =
	--WareHouseEmployeeDemographics.EmployeeID



	--SELECT EmployeeID, FirstName, Age
	--FROM [My SQL Tutorial].dbo.EmployeeDemographics
	--UNION
	--SELECT EmployeeID, JobTitle, salary
	--FROM [My SQL Tutorial].dbo.EmployeeSalary
	--ORDER BY EmployeeID



--	SELECT Firstname, Lastname, Age,
--	CASE
--		WHEN Age = 26 THEN 'Precious'
--		WHEN Age >  24 THEN 'Old'
		
--		ELSE 'Baby'
--END 
--	FROM [My SQL Tutorial].dbo.EmployeeDemographics
--	WHERE Age is NOT NULL
--	ORDER BY Age 


	--SELECT FirstName, Lastname, JobTitle, salary
	--FROM [My SQL Tutorial].dbo.EmployeeDemographics
	--JOIN [My SQL Tutorial].dbo.EmployeeSalary
	--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


	--SELECT JobTitle, AVG(Salary)
	--FROM [My SQL Tutorial].dbo.EmployeeDemographics
	--JOIN [My SQL Tutorial].dbo.EmployeeSalary
	--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	--GROUP BY Jobtitle 
	--HAVING AVG(Salary) > 45000
	--ORDER BY AVG(Salary)


 -- SELECT *
 -- FROM [My SQL Tutorial].dbo.EmployeeDemographics
 -- JOIN [My SQL Tutorial].dbo.EmployeeSalary
	--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


 -- SELECT *
 -- FROM [My SQL Tutorial].dbo.EmployeeSalary

  --UPDATE [My SQL Tutorial].dbo.EmployeeDemographics
  --SET EmployeeID = 1012
  --Where FirstName = 'Ben' AND LastName = 'White'

  --SELECT *
  --FROM [My SQL Tutorial].dbo.EmployeeDemographics

 -- SELECT FirstName, LastName, Gender, Salary
 -- , COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
 -- FROM [My SQL Tutorial].dbo.EmployeeDemographics
 -- JOIN [My SQL Tutorial].dbo.EmployeeSalary
	--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

	-- SELECT  Gender, COUNT(Gender)
 -- , COUNT(Gender) OVER (PARTITION BY Gender) 
 -- FROM [My SQL Tutorial].dbo.EmployeeDemographics
 -- JOIN [My SQL Tutorial].dbo.EmployeeSalary
	--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	--GROUP BY Gender



--WITH CTE_Employee AS (
--    SELECT
--        FirstName,
--        LastName,
--        Gender,
--        Salary,
--        COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
--        AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
--    FROM
--        [My SQL Tutorial].dbo.EmployeeDemographics
--    JOIN [My SQL Tutorial].dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--    WHERE
--        Salary > 30000
--)
--SELECT *
--FROM
--    CTE_Employee;


--WITH CTE_Employee as 
--(SELECT FirstName, LastName, Gender, Salary
--, COUNT(Gender) OVER (PARTITION by Gender) as TotalGender
--, AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
--FROM [My SQL Tutorial].dbo.EmployeeDemographics
--JOIN [My SQL Tutorial].dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE salary > '30000'
--)
--select * 
--FROM CTE_Employee







