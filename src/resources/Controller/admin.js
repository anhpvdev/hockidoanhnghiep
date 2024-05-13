require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
// const checkauth = require("../Middleware/checkuser");
const checkadmin = require("../Middleware/checkadmin");
const AdminModel = require("../Model/admin")

const BuyerRoutes = (app) => {
    router.get('/',checkadmin.any,AdminModel.home)
    // router.get('/listadmin',checkadmin.any,AdminModel.home)
    // router.get('/listadmin',checkadmin.any,AdminModel.home)
    // router.get('/category',checkadmin.any,AdminModel.home)
    router.get('/seller',checkadmin.Admin3,AdminModel.seller)
    router.get('/seller/regis',checkadmin.Admin3,AdminModel.seller_add)
    router.post('/seller/regis',checkadmin.Admin3,AdminModel.post_seller_add)
    router.get('/seller/regis/:id',checkadmin.Admin3,AdminModel.seller_detail)
    
    
    
    router.get('/login',AdminModel.get_login)
    router.post('/login',AdminModel.post_login)


    router.get('/404',checkadmin.any,AdminModel.admute)
    return app.use("/admin", router)
}
module.exports = BuyerRoutes

