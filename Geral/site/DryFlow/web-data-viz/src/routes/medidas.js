var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas", medidaController.buscarUltimasMedidas);

router.get("/ultimas/:idAquario", function (req, res) {
  medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idAquario", function (req, res) {
  medidaController.buscarMedidasEmTempoReal(req, res);
});

router.get("/alertas/:oficinaDaSessao", function (req, res) {
  medidaController.alertas(req, res);
});

router.get("/ultimas24Horas/:idAquario", function (req, res) {
  medidaController.buscarMedidas24Horas(req, res);
});

router.get("/horarioInicioUmidade50Hoje/:idAquario", function (req, res) {
  medidaController.horarioInicioUmidade50Hoje(req, res);
});

router.get("/ultimoMes/:idAquario", function (req, res) {
  medidaController.buscarMedidasEsteMes(req, res);
});

router.get(
  "/ultimasTodosCompressoresUmidadeMaior/:oficinaDoUsuario",
  function (req, res) {
    medidaController.ultimasTodosCompressoresUmidadeMaior(req, res);
  }
);

router.get(
  "/ultimasCompressoresOficina/:oficinaDoUsuario",
  function (req, res) {
    medidaController.ultimasCompressoresOficina(req, res);
  }
);

router.get("/ultimas24HorasLinha/:compressorEspecifico", function (req, res) {
  medidaController.buscarMedidas24HorasLinha(req, res);
});

router.get("/nomeOficinaUsuario/:oficinaDoUsuarioTitulo", function (req, res) {
  medidaController.nomeOficinaUsuario(req, res);
});

module.exports = router;
