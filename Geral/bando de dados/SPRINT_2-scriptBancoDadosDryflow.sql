create database dryflow;
use dryflow;

create table empresa (
idEmpresa int primary key auto_increment,
cnpj char(14) not null,
nomeFantasia varchar(50) not null,
email varchar(50) not null
);

create table oficina (
idOficina int primary key auto_increment,
qtdCompressor int not null,
qtdFuncionario int not null,
fkempresa int not null,
constraint fk_empresa foreign key (fkempresa) references empresa(idEmpresa)
);

create table endereco (
idEndereco int primary key auto_increment,
rua varchar(45) not null,
numero int not null,
cidade varchar(45) not null,
cep char(8) not null,
fkEndOficina int,
fkEndEmpresa int,
constraint fk_endOficina foreign key (fkEndOficina) references oficina(idOficina),
constraint fk_endEmpresa foreign key (fkEndEmpresa) references empresa(idEmpresa)
);

create table funcionarios (
idFuncionario int primary key auto_increment,
nome varchar(45) not null,
email varchar(45) not null,
senha varchar(45) not null,
cargo varchar(45) not null,
fkOficina int not null
);

create table telefones (
idTelefone int primary key auto_increment,
numero varchar(20),
fkTelFuncionario int,
fkTelEmpresa int,
fkTelOficina int,
constraint fk_telFuncionario foreign key (fkTelFuncionario) references funcionarios(idFuncionario),
constraint fk_telEmpresa foreign key (fkTelEmpresa) references empresa(idEmpresa),
constraint fk_telOficina foreign key (fkTelOficina) references oficina(idOficina)
);

create table compressor (
idCompressor int primary key auto_increment,
capacidadeUmiMax dec(5,2) not null,
statuss varchar(20) not null,
fkCompOficina int not null,
constraint fk_compOficina foreign key (fkCompOficina) references oficina(idOficina),
constraint chk_statuss check (statuss in('ativo', 'inativo'))
);

create table sensor (
idSensor int primary key auto_increment,
fkcompressor int not null,
constraint fk_compressor foreign key (fkcompressor) references compressor(idCompressor)
);

create table registrosSensor (
idRegistro int primary key auto_increment,
umidadeRegistrada dec(5,2) not null,
dtHrRegistrada datetime not null,
fksensor int not null,
constraint fk_sensor foreign key (fksensor) references sensor(idSensor)
);

create table alertas (
idAlerta int primary key auto_increment,
dtHrAlerta datetime not null,
umidAlerta dec(5,2),
fkregistro int not null,
constraint fk_alerta foreign key (fkregistro) references registrosSensor(idRegistro)
);

-- Populando o banco de dados da oficina de compressores de ar (Parte de teste)

-- 1. Inserir Empresas
INSERT INTO empresa (cnpj, nomeFantasia, email) VALUES
('12345678000190', 'CompressAir Ltda', 'contato@compressair.com'),
('98765432000199', 'ArPower Serviços', 'suporte@arpower.com');

-- 2. Inserir Oficinas
INSERT INTO oficina (qtdCompressor, qtdFuncionario, fkempresa) VALUES
(3, 5, 1),
(2, 3, 2);

-- 3. Inserir Endereços (Empresas)
INSERT INTO endereco (rua, numero, cidade, cep, fkEndEmpresa) VALUES
('Rua das Indústrias', 100, 'São Paulo', '01001000', 1),
('Av. do Trabalho', 200, 'Campinas', '13013000', 2);

-- 3. Inserir Endereços (Oficinas)
INSERT INTO endereco (rua, numero, cidade, cep, fkEndOficina) VALUES
('Rua dos Compressores', 50, 'São Paulo', '01002000', 1),
('Rua da Manutenção', 80, 'Campinas', '13014000', 2);

-- 4. Inserir Funcionários
INSERT INTO funcionarios (nome, email, senha, cargo, fkOficina) VALUES
('Carlos Silva', 'carlos@compressair.com', 'senha123', 'Técnico', 1),
('Ana Souza', 'ana@compressair.com', 'senha123', 'Supervisora', 1),
('João Lima', 'joao@arpower.com', 'senha123', 'Técnico', 2);

-- 5. Inserir Telefones (Empresas)
INSERT INTO telefones (numero, fkTelEmpresa) VALUES
('(11) 1111-1111', 1),
('(19) 2222-2222', 2);

-- 5. Inserir Telefones (Oficinas)
INSERT INTO telefones (numero, fkTelOficina) VALUES
('(11) 3333-3333', 1),
('(19) 4444-4444', 2);

-- 5. Inserir Telefones (Funcionários)
INSERT INTO telefones (numero, fkTelFuncionario) VALUES
('(11) 5555-5555', 1),
('(11) 6666-6666', 2),
('(19) 7777-7777', 3);

-- 6. Inserir Compressores
INSERT INTO compressor (capacidadeUmiMax, statuss, fkCompOficina) VALUES
(75.50, 'ativo', 1),
(68.20, 'inativo', 1),
(80.00, 'ativo', 2);

-- 7. Inserir Sensores
INSERT INTO sensor (fkcompressor) VALUES
(1),
(2),
(3);

-- 8. Inserir Registros de Sensor
INSERT INTO registrosSensor (umidadeRegistrada, dtHrRegistrada, fksensor) VALUES
(70.00, '2025-04-15 08:00:00', 1),
(65.50, '2025-04-15 09:00:00', 1),
(72.00, '2025-04-15 10:00:00', 2),
(75.00, '2025-04-15 08:30:00', 3);

-- 9. Inserir Alertas
INSERT INTO alertas (dtHrAlerta, umidAlerta, fkregistro) VALUES
('2025-04-15 08:00:00', 70.00, 1),
('2025-04-15 10:00:00', 72.00, 3);

-- Teste para ver os dados na tabela
 SELECT * FROM registrosSensor;
 
 -- Limpar a tabela
ALTER TABLE alertas DROP FOREIGN KEY fk_alerta;
TRUNCATE TABLE registrosSensor;
ALTER TABLE alertas ADD CONSTRAINT fk_alerta FOREIGN KEY (fkregistro) REFERENCES registrosSensor(idRegistro);
SELECT * FROM registrosSensor;
