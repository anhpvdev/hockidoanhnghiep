const path = require('path')
const connection = require('../../config/connect_db')
const randomeCode = Math.floor(Math.random() * 9000) + 1000

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
                var name = "all san pham"
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
    },
    get_registry: async (req, res) => {
        return res.render(path.join(__dirname+"../../views/Users/registry.ejs"),{content:""})
    },
    post_registry: async (req, res) => {
        let {mail,pass} = req.body
        console.log(mail,pass)
        connection.query('select * from buyers where Email = ?',[mail],(err,row)=>{
            console.log(row.length)
            console.log("checkk")
        })
        // if(randomeCode == mail) return res.render(path.join(__dirname+"../../views/Users/registry.ejs"),{content:"dk thanfh coong"})
        // else{ return res.render(path.join(__dirname+"../../views/Users/registry.ejs"),{content:"mã sai"})}
        res.json({success:true,data:"Đăng ký thành công"})
    }, 
    SendGmail: async (req, res) => {
        let {mail} = req.body
        const emailServices = require("../../config/mailer")
        const sendmail = await emailServices(mail,randomeCode)

        if(sendmail) return res.render(path.join(__dirname+"../../views/Users/registry.ejs"),{content:"đã gửi thành công đến:"+mail})
    },
    test: async (req, res) => {
        let mail = "maviess10@gmail.com"
        const emailServices = require("../../config/mailer")
        const sendmail = await emailServices(mail,randomeCode)
        return res.json({data:mail})
    }
}

module.exports = UserServices