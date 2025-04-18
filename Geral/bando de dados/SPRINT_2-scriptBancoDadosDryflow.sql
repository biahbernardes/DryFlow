create database dryflow;   

use dryflow;  

-- Criação de tabelas

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
administrador int, 
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

-- Inserção de dados nas tabelas

insert into oficina(nomeOficina,oficinaMatriz) 
 values 
("SpOficina", null), 
("SpOficina Santo André", 1),  
("SpOficina Taboão da Serra", 1); 

insert into endereco(logradouro, rua, numero, cidade, cep, fkOficina)  
values
("Jardins", "Rua Europa", 755, "São Paulo", "12345678", 1),  
("Parque das Nações", "Rua Guatemala", 90, "Santo André", "87654321", 2),  
("Arraial Paulista", "Rua Maria Smid", 41, "Taboão das Serras", "96385240", 3); 

insert into funcionario(nome, email, senha, cargo, fkOficina, administrador)  
values 
("Brando", "Bran0@gmail.com", "1234567", "Gerente", 1, null),  
("Julia", "Juju@gamil.com", "654321", "Mecânico", 1, 1),  
("João Paulo", "JP@gmail.com", "sumido", "Gerente", 2, null),  
("Manoel", "Mano3l@gmail.com", "hello_world","Ajudante", 2, 3),  
("Rossim", "Ross@gmail.com", "o_banco_nunca_erra","Gerente", 3, null),  
("Isabela", "B3l4@gmail.com", "0021321", "Estagiario", 3, 5); 

insert into telefone(numero, fkTelFuncionario, fkTelOficina) 
values("119654158542", null, 2), 
("11964864561052", 1, null), 
("11964653414545", null, 3), 
("11987846465452", 4, null); 

insert into compressor(modelo, capacidadeUmiMax, statusCompressor, fkOficina) values
("Schuz", 60, "Umidade baixa", 2), 
("Chiaperini", 55, "Umidade media", 1),
("Motomil", 50, "Umidade alta" ,3); 

insert into sensor(fkCompressor) values (1), (2), (3); 

-- Testes

SELECT * FROM oficina;
SELECT * FROM endereco;
SELECT * FROM funcionario;
SELECT * FROM telefone;
SELECT * FROM compressor;
SELECT * FROM sensor;
SELECT * FROM registro_sensor;
SELECT * FROM telefone;
 