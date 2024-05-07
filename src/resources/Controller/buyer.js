require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
const checkauth = require("../Middleware/checkuser");
const BuyerModel = require("../Model/buyer")

const BuyerRoutes = (app) => {
  router.get('/profile',checkauth.buyer,BuyerModel.profile)
  router.get('/cart',checkauth.buyer,BuyerModel.cart)

  router.post('/buy',checkauth.buyer,BuyerModel.buy)

  router.get('/seller',checkauth.buyer,BuyerModel.get_seller)
  router.post('/seller',checkauth.buyer,BuyerModel.post_seller)
  return app.use("/buyer", router)
}
module.exports = BuyerRoutes

