CREATE DATABASE IF NOT EXISTS HR;
USE HR;

CREATE TABLE emp (
  empno DECIMAL(4,0) NOT NULL,
  ename VARCHAR(10) DEFAULT NULL,
  job VARCHAR(9) DEFAULT NULL,
  mgr DECIMAL(4,0) DEFAULT NULL,
  hiredate DATE DEFAULT NULL,
  sal DECIMAL(7,2) DEFAULT NULL,
  comm DECIMAL(7,2) DEFAULT NULL,
  deptno DECIMAL(2,0) DEFAULT NULL,
  PRIMARY KEY (empno)
);

CREATE TABLE dept (
  deptno DECIMAL(2,0) NOT NULL,
  dname VARCHAR(14) DEFAULT NULL,
  loc VARCHAR(13) DEFAULT NULL,
  PRIMARY KEY (deptno)
);

CREATE TABLE salgrade (
  grade INT NOT NULL PRIMARY KEY,
  losal INT NOT NULL,
  hisal INT NOT NULL
);

INSERT INTO dept (deptno, dname, loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp VALUES
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10),
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, NULL, 20);

INSERT INTO salgrade VALUES
(1, 700, 1200),
(2, 1201, 1400),
(3, 1401, 2000),
(4, 2001, 3000),
(5, 3001, 9999);




-- 1. Display all details of employees.
SELECT * FROM emp;

-- 2. Display employee name and salary.
SELECT ename, sal FROM emp;

-- 3. Display employee name and department number.
SELECT ename, deptno FROM emp;

-- 4. Display distinct job titles from the EMP table.
SELECT DISTINCT job FROM emp;

-- 5. Display employees who belong to department number 30.
SELECT * FROM emp WHERE deptno = 30;

-- 6. Display employees whose salary is greater than 2000.
SELECT * FROM emp WHERE sal > 2000;

-- 7. Display employees hired after 01-JAN-1981.
SELECT * FROM emp WHERE hiredate > '1981-01-01';

-- 8. Display employees whose name starts with the letter S.
SELECT * FROM emp WHERE ename LIKE 'S%';

-- 9. Display employees who receive any commission.
SELECT * FROM emp WHERE comm IS NOT NULL;
SELECT * FROM emp WHERE comm IS NOT NULL AND comm > 0;

-- 10. Display employees whose department number is 10 or 20.
SELECT * FROM emp WHERE deptno IN (10, 20);

-- 11. Display all employees sorted by salary in descending order.
SELECT * FROM emp ORDER BY sal DESC;

-- 12. Display employee name, salary and commission sorted by name.
SELECT ename, sal, comm FROM emp ORDER BY ename;

-- 13. Display employees who have no manager.
SELECT * FROM emp WHERE mgr IS NULL;

-- 14. Display the location of department number 20.
SELECT loc FROM dept WHERE deptno = 20;

-- 15. Display department details sorted by department name in alphabetical order.
SELECT * FROM dept ORDER BY dname;

-- 16. Display employees whose salary is between 1000 and 2000.
SELECT * FROM emp WHERE sal BETWEEN 1000 AND 2000;

-- 17. Count the total number of employees in the EMP table.
SELECT COUNT(*) FROM emp;

-- 18. Display the minimum and maximum salary from the EMP table.
SELECT MIN(sal) AS min_salary, MAX(sal) AS max_salary FROM emp;

-- 19. Display total number of employees for each job title.
SELECT job, COUNT(*) AS num_employees FROM emp GROUP BY job;

-- 20. Display the current system date in MySQL.
SELECT CURDATE() AS today_date, NOW() AS current_datetime;


-- 21. Display employee name, salary and yearly salary (salary * 12).
SELECT ename, sal, sal * 12 AS yearly_salary FROM emp;

-- 22. Display employees who joined in the year 1981.
SELECT * FROM emp WHERE YEAR(hiredate) = 1981;

-- 23. Display employee details sorted by hire date in descending order.
SELECT * FROM emp ORDER BY hiredate DESC;

-- 24. Display the average salary of each department.
SELECT deptno, AVG(sal) AS avg_salary FROM emp GROUP BY deptno;

-- 25. Display employee name along with department name using a join operation.
SELECT e.ename, d.dname 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno;

-- 26. Display employees earning more than the average salary of the company.
SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp);

-- 27. Display employees who have commission in each department.
SELECT deptno, ename, comm 
FROM emp 
WHERE comm IS NOT NULL 
ORDER BY deptno;

-- 28. Display employees whose name contains the character A (case-insensitive).
SELECT * FROM emp WHERE ename LIKE '%A%' OR ename LIKE '%a%';
SELECT * FROM emp WHERE ename LIKE '%A%';

-- 29. Display the highest salary of each job title.
SELECT job, MAX(sal) AS highest_salary FROM emp GROUP BY job;

-- 30. Display employees who work in the department located in NEW YORK.
SELECT e.* 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
WHERE d.loc = 'NEW YORK';

-- 31. Display employees who were hired on a Monday.
SELECT * FROM emp WHERE DAYOFWEEK(hiredate) = 2;

-- 32. Count the number of employees who do not receive commission.
SELECT COUNT(*) FROM emp WHERE comm IS NULL OR comm = 0;
SELECT COUNT(*) FROM emp WHERE comm IS NULL;

-- 33. Display job titles along with the total commission paid for each job.
SELECT job, SUM(IFNULL(comm, 0)) AS total_commission FROM emp GROUP BY job;

-- 34. Display departments having more than 3 employees.
SELECT deptno, COUNT(*) AS num_employees 
FROM emp 
GROUP BY deptno 
HAVING COUNT(*) > 3;

-- 35. Display the employees who draw the second highest salary.
SELECT * FROM emp 
WHERE sal = (
    SELECT DISTINCT sal FROM emp 
    ORDER BY sal DESC 
    LIMIT 1 OFFSET 1
);

-- 36. Display employees who have the same job title as SMITH.
SELECT * FROM emp 
WHERE job = (SELECT job FROM emp WHERE ename = 'SMITH') 
AND ename != 'SMITH';

-- 37. Display each employee's salary grade using the SALGRADE table.
SELECT e.ename, e.sal, s.GRADE 
FROM emp e 
JOIN SALGRADE s ON e.sal BETWEEN s.LOSAL AND s.HISAL;

-- 38. Display employee name, salary and salary grade together.
SELECT e.ename, e.sal, s.GRADE 
FROM emp e 
JOIN SALGRADE s ON e.sal BETWEEN s.LOSAL AND s.HISAL;

-- 39. Display employees who are managers.
SELECT DISTINCT e.* 
FROM emp e 
JOIN emp m ON e.empno = m.mgr;

-- 40. Display the employee who earns the highest salary in department 30.
SELECT * FROM emp 
WHERE deptno = 30 
ORDER BY sal DESC 
LIMIT 1;

-- ==================
-- III. Subqueries, Joins, Views, DDL, DML and Advanced SQL Concepts (Advanced Level)
-- ==================

-- 41. Display the employee(s) who earn the highest salary in the company.
SELECT * FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);

-- 42. Display employees who earn more than the average salary of their department.
SELECT e.* 
FROM emp e 
WHERE e.sal > (
    SELECT AVG(sal) 
    FROM emp 
    WHERE deptno = e.deptno
);

-- 43. Display the department having the maximum total salary paid to employees.
SELECT deptno, SUM(sal) AS total_salary 
FROM emp 
GROUP BY deptno 
ORDER BY total_salary DESC 
LIMIT 1;

-- 44. Display employees who joined before their respective manager joined.
SELECT e.ename AS employee, e.hiredate AS emp_hire_date, 
       m.ename AS manager, m.hiredate AS mgr_hire_date
FROM emp e 
JOIN emp m ON e.mgr = m.empno 
WHERE e.hiredate < m.hiredate;

-- 45. Display department details where no employees are working.
SELECT d.* 
FROM dept d 
LEFT JOIN emp e ON d.deptno = e.deptno 
WHERE e.empno IS NULL;

-- 46. Display the third highest salary using a subquery.
SELECT DISTINCT sal 
FROM emp 
ORDER BY sal DESC 
LIMIT 1 OFFSET 2;

SELECT * FROM emp 
WHERE sal = (
    SELECT DISTINCT sal 
    FROM emp 
    ORDER BY sal DESC 
    LIMIT 1 OFFSET 2
);



-- 47. Display the count of employees hired month-wise.
SELECT DATE_FORMAT(hiredate, '%Y-%m') AS hire_month, COUNT(*) AS num_employees 
FROM emp 
GROUP BY hire_month 
ORDER BY hire_month;

-- 48. Display employees who joined after the employee FORD joined.
SELECT * FROM emp 
WHERE hiredate > (SELECT hiredate FROM emp WHERE ename = 'FORD');

-- 49. Display the employees whose department number is not present in the DEPT table.
SELECT * FROM emp 
WHERE deptno NOT IN (SELECT deptno FROM dept);

SELECT * FROM emp e
WHERE NOT EXISTS (
    SELECT 1 FROM dept d WHERE d.deptno = e.deptno
);



-- 50. Display job titles along with the difference between maximum and minimum salary of that job.
SELECT job, 
       MAX(sal) - MIN(sal) AS salary_difference 
FROM emp 
GROUP BY job;

-- 51. Display employee names along with the length of each name.
SELECT ename, LENGTH(ename) AS name_length FROM emp;

-- 52. Display salaries formatted to two decimal places.
SELECT ename, FORMAT(sal, 2) AS formatted_salary FROM emp;

-- 53. Display each employee name masked after the first three characters (example: SMI****).
SELECT CONCAT(LEFT(ename, 3), REPEAT('*', LENGTH(ename) - 3)) AS masked_name FROM emp;

-- 54. Display employee name and commission, replacing NULL values with the text "No Commission".
SELECT ename, IFNULL(comm, 'No Commission') AS commission FROM emp;

-- 55. Create a view to display employee name, salary and department name.
CREATE OR REPLACE VIEW emp_dept_view AS
SELECT e.ename, e.sal, d.dname 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno;

-- 56. Update the salary of employees belonging to department number 10 by 10 percent.
UPDATE emp SET sal = sal * 1.10 WHERE deptno = 10;

-- 57. Delete employees who are not belonging to any department.
DELETE FROM emp WHERE deptno IS NULL;

-- 58. Insert a new employee with department number is the department name "HR".
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (9999, 'NEWemp', 'CLERK', NULL, CURDATE(), 2000, NULL, 
        (SELECT deptno FROM dept WHERE dname = 'HR'));

INSERT INTO dept (deptno, dname, loc) VALUES (50, 'HR', 'BOSTON');

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (9999, 'NEWemp', 'CLERK', NULL, CURDATE(), 2000, NULL,
        (SELECT deptno FROM dept WHERE dname = 'HR'));

-- 59. Display employees working in the same department as BLAKE.
SELECT * FROM emp 
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'BLAKE') 
AND ename != 'BLAKE';

-- 60. Display employees whose job title appears more than once in the EMP table.
SELECT * FROM emp 
WHERE job IN (
    SELECT job FROM emp GROUP BY job HAVING COUNT(*) > 1
);

-- 61. Display employee details whose salary is higher than the maximum salary of employees in department 10.
SELECT * FROM emp 
WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 10);

-- 62. Display employees who earn more than every employee in department 30.
SELECT * FROM emp 
WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 30);

-- 63. Display departments where all employees earn commission.
SELECT deptno 
FROM emp 
GROUP BY deptno 
HAVING COUNT(*) = COUNT(comm) AND COUNT(comm) > 0;

-- 64. Display employees whose salary matches the minimum salary of their own department.
SELECT e.* 
FROM emp e 
WHERE e.sal = (
    SELECT MIN(sal) FROM emp WHERE deptno = e.deptno
);

-- 65. Display job title and employee whose salary is below the average salary of that job.
SELECT ename, job, sal 
FROM emp e 
WHERE sal < (
    SELECT AVG(sal) FROM emp WHERE job = e.job
);

-- 66. Display employees who have the same salary in their respective job.
SELECT e1.* 
FROM emp e1 
JOIN emp e2 ON e1.sal = e2.sal AND e1.job = e2.job AND e1.empno != e2.empno;

-- 67. Display employees who work in a department located in the same city as the department of KING.
SELECT e.* 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
WHERE d.loc = (
    SELECT loc FROM dept WHERE deptno = (
        SELECT deptno FROM emp WHERE ename = 'KING'
    )
);

-- 68. Display employees whose salary is equal to the average salary grade 4 range.
SELECT * FROM emp 
WHERE sal = (
    SELECT (LOSAL + HISAL) / 2 FROM SALGRADE WHERE GRADE = 4
);

-- 69. Display employees who earn the second highest salary in each department.
SELECT e1.* 
FROM emp e1 
WHERE 1 = (
    SELECT COUNT(DISTINCT e2.sal) 
    FROM emp e2 
    WHERE e2.deptno = e1.deptno AND e2.sal > e1.sal
);

-- 70. Display employee names that have the last name that does not end in S.
SELECT * FROM emp WHERE ename NOT LIKE '%S';


-- 71. Display departments where no manager is assigned based on EMP table details.
SELECT DISTINCT deptno 
FROM emp 
WHERE deptno NOT IN (
    SELECT DISTINCT deptno FROM emp WHERE empno IN (SELECT mgr FROM emp WHERE mgr IS NOT NULL)
);

SELECT d.deptno
FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno AND e.empno IN (SELECT mgr FROM emp)
WHERE e.empno IS NULL;

-- 72. Display employees who earn a salary that falls into the highest grade in SALGRADE.
SELECT e.* 
FROM emp e 
JOIN SALGRADE s ON e.sal BETWEEN s.LOSAL AND s.HISAL 
WHERE s.GRADE = (SELECT MAX(GRADE) FROM SALGRADE);

-- 73. Display departments and their total salary, showing only the top 3 highest paid departments.
SELECT deptno, SUM(sal) AS total_salary 
FROM emp 
GROUP BY deptno 
ORDER BY total_salary DESC 
LIMIT 3;

-- 74. Display the employee who has the earliest hire date in each department using a correlated subquery.
SELECT e.* 
FROM emp e 
WHERE e.hiredate = (
    SELECT MIN(hiredate) FROM emp WHERE deptno = e.deptno
);

-- 75. Display all departments that have less than the average number of employees compared to all departments.
SELECT deptno, COUNT(*) AS num_employees 
FROM emp 
GROUP BY deptno 
HAVING COUNT(*) < (
    SELECT AVG(emp_count) FROM (
        SELECT COUNT(*) AS emp_count FROM emp GROUP BY deptno
    ) AS dept_counts
);

-- 76. Display employees whose managers work in a different location than the employee.
SELECT e.ename, e.deptno, ed.loc AS emp_loc, 
       m.ename AS manager, md.loc AS mgr_loc
FROM emp e 
JOIN dept ed ON e.deptno = ed.deptno 
JOIN emp m ON e.mgr = m.empno 
JOIN dept md ON m.deptno = md.deptno 
WHERE ed.loc != md.loc;

-- 77. Display employees who work in a department where the total salary is greater than all other departments.
SELECT e.* 
FROM emp e 
WHERE e.deptno = (
    SELECT deptno 
    FROM emp 
    GROUP BY deptno 
    ORDER BY SUM(sal) DESC 
    LIMIT 1
);

-- 78. Display the name of the department and employees who earn a salary greater than the average of all managers.
SELECT d.dname, e.ename, e.sal 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
WHERE e.sal > (
    SELECT AVG(sal) 
    FROM emp 
    WHERE empno IN (SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL)
);

-- 79. Display the department name and employee name for employees who earn more than their manager.
SELECT d.dname, e.ename AS employee, e.sal AS emp_salary, 
       m.ename AS manager, m.sal AS mgr_salary
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
JOIN emp m ON e.mgr = m.empno 
WHERE e.sal > m.sal;

-- 80. Display employee name, salary, and department name for employees whose salary is in salary grade 3.
SELECT e.ename, e.sal, d.dname 
FROM emp e 
JOIN dept d ON e.deptno = d.deptno 
JOIN SALGRADE s ON e.sal BETWEEN s.LOSAL AND s.HISAL 
WHERE s.GRADE = 3;



