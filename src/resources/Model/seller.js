const connection = require('../../config/connect_db')
const path = require('path')

const seller = {
    home: async (req, res) => {
        connection.query('select * from buyers',(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            else {

                var name = "phan huu viet anh"

                console.log(req.user)
                if(req.user) return res.render(path.join(__dirname+"../../views/sellers/home.ejs"),{name:req.user.gmail})
                else return res.render(path.join(__dirname+"../../views/sellers/home.ejs"),{name:"chưa đăng nhập bro"})
            }
        })
    },
    post_login: async (req, res) => {
        let {user,pass} = req.body
        console.log(user,pass)
        connection.query('select * from buyers where Email = ? and Password = ?',[user,pass],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            if(row.length ==0) res.render(path.join(__dirname+"../../views/sellers/login.ejs"))
            else if(row[0].role == 3){

                const user_cookie= {
                    id:row[0].Buyer_id,
                    gmail: row[0].Email,
                    password: row[0].Password
                }
                console.log(user_cookie)
    
    
                const jwt = require("jsonwebtoken")
                const token = await jwt.sign(user_cookie, process.env.SECRET)
                console.log(token)
    
                res.cookie("AU2", JSON.stringify(token),{ secure: true, httpOnly: true })

                res.redirect("/seller")
            }
        })
    },
    get_login: async (req, res) => {
        if(req.role !=3) return res.render(path.join(__dirname+"../../views/Sellers/login.ejs"),{content:""})
        else return res.redirect("/seller")
    },

}

module.exports = seller