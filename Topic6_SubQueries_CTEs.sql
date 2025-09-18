-- Topic 6: Subqueries & CTEs

-- Single-row Subquery

--Q1. Find employees earning more than the average salary.

	SELECT ename
	FROM emp 
	WHERE sal > ( SELECT ROUND(AVG(sal),2)
					FROM emp);

--Q2.Find the employee with the minimum hire date.

	SELECT ename
	FROM emp
	WHERE hiredate = ( SELECT MIN(hiredate)
					 	FROM emp);

-- Multi-row Subquery

--Q3.List employees working in the same department as SCOTT.

	SELECT ename,deptno
	FROM emp
	WHERE deptno = ( SELECT deptno
						FROM emp
						WHERE ename='SCOTT');

--Q4.Find employees whose salary is greater than ANY clerk’s salary.
	
	SELECT ename,sal
	FROM emp
	WHERE sal >ANY ( SELECT sal
						FROM emp
						WHERE job='CLERK');

--Q5.Find employees whose salary is greater than ALL clerks’ salaries.

	SELECT ename,sal
	FROM emp
	WHERE sal > ALL ( SELECT sal
						FROM emp
						WHERE job='CLERK');
	

--  Nested Subqueries

-- Q6. Find the employee(s) who earn the second highest salary from the EMP table.

	SELECT ename,sal
	FROM emp
	WHERE sal = (
		SELECT MAX(sal)
		FROM emp
		WHERE sal < (
			SELECT MAX(sal)
				FROM emp)
		);


--Q7. Find employees who earn more than the minimum salary in the company.
	
	SELECT ename,sal
	FROM emp
	WHERE sal >( SELECT MIN(sal)
					FROM emp);

-- Correlated Subqueries

--Q8. Find the highest paid employee in each department.

	SELECT ename,sal,deptno
	FROM emp e1
	WHERE sal =( SELECT MAX(sal)
				FROM emp e2
				WHERE e2.deptno=e1.deptno);

--Q9. Find employees who earn more than the average salary of their department (correlated version).

	SELECT ename,sal,deptno
	FROM emp e1
	WHERE sal >( SELECT ROUND(AVG(sal),2)
				FROM emp e2
				WHERE e2.deptno=e1.deptno);

-- CTEs

--Q10. Use a CTE to get the average salary per department and list employees above average.

	WITH dept_avg AS (
    SELECT deptno, AVG(sal) AS avg_sal
    FROM emp
    GROUP BY deptno
		)
		SELECT e.ename, e.sal, e.deptno
		FROM emp e
		JOIN dept_avg d ON e.deptno = d.deptno
		WHERE e.sal > d.avg_sal;


--Q11. Use a CTE to get department-wise employee counts.

	WITH dept_wise_count AS (
			SELECT deptno,COUNT(deptno) AS Count_of_emp
			FROM emp
			GROUP BY deptno
		)
			SELECT deptno,Count_of_emp
			FROM dept_wise_count
		

--  Recursive CTEs

--Q12. Show the employee hierarchy starting from KING.

	WITH RECURSIVE emp_hierarchy AS (
    SELECT empno, ename, mgr, 1 AS level
    FROM emp
    WHERE ename = 'KING'

    UNION ALL

    SELECT e.empno, e.ename, e.mgr, h.level + 1
    FROM emp e
    JOIN emp_hierarchy h ON e.mgr = h.empno
)

	SELECT empno, ename, mgr, level
	FROM emp_hierarchy
	ORDER BY level, ename;

--Q13.Find employees reporting under SCOTT.

	
	WITH RECURSIVE reporting_chain AS (
    SELECT empno, ename, mgr, 1 AS level
    FROM emp
    WHERE ename = 'SCOTT'

    UNION ALL

    SELECT e.empno, e.ename, e.mgr, h.level + 1
    FROM emp e
    JOIN reporting_chain h ON e.mgr = h.empno
)

	SELECT empno, ename, mgr, level
	FROM reporting_chain
	ORDER BY level, ename;

