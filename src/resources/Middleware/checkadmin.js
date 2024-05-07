require("dotenv").config()
const jwt = require('jsonwebtoken')
const connection = require('../../config/connect_db')

const checkAdmin = {
    Admin:(req, res, next) => {
        if(req.headers.cookie) {
            const token = req.cookies['AU2D_nt3h']
            if(token) {
                jwt.verify(JSON.parse(token), process.env.SECRET, (err, decoded) => {
                    if (err){
                        console.log(err) 
                        res.redirect("/admin/login")
                    }
                    console.log(decoded.admin,decoded.pass)
                    connection.query('select * from admins where Admin_name = ? and Password = ?',[decoded.admin,decoded.pass],async(err,row)=>{
                        if(err) res.redirect("/admin/login")
                            
                        if(row.length ==0) res.redirect("/admin/login")
                        if(row[0].Role ==1){
                            req.admin = decoded
                            req.adrole = row[0].Role
                            next()   
                        }else res.redirect("/admin/404")
                    })
                })
            }else {
            res.redirect("/admin/login")
                next()
            }
        }

    },
    Admin2:(req, res, next) => {
        if(req.headers.cookie) {
            const token = req.cookies['AU2D_nt3h']
            if(token) {
                jwt.verify(JSON.parse(token), process.env.SECRET, (err, decoded) => {
                    if (err){
                        console.log(err) 
                        res.redirect("/admin/login")
                    }
                    console.log(decoded.admin,decoded.pass)
                    connection.query('select * from admins where Admin_name = ? and Password = ?',[decoded.admin,decoded.pass],async(err,row)=>{
                        if(err) res.redirect("/admin/login")
                            
                        if(row.length ==0) res.redirect("/admin/login")
                        if(row[0].Role ==2 || row[0].Role ==1){
                            req.admin = decoded
                            req.adrole = row[0].Role
                            next()   
                        }else res.redirect("/admin/login")
                    })

                })
            }else {
            res.redirect("/admin/login")
                next()
            }
        }

    },
    Admin3:(req, res, next) => {
        if(req.headers.cookie) {
            const token = req.cookies['AU2D_nt3h']
            if(token) {
                jwt.verify(JSON.parse(token), process.env.SECRET, (err, decoded) => {
                    if (err){
                        console.log(err) 
                        res.redirect("/admin/login")
                    }
                    console.log(decoded.admin,decoded.pass)
                    connection.query('select * from admins where Admin_name = ? and Password = ?',[decoded.admin,decoded.pass],async(err,row)=>{
                        if(err) res.redirect("/admin/login")
                            
                        if(row.length ==0) res.redirect("/admin/login")
                        if(row[0].Role ==3 || row[0].Role ==1){
                            req.admin = decoded
                            req.adrole = row[0].Role
                            next()   
                        }else res.redirect("/admin/login")
                    })

                })
            }else {
            res.redirect("/admin/login")
                next()
            }
        }

    },

    any:(req, res, next) => {
        if(req.headers.cookie) {
            const token = req.cookies['AU2D_nt3h']
            if(token) {
                jwt.verify(JSON.parse(token), process.env.SECRET, (err, decoded) => {
                    if (err){
                        console.log(err) 
                        res.redirect("/admin/login")
                    }
                    console.log(decoded.admin,decoded.pass)
                    connection.query('select * from admins where Admin_name = ? and Password = ?',[decoded.admin,decoded.pass],async(err,row)=>{
                        if(err) res.redirect("/admin/login")
                            
                        if(row.length ==0) res.redirect("/admin/login")
                        
                        req.admin = decoded
                        req.adrole = row[0].Role
                        next()   
                    })

                })
            }else {
            res.redirect("/admin/login")
                next()
            }
        }

    }
}

module.exports = checkAdmin