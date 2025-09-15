/* Topic 3 : GROUP BY, SUM/AVG/COUNT/MAX/MIN, HAVING, COUNT DISTINCT */

-- Q14: Total salary by department.

	SELECT deptno,SUM(sal) AS total_salary
	FROM emp
	GROUP BY deptno;

-- Q15: Average salary by job.

	SELECT job,ROUND(AVG(sal),2) AS Avg_Sal
	FROM emp
	GROUP BY job;

-- Q16: Count employees in each dept.

	SELECT deptno,COUNT(*) AS No_of_employees
	FROM emp
	GROUP BY deptno;

-- Q17: Departments with total salary > 5000.

	SELECT deptno,SUM(sal) AS total_sal
	FROM emp
	GROUP BY deptno
	HAVING SUM(sal) > 5000;

-- Q18: Jobs with more than 3 employees.

	SELECT job,COUNT(*) AS No_of_employees
	FROM emp
	GROUP BY job
	HAVING COUNT(*)>3;

-- Q19: Count distinct jobs.

	SELECT COUNT(DISTINCT(job)) AS No_of_job
	FROM emp;

-- Q20: Count distinct departments with employees.

	SELECT COUNT(DISTINCT(deptno)) AS No_of_deptno
	FROM emp;