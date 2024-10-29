CREATE TABLE CLIENTES (
    codigo SERIAL PRIMARY KEY,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(255) NOT NULL,
    ramo_atividade VARCHAR(255),
    data_cadastramento DATE NOT NULL,
    pessoa_contato VARCHAR(255)
);

CREATE TABLE TELEFONES_CLIENTES (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTES(codigo) ON DELETE CASCADE
);

CREATE TABLE ENDERECOS_CLIENTES (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    numero VARCHAR(10),
    logradouro VARCHAR(255) NOT NULL,
    complemento VARCHAR(255),
    cep VARCHAR(10),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    tipo_endereco_id INT,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTES(codigo) ON DELETE CASCADE,
    FOREIGN KEY (tipo_endereco_id) REFERENCES TIPO_DE_ENDERECO(codigo)
);

CREATE TABLE EMPREGADOS (
    matricula SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(100),
    salario DECIMAL(10, 2),
    data_admissao DATE NOT NULL,
    qualificacoes VARCHAR(255)
);

CREATE TABLE TELEFONES_EMPREGADOS (
    id SERIAL PRIMARY KEY,
    empregado_id INT NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    FOREIGN KEY (empregado_id) REFERENCES EMPREGADOS(matricula) ON DELETE CASCADE
);

CREATE TABLE EMPRESAS (
    cnpj VARCHAR(14) PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    pessoa_contato VARCHAR(255)
);

CREATE TABLE TELEFONES_EMPRESAS (
    id SERIAL PRIMARY KEY,
    empresa_cnpj VARCHAR(14) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    FOREIGN KEY (empresa_cnpj) REFERENCES EMPRESAS(cnpj) ON DELETE CASCADE
);

CREATE TABLE FORNECEDORES (
    cnpj VARCHAR(14) PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL
);

CREATE TABLE TELEFONES_FORNECEDORES (
    id SERIAL PRIMARY KEY,
    fornecedor_cnpj VARCHAR(14) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    FOREIGN KEY (fornecedor_cnpj) REFERENCES FORNECEDORES(cnpj) ON DELETE CASCADE
);

CREATE TABLE TIPO_DE_ENDERECO (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE ENCOMENDAS (
    numero SERIAL PRIMARY KEY,
    data_inclusao DATE NOT NULL,
    valor_total DECIMAL(10, 2),
    valor_desconto DECIMAL(10, 2),
    valor_liquido DECIMAL(10, 2),
    forma_pagamento_id INT,
    quantidade_parcelas INT,
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTES(codigo) ON DELETE CASCADE
);

CREATE TABLE PRODUTOS (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cor VARCHAR(50),
    dimensoes VARCHAR(100),
    peso DECIMAL(10, 2),
    preco DECIMAL(10, 2),
    tempo_fabricacao INT,
    desenho_produto TEXT,
    horas_mao_obra INT
);

CREATE TABLE TIPOS_DE_COMPONENTE (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE COMPONENTES (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    quantidade_em_estoque INT,
    preco_unitario DECIMAL(10, 2),
    unidade VARCHAR(50),
    tipo_componente_id INT,
    FOREIGN KEY (tipo_componente_id) REFERENCES TIPOS_DE_COMPONENTE(codigo)
);

CREATE TABLE MAQUINAS (
    id SERIAL PRIMARY KEY,
    tempo_de_vida INT,
    data_da_compra DATE,
    data_fim_garantia DATE
);

CREATE TABLE RECURSOS_ESPECIFICOS (
    id SERIAL PRIMARY KEY,
    quantidade_necessaria INT,
    unidade VARCHAR(50),
    tempo_uso INT,
    horas_mao_obra INT,
    produto_id INT,
    FOREIGN KEY (produto_id) REFERENCES PRODUTOS(codigo)
);

CREATE TABLE REGISTRO_MANUTENCAO (
    id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    descricao TEXT,
    maquina_id INT,
    FOREIGN KEY (maquina_id) REFERENCES MAQUINAS(id)
);

CREATE TABLE REGISTRO_SUPRIMENTOS (
    id SERIAL PRIMARY KEY,
    quantidade INT,
    data_necessidade DATE,
    componente_id INT,
    FOREIGN KEY (componente_id) REFERENCES COMPONENTES(codigo)
);
