-- Cálcular: Quantos produtos únicos existem? Quantos produtos no total? Qual é o valor total pago?

SELECT order_id,
       COUNT(order_id) AS unique_product,
       SUM(quantity) AS total_quantity,
       SUM(unit_price * quantity) AS total_price
FROM order_details
GROUP BY order_id
ORDER BY order_id;

-- Com Windows Function
SELECT DISTINCT order_id,
   COUNT(order_id) OVER (PARTITION BY order_id) AS unique_product,
   SUM(quantity) OVER (PARTITION BY order_id) AS total_quantity,
   SUM(unit_price * quantity) OVER (PARTITION BY order_id) AS total_price
FROM order_details
ORDER BY order_id;

-- MIN (), MAX (), AVG ()
--Usando Group by
SELECT customer_id,
   MIN(freight) AS min_freight,
   MAX(freight) AS max_freight,
   AVG(freight) AS avg_freight
FROM orders
GROUP BY customer_id
ORDER BY customer_id;

-- Usando Windows Function
SELECT DISTINCT customer_id,
   MIN(freight) OVER (PARTITION BY customer_id) AS min_freight,
   MAX(freight) OVER (PARTITION BY customer_id) AS max_freight,
   AVG(freight) OVER (PARTITION BY customer_id) AS avg_freight
FROM orders
ORDER BY customer_id;

-- Colapso
/*Exemplo sem GROUP BY
Considere a seguinte consulta sem usar GROUP BY:*/

-- 830 linhas
SELECT customer_id, freight
FROM orders;

/*Exemplo com GROUP BY
Agora, vamos adicionar GROUP BY e funções de agregação:*/

-- 89 linhas
SELECT customer_id,
       MIN(freight) AS min_freight,
       MAX(freight) AS max_freight,
       AVG(freight) AS avg_freight
FROM orders
GROUP BY customer_id
ORDER BY customer_id;

-- RANK(), DENSE_RANK() e ROW_NUMBER()
-- RANK(): Atribui um rank único a cada linha, deixando lacunas em caso de empates.
-- DENSE_RANK(): Atribui um rank único a cada linha, com ranks contínuos para linhas empatadas.
-- ROW_NUMBER(): Atribui um número inteiro sequencial único a cada linha, independentemente de empates, sem lacunas.
SELECT  
  o.order_id, 
  p.product_name, 
  (o.unit_price * o.quantity) AS total_sale,
  ROW_NUMBER() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_rn, 
  RANK() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_rank, 
  DENSE_RANK() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_dense
FROM  
  order_details o
JOIN 
  products p ON p.product_id = o.product_id;

/*Este relatório apresenta o ID de cada pedido juntamente com o total de vendas e a classificação percentual e a distribuição cumulativa 
do valor de cada venda em relação ao valor total das vendas para o mesmo pedido. Esses cálculos são realizados com base no preço unitário e na quantidade de produtos vendidos em cada pedido.
Exemplo: Classificação dos produtos mais venvidos usnado SUB QUERY*/
SELECT  
  sales.product_name, 
  total_sale,
  ROW_NUMBER() OVER (ORDER BY total_sale DESC) AS order_rn, 
  RANK() OVER (ORDER BY total_sale DESC) AS order_rank, 
  DENSE_RANK() OVER (ORDER BY total_sale DESC) AS order_dense
FROM (
  SELECT 
    p.product_name, 
    SUM(o.unit_price * o.quantity) AS total_sale
  FROM  
    order_details o
  JOIN 
    products p ON p.product_id = o.product_id
  GROUP BY p.product_name
) AS sales
ORDER BY sales.product_name;  

-- Funções PERCENT_RANK() e CUME_DIST()
SELECT  
  order_id, 
  unit_price * quantity AS total_sale,
  ROUND(CAST(PERCENT_RANK() OVER (PARTITION BY order_id 
    ORDER BY (unit_price * quantity) DESC) AS numeric), 2) AS order_percent_rank,
  ROUND(CAST(CUME_DIST() OVER (PARTITION BY order_id 
    ORDER BY (unit_price * quantity) DESC) AS numeric), 2) AS order_cume_dist
FROM  
  order_details;

/*A função NTILE() no SQL é usada para dividir o conjunto de resultados em um número especificado de partes aproximadamente iguais ou "faixas" e 
atribuir um número de grupo ou "bucket" a cada linha com base em sua posição dentro do conjunto de resultados ordenado.

NTILE(n) OVER (ORDER BY coluna)
n: O número de faixas ou grupos que você deseja criar.
ORDER BY coluna: A coluna pela qual você deseja ordenar o conjunto de resultados antes de aplicar a função NTILE().*/
--Exemplo: Listar funcionários dividindo-os em 3 grupos
SELECT first_name, last_name, title,
   NTILE(3) OVER (ORDER BY first_name) AS group_number
FROM employees;  

-- LAG(), LEAD()
SELECT 
  customer_id, 
  TO_CHAR(order_date, 'YYYY-MM-DD') AS order_date, 
  shippers.company_name AS shipper_name, 
  LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS previous_order_freight, 
  freight AS order_freight, 
  LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS next_order_freight
FROM 
  orders
JOIN 
  shippers ON shippers.shipper_id = orders.ship_via;

