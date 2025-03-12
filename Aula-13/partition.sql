CREATE TABLE pessoas (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(3),
    last_name VARCHAR(3),
    estado VARCHAR(3)
);

-- Inserção de 1 Milhão de Registros:
CREATE OR REPLACE FUNCTION random_estado()
RETURNS VARCHAR(3) AS $$
BEGIN
   RETURN CASE floor(random() * 5)
         WHEN 0 THEN 'SP'
         WHEN 1 THEN 'RJ'
         WHEN 2 THEN 'MG'
         WHEN 3 THEN 'ES'
         ELSE 'DF'
         END;
END;
$$ LANGUAGE plpgsql;

-- Inserir dados na tabela pessoas com estados aleatórios
INSERT INTO pessoas (first_name, last_name, estado)
SELECT 
   substring(md5(random()::text), 0, 3),
   substring(md5(random()::text), 0, 3),
   random_estado()
FROM 
   generate_series(1, 10000000);

--Criando um INDEX no first_name

CREATE INDEX first_name_index ON pessoas(first_name)   

-- Fazendo uma busca usando um INDEX
SELECT COUNT(*) FROM pessoas WHERE first_name = 'aa'

-- Fazendo uma busca sem usar INDEX
SELECT COUNT(*) FROM pessoas WHERE last_name = 'aa'

CREATE TABLE pessoas2 (
    id SERIAL,
    first_name VARCHAR(3),
    last_name VARCHAR(3),
    estado VARCHAR(3),
    PRIMARY KEY (id, estado)
) PARTITION BY LIST (estado);

-- Criar as partições
CREATE TABLE pessoas_sp PARTITION OF pessoas2 FOR VALUES IN ('SP');
CREATE TABLE pessoas_rj PARTITION OF pessoas2 FOR VALUES IN ('RJ');
CREATE TABLE pessoas_mg PARTITION OF pessoas2 FOR VALUES IN ('MG');
CREATE TABLE pessoas_es PARTITION OF pessoas2 FOR VALUES IN ('ES');
CREATE TABLE pessoas_df PARTITION OF pessoas2 FOR VALUES IN ('DF');

INSERT INTO pessoas2 (first_name, last_name, estado)
   SELECT 
      substring(md5(random()::text), 0, 3),
      substring(md5(random()::text), 0, 3),
      random_estado()
 FROM 
      generate_series(1, 10000000);

select count(*) from pessoas2


