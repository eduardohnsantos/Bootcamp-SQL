DROP TABLE pessoas

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE pessoas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(3),
    last_name VARCHAR(3)
);

CREATE TABLE pessoas (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(3),
    last_name VARCHAR(3)
);

/*Verificação de Índices Existente:

Este trecho de código verifica os índices existentes na tabela pessoas e exibe suas informações, como nome e definição.
Exemplo
*/

SELECT 
    tablename AS "Tabela",
    indexname AS "Índice",
    indexdef AS "Definição do Índice"
FROM 
    pg_indexes 
WHERE 
    tablename = 'pessoas'; -- Substitua 'pessoas' pelo nome da sua tabela

INSERT INTO pessoas (first_name, last_name)
SELECT 
    substring(md5(random()::text), 0, 3),
    substring(md5(random()::text), 0, 3)
FROM 
    generate_series(1, 1000000);	

-- SELECT id FROM pessoas WHERE id = 100000;
EXPLAIN ANALYZE SELECT id FROM pessoas WHERE id = 100000;
SELECT id FROM pessoas WHERE id = 100000;

-- Buscando e trazendo dados da tabela de maneira eficiente:
SELECT first_name FROM pessoas WHERE first_name = 'aa';

-- Buscando e trazendo dados da tabela da pior maneira possível:
SELECT first_name FROM pessoas WHERE first_name LIKE '%a%';

-- Criando nosso índice:
CREATE INDEX first_name_index ON pessoas(first_name);

-- Comparação após a criação do índice:
SELECT first_name FROM pessoas WHERE first_name = 'aa';

-- Comparando agora com o operador LIKE:
SELECT first_name FROM pessoas WHERE first_name LIKE '%aa%';








