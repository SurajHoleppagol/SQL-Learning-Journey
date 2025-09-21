-- Topic 8: Window / Analytic Functions

--  ROW_NUMBER(), RANK(), DENSE_RANK()

-- Q1 Assign a row number to all employees ordered by salary descending.
	
	SELECT ename,
		ROW_NUMBER() OVER(ORDER BY sal DESC) AS row_num
	FROM emp;
		
-- Q2 Rank employees by salary within each department.

	SELECT ename,deptno,
		RANK() OVER(PARTITION BY deptno ORDER BY sal) AS rank_in_dept
	FROM emp;
	
-- Q3 Find 2nd highest salary in each department using DENSE_RANK.

	WITH high_2sal AS(
		SELECT ename,sal,deptno,
			DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) AS rank_in_dept
		FROM emp
	) 
	SELECT ename,sal,deptno
	FROM high_2sal
	WHERE rank_in_dept = 2;


--  LAG(), LEAD()

-- Q4 Show each employee’s salary along with the previous employee’s salary (based on hiredate).
	
	SELECT ename,sal,hiredate,
		LAG(sal) OVER(ORDER BY hiredate) AS previous_employee_salary
	FROM emp;
	
-- Q5 Show each employee’s salary and the next employee’s salary (based on hiredate).

	SELECT ename,sal,hiredate,
		LEAD(sal) OVER(ORDER BY hiredate) AS next_employee_salary
	FROM emp;
	
-- Q6 Show employees whose salary is greater than the previous employee’s salary (using LAG).

	WITH previous_emp_salary AS (
		SELECT ename,sal,
			LAG(sal) OVER(ORDER BY sal) AS prev_sal
		FROM emp
	)
	SELECT ename,sal
	FROM previous_emp_salary 
	WHERE sal>prev_sal

--  SUM()/AVG() OVER (PARTITION BY …)

-- Q7 Show each employee’s salary and department’s total salary.

	SELECT ename,sal,
		SUM(sal) OVER(PARTITION BY deptno) AS total_salary
	FROM emp;
		
	
-- Q8 Show each employee’s salary and department’s average salary.

	SELECT ename,sal,
		ROUND(AVG(sal) OVER(PARTITION BY deptno),2) AS average_salary
	FROM emp;
	
-- Q9 Find employees who earn more than their department’s average salary.

	WITH avg_sal AS (
		SELECT ename,sal,deptno,
			ROUND(AVG(sal) OVER(PARTITION BY deptno),2) AS average_salary
		FROM emp
	)
	SELECT ename,sal,deptno
	FROM avg_sal
	WHERE sal>average_salary

--  FIRST_VALUE(), LAST_VALUE()

-- Q10 For each department, show employee with the lowest salary (use FIRST_VALUE).

	SELECT ename,sal,deptno,
		FIRST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal) AS lowest_salary
	FROM emp;
	
-- Q11 For each department, show employee with the highest salary (use LAST_VALUE).

	SELECT ename,sal,deptno,
		LAST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING 
		AND UNBOUNDED FOLLOWING ) AS highest_salary
	FROM emp;
	
-- Q12 For each department, show all employees along with department’s highest salary and lowest salary side by side.

	SELECT ename,sal,deptno,
		FIRST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal) AS lowest_salary,
		LAST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING 
		AND UNBOUNDED FOLLOWING ) AS highest_salary
	FROM emp;