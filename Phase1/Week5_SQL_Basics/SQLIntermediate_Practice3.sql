WITH Employee AS
(
SELECT 
	emp_id, 
	e_name,
	'Permanent' AS emp_type,
	salary AS monthly_salary
FROM SQL_Tutorial.dbo.permanent_employees

UNION ALL

SELECT 
	emp_id, 
	e_name,
	'Contract' AS emp_type,
	hourly_rate * hours_worked AS monthly_salary
FROM SQL_Tutorial.dbo.contract_employees
)

SELECT *
FROM Employee




