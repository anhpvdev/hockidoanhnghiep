require("dotenv").config()
const jwt = require('jsonwebtoken')
const connection = require('../../config/connect_db')



const checkauth = {
    auth:(req, res, next)=>{
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

    },
    buyer:(req, res, next)=>{
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
                            req.role = row[0].role
                            next()   
                        }
                    })

                })
            }else {
                res.redirect("/login")
            }
        }
    },
    seller:(req, res, next)=>{
        if(req.headers.cookie) {
            const token = req.cookies['AU2']
            if(token) {
                jwt.verify(JSON.parse(token), process.env.SECRET, (err, decoded) => {
                    if (err){
                        console.log(err) 
                        res.redirect("/404")///nodelai
                    }

                    connection.query('select * from buyers where Email = ? and Password = ?',[decoded.gmail,decoded.password],(err,row)=>{
                        if(err) res.redirect("/seller/login")
                        else {
                            req.user = decoded
                            req.role = row[0].role ==3
                            next()
                        }
                    })

                })
            }else {
                res.redirect("/seller/login")
            }
        }
    }
}
module.exports = checkauth