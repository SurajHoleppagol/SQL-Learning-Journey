# SQL Learning Journey

This repository contains my SQL practice using the Oracle-style `emp` and `dept` dataset.  
All queries are organized by topics, and the database setup file is included.

# Database Setup

- **Tables:** `emp`, `dept`  
- **Setup file:** [`setup_emp_dept.sql`](setup_emp_dept.sql)  
- **Description:** Creates tables and inserts sample data for practice.

## Step 1: Create Tables
-- Department table

```sql
create table dept(   
  deptno     numeric(2),   
  dname      varchar(14),   
  loc        varchar(13),   
  constraint pk_dept primary key (deptno)   
)
```

-- Employe Table
```sql
create table emp(   
  empno    numeric(4),   
  ename    varchar(10),   
  job      varchar(9),   
  mgr      numeric(4),   
  hiredate date,   
  sal      numeric(7),   
  comm     numeric(7),   
  deptno   numeric(2),   
  constraint pk_emp primary key (empno),   
  constraint fk_deptno foreign key (deptno) references dept (deptno)   
)
```

## Step 2: Insert sample data
``` sql
insert into DEPT (DEPTNO, DNAME, LOC) 
values(10, 'ACCOUNTING', 'NEW YORK')
```
```sql
insert into dept   
values(20, 'RESEARCH', 'DALLAS')
```
```sql
insert into dept   
values(30, 'SALES', 'CHICAGO')
```
```sql
insert into dept  
values(40, 'OPERATIONS', 'BOSTON')
```
```sql
insert into emp   
values(   
 7839, 'KING', 'PRESIDENT', null,   
 to_date('17-11-1981','dd-mm-yyyy'),   
 5000, null, 10   
)
```
```sql
insert into emp  
values(  
 7698, 'BLAKE', 'MANAGER', 7839,  
 to_date('1-5-1981','dd-mm-yyyy'),  
 2850, null, 30  
)
```
```sql
insert into emp  
values(  
 7782, 'CLARK', 'MANAGER', 7839,  
 to_date('9-6-1981','dd-mm-yyyy'),  
 2450, null, 10  
)
```
```sql
insert into emp  
values(  
 7566, 'JONES', 'MANAGER', 7839,  
 to_date('2-4-1981','dd-mm-yyyy'),  
 2975, null, 20  
)
```
```sql
insert into emp  
values(  
 7788, 'SCOTT', 'ANALYST', 7566,  
 to_date('13-07-1987','dd-mm-yyyy'),
 3000, null, 20  
)
```
```sql
insert into emp  
values(  
 7902, 'FORD', 'ANALYST', 7566,  
 to_date('3-12-1981','dd-mm-yyyy'),  
 3000, null, 20  
)
```
```sql
insert into emp  
values(  
 7369, 'SMITH', 'CLERK', 7902,  
 to_date('17-12-1980','dd-mm-yyyy'),  
 800, null, 20  
)
```
```sql
insert into emp  
values(  
 7499, 'ALLEN', 'SALESMAN', 7698,  
 to_date('20-2-1981','dd-mm-yyyy'),  
 1600, 300, 30  
)
```
```sql
insert into emp  
values(  
 7521, 'WARD', 'SALESMAN', 7698,  
 to_date('22-2-1981','dd-mm-yyyy'),  
 1250, 500, 30  
)
```
```sql
insert into emp  
values(  
 7654, 'MARTIN', 'SALESMAN', 7698,  
 to_date('28-9-1981','dd-mm-yyyy'),  
 1250, 1400, 30  
)
```
```sql
insert into emp  
values(  
 7844, 'TURNER', 'SALESMAN', 7698,  
 to_date('8-9-1981','dd-mm-yyyy'),  
 1500, 0, 30  
)
```
```sql

insert into emp  
values(  
 7876, 'ADAMS', 'CLERK', 7788,  
 to_date('13-07-1987', 'dd-mm-yyyy'),  
 1100, null, 20  
)
```
```sql
insert into emp  
values(  
 7900, 'JAMES', 'CLERK', 7698,  
 to_date('3-12-1981','dd-mm-yyyy'),  
 950, null, 30  
)
```
```sql
insert into emp  
values(  
 7934, 'MILLER', 'CLERK', 7782,  
 to_date('23-1-1982','dd-mm-yyyy'),  
 1300, null, 10  
)
```
## Topic 1: SELECT, WHERE, DISTINCT 

- **All Topic 1 queries are in**[`Topic1_SELECT_WHERE_DISTINCT.sql`](Topic1_SELECT_WHERE_DISTINCT.sql).

**Q1: Show employee names and salaries.**

```sql
	SELECT ename,sal
	FROM emp;
```
**Q2: Show all departments.**

```sql
	SELECT dname
	FROM dept;
```

**Q3: Employees with salary > 2000.**

```sql
	SELECT ename,sal
	FROM emp
	WHERE sal>2000;
```
**Q4: Employees hired after 01-Jan-81.**

```sql
	SELECT ename,hiredate
	FROM emp
	WHERE hiredate > '01-Jan-81';
```

**Q5: List unique job titles.**

```sql
	SELECT DISTINCT(job) AS job_titles
	FROM emp;
```
	
**Q6: List unique dept numbers.**

```sql
	SELECT DISTINCT(deptno) AS dept_number
	FROM emp;
```
## Topic 2: AND, OR, NOT + ORDER BY + LIMIT / OFFSET

- **All Topic 2 queries are in** [`Topic2_AND_OR_NOT_ORDERBY_LIMIT_OFFSET.sql`](Topic2_AND_OR_NOT_ORDERBY_LIMIT_OFFSET.sql).

**Q7: Employees in dept 10 and earning > 1500.**

```sql
	SELECT ename,deptno,sal
	FROM emp
	WHERE deptno=10 AND sal>1500;
```

**Q8: Employees in dept 20 or job = 'CLERK'.**

```sql
	SELECT ename,deptno,job
	FROM emp
	WHERE deptno=20 OR job='CLERK';
```

**Q9: Employees not in dept 30.**

```sql
	SELECT ename,deptno
	FROM emp
	WHERE deptno NOT IN (30);
```
	
**Q10: Employees sorted by salary ascending.**

```sql
	SELECT ename,sal
	FROM emp
	ORDER BY sal ASC;
```

**Q11: Employees sorted by job, then salary desc.**

```sql
	SELECT ename,job,sal
	FROM emp
	ORDER BY job,sal DESC;
```

**Q12: Top 5 highest-paid employees.**

```sql
	SELECT ename,sal
	FROM emp
	ORDER BY sal DESC
	LIMIT 5;
```

**Q13: Skip top 3 salaries, show next 5.**

```sql
	SELECT ename,sal
	FROM emp
	ORDER BY sal DESC
	LIMIT 5 OFFSET 3;
```

## Topic 3: GROUP BY + SUM/AVG/COUNT/MAX/MIN + HAVING + COUNT DISTINCT

- **All Topic 3 queries are in** [`Topic3_GROUPBY_AGG_HAVING.sql`](Topic3_GROUPBY_AGG_HAVING.sql).


**Q14: Total salary by department.**

```sql
	SELECT deptno,SUM(sal) AS total_salary
	FROM emp
	GROUP BY deptno;
  ```

**Q15: Average salary by job.**

```sql
	SELECT job,ROUND(AVG(sal),2) AS Avg_Sal
	FROM emp
	GROUP BY job;
```

**Q16: Count employees in each dept.**

```sql
	SELECT deptno,COUNT(*) AS No_of_employees
	FROM emp
	GROUP BY deptno;
```

**Q17: Departments with total salary > 5000.**

```sql
	SELECT deptno,SUM(sal) AS total_sal
	FROM emp
	GROUP BY deptno
	HAVING SUM(sal) > 5000;
```

**Q18: Jobs with more than 3 employees.**

```sql
	SELECT job,COUNT(*) AS No_of_employees
	FROM emp
	GROUP BY job
	HAVING COUNT(*)>3;
```

**Q19: Count distinct jobs.**

```sql
	SELECT COUNT(DISTINCT(job)) AS No_of_job
	FROM emp;
```

**Q20: Count distinct departments with employees.**

```sql
	SELECT COUNT(DISTINCT(deptno)) AS No_of_deptno
	FROM emp;
```

## Topic 4: ROLLUP / CUBE

- **All Topic 4 queries are in** [`Topic4_ROLLUP_CUBE.sql`](Topic4_ROLLUP_CUBE.sql).

**Q21: Salary sum by dept with grand total (ROLLUP).**

```sql
	SELECT deptno, SUM(sal) AS total_salary
	FROM emp
	GROUP BY ROLLUP(deptno);
```

**Q22: Salary sum by dept & job (CUBE).**

```sql
	SELECT deptno, job, SUM(sal) AS total_salary
	FROM emp
	GROUP BY CUBE(deptno, job);
```

## Topic 5: JOINS

- **All Topic 5 queries are in** [`Topic5_JOINS.sql`](Topic5_JOINS.sql).

**INNER JOIN**

**Q1. Show employee names with their department names.**

```sql
	SELECT e.ename,d.dname
	FROM emp e INNER JOIN dept d ON d.deptno = e.deptno;
```
	
**Q2. List employees and their department location.**

```sql
	SELECT e.ename,d.loc
	FROM emp e INNER JOIN dept d ON d.deptno = e.deptno;
```
	
**Q3. Show employees who belong to department 10.**

```sql
	SELECT e.ename
	FROM emp e INNER JOIN dept d ON d.deptno = e.deptno
	WHERE d.deptno=10;
```

**LEFT JOIN**

**Q4. Show all employees with their department names. If dept is missing, show NULL.**

```sql
	SELECT e.ename,d.dname
	FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno;
```


**Q5. Find employees who are not assigned to any department.**

```sql
	SELECT e.ename,d.deptno
	FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno
	WHERE d.deptno IS NULL;
```


**RIGHT JOIN**

**Q6. Show all departments with employees.**

```sql
	SELECT e.ename,d.dname
	FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno;
```
	
**Q7. Find departments that have no employees.**

```sql
	SELECT d.dname,d.deptno
	FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
	WHERE e.empno IS NULL;
```

**FULL OUTER JOIN**

 **Q8. Show all employees and departments. Include unmatched from both sides.**

```sql
	SELECT e.empno,e.ename,d.dname,d.deptno
	FROM emp e FULL OUTER JOIN dept d ON e.deptno = d.deptno;
```

**SELF JOIN**

**Q9. Show employee name and their manager’s name.**

```sql
	SELECT e.empno,e.ename,m.ename AS "manager_name"
	FROM emp e JOIN emp m ON e.mgr = m.empno;
```

	
**Q10. Show employees who do not have a manager**
	
```sql
	SELECT e.empno,e.ename,e.mgr
	FROM emp e LEFT JOIN emp m ON e.mgr = m.empno
	WHERE m.empno IS NULL;
```

**CROSS JOIN**

**Q11. Show all combinations of employees and departments.**
	
```sql
	SELECT e.empno, e.ename, d.deptno, d.dname
	FROM emp e CROSS JOIN dept d;
```
	
**Q12. Show how many total pairs are formed between employees and departments.**

```sql
	SELECT COUNT(*) AS "total_pairs"
	FROM emp e CROSS JOIN dept d;
```
## Topic 6: Subqueries & CTEs

**All Topic 6 queries are in** [`Topic6_SubQueries_CTEs.sql`](Topic6_SubQueries_CTEs.sql).

**Single-row Subquery**

**Q1. Find employees earning more than the average salary.**

```sql
	SELECT ename
	FROM emp 
	WHERE sal > ( SELECT ROUND(AVG(sal),2)
					FROM emp);
```

**Q2.Find the employee with the minimum hire date.**

```sql
	SELECT ename
	FROM emp
	WHERE hiredate = ( SELECT MIN(hiredate)
					 	FROM emp);
```

**Multi-row Subquery**

**Q3.List employees working in the same department as SCOTT.**

```sql
	SELECT ename,deptno
	FROM emp
	WHERE deptno = ( SELECT deptno
						FROM emp
						WHERE ename='SCOTT');
```

**Q4.Find employees whose salary is greater than ANY clerk’s salary.**

```sql
	SELECT ename,sal
	FROM emp
	WHERE sal >ANY ( SELECT sal
						FROM emp
						WHERE job='CLERK');
```

**Q5.Find employees whose salary is greater than ALL clerks’ salaries.**

```sql
	SELECT ename,sal
	FROM emp
	WHERE sal > ALL ( SELECT sal
						FROM emp
						WHERE job='CLERK');
```

**Nested Subqueries**

**Q6. Find the employee(s) who earn the second highest salary from the EMP table.**

```sql
	SELECT ename,sal
	FROM emp
	WHERE sal = (
		SELECT MAX(sal)
		FROM emp
		WHERE sal < (
			SELECT MAX(sal)
				FROM emp)
		);
```

**Q7. Find employees who earn more than the minimum salary in the company.**

```sql
	SELECT ename,sal
	FROM emp
	WHERE sal >( SELECT MIN(sal)
					FROM emp);
```

**Correlated Subqueries**

**Q8. Find the highest paid employee in each department.**

```sql
	SELECT ename,sal,deptno
	FROM emp e1
	WHERE sal =( SELECT MAX(sal)
				FROM emp e2
				WHERE e2.deptno=e1.deptno);
```

**Q9. Find employees who earn more than the average salary of their department (correlated version).**

```sql
	SELECT ename,sal,deptno
	FROM emp e1
	WHERE sal >( SELECT ROUND(AVG(sal),2)
				FROM emp e2
				WHERE e2.deptno=e1.deptno);
```

**CTEs**

**Q10. Use a CTE to get the average salary per department and list employees above average.**

```sql
	WITH dept_avg AS (
    SELECT deptno, AVG(sal) AS avg_sal
    FROM emp
    GROUP BY deptno
		)
		SELECT e.ename, e.sal, e.deptno
		FROM emp e
		JOIN dept_avg d ON e.deptno = d.deptno
		WHERE e.sal > d.avg_sal;
```

**Q11. Use a CTE to get department-wise employee counts.**

```sql
	WITH dept_wise_count AS (
			SELECT deptno,COUNT(deptno) AS Count_of_emp
			FROM emp
			GROUP BY deptno
		)
			SELECT deptno,Count_of_emp
			FROM dept_wise_count
```	

**Recursive CTEs**

**Q12. Show the employee hierarchy starting from KING.**

```sql
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
```

**Q13.Find employees reporting under SCOTT.**

```sql
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
```
## Topic 7: Conditional Logic & Functions

- **All Topic 7 queries are in** [`Topic7_Conditional_Functions.sql`](Topic7_Conditional_Functions.sql).

## CASE

**Q1 Show employee names and salaries, and label them as ‘High Salary’ if > 3000, else ‘Normal Salary’.**

```sql
	SELECT ename,sal,
			CASE
			 	WHEN sal > 3000 THEN 'High Salary'
			ELSE 'Normal Salary'
	END AS sal_category
	FROM emp;
```
	
**Q2 Show employees with a column Grade:**
**A if salary > 3000,  B if between 2000–3000,  C otherwise**

```sql
	SELECT ename,sal,
		CASE 
			WHEN sal > 3000 THEN 'A'
			WHEN sal BETWEEN 2000 AND 3000 THEN 'B'
		ELSE 'C'
	END AS "Grade"
	FROM emp;
```
	
**Q3 Show department-wise employee counts, but display "SMALL" if count < 3, "MEDIUM" if 3–5, "LARGE" if > 5.**

```sql
	SELECT deptno,COUNT(*),
			CASE
				WHEN COUNT(*) < 3 THEN 'SMALL'
				WHEN COUNT(*) BETWEEN 3 AND 5 THEN 'MEDIUM'
				WHEN COUNT(*) > 5 THEN 'LARGE'
			ELSE 'NORMAL'
			END AS "Dept_size"
	FROM emp
	GROUP BY deptno;
```

## COALESCE / NULL handling

**Q4 Display employee names and commission. If commission is NULL, show 0.**

```sql
	SELECT ename,COALESCE(comm,0) AS commission
	FROM emp;
```
	
**Q5 Show ename and sal + NVL(comm, 0) as total compensation.**

```sql
	SELECT ename,sal+COALESCE(comm,0) AS total_compensation
	FROM emp;
```
	
**Q6 List employees who do not have a manager (mgr is NULL). Use COALESCE to show "No Manager" instead of NULL.**

```sql
	SELECT ename,COALESCE(mgr::text,'No Manager') AS manager
	FROM emp;
```

## String Functions

**Q7 Show all employee names in uppercase.**

```sql
	SELECT ename, UPPER(ename) AS upper_name
	FROM emp;
```
	
**Q8 Show first 3 characters of employee names.**

```sql
	SELECT SUBSTR(ename,1,3)
	FROM emp;
```

**Q9 Show employee names with their length, ordered by name length descending.**

```sql
	SELECT ename,LENGTH(ename) AS "Name_Length"
	FROM emp
	ORDER by 2 DESC;
```

## Date Functions

**Q10 Show employees hired in the year 1981.**

```sql
	SELECT ename,hiredate
	FROM emp
	WHERE EXTRACT(YEAR FROM hiredate)=1981;
```
	
**Q11 Show employees and number of years they have worked till today.**

```sql
	SELECT ename,EXTRACT(YEAR FROM AGE(CURRENT_DATE,hiredate)) AS years_worked
	FROM emp;
```
	
**Q12 Find employees who joined in the same month as ‘SCOTT’.**

```sql
	SELECT ename,hiredate
	FROM emp
	WHERE EXTRACT(MONTH FROM hiredate) = (SELECT EXTRACT(MONTH FROM hiredate)
											FROM emp
											WHERE ename='SCOTT');
```
## Topic 8: Window / Analytic Functions

- **All Topic 8 queries are in** [`Topic8_Window_Functions.sql`](Topic8_Window_Functions.sql).

## ROW_NUMBER(), RANK(), DENSE_RANK()

**Q1 Assign a row number to all employees ordered by salary descending**

```sql	
	SELECT ename,
		ROW_NUMBER() OVER(ORDER BY sal DESC) AS row_num
	FROM emp;
```

**Q2 Rank employees by salary within each department.**

```sql
	SELECT ename,deptno,
		RANK() OVER(PARTITION BY deptno ORDER BY sal) AS rank_in_dept
	FROM emp;
```
	
**Q3 Find 2nd highest salary in each department using DENSE_RANK.**

```sql
	WITH high_2sal AS(
		SELECT ename,sal,deptno,
			DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) AS rank_in_dept
		FROM emp
	) 
	SELECT ename,sal,deptno
	FROM high_2sal
	WHERE rank_in_dept = 2;
```

## LAG(), LEAD()

**Q4 Show each employee’s salary along with the previous employee’s salary (based on hiredate).**

```sql
	SELECT ename,sal,hiredate,
		LAG(sal) OVER(ORDER BY hiredate) AS previous_employee_salary
	FROM emp;
```
	
**Q5 Show each employee’s salary and the next employee’s salary (based on hiredate).**

```sql
	SELECT ename,sal,hiredate,
		LEAD(sal) OVER(ORDER BY hiredate) AS next_employee_salary
	FROM emp;
```
	
**Q6 Show employees whose salary is greater than the previous employee’s salary (using LAG).**

```sql
	WITH previous_emp_salary AS (
		SELECT ename,sal,
			LAG(sal) OVER(ORDER BY sal) AS prev_sal
		FROM emp
	)
	SELECT ename,sal
	FROM previous_emp_salary 
	WHERE sal>prev_sal
```

## SUM()/AVG() OVER (PARTITION BY …)

**Q7 Show each employee’s salary and department’s total salary.**

```sql
	SELECT ename,sal,
		SUM(sal) OVER(PARTITION BY deptno) AS total_salary
	FROM emp;
```		
	
**Q8 Show each employee’s salary and department’s average salary.**

```sql
	SELECT ename,sal,
		ROUND(AVG(sal) OVER(PARTITION BY deptno),2) AS average_salary
	FROM emp;
```

**Q9 Find employees who earn more than their department’s average salary.**

```sql
	WITH avg_sal AS (
		SELECT ename,sal,deptno,
			ROUND(AVG(sal) OVER(PARTITION BY deptno),2) AS average_salary
		FROM emp
	)
	SELECT ename,sal,deptno
	FROM avg_sal
	WHERE sal>average_salary
```

## FIRST_VALUE(), LAST_VALUE()

**Q10 For each department, show employee with the lowest salary (use FIRST_VALUE).**

```sql
	SELECT ename,sal,deptno,
		FIRST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal) AS lowest_salary
	FROM emp;
```
	
**Q11 For each department, show employee with the highest salary (use LAST_VALUE).**

```sql
	SELECT ename,sal,deptno,
		LAST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING 
		AND UNBOUNDED FOLLOWING ) AS highest_salary
	FROM emp;
```

**Q12 For each department, show all employees along with department’s highest salary and lowest salary side by side.**

```sql
	SELECT ename,sal,deptno,
		FIRST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal) AS lowest_salary,
		LAST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING 
		AND UNBOUNDED FOLLOWING ) AS highest_salary
	FROM emp;
```
## Topic 9: Data Manipulation & Maintenance

- **All Topic 9 queries are in** [`Topic9_Data_Manipulation_&_Maintenance.sql`](Topic9_Data_Manipulation_&_Maintenance.sql).

## INSERT, UPDATE, DELETE

**Q1 Insert a new employee Peter into emp table with:empno: 9001, job: ANALYST, deptno: 20, mgr: 7839, salary: 4000**

```sql
	INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
	VALUES (9001,'PETER','ANALYST',7839,'1985-01-22',4000,null,20);
```

**Q2 Update all employees in department 30 to increase salary by 10%.**

```sql
	UPDATE emp
	SET sal=sal+(sal*0.10)
	WHERE deptno=30;
```

**Q3 Delete all employees whose commission (comm) is NULL.**

```sql
	DELETE FROM emp
	WHERE comm IS NULL;
```

**Q4 Insert into emp table the details of employees who work in deptno=10, but copy them into a new dept 50.**

```sql
	INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
	SELECT empno+1000,ename,job,mgr,hiredate,sal,comm,50
	FROM emp
	WHERE deptno=10;
```
**NOTE: Adding 1000 to empno to avoid primary key conflict.**

## Transactions

**Q5 Begin a transaction. Insert a new employee and then roll it back. Show that the record is not in the table.**

```sql
	BEGIN;

	INSERT INTO emp (empno, ename, job, sal, deptno)
	VALUES (9002, 'DAVID', 'ANALYST', 3500, 30);

	ROLLBACK;

	SELECT * FROM emp WHERE empno=9002;
```

**Q6 Start a transaction: Deduct 500 from employee KING’s salary., Add 500 to employee BLAKE’s salary., Commit the transaction.**

```sql
	BEGIN;

	UPDATE emp
	SET sal=sal-500
	WHERE ename='KING';

	UPDATE emp
	SET sal=sal+500
	WHERE ename='BLAKE';

	COMMIT;
```

**Q7 Simulate a money transfer: Write a transaction where salary is transferred from CLARK to SMITH.If CLARK’s salary becomes negative, rollback the entire transaction.**

```sql
	BEGIN;
	
		-- Deduct salary from CLARK
		UPDATE emp
		SET sal = sal - 100
		WHERE ename = 'CLARK';
	
	-- Check CLARK’s balance
	SELECT sal FROM emp WHERE ename = 'CLARK';
	
		-- If CLARK’s salary < 0 → ROLLBACK
		-- Else → Add salary to SMITH and COMMIT
		UPDATE emp
		SET sal = sal + 100
		WHERE ename = 'SMITH';
	
	COMMIT;
```

## Stored Procedures / Functions

**Q8  Create a stored function get_bonus(sal NUMERIC) that returns 10% of salary.**

```sql	
	CREATE OR REPLACE FUNCTION get_bonus(sal NUMERIC)
	RETURNS NUMERIC
	LANGUAGE plpgsql
	AS $$
	BEGIN
		RETURN sal * 0.10;
	END;
	$$;

	SELECT ename, sal, get_bonus(sal) AS bonus
	FROM emp;
```

**Q9 Create a procedure raise_salary(dept_id INT, percent NUMERIC) that increases salaries of all employees in that department.**

```sql
	CREATE OR REPLACE PROCEDURE raise_salary(p_deptno INT, percent NUMERIC)
	LANGUAGE plpgsql
	AS $$
		BEGIN
				UPDATE emp
				SET sal=sal+sal*percent
				WHERE deptno=p_deptno;
		RAISE NOTICE 'Salaries in department % raised by % percent', p_deptno, percent * 100;
	END;
	$$;

	CALL raise_salary(10, 0.10);
```

**Q10 Write a procedure transfer_employee(emp_id INT, new_dept INT) that: Updates employee’s department. If new_dept does not exist, rollback and raise an exception.**

```sql
	CREATE OR REPLACE PROCEDURE transfer_employee(p_emp_id INT, p_new_dept INT)
	LANGUAGE plpgsql
	AS $$
			BEGIN
	    -- 1. Check if department exists
	    IF NOT EXISTS (SELECT 1 FROM dept WHERE deptno = p_new_dept) THEN
	        RAISE EXCEPTION 'Department % does not exist. Rolling back...', p_new_dept;
	    END IF;
	
	    -- 2. Update employee’s department
	    UPDATE emp
	    SET deptno = p_new_dept
	    WHERE empno = p_emp_id;
	
	    -- 3. Optional confirmation
	    RAISE NOTICE 'Employee % moved to department %', p_emp_id, p_new_dept;
	END;
	$$;
	
	CALL transfer_employee(101, 50);   -- If dept 50 exists, update happens
	CALL transfer_employee(101, 999);  -- If dept 999 does not exist → exception, rollback		
```

## Topic 10: Views & Optimization

- **All Topic 10 queries are in** [`Topic10_Views_&_Optimization.sql`](Topic10_Views_&_Optimization.sql).

## Views & Materialized Views

**Q1 Create a view emp_dept_view that shows employee name, job, salary, and department name by joining emp and dept.**

```sql
	CREATE VIEW emp_dept_view AS
		SELECT e.ename,e.job,e.sal,d.dname
		FROM emp e JOIN dept d ON e.deptno = d.deptno;

	SELECT * FROM emp_dept_view;
```

**Q2 Select all employees from emp_dept_view who work in department 'SALES'.**

```sql
	CREATE OR REPLACE VIEW emp_dept_sales AS
		SELECT e.empno,e.ename
		FROM emp e JOIN dept d ON d.deptno = e.deptno
		WHERE d.dname='SALES';

		SELECT * FROM emp_dept_sales;
```

**Q3 Create a view high_salary_emp that shows employees earning more than the average salary of their department.**

```sql
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
```

**Q4 Create a view emp_basic that only shows empno, ename, sal.**

```sql
	CREATE VIEW emp_details AS
		SELECT empno, ename, sal
		FROM emp
```

- **Try to update the salary of employee 'SMITH' using this view.**

```sql
	UPDATE emp_details
	SET sal=sal+100
	WHERE ename='SMITH'
```

- **Verify if the base table emp reflects the change.**

```sql
	SELECT empno, ename, sal
	FROM emp
	WHERE ename='SMITH';
```

**Q5 Create a materialized view dept_average_sal that shows the average salary per department.**

```sql
	CREATE MATERIALIZED VIEW dept_average_sal AS
		SELECT deptno,ROUND(AVG(sal),2) AS avg_sal
		FROM emp
		GROUP BY deptno

	SELECT * FROM dept_average_sal;
```

- **Refresh the materialized view after inserting a new employee in dept 20.**

```sql
	INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
	VALUES (9800,'MICHEL','SALES',7782,'1982-10-23',3500,NULL,20)
	
	REFRESH MATERIALIZED VIEW dept_average_sal;
```

**Q6 Nested View Create a view senior_emp that shows employees with salary > 3000.**

```sql
	CREATE VIEW senior_emp AS
	    SELECT empno, ename, sal, deptno, job
	    FROM emp
	    WHERE sal > 3000;

	SELECT * FROM senior_emp;
```
		
- **Then create another view dept_senior that counts how many senior employees are in each department.**

	- **Nested view: count senior employees per department**
```sql
		CREATE VIEW dept_senior AS
		    SELECT deptno, COUNT(*) AS senior_emp_count
		    FROM senior_emp
		    WHERE job IN ('MANAGER','PRESIDENT')
		    GROUP BY deptno;
	
	SELECT * FROM dept_senior;
```

- **Query which department has the maximum senior employees.**

	- **Query department(s) with maximum senior employees**

```sql
	SELECT deptno, senior_emp_count
	FROM dept_senior
	WHERE senior_emp_count = (SELECT MAX(senior_emp_count) FROM dept_senior);
	
	SELECT MAX(senior_emp_count) FROM max_senior_emp;
```

## Indexes / Query Optimization

**Q7 Create an index on the sal column of emp table.**
```sql
	CREATE INDEX idx_emp_sal ON emp(sal);
```

- **Run a query to find all employees with salary > 4000.**

```sql
	SELECT * FROM emp
	WHERE sal > 4000;
```
	
- **Check the query plan using EXPLAIN.**

```sql
	EXPLAIN SELECT * FROM emp WHERE sal > 4000;
```

**Q8 Create a composite index on (deptno, job) in the emp table.**

```sql
	CREATE INDEX idx_emp_dept ON emp(deptno, job);
```

- **Run a query to find all employees who are CLERK in dept 20.**

```sql
	SELECT * FROM emp WHERE job='CLERK' AND deptno=20;
```

- **Compare query performance with/without the index.**

	- **WITH INDEX**

	```sql	
		CREATE INDEX idx_emp_dept ON emp(deptno, job);

		EXPLAIN SELECT * FROM emp WHERE job='CLERK' AND deptno=20;
	```
	- **WITHOUT INDEX**

	```sql
		DROP INDEX IF EXISTS idx_emp_dept;

		EXPLAIN SELECT * FROM emp WHERE job='CLERK' AND deptno=20;
	```
	
**Q9 Create a unique index on dname.**

```sql
	CREATE UNIQUE INDEX idx_dept_dname ON dept(dname);
```

- **Try inserting a duplicate department name and see what happens.**
	```sql
		INSERT INTO dept (deptno,dname)
		VALUES (60,'SALES')
	```
	

**Q10 Covering Index - Suppose queries often ask for ename, job, sal of employees where deptno=10.**
- **Design an index that makes this query faster without touching the emp table directly.**

```sql
	CREATE INDEX idx_dept_emp ON emp(deptno) INCLUDE (ename,job,sal);	
```

**Q11 Query Optimization -You have a slow query:**

```sql
	SELECT e.ename, d.dname, e.sal
	FROM emp e
	JOIN dept d ON e.deptno = d.deptno
	WHERE e.sal > 3000
	ORDER BY e.sal DESC; 
```

- **Use EXPLAIN ANALYZE to check performance.**

	```sql
		EXPLAIN SELECT e.ename, d.dname, e.sal
	FROM emp e
	JOIN dept d ON e.deptno = d.deptno
	WHERE e.sal > 3000
	ORDER BY e.sal DESC;
	```


- **optimizations (indexes, materialized views, query rewrite).**

	- **materialized view**
```sql
	CREATE MATERIALIZED VIEW emp_sal_high AS
		SELECT e.ename, d.dname, e.sal
			FROM emp e
			JOIN dept d ON e.deptno = d.deptno
			WHERE e.sal > 3000;

	SELECT * FROM emp_sal_high;
```

- **Index**
	
```sql
	CREATE INDEX idx_emp_sal_dept ON emp(sal DESC, deptno);
```
	
**Q12 (Index Maintenance)**

- **Drop all indexes on emp.**

```sql
	DROP INDEX IF EXISTS idx_emp_sal;
	DROP INDEX IF EXISTS idx_emp_dept;
	DROP INDEX IF EXISTS idx_dept_dname;
	DROP INDEX IF EXISTS idx_dept_emp;
```
	
- **Searching by ename (exact match).**

```sql
	CREATE INDEX idx_emp_ename ON emp(ename);
```

- **Searching employees in a department with salary range.**

```sql
	CREATE INDEX idx_emp_dept_sal ON emp(deptno, sal);
```

- **Aggregating salaries by dept.**

```sql
	CREATE INDEX idx_emp_deptno ON emp(deptno);
```

- **Explain your choices.**

	- **idx_emp_ename: Speeds up exact name searches.**

	- **idx_emp_dept_sal: Composite index allows filtering employees by department and salary range efficiently.**

	- **idx_emp_deptno: Helps grouping or aggregating salaries by department.**

**This strategy balances search performance, range filtering, and aggregation optimization.**

## Conclusion
**This repository contains a complete SQL journey covering topics from basics to advanced concepts, including DML, DDL,** **Views, Materialized Views, Indexing, Stored Procedures, Query Optimization, and more.**  
**All exercises are tested in PostgreSQL.**  

## Completion of SQL Journey  
**Next: Building a hands-on SQL Project to showcase real-world data analytics skills.**

