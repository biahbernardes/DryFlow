var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM oficina WHERE idOficina = '${id}'`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT idOficina, nomeOficina, codigo_ativacao FROM oficina`;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpj}'`;

  return database.executar(instrucaoSql);
}

function cadastrar(nomeFantasia, cnpj) {
  var instrucaoSql = `INSERT INTO empresa (nomeFantasia, cnpj) VALUES ('${nomeFantasia}', '${cnpj}')`;

  return database.executar(instrucaoSql);
}

module.exports = { buscarPorCnpj, buscarPorId, cadastrar, listar };
