
-- Criação do Banco de Dados para a Biblioteca Universitária
CREATE DATABASE BibliotecaUniversitaria;
USE BibliotecaUniversitaria;

-- Tabelas para Cadastro de Usuários, Livros, Empréstimos e Reservas
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    tipo_usuario ENUM('Aluno', 'Professor', 'Funcionario'),
    telefone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Livros (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200),
    autor VARCHAR(100),
    isbn VARCHAR(13),
    categoria ENUM('Ficcao', 'Ciencia', 'Historia', 'Outros')
);

CREATE TABLE Emprestimos (
    id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_livro INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    multa DECIMAL(5, 2) DEFAULT 0.00,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);

CREATE TABLE Reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_livro INT,
    data_reserva DATE,
    status_reserva ENUM('Ativa', 'Finalizada'),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);

-- Inserção de dados iniciais
INSERT INTO Usuarios (nome, tipo_usuario, telefone, email) VALUES
('Alice Martins', 'Aluno', '123456789', 'alice@example.com'),
('Carlos Silva', 'Professor', '987654321', 'carlos@example.com'),
('Mariana Souza', 'Funcionario', '456123789', 'mariana@example.com');

INSERT INTO Livros (titulo, autor, isbn, categoria) VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', '1234567890123', 'Ficcao'),
('Breve História do Tempo', 'Stephen Hawking', '9876543210987', 'Ciencia'),
('A Arte da Guerra', 'Sun Tzu', '4561237890123', 'Historia');

INSERT INTO Emprestimos (id_usuario, id_livro, data_emprestimo, data_devolucao, multa) VALUES
(1, 1, '2024-11-01', '2024-11-15', 0.00),
(2, 2, '2024-11-05', '2024-11-20', 0.00);

INSERT INTO Reservas (id_usuario, id_livro, data_reserva, status_reserva) VALUES
(3, 3, '2024-11-10', 'Ativa');

-- Consultas básicas
SELECT * FROM Usuarios;
SELECT * FROM Livros;
SELECT * FROM Emprestimos;
SELECT * FROM Reservas;

-- Consultas avançadas
-- Relatório de livros mais emprestados
SELECT Livros.titulo, COUNT(Emprestimos.id_emprestimo) AS emprestimos
FROM Livros
LEFT JOIN Emprestimos ON Livros.id_livro = Emprestimos.id_livro
GROUP BY Livros.id_livro
ORDER BY emprestimos DESC;

-- Relatório de reservas ativas por usuário
SELECT Usuarios.nome, COUNT(Reservas.id_reserva) AS reservas_ativas
FROM Usuarios
INNER JOIN Reservas ON Usuarios.id_usuario = Reservas.id_usuario
WHERE Reservas.status_reserva = 'Ativa'
GROUP BY Usuarios.id_usuario;

-- Controle de multas por usuário
SELECT Usuarios.nome, SUM(Emprestimos.multa) AS total_multas
FROM Usuarios
INNER JOIN Emprestimos ON Usuarios.id_usuario = Emprestimos.id_usuario
GROUP BY Usuarios.id_usuario;
