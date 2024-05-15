require("dotenv").config();
const PORT = process.env.PORT || 5000
const express = require('express')
const cookieParser = require('cookie-parser');
const app = express()
app.use(cookieParser());

// app.set('view engine', 'ejs');
// app.set('views', './resources/views')
// config
const config = require("./config/config")
config(app)

// routes
const UserRoutes = require("./resources/Controller/user")
UserRoutes(app)
const BuyerRoutes = require("./resources/Controller/buyer")
BuyerRoutes(app)

const AdminRoutes = require("./resources/Controller/admin")
AdminRoutes(app)

const SellerRoutes = require("./resources/Controller/seller")
SellerRoutes(app)

const AdressRoutes = require("./resources/Controller/adress")
AdressRoutes(app)

const PayRoutes = require("./resources/Controller/payment")
PayRoutes(app)

app.listen(PORT, () => console.log(`server is running on port http://localhost:${PORT}`))
