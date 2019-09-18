--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19


--Comentários do Roteiro 2
-- Questão 3
-- Para impedir os comandos 3 mas ainda permitir os comandos 4 a solução encontrada foi mudar o domínio do atributo para smallint.

-- Questão 5
-- A solução encontrada foi adicionar uma constraint UNIQUE em id, a fim de não permitir IDs repetidos.

-- Questão 10
-- ON DELETE CASCADE
-- Deletar o funcionário da tabela funcionario fez com que a atividade que ele era responsável
-- também fosse deletada da tabela tarefas.

-- ON DELETE RESTRICT
-- Deletar o funcionario da tabela funcionario não foi permitido pois este ainda era referenciado 
-- na tabela tarefas.

-- Questão 11 
-- ON DELETE SET NULL
-- Não é possível deletar por causa do SET NULL, pois subtitui todos os valores da tupla por null. Pelo fato de cpf ser chave estrangeira na tabela tarefas, esta propriedade também a afeta. Porém, em tarefas, existe a constraint que impede o cpf do funcionario seja null se este estiver responsável por uma tarefa em status 'E'. O SET NULL e essa constraint entram em conflito e o funcionario nao é deletado. 


SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_superior_cpf_fkey;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT cpf_tarefas_funcionarios;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT id_unico;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(50) NOT NULL,
    funcao character varying(11) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT funcionario_comum_tem_superior CHECK (((((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL)))),
    CONSTRAINT funcoes_permitidas CHECK ((((funcao)::text = 'LIMPEZA'::text) OR ((funcao)::text = 'SUP_LIMPEZA'::text))),
    CONSTRAINT niveis_permitidos CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO mauricio;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.tarefas (
    id numeric NOT NULL,
    descricao character varying(250) NOT NULL,
    func_resp_cpf character(11),
    prioridade smallint NOT NULL,
    status character varying(1) NOT NULL,
    CONSTRAINT concluido_nao_tem_cpf CHECK (((((status)::text = 'E'::text) AND (func_resp_cpf IS NOT NULL)) OR (((status)::text = 'P'::text) OR ((status)::text = 'C'::text)))),
    CONSTRAINT niveis_de_prioridade_permitidos CHECK (((prioridade >= 0) AND (prioridade <= 5))),
    CONSTRAINT status_validos CHECK ((((status)::text = 'A'::text) OR ((status)::text = 'R'::text) OR ((status)::text = 'F'::text) OR ((status)::text = 'P'::text) OR ((status)::text = 'E'::text) OR ((status)::text = 'C'::text))),
    CONSTRAINT tamanho_valido CHECK ((length(func_resp_cpf) = 11))
);


ALTER TABLE public.tarefas OWNER TO mauricio;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: mauricio
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1969-11-20', 'Severino Braga de Morais', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1970-05-07', 'Rodolfo Costa de Albuquerque', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1980-05-17', 'Ricardo Santana de Azevedo', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1990-01-02', 'Marcelo Morais Magalhães', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1989-06-09', 'Marcus Vinicius da Costa', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1956-04-07', 'Maria Jose do nascimento', 'LIMPEZA', 'S', '12345678919');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1978-03-20', 'Francisco Pereira da Silva', 'LIMPEZA', 'S', '12345678922');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-05-07', 'Mariano Carvalho', 'LIMPEZA', 'P', '12345678920');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1965-12-11', 'Josefa Stefanini Diniz', 'LIMPEZA', 'P', '12345678916');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1982-02-12', 'Maria de Fátima Soares', 'LIMPEZA', 'P', '12345678917');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1987-09-23', 'Guilherme Arruda Vilela Filho', 'LIMPEZA', 'J', '12345678920');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1984-10-29', 'Joaquim da Silva', 'LIMPEZA', 'J', '12345678917');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1984-10-29', 'Joaldo da Silva', 'LIMPEZA', 'J', '12345678917');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1984-10-29', 'Ronaldo da Silva', 'LIMPEZA', 'J', '12345678917');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: mauricio
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (1112223330, 'limpar banheiros', '12345678915', 3, 'E');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: id_unico; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT id_unico UNIQUE (id);


--
-- Name: cpf_tarefas_funcionarios; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT cpf_tarefas_funcionarios FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- Name: funcionario_superior_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_superior_cpf_fkey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

