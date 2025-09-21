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