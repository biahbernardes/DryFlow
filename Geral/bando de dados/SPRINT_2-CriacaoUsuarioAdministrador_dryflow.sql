CREATE USER 'administrador'@'%' IDENTIFIED BY 'Dry#2025';

DROP USER administrador;

-- Comando abaixo só funciona no usuário root
GRANT INSERT ON dryflow.registrosSensor TO administrador;

SELECT user FROM mysql.user;