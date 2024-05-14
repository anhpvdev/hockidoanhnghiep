const { json } = require('express')
const connection = require('../../config/connect_db')
const path = require('path')
const { any } = require('../Middleware/Uploads/avatar')

function addtype(value){
    let query = `INSERT INTO classify_types (classify_id,Name,Prices,Quantity) VALUES ${value};`
    console.log(query)
    return new Promise((resolve,reject) => {
        connection.query(query,async(err,classify)=>{
            if(err) reject()

            console.log(value)
            console.log("//////")
            resolve()
        })
    })

}

function addclassify(product,value,data){
    return new Promise((resolve,reject) => {
        connection.query('INSERT INTO classify (Product_id ,name) VALUES(?, ?);',[product,value],async(err,classify)=>{
            if(err) reject

            else{
                var classifyid = classify.insertId
                var classifydata = data
                var list_classify = ""
                for(let j=0;j<classifydata.length;j++){
                    console.log(classifydata[j].name,classifydata[j].price)
                    list_classify += `(${classifyid},'${classifydata[j].name}', ${classifydata[j].price},${classifydata[j].num}),`           
                }
                list_classify = list_classify.slice(0,-1)
                await addtype(list_classify)
                        .then(resolve)
                        .catch(reject)
            }              
        })
    })
}

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
    get_addproduct: async (req, res) => {
        connection.query('SELECT * FROM product_types',async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                console.log(row)
                return res.render(path.join(__dirname+"../../views/Sellers/add_product.ejs"),{type:row})
            })

      
    },
    post_addproduct: async (req, res) => {
        const {name,type_product1, trademark,type1,type2, fulldata} = req.body
        const seller = req.user
        // for(let i=0;i<fulldata.length;i++){
        //     await addclassify(fulldata[i].name)
        // }
        connection.query('INSERT INTO products (name, type,Trademark,Seller_id,classname,typename) VALUES(?, ?, ?, ?,? ,?);',[name,type_product1,trademark,seller.id,type1,type2],async(err,product)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                
            var productid = product.insertId
            for(let i=0;i<fulldata.length;i++){
                await addclassify(productid,fulldata[i].name,fulldata[i].data)
                    .catch(()=>{return res.render(path.join(__dirname+"../../views/404.ejs"))})
               
            }   
            res.json({success:true,data:productid})

        })



    },
    imageproduct: async (req, res) => {
        const pr_file = req.files
        const prductid = req.body.product_id
       
        var list_insert = ""
        for(i=0;i<pr_file.length;i++){
            let filename = prductid+"_"+pr_file[i].originalname
            list_insert += `(${prductid},'${filename}'),`
 
        }
        list_insert = list_insert.slice(0,-1)
        console.log(list_insert)
        var query = `INSERT INTO products_image(Product_id,image) VALUES ${list_insert};`
        console.log(query)
        
        connection.query(query,async(err,product)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
       
            res.redirect("/products/"+prductid)
            })
    },
    typeproduct: async (req, res) => {
        const {product} = req.body
        connection.query('SELECT * FROM types where Product_type_id = ?',[product],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                console.log(row)
                return res.json({success:true,data:row})
        })

      
    },
    get_profile: (req, res) => {
        let user = req.user

        connection.query('select b.* ,w.Name as wname,d.name as district,c.name as city from Sellers as b LEFT JOIN ward as w on b.Shop_Ward = w.Ward_id LEFT JOIN district as d on w.District = d.District_id LEFT JOIN city as c on c.City_id = d.City WHERE b.Buyer_id =?',[user.id],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
        
            if(row.length ==0) res.render(path.join(__dirname+"../../views/Users/login.ejs"))
            else{
             console.log(row)

                return res.render(path.join(__dirname+"../../views/Sellers/profile.ejs"),{data:row[0]})
            }
        })
    },
    post_profile: (req, res) => {
        let user = req.user

        const{name,Phone,adress,ward}= req.body
        console.log(name,Phone,adress,ward)
        connection.query('UPDATE Sellers set Shop_name = ?,phone=?,Shop_Address=?,Shop_Ward=? where Buyer_id = ?;',[name,Phone,adress,ward,user.id],async(err,row)=>{
            if(err) console.log(err)
                
            return res.redirect('/seller/profile')
        })
       
    },


}

module.exports = seller