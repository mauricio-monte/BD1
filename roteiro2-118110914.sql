
--Questão 1

CREATE TABLE tarefas (
	id_tarefa numeric,
	descricao_da_tarefa varchar(250),
	cpf_do_funcionario char(11),
	andar_do_predio smallint,
	bloco_do_predio varchar(1)
);


INSERT INTO tarefas VALUES(2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
INSERT INTO tarefas VALUES(null, null, null, null, null);
-- Comandos que não devem funcionar:
-- Esta operação não deve funcionar porque o cpf do funcionario tem 1 dígito a mais do que o permitido.
INSERT INTO tarefas VALUES(2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');
-- Esta operação não funciona porque o ultimo atributo possui 2 letras, sendo que o foi estabelecido char(1) como domínio
INSERT INTO tarefas VALUES(2147483644, 'limpar chão do corredor superior', '98765432321', 0, 'FF');

-- Questão 2
INSERT INTO tarefas VALUES(2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

--Questão 3
--Nao deve funcionar
INSERT INTO tarefas VALUES(2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');
INSERT INTO tarefas VALUES(2147483650, 'limpar janelas da entrada principal','32333233288', 32769, 'A');
-- Deve funcionar
INSERT INTO tarefas VALUES(2147483651, 'limpar portas do 1o andar', '32323232911', 32767, 'A');
INSERT INTO tarefas VALUES(2147483652, 'limpar portas do 2o andar', '32323232911', 32766, 'A');

--Questão 4

ALTER TABLE tarefas RENAME id_tarefa TO id;
ALTER TABLE tarefas RENAME descricao_da_tarefa TO descricao;
ALTER TABLE tarefas RENAME cpf_do_funcionario TO func_resp_cpf;
ALTER TABLE tarefas RENAME andar_do_predio TO prioridade;
ALTER TABLE tarefas RENAME bloco_do_predio TO status;

DELETE FROM tarefas WHERE id IS NULL AND descricao IS NULL AND func_resp_cpf IS NULL AND prioridade IS NULL AND status IS NULL;



-- Adicionando constraint not null

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

--Questão 5
ALTER TABLE tarefas ADD CONSTRAINT id_unico UNIQUE(id);
INSERT INTO tarefas VALUES(2147483653, 'limpar portas do 1o andar', '32323232911', 2 , 'A');
--Não deve funcionar:
INSERT INTO tarefas VALUES(2147483653, 'aparar a grama da área frontal', '32323232911', 3 , 'A');


--Questão 6
-- A)
ALTER TABLE tarefas ADD CONSTRAINT tamanho_valido CHECK (LENGTH(func_resp_cpf) = 11);
--Testes:
INSERT INTO tarefas VALUES(2147483640, 'aparar a grama da área frontal', '323232329110', 3 , 'A'); -- erro
INSERT INTO tarefas VALUES(1234567890, 'aparar a grama da área frontal', '12345678900', 3 , 'A'); -- certo
DELETE FROM tarefas WHERE id=1234567890;

-- B)
UPDATE tarefas SET status='P' WHERE status='A';
UPDATE tarefas SET status='E' WHERE status='R';
UPDATE tarefas SET status='C' WHERE status='F';

ALTER TABLE tarefas ADD CONSTRAINT status_validos CHECK (status = 'P' OR status = 'E' OR status = 'C');
--Testes:
INSERT INTO tarefas VALUES(1234567890, 'aparar a grama da área frontal', '12345678900', 3 , 'G'); -- erro
INSERT INTO tarefas VALUES(1234567811, 'aparar a grama da área frontal', '12345678900', 3 , 'p'); -- certo
DELETE FROM tarefas WHERE id=1234567811;

--Questão 7
ALTER TABLE tarefas ADD CONSTRAINT niveis_de_prioridade_permitidos CHECK (prioridade >= 0 AND prioridade <= 5);
--Teste
INSERT INTO tarefas VALUES(1234567891, 'alguma coisa', '12345678900', 6, 'A'); -- erro
INSERT INTO tarefas VALUES(1234567891, 'alguma coisa', '12345678900', 5, 'A'); -- certo
DELETE FROM tarefas WHERE descricao='alguma coisa';

--Questão 8

CREATE TABLE funcionario(
	cpf CHAR(11),
	data_nasc DATE NOT NULL,
	nome VARCHAR(50) NOT NULL,
	funcao VARCHAR(11) NOT NULL,
	nivel CHAR(1) NOT NULL CONSTRAINT niveis_permitidos CHECK (nivel = 'J' OR nivel = 'P' OR nivel = 'S'),
	superior_cpf CHAR(11),
	PRIMARY KEY(cpf),
	FOREIGN KEY(superior_cpf) REFERENCES funcionario(cpf)
);

-- devem funcionar:
INSERT INTO funcionario VALUES('12345678911', '1980-05-07','Pedro da Silva', 'SUP_LIMPEZA','S', null);
INSERT INTO funcionario VALUES('12345678912','1980-03-08','Jose da Silva', 'LIMPEZA','J','12345678911');

ALTER TABLE funcionario ADD CONSTRAINT funcoes_permitidas CHECK(funcao = 'LIMPEZA' OR funcao = 'SUP_LIMPEZA');


--Essa é a condição que diz que se o cara é LIMPEZA, então tem que ter cpf do superior, se for SUP_LIMPEZA, nao tem cpf do superior 
ALTER TABLE funcionario ADD CONSTRAINT funcionario_comum_tem_superior CHECK ( (funcao='LIMPEZA' AND superior_cpf is NOT NULL ) OR (funcao='SUP_LIMPEZA' AND superior_cpf is  NULL) );


-- não deve funcionar:

INSERT INTO funcionario VALUES('12345678913', '1980-04-09', 'joao da silva', 'LIMPEZA', 'J', null);

-- Questão 9
-- Casos que devem ser cadastrados
INSERT INTO funcionario VALUES('12345678919', '1969-11-20', 'Severino Braga de Morais', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario VALUES('12345678920', '1970-05-07', 'Rodolfo Costa de Albuquerque', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES('12345678922', '1980-05-17', 'Ricardo Santana de Azevedo', 'SUP_LIMPEZA','S',  null);
INSERT INTO funcionario VALUES('12345678916', '1990-01-02', 'Marcelo Morais Magalhães', 'SUP_LIMPEZA', 'J', null);
INSERT INTO funcionario VALUES('12345678917', '1989-06-09', 'Marcus Vinicius da Costa', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario VALUES('12345678914', '1956-04-07', 'Maria Jose do nascimento', 'LIMPEZA','S', '12345678919');
INSERT INTO funcionario VALUES('12345678915', '1978-03-20', 'Francisco Pereira da Silva', 'LIMPEZA', 'S', '12345678922');
INSERT INTO funcionario VALUES('12345678913', '1980-05-07', 'Mariano Carvalho', 'LIMPEZA', 'P', '12345678920');
INSERT INTO funcionario VALUES('12345678918', '1965-12-11', 'Josefa Stefanini Diniz', 'LIMPEZA', 'P', '12345678916');
INSERT INTO funcionario VALUES('12345678921', '1982-02-12', 'Maria de Fátima Soares', 'LIMPEZA', 'P', '12345678917');
INSERT INTO funcionario VALUES('12345678923', '1987-09-23', 'Guilherme Arruda Vilela Filho', 'LIMPEZA', 'J', '12345678920');



-- Casos em que não deve funcionar:

-- funcionario normal com superior que nao está cadastrado ou está como null)
INSERT INTO funcionario VALUES('12345678924', '1985-01-20', 'Mr. Moustachio', 'LIMPEZA', 'S', '33322211198');
INSERT INTO funcionario VALUES('12345678925', '1986-02-21', 'O revoltado', 'LIMPEZA', 'P', null);
-- cpf null 
INSERT INTO funcionario VALUES(null , '1987-03-22', 'Jack Black', 'SUP_LIMPEZA', 'S', '12345678916');
-- Funcao diferente das 2 permitidas
INSERT INTO funcionario VALUES('12345678927', '1988-04-23', 'O Penetra', 'Advogado', 'J', '12345678916');
--nivel diferente dos 3 permitidos
INSERT INTO funcionario VALUES('12345678928', '1989-05-24', 'Novo demais', 'LIMPEZA', 'B', '12345678919');
-- Superior com cpf de superior válido
INSERT INTO funcionario VALUES('12345678929', '1980-06-25', 'Falta de confiança', 'SUP_LIMPEZA', 'S', '12345678920');
-- Superior com cpf de superior inválido
INSERT INTO funcionario VALUES('12345678931', '1982-08-27', 'Falta de confiança 2', 'SUP_LIMPEZA', 'S', '33322211198');
-- nome null
INSERT INTO funcionario VALUES('12345678930', '1981-07-26', null, 'LIMPEZA', 'P', '12345678920');
-- nasc null
INSERT INTO funcionario VALUES('12345678932', null, 'Viajante do Tempo', 'SUP_LIMPEZA', 'J', null);
-- superior com referencia para superior como sendo funcionario normal
INSERT INTO funcionario VALUES('12345678934', '1985-11-30', 'Rigby', 'SUP_LIMPEZA', 'J', '12345678916');





--passou:
-- funcionario normal com superior sendo outro funcionario normal
INSERT INTO funcionario VALUES('12345678933', '1984-10-29', 'Mordecai', 'LIMPEZA', 'J', '12345678916');

-- Questão 10

INSERT INTO funcionario VALUES('32323232955', '1984-10-29', 'Joaquim da Silva', 'LIMPEZA', 'J', '12345678917');
INSERT INTO funcionario VALUES('32323232911', '1984-10-29', 'Moacir da Silva', 'LIMPEZA', 'J', '12345678917');
INSERT INTO funcionario VALUES('98765432111', '1984-10-29', 'Ronaldo da Silva', 'LIMPEZA', 'J', '12345678917');
INSERT INTO funcionario VALUES('98765432122', '1984-10-29', 'Joaldo da Silva', 'LIMPEZA', 'J', '12345678917');


-- ON DELETE CASCADE
ALTER TABLE tarefas ADD CONSTRAINT cpf_tarefas_funcionarios FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;
DELETE FROM funcionario WHERE cpf = '32323232911';
ALTER TABLE tarefas DROP CONSTRAINT cpf_tarefas_funcionarios;

-- ON DELETE RESTRICT
ALTER TABLE tarefas ADD CONSTRAINT cpf_tarefas_funcionarios FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE RESTRICT;

DELETE FROM funcionario WHERE cpf = '98765432111';



-- Questão 11
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf DROP NOT NULL;
ALTER TABLE tarefas ADD CONSTRAINT concluido_nao_tem_cpf CHECK ((status='E' AND func_resp_cpf IS NOT null) or (status= 'P' or status = 'C'));  

ALTER TABLE tarefas DROP CONSTRAINT cpf_tarefas_funcionarios;
ALTER TABLE tarefas ADD CONSTRAINT cpf_tarefas_funcionarios FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE SET NULL;

INSERT INTO tarefas VALUES('1112223330', 'limpar banheiros', '12345678915', '3', 'E' );
DELETE FROM funcionario WHERE cpf ='12345678915';





