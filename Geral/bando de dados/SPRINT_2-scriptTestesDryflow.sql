-- Testes

SELECT * FROM oficina;
SELECT * FROM endereco;
SELECT * FROM funcionario;
SELECT * FROM telefone;
SELECT * FROM compressor;
SELECT * FROM sensor;
SELECT * FROM registro_sensor;
SELECT * FROM telefone;

SELECT nomeOficina AS NOME_OFICINA, logradouro, rua, numero, cidade, cep  FROM oficina INNER JOIN endereco ON idOficina = fkOficina;

SELECT nomeOficina AS NOME_OFICINA FROM oficina INNER JOIN compressor ON fkOficina = idOficina;