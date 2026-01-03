--SQL Intermediate

/*
Inner Joins,
Full/Left/Right/Outer Joins
*/

--Join is used to combine two or more tables

SELECT JobTitle, AVG(Salary)
FROM SQL_Tutorial.dbo.EmployeeDemographics
INNER JOIN SQL_Tutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle