var database = require("../database/config");

function buscarUltimasMedidas() {
  const instrucaoSql = `
    SELECT 
      c.modelo, 
      c.idCompressor,
      rs.umidadeRegistrada, 
      rs.dtHrRegistrada
    FROM compressor c
    JOIN sensor s ON s.fkCompressor = c.idCompressor
    JOIN registroSensor rs ON rs.fkSensor = s.idSensor
    WHERE rs.idRegistro = (
      SELECT MAX(rs2.idRegistro)
      FROM sensor s2
      JOIN registroSensor rs2 ON rs2.fkSensor = s2.idSensor
      WHERE s2.fkCompressor = c.idCompressor
    )
    ORDER BY rs.dtHrRegistrada DESC;
  `;
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

function alertas(oficinaDaSessao) {
  const instrucaoSql = `
        SELECT c.modelo, rs.umidadeRegistrada, DATE_FORMAT(rs.dtHrRegistrada, "Data: %Y-%m-%d | Horario: %H:%i:%s") as dtHrRegistrada
        FROM sensor s
        INNER JOIN registroSensor rs ON s.fkCompressor = rs.fkSensor
        INNER JOIN compressor c ON c.idcompressor = s.fkCompressor
        WHERE c.fkOficina = ${oficinaDaSessao}
        AND (TIME(rs.dtHrRegistrada) LIKE ("%%:%5:00") OR TIME(rs.dtHrRegistrada) LIKE ("%%:%0:00"))
        ORDER BY rs.dtHrRegistrada;
    `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarMedidas24Horas(idAquario) {
  const instrucaoSql = `
        SELECT COUNT(registroSensor.umidadeRegistrada) AS "Quantidade_Passou_50" FROM registroSensor 
        INNER JOIN sensor ON registroSensor.fkSensor = sensor.idSensor
        INNER JOIN compressor ON sensor.fkCompressor = compressor.idCompressor
        WHERE umidadeRegistrada > 50 
        AND DATE(registroSensor.dtHrRegistrada) = CURDATE() 
        AND sensor.fkCompressor = ${idAquario}
        AND TIME(registroSensor.dtHrRegistrada) LIKE ("%%:%%:00")

    `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function horarioInicioUmidade50Hoje(idAquario) {
  const instrucaoSql = `
        SELECT MIN(TIME(dtHrRegistrada)) AS "HorarioHoje_Inicio_umidadeMaior50" FROM registroSensor
        INNER JOIN sensor ON registroSensor.fkSensor = sensor.idSensor
        INNER JOIN compressor ON sensor.fkCompressor = compressor.idCompressor
        WHERE umidadeRegistrada > 50 AND DATE(registroSensor.dtHrRegistrada) = CURDATE() AND sensor.fkCompressor = ${idAquario}

    `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarMedidasEsteMes(idAquario) {
  const instrucaoSql = `
        SELECT  COUNT(registroSensor.umidadeRegistrada) AS "Quantidade_Passou_50_Mes" FROM registroSensor 
        INNER JOIN sensor ON registroSensor.fkSensor = sensor.idSensor
        INNER JOIN compressor ON sensor.fkCompressor = compressor.idCompressor
        WHERE umidadeRegistrada > 50 
        AND MONTH(registroSensor.dtHrRegistrada) = MONTH(CURDATE()) 
        AND YEAR(registroSensor.dtHrRegistrada) = YEAR(CURDATE())
        AND sensor.fkCompressor = ${idAquario}
        AND TIME(registroSensor.dtHrRegistrada) LIKE ("%%:%%:00")

    `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}
/* OBS: Essa função alterei a parte  rs.dtHrRegistrada de "currente date time" para rs.dtHrRegistrada = '2025-06-11 09:00:00' para facilitar na hora da apresentação*/
/* WHERE rs.dtHrRegistrada = (SELECT MAX(dtHrRegistrada) FROM registroSensor) (Na verdade tem que ser esse, mas fazer registro fixo para apresentação) */
function ultimasTodosCompressoresUmidadeMaior(idOficina) {
  const instrucaoSql = `
        SELECT c.modelo, rs.umidadeRegistrada, rs.dtHrRegistrada
        FROM compressor c
        INNER JOIN sensor s ON c.idCompressor = s.fkCompressor
        INNER JOIN registroSensor rs ON rs.fkSensor = s.idSensor
        WHERE rs.dtHrRegistrada = '2025-06-11 09:00:00'
        AND c.fkOficina = ${idOficina}
        GROUP BY c.idCompressor, c.modelo, rs.umidadeRegistrada, rs.dtHrRegistrada
        ORDER BY rs.umidadeRegistrada DESC
        LIMIT 5

    `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function ultimasCompressoresOficina(idOficina) {
  const instrucaoSql = `
    SELECT 
      c.modelo, 
      c.idCompressor,
      rs.umidadeRegistrada, 
      rs.dtHrRegistrada
    FROM compressor c
    JOIN sensor s ON s.fkCompressor = c.idCompressor
    JOIN registroSensor rs ON rs.fkSensor = s.idSensor
    WHERE rs.idRegistro = (
      SELECT MAX(rs2.idRegistro)
      FROM sensor s2
      JOIN registroSensor rs2 ON rs2.fkSensor = s2.idSensor
      WHERE s2.fkCompressor = c.idCompressor
    )
    AND c.fkOficina = ${idOficina}
    ORDER BY rs.dtHrRegistrada DESC;
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarMedidas24HorasLinha(compressorEspecifico) {
  const instrucaoSql = `
        SELECT 
        umidadeRegistrada as umidade,
        DATE_FORMAT(dtHrRegistrada,'%H:%i:%s') as momento_grafico, 
        fkSensor 
        FROM registroSensor rs
        INNER JOIN sensor s ON rs.fkSensor = s.idSensor
        INNER JOIN compressor c ON s.fkCompressor = c.idCompressor
        WHERE idCompressor = ${compressorEspecifico}
        AND DATE_FORMAT(dtHrRegistrada,'%H:%i:%s') LIKE ('%%:00:00')
        ORDER BY idRegistro DESC 
        LIMIT 24;

    `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function nomeOficinaUsuario(idOficinaDoUsuario) {
  const instrucaoSql = `
       SELECT nomeOficina FROM oficina WHERE idOficina = ${idOficinaDoUsuario}

    `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function modeloCompressorSelecionado(idCompressorSelecionado) {
  const instrucaoSql = `
       SELECT modelo FROM compressor WHERE idCompressor = ${idCompressorSelecionado}

    `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}
module.exports = {
  buscarUltimasMedidas,
  buscarMedidasEmTempoReal,
  alertas,
  buscarMedidas24Horas,
  horarioInicioUmidade50Hoje,
  buscarMedidasEsteMes,
  ultimasTodosCompressoresUmidadeMaior,
  ultimasCompressoresOficina,
  buscarMedidas24HorasLinha,
  nomeOficinaUsuario,
  modeloCompressorSelecionado
};
