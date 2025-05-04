-- Testes
USE dryflow;

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
INNER JOIN endereco ON endereco.fkEndEmpresa = empresa.idEmpresa;

-- Mostrar oficina e seu endereço
SELECT 
oficina.nomeOficina AS Nome_Oficina, 
endereco.rua AS Rua, 
endereco.numero AS Número, 
endereco.cidade AS Cidade, 
endereco.cep AS CEP FROM oficina 
INNER JOIN endereco ON endereco.fkEndOficina = oficina.idOficina;

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
WHERE nomeOficina = 'Oficina A';

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
