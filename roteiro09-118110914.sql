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

-- questao 4 
CREATE FUNCTION check_age(pssn char(9))
RETURNS char(20) AS
BEGIN
	DECLARE 
	idade integer;
	retorno char(20);
 
	SELECT extract(year from age(bdate)) INTO idade FROM employee as e WHERE e.ssn = pssn

	print(idade)

		IF idade > 50 BEGIN
		SET retorno = 'SENIOR'
		END

		ELSE IF idade < 50 BEGIN
		SET retorno = 'YOUNG'
		END
		
		ELSE IF idade IS NULL BEGIN
		SET retorno = 'YOUNG'
		END

		ELSE IF idade < 0 BEGIN
		SET retorno = 'INVALID'
		END
	RETURN retorno
END;

CREATE FUNCTION check_age(pssn char(9))
RETURNS char(20) AS $$

DECLARE 
idade integer;

BEGIN
 
SELECT extract(year from age(bdate)) INTO idade FROM employee as e WHERE e.ssn = pssn;


	
	IF (idade > 50) THEN RETURN 'SENIOR'
	
	
	ELSIF (idade < 50) THEN RETURN 'YOUNG'
	
	
	ELSIF (idade IS NULL) THEN RETURN 'YOUNG'
	
	
	ELSIF (idade < 0) THEN RETURN 'INVALID'
	END IF;

END;
$$ LANGUAGE plpgsql;
