require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
const checkauth = require("../Middleware/checkuser");
const UserModel = require("../Model/user")


const userRoutes = (app) => {
  router.get('/',checkauth.auth,UserModel.home)
  router.get('/products',checkauth.auth,UserModel.products)
  router.get('/products/:id',checkauth.auth,UserModel.products_detail)
  router.get('/products/type/:id',checkauth.auth,UserModel.products_type)
  router.post('/seach',checkauth.auth,UserModel.seach)
  router.post('/sortseach',checkauth.auth,UserModel.sortseach)
  router.post('/longseach',checkauth.auth,UserModel.longseach)

  router.get('/registry',UserModel.get_registry)
  router.post('/registry',UserModel.post_registry)
  router.post('/Check_otp',UserModel.Check_otp)

  router.get('/login',UserModel.get_login)
  router.post('/login',UserModel.post_login)
  router.get('/logout',UserModel.logout)
  router.get('/repassword',UserModel.get_repassword)
  router.post('/repassword',UserModel.post_repassword)
  router.get('/404',checkauth.auth,UserModel.error)

  
  return app.use("/", router)
}
module.exports = userRoutes

