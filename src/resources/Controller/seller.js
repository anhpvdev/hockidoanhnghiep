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
    router.get('/addproduct',checkauth.seller,SellerModel.get_addproduct)
    router.post('/add_product',checkauth.seller,SellerModel.post_addproduct)

    router.post('/typeproduct',checkauth.seller,SellerModel.typeproduct)
    return app.use("/seller", router)
}
module.exports = BuyerRoutes

