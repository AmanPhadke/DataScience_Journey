/*
UNION and UNION ALL
*/

SELECT *
FROM SQL_Tutorial.dbo.EmployeeDemographics
UNION ALL
SELECT *
FROM SQL_Tutorial.dbo.WareHouseEmployeeDemographics


--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--FULL OUTER JOIN SQL_Tutorial.dbo.WareHouseEmployeeDemographics
--	ON EmployeeDemographics.EmployeeId = WareHouseEmployeeDemographics.EmployeeId


