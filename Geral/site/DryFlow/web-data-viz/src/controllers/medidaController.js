var medidaModel = require("../models/medidaModel");

function buscarUltimasMedidas(req, res) {
  // const limite_linhas = 7;

  // var idAquario = req.params.idAquario;

  // console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

  medidaModel
    .buscarUltimasMedidas()
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as ultimas medidas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function buscarMedidasEmTempoReal(req, res) {
  var idAquario = req.params.idAquario;

  console.log(`Recuperando medidas em tempo real`);

  medidaModel
    .buscarMedidasEmTempoReal(idAquario)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as ultimas medidas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function alertas(req, res) {
  medidaModel
    .alertas()
    .then((resultado) => res.json(resultado))
    .catch((erro) => {
      console.log("Erro ao alertas:", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
    });
}

function buscarMedidas24Horas(req, res) {
  // const limite_linhas = 7;

  var idAquario = req.params.idAquario;

  // console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

  medidaModel
    .buscarMedidas24Horas(idAquario)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as ultimas medidas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function horarioInicioUmidade50Hoje(req, res) {
  // const limite_linhas = 7;

  var idAquario = req.params.idAquario;

  // console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

  medidaModel
    .horarioInicioUmidade50Hoje(idAquario)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as ultimas medidas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function buscarMedidasEsteMes(req, res) {
  // const limite_linhas = 7;

  var idAquario = req.params.idAquario;

  // console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

  medidaModel
    .buscarMedidasEsteMes(idAquario)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as ultimas medidas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function ultimasTodosCompressoresUmidadeMaior(req, res) {
  // const limite_linhas = 7;

  // var idAquario = req.params.idAquario;

  // console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

  medidaModel
    .ultimasTodosCompressoresUmidadeMaior()
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as ultimas medidas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
  buscarUltimasMedidas,
  buscarMedidasEmTempoReal,
  alertas,
  buscarMedidas24Horas,
  horarioInicioUmidade50Hoje,
  buscarMedidasEsteMes,
  ultimasTodosCompressoresUmidadeMaior,
};
