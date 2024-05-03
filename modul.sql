show databases;
create database module;
use module;
create table emp(
empno int primary key not null,
 Ename VARCHAR(10),
 Job VARCHAR(9),
 Mgr INT,
Hiredate DATE,
Sal DECIMAL(7,2),
Comm DECIMAL(7,2),
Deptno INT,
FOREIGN KEY (Deptno) REFERENCES DEPT(Deptno)
);
select * from emp;
show tables;
CREATE TABLE DEPT (
    Deptno INT NOT NULL PRIMARY KEY,
    Dname VARCHAR(14),
    Loc VARCHAR(13)
);
select * from dept;

CREATE TABLE STUDENT (
    Rno INT NOT NULL PRIMARY KEY,
    Sname VARCHAR(14),
    City VARCHAR(20),
    State VARCHAR(20)
);

CREATE TABLE EMP_LOG (
    Emp_id INT not null,
    Log_date DATE,
    New_salary INT,
    Action VARCHAR(20)
);
drop table emp_log;
select * from emp_log;
INSERT INTO DEPT (Deptno, Dname, Loc) VALUES (10, 'ACCOUNTING', 'NEW YORK'),(20, 'RESEARCH', 'DALLAS'),(30, 'SALES', 'CHICAGO'), (40, 'OPERATIONS', 'BOSTON');
INSERT INTO EMP (Empno, Ename, Job, Mgr, Hiredate, Sal, Comm, Deptno) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-06-11', 3000.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-08-09', 1500.00, 0.00, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-07-13', 1100.00, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-03-12', 950.00, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-03-12', 3000.00, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);

-- question i. Select unique job from EMP table --

select distinct job from emp;

-- ii. List the details of the emps in asc order of the Dptnos and desc of Jobs? 
select Deptno job from emp order by deptno asc,  job desc;

-- Display all the unique job groups in the descending order? 
select  distinct job from emp group by job order by job desc; 

-- List the emps who joined before 1981.
select * from emp where year(Hiredate) < 1981;

-- List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal
select empno,ename,sal , sal/30 as daily_sal , sal*12 as annsal from emp order by annsal asc;

-- List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.
SELECT Empno, Ename, Sal, YEAR(CURDATE()) - YEAR(Hiredate) AS Exp FROM EMP WHERE Mgr = 7369;

-- Display all the details of the emps who’s Comm. Is more than their Sal?
SELECT * FROM EMP WHERE Comm > Sal;

-- List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.
SELECT * FROM EMP WHERE Job IN ('CLERK', 'ANALYST') ORDER BY Job DESC;

-- List the emps Who Annual sal ranging from 22000 and 45000. 
select empno,ename,sal , sal*12 as annual from emp where sal*12 between 22000 and 45000;

-- List the Enames those are starting with ‘S’ and with five characters.
select * from emp where ename like 's%' ;

-- List the emps whose Empno not starting with digit78
select  * from emp where empno like '78%';

-- List all the Clerks of Deptno 20
 select * from emp where  job = 'clerk' and deptno =20;
 
-- List the Emps who are senior to their own MGRS.


 -- List the Emps of Deptno 20 who’s Jobs are same as Deptno10
select * from emp where deptno = 20 and job in ( select distinct job from emp where deptno = 10);

-- List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.
select * from emp WHERE Sal IN (SELECT Sal FROM EMP WHERE Ename IN ('FORD', 'SMITH')) ORDER BY Sal DESC;

-- List the emps whose jobs same as SMITH or ALLEN

select * from emp where job in (select job from emp where ename in ('smith','allen'));
 
 -- . Any jobs of deptno 10 those that are not found in deptno 20.
 SELECT * FROM EMP WHERE Deptno = 10 AND Job NOT IN (SELECT job FROM EMP WHERE Deptno = 20);
 
 -- Find the highest sal of EMP table.
 
 select max(sal) as highest_sal from emp;
 
 -- Find details of highest paid employee.
select * from emp order by sal desc limit 1;

-- Find the total sal given to the MGR
select mgr,sum(sal) as total_sal from emp group by mgr;

-- List the emps whose names contains ‘A’
select * from emp where ename like '%a%';

-- Find all the emps who earn the minimum Salary for each job wise in ascending order.
 select job,min(sal) from emp  group by job  order by job asc;
 
 -- List the emps whose sal greater than Blake’s sal. 
 SELECT * FROM EMP WHERE Sal > (SELECT Sal FROM EMP WHERE Ename = 'BLAKE');
 
  -- Create view v1 to select ename, job, dname, loc whose deptno are same. 
  create view v1 as select e.ename ,e.job, d.dname , d.loc from DEPT as d join emp as e on d.Deptno = e.Deptno ;
  
  select * from v1;
  
  -- Create a procedure with dno as input parameter to fetch ename and dname.
  delimiter \\
  create procedure getemplydetail(in deptno int)
  begin
  select e.ename ,  d.dname   from dept as d join emp as e on d.deptno = e.deptno   WHERE e.deptno = deptno;
  end \\ 
  delimiter ;
  drop procedure getemplydetail;
  call getemplydetail(30);
  
 -- Add column Pin with bigint data type in table student.  
  ALTER TABLE student
ADD COLUMN Pin BIGINT;


-- Modify the student table to change the sname length from 14 to 40. Create trigger to insert data in emp_log table whenever any update of sal in EMP table. You can set action as ‘New Salary’. 

ALTER TABLE student
MODIFY COLUMN sname VARCHAR(40);

DELIMITER //
CREATE TRIGGER UpdateSalaryTrigger
AFTER UPDATE ON EMP
FOR EACH ROW
BEGIN
    IF OLD.sal != NEW.sal THEN
        INSERT INTO emp_log (Emp_id, action, Log_date,new_salary)
        VALUES (new.empno, 'New Salary', NOW(),new.sal);
    END IF;
END //
DELIMITER ;

update emp set sal = 1111 where empno = 7369;
select * from emp;
select * from emp_log;

 drop  trigger UpdateSalaryTrigger;

