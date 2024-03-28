--STORED PROCEDURE TEST


CREATE PROCEDURE TEST
AS
SELECT *
FROM [My SQL Tutorial].dbo.EmployeeDemographics

Exec TESTT

CREATE PROCEDURE Temp_Employee 
AS
Create table #Temp_Employee (
JobTitle varchar(50) ,
EmployeesPerJob int ,
AvgAge int,
AvgSalary int,
)




insert into #Temp_Employee
select JobTitle, COUNT(JobTitle), AVG(age), AVG(salary)
FROM [My SQL Tutorial].dbo.EmployeeDemographics
JOIN [My SQL Tutorial].dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #Temp_Employee


EXEC Temp_Employee


--ALTER PROCEDURE........

ALTER PROCEDURE [dbo].[Temp_Employee]
@JobTitle nvarchar(100)
AS
Create table #Temp_Employee (
JobTitle varchar(100) ,
EmployeesPerJob int ,
AvgAge int,
AvgSalary int,
)


insert into #Temp_Employee
select JobTitle, COUNT(JobTitle), AVG(age), AVG(salary)
FROM [My SQL Tutorial].dbo.EmployeeDemographics
JOIN [My SQL Tutorial].dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	WHERE JobTitle = @JobTitle
GROUP BY JobTitle



SELECT *
FROM #Temp_Employee


EXEC Temp_Employee @JobTitile = 'Saleman'