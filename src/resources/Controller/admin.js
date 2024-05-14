require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
// const checkauth = require("../Middleware/checkuser");
const checkadmin = require("../Middleware/checkadmin");
const AdminModel = require("../Model/admin")

const BuyerRoutes = (app) => {
    router.get('/',checkadmin.any,AdminModel.home)
    router.get('/listadmin',checkadmin.Admin,AdminModel.listadmin)
    router.get('/listadmin/:id',checkadmin.Admin,AdminModel.admin_detail)

    router.get('/addadmin',checkadmin.Admin,AdminModel.get_addadmin)
    router.post('/addadmin',checkadmin.Admin,AdminModel.post_addadmin)
    // router.get('/listadmin',checkadmin.any,AdminModel.home)
    // router.get('/category',checkadmin.any,AdminModel.home)
    router.get('/seller',checkadmin.Admin3,AdminModel.seller)
    router.get('/seller/regis',checkadmin.Admin3,AdminModel.seller_add)
    router.post('/seller/regis',checkadmin.Admin3,AdminModel.post_seller_add)
    router.get('/seller/regis/:id',checkadmin.Admin3,AdminModel.seller_detail)
    router.get('/category',checkadmin.Admin2,AdminModel.get_category)
    router.get('/category/:id',checkadmin.Admin2,AdminModel.get_dcategory)
    router.post('/category',checkadmin.Admin2,AdminModel.post_category)
    router.post('/category/type1',checkadmin.Admin2,AdminModel.post_category_type1)
    router.post('/category/type2',checkadmin.Admin2,AdminModel.post_category_type2)
    router.post('/category/type/add',checkadmin.Admin2,AdminModel.add_c_category)
    router.post('/category/add',checkadmin.Admin2,AdminModel.add_category)
    router.post('/category/dell1',checkadmin.Admin2,AdminModel.dell_category1)
    router.post('/category/dell2',checkadmin.Admin2,AdminModel.dell_category2)
   
    router.get('/login',AdminModel.get_login)
    router.post('/login',AdminModel.post_login)


    router.get('/404',checkadmin.any,AdminModel.admute)
    return app.use("/admin", router)
}
module.exports = BuyerRoutes

