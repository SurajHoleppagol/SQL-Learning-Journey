-- -- Topic 9: Data Manipulation & Maintenance

-- INSERT, UPDATE, DELETE

-- Q1 Insert a new employee Peter into emp table with:
-- empno: 9001, job: ANALYST, deptno: 20, mgr: 7839, salary: 4000

	INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
	VALUES (9001,'PETER','ANALYST',7839,'1985-01-22',4000,null,20);

-- Q2 Update all employees in department 30 to increase salary by 10%.

	UPDATE emp
	SET sal=sal+(sal*0.10)
	WHERE deptno=30;

-- Q3 Delete all employees whose commission (comm) is NULL.

	DELETE FROM emp
	WHERE comm IS NULL;

-- Q4 Insert into emp table the details of employees who work in deptno=10, but copy them into a new dept 50. 

	INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
	SELECT empno+1000,ename,job,mgr,hiredate,sal,comm,50
	FROM emp
	WHERE deptno=10;

-- NOTE: Adding 1000 to empno to avoid primary key conflict.

-- Transactions

-- Q5 Begin a transaction. Insert a new employee and then roll it back. Show that the record is not in the table.

	BEGIN;

	INSERT INTO emp (empno, ename, job, sal, deptno)
	VALUES (9002, 'DAVID', 'ANALYST', 3500, 30);

	ROLLBACK;

	SELECT * FROM emp WHERE empno=9002;

-- Q6 Start a transaction:
-- Deduct 500 from employee KING’s salary., Add 500 to employee BLAKE’s salary., Commit the transaction.

	BEGIN;

	UPDATE emp
	SET sal=sal-500
	WHERE ename='KING';

	UPDATE emp
	SET sal=sal+500
	WHERE ename='BLAKE';

	COMMIT;
	
-- Q7 Simulate a money transfer: Write a transaction where salary is transferred from CLARK to SMITH. 
-- 		If CLARK’s salary becomes negative, rollback the entire transaction.

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