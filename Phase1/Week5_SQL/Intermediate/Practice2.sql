--SELECT DISTINCT s.student_id, s.s_name
--FROM SQL_Tutorial.dbo.students2 s
--JOIN SQL_Tutorial.dbo.marks m
--	ON s.student_id = m.student_id


-- Average Marks for all subjects
--SELECT AVG(marks) AS Average_Marks
--FROM SQL_Tutorial.dbo.students2 s
--JOIN SQL_Tutorial.dbo.marks m
--	ON s.student_id = m.student_id

SELECT 
	s.student_id,
	s.s_name, 
	AVG(marks) AS avg_marks,
CASE
	WHEN AVG(marks) >= 75 THEN 'Distinction'
	WHEN AVG(marks) BETWEEN 40 AND 74 THEN 'Pass'
	WHEN AVG(marks) < 40 THEN 'Fail'
END AS 'Remarks'
FROM SQL_Tutorial.dbo.students2 s
JOIN SQL_Tutorial.dbo.marks m
	ON s.student_id = m.student_id
GROUP BY s.student_id, s.s_name
