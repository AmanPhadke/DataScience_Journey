/*
Temp Tables
*/

--CREATE TABLE #temp_Employee (
--EmployeeID int,
--JobTitle varchar(100),
--Salary int
--)

--Select * 
--FROM #temp_Employee

DROP TABLE IF EXISTS #temp_Employee2
CREATE TABLE #temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQL_Tutorial..EmployeeSalary sal
JOIN SQL_Tutorial..EmployeeDemographics demo
	ON sal.EmployeeID = demo.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2
