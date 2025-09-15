/* Topic 4 : ROLLUP / CUBE */

-- Q21: Salary sum by dept with grand total (ROLLUP).

	SELECT deptno, SUM(sal) AS total_salary
	FROM emp
	GROUP BY ROLLUP(deptno);


-- Q22: Salary sum by dept & job (CUBE).

	SELECT deptno, job, SUM(sal) AS total_salary
	FROM emp
	GROUP BY CUBE(deptno, job);