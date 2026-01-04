/*
Partition By
*/

SELECT FirstName, LastName, Gender, Salary,
	COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM SQL_Tutorial.dbo.EmployeeDemographics AS demo
JOIN SQL_Tutorial.dbo.EmployeeSalary AS sal
	ON demo.EmployeeID = sal.EmployeeID

--SELECT Gender, COUNT(Gender)
--FROM SQL_Tutorial.dbo.EmployeeDemographics AS demo
--JOIN SQL_Tutorial.dbo.EmployeeSalary AS sal
--	ON demo.EmployeeID = sal.EmployeeID
--GROUP BY Gender