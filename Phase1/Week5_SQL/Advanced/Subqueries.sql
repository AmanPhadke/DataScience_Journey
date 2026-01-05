/*
Subqueries
*/


SELECT *
FROM EmployeeSalary

--Subquery in select

SELECT EmployeeID, Salary, 
	(SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSal
FROM EmployeeSalary

--Using Partition By

SELECT EmployeeID, Salary, 
	AVG(Salary) OVER () as AllAvgSal
FROM EmployeeSalary

--Using Group By

SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSal
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1, 2

--Subqueries in from

SELECT a.EmployeeID, AllAvgSal
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () as AllAvgSal
	  FROM EmployeeSalary) a


--Subqueries in Where

SELECT EmployeeID, JobTitle,Salary
FROM EmployeeSalary
WHERE EmployeeID in(
	SELECT EmployeeID
	FROM EmployeeDemographics
	WHERE Age > 31
)

