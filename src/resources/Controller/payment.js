require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
const checkauth = require("../Middleware/checkuser");
const Payment = require("../Model/payment")




const PayRoutes = (app) => {
  router.get('/home',checkauth.buyer,Payment.home)
  router.post('/payment',Payment.payment)
  router.post('/test',Payment.test)
  return app.use("/pay", router)
}
module.exports = PayRoutes

