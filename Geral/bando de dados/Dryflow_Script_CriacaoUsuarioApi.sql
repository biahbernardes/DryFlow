CREATE USER 'apiOficina1'@'%' IDENTIFIED BY 'Dry#2025';

DROP USER apiOficina1;

-- Comando abaixo só funciona no usuário root
GRANT INSERT ON dryflow.registro_sensor TO apiOficina1;

SELECT user FROM mysql.user;