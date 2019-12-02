--Questao 1

CREATE VIEW vw_dptmgr 
AS SELECT dnumber, fname, lname
FROM department, employee
WHERE mgrssn = ssn;

CREATE VIEW vw_empl_houston
AS SELECT ssn, fname
FROM employee
WHERE address LIKE '%Houston%';

CREATE VIEW vw_deptstats
AS SELECT dnumber, dname, count(ssn) AS quant_func
FROM department, employee
WHERE dnumber = dno
GROUP BY dnumber;

CREATE VIEW vw_projstats
AS SELECT pno AS projetoID, count(essn) AS quant_func
FROM works_on
GROUP BY pno;

-- Funcao do roteiro 9 - questao 2
CREATE FUNCTION check_age(pssn char(9))
RETURNS VARCHAR(10) AS
$$

DECLARE
	idade integer;

BEGIN
	SELECT extract(year FROM age(bdate)) INTO idade FROM employee WHERE ssn = pssn;
	RAISE NOTICE 'Idade: %', idade;
	
	IF( idade >= 50) THEN RETURN 'SENIOR';
	ELSEIF(idade <= 0) THEN RETURN 'INVALID';
	ELSEIF(idade <= 50) THEN RETURN 'YOUNG';
	ELSEIF(idade is NULL) THEN RETURN 'UNKNOWN';

	END IF;
	

END;


$$ LANGUAGE plpgsql;


-- roteiro 9 -- questao 3

CREATE FUNCTION check_mgr() RETURNS TRIGGER
AS
$$
	DECLARE
		mgr_ssn CHAR(9);
		idade_status INTEGER;

	BEGIN 
		idade_status := SELECT check_age(NEW.mgrssn);

		IF NOT EXISTS (SELECT e.ssn FROM employee AS e, department as d WHERE (NEW.mgrssn = e.ssn and e.dno = d.dnumber) ) 
		THEN RAISE EXCEPTION 'manager must be a departments employee';
		END IF;

		IF NOT EXISTS (SELECT e.ssn FROM employee AS e WHERE (NEW.mgrssn = e.superssn) ) 
		THEN RAISE EXCEPTION 'manager must have supervisees';
		END IF;

		IF (idade_status != 'SENIOR') THEN RAISE EXCEPTION 'manager must be a SENIOR employee';
		END IF;


	END;

$$ LANGUAGE plpgsql;



CREATE TRIGGER check_mgr
BEFORE INSERT ON department

FOR EACH ROW EXECUTE PROCEDURE check_mgr();


