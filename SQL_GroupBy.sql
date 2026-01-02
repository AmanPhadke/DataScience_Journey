--Group By, Order By

--SELECT *
--From EmployeeDemographics

--SELECT Gender, COUNT(Gender) AS CountGender
--From EmployeeDemographics
--WHERE Age > 31
--GROUP BY Gender
--ORDER BY CountGender DESC 

SELECT *
From EmployeeDemographics
ORDER BY Age DESC,Gender DESC
