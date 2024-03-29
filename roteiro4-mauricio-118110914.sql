--Q1
SELECT * FROM department;
--Q2
SELECT * FROM dependent;
--Q3
SELECT * FROM dept_locations;
--Q4
SELECT * FROM employee;
--Q5
SELECT * FROM project;
--Q6
SELECT * FROM works_on;
--Q7
SELECT fname,lname FROM employee WHERE sex = 'M';
--Q8
SELECT fname FROM employee WHERE (superssn is null) AND (sex = 'M');
--Q9
SELECT e.fname as func_name, s.fname as super_name FROM employee as e, employee as s WHERE(e.superssn is not null) AND (e.superssn = s.ssn);
--Q10
SELECT e.fname FROM employee as e, employee as s WHERE(s.fname = 'Franklin') and (e.superssn = s.ssn);
--Q11
SELECT dept.dname as departamentos,l.dlocation as localizacoes FROM department as dept, dept_locations as l WHERE(dept.dnumber = l.dnumber); 
--Q12
SELECT dept.dname as departamentos,l.dlocation as localizacoes FROM department as dept, dept_locations as l WHERE(dept.dnumber = l.dnumber) and (l.dlocation LIKE 'S%'); 
--Q13
SELECT e.fname as emp_fname, e.lname as emp_lname, d.dependent_name FROM employee as e, dependent as d WHERE (e.ssn = d.essn);
--Q14
SELECT fname || ' ' || minit || ' ' || lname as full_name, salary FROM employee WHERE(salary > 50000);
--Q15
SELECT p.pname, d.dname from project as p, department as d WHERE (p.dnum = d.dnumber); 
--Q16
SELECT p.pname, e.fname from project as p, department as d, employee as e WHERE (p.dnum = d.dnumber and d.mgrssn = e.ssn); 
--Q17
SELECT p.pname, e.fname FROM project as p, works_on as w, employee as e WHERE (p.pnumber = w.pno) and (e.ssn = w.essn);
--Q18
SELECT d.dependent_name, e.fname AS emp_fname, d.relationship FROM dependent AS d, employee AS e, works_on AS w WHERE(w.essn = e.ssn) AND (w.pno = '91') AND (d.essn = e.ssn);
