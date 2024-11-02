CREATE SCHEMA EST_CASO_IV;
USE ESTC_IV; 

CREATE TABLE IF NOT EXISTS ALUNOS (
    ALUNO_ID INT PRIMARY KEY,
    ALUNO_CPF VARCHAR(14) NOT NULL,
    ALUNO_NOME VARCHAR(100) NOT NULL,
    ALUNO_DATANASC DATE NOT NULL,
    ALUNO_RUA VARCHAR(100) NOT NULL,
    ALUNO_NUM INT,
    ALUNO_COMPLEMENTO TEXT,
    ALUNO_BAIRRO VARCHAR(100) NOT NULL,
    ALUNO_CIDADE VARCHAR(100) NOT NULL,
    ALUNO_CEP VARCHAR(15) NOT NULL,
    ALUNO_UF CHAR(2) NOT NULL,
    ALUNO_PAIS VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS INSTRUTORES (
    INSTRU_ID INT PRIMARY KEY,
    INSTRU_CPF VARCHAR(14) NOT NULL,
    INSTRU_NOME VARCHAR(100) NOT NULL,
    INSTRU_DATANASC DATE NOT NULL,
    INSTRU_RUA VARCHAR(100) NOT NULL,
    INSTRU_NUM INT,
    INSTRU_COMPLEMENTO TEXT,
    INSTRU_BAIRRO VARCHAR(100) NOT NULL,
    INSTRU_CIDADE VARCHAR(100) NOT NULL,
    INSTRU_CEP VARCHAR(15) NOT NULL,
    INSTRU_UF CHAR(2) NOT NULL,
    INSTRU_PAIS VARCHAR(100) NOT NULL,
    INSTRU_ESPECIALIDADE VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS MODALIDADES (
    MOD_ID INT PRIMARY KEY,
    MOD_NOME VARCHAR(100) NOT NULL,
    MOD_DESCRICAO TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS PLANOS_TREINAMENTOS (
    PLAN_ID INT PRIMARY KEY,
    ALUNO_ID INT NOT NULL,
    INSTRU_ID INT NOT NULL,
    PLAN_DESCRICAO TEXT NOT NULL,
    PLAN_DATAINICIO DATE NOT NULL,
    PLAN_DATAFIM DATE,
    CONSTRAINT PLTR_FK_ALUNO FOREIGN KEY(ALUNO_ID) REFERENCES ALUNOS(ALUNO_ID),
    CONSTRAINT PLTR_FK_INSTRUTOR FOREIGN KEY(INSTRU_ID) REFERENCES INSTRUTORES(INSTRU_ID)
);

CREATE TABLE IF NOT EXISTS AULAS (
    AULA_ID INT PRIMARY KEY,
    MOD_ID INT NOT NULL,
    INSTRU_ID INT NOT NULL,
    AULA_HORARIO TIME NOT NULL,
    AULA_CAPACIDADE INT NOT NULL,
    CONSTRAINT AULAS_FK_MODALIDADES FOREIGN KEY (MOD_ID) REFERENCES MODALIDADES(MOD_ID),
    CONSTRAINT AULAS_FK_INSTRUTORES FOREIGN KEY (INSTRU_ID) REFERENCES INSTRUTORES(INSTRU_ID)
);


CREATE TABLE IF NOT EXISTS MATRICULAS (
    MATRICULA_ID INT PRIMARY KEY,
    ALUNO_ID INT NOT NULL,
    MOD_ID INT NOT NULL,
    MATRICULA_DATA DATE NOT NULL,
    MATRICULA_STATUS ENUM("MATRICULADO", "NAO MATRICULADO"),
    CONSTRAINT MATRICULA_FK_ALUNOS FOREIGN KEY (ALUNO_ID) REFERENCES ALUNOS(ALUNO_ID),
    CONSTRAINT MATRICULA_FK_MODALIDADES FOREIGN KEY (MOD_ID) REFERENCES MODALIDADES(MOD_ID)

);

CREATE TABLE IF NOT EXISTS PAGAMENTOS (
    PAG_ID INT PRIMARY KEY,
    PAG_DATA DATE NOT NULL,
    PAG_VALOR DECIMAL(10, 3) NOT NULL,
    PAG_STATUS ENUM("PAGO", "PENDENTE"),
	MATRICULA_ID INT,
    CONSTRAINT PAG_FK_MATRICULAS FOREIGN KEY(MATRICULA_ID) REFERENCES MATRICULAS(MATRICULA_ID)
);

CREATE TABLE IF NOT EXISTS ALUNOS_AULAS (
    AULA_ID INT,
    ALUNO_ID INT,
    PRIMARY KEY(AULA_ID, ALUNO_ID),
    CONSTRAINT ALAU_FK_AULAS FOREIGN KEY(AULA_ID) REFERENCES AULAS(AULA_ID),
    CONSTRAINT ALAU_FK_ALUNOS FOREIGN KEY(ALUNO_ID) REFERENCES ALUNOS(ALUNO_ID) 
);

-- TABELA ALUNOS
INSERT INTO ALUNOS (ALUNO_ID, ALUNO_CPF, ALUNO_NOME, ALUNO_DATANASC, ALUNO_RUA, ALUNO_NUM, ALUNO_COMPLEMENTO, ALUNO_BAIRRO, ALUNO_CIDADE, ALUNO_CEP, ALUNO_UF, ALUNO_PAIS) VALUES (1, '123.456.789-00', 'João Silva', '2000-01-15', 'Rua A', 10, 'Apto 1', 'Centro', 'São Paulo', '01000-000', 'SP', 'Brasil'), (2, '987.654.321-00', 'Maria Oliveira', '1998-05-22', 'Rua B', 20, NULL, 'Jardim', 'Rio de Janeiro', '20000-000', 'RJ', 'Brasil');
UPDATE ALUNOS SET ALUNO_NOME = 'João da Silva', ALUNO_CIDADE = 'São Paulo' WHERE ALUNO_ID = 1;

-- TABELA INSTRUTORES
INSERT INTO INSTRUTORES (INSTRU_ID, INSTRU_CPF, INSTRU_NOME, INSTRU_DATANASC, INSTRU_RUA, INSTRU_NUM, INSTRU_COMPLEMENTO, INSTRU_BAIRRO, INSTRU_CIDADE, INSTRU_CEP, INSTRU_UF, INSTRU_PAIS, INSTRU_ESPECIALIDADE) VALUES (1, '321.654.987-00', 'Carlos Mendes', '1985-03-30', 'Rua C', 15, NULL, 'Bela Vista', 'Belo Horizonte', '30000-000', 'MG', 'Brasil', 'Fisiologia'), (2, '654.321.098-00', 'Ana Costa', '1990-12-01', 'Rua D', 25, 'Sala 5', 'Leblon', 'Rio de Janeiro', '20000-001', 'RJ', 'Brasil', 'Nutrição');
UPDATE INSTRUTORES SET INSTRU_NOME = 'Carlos Alberto Mendes', INSTRU_CIDADE = 'Belo Horizonte' WHERE INSTRU_ID = 1;

-- TABELA MODALIDADES
INSERT INTO MODALIDADES (MOD_ID, MOD_NOME, MOD_DESCRICAO) VALUES (1, 'Musculação', 'Treinamento de força e resistência.'), (2, 'Yoga', 'Prática para o equilíbrio físico e mental.');
UPDATE MODALIDADES SET MOD_NOME = 'Musculação Avançada' WHERE MOD_ID = 1;

-- TABELA PLANOS_TREINAMENTOS
INSERT INTO PLANOS_TREINAMENTOS (PLAN_ID, ALUNO_ID, INSTRU_ID, PLAN_DESCRICAO, PLAN_DATAINICIO, PLAN_DATAFIM) VALUES (1, 1, 1, 'Plano de Musculação básico.', '2024-01-01', '2024-06-30'), (2, 2, 2, 'Plano de Yoga intermediário.', '2024-01-15', NULL);
UPDATE PLANOS_TREINAMENTOS SET PLAN_DESCRICAO = 'Plano de Musculação intensivo.' WHERE PLAN_ID = 1;

-- TABELA AULAS
INSERT INTO AULAS (AULA_ID, MOD_ID, INSTRU_ID, AULA_HORARIO, AULA_CAPACIDADE) VALUES (1, 1, 1, '08:00:00', 20), (2, 2, 2, '10:00:00', 15);
UPDATE AULAS SET AULA_HORARIO = '09:00:00', AULA_CAPACIDADE = 25 WHERE AULA_ID = 1;

-- TABELA MATRICULAS
INSERT INTO MATRICULAS (MATRICULA_ID, ALUNO_ID, MOD_ID, MATRICULA_DATA, MATRICULA_STATUS) VALUES (1, 1, 1, '2024-01-01', 'MATRICULADO'), (2, 2, 2, '2024-01-15', 'MATRICULADO');
UPDATE MATRICULAS SET MATRICULA_STATUS = 'NAO MATRICULADO' WHERE MATRICULA_ID = 1;

-- TABELA PAGAMENTOS
INSERT INTO PAGAMENTOS (PAG_ID, PAG_DATA, PAG_VALOR, PAG_STATUS, MATRICULA_ID) VALUES (1, '2024-01-05', 150.00, 'PAGO', 1), (2, '2024-01-20', 120.00, 'PAGO', 2);
UPDATE PAGAMENTOS SET PAG_VALOR = 160.00, PAG_STATUS = 'PENDENTE' WHERE PAG_ID = 1;

-- TABELA ALUNOS_AULAS
INSERT INTO ALUNOS_AULAS (AULA_ID, ALUNO_ID) VALUES (1, 1), (2, 2);
UPDATE ALUNOS_AULAS SET ALUNO_ID = 2 WHERE AULA_ID = 1 AND ALUNO_ID = 1;
