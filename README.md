# Sistema de Biblioteca Universitária

Este projeto é um sistema de gerenciamento para uma biblioteca universitária, desenvolvido para atender às necessidades de cadastro, empréstimos, devoluções, reservas de livros e controle de multas. O objetivo é modernizar o sistema de empréstimos, facilitando o acesso a informações e a gestão das operações da biblioteca.

---

## Conteúdo do Repositório

- **BibliotecaUniversitaria.sql**: Script SQL contendo a criação do banco de dados, inserção de dados (DDL e DML) e consultas avançadas (DQL).
- **Diagrama Relacional**: Diagrama relacional das tabelas e seus relacionamentos.

---

## Estrutura do Sistema

### Entidades e Atributos

#### **Usuarios**
- `id_usuario (PK)`: Identificador único do usuário.
- `nome`: Nome completo do usuário.
- `tipo_usuario`: Tipo de usuário (`Aluno`, `Professor`, `Funcionario`).
- `telefone`: Contato telefônico do usuário.
- `email`: Endereço de email do usuário.

#### **Livros**
- `id_livro (PK)`: Identificador único do livro.
- `titulo`: Título do livro.
- `autor`: Nome do autor do livro.
- `isbn`: Número ISBN do livro.
- `categoria`: Categoria do livro (`Ficcao`, `Ciencia`, `Historia`, `Outros`).

#### **Emprestimos**
- `id_emprestimo (PK)`: Identificador único do empréstimo.
- `id_usuario (FK)`: Relacionado ao usuário que realizou o empréstimo.
- `id_livro (FK)`: Relacionado ao livro emprestado.
- `data_emprestimo`: Data do empréstimo.
- `data_devolucao`: Data prevista para devolução.
- `multa`: Valor da multa, caso aplicável.

#### **Reservas**
- `id_reserva (PK)`: Identificador único da reserva.
- `id_usuario (FK)`: Relacionado ao usuário que realizou a reserva.
- `id_livro (FK)`: Relacionado ao livro reservado.
- `data_reserva`: Data em que a reserva foi realizada.
- `status_reserva`: Status da reserva (`Ativa`, `Finalizada`).

---

## Funcionalidades Implementadas

- **Cadastro**:
  - Cadastro de usuários com tipos diferenciados.
  - Cadastro de livros com categorias específicas.
- **Gestão de Empréstimos**:
  - Registro de empréstimos com datas e controle de devoluções.
  - Cálculo de multas baseado na data de devolução.
- **Gestão de Reservas**:
  - Registro de reservas com status e vínculo ao usuário e livro.
- **Relatórios**:
  - Livros mais emprestados.
  - Reservas ativas por usuário.
  - Controle de multas por usuário.

---

## Diagrama Relacional

![image](https://github.com/user-attachments/assets/20d3c114-2243-4ae0-8546-44e12a9305aa)


---

## Consultas Avançadas (DQL)

### Livros mais emprestados
```sql
SELECT Livros.titulo, COUNT(Emprestimos.id_emprestimo) AS emprestimos
FROM Livros
LEFT JOIN Emprestimos ON Livros.id_livro = Emprestimos.id_livro
GROUP BY Livros.id_livro
ORDER BY emprestimos DESC;
```

---

### Reservas ativas por usuário
```sql

SELECT Usuarios.nome, COUNT(Reservas.id_reserva) AS reservas_ativas
FROM Usuarios
INNER JOIN Reservas ON Usuarios.id_usuario = Reservas.id_usuario
WHERE Reservas.status_reserva = 'Ativa'
GROUP BY Usuarios.id_usuario;
```
---

### Controle de multas por usuário
```sql

SELECT Usuarios.nome, SUM(Emprestimos.multa) AS total_multas
FROM Usuarios
INNER JOIN Emprestimos ON Usuarios.id_usuario = Emprestimos.id_usuario
GROUP BY Usuarios.id_usuario;
```
---

### Como Usar
Faça o download ou clone o repositório:

bash
Copiar código
git clone https://github.com/vhvaz/biblioteca-universitaria-sql.git
Importe o arquivo BibliotecaUniversitaria.sql no seu banco de dados MySQL ou MariaDB.

Utilize os exemplos de consultas ou crie suas próprias queries para explorar os dados.

---

### Decisões de Modelagem
Utilizei enum para categorizar tipos de usuários, categorias de livros e status de reservas, garantindo maior controle e padronização.
Chaves estrangeiras foram implementadas para assegurar integridade referencial entre tabelas.
Estrutura simples e funcional para facilitar o entendimento e escalabilidade.

Este projeto foi desenvolvido com o objetivo de fornecer uma solução prática e eficiente para o gerenciamento de bibliotecas universitárias. Todo o sistema foi pensado para atender às demandas mais comuns, permitindo futuras expansões e personalizações. Caso tenha dúvidas ou sugestões, não hesite em entrar em contato!
