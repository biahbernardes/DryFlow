create database dryflow;  

use dryflow; 

create table oficina (  
idOficina int primary key auto_increment, 
nomeOficina varchar(45),  
oficinaMatriz int,  
foreign key (oficinaMatriz) references oficina(idOficina)  
); 

create table endereco (  
idEndereco int primary key auto_increment, 
logradouro varchar(45) not null, 
rua varchar(45) not null, 
numero int not null, 
cidade varchar(45) not null,  
cep char(8) not null, 
fkOficina int, 
constraint fk_Oficina foreign key (fkOficina) references oficina(idOficina)  
); 

create table funcionario (  
idFuncionario int primary key auto_increment,  
nome varchar(45) not null, 
email varchar(45) not null, 
senha varchar(45) not null,  
cargo varchar(45) not null, 
fkOficina int not null, 
administrador int ,
constraint fk_OficinaFunc foreign key (fkOficina) references oficina(idOficina),
constraint fk_AdmFunc foreign key (administrador) references funcionario(idFuncionario)
 ); 

create table telefone (  
idTelefone int primary key auto_increment, 
numero varchar(20), 
fkTelFuncionario int, 
fkTelOficina int, 
constraint fk_telFuncionario foreign key (fkTelFuncionario) references funcionario(idFuncionario),
constraint fk_telOficina foreign key (fkTelOficina) references oficina(idOficina)  
); 

create table compressor(  
idCompressor INT primary key auto_increment,  
modelo varchar(45), 
capacidadeUmiMax int,  
statusCompressor varchar(20), 
fkOficina int not null,  
constraint fk_oficinaCompressor foreign key (fkOficina) references oficina(idOficina)  
); 

create table sensor(  
idSensor int auto_increment primary key,  
fkCompressor int not null, 
constraint fk_compressor foreign key(fkCompressor) references compressor(idCompressor) 
 ); 

create table registro_sensor( 
idRegistro int auto_increment primary key,  
umidadeRegistrada int, 
dtHrRegistrada datetime,  
fkSensor int not null, 
constraint fk_sensor foreign key(fkSensor) references sensor(idSensor) 
 ); 

/*
create table alerta(  
idAlerta int auto_increment primary key,  
dtHrAlerta datetime, 
umidAlerta int, 
fkRegistro int not null, 
constraint fk_registro foreign key(fkRegistro) references registro_sensor(idRegistro) 
 ); 
*/




 