

--Q1
SELECT COUNT(sex) AS qtd_func_fem FROM employee WHERE sex='F';

--Q2
SELECT AVG(salary) AS avg_salary_texas FROM employee WHERE address like '%TX' AND sex='M';

--Q3
SELECT superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados FROM employee GROUP BY superssn ORDER BY COUNT(*);

--Q4
SELECT s.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM (employee AS e JOIN employee AS s ON e.superssn = s.ssn) GROUP BY s.ssn ORDER BY COUNT(*),s.fname;

--Q5
SELECT s.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM (employee AS e LEFT OUTER JOIN employee AS s ON e.superssn = s.ssn) GROUP BY s.ssn ORDER BY COUNT(*),s.fname;

--Q6
SELECT min(qtd) AS qtd from (SELECT COUNT(*) AS qtd FROM works_on GROUP BY pno) AS temp;

--Q7

--Q8
SELECT pno as num_proj, avg(salary) as media_sal FROM(
SELECT pno, essn, salary FROM employee JOIN works_on ON essn=ssn
) as temp group by pno
;
--Q9
SELECT pname, pno as num_proj, avg(salary) as media_sal FROM ( (SELECT pno, essn, salary FROM employee JOIN works_on ON essn=ssn) AS temp JOIN project as p ON pno = p.pnumber) as temp2 GROUP BY pname,pno;

--Q10
SELECT e.fname, e.salary FROM (SELECT max(salary) AS top_salary FROM employee JOIN works_on ON essn=ssn and pno='92') as top92 ,employee AS e WHERE  e.salary > top_salary;

--Q11
SELECT e.ssn, count(pno) as qtd_proj FROM employee AS e LEFT OUTER JOIN works_on ON essn=ssn GROUP BY e.ssn ORDER BY qtd_proj;

--Q12
SELECT proj_num, qtd_func FROM(SELECT w.pno AS proj_num, count(essn) AS qtd_func FROM employee AS e LEFT OUTER JOIN works_on AS w ON e.ssn = w.essn GROUP BY proj_num) AS temp WHERE qtd_func < 5;

--Q13

SELECT e.fname FROM employee AS e WHERE EXISTS(
    SELECT w.essn FROM works_on AS w WHERE EXISTS(
        SELECT pnumber FROM project WHERE (plocation = 'Sugarland') AND pnumber = w.pno)
    AND(e.ssn = w.essn)
)
AND EXISTS (SELECT d.essn FROM dependent AS d WHERE (e.ssn = d.essn));

--Q14
SELECT dname FROM department WHERE NOT EXISTS (
SELECT dnum FROM project WHERE dnumber=dnum);

--Q15
SELECT fname, lname FROM employee AS e WHERE NOT EXISTS((SELECT pno FROM works_on AS w WHERE essn = '123456789')
EXCEPT ((SELECT pno FROM works_on AS o WHERE o.essn = e.ssn))) AND (e.ssn !='123456789');

