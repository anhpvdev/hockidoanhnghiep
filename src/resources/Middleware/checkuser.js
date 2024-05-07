require("dotenv").config()
const jwt = require('jsonwebtoken')
const connection = require('../../config/connect_db')



const checkauth = (req, res, next) => {
    if(req.headers.cookie) {
        const token = req.cookies['AU2']
        if(token) {
            jwt.verify(JSON.parse(token), process.env.SECRET, (err, decoded) => {
                if (err){
                    console.log(err) 
                    res.redirect("/login")
                }
                connection.query('select * from buyers where Email = ? and Password = ?',[decoded.gmail,decoded.password],(err,row)=>{
                    if(err) res.redirect("/login")
                    else {
                        req.user = decoded
                        next()   
                    }
                })

            })
        }else {
            req.user = null
            next()
        }
   }

}

module.exports = checkauth