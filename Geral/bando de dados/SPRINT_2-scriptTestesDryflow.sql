-- Testes
USE dryflow;

SELECT * FROM oficina;
SELECT * FROM endereco;
SELECT * FROM funcionario;
SELECT * FROM telefone;
SELECT * FROM compressor;
SELECT * FROM sensor;
SELECT * FROM registro_sensor;
SELECT * FROM telefone;

TRUNCATE registro_sensor;

SELECT nomeOficina AS NOME_OFICINA, logradouro, rua, numero, cidade, cep  FROM oficina INNER JOIN endereco ON idOficina = fkOficina;

SELECT nomeOficina AS NOME_OFICINA FROM oficina INNER JOIN compressor ON fkOficina = idOficina;

SELECT o.nomeOficina Oficina, c.idCompressor 'Número Compressor', c.modelo 'Modelo Compressor', s.idSensor 'Número Sensor', r.umidadeRegistrada 'Registro Umidade'
FROM compressor c
INNER JOIN oficina o ON c.fkOficina = o.idOficina
INNER JOIN sensor s ON s.fkCompressor = c.idCompressor
INNER JOIN registro_sensor r ON r.fkSensor = s.idSensor;

SELECT o.nomeOficina Oficina, c.idCompressor 'Número Compressor', c.modelo 'Modelo Compressor', s.idSensor 'Número Sensor', r.umidadeRegistrada 'Registro Umidade'
FROM compressor c
INNER JOIN oficina o ON c.fkOficina = o.idOficina
INNER JOIN sensor s ON s.fkCompressor = c.idCompressor
INNER JOIN registro_sensor r ON r.fkSensor = s.idSensor
WHERE umidadeRegistrada > 50;