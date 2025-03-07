-- Criação de um TRIGGER
CREATE OR REPLACE FUNCTION func_verifica_estoque() RETURNS TRIGGER AS $$
DECLARE
    qted_atual INTEGER;
BEGIN
    SELECT qtde_disponivel INTO qted_atual
    FROM Produto WHERE cod_prod = NEW.cod_prod;
    IF qted_atual < NEW.qtde_vendida THEN
        RAISE EXCEPTION 'Quantidade indisponivel em estoque'
    ELSE
        UPDATE Produto SET qtde_disponivel = qtde_disponivel - NEW.qtde_vendida
        WHERE cod_prod = NEW.cod_prod;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verifica_estoque 
BEFORE INSERT ON RegistroVendas
FOR EACH ROW 
EXECUTE FUNCTION func_verifica_estoque();

-- Tentativa de venda de 5 unidades de Basico (deve ser bem-sucedida, pois há 10 unidades disponíveis)
INSERT INTO RegistroVendas (cod_prod, qtde_vendida) VALUES (1, 5);

-- Tentativa de venda de 6 unidades de Dados (deve ser bem-sucedida, pois há 5 unidades disponíveis e a quantidade vendida não excede o estoque)
INSERT INTO RegistroVendas (cod_prod, qtde_vendida) VALUES (2, 5);

-- Tentativa de venda de 16 unidades de Versao (deve falhar, pois só há 15 unidades disponíveis)
INSERT INTO RegistroVendas (cod_prod, qtde_vendida) VALUES (3, 16);