-- Topic 6: Conditional Logic & Functions

--  CASE

-- Q1 (Basic): Show employee names and salaries, and label them as ‘High Salary’ if > 3000, else ‘Normal Salary’.

	SELECT ename,sal,
			CASE
			 	WHEN sal > 3000 THEN 'High Salary'
			ELSE 'Normal Salary'
	END AS sal_category
	FROM emp;
	
-- Q2 (Intermediate): Show employees with a column Grade:

-- A if salary > 3000,  B if between 2000–3000,  C otherwise

	SELECT ename,sal,
		CASE 
			WHEN sal > 3000 THEN 'A'
			WHEN sal BETWEEN 2000 AND 3000 THEN 'B'
		ELSE 'C'
	END AS "Grade"
	FROM emp;
	
-- Q3 (Advanced): Show department-wise employee counts, but display "SMALL" if count < 3, "MEDIUM" if 3–5, "LARGE" if > 5.

	SELECT deptno,COUNT(*),
			CASE
				WHEN COUNT(*) < 3 THEN 'SMALL'
				WHEN COUNT(*) BETWEEN 3 AND 5 THEN 'MEDIUM'
				WHEN COUNT(*) > 5 THEN 'LARGE'
			ELSE 'NORMAL'
			END AS "Dept_size"
	FROM emp
	GROUP BY deptno;
		

-- 🔹 6.2 COALESCE / NULL handling

-- Q4 (Basic): Display employee names and commission. If commission is NULL, show 0.

	SELECT ename,COALESCE(comm,0) AS commission
	FROM emp;
	
-- Q5 (Intermediate): Show ename and sal + NVL(comm, 0) as total compensation.

	SELECT ename,sal+COALESCE(comm,0) AS total_compensation
	FROM emp;
	
-- Q6 (Advanced): List employees who do not have a manager (mgr is NULL). Use COALESCE to show "No Manager" instead of NULL.

	SELECT ename,COALESCE(mgr::text,'No Manager') AS manager
	FROM emp;

-- 🔹 6.3 String Functions

-- Q7 (Basic): Show all employee names in uppercase.

	SELECT ename, UPPER(ename) AS upper_name
	FROM emp;
	
-- Q8 (Intermediate): Show first 3 characters of employee names.

	SELECT SUBSTR(ename,1,3)
	FROM emp;
	
-- Q9 (Advanced): Show employee names with their length, ordered by name length descending.

	SELECT ename,LENGTH(ename) AS "Name_Length"
	FROM emp
	ORDER by 2 DESC;

-- 🔹 6.4 Date Functions

-- Q10 (Basic): Show employees hired in the year 1981.

	SELECT ename,hiredate
	FROM emp
	WHERE EXTRACT(YEAR FROM hiredate)=1981;
	
-- Q11 (Intermediate): Show employees and number of years they have worked till today.

	SELECT ename,EXTRACT(YEAR FROM AGE(CURRENT_DATE,hiredate)) AS years_worked
	FROM emp;
	
-- Q12 (Advanced): Find employees who joined in the same month as ‘SCOTT’.

	SELECT ename,hiredate
	FROM emp
	WHERE EXTRACT(MONTH FROM hiredate) = (SELECT EXTRACT(MONTH FROM hiredate)
											FROM emp
											WHERE ename='SCOTT') 

WITH month AS (
	SELECT ename,hiredate,EXTRACT(MONTH FROM hiredate)
	FROM emp
	WHERE ename='SCOTT'
)
SELECT ename,hiredate
FROM month - just tried