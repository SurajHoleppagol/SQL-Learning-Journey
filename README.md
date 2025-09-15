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