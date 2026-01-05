  /*
  Stored Procedures
  */

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST


CREATE PROCEDURE temp_Employee3
AS
CREATE TABLE #temp_Employee (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #temp_Employee
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQL_Tutorial..EmployeeSalary sal
JOIN SQL_Tutorial..EmployeeDemographics demo
	ON sal.EmployeeID = demo.EmployeeID
GROUP BY JobTitle


SELECT *
FROM #temp_Employee



EXEC temp_Employee3 @JobTitle = 'Salesman'