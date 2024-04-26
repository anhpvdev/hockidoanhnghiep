require("dotenv").config()
const express = require("express");
const router = express.Router();
const path = require('path')

const UserModel = require("../Model/user")


const userRoutes = (app) => {
  router.get('/',UserModel.home)
  router.get('/products',UserModel.products)
  router.get('/products/:id',UserModel.products_detail)
  router.post('/seach',UserModel.seach)
  // router.get('/products',(req, res) => { res.sendFile(path.join(__dirname+"../../views/Users/products.html")) })
  // router.get('/products/detail',(req, res) => { res.sendFile(path.join(__dirname+"../../views/Users/products.html")) })
  // router.get('/login/',(req, res) => { res.sendFile(path.join(__dirname+"../../views/Users/login.html")) })
  // router.get('/registry/',(req, res) => { res.sendFile(path.join(__dirname+"../../views/Users/registry.html")) })

  router.get('/registry',UserModel.view_registry)
  router.post('/registry',UserModel.registry)
  router.post('/test',UserModel.test)
  return app.use("/", router)
}
module.exports = userRoutes

