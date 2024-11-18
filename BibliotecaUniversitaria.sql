
-- Criação do Banco de Dados para a Biblioteca Universitária
CREATE DATABASE BibliotecaUniversitaria;
USE BibliotecaUniversitaria;

-- Tabelas para Cadastro de Usuários, Livros, Categorias, Empréstimos e Reservas
CREATE TABLE Usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    tipo ENUM('Aluno', 'Professor', 'Funcionario'),
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);

CREATE TABLE Categoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50)
);

CREATE TABLE Livro (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255),
    autor VARCHAR(100),
    ISBN VARCHAR(20),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(id)
);

CREATE TABLE Emprestimo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_emprestimo DATE,
    data_devolucao DATE,
    multa FLOAT,
    usuario_id INT,
    livro_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(id),
    FOREIGN KEY (livro_id) REFERENCES Livro(id)
);

CREATE TABLE Reserva (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_reserva DATE,
    livro_id INT,
    usuario_id INT,
    FOREIGN KEY (livro_id) REFERENCES Livro(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(id)
);

-- Inserção de dados iniciais
INSERT INTO Usuario (nome, tipo, endereco, telefone) VALUES
('João Silva', 'Aluno', 'Rua A, 123', '123456789'),
('Maria Oliveira', 'Professor', 'Rua B, 456', '987654321'),
('Ana Santos', 'Funcionario', 'Rua C, 789', '456123789');

INSERT INTO Categoria (nome) VALUES
('Ficção'),
('Ciência'),
('História');

INSERT INTO Livro (titulo, autor, ISBN, categoria_id) VALUES
('Dom Casmurro', 'Machado de Assis', '978-8525406572', 1),
('Breve História do Tempo', 'Stephen Hawking', '978-8571100079', 2),
('A Arte da Guerra', 'Sun Tzu', '978-8537801525', 3);

INSERT INTO Emprestimo (data_emprestimo, data_devolucao, multa, usuario_id, livro_id) VALUES
('2024-11-01', '2024-11-15', 0.0, 1, 1),
('2024-11-05', '2024-11-20', 5.0, 2, 2);

INSERT INTO Reserva (data_reserva, livro_id, usuario_id) VALUES
('2024-11-05', 1, 3);

-- Consultas avançadas

-- Consultar todos os livros e suas categorias
SELECT Livro.titulo, Categoria.nome 
FROM Livro 
JOIN Categoria ON Livro.categoria_id = Categoria.id;

-- Consultar empréstimos de um usuário específico
SELECT Emprestimo.id, Livro.titulo, Emprestimo.data_emprestimo, Emprestimo.data_devolucao 
FROM Emprestimo
JOIN Livro ON Emprestimo.livro_id = Livro.id
WHERE Emprestimo.usuario_id = 1;

-- Consultar usuários com reservas ativas
SELECT Usuario.nome, Livro.titulo, Reserva.data_reserva
FROM Reserva
JOIN Usuario ON Reserva.usuario_id = Usuario.id
JOIN Livro ON Reserva.livro_id = Livro.id;

-- Consultar multa acumulada por usuário
SELECT Usuario.nome, SUM(Emprestimo.multa) AS total_multa
FROM Emprestimo
JOIN Usuario ON Emprestimo.usuario_id = Usuario.id
GROUP BY Usuario.id;
