var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {
  /* var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`; */
  var instrucaoSql = `SELECT  
        umidadeRegistrada as umidade,
        dtHrRegistrada,
                        DATE_FORMAT(dtHrRegistrada,'%H:%i:%s') as momento_grafico
                    FROM registroSensor
                    WHERE fkSensor = ${idAquario}
                    ORDER BY idRegistro DESC LIMIT ${limite_linhas}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {
  /*     var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        FROM medida WHERE fk_aquario = ${idAquario} 
                    ORDER BY id DESC LIMIT 1`; */
  var instrucaoSql = `SELECT 
        umidadeRegistrada as umidade,
                        DATE_FORMAT(dtHrRegistrada,'%H:%i:%s') as momento_grafico, 
                        fkSensor 
                        FROM registroSensor WHERE fkSensor = ${idAquario} 
                    ORDER BY idRegistro DESC LIMIT 1`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarUltimasMedidas,
  buscarMedidasEmTempoReal,
};
