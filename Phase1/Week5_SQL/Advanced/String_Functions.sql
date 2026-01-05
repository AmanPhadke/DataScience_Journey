CREATE TABLE EmployeeErrors
(EmpId varchar(50),
FirstName varchar(50),
LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES
('1001   ', 'Jimbo', 'Helbert'),
('   1002', 'Pamela', 'Beasely'),
('1003', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors


--Using TRIM, LTRIM AND RTRIM

SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors


--Using Replace

SELECT LastName, Replace(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors

--Using Substring

SELECT er.FirstName, SUBSTRING(dem.FirstName,1,3),dem.FirstName, SUBSTRING(ER.FirstName,1,3)
FROM EmployeeErrors er
JOIN EmployeeDemographics dem
	ON SUBSTRING(dem.FirstName,1,3) = SUBSTRING(ER.FirstName,1,3)


--Using UPPER and lower

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors
