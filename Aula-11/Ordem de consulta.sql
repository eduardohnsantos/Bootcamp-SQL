/*Para alcançar nosso objetivo de identificar os dois carros mais potentes da Alemanha, estaremos olhando para automóveis modernos que não sejam mais antigos do que oito anos. 
Para isso, usaremos instruções SQL conhecidas como SELECT, FROM, JOIN, WHERE, GROUP BY, HAVING, ORDER BY e LIMIT.*/


SELECT
  cars.manufacturer,
  cars.model,
  cars.country,
  cars.year,
  MAX(engines.horse_power) as maximum_horse_power
FROM cars
JOIN engines ON cars.engine_name = engines.name
WHERE cars.year > 2015 AND cars.country = 'Germany'
GROUP BY cars.manufacturer, cars.model, cars.country, cars.year
HAVING MAX(engines.horse_power)> 200
ORDER BY maximum_horse_power DESC
LIMIT 2

/*Saída da consulta — os dois carros alemães mais potentes do nosso banco de dados de amostra

Agora que temos nossa consulta, vamos entender como o mecanismo a ordena ao executar. Aqui está a ordem:

FROM
JOIN (e ON)
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
LIMIT*/