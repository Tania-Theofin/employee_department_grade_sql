use codeathon;

-- Section 1: Basic SELECT Queries
-- Q: Display all information about all employees.
select * from EMPLOYEE;
-- Q: Display the employee number, name, and salary of all employees.
select EMPNO, ENAME, SAL from EMPLOYEE;
-- Q: Display the unique job titles from the EMPLOYEE table.
select distinct JOB from EMPLOYEE;
-- Q: Display the employee name and their annual salary (SAL * 12)
select ENAME, SAL*12 as annual_salary from EMPLOYEE;
-- Q: Display the details of all employees from department number 10.
select * from EMPLOYEE where DEPTNO='10';
-- Q: Display the name and job of employees who are ‘CLERK’
select ENAME, JOB from EMPLOYEE where JOB='CLERK';
-- Q: Display the name of employees whose name starts with ‘S’.
select ENAME from EMPLOYEE where ENAME like 'S%';
-- Q: Display the name of employees where the second letter of their name is ‘L’.
select ENAME from EMPLOYEE where ENAME like '_L%';
-- Q: Display the name of employees who have ‘AR’ in their name.
select ENAME from EMPLOYEE where ENAME like '%AR%';
-- Q: Display the details of employees who were hired in the year 1981.
select * from EMPLOYEE WHERE year(HIREDATE)='1981';
-- Q: Display the name and salary of employees who earn more than 2500
select ENAME, SAL from EMPLOYEE where SAL>2500;
-- Q: Display the details of employees who are not ‘MANAGER’
select * from EMPLOYEE WHERE JOB!='MANAGER';
-- Q: Display the details of employees who have a commission.
select * from EMPLOYEE WHERE COMM!='NULL';
-- Q: Display the details of employees who do not have a manager.
select * from EMPLOYEE WHERE MGR='NULL';
-- Q: Display the names of all employees from department 30 who are ‘SALESMAN’.
select * from EMPLOYEE where DEPTNO=30 and JOB='SALESMAN';
-- Q: Display the names of all ‘CLERK’s and ‘ANALYST’s.
select ENAME from EMPLOYEE where JOB='CLERK'or JOB='ANALYST';
-- Q: Display the names of employees whose salary is between 1000 and 2000.
select ENAME from EMPLOYEE WHERE SAL between 1000 and 2000;

-- Section 2: Ordering and Grouping

-- Q: Display employee details sorted by their name in alphabetical order.
select * from EMPLOYEE order by ENAME asc;

-- Q: Display employee details sorted by department number, and then by salary in descending order.
select * from EMPLOYEE order by DEPTNO asc, SAL desc;

-- Q: Display the total number of employees.
select count(*) as total_number_of_employees from EMPLOYEE;

-- Q: Find the total salary paid to all employees.
select sum(SAL) as total_salary from EMPLOYEE;

-- Q: Find the average salary of all employees
select avg(SAL) as average_salary from EMPLOYEE;

-- Q: Find the maximum and minimum salary from the EMPLOYEE table.
select max(SAL) as max_salry, min(SAL) as min_salary from EMPLOYEE;

-- Q: Count the number of employees in each department.
select DEPTNO, count(*) from EMPLOYEE group by DEPTNO;

-- Q: Find the average salary for each job type.
select JOB, avg(SAL) from EMPLOYEE group by JOB;

-- Q: Find the total salary for each department.
select DEPTNO, sum(SAL) from EMPLOYEE group by DEPTNO;

-- Q: Display the department numbers that have more than 3 employees.
select DEPTNO, count(*) from EMPLOYEE group by DEPTNO having count(*)>3;

-- Q: Display the jobs where the average salary is more than 2000.
select JOB, avg(SAL) from EMPLOYEE group by JOB having avg(SAL)>2000;

-- Section 3: Joins and Subqueries
-- Q: Display the employee name and their department name.
select E.ENAME, D.DNAME from EMPLOYEE E INNER JOIN DEPARTMENT D ON E.DEPTNO=D.DEPTNO;

-- Q: Display the employee name, department name, and location for all employees.
select E.ENAME, D.DNAME, D.LOC  from EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.DEPTNO=D.DEPTNO;

-- Q: Display the name of the employee and the name of their manager.
select E.ENAME as employee_name, M.ENAME as employee_manager from EMPLOYEE E LEFT JOIN EMPLOYEE M on E.MGR=M.EMPNO;

-- Display the employee name, salary, and salary grade.
select E.ENAME as employee_name, E.SAL as employee_salary, G.GRADE as salary_grade from EMPLOYEE E inner join GRADE G ON E.SAL BETWEEN G.LOSAL AND G.HISAL;

-- Display the employee name for those working in ‘NEW YORK’.
select E.ENAME as employee_name from EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.DEPTNO=D.DEPTNO WHERE D.LOC='NEW YORK';

-- Find the name of the department where ‘SMITH’ works.
select D.DNAME as department_name from EMPLOYEE E INNER JOIN DEPARTMENT D ON E.DEPTNO=D.DEPTNO WHERE E.ENAME='SMITH';

-- Q: Display the names of employees who earn more than ‘ALLEN’. (Subquery)
SELECT ENAME FROM EMPLOYEE WHERE SAL > (SELECT SAL FROM EMPLOYEE WHERE ENAME = 'ALLEN');

-- Q: Display the names of employees who work in the same department as ‘SCOTT’
select ENAME from EMPLOYEE where DEPTNO=(SELECT DEPTNO from EMPLOYEE where ENAME ='SCOTT') AND ENAME<>'SCOTT';

-- Q: Display the names of employees who have the same job as ‘JONES’
select ENAME from EMPLOYEE where JOB=(select JOB from EMPLOYEE where ENAME='JONES') AND ENAME<>'JONES';

-- Q: Display the names of managers who manage more than 2 employees.
select M.ENAME as manager_name from EMPLOYEE M INNER JOIN EMPLOYEE E on M.EMPNO=E.MGR group by M.ENAME having count(E.EMPNO)>2;

-- Section 4: Functions (String, Numeric, Date)

-- Q: Display the employee names in lowercase.
select LOWER(ENAME) from EMPLOYEE;

-- Q: Display the first three characters of each employee’s name.
select substring(ENAME,1,3) from EMPLOYEE;

-- Q: Display the length of each employee’s name.
select length(ENAME) from EMPLOYEE;

-- Q: Display the salary of each employee rounded to the nearest thousand.
select ENAME, round(SAL,-3) as rounded_salary from EMPLOYEE;

-- Q: Display the current date and time.
select now();

-- Q: Display the year each employee was hired.
select ENAME, YEAR(HIREDATE) as year_of_joining from EMPLOYEE;

-- Q: Display the name of the month each employee was hired
select ENAME, monthname(HIREDATE) as month_of_joining from EMPLOYEE;

-- Q: Display the number of years each employee has been with the company (assuming the current year is 2025).
select ENAME, (2025-year(HIREDATE)) as employee_experience from EMPLOYEE;

-- Section 5: DDL and DML
-- Q: Write the SQL command to create the DEPARTMENT table with DEPTNO as the primary key.
drop table DEPARTMENT;
CREATE TABLE DEPARTMENT (DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(50),
    LOC VARCHAR(50));
    
-- Q: Add a new column PINCODE of type INT to the DEPARTMENT table.
Alter table DEPARTMENT add PINCODE INT;

-- Q: Insert a new record for department 50, ‘HR’, located in ‘HOUSTON’ into the DEPARTMENT table.
insert into DEPARTMENT(DEPTNO, DNAME, LOC) VALUES (50,'HR', 'HOUSTON');

-- Q: Update the location of the ‘SALES’ department to ‘ATLANTA’.
SET SQL_SAFE_UPDATES = 0;
Update DEPARTMENT set LOC='ATLANTA' where DNAME='SALES';

-- Q: Delete the ‘OPERATIONS’ department from the table.
delete from DEPARTMENT where DNAME='OPERATIONS';