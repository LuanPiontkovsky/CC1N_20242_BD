-- Criação da tabela Alunos
CREATE TABLE Alunos (
    ID_Aluno INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Endereço VARCHAR(255) NOT NULL,
    Telefone VARCHAR(15)
);

-- Criação da tabela Instrutores
CREATE TABLE Instrutores (
    ID_Instrutor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL
);

-- Criação da tabela Modalidades
CREATE TABLE Modalidades (
    ID_Modalidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descrição TEXT
);

-- Criação da tabela Planos de Treinamento
CREATE TABLE Planos_Treinamento (
    ID_Plano INT AUTO_INCREMENT PRIMARY KEY,
    ID_Aluno INT NOT NULL,
    ID_Instrutor INT NOT NULL,
    Descrição TEXT,
    Data_Criação DATE NOT NULL,
    Data_Atualização DATE,
    FOREIGN KEY (ID_Aluno) REFERENCES Alunos(ID_Aluno) ON DELETE CASCADE,
    FOREIGN KEY (ID_Instrutor) REFERENCES Instrutores(ID_Instrutor) ON DELETE CASCADE
);

-- Criação da tabela Aulas
CREATE TABLE Aulas (
    ID_Aula INT AUTO_INCREMENT PRIMARY KEY,
    ID_Modalidade INT NOT NULL,
    ID_Instrutor INT NOT NULL,
    Horário TIME NOT NULL,
    Capacidade INT NOT NULL,
    Data DATE NOT NULL,
    FOREIGN KEY (ID_Modalidade) REFERENCES Modalidades(ID_Modalidade) ON DELETE CASCADE,
    FOREIGN KEY (ID_Instrutor) REFERENCES Instrutores(ID_Instrutor) ON DELETE CASCADE
);

-- Criação da tabela Pagamentos
CREATE TABLE Pagamentos (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Aluno INT NOT NULL,
    Data_Pagamento DATE NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Status ENUM('pago', 'pendente') NOT NULL,
    FOREIGN KEY (ID_Aluno) REFERENCES Alunos(ID_Aluno) ON DELETE CASCADE
);

-- Tabela de relacionamento entre Alunos e Modalidades (para a relação muitos-para-muitos)
CREATE TABLE Alunos_Modalidades (
    ID_Aluno INT NOT NULL,
    ID_Modalidade INT NOT NULL,
    PRIMARY KEY (ID_Aluno, ID_Modalidade),
    FOREIGN KEY (ID_Aluno) REFERENCES Alunos(ID_Aluno) ON DELETE CASCADE,
    FOREIGN KEY (ID_Modalidade) REFERENCES Modalidades(ID_Modalidade) ON DELETE CASCADE
);
