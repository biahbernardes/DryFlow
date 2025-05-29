CREATE DATABASE IF NOT EXISTS dryflow;
USE dryflow;

CREATE TABLE IF NOT EXISTS empresa (
idEmpresa INT NOT NULL AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL,
nomeFantasia VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
PRIMARY KEY (idEmpresa)
);

CREATE TABLE IF NOT EXISTS oficina (
idOficina INT NOT NULL AUTO_INCREMENT,
nomeOficina VARCHAR(45) NOT NULL,
codigo_ativacao VARCHAR(45) NULL,
fkEmpresa INT NOT NULL,
PRIMARY KEY (idOficina),
CONSTRAINT fk_Oficinas_Empresa1
FOREIGN KEY (fkEmpresa)
REFERENCES empresa (idEmpresa)
);

CREATE TABLE IF NOT EXISTS telefone (
idTelefone INT NOT NULL AUTO_INCREMENT,
numero VARCHAR(20) NOT NULL,
fkTelEmpresa INT NULL,
fkTelOficina INT NULL,
PRIMARY KEY (idTelefone),
CONSTRAINT fk_Telefones_Empresa1
FOREIGN KEY (fkTelEmpresa)
REFERENCES empresa (idEmpresa),
CONSTRAINT fk_Telefones_Oficinas1
FOREIGN KEY (fkTelOficina)
REFERENCES oficina (idOficina)
);

CREATE TABLE IF NOT EXISTS endereco (
idEndereco INT NOT NULL AUTO_INCREMENT,
rua VARCHAR(45) NOT NULL,
numero INT NOT NULL,
cidade VARCHAR(45) NOT NULL,
bairro VARCHAR(45) NOT NULL,
cep CHAR(8) NOT NULL,
fkEndEmpresa INT NULL,
fkEndOficina INT NULL,
PRIMARY KEY (idEndereco),
CONSTRAINT fk_endereco_oficina1
FOREIGN KEY (fkEndEmpresa)
REFERENCES oficina (idOficina),
CONSTRAINT fk_endereco_empresa1
FOREIGN KEY (fkEndOficina)
REFERENCES empresa (idEmpresa)
);

CREATE TABLE IF NOT EXISTS funcionario (
idFuncionario INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
email VARCHAR(45) NOT NULL UNIQUE,
senha VARCHAR(45) NOT NULL,
cargo VARCHAR(45) NOT NULL,
fkOficina INT NOT NULL,
PRIMARY KEY (idFuncionario),
CONSTRAINT fk_Funcionarios_Oficinas1
FOREIGN KEY (fkOficina)
REFERENCES oficina (idOficina)
);

CREATE TABLE IF NOT EXISTS compressor (
idCompressor INT NOT NULL AUTO_INCREMENT,
modelo VARCHAR(45) NOT NULL,
capacidadeUmiMax INT NOT NULL,
status VARCHAR(20) NOT NULL,
fkOficina INT NOT NULL,
PRIMARY KEY (idCompressor),
CONSTRAINT fk_Compressor_Oficinas1
FOREIGN KEY (fkOficina)
REFERENCES oficina (idOficina)
);

CREATE TABLE IF NOT EXISTS sensor (
idSensor INT NOT NULL AUTO_INCREMENT,
fkCompressor INT NOT NULL,
PRIMARY KEY (idSensor),
CONSTRAINT fk_sensor_compressor1
FOREIGN KEY (fkCompressor)
REFERENCES compressor (idCompressor)
);

CREATE TABLE IF NOT EXISTS registroSensor (
idRegistro INT NOT NULL AUTO_INCREMENT,
umidadeRegistrada INT NOT NULL,
dtHrRegistrada DATETIME NOT NULL,
fkSensor INT NOT NULL,
PRIMARY KEY (idRegistro),
CONSTRAINT fk_RegistrosSensor_Sensor1
FOREIGN KEY (fkSensor)
REFERENCES sensor (idSensor)
);

/*
create table alerta (
idAlerta int primary key auto_increment,
dtHrAlerta datetime not null,
umidAlerta int,
fkAlerta int not null,
constraint fk_alerta foreign key (fkAlerta) references registroSensor(idRegistro)
);
*/

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
insert into endereco (rua, numero, cidade, bairro, cep, fkEndOficina, fkEndEmpresa) values
('Av. Central', 100, 'São Paulo', 'Bairro A','01001000', NULL, 1), 
('Av. Paulista', 200, 'São Paulo', 'Bairro B','01002000', NULL, 2),
('Rua das Flores', 300, 'Rio de Janeiro','Bairro C', '20001000', NULL, 3),
('Rua das Pedras', 400, 'Belo Horizonte', 'Bairro D','30001000', NULL, 4);

-- Inserir Endereços para Oficinas (sem associar à empresa)
insert into endereco (rua, numero, cidade, bairro, cep, fkEndOficina, fkEndEmpresa) values
('Av. Tropical', 101, 'São Paulo', 'Bairro D', '01001001', 1, NULL),
('Rua do Sol', 202, 'São Paulo', 'Bairro E', '01002001', 2, NULL),
('Rua das Flores', 303, 'Rio de Janeiro', 'Bairro F', '20001001', 3, NULL),
('Rua das Pedras', 404, 'Belo Horizonte', 'Bairro G', '30001001', 4, NULL);

-- Inserir Funcionários
insert into funcionario (nome, email, senha, cargo, fkOficina) values
('Feranado Brandao', 'brandao@sptech.com', '654321', 'Supervisor', 1);

-- Inserir Telefones
insert into telefone (numero,fkTelEmpresa, fkTelOficina) values
('1123456789', 1, NULL), 
('1122334455', 2, NULL),
('2133445566', 3, NULL),
('3198877665', 4, NULL),
('1198887777', NULL, 1),
('2133222333', NULL, 2),
('3199988777', NULL, 3),
('2199999888', NULL, 4),
('2145679888', NULL, 5);

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
(55, '2025-04-07 08:00:00', 1),
(60, '2025-04-07 09:00:00', 1),
(64, '2025-04-07 10:00:00', 1),
(80, '2025-04-07 09:00:00', 2),
(40, '2025-04-07 10:00:00', 3),
(85, '2025-04-07 11:00:00', 4),
(88, '2025-04-07 12:00:00', 5),
(81, '2025-04-07 12:00:00', 6),
(74, '2025-04-07 12:00:00', 7),
(55, '2025-04-07 12:00:00', 8),
(18, '2025-04-07 12:00:00', 9);

/*
-- Inserir Alertas (Comentei para não usarmos ela)
insert into alerta (dtHrAlerta, umidAlerta, fkAlerta) values 
('2025-04-07 12:30:00', 80, 2),
('2025-04-07 13:30:00', 85, 4);
*/
