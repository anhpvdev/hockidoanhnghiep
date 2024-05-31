const path = require('path')
const connection = require('../../config/connect_db')
const emailServices = require("../../config/mailer")
const { change_password } = require('./buyer')

const UserServices = {

    error: async (req, res) => {
        res.render(path.join(__dirname+"../../views/404.ejs"))
    },
    home: async (req, res) => {
        connection.query('select * from buyers',(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            else {

                var name = "phan huu viet anh"

                console.log(req.user)
                connection.query('SELECT * FROM `product_types`',(err,type)=>{
                    if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

                    if(req.user) {
                        connection.query('select * from products as p LEFT JOIN products_image as pm on p.Product_id = pm.Product_id GROUP By p.Product_id;',(err,product)=>{
                            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                            else {
                              
                                return res.render(path.join(__dirname+"../../views/Users/home.ejs"),{data:row,product:product,type:type,name:req.user.gmail})
                            }
                        })
                        
                    }
                    else return res.render(path.join(__dirname+"../../views/Users/home.ejs"),{data:row,type:type,name:"chưa đăng nhập bro"})
                })
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
        connection.query('SELECT cl_t.*,cl.Quantity as clnum,cl.name as clname,pr.name as prname FROM classify as cl INNER JOIN products as pr on cl.Product_id = pr.Product_id INNER JOIN classify_types as cl_t on cl_t.classify_id = cl.classify_id WHERE pr.Product_id = ?;',[req.params.id],(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            else {

                connection.query('SELECT * FROM `products_image` WHERE Product_id = ?;',[req.params.id],(err,image)=>{
                    if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                    else {
                        var name = "chi tiet san pham"
                        return res.render(path.join(__dirname+"../../views/Users/products_detal.ejs"),{data:row,image:image,name:name})
                    }

                })
            }

        })
    },

    products_type:async (req, res) => {
        connection.query('SELECT pr.*,prt.name as pname FROM products as pr INNER JOIN types as t on t.Type_id = pr.type INNER JOIN product_types as prt on t.Product_type_id = prt.Product_Types_id WHERE prt.Product_Types_id = ?;',[req.params.id],(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            else {
                console.log(row)
                var name = "all san pham"
                return res.render(path.join(__dirname+"../../views/Users/products.ejs"),{data:row,name:name})
            }
        })
    },

    seach:async (req, res) => {
        var content =req.body.content
        return res.render(path.join(__dirname+"../../views/Users/seach.ejs"),{content:content})
    },

    get_registry: async (req, res) => {
        return res.render(path.join(__dirname+"../../views/Users/registry.ejs"),{content:""})
    },

    post_registry: async (req, res) => {
        let {mail,pass} = req.body
        console.log(mail,pass)
        let query = `select * from buyers where Email = "${mail}"`
        console.log(query)
        connection.query(query,async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            if(row.length !=0){
                if(row[0].role ==1||row[0].role ==2||row[0].role ==3) return res.json({success:false,data:"Email đã được đăng ký"})
                else{
                    // xử lý gửi lại opt về mail
                    const sendmail = await emailServices(mail,`<b>Mã xác nhận của bạn là: <h3>${row[0].token}</h3></b>`)
                    if(sendmail) return res.json({success:true,mail:mail})
                }
           }else{
                const code_otp = Math.floor(Math.random() * 900000) + 100000
                connection.query('INSERT INTO `buyers` (`Email`, `Password`, `token`) VALUES(?,?,?);',[mail,pass,code_otp], async(err,data)=>{
                    if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))


                    const sendmail = await emailServices(mail,`<b>Mã xác nhận của bạn là: <h3>${code_otp}</h3></b>`)
                    if(sendmail) return res.json({success:true,mail:mail})
                    
                })
            }
        })

        
    }, 

    Check_otp: async (req, res) => {
        let {mail,otp} = req.body
        console.log(mail,otp)
        connection.query('select * from buyers where Email = ? and token = ?',[mail,otp],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            if(row.length ==0) return res.json({success:false,data:"Mã otp không đúng"})
            else{
                connection.query('update buyers set role = 1,token =NULL where  Email = ?',[mail],async(err,row)=>{
                    if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                    
                    return res.json({success:true,data:"Đăng ký thành công"})
                })
            }
        })
        
     

       
    },
    post_login: async (req, res) => {
        let {user,pass} = req.body
        console.log(user,pass)
        connection.query('select * from buyers where Email = ? and Password = ?',[user,pass],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            if(row.length ==0) res.render(path.join(__dirname+"../../views/Users/login.ejs"))
            else{

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

                res.redirect("/")
            }
        })
    },
    logout: async (req, res) => {
        res.cookie("AU2", "")
        res.redirect("/")
    },

    get_login: async (req, res) => {
        return res.render(path.join(__dirname+"../../views/Users/login.ejs"),{content:""})
    },
    get_repassword: async (req, res) => {
        return res.render(path.join(__dirname+"../../views/Users/repassword.ejs"),{content:""})
    },
    post_repassword: async (req, res) => {
        let {gmail} = req.body
        if(gmail){
        
            connection.query('select * from buyers where Email = ?',[gmail], async(err,row)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                
                if(row.length ==0) return res.render(path.join(__dirname+"../../views/Users/repassword.ejs"),{gmail:gmail,content:"gmail chưa được đăng ký"})
                else{
                    const sendmail = await emailServices(gmail,`<b>Mật khẩu của bạn là: <h3>${row[0].Password}</h3></b>`)
                    if(sendmail) return res.render(path.join(__dirname+"../../views/Users/repassword.ejs"),{gmail:gmail,content:"đã gửi mật khẩu về gmail đăng ký"})    
                }  
            })
        }else{
            return res.render(path.join(__dirname+"../../views/Users/repassword.ejs"),{content:"vui lòng nhập gmail đã đăng ký"})
        }
    },
    change_password: async (req, res) => {

        return res.render(path.join(__dirname+"../../views/Users/change_password.ejs"),{content:"",})
    },

    sortseach: async (req, res) => {
        let {content} = req.body

        console.log(content)
        connection.query('SELECT * FROM `products` WHERE name like "%'+content+'%" LIMIT 10 OFFSET 0',async(err,row)=>{
            if(err) return res.json({success:"err",data:"có lỗi sảy ra"})
                
            if(row.length ==0) res.json({success:false,data:"không có dữ liệu cần tìm"})
            else{

                res.json({success:true,data:row})
            }
        })
    },

    longseach:async (req, res) => {
        const {content} = req.body
        connection.query('SELECT * FROM `products` WHERE name like "%'+content+'%"',(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            else {
                console.log(row)
                var name = `all san pham da tim theo <${content}>`
                return res.render(path.join(__dirname+"../../views/Users/products.ejs"),{data:row,name:name})
            }
        })
    },

    

}

module.exports = UserServices