--SUBQUERIES (IN THE SELECT, FROM AND WHERE STATEMENT)


SELECT *
FROM [My SQL Tutorial].dbo.EmployeeSalary


--SUBQUERY IN SELECT

SELECT EmployeeID, Salary, (select AVG(Salary) from [My SQL Tutorial].dbo.EmployeeSalary) as AllAvgSalary
from [My SQL Tutorial].dbo.EmployeeSalary



--HOW TO DO IT WITH PARTITION BY

SELECT EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
from [My SQL Tutorial].dbo.EmployeeSalary


--WHY GROUP BY DOESN'T WORK

SELECT EmployeeID, Salary, AVG(Salary) as AllAvgSalary
from [My SQL Tutorial].dbo.EmployeeSalary
GROUP BY EmployeeID, salary
order by 1,2


--SUBQUERY IN FROM

SELECT *
FROM (SELECT EmployeeID, Salary, AVG(salary) over () as AllAvgSalary
	  from [My SQL Tutorial].dbo.EmployeeSalary)



--SUBQUERY IN WHERE

Select EmployeeID, JobTitle, Salary
from [My SQL Tutorial].dbo.EmployeeSalary
where EmployeeID in (
	select *
	from [My SQL Tutorial].dbo.EmployeeDemographics)



SELECT EmployeeID, JobTitle, Salary
FROM [My SQL Tutorial].dbo.EmployeeSalary
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM [My SQL Tutorial].dbo.EmployeeDemographics
	where Age > 30
);
