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
nomeOficina varchar(45) not null,
fkEmpresa int not null,
constraint fk_empresa foreign key (fkEmpresa) references empresa(idEmpresa)
);

create table endereco (
idEndereco int primary key auto_increment,
rua varchar(45) not null,
numero int not null,
cidade varchar(45) not null,
bairro varchar(45) not null,
estado varchar(45) not null,
cep char(8) not null,
fkEndOficina int UNIQUE,
fkEndEmpresa int UNIQUE,
constraint fk_endOficina foreign key (fkEndOficina) references oficina(idOficina),
constraint fk_endEmpresa foreign key (fkEndEmpresa) references empresa(idEmpresa)
);

create table funcionario (
idFuncionario int primary key auto_increment,
nome varchar(45) not null,
email varchar(45) not null,
senha varchar(45) not null,
cargo varchar(45) not null,
fkOficina int not null
);

create table telefone (
idTelefone int primary key auto_increment,
numero varchar(20),
fkTelFuncionario int,
fkTelEmpresa int,
fkTelOficina int,
constraint fk_telFuncionario foreign key (fkTelFuncionario) references funcionario(idFuncionario),
constraint fk_telEmpresa foreign key (fkTelEmpresa) references empresa(idEmpresa),
constraint fk_telOficina foreign key (fkTelOficina) references oficina(idOficina)
);

create table compressor (
idCompressor int primary key auto_increment,
modelo varchar(45) not null,
capacidadeUmiMax int not null,
status varchar(20) not null,
fkOficina int not null,
constraint fk_compOficina foreign key (fkOficina) references oficina(idOficina),
constraint chk_status check (status in('ativo', 'inativo'))
);

create table sensor (
idSensor int primary key auto_increment,
fkCompressor int not null,
constraint fk_compressor foreign key (fkCompressor) references compressor(idCompressor)
);

create table registroSensor (
idRegistro int primary key auto_increment,
umidadeRegistrada int not null,
dtHrRegistrada datetime not null,
fkSensor int not null,
constraint fk_sensor foreign key (fkSensor) references sensor(idSensor)
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
insert into oficina (nomeOficina, fkEmpresa) values
('Oficina A', 1), 
('Oficina B', 2), 
('Oficina C', 3),
('Oficina D', 4),
('Oficina E', 1);

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
('Modelo E', 87, 'ativo', 5);

-- Inserir Sensores
insert into sensor (fkCompressor) values
(1),
(2),
(3),
(4),
(5);

-- Inserir Registros de Sensor
insert into registroSensor (umidadeRegistrada, dtHrRegistrada, fkSensor) values
(55, '2025-04-07 08:00:00', 1),
(60, '2025-04-07 09:00:00', 1),
(64, '2025-04-07 10:00:00', 1),
(80, '2025-04-07 09:00:00', 2),
(40, '2025-04-07 10:00:00', 3),
(85, '2025-04-07 11:00:00', 4),
(88, '2025-04-07 12:00:00', 5);

/*
-- Inserir Alertas (Comentei para não usarmos ela)
insert into alerta (dtHrAlerta, umidAlerta, fkAlerta) values 
('2025-04-07 12:30:00', 80, 2),
('2025-04-07 13:30:00', 85, 4);
*/
