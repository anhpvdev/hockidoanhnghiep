require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
const checkauth = require("../Middleware/checkuser");
const Payment = require("../Model/payment")




const PayRoutes = (app) => {
  router.get('/home',Payment.home)
  router.post('/test',Payment.test)
  return app.use("/pay", router)
}
module.exports = PayRoutes

