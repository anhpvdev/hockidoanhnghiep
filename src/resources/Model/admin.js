const connection = require('../../config/connect_db')
const path = require('path')

const adminServices = {
    home: async (req, res) => {
        console.log(req.admin)
        console.log(req.role)
        return res.render(path.join(__dirname+"../../views/Admins/home.ejs"),{name:req.admin.admin})
    },
    get_login: async (req, res) => {
        return res.render(path.join(__dirname+"../../views/Admins/login.ejs"),{content:""})
    },
    post_login: async (req, res) => {
        let {user,pass} = req.body
        console.log(user,pass)
        connection.query('select * from admins where Admin_name = ? and Password = ?',[user,pass],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            if(row.length ==0) res.render(path.join(__dirname+"../../views/Admins/login.ejs"))
            else{

                const user_cookie= {
                    admin: row[0].Admin_name,
                    pass: row[0].Password
                }
                console.log(user_cookie)
    
    
                const jwt = require("jsonwebtoken")
                const token = await jwt.sign(user_cookie, process.env.SECRET)
                console.log(token)
    
                res.cookie("AU2D_nt3h", JSON.stringify(token),{ secure: true, httpOnly: true })

                res.redirect("/admin")
            }
        })
    },
    admute: async (req, res) => {
        console.log("admute")
        return res.render(path.join(__dirname+"../../views/AD_mute.ejs"),{content:""})
    },
    seller: async (req, res) => {
        console.log("seller")

        connection.query('SELECT * FROM sellers',async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            

              
            return res.render(path.join(__dirname+"../../views/Admins/seller.ejs"),{data:row,content:"",admin:req.admin})
        })
    },
    seller_add: async (req, res) => {
        console.log("seller_add")

        connection.query('SELECT * FROM seller_registries',async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            

              
            return res.render(path.join(__dirname+"../../views/Admins/seller_add.ejs"),{data:row,content:"",admin:req.admin})
        })
    },
}

module.exports = adminServices