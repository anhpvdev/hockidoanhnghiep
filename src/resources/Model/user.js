const path = require('path')
// const { HOST, USER, PASSWORD, DATABASE } = require("dotenv").config()["parsed"]
// const mysql = require("mysql");
const connection = require('../../config/connect_db')



const UserServices = {
    home: async (req, res) => {
        connection.query('select * from buyers',(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            else {
                console.log(row)
                var name = "phan huu viet anh"
                return res.render(path.join(__dirname+"../../views/Users/home.ejs"),{data:row,name:name})
            }
        })
    },
    products:async (req, res) => {
        connection.query('select * from products',(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            else {
                console.log(row)
                var name = "phan huu viet anh"
                return res.render(path.join(__dirname+"../../views/Users/products.ejs"),{data:row,name:name})
            }
        })
    },

    products_detail:async (req, res) => {
        console.log(req.params.id)
        connection.query('select * from products where product_id = ?',[req.params.id],(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            else {
                console.log(row[0])
                var name = "chi tiet san pham"
                return res.render(path.join(__dirname+"../../views/Users/products_detal.ejs"),{data:row[0],name:name})
            }

        })
    },
    seach:async (req, res) => {
        var content =req.body.content
        return res.render(path.join(__dirname+"../../views/Users/seach.ejs"),{content:content})
    },
    addcart: async (req, res) => {
        return res.sendFile(__dirname+"../../views/Users/home.html")
    }
}

module.exports = UserServices