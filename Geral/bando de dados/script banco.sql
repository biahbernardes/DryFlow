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
umidaedRegistrada dec(5,2) not null,
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

