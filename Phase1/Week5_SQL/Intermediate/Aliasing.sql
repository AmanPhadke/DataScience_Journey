/*
Aliasing
*/

--SELECT FirstName + ' '+ LastName AS FullName
--FROM SQL_Tutorial.dbo.EmployeeDemographics

SELECT Demo.EmployeeID, Demo.FirstName, Sal.JobTitle, Sal.Salary, Ware.Age
FROM SQL_Tutorial.dbo.EmployeeDemographics AS Demo
LEFT JOIN SQL_Tutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN SQL_Tutorial.dbo.WareHouseEmployeeDemographics AS Ware
	ON Demo.EmployeeID = Ware.EmployeeId

