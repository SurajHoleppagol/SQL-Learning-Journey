/* Topic 2 : AND / OR / NOT, ORDER BY, LIMIT / OFFSET */

-- Q7: Employees in dept 10 and earning > 1500.

	SELECT ename,deptno,sal
	FROM emp
	WHERE deptno=10 AND sal>1500;

-- Q8: Employees in dept 20 or job = 'CLERK'.

	SELECT ename,deptno,job
	FROM emp
	WHERE deptno=20 OR job='CLERK';

-- Q9: Employees not in dept 30.

	SELECT ename,deptno
	FROM emp
	WHERE deptno NOT IN (30);
	
-- Q10: Employees sorted by salary ascending.

	SELECT ename,sal
	FROM emp
	ORDER BY sal ASC;

-- Q11: Employees sorted by job, then salary desc.

	SELECT ename,job,sal
	FROM emp
	ORDER BY job,sal DESC;

-- Q12: Top 5 highest-paid employees.

	SELECT ename,sal
	FROM emp
	ORDER BY sal DESC
	LIMIT 5;

-- Q13: Skip top 3 salaries, show next 5.

	SELECT ename,sal
	FROM emp
	ORDER BY sal DESC
	LIMIT 5 OFFSET 3;