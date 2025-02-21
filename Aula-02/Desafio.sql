--Desafio

-- Obter todas as colunas das tabelas Clientes, Pedidos e Fornecedores
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM suppliers;

-- Obter todos os Clientes em ordem alfabética por país e nome
SELECT *
FROM customers
ORDER BY country, contact_name;

-- Obter os 5 pedidos mais antigos
SELECT * 
FROM orders 
ORDER BY order_date
LIMIT 5;

-- Obter a contagem de todos os Pedidos feitos durante 1997
SELECT COUNT(*) AS "Number of Orders During 1997"
FROM orders
WHERE order_date BETWEEN '1997-1-1' AND '1997-12-31';

-- Obter os nomes de todas as pessoas de contato onde a pessoa é um gerente, em ordem alfabética
SELECT contact_name
FROM customers
WHERE contact_title LIKE '%Manager%'
ORDER BY contact_name;

-- Obter todos os pedidos feitos em 19 de maio de 1997
SELECT *
FROM orders
WHERE order_date = '1997-05-19';
