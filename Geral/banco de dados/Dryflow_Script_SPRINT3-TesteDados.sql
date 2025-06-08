/*DRYFLOW - TESTES DE DADOS*/

-- Apagar os registros captados pelo sensor
TRUNCATE registroSensor;

-- Mostrar empresa e seu endereço
SELECT 
empresa.nomeFantasia, 
endereco.rua AS Rua, 
endereco.numero AS Número, 
endereco.cidade AS Cidade, 
endereco.cep AS CEP FROM empresa 
INNER JOIN endereco ON endereco.idEndereco = empresa.fkEndEmpresa;

-- Mostrar oficina e seu endereço
SELECT 
oficina.nomeOficina AS Nome_Oficina, 
endereco.rua AS Rua, 
endereco.numero AS Número, 
endereco.cidade AS Cidade, 
endereco.cep AS CEP FROM oficina 
INNER JOIN endereco ON endereco.idEndereco = oficina.fkEndOficina;

-- Mostrar Oficina e seus funcionários
SELECT
nomeOficina AS NOME_OFICINA,
nome AS NOME_FUNCIONÁRIO,
email AS EMAIL_FUNCIONÁRIO,
cargo AS CARGO_FUNCIONÁRIO
FROM oficina 
INNER JOIN funcionario ON idOficina = fkOficina ORDER BY nomeOficina;

-- Mostrar Oficina e seus funcionários de uma determinada oficina
SELECT
nomeOficina AS NOME_OFICINA,
nome AS NOME_FUNCIONÁRIO,
email AS EMAIL_FUNCIONÁRIO,
cargo AS CARGO_FUNCIONÁRIO
FROM oficina 
INNER JOIN funcionario ON idOficina = fkOficina
WHERE nomeOficina = 'Oficina Belos Automóveis';

-- Mostrar compressor e seu respectivo endereço e empresa
SELECT 
compressor.modelo AS Modelo_Compressor,
oficina.nomeOficina AS Nome_Oficina,
endereco.rua AS Rua,
endereco.numero AS Número,
endereco.cidade AS Cidade,
endereco.bairro AS Bairro,
endereco.cep AS CEP,
empresa.nomeFantasia AS Nome_Empresa,
empresa.cnpj AS CNPJ
FROM compressor 
INNER JOIN oficina ON fkOficina=idOficina
INNER JOIN endereco ON idEndereco = oficina.fkEndOficina
INNER JOIN empresa ON fkEmpresa = idEmpresa ;

-- Mostrar compressor e sua respectiva oficina e endereço de uma determinada empresa
SELECT 
compressor.modelo AS Modelo_Compressor,
oficina.nomeOficina AS Nome_Oficina,
endereco.rua AS Rua,
endereco.numero AS Número,
endereco.cidade AS Cidade,
endereco.bairro AS Bairro,
endereco.cep AS CEP,
empresa.nomeFantasia AS Nome_Empresa,
empresa.cnpj AS CNPJ
FROM compressor 
INNER JOIN oficina ON fkOficina=idOficina
INNER JOIN endereco ON idEndereco = oficina.fkEndOficina
INNER JOIN empresa ON fkEmpresa = idEmpresa 
WHERE empresa.nomeFantasia = 'Amor Por Carros';

-- Mostrar compressor e seus registros
SELECT 
modelo AS Modelo_Compressor,
capacidadeUmiMax AS Umidade_Máxima_Compressor,
status AS Status_Compressor,
umidadeRegistrada AS Umidade_Registrada,
dtHrRegistrada AS DATA_E_HORA_REGISTRO 
FROM compressor 
INNER JOIN sensor ON fkCompressor = idCompressor
INNER JOIN registroSensor ON fkSensor = idSensor;

-- Mostrar compressor e seus registros que ultrapassarem a umidade máxima do compressor
SELECT 
modelo AS Modelo_Compressor,
capacidadeUmiMax AS Umidade_Máxima_Compressor,
status AS Status_Compressor,
umidadeRegistrada AS Umidade_Registrada,
dtHrRegistrada AS DATA_E_HORA_REGISTRO 
FROM compressor 
INNER JOIN sensor ON fkCompressor = idCompressor
INNER JOIN registroSensor ON fkSensor = idSensor
WHERE umidadeRegistrada > capacidadeUmiMax;

-- buscar últimas medidas
SELECT  
        umidadeRegistrada as umidade,
        dtHrRegistrada,
					DATE_FORMAT(dtHrRegistrada,'%H:%i:%s') as momento_grafico
                    FROM registroSensor
                    WHERE fkSensor = 1
                    ORDER BY idRegistro DESC LIMIT 7;

-- buscar últimas medidas em tempo real

                    SELECT 
        umidadeRegistrada as umidade,
                        DATE_FORMAT(dtHrRegistrada,'%H:%i:%s') as momento_grafico,
                        fkSensor
                        FROM registroSensor WHERE fkSensor = 1 
                    ORDER BY idRegistro DESC LIMIT 1;


-- Apagar os registros captados pelo sensor
TRUNCATE registroSensor;
-- Inserir Registros de Sensor PARA TESTES DE Contador de vezes que passou da umidade nas últimas 24 horas
insert into registroSensor (umidadeRegistrada, dtHrRegistrada, fkSensor) values
(20, '2025-06-03 00:00:00', 1),
(20, '2025-06-03 01:00:00', 1),
(20, '2025-06-03 02:00:00', 1),
(20, '2025-06-03 03:00:00', 1),
(20, '2025-06-03 04:00:00', 1),
(20, '2025-06-03 05:00:00', 1),
(20, '2025-06-03 06:00:00', 1),
(25, '2025-06-03 07:00:00', 1),
(45, '2025-06-03 08:00:00', 1),
(51, '2025-06-03 09:00:00', 1), -- Passou da umidade
(51, '2025-06-03 09:30:00', 1), -- Passou da umidade
(55, '2025-06-03 10:00:00', 1), -- Passou da umidade
(55, '2025-06-03 10:30:00', 1), -- Passou da umidade
(60, '2025-06-03 11:00:00', 1), -- Passou da umidade
(60, '2025-06-03 11:30:00', 1), -- Passou da umidade
(60, '2025-06-03 11:31:00', 1), -- Passou da umidade
(60, '2025-06-03 11:32:00', 1), -- Passou da umidade
(60, '2025-06-03 11:33:00', 1), -- Passou da umidade
(60, '2025-06-03 11:54:00', 1), -- Passou da umidade
(60, '2025-06-03 11:30:00', 1), -- Passou da umidade
(20, '2025-06-03 12:00:00', 1),
(22, '2025-06-03 13:00:00', 1),
(24, '2025-06-03 14:00:00', 1),
(34, '2025-06-03 15:00:00', 1),
(64, '2025-06-03 16:00:00', 1), -- Passou da umidade
(75, '2025-06-03 17:00:00', 1), -- Passou da umidade
(20, '2025-06-03 18:00:00', 1),
(20, '2025-06-03 19:00:00', 1),
(47, '2025-06-03 20:00:00', 1), 
(59, '2025-06-03 21:00:00', 1), -- Passou da umidade
(20, '2025-06-03 22:00:00', 1),
(20, '2025-06-03 23:00:00', 1),
(20, '2025-06-04 00:00:00', 1),
(20, '2025-06-04 01:00:00', 1),
(20, '2025-06-04 02:00:00', 1),
(20, '2025-06-04 03:00:00', 1),
(20, '2025-06-04 04:00:00', 1),
(20, '2025-06-04 05:00:00', 1),
(20, '2025-06-04 06:00:00', 1),
(25, '2025-06-04 07:00:00', 1),
(45, '2025-06-04 08:00:00', 1),
(51, '2025-06-04 09:00:00', 1), -- Passou da umidade
(55, '2025-06-04 10:00:00', 1), -- Passou da umidade
(60, '2025-06-04 11:00:00', 1), -- Passou da umidade
(20, '2025-06-04 12:00:00', 1),
(22, '2025-06-04 13:00:00', 1),
(24, '2025-06-04 14:00:00', 1),
(34, '2025-06-04 15:00:00', 1),
(64, '2025-06-04 16:00:00', 1), -- Passou da umidade
(75, '2025-06-04 17:00:00', 1), -- Passou da umidade
(20, '2025-06-04 18:00:00', 1),
(20, '2025-06-04 19:00:00', 1),
(47, '2025-06-04 20:00:00', 1), 
(59, '2025-06-04 21:00:00', 1), -- Passou da umidade
(20, '2025-06-04 22:00:00', 1),
(20, '2025-06-04 23:00:00', 1),
(51, '2025-06-03 08:00:00', 2), -- Passou da umidade
(51, '2025-06-03 22:00:00', 2), -- Passou da umidade
(51, '2025-06-03 23:00:00', 2), -- Passou da umidade
(51, '2025-07-03 08:00:00', 1), -- Passou da umidade
(51, '2025-07-03 22:00:00', 1), -- Passou da umidade
(51, '2025-07-03 23:00:00', 1); -- Passou da umidade
-- Contador quantidade de vezes compressor passou dos 50% no dia do compressor selecionado

SELECT TIME(current_timestamp());
SELECT * FROM registroSensor WHERE TIME(dtHrRegistrada) LIKE ("%%:%%:00");
SELECT COUNT(registroSensor.umidadeRegistrada) AS "Quantidade_Passou_50" FROM registroSensor 
INNER JOIN sensor ON registroSensor.fkSensor = sensor.idSensor
INNER JOIN compressor ON sensor.fkCompressor = compressor.idCompressor
WHERE umidadeRegistrada > 50 
AND DATE(registroSensor.dtHrRegistrada) = CURDATE() 
AND sensor.fkCompressor = compressor.idCompressor
AND TIME(registroSensor.dtHrRegistrada) LIKE ("%%:%%:00");

-- Horário que iniciou a umidade a ficar mais de 50% de umidade hoje
SELECT MIN(TIME(dtHrRegistrada)) AS "HorarioHoje_Inicio_umidadeMaior50" FROM registroSensor
INNER JOIN sensor ON registroSensor.fkSensor = sensor.idSensor
INNER JOIN compressor ON sensor.fkCompressor = compressor.idCompressor
WHERE umidadeRegistrada > 50 AND DATE(registroSensor.dtHrRegistrada) = CURDATE() AND sensor.fkCompressor = compressor.idCompressor;

-- Contagem total de registros que passou de 50% de umidade no ultimo mes

SELECT  COUNT(registroSensor.umidadeRegistrada) AS "Quantidade_Passou_50_Mes" FROM registroSensor 
        INNER JOIN sensor ON registroSensor.fkSensor = sensor.idSensor
        INNER JOIN compressor ON sensor.fkCompressor = compressor.idCompressor
        WHERE umidadeRegistrada > 50 
        AND MONTH(registroSensor.dtHrRegistrada) = MONTH(CURDATE()) 
        AND YEAR(registroSensor.dtHrRegistrada) = YEAR(CURDATE())
        AND sensor.fkCompressor = compressor.idCompressor;
        
        -- Gráfico de barras (Fazer ajustes colocando massas de dados mockados só para ficar bonito na apresentação)
        SELECT * FROM compressor;
        SELECT c.modelo, rs.umidadeRegistrada, rs.dtHrRegistrada
        FROM compressor c
        INNER JOIN sensor s ON c.idCompressor = s.fkCompressor
        INNER JOIN registroSensor rs ON rs.fkSensor = s.idSensor
--        WHERE rs.dtHrRegistrada = (SELECT MAX(dtHrRegistrada) FROM registroSensor) (Na verdade tem que ser esse, mas fazer registro fixo para apresentação)
        WHERE rs.dtHrRegistrada = '2025-06-11 09:00:00'
        AND c.fkOficina = 1
        GROUP BY c.idCompressor, c.modelo, rs.umidadeRegistrada, rs.dtHrRegistrada
        ORDER BY rs.umidadeRegistrada DESC
        LIMIT 5;
        
-- Código para pegar somente compressores daquela oficina
        SELECT 
      c.modelo, 
      c.idCompressor,
      rs.umidadeRegistrada, 
      rs.dtHrRegistrada
    FROM compressor c
    JOIN sensor s ON s.fkCompressor = c.idCompressor
    JOIN registroSensor rs ON rs.fkSensor = s.idSensor
    WHERE rs.idRegistro = (
      SELECT MAX(rs2.idRegistro)
      FROM sensor s2
      JOIN registroSensor rs2 ON rs2.fkSensor = s2.idSensor
      WHERE s2.fkCompressor = c.idCompressor
    )
    AND c.fkOficina = 1
    ORDER BY rs.dtHrRegistrada DESC;
    
    SELECT * FROM funcionario;
    SELECT * FROM registroSensor;
    SELECT * FROM sensor;
    SELECT * FROM compressor;
    SELECT * FROM registroSensor WHERE fkSensor = 1;
    
    TRUNCATE registroSensor;