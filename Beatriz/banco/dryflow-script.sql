CREATE DATABASE DryFlow;
USE DryFlow;

CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY,
    logradouro VARCHAR(100),
    cidade VARCHAR(45)
);

CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY,
    nome_empresa VARCHAR(100),
    cnpj CHAR(18),
    idEndereco INT,
    FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
);

CREATE TABLE Oficina (
    idOficina INT PRIMARY KEY,
    nome VARCHAR(100),
    idEmpresa INT,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(40),
    telefone CHAR(15),
    idEmpresa INT,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY,
    status ENUM('Online', 'Offline')
);

CREATE TABLE Compressor (
    idCompressor INT PRIMARY KEY,
    status ENUM('Ativo', 'Inativo'),
    idSensor INT,
    idOficina INT,
    FOREIGN KEY (idSensor) REFERENCES Sensor(idSensor),
    FOREIGN KEY (idOficina) REFERENCES Oficina(idOficina)
);

CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY,
    unidade DECIMAL(5,2),
    dataHora DATETIME,
    idSensor INT,
    FOREIGN KEY (idSensor) REFERENCES Sensor(idSensor)
);

CREATE TABLE Alerta (
    idAlerta INT PRIMARY KEY,
    situacao VARCHAR(80),
    dataHora DATETIME,
    idRegistro INT,
    FOREIGN KEY (idRegistro) REFERENCES Registro(idRegistro)
);

INSERT INTO Endereco VALUES
 (1, 'Rua das Flores, 123', 'São Paulo'),
 (2, 'Av. Brasil, 456', 'Rio de Janeiro');

INSERT INTO Empresa VALUES 
(1, 'DryFlow Ltda', '12.345.678/0001-90', 1),
(2, 'TechAir Solutions', '98.765.432/0001-10', 2);

INSERT INTO Oficina VALUES
 (1, 'Oficina SP', 1),
 (2, 'Oficina RJ', 2);

INSERT INTO Usuario VALUES
(1, 'Carlos Silva', 'carlos@dryflow.com', '11999990000', 1),
(2, 'Mariana Rocha', 'mariana@techair.com', '21988887777', 2);

INSERT INTO Sensor VALUES
(1, 'Online'),
(2, 'Offline');

INSERT INTO Compressor VALUES
 (1, 'Ativo', 1, 1),
 (2, 'Inativo', 2, 2);

INSERT INTO Registro VALUES
 (1, 45.67, '2025-04-20 14:30:00', 1),
 (2, 60.12, '2025-04-20 15:00:00', 2);

INSERT INTO Alerta VALUES
 (1, 'Umidade acima do ideal', '2025-04-20 14:35:00', 1),
 (2, 'Sensor offline', '2025-04-20 15:05:00', 2);

SELECT e.nome_empresa, en.logradouro, en.cidade
FROM Empresa e JOIN Endereco en ON e.idEndereco = en.idEndereco;

SELECT s.idSensor, s.status AS status_sensor, c.idCompressor, c.status AS status_compressor, o.nome AS oficina
FROM Sensor s JOIN Compressor c ON c.idSensor = s.idSensor
JOIN Oficina o ON c.idOficina = o.idOficina;

SELECT a.situacao, a.dataHora AS alerta_data, r.unidade AS umidade, r.dataHora AS registro_data, s.status AS status_sensor, emp.nome_empresa
FROM Alerta a
JOIN Registro r ON a.idRegistro = r.idRegistro
JOIN Sensor s ON r.idSensor = s.idSensor
JOIN Compressor c ON c.idSensor = s.idSensor
JOIN Oficina o ON o.idOficina = c.idOficina
JOIN Empresa emp ON emp.idEmpresa = o.idEmpresa;
