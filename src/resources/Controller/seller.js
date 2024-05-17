require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
const checkauth = require("../Middleware/checkuser");
const SellerModel = require("../Model/seller")
const Productupload = require("../Middleware/Uploads/product");
const BuyerRoutes = (app) => {
    router.get('/',checkauth.seller,SellerModel.home)
    router.get('/login',checkauth.seller,SellerModel.get_login)
    router.post('/login',checkauth.seller,SellerModel.post_login)
    router.get('/addproduct',checkauth.seller,SellerModel.get_addproduct)
    router.get('/profile',checkauth.seller,SellerModel.get_profile)
    router.post('/profile',checkauth.seller,SellerModel.post_profile)
    router.post('/add_product',checkauth.seller,SellerModel.post_addproduct)
    router.post('/addimageproduct',checkauth.seller,Productupload.array("product_img"),SellerModel.imageproduct)
    router.post('/typeproduct',checkauth.seller,SellerModel.typeproduct)



    router.get('/purchase',checkauth.seller,SellerModel.purchase)
    router.get('/purchase/:id',checkauth.seller,SellerModel.detail_purchase)
    router.post('/purchase/acp',checkauth.seller,SellerModel.acp_purchase)

    //thống kê
    router.get('/profit',checkauth.seller,SellerModel.profit)
    router.post('/profit/month',checkauth.seller,SellerModel.profit_month)
    return app.use("/seller", router)
}
module.exports = BuyerRoutes

