-- /* JOINS */

--1. INNER JOIN

-- Q1. Show employee names with their department names.

	SELECT e.ename,d.dname
	FROM emp e INNER JOIN dept d ON d.deptno = e.deptno;
	
-- Q2. List employees and their department location.

	SELECT e.ename,d.loc
	FROM emp e INNER JOIN dept d ON d.deptno = e.deptno;
	
-- Q3. Show employees who belong to department 10.

	SELECT e.ename
	FROM emp e INNER JOIN dept d ON d.deptno = e.deptno
	WHERE d.deptno=10;

-- 2. LEFT JOIN

-- Q4. Show all employees with their department names. If dept is missing, show NULL.
	SELECT e.ename,d.dname
	FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno;


-- Q5. Find employees who are not assigned to any department.
	SELECT e.ename,d.deptno
	FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno
	WHERE d.deptno IS NULL;


-- 3. RIGHT JOIN

-- Q6. Show all departments with employees.

	SELECT e.ename,d.dname
	FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno;
	
-- Q7. Find departments that have no employees.

	SELECT d.dname,d.deptno
	FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
	WHERE e.empno IS NULL;

-- 4. FULL OUTER JOIN

-- Q8. Show all employees and departments. Include unmatched from both sides.

	SELECT e.empno,e.ename,d.dname,d.deptno
	FROM emp e FULL OUTER JOIN dept d ON e.deptno = d.deptno;

-- 5. SELF JOIN

-- Q9. Show employee name and their manager’s name.

	SELECT e.empno,e.ename,m.ename AS "manager_name"
	FROM emp e JOIN emp m ON e.mgr = m.empno;

	
-- Q10. Show employees who do not have a manager
	
	SELECT e.empno,e.ename,e.mgr
	FROM emp e LEFT JOIN emp m ON e.mgr = m.empno
	WHERE m.empno IS NULL;


-- 6. CROSS JOIN

-- Q11. Show all combinations of employees and departments.
	
	SELECT e.empno, e.ename, d.deptno, d.dname
	FROM emp e CROSS JOIN dept d;
	
-- Q12. Show how many total pairs are formed between employees and departments.

	SELECT COUNT(*) AS "total_pairs"
	FROM emp e CROSS JOIN dept d;
	