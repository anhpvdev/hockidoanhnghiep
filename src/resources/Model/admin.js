const connection = require('../../config/connect_db')
const path = require('path')

const adminServices = {
    home: async (req, res) => {
        console.log(req.admin)
        console.log(req.role)
        return res.render(path.join(__dirname+"../../views/Admins/home.ejs"),{name:req.admin.admin})
    },
    listadmin: async (req, res) => {
        connection.query('SELECT * FROM admins as a LEFT JOIN admins_roles as ar on ar.Role_id = a.Role WHERE role !=1',async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                
            return res.render(path.join(__dirname+"../../views/Admins/listadmin.ejs"),{data:row})
        })
    },
    admin_detail: async (req, res) => {
        console.log(req.params.id)
        connection.query('SELECT * FROM admins as a LEFT JOIN admins_roles as ar on ar.Role_id = a.Role WHERE Admin_id =?',[req.params.id],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                console.log(row[0])
            return res.render(path.join(__dirname+"../../views/Admins/admin_detail.ejs"),{data:row[0]})
        })
    },
    get_addadmin: async (req, res) => {
        connection.query('SELECT * FROM admins_roles WHERE Role_id  !=1',async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            console.log(row[0])
            return res.render(path.join(__dirname+"../../views/Admins/add_admin.ejs"),{data:row,status:""})
        })

    },
    post_addadmin: async (req, res) => {
        let {name,pass,role} = req.body
        console.log(name,pass,role)

        connection.query('SELECT * FROM admins WHERE Admin_name = ?;',[name],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            if(row.length ==0){
                console.log("next")
                connection.query('INSERT INTO admins (Admin_name, Password, Role) VALUES(?, ?, ?);',[name,pass,role],async(err,resuilt)=>{
                    if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

                    return res.redirect("/admin/listadmin/" + resuilt.insertId)
                })
            }else{
                return res.render(path.join(__dirname+"../../views/Admins/add_admin.ejs"),{status:"Tài khoản admin đã tồn tại"})
            }
        })

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

        connection.query('SELECT * FROM seller_registries where status = 0',async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            

              
            return res.render(path.join(__dirname+"../../views/Admins/seller_add.ejs"),{data:row,content:"",admin:req.admin})
        })
    },
    //thong ke doanh thu theo thang
    seller_detail: async (req, res) => {
        let user = req.params.id

        connection.query('select b.*,se.Shop_name ,w.Name as wname,d.name as district,c.name as city from buyers as b LEFT JOIN sellers as se on se.Buyer_id = b.Buyer_id LEFT JOIN ward as w on b.Ward = w.Ward_id LEFT JOIN district as d on w.District = d.District_id LEFT JOIN city as c on c.City_id = d.City WHERE se.Seller_id = ?',[user],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
        
            if(row.length ==0) res.render(path.join(__dirname+"../../views/Users/login.ejs"))
            else{
                var checkdate=new Date(row[0].Birth)
                row[0].Birth = checkdate
                const currentYear = new Date().getFullYear();
                connection.query('SELECT c.*,pr.Seller_id,cl_t.Prices, SUM(c.Quantity * cl_t.Prices) as total FROM `buyer_purchases` as b_p LEFT JOIN carts as c on c.Purchase_id = b_p.Purchase_id LEFT JOIN classify_types as cl_t on cl_t.Classify_type_id = c.classify_type_id LEFT JOIN classify as cl on cl.classify_id = cl_t.classify_id LEFT JOIN products as pr on pr.Product_id = cl.Product_id WHERE b_p.status = 1 and pr.Seller_id = ?  and YEAR(b_p.Created_at) = ? GROUP BY pr.Seller_id;',[user,currentYear],async(err,profit)=>{
                    if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                    
                        if(profit.length ==0) return res.render(path.join(__dirname+"../../views/Admins/seller_profit.ejs"),{data:row[0],profit:0})

                        return res.render(path.join(__dirname+"../../views/Admins/seller_profit.ejs"),{data:row[0],profit:profit[0].total})
                    
                })
                
            }
        })
    },

    post_seller_add: async (req, res) => {
        let {seller} = req.body
        console.log(seller)
       connection.query('SELECT * FROM `seller_registries` WHERE Buyer_id =  ?',[seller],async(err,row)=>{
        if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

            connection.query('INSERT INTO `sellers` (`Buyer_id`, `Shop_name`) VALUES(?, ?);',[seller,row[0].Shop_name],async(err,insert)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                    
                    
                    connection.query('UPDATE seller_registries SET status = 1 WHERE Buyer_id = ?;',[seller],async(err,result)=>{
                        if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                        
                        connection.query('UPDATE buyers SET role = 3 WHERE Buyer_id = ?;',[seller],async(err,result)=>{
                            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                                
                            return  res.redirect('/admin/seller/regis')
                        })
                    })
            })
        })
    
    },
    get_category: async (req, res) => {
        
        connection.query('SELECT * FROM `product_types`',(err,type)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

            else return res.render(path.join(__dirname+"../../views/Admins/category.ejs"),{data:type})
        })
    
    },
    get_dcategory: async (req, res) => {
        const category = req.params.id
        connection.query('SELECT t.*,p.name as pname,p.Product_Types_id as back FROM types as t LEFT JOIN product_types as p on t.Product_type_id = p.Product_Types_id WHERE t.Product_type_id = ?',[category],(err,type)=>{
             if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

            if(type.length ==0) return res.render(path.join(__dirname+"../../views/Admins/category_detail0.ejs"),{data:type,params:req.params.id})
             else return res.render(path.join(__dirname+"../../views/Admins/category_detail.ejs"),{data:type})
        })
    
    },
    post_category: async (req, res) => {
        
        // connection.query('SELECT * FROM `product_types`',(err,type)=>{
        //     if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

        //     else return res.render(path.join(__dirname+"../../views/Admins/category.ejs"),{data:type})
        // })
    
    },
    post_category_type1: async (req, res) => {
        const{type,name}=req.body
        console.log(type,name)
        connection.query('UPDATE product_types set name = ? WHERE Product_Types_id = ?',[name,type],(err,type)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            else return res.redirect("/admin/category")
        })
    
    },

    post_category_type2: async (req, res) => {
        const{type,name,back}=req.body
        console.log(type,name)
        connection.query('UPDATE types set name = ? WHERE Type_id = ?',[name,type],(err,type)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            else return res.redirect("/admin/category/"+back)
        })
    
    },


    add_c_category: async (req, res) => {
        const{type,name}=req.body
        console.log(type,name)
        connection.query('INSERT INTO types (Product_type_id, name) VALUES(?, ?);',[type,name],(err,resuilt)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

            else return res.redirect("/admin/category/"+type)
        })
    
    },
    
    add_category: async (req, res) => {
        const{name}=req.body
        console.log(name)
        connection.query('INSERT INTO product_types (name) VALUES(?);',[name],(err,resuilt)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

            else return res.redirect("/admin/category")
        })
    
    },
    dell_category1: async (req, res) => {
        const{dellid}=req.body
        console.log(dellid)
        connection.query('DELETE FROM product_types WHERE Product_Types_id = ?;',[dellid],(err,resuilt)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            else return res.redirect("/admin/category")
        })
    
    },

    dell_category2: async (req, res) => {
        const{dellid,back}=req.body
        console.log(dellid,back)
        connection.query('DELETE FROM types WHERE Type_id = ?',[dellid],(err,resuilt)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))

            else return res.redirect("/admin/category/"+back)
        })
    
    }
    
}
module.exports = adminServices