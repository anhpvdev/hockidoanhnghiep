require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
const checkauth = require("../Middleware/checkuser");
const checkbuyer = require("../Middleware/checkbuyer");
const BuyerModel = require("../Model/buyer")

const BuyerRoutes = (app) => {
  router.get('/profile',checkauth,BuyerModel.profile)
  router.get('/cart',checkauth,BuyerModel.cart)

  // router.post('/buy',checkbuyer,BuyerModel.buy)

  return app.use("/buyer", router)
}
module.exports = BuyerRoutes

