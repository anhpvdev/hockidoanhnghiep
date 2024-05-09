require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
const checkauth = require("../Middleware/checkuser");
const SellerModel = require("../Model/seller")

const BuyerRoutes = (app) => {
    router.get('/',checkauth.seller,SellerModel.home)
    router.get('/login',checkauth.seller,SellerModel.get_login)
    router.post('/login',checkauth.seller,SellerModel.post_login)
    return app.use("/seller", router)
}
module.exports = BuyerRoutes

