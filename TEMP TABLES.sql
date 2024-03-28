CREATE TABLE #temp_Employee (
EmployID int,
JobTitle varchar(100),
Salary int
)

Select *
FROM #temp_Employee

--insert into #temp_Employee values (
--'1001', 'HR', '45000'
--)


insert into #temp_Employee
select *
from [My SQL Tutorial].dbo.EmployeeSalary


DROP TABLE IF EXISTS #temp_Employee
Create table #Temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)



insert into #Temp_Employee2
select JobTitle, COUNT(JobTitle), AVG(age), AVG(salary)
FROM [My SQL Tutorial].dbo.EmployeeDemographics
JOIN [My SQL Tutorial].dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle



select *
from #Temp_Employee2






--insert into [My SQL Tutorial].dbo.EmployeeSalary values
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)


--DROP TABLE IF EXISTS #Temp_Employee2
--Create table #Temp_Employee2 (
--JobTitle varchar(50),
--EmployeesPerJob int,
--AvgAge int,
--AvgSalary int)











