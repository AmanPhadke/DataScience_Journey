/*
Having Clause
*/


SELECT JobTitle,AVG(Salary)
FROM SQL_Tutorial.dbo.EmployeeDemographics
JOIN SQL_Tutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeId = EmployeeSalary.EmployeeId
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)
