require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')

const AdressModel = require("../Model/adress.js")


const AdressRoutes  = (app) => {
  router.post('/city',AdressModel.city)
  router.post('/district',AdressModel.district)
  
  return app.use("/adress", router)
}
module.exports = AdressRoutes

