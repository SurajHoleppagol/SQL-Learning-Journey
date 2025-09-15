/* Topic 1: SELECT, WHERE, DISTINCT */

-- Q1: Show employee names and salaries.

	SELECT ename,sal
	FROM emp;
	
-- Q2: Show all departments.

	SELECT dname
	FROM dept;

-- Q3: Employees with salary > 2000.

	SELECT ename,sal
	FROM emp
	WHERE sal>2000;

-- Q4: Employees hired after 01-Jan-81.

	SELECT ename,hiredate
	FROM emp
	WHERE hiredate > DATE '1981-01-01';

-- Q5: List unique job titles.

	SELECT DISTINCT(job) AS job_titles
	FROM emp;
	
-- Q6: List unique dept numbers.

	SELECT DISTINCT(deptno) AS dept_number
	FROM emp;