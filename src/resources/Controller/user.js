require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')
const checkauth = require("../Middleware/checkuser");
const UserModel = require("../Model/user")


const userRoutes = (app) => {
  router.get('/',checkauth,UserModel.home)
  router.get('/products',UserModel.products)
  router.get('/products/:id',UserModel.products_detail)
  router.post('/seach',UserModel.seach)


  router.get('/registry',UserModel.get_registry)
  router.post('/registry',UserModel.post_registry)
  router.post('/Check_otp',UserModel.Check_otp)

  router.get('/login',UserModel.get_login)
  router.post('/login',UserModel.post_login)
  router.get('/logout',UserModel.logout)
  router.get('/repassword',UserModel.get_repassword)
  router.post('/repassword',UserModel.post_repassword)
  return app.use("/", router)
}
module.exports = userRoutes

