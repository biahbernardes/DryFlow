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
codigo_ativacao varchar(45),
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
fkOficina int not null,
constraint fk_funcOficina foreign key (fkOficina) references oficina(idOficina)
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

/*
-- Inserir Alertas (Comentei para não usarmos ela)
insert into alerta (dtHrAlerta, umidAlerta, fkAlerta) values 
('2025-04-07 12:30:00', 80, 2),
('2025-04-07 13:30:00', 85, 4);
*/
