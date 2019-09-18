
-- Questão 1 e 2
CREATE TABLE AUTOMOVEL (
	PLACA CHAR(8),
	DONO_DO_CARRO VARCHAR(30),
	CHASSI CHAR(21),
	MARCA VARCHAR(20),
	MODELO VARCHAR(20),
	COR VARCHAR(20),
	ANO CHAR(4),
	CPF_DO_SEGURADO CHAR(14)
);

CREATE TABLE SEGURADO (
	NOME VARCHAR(30), 
	DATA_DE_NASCIMENTO DATE,
	CPF CHAR(14),
	TELEFONE CHAR(30),
	ENDERECO TEXT,
	EMAIL CHAR(30),
	PLACA_DO_CARRO CHAR(8)
);
	
CREATE TABLE PERITO (
	NOME VARCHAR(30), 
	CPF CHAR(14),
	TELEFONE CHAR(20)
);

CREATE TABLE OFICINA (
	NOME VARCHAR(30), 
	CNPJ CHAR(30), 
	TELEFONE CHAR(20),
	ENDERECO TEXT,
	NUMERO_DO_CONTRATO CHAR,
	EMAIL VARCHAR(40)
);

CREATE TABLE SEGURO (
	PLACA_DO_CARRO CHAR(8),
	NOME_DO_SEGURADO VARCHAR(50),
	CPF_DO_SEGURADO CHAR(14),
	INICIO_DO_CONTRATO DATE,
	VALIDADE_DO_SEGURO DATE,
	PRECO_ANUAL NUMERIC

);

 
CREATE TABLE SINISTRO (
	ID VARCHAR(10),
	CATEGORIA TEXT,
	DATA_E_HORA TIMESTAMP,
	PLACA_DO_CARRO CHAR(8),
	LOCAL TEXT,
	CPF_CONDUTOR VARCHAR(50)

);


CREATE TABLE PERICIA (
	ID_DO_SINISTRO VARCHAR(10),
	CPF_DO_PERITO CHAR(14),
	ANALISE_DE_DANOS TEXT,
	FRANQUIA NUMERIC
);


CREATE TABLE REPARO (
	ID_DO_SINISTRO VARCHAR(10),
	VALOR_DO_REPARO	NUMERIC,
	DATA DATE,
	PLACA_DO_CARRO CHAR(8)
);

-- Questão 3


ALTER TABLE automovel ADD CONSTRAINT id_automovel PRIMARY KEY(PLACA,CPF_DO_SEGURADO);

ALTER TABLE segurado ADD CONSTRAINT id_segurado PRIMARY KEY(PLACA_DO_CARRO,CPF);

ALTER TABLE perito ADD CONSTRAINT id_perito PRIMARY KEY(CPF);

ALTER TABLE oficina ADD CONSTRAINT id_oficina PRIMARY KEY(CNPJ,NUMERO_DO_CONTRATO);

ALTER TABLE seguro ADD CONSTRAINT id_seguro PRIMARY KEY(PLACA_DO_CARRO,CPF_DO_SEGURADO);

ALTER TABLE sinistro ADD CONSTRAINT id_sinistro PRIMARY KEY(ID);

ALTER TABLE pericia ADD CONSTRAINT id_pericia PRIMARY KEY(ID_DO_SINISTRO);

ALTER TABLE reparo ADD CONSTRAINT id_reparo PRIMARY KEY(ID_DO_SINISTRO);


-- Questão 4

ALTER TABLE automovel ADD CONSTRAINT automovel_seguro FOREIGN KEY(PLACA,CPF_DO_SEGURADO) REFERENCES SEGURO(PLACA_DO_CARRO,CPF_DO_SEGURADO);
--ALTER TABLE automovel ADD CONSTRAINT automovel_sinistro FOREIGN KEY(PLACA) REFERENCES SINISTRO(PLACA_DO_CARRO);

ALTER TABLE segurado ADD CONSTRAINT segurado_seguro FOREIGN KEY(PLACA_DO_CARRO,CPF) REFERENCES seguro(PLACA_DO_CARRO,CPF_DO_SEGURADO);

ALTER TABLE sinistro ADD CONSTRAINT sinistro_pericia FOREIGN KEY(ID) REFERENCES pericia(ID_DO_SINISTRO);

ALTER TABLE pericia ADD CONSTRAINT pericia_reparo FOREIGN KEY(ID_DO_SINISTRO) REFERENCES reparo(ID_DO_SINISTRO);


-- Questão 6


DROP TABLE automovel;
DROP TABLE oficina;
DROP TABLE pericia CASCADE;
DROP TABLE perito;
DROP TABLE reparo;
DROP TABLE segurado;
DROP TABLE seguro;
DROP TABLE sinistro;

-- Questão 7


CREATE TABLE SEGURO (
	PLACA_DO_CARRO CHAR(8),
	NOME_DO_SEGURADO VARCHAR(50) NOT NULL,
	CPF_DO_SEGURADO CHAR(14),
	INICIO_DO_CONTRATO DATE NOT NULL,
	VALIDADE_DO_SEGURO DATE NOT NULL,
	PRECO_ANUAL NUMERIC NOT NULL,
	PRIMARY KEY(PLACA_DO_CARRO,CPF_DO_SEGURADO)

);

CREATE TABLE SEGURADO (
	NOME VARCHAR(30) NOT NULL, 
	DATA_DE_NASCIMENTO DATE NOT NULL,
	CPF CHAR(14),
	TELEFONE CHAR(30),
	ENDERECO TEXT NOT NULL,
	EMAIL CHAR(30),
	PLACA_DO_CARRO CHAR(8),
	PRIMARY KEY(PLACA_DO_CARRO,CPF),
	FOREIGN KEY(PLACA_DO_CARRO,CPF) REFERENCES seguro(PLACA_DO_CARRO,CPF_DO_SEGURADO)
);

CREATE TABLE AUTOMOVEL (
	PLACA CHAR(8),
	DONO_DO_CARRO VARCHAR(30) NOT NULL,
	CHASSI CHAR(21) NOT NULL,
	MARCA VARCHAR(20),
	MODELO VARCHAR(20),
	COR VARCHAR(20),
	ANO CHAR(4),
	CPF_DO_SEGURADO CHAR(14),
	PRIMARY KEY(PLACA,CPF_DO_SEGURADO),
	FOREIGN KEY (PLACA,CPF_DO_SEGURADO) REFERENCES seguro(PLACA_DO_CARRO,CPF_DO_SEGURADO)
);


	
CREATE TABLE PERITO (
	NOME VARCHAR(30) NOT NULL, 
	CPF CHAR(14),
	TELEFONE CHAR(20) NOT NULL,
	PRIMARY KEY(CPF)
);

CREATE TABLE OFICINA (
	NOME VARCHAR(30) NOT NULL, 
	CNPJ CHAR(30) NOT NULL, 
	TELEFONE CHAR(20),
	ENDERECO TEXT NOT NULL,
	NUMERO_DO_CONTRATO CHAR,
	EMAIL VARCHAR(40) NOT NULL,
	PRIMARY KEY(CNPJ,NUMERO_DO_CONTRATO)
);


CREATE TABLE REPARO (
	ID_DO_SINISTRO VARCHAR(10),
	VALOR_DO_REPARO	NUMERIC NOT NULL,
	DATA DATE NOT NULL,
	PLACA_DO_CARRO CHAR(8) NOT NULL,
	PRIMARY KEY(ID_DO_SINISTRO)
);

CREATE TABLE PERICIA (
	ID_DO_SINISTRO VARCHAR(10),
	CPF_DO_PERITO CHAR(14) NOT NULL,
	ANALISE_DE_DANOS TEXT NOT NULL,
	FRANQUIA NUMERIC NOT NULL,
	PRIMARY KEY(ID_DO_SINISTRO),	
	FOREIGN KEY(ID_DO_SINISTRO) REFERENCES reparo(ID_DO_SINISTRO)
);
 
CREATE TABLE SINISTRO (
	ID VARCHAR(10),
	CATEGORIA TEXT NOT NULL,
	DATA_E_HORA TIMESTAMP NOT NULL,
	PLACA_DO_CARRO CHAR(8) NOT NULL,
	LOCAL TEXT NOT NULL,
	CPF_CONDUTOR VARCHAR(50) NOT NULL,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID) REFERENCES pericia(ID_DO_SINISTRO)
);


-- Questão 9 

DROP TABLE segurado;
DROP TABLE automovel;
DROP TABLE seguro;
DROP TABLE sinistro;
DROP TABLE pericia;
DROP TABLE reparo;
DROP TABLE oficina;
DROP TABLE perito;




