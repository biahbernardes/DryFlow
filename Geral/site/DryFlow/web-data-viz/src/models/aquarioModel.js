var database = require("../database/config");

/* Imaginando  */
function buscarAquariosPorEmpresa(oficinaId) {
  var instrucaoSql = `SELECT * FROM compressor a WHERE fkOficina = ${oficinaId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) aquario VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarAquariosPorEmpresa,
  cadastrar,
};
