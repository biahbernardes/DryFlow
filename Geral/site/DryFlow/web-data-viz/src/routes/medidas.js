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

router.get("/alertas", function (req, res) {
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

module.exports = router;
