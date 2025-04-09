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
logradouro varchar(45) not null,
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
statusCompressor varchar(20) not null,
fkCompOficina int not null,
constraint fk_compOficina foreign key (fkCompOficina) references oficina(idOficina),
constraint chk_status check (statusCompressor in('ativo', 'inativo'))
);

create table sensor (
idSensor int primary key auto_increment,
fkcompressor int not null,
constraint fk_compressor foreign key (fkcompressor) references compressor(idCompressor)
);

create table registrossensor (
idRegistro int primary key auto_increment,
umidadeRegistrada int not null,
dtHrRegistrada datetime not null,
fksensor int not null,
constraint fk_sensor foreign key (fksensor) references sensor(idSensor)
);

create table alertas (
idAlerta int primary key auto_increment,
dtHrAlerta datetime not null,
umidAlerta int,
fkalerta int not null,
constraint fk_alerta foreign key (fkalerta) references registrossensor(idRegistro)
);

-- Inserir Empresas
insert into empresa (cnpj, nomeFantasia, email) values
('12345678000195', 'Empresa A', 'contato@empresaA.com'),
('98765432000198', 'Empresa B', 'contato@empresaB.com'),
('11122233000181', 'Empresa C', 'contato@empresaC.com'),
('22233344000102', 'Empresa D', 'contato@empresaD.com');

-- Inserir Oficinas
insert into oficina (qtdCompressor, qtdFuncionario, fkempresa) values
(10, 5, 1), 
(15, 7, 2), 
(20, 9, 3),
(12, 6, 4);

-- Inserir Endereços para Empresas (sem associar à oficina)
insert into endereco (logradouro, rua, numero, cidade, cep, fkEndOficina, fkEndEmpresa) values
('Rua das Flores', 'Av. Central', 100, 'São Paulo', '01001000', NULL, 1), 
('Rua do Sol', 'Av. Paulista', 200, 'São Paulo', '01002000', NULL, 2),
('Rua das Palmeiras', 'Rua das Flores', 300, 'Rio de Janeiro', '20001000', NULL, 3),
('Rua das Árvores', 'Rua das Pedras', 400, 'Belo Horizonte', '30001000', NULL, 4);

-- Inserir Endereços para Oficinas (sem associar à empresa)
insert into endereco (logradouro, rua, numero, cidade, cep, fkEndOficina, fkEndEmpresa) values
('Rua das Laranjeiras', 'Av. Tropical', 101, 'São Paulo', '01001001', 1, NULL),
('Rua do Mar', 'Rua do Sol', 202, 'São Paulo', '01002001', 2, NULL),
('Rua dos Ventos', 'Rua das Flores', 303, 'Rio de Janeiro', '20001001', 3, NULL),
('Rua do Campo', 'Rua das Pedras', 404, 'Belo Horizonte', '30001001', 4, NULL);

-- Inserir Funcionários
insert into funcionarios (nome, email, senha, cargo, fkOficina) values
('João Silva', 'joao@empresaA.com', 'senha123', 'Técnico', 1),
('Maria Oliveira', 'maria@empresaB.com', 'senha123', 'Gerente', 2),
('Carlos Souza', 'carlos@empresaC.com', 'senha123', 'Supervisor', 3),
('Ana Costa', 'ana@empresaD.com', 'senha123', 'Técnico', 4);

-- Inserir Telefones
insert into telefones (numero, fkTelFuncionario, fkTelEmpresa, fkTelOficina) values
('1112345678', 1, NULL, NULL), 
('11987654321', 2, NULL, NULL),
('21387654321', 3, NULL, NULL),
('31987654321', 4, NULL, NULL),
('1123456789', NULL, 1, NULL), 
('1122334455', NULL, 2, NULL),
('2133445566', NULL, 3, NULL),
('3198877665', NULL, 4, NULL),
('1198887777', NULL, NULL, 1),
('2133222333', NULL, NULL, 2),
('3199988777', NULL, NULL, 3),
('2199999888', NULL, NULL, 4);

-- Inserir Compressores
insert into compressor (capacidadeUmiMax, statusCompressor, fkCompOficina) values
(60.00, 'ativo', 1),
(75.00, 'ativo', 2),
(50.00, 'inativo', 3),
(80.00, 'ativo', 4);

-- Inserir Sensores
insert into sensor (fkcompressor) values
(1),
(2),
(3),
(4);

-- Inserir Registros de Sensor
insert into registrosSensor (umidaedRegistrada, dtHrRegistrada, fksensor) values
(55, '2025-04-07 08:00:00', 1),
(80, '2025-04-07 09:00:00', 2),
(40, '2025-04-07 10:00:00', 3),
(85, '2025-04-07 11:00:00', 4);

-- Inserir Alertas
insert into alertas (dtHrAlerta, umidAlerta, fkalerta) values 
('2025-04-07 12:30:00', 80, 2),
('2025-04-07 13:30:00', 85, 4);
