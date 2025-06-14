-- Testes
USE dryflow;

-- INSERÇÃO DE DADOS
-- Inserir Empresas
insert into empresa (cnpj, nomeFantasia, email) values
('12345678000195', 'Empresa A', 'contato@empresaA.com'),
('98765432000198', 'Empresa B', 'contato@empresaB.com'),
('11122233000181', 'Empresa C', 'contato@empresaC.com'),
('22233344000102', 'Empresa D', 'contato@empresaD.com');

-- Inserir Oficinas (Empresa A tem 1 oficina a mais)
insert into oficina (nomeOficina, fkEmpresa, codigo_ativacao) values
('Oficina A', 1, 'AAAAA'), 
('Oficina B', 2, 'BBBBB'), 
('Oficina C', 3, 'CCCCC'),
('Oficina D', 4, 'DDDDD'),
('Oficina E', 1, 'EEEEE');

-- Inserir Endereços para Empresas (sem associar à oficina)
insert into endereco (rua, numero, cidade, bairro, estado, cep, fkEndOficina, fkEndEmpresa) values
('Av. Central', 100, 'São Paulo', 'Bairro A','São Paulo', '01001000', NULL, 1), 
('Av. Paulista', 200, 'São Paulo', 'Bairro B','São Paulo','01002000', NULL, 2),
('Rua das Flores', 300, 'Rio de Janeiro','Bairro C','Rio de Janeiro','20001000', NULL, 3),
('Rua das Pedras', 400, 'Belo Horizonte', 'Bairro D','Minas Gerais','30001000', NULL, 4);

-- Inserir Endereços para Oficinas (sem associar à empresa)
insert into endereco (rua, numero, cidade, bairro, estado, cep, fkEndOficina, fkEndEmpresa) values
('Av. Tropical', 101, 'São Paulo','Bairro D','São Paulo', '01001001', 1, NULL),
('Rua do Sol', 202, 'São Paulo','Bairro E','São Paulo', '01002001', 2, NULL),
('Rua das Flores', 303, 'Rio de Janeiro','Bairro F','Rio de Janeiro', '20001001', 3, NULL),
('Rua das Pedras', 404, 'Belo Horizonte','Bairro G','Minas Gerais', '30001001', 4, NULL),
('Rua dos Diamantes', 505, 'Belo Horizonte','Bairro H','Minas Gerais', '40001001', 5, NULL);

-- Inserir Funcionários
insert into funcionario (nome, email, senha, cargo, fkOficina) values
('Feranado Brandao', 'brandao@sptech.com', '654321', 'Supervisor', 1),
('Hector Silva', 'hector@empresaA.com', 'senha123', 'Gerente', 1),
('João Silva', 'joao@empresaA.com', 'senha123', 'Técnico', 1),
('Maria Oliveira', 'maria@empresaB.com', 'senha123', 'Gerente', 2),
('Carlos Souza', 'carlos@empresaC.com', 'senha123', 'Supervisor', 3),
('Ana Costa', 'ana@empresaD.com', 'senha123', 'Técnico', 4),
('Roberta Marinho', 'roberta@empresaD.com', 'senha123', 'Técnico', 5);



-- Inserir Telefones
insert into telefone (numero, fkTelFuncionario, fkTelEmpresa, fkTelOficina) values
('1112345678', 1, NULL, NULL), 
('11987654321', 2, NULL, NULL),
('21387654321', 3, NULL, NULL),
('31987654321', 4, NULL, NULL),
('45687654321', 5, NULL, NULL),
('78887654321', 6, NULL, NULL),
('1123456789', NULL, 1, NULL), 
('1122334455', NULL, 2, NULL),
('2133445566', NULL, 3, NULL),
('3198877665', NULL, 4, NULL),
('1198887777', NULL, NULL, 1),
('2133222333', NULL, NULL, 2),
('3199988777', NULL, NULL, 3),
('2199999888', NULL, NULL, 4),
('2145679888', NULL, NULL, 5);

-- Inserir Compressores
insert into compressor (modelo, capacidadeUmiMax, status, fkOficina) values
('Modelo A', 60, 'ativo', 1),
('Modelo B', 75, 'ativo', 2),
('Modelo C', 50, 'inativo', 3),
('Modelo D', 80, 'ativo', 4),
('Modelo E', 87, 'ativo', 5),
('Modelo F', 60, 'ativo', 1),
('Modelo G', 75, 'ativo', 1),
('Modelo H', 58, 'ativo', 1),
('Modelo I', 62, 'ativo', 1);

-- Inserir Sensores
insert into sensor (fkCompressor) values
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9);

-- Inserir Registros de Sensor
insert into registroSensor (umidadeRegistrada, dtHrRegistrada, fkSensor) values
(55, '2025-06-04 14:45:30', 1),
(60, '2025-06-04 14:45:31', 1),
(64, '2025-06-04 14:45:32', 1),
(80, '2025-06-04 14:45:30', 2),
(40, '2025-06-04 14:45:30', 3),
(85, '2025-06-04 14:45:30', 4),
(88, '2025-06-04 14:45:30', 5),
(81, '2025-06-04 14:45:30', 6),
(74, '2025-06-04 14:45:30', 7),
(55, '2025-06-04 14:45:30', 8),
(18, '2025-06-04 14:45:30', 9);

-- Teste das tabelas
SELECT * FROM oficina;
SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM funcionario;
SELECT * FROM telefone;
SELECT * FROM compressor;
SELECT * FROM sensor;
SELECT * FROM registroSensor;





/*
-- Apagar os registros captados pelo sensor caso tenha a tabela alerta
SELECT * FROM information_schema.referential_constraints where constraint_schema = 'dryflow' AND table_name = 'alerta';
ALTER TABLE alerta DROP FOREIGN KEY fk_alerta;
TRUNCATE registroSensor;
TRUNCATE alerta;
ALTER TABLE alerta ADD CONSTRAINT fk_alerta foreign key (fkAlerta) references registroSensor(idRegistro);
*/

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
WHERE nomeOficina = 'Amor Por Carros';

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
INNER JOIN endereco ON fkEndOficina = idOficina
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
INNER JOIN endereco ON fkEndOficina = idOficina
INNER JOIN empresa ON fkEmpresa = idEmpresa 
WHERE empresa.nomeFantasia = 'Empresa A';

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
        WHERE rs.dtHrRegistrada = '2025-06-04 14:45:30'
        AND c.fkOficina = 1
        GROUP BY c.idCompressor, c.modelo, rs.umidadeRegistrada, rs.dtHrRegistrada
        ORDER BY rs.umidadeRegistrada 
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