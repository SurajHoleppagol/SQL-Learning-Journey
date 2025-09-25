-- Topic 10: Views & Optimization

-- Views & Materialized Views

-- Q1 Create a view emp_dept_view that shows employee name, job, salary, and department name by joining emp and dept.

	CREATE VIEW emp_dept_view AS
		SELECT e.ename,e.job,e.sal,d.dname
		FROM emp e JOIN dept d ON e.deptno = d.deptno;

	SELECT * FROM emp_dept_view;

-- Q2 Select all employees from emp_dept_view who work in department 'SALES'.

	CREATE OR REPLACE VIEW emp_dept_sales AS
		SELECT e.empno,e.ename
		FROM emp e JOIN dept d ON d.deptno = e.deptno
		WHERE d.dname='SALES';

		SELECT * FROM emp_dept_sales;

-- Q3 Create a view high_salary_emp that shows employees earning more than the average salary of their department.

	CREATE VIEW high_salary_emp AS
	    SELECT e.ename, e.sal, e.deptno
	    FROM emp e
	    JOIN (
	        SELECT deptno, AVG(sal) AS avg_sal
	        FROM emp
	        GROUP BY deptno
	    ) d_avg ON e.deptno = d_avg.deptno
	    WHERE e.sal > d_avg.avg_sal;

	SELECT * FROM high_salary_emp;

-- Q4 Create a view emp_basic that only shows empno, ename, sal.

	CREATE VIEW emp_details AS
		SELECT empno, ename, sal
		FROM emp

-- Try to update the salary of employee 'SMITH' using this view.

	UPDATE emp_details
	SET sal=sal+100
	WHERE ename='SMITH'

-- Verify if the base table emp reflects the change.

	SELECT empno, ename, sal
	FROM emp
	WHERE ename='SMITH';

-- Q5 Create a materialized view dept_average_sal that shows the average salary per department.

	CREATE MATERIALIZED VIEW dept_average_sal AS
		SELECT deptno,ROUND(AVG(sal),2) AS avg_sal
		FROM emp
		GROUP BY deptno

	SELECT * FROM dept_average_sal;
	

-- Refresh the materialized view after inserting a new employee in dept 20.

	INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
	VALUES (9800,'MICHEL','SALES',7782,'1982-10-23',3500,NULL,20)
	
	REFRESH MATERIALIZED VIEW dept_average_sal;

-- Q6 Nested View Create a view senior_emp that shows employees with salary > 3000.


	CREATE VIEW senior_emp AS
	    SELECT empno, ename, sal, deptno, job
	    FROM emp
	    WHERE sal > 3000;

	SELECT * FROM senior_emp;
		
-- Then create another view dept_senior that counts how many senior employees are in each department.

	-- Nested view: count senior employees per department
		
		CREATE VIEW dept_senior AS
		    SELECT deptno, COUNT(*) AS senior_emp_count
		    FROM senior_emp
		    WHERE job IN ('MANAGER','PRESIDENT')
		    GROUP BY deptno;
	
	SELECT * FROM dept_senior;
	
-- Query which department has the maximum senior employees.

	-- Query department(s) with maximum senior employees
	
	SELECT deptno, senior_emp_count
	FROM dept_senior
	WHERE senior_emp_count = (SELECT MAX(senior_emp_count) FROM dept_senior);
	
	SELECT MAX(senior_emp_count) FROM max_senior_emp;
										
-- Indexes / Query Optimization

-- Q7 Create an index on the sal column of emp table.
	CREATE INDEX idx_emp_sal ON emp(sal);
	
-- Run a query to find all employees with salary > 4000.

	SELECT * FROM emp
	WHERE sal > 4000;
	
-- Check the query plan using EXPLAIN.

	EXPLAIN SELECT * FROM emp WHERE sal > 4000;

-- Q8 (Composite Index)
-- Create a composite index on (deptno, job) in the emp table.

	CREATE INDEX idx_emp_dept ON emp(deptno, job);
	
-- Run a query to find all employees who are CLERK in dept 20.

	SELECT * FROM emp WHERE job='CLERK' AND deptno=20;
	
-- Compare query performance with/without the index.

	-- WITH INDEX
		CREATE INDEX idx_emp_dept ON emp(deptno, job);

		EXPLAIN SELECT * FROM emp WHERE job='CLERK' AND deptno=20;

	-- WITHOUT INDEX
	
		DROP INDEX IF EXISTS idx_emp_dept;

		EXPLAIN SELECT * FROM emp WHERE job='CLERK' AND deptno=20;

	
-- Q9 Create a unique index on dname.

	CREATE UNIQUE INDEX idx_dept_dname ON dept(dname);
	
-- Try inserting a duplicate department name and see what happens.

		INSERT INTO dept (deptno,dname)
		VALUES (60,'SALES')
	

-- Q10 (Covering Index)
-- Suppose queries often ask for ename, job, sal of employees where deptno=10.
-- Design an index that makes this query faster without touching the emp table directly.
-- (Hint: covering index using INCLUDE columns).
	CREATE INDEX idx_dept_emp ON emp(deptno) INCLUDE (ename,job,sal);	


-- Q11 (Query Optimization)
-- You have a slow query:

/* SELECT e.ename, d.dname, e.sal
 FROM emp e
 JOIN dept d ON e.deptno = d.deptno
 WHERE e.sal > 3000
 ORDER BY e.sal DESC; */


-- Use EXPLAIN ANALYZE to check performance.

	EXPLAIN SELECT e.ename, d.dname, e.sal
 FROM emp e
 JOIN dept d ON e.deptno = d.deptno
 WHERE e.sal > 3000
 ORDER BY e.sal DESC;


-- Suggest optimizations (indexes, materialized views, query rewrite).

	-- suggest materialized view

	CREATE MATERIALIZED VIEW emp_sal_high AS
		SELECT e.ename, d.dname, e.sal
			FROM emp e
			JOIN dept d ON e.deptno = d.deptno
			WHERE e.sal > 3000;

	SELECT * FROM emp_sal_high;

--- index
CREATE INDEX idx_emp_sal_dept ON emp(sal DESC, deptno);

	
-- Q12 (Index Maintenance)

-- Drop all indexes on emp.

	DROP INDEX IF EXISTS idx_emp_sal;
	DROP INDEX IF EXISTS idx_emp_dept;
	DROP INDEX IF EXISTS idx_dept_dname;
	DROP INDEX IF EXISTS idx_dept_emp;
	
-- Recreate an index strategy to optimize:

-- Searching by ename (exact match).

	CREATE INDEX idx_emp_ename ON emp(ename);
	
-- Searching employees in a department with salary range.

	CREATE INDEX idx_emp_dept_sal ON emp(deptno, sal);

-- Aggregating salaries by dept.

	CREATE INDEX idx_emp_deptno ON emp(deptno);
	
-- Explain your choices.

-- 1. idx_emp_ename: Speeds up exact name searches.

-- 2. idx_emp_dept_sal: Composite index allows filtering employees by department and salary range efficiently.

-- 3. idx_emp_deptno: Helps grouping or aggregating salaries by department.

-- This strategy balances search performance, range filtering, and aggregation optimization.