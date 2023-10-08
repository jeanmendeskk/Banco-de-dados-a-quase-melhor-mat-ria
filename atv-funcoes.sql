CREATE DATABASE bagui_la;
use bagui_la;

-- ex 1

CREATE TABLE nomes (
    nome VARCHAR(20)
);

INSERT INTO nomes (nome)
VALUES('Roberta'),
('Roberto'),
('Maria Clara'),
('João');

SELECT UPPER(nome) AS nome_maiusculo
FROM nomes;

SELECT nome, LENGTH(nome) AS tamanho_nome
FROM nomes;

SELECT
    CASE
        WHEN RIGHT(nome, 1) = 'a' THEN CONCAT('Sra. ', nome)
        WHEN RIGHT(nome, 1) = 'o' THEN CONCAT('Sr. ', nome)
    END AS nome_sr_sra
FROM nomes;

-- ex 2

CREATE TABLE produtos (
    produto VARCHAR(30),
    preco DECIMAL(10, 3),
    quantidade INT
);

INSERT INTO produtos (produto, preco, quantidade)
VALUES('Chocolate 200g', 19.997, 5),
('Bandeja 12 Ovos', 9.501, 3),
('Kit Shampoo e Condicionador', 29.993, 7),
('Faca de mesa', 12.754, 2);
    
SELECT produto, ROUND(preco, 2) AS preco_arredondado
FROM produtos;

SELECT produto, ABS(quantidade) AS quantidade_total
FROM produtos;

SELECT AVG(preco) AS media_precos
FROM produtos;

-- ex 3

CREATE TABLE eventos (
    data_evento DATE
);

INSERT INTO eventos (data_evento)
VALUES('2023-10-01'),
('2023-10-15'),
('2023-11-05');

INSERT INTO eventos (data_evento)
VALUES (NOW());

SELECT
    data_evento,
    DATEDIFF(data_evento, CURDATE()) AS dias_ate_hoje
FROM eventos;

SELECT
    data_evento,
    DAYNAME(data_evento) AS dia_da_semana
FROM eventos;

-- ex 4

SELECT produto,
       quantidade,
       IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS status_estoque
FROM produtos;

SELECT produto,
       preco,
       CASE
           WHEN preco <= 10 THEN 'Barato'
           WHEN preco <= 20 THEN 'Médio'
           ELSE 'Caro'
       END AS categoria_preco
FROM produtos;

-- ex 5

DELIMITER //

CREATE FUNCTION TOTAL_VALOR(preco DECIMAL(10, 2), quantidade INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SET total = preco * quantidade;
    RETURN total;
END;
//
DELIMITER ;

SELECT produto,
       preco,
       quantidade,
       TOTAL_VALOR(preco, quantidade) AS valor_total
FROM produtos;

-- ex 6

SELECT COUNT(*) AS total_produtos
FROM produtos;

SELECT produto
FROM produtos
WHERE preco = (SELECT MAX(preco) FROM produtos);

SELECT produto
FROM produtos
WHERE preco = (SELECT MIN(preco) FROM produtos);

SELECT SUM(IF(quantidade > 0, preco, 0)) AS total_em_estoque
FROM produtos;

-- ex 7

DELIMITER //
CREATE FUNCTION calcular_fatorial(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = 1;
    WHILE n > 0 DO
        SET resultado = resultado * n;
        SET n = n - 1;
    END WHILE;
    RETURN resultado;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION calcular_exponencial(base DECIMAL(10, 2), expoente INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE resultado DECIMAL(10, 2);
    SET resultado = POW(base, expoente);
    RETURN resultado;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION verificar_palindromo(palavra VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE tam INT;
    DECLARE i INT;
    DECLARE palindromo INT;
    SET tam = LENGTH(palavra);
    SET palindromo = 1;
    SET i = 1;
    WHILE i <= tam / 2 DO
        IF SUBSTRING(palavra, i, 1) <> SUBSTRING(palavra, tam - i + 1, 1) THEN
            SET palindromo = 0;
        END IF;
        SET i = i + 1;
    END WHILE;
    RETURN palindromo;
END;
//
DELIMITER ;