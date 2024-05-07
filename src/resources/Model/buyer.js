const connection = require('../../config/connect_db')
const path = require('path')
const BuyerServices = {
    profile: (req, res) => {
        let user = req.user
        if(!user) return res.render(path.join(__dirname+"../../views/Users/login.ejs"))
        else{
            console.log(user)
            connection.query('select * from buyers where Email = ? and Password = ?',[user.gmail,user.password],async(err,row)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
                if(row.length ==0) res.render(path.join(__dirname+"../../views/Users/login.ejs"))
                else{
                    console.log(row[0])
                    return res.render(path.join(__dirname+"../../views/Buyers/profile.ejs"),{data:row[0]})
                }
            })
        }
    },
    cart: (req, res) => {
        let user = req.user
        if(!user) return res.render(path.join(__dirname+"../../views/Users/login.ejs"))
        else{
            console.log(user)
            connection.query('select c.Quantity as num,cl_t.*,cl.name as cname,pr.name as pname,pr.Seller_id from carts as c INNER JOIN buyers as b ON c.user_id = b.Buyer_id INNER JOIN classify_types as cl_t on c.classify_type_id = cl_t.Classify_type_id INNER JOIN classify as cl on cl_t.classify_id = cl.classify_id INNER JOIN products as pr on pr.Product_id = cl.Product_id WHERE b.Buyer_id = ?;',[user.id],async(err,row)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
                if(row.length ==0) res.render(path.join(__dirname+"../../views/Users/login.ejs"))
                else{
                    console.log(row[0])
                    return res.render(path.join(__dirname+"../../views/Buyers/cart.ejs"),{data:row})
                }
            })
        }
    },

    cart: (req, res) => {
        let user = req.user
        if(!user) return res.render(path.join(__dirname+"../../views/Users/login.ejs"))
        else{
            console.log(user)
            let {product,num} = req.body
            console.log(product,num)
            res.json({success:true,data:"Đăng ký thành công"})
        }
    },
}

module.exports = BuyerServices