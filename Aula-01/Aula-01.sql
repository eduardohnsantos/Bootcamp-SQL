/*Vamos agora para um guia introdutório para operações básicas de SQL utilizando o banco de dados Northwind. Cada comando SQL será explicado com uma breve introdução para ajudar no entendimento 
e aplicação prática.

Exemplo de Seleção Completa
Para selecionar todos os dados de uma tabela:*/

-- Exibe todos os registros da tabela Customers
SELECT * FROM customers;


-- Exibe o nome de contato e a cidade dos clientes
SELECT contact_name, city FROM customers;
Utilizando DISTINCT

-- Lista todos os países dos clientes
SELECT country FROM customers;

-- Lista os países sem repetição
SELECT DISTINCT country FROM customers;

-- Conta quantos países únicos existem
SELECT COUNT(DISTINCT country) FROM customers;
Cláusula WHERE


-- Seleciona todos os clientes do México
SELECT * FROM customers WHERE country='Mexico';

-- Seleciona clientes com ID específico
SELECT * FROM customers WHERE customer_id='ANATR';

-- Utiliza AND para múltiplos critérios
SELECT * FROM customers WHERE country='Germany' AND city='Berlin';

-- Utiliza OR para mais de uma cidade
SELECT * FROM customers WHERE city='Berlin' OR city='Aachen';

-- Utiliza NOT para excluir a Alemanha
SELECT * FROM customers WHERE country<>'Germany';

-- Combina AND, OR e NOT
SELECT * FROM customers WHERE country='Germany' AND (city='Berlin' OR city='Aachen');

-- Exclui clientes da Alemanha e EUA
SELECT * FROM customers WHERE country<>'Germany' AND country<>'USA';
ORDER BY


-- Ordena clientes pelo país
SELECT * FROM customers ORDER BY country;

-- Ordena por país em ordem descendente
SELECT * FROM customers ORDER BY country DESC;

-- Ordena por país e nome do contato
SELECT * FROM customers ORDER BY country, contact_name;

-- Ordena por país em ordem ascendente e nome em ordem descendente
SELECT * FROM customers ORDER BY country ASC, contact_name DESC;
Utilizando LIKE e IN


-- Clientes com nome de contato começando por "a"
SELECT * FROM customers WHERE contact_name LIKE 'a%';

-- Clientes com nome de contato não começando por "a"
SELECT * FROM customers WHERE contact_name NOT LIKE 'a%';

-- Clientes de países específicos
SELECT * FROM customers WHERE country IN ('Germany', 'France', 'UK');

-- Clientes não localizados em 'Germany', 'France', 'UK'
SELECT * FROM customers WHERE country NOT IN ('Germany', 'France', 'UK');