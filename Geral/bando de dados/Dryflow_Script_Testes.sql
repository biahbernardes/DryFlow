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
SELECT * FROM alerta;

-- Apagar os registros captados pelo sensor
SELECT * FROM information_schema.referential_constraints where constraint_schema = 'dryflow' AND table_name = 'alerta';
ALTER TABLE alerta DROP FOREIGN KEY fk_alerta;
TRUNCATE registroSensor;
TRUNCATE alerta;
ALTER TABLE alerta ADD CONSTRAINT fk_alerta foreign key (fkAlerta) references registroSensor(idRegistro);

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

-- Mostrar compressor e sua respectiva oficina e endereço
SELECT 
compressor.modelo AS Modelo_Compressor,
oficina.nomeOficina AS Nome_Oficina,
endereco.rua AS Rua,
endereco.numero AS Número,
endereco.cidade AS Cidade,
endereco.bairro AS Bairro,
endereco.cep AS CEP
FROM compressor 
INNER JOIN oficina ON fkOficina=idOficina
INNER JOIN endereco ON fkEndOficina = idOficina;